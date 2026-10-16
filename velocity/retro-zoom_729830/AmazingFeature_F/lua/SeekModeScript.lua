local function Log (fmt, ...)
    Amaz.LOGW("jorgen", string.format(fmt, ...))
end
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
local function mirror (range, value)
    local round = value / range
    local roundF = 1 - math.abs(round % 2 - 1)
    local roundI = math.floor(round)
    return roundF, roundI
end


local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript


function SeekModeScript:create (node, data, w, h, scene)
    node.pass0 = scene:findEntityBy("Pass0"):getComponent("MeshRenderer").material

    data.intensity = 1
end

function SeekModeScript:layout (node, data, w, h)
end

function SeekModeScript:solveTiming (prev, next, q, p)
    if not prev then
        next.s = next.t - 0.275
    elseif not next then
        prev.e = prev.t + 0.725
    else
        local t = next.t - prev.t
        if t < 0.3 then
            prev.e = prev.t + t*0.5
            next.s = next.t - t*0.5
        else
            prev.e = prev.t + 0.3*0.5
            next.s = next.t - 0.3*0.5
        end
    end
end

function SeekModeScript:update (node, data_, w, h, time, duration)
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
    self:update0(node, data_, w, h, time0, duration)
end

function SeekModeScript:update0 (node, data, w, h, elapsed, duration)
    local data_light = data.intensity * 0.78
    local data_intensity = data.intensity * 0
    local data_filter = data.intensity * 0
    local data_range = data.intensity * 0.7

    node.pass0:setFloat("lightIns", mix(1, 2, data_light))
    node.pass0:setFloat("scale", mix(1, 0.75, data_intensity))
    node.pass0:setFloat("filterHow", data_filter)
    node.pass0:setFloat("shakeMask", mix(0.1, 0.5, data_range))

    elapsed = elapsed % 1
    node.pass0:setFloat("iTime", elapsed)
end


function SeekModeScript.new (construct, ...)
    local self = setmetatable({}, SeekModeScript)
    self.w = 0
    self.h = 0
    self.startTime = 0.0
    self.endTime = 1
    self.curTime = 0.0
    self.node = {}
    self.data = {}
    ---#ifdef DEV
--//    self.rawTimingData = {1230,2090,2960,3850,4760,5610,6460,7170,7850,8570,9250,9960,10640,11340,12070,12740,13420,14120,14830,15540,16250,16930,17620,18330,19020,19720,20420,21120,21810,22510,23200,23930,24600,25300,26000,26720,27410,28010,28620,29250}
--//    for i = 1, #self.rawTimingData do
--//        self.rawTimingData[i] = self.rawTimingData[i] * 0.001
--//    end
--//    self.endTime = self.rawTimingData[#self.rawTimingData] + 1
    ---#else
    self.rawTimingData = {9999999999}
    ---#endif
    self.RawHeadTime = 0
    self.RawBeatTime = 0.275
    self.RawFootTime = 1
    return self
end

function SeekModeScript:onStart (comp)
    self.w = Amaz.BuiltinObject.getInputTextureWidth()
    self.h = Amaz.BuiltinObject.getInputTextureHeight()
    self:create(self.node, self.data, self.w, self.h, comp.entity.scene)
    self:layout(self.node, self.data, self.w, self.h)
    self:update(self.node, self.data, self.w, self.h, 0, 1)
end

function SeekModeScript:onUpdate (comp, dt)
    if Editor then
        self.curTime = self.curTime + dt
    end
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if w ~= self.w or h ~= self.h then
        self.w = w
        self.h = h
        self:layout(self.node, self.data, w, h)
    end
    local t = self.curTime - self.startTime
    local T = self.endTime - self.startTime

    ---#ifdef DEV
--//    if self.dev_seek then
--//        self:update(self.node, self.data, w, h, T * self.dev_seek, T)
--//    else
--//        self:update(self.node, self.data, w, h, t, T)
--//    end
--//    self.curTime = self.curTime + dt
    ---#else
    self:update(self.node, self.data, w, h, t, T)
    ---#endif
end

function SeekModeScript:onEvent(sys, event)
    if event.args:get(0) == "effects_adjust_intensity" then
        self.data.intensity = event.args:get(1) * 2
        return
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


local exports = exports or {}
exports.SeekModeScript = SeekModeScript
return exports
