local Main = require("Main")


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
    self.w = 0
    self.h = 0
    self.startTime = 0.0
    self.endTime = 5.0
    self.curTime = 0.0
    self.data = {}
    self.main = Main.new(self)
    ---#ifdef DEV
--//    self.rawTimingData = {1230,2090,2960,3850,4760,5610,6460,7170,7850,8570,9250,9960,10640,11340,12070,12740,13420,14120,14830,15540,16250,16930,17620,18330,19020,19720,20420,21120,21810,22510,23200,23930,24600,25300,26000,26720,27410,28010,28620,29250}
--//    for i = 1, #self.rawTimingData do
--//        self.rawTimingData[i] = self.rawTimingData[i] * 0.001
--//    end
--//    self.endTime = self.rawTimingData[#self.rawTimingData] + 1
    ---#else
    self.rawTimingData = {9999999999}
    ---#endif
    self.RawHeadTime = 0.06666667
    self.RawBeatTime = 0.2
    self.RawFootTime = 0.36666667
    return self
end

function SeekModeScript:onStart (comp)
    self.w = Amaz.BuiltinObject.getInputTextureWidth()
    self.h = Amaz.BuiltinObject.getInputTextureHeight()
    self.main:create(self, self.data, comp.entity.scene)
    self.main:layout(self, self.data, self.w, self.h)
    self.main:update(self, self.data, 0, self.endTime, 0)
end

function SeekModeScript:onUpdate (comp, dt)
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if w ~= self.w or h ~= self.h then
        self.w = w
        self.h = h
        self.main:layout(self, self.data, w, h)
    end
    local t = self.curTime - self.startTime
    local T = self.endTime - self.startTime
    self.main:update(self, self.data, self.dev_seek and self.dev_seek * T or t, T, self.dev_seek or t / T)
    if Editor then
        self.curTime = self.curTime + dt
    end
end

function SeekModeScript:onEvent (comp, event)
    local key = event.args:get(0)
    if type(key) == "string" then
        local data = self.data
        local name = CCHandlers[key]
        if name then
            data[name] = event.args:get(1)
            return
        end
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
