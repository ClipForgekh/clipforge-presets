local function clamp (value, min, max)
    return math.min(math.max(min, value), max)
end
local function mix (x, y, a)
    return x + (y - x) * a
end
local function step (edge0, edge1, value)
    return math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
end
local function smoothstep (edge0, edge1, value)
    local t = math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
    return t * t * (3 - t - t)
end


local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.width = 0
    self.height = 0
    self.speedIntensity = 0.33
    self.filterIntensity = 1
    ---#ifdef DEV
--//    self.rawTimingData = { 0.8, 1.1, 2.5, 2.8, 4.0, 4.5 }
--//    self.endTime = self.rawTimingData[#self.rawTimingData] + 1
    ---#endif
    self.RawHeadTime = 1
    self.RawBeatTime = 1
    self.RawFootTime = 0
    return self
end

function SeekModeScript:constructor()

end

function SeekModeScript:onUpdate(comp, detalTime)
    self:seekToTime(comp, self.curTime - self.startTime)
end

function SeekModeScript:onStart(comp)
    self.animSeqCom = comp.entity:getComponent("AnimSeqComponent")
    self.material = comp.entity:getComponent("Sprite2DRenderer").material
end

function SeekModeScript:seekToTime (comp, time)
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
    for i, beat in ipairs(self.timingData) do
        if beat.s <= time and time < beat.e then
            if time < beat.t then
                time0 = mix(self.RawHeadTime, self.RawBeatTime, step(beat.s, beat.t, time))
            else
                time0 = mix(self.RawBeatTime, self.RawFootTime, step(beat.t, beat.e, time))
            end
            self.currentBeatIndex = i
            break
        end
    end
    self:seekToTime0(comp, time0)
end

function SeekModeScript:seekToTime0(comp, time)

    self.animSeqCom:seekToTime(time * (0.5 + 1.5 * self.speedIntensity))

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.material:setInt("baseTexWidth", self.width)
        self.material:setInt("baseTexHeight", self.height)
    end
    self.material:setFloat("uniAlpha", self.filterIntensity)
end

function SeekModeScript:onEvent(sys, event)
    if "effects_adjust_speed" == event.args:get(0) then
        local intensity = event.args:get(1)
        self.speedIntensity = intensity
    end
    if "effects_adjust_filter" == event.args:get(0) then
        local intensity = event.args:get(1)
        self.filterIntensity = intensity
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
        for i = 0, src:size() - 1 do
            table.insert(dst, src:get(i))
        end
        if #dst == 0 then
            return
        end
        self.rawTimingData = dst
        self.timingData = nil
    end
    ---#endif
end

exports.SeekModeScript = SeekModeScript
return exports
