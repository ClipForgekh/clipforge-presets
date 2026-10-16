local function mix (a, b, t)
    return a + (b - a) * t
end
local function step (edge0, edge1, value)
    return (value - edge0) / (edge1 - edge0)
end

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then
        SeekModeScript.constructor(self, ...)
    end
    self.startTime = 0.0
    self.endTime = 5.0
    self.curTime = 0.0
    self.width = 0
    self.height = 0
    ---#ifdef DEV
--//    self.rawTimingData = { 0.8, 1.1, 2.5, 2.8, 4.0, 4.5 }
--//    self.endTime = self.rawTimingData[#self.rawTimingData] + 1
    ---#else
    self.rawTimingData = {9999999999}
    ---#endif
    self.RawHeadTime = 0
    self.RawBeatTime = 0.32
    self.RawFootTime = 0.6225
    return self
end

function SeekModeScript:onStart(comp)
    self.pass0mat = comp.entity.scene:findEntityBy("Pass0"):getComponent("MeshRenderer").material

    if "effects_adjust_luminance" == "effects_adjust_luminance" then
        local intensity = 0.65
        self.pass0mat["lightIns"] = mix(1, 2, intensity)
    end
    if "effects_adjust_intensity" == "effects_adjust_intensity" then
        local intensity = 0
        self.pass0mat["scale"] = mix(1, 0.75, intensity)
    end
    if "effects_adjust_filter" == "effects_adjust_filter" then
        local intensity = 0
        self.pass0mat["filterHow"] = mix(0, 1, intensity)
    end
    if "effects_adjust_range" == "effects_adjust_range" then
        local intensity = 0
        self.pass0mat["shakeMask"] = mix(0.1, 0.5, intensity)
    end
end

function SeekModeScript:onUpdate(comp, detalTime)
    ---#ifdef DEV
--//    if self.dev_seek then
--//        self:update((self.endTime - self.startTime) * self.dev_seek)
--//    else
--//        self:update(self.curTime - self.startTime)
--//    end
--//    self.curTime = self.curTime + detalTime
    ---#else
    self:update(self.curTime - self.startTime)
    ---#endif
end

function SeekModeScript:solveTiming (prev, next, q, p)
    local T = 0.3
    if not prev then
        next.s = next.t - T*q
    elseif not next then
        prev.e = prev.t + T*p
    else
        local t = next.t - prev.t
        if t < T then
            prev.e = prev.t + t*p
            next.s = next.t - t*q
        else
            prev.e = prev.t + T*p
            next.s = next.t - T*q
        end
    end
end

function SeekModeScript:update (time)
    if not self.timingData then
        if not self.rawTimingData then
            return
        end
        local src = self.rawTimingData
        local dst = {}
        for _, beat in ipairs(src) do
            table.insert(dst, {t = beat})
        end
        local q = step(self.RawHeadTime, self.RawFootTime, self.RawBeatTime)
        local p = 1 - q
        for i = 0, #dst do
            self:solveTiming(dst[i], dst[i+1], q, p)
        end
        self.timingData = dst
    end

    local time0 = self.RawHeadTime
    for _, beat in ipairs(self.timingData) do
        if beat.s <= time and time < beat.e then
            if time < beat.t then
                time0 = mix(self.RawHeadTime, self.RawBeatTime, step(beat.s, beat.t, time))
            else
                time0 = mix(self.RawBeatTime, self.RawFootTime, step(beat.t, beat.e, time))
            end
            break
        end
    end
    self:update0(time0)
end

function SeekModeScript:update0 (time)
    time = math.mod(time, 1.0)
    self.pass0mat:setFloat("iTime", time)
end

function SeekModeScript:onEvent(sys, event)
    if event.args:get(0) == "effects_adjust_intensity" then
        local intensity = event.args:get(1)
        self.pass0mat["lightIns"] = mix(1, 2, intensity * 0.65)
        self.pass0mat["scale"] = mix(1, 0.75, intensity * 0)
        self.pass0mat["filterHow"] = mix(0, 1, intensity * 0)
        self.pass0mat["shakeMask"] = mix(0.1, 0.5, intensity * 0)
    end
    ---#ifdef DEV
--//    if event.type == Amaz.EventType.TOUCH then
--//        local pointer = event.args:get(0)
--//        if pointer.type == Amaz.TouchType.TOUCH_BEGAN then
--//            self.dev_seek = pointer.x
--//        elseif pointer.type == Amaz.TouchType.TOUCH_MOVED then
--//            self.dev_seek = pointer.x
--//        elseif pointer.type == Amaz.TouchType.TOUCH_ENDED or pointer.type == Amaz.TouchType.TOUCH_CANCELLED then
--//            if pointer.y > 0.9 then
--//                self.curTime = self.startTime + (self.endTime - self.startTime) * self.dev_seek
--//                self.dev_seek = nil
--//            end
--//        end
--//    end
    ---#else
    local type = event.args:get(0)
    if type == "time" then
        local dst = {}
        local src = event.args:get(1)
        if src and src:size() > 0 then
            for i = 0, src:size() - 1 do
                table.insert(dst, src:get(i))
            end
        else
            table.insert(dst, 99999999999)
        end
        self.rawTimingData = dst
        self.timingData = nil
    end
    ---#endif
end

exports.SeekModeScript = SeekModeScript
return exports






