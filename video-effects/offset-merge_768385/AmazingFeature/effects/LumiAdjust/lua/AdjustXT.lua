local exports = exports or {}
local AdjustXT = AdjustXT or {}
AdjustXT.__index = AdjustXT
---@class AdjustXT: ScriptComponent
---@field brilliance number
---@field brightness number
---@field contrast number
---@field exposure number
---@field fade number
---@field highlight number
---@field lightSensation number
---@field saturation number
---@field shadow number
---@field temperature number
---@field tone number
---@field vibrance number
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

function AdjustXT.new(construct, ...)
    local self = setmetatable({}, AdjustXT)
    if construct and AdjustXT.constructor then
        AdjustXT.constructor(self, ...)
    end

    -- Neutral defaults match the Adjust material and keep cloned instances
    -- safe before LumiBlit supplies their per-pass values.
    self.brilliance = 0.0
    self.brightness = 0.0
    self.contrast = 0.0
    self.exposure = 0.0
    self.fade = 0.0
    self.highlight = 0.0
    self.lightSensation = 0.0
    self.saturation = 0.0
    self.shadow = 0.0
    self.temperature = 0.0
    self.tone = 0.0
    self.vibrance = 0.0
    self.midTex = nil

    return self
end

function AdjustXT:constructor()
end

function AdjustXT:onStart(comp)
    self:start(comp)
end

function AdjustXT:start(comp)
    self.first = true
    self.camera = comp.entity:searchEntity("Camera_entity_3"):getComponent("Camera")
    self.material = comp.entity:searchEntity("map_renderer"):getComponent("MeshRenderer").material
    self.material_final = comp.entity:searchEntity("final_renderer"):getComponent("MeshRenderer").material
    self.material_splendor = comp.entity:searchEntity("splendor_renderer"):getComponent("MeshRenderer").material
    self.camera_map = comp.entity:searchEntity("Camera_entity_map"):getComponent("Camera")
    self.camera2 =  comp.entity:searchEntity("Camera_entity"):getComponent("Camera")
    if self.midTex == nil and self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.midTex = self.lumiSharedRt:get(0)
    end
    if self.midTex == nil then
        self.midTex = self.camera2.renderTexture
    end
    if self.midTex then
        self.camera2.renderTexture = self.midTex
        self.material_splendor:setTex("inputImageTexture", self.midTex)
    end
end

function AdjustXT:updateMaterial()
    if self.first == nil or self.OutputTex == nil or self.midTex == nil then
        return
    end

    if self.midTex.width ~= self.OutputTex.width or self.midTex.height ~= self.OutputTex.height then
        self.midTex.width = self.OutputTex.width
        self.midTex.height = self.OutputTex.height
    end

    self.camera.renderTexture = self.OutputTex
    self.camera_map.renderTexture = self.OutputTex
    self.material_final:setTex("lut", self.OutputTex)
    self.material_final:setTex("inputImage", self.InputTex)
    self.material_splendor:setTex("inputImageTexture", self.midTex)
    self.material_splendor:setFloat("ins", self.brilliance*0.5+0.5)
    self.material:setFloat("intensityBrightness", self.brightness)
    self.material:setFloat("intensityContrast", self.contrast)
    self.material:setFloat("intensityExposure", self.exposure)
    self.material:setFloat("intensityFade", self.fade)
    self.material:setFloat("intensityHighlight", self.highlight)
    self.material:setFloat("intensityLightSensation", self.lightSensation)
    self.material:setFloat("intensitySaturation", self.saturation)
    self.material:setFloat("intensityShadow", self.shadow)
    self.material:setFloat("intensityTemperature", self.temperature)
    self.material:setFloat("intensityVibrance", self.vibrance)
    self.material:setFloat("intensityTone", self.tone)
end

function AdjustXT:onUpdate(comp, detalTime)
    if self.first == nil then
        self:start(comp)
    end

    -- LumiBlit drives cloned Adjust passes through ScriptComponent properties.
    -- Read those values before updating the native material so animated
    -- controls such as exposure are not stuck at the constructor defaults.
    local props = comp and comp.properties
    if props then
        if props:has("InputTex") then self.InputTex = props:get("InputTex") end
        if props:has("OutputTex") then self.OutputTex = props:get("OutputTex") end
        local fields = {
            "brilliance", "brightness", "contrast", "exposure", "fade",
            "highlight", "lightSensation", "saturation", "shadow",
            "temperature", "tone", "vibrance",
        }
        for _, field in ipairs(fields) do
            if props:has(field) then self[field] = props:get(field) end
        end
    end

    self:updateMaterial()
end

exports.AdjustXT = AdjustXT
return exports
