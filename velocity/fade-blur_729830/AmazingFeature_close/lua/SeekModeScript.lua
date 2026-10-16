
local function mix (a, b, t)
    return a + (b - a) * t
end
local function step (edge0, edge1, value)
    return (value - edge0) / (edge1 - edge0)
end
local function calcGaussianWeight(radius,sigma)
    local gaussianWeights = {}
    local arraySize = radius + 1
    local sumWeight = 0
    for i = 0, radius do
        local weight = (1.0 / math.sqrt(2.0 * math.pi * math.pow(sigma, 2.0))) *
        math.exp(-math.pow(i, 2.0) / (2.0 * math.pow(sigma, 2.0)));
        gaussianWeights[i+1] = weight
        if (i == 0) then
            sumWeight = sumWeight +  weight
        else
            sumWeight = sumWeight + 2.0 * weight
        end
    end

    for i = 0,radius do
        local oldValue = gaussianWeights[i+1]
        local newWeight = oldValue / sumWeight
        gaussianWeights[i+1] = newWeight
    end
    return gaussianWeights
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
    ---#ifdef DEV
--//    self.rawTimingData = {1230,2090,2960,3850,4760,5610,6460,7170,7850,8570,9250,9960,10640,11340,12070,12740,13420,14120,14830,15540,16250,16930,17620,18330,19020,19720,20420,21120,21810,22510,23200,23930,24600,25300,26000,26720,27410,28010,28620,29250}
--//    for i = 1, #self.rawTimingData do
--//        self.rawTimingData[i] = self.rawTimingData[i] * 0.001
--//    end
    ---#endif
    self.RawHeadTime = 0.2
    self.RawBeatTime = 1
    self.RawFootTime = 1
    self.RawIdleTime = self.RawHeadTime
    return self
end

function SeekModeScript:constructor()

end

function SeekModeScript:onStart(comp)
    self.pass2Material = comp.entity:getComponent("MeshRenderer").material
    self.intensity = 1
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
    if not prev then
        next.s = next.t - 0.4*q
    elseif not next then
        prev.e = prev.t + 0.4*p
    else
        local t = next.t - prev.t
        if t < 0.5 then
            t = t * 2/3
            prev.e = prev.t + t*p
            next.s = next.t - t*q
        else
            t = 0.4
            prev.e = prev.t + t*p
            next.s = next.t - t*q
        end
    end
end

function SeekModeScript:update (time)
    if not self.timingData then
        if self.rawTimingData then
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
    end

    if self.rawTimingData then
        local time0 = self.RawIdleTime
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
    else
        self:update0(nil)
    end
end

function SeekModeScript:update0 (time)
    if time == nil then
        time = self.RawHeadTime
    end
    self.pass2Material:setFloat("elapsedTime", mix(1, 1 - 0.8 * self.intensity * 1.1, time))
end

function SeekModeScript:onEvent(sys, event)
    if event.args:get(0) == "effects_adjust_intensity" then
        local intensity = event.args:get(1)
        self.intensity = intensity
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
        local src = event.args:get(1)
        if src and src:size() > 0 then
            local dst = {}
            for i = 0, src:size() - 1 do
                table.insert(dst, src:get(i))
            end
            if #dst == 0 then
                return
            end
            self.rawTimingData = dst
            self.timingData = nil
        end
    end
    ---#endif
end


exports.SeekModeScript = SeekModeScript
return exports
