local exports = exports or {}
local MotionBlur2D = MotionBlur2D or {}
MotionBlur2D.__index = MotionBlur2D
---@class MotionBlur2D: ScriptComponent
----@field CurrRotate double [UI(Range={0, 360}, Slider)]
----@field CurrOffset Vector2f [UI(Drag=0.01)]
----@field CurrScale Vector2f [UI(Drag=0.01)]
----@field vIntensity double [UI(Range={0, 2}, Slider)]
----@field vCenter double [UI(Range={-1, 1}, Slider)]
----@field minSamples double [UI(Range={0, 256}, Slider)]
----@field maxSamples double [UI(Range={0, 256}, Slider)]
----@field u_Intensity number
----@field final_alpha number
----@field motion_tile_flag number
----@field InputTex Texture
----@field OutputTex Texture
function MotionBlur2D.new(construct, ...)
    local self = setmetatable({}, MotionBlur2D)
    if construct and MotionBlur2D.constructor then
        MotionBlur2D.constructor(self, ...)
    end
    self.startTime = 0.0
    self.endTime = 1.0
    self.curTime = 0.0
    self.firstSeek = true
    self.u_Intensity = 1
    self.final_alpha = 1
    self.motion_tile_flag = 0
    
    self.InputTex = nil
    self.OutputTex = nil
    return self
end

function MotionBlur2D:constructor()
end

function MotionBlur2D:onUpdate(comp, detalTime)
    self:seekToTime(comp, detalTime)

    self.material:setTex("inputImageTexture", self.InputTex)
    self.cam.renderTexture = self.OutputTex
end

function MotionBlur2D:onStart(comp)
    self.material = comp.entity:searchEntity("motion_blur_2d"):getComponent("MeshRenderer").material
    self.cam = comp.entity:searchEntity("cam"):getComponent("Camera")
    self.PrevRotate = 0
    self.PrevOffset = Amaz.Vector2f(0., 0.)
    self.PrevScale = Amaz.Vector2f(1, 1)
    self.CurrRotate = 0
    self.CurrOffset = Amaz.Vector2f(0., 0.)
    self.CurrScale = Amaz.Vector2f(1, 1)
end

function MotionBlur2D:seekToTime(comp, time)
    if self.first == nil then
        self.first = true
        -- self:start(comp)
    end
    
    if self.firstSeek then
        self.PrevRotate = self.CurrRotate;
        self.PrevOffset:Set(self.CurrOffset.x, self.CurrOffset.y);
        self.PrevScale:Set(self.CurrScale.x, self.CurrScale.y);
        self.firstSeek = false
    end

    self.curTime = (self.curTime + time)%(self.endTime - self.startTime)

    -- self.material:setFloat("CurrRotate", self.CurrRotate);
    -- self.material:setVec2("CurrOffset", self.CurrOffset)
    -- self.material:setVec2("CurrScale", self.CurrScale)
    -- self.material:setFloat("PrevRotate", self.PrevRotate);
    -- self.material:setVec2("PrevOffset", self.PrevOffset)
    -- self.material:setVec2("PrevScale", self.PrevScale)
    -- self.material:setFloat("vIntensity", self.vIntensity);
    -- self.material:setFloat("minSamples", self.minSamples);
    -- self.material:setFloat("maxSamples", self.maxSamples);
    -- self.material:setFloat("vCenter", self.vCenter);
    -- self.material:setFloat("u_Intensity", self.u_Intensity);
    -- self.material:setFloat("final_alpha", self.final_alpha);
    -- self.material:setFloat("motion_tile_flag", self.motion_tile_flag);
    -- self:updateMaterial()
end

function MotionBlur2D:updateMaterial()
    self.material:setFloat("CurrRotate", self.CurrRotate);
    self.material:setVec2("CurrOffset", self.CurrOffset)
    self.material:setVec2("CurrScale", self.CurrScale)
    self.material:setFloat("PrevRotate", self.PrevRotate);
    self.material:setVec2("PrevOffset", self.PrevOffset)
    self.material:setVec2("PrevScale", self.PrevScale)
    self.material:setFloat("vIntensity", self.vIntensity);
    self.material:setFloat("minSamples", self.minSamples);
    self.material:setFloat("maxSamples", self.maxSamples);
    self.material:setFloat("vCenter", self.vCenter);
    self.material:setFloat("u_Intensity", self.u_Intensity);
    self.material:setFloat("final_alpha", self.final_alpha);
    self.material:setFloat("motion_tile_flag", self.motion_tile_flag);
    self.material:setTex("inputImageTexture", self.InputTex)
end

local function clamp(val, min, max)
    return math.max(math.min(val, max), min)
end

function MotionBlur2D:onEvent(sys, event)
    -- if self.first == nil then
    --     self.first = true
    --     self:start(sys)
    -- end
    if self.material == nil then 
        return
    end
    if event.type == Amaz.AppEventType.SetEffectIntensity then
        -- local intensity = clamp(event.args:get(1), -360, 360)
        local intensity = event.args:get(1)
        if ("rotate" == event.args:get(0)) then
            self.CurrRotate = intensity*360;
        -- elseif ("offset_x" == event.args:get(0)) then
        --     self.CurrOffset:Set(intensity, self.CurrOffset.y)
        -- elseif ("offset_y" == event.args:get(0)) then
        --     self.CurrOffset:Set(self.CurrOffset.x, intensity)
        elseif ("position" == event.args:get(0)) then
            self.CurrOffset:Set(intensity:get(0) - 0.5, intensity:get(1) - 0.5)
        elseif ("scale_x" == event.args:get(0)) then
            self.CurrScale:Set(intensity*10, self.CurrScale.y)
        elseif ("scale_y" == event.args:get(0)) then
            self.CurrScale:Set(self.CurrScale.x, intensity*10)
        elseif ("vIntensity" == event.args:get(0)) then
            self.vIntensity = intensity
        elseif ("maxSamples" == event.args:get(0)) then
            self.maxSamples = intensity*100
        elseif ("minSamples" == event.args:get(0)) then
            self.minSamples = intensity*100
        elseif ("vCenter" == event.args:get(0)) then
            self.vCenter = intensity
        elseif ("ae_pre_rotate" == event.args:get(0)) then
            self.PrevRotate = intensity*360;
        elseif ("ae_pre_position" == event.args:get(0)) then
            self.PrevOffset:Set(intensity:get(0) - 0.5, intensity:get(1) - 0.5)
        elseif ("ae_pre_scale_x" == event.args:get(0)) then
            self.PrevScale:Set(intensity*10, self.PrevScale.y)
        elseif ("ae_pre_scale_y" == event.args:get(0)) then
            self.PrevScale:Set(self.PrevScale.x, intensity*10)
        elseif ("effects_adjust_size" == event.args:get(0)) then
            self.vCenter = intensity
        elseif ("effects_adjust_intensity" == event.args:get(0)) then
            self.vIntensity = intensity
        elseif ("effects_adjust_distortion" == event.args:get(0)) then
            self.maxSamples = intensity*100
        end
    end
end

exports.MotionBlur2D = MotionBlur2D
return exports
