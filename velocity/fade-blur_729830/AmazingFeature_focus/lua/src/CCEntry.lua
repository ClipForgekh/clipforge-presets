local CCMain = require("CCMain")

local function mix (a, b, t)
    return a + (b - a) * t
end
local function step (edge0, edge1, value)
    return (value - edge0) / (edge1 - edge0)
end

local CCHandlers = {
    effects_adjust_speed = "speed",
    effects_adjust_filter = "filter",
    effects_adjust_texture = "texture",
    effects_adjust_noise = "noise",
    effects_adjust_sharpen = "sharp",
    effects_adjust_soft = "soft",
    effects_adjust_luminance = "light",
    effects_adjust_blur = "blur",
    effects_adjust_distortion = "shape",
    effects_adjust_range = "range",
    effects_adjust_horizontal_chromatic = "color_x",
    effects_adjust_vertical_chromatic = "color_y",
    effects_adjust_horizontal_shift = "shift_x",
    effects_adjust_vertical_shift = "shift_y",
    effects_adjust_number = "count",
    effects_adjust_size = "scale",
    effects_adjust_intensity = "intensity",
    effects_adjust_rotate = "angle",
    effects_adjust_color = "color",
    effects_adjust_background_animation = "animate",
    sticker = "alpha"
}

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

function SeekModeScript.new (construct, ...)
    local self = setmetatable({}, SeekModeScript)
    self.main = CCMain.new(self)
    ---#ifdef DEF
--//    self.rawTimingData = {1230,2090,2960,3850,4760,5610,6460,7170,7850,8570,9250,9960,10640,11340,12070,12740,13420,14120,14830,15540,16250,16930,17620,18330,19020,19720,20420,21120,21810,22510,23200,23930,24600,25300,26000,26720,27410,28010,28620,29250}
--//    for i = 1, #self.rawTimingData do
--//        self.rawTimingData[i] = self.rawTimingData[i] * 0.001
--//    end
    ---#endif
    self.RawHeadTime = 0
    self.RawBeatTime = 0
    self.RawFootTime = 0.5
    self.RawIdleTime = self.RawFootTime
    return self
end

function SeekModeScript:onStart (comp)
    self.w = 0
    self.h = 0
    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.data = {}

    self.w = Amaz.BuiltinObject.getInputTextureWidth()
    self.h = Amaz.BuiltinObject.getInputTextureHeight()
    self.main:create(self, self.data, comp.entity.scene)
    self.main:layout(self, self.data, self.w, self.h)
    self:update(self, self.data, 0, self.endTime, 0)
end

function SeekModeScript:solveTiming (prev, next, q, p)
    local T = 0.5
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

function SeekModeScript:update (env, data, time, duration, progress)
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

    if self.timingData then
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
        self.main:update(env, data, time, time0, duration, time0 / duration)
    else
        self.main:update(env, data, time, nil, duration, nil)
    end
end

function SeekModeScript:onUpdate (comp, dt)
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if w ~= self.w or h ~= self.h then
        self.w = w
        self.h = h
        self.main:layout(self, self.data, w, h)
    end
    local T = self.endTime - self.startTime
    local t = self.curTime - self.startTime
    ---#ifndef DEV
    self:update(self, self.data, t, T, t / T)
    ---#else
--//    if self.dev_seek then
--//        self:update(self, self.data, self.dev_seek * T, T, self.dev_seek)
--//    else
--//        self:update(self, self.data, t, T, t / T)
--//    end
--//    if Editor then
--//        self.curTime = self.curTime + dt
--//    end
    ---#endif
end

function SeekModeScript:onEvent(sys, event)
    if event.args:get(0) == "effects_adjust_intensity" then
        local intensity = event.args:get(1)
        self.data.intensity = intensity
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
