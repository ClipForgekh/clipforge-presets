local exports = exports or {}
local LightSensation = LightSensation or {}
LightSensation.__index = LightSensation
---@class LightSensation: ScriptComponent
---@field lightIntensity number
---@field InputTex Texture
---@field OutputTex Texture

function LightSensation.new(construct, ...)
    local self = setmetatable({}, LightSensation)
    if construct and LightSensation.constructor then LightSensation.constructor(self, ...) end

    self.InputTex = nil
    self.OutputTex = nil
    self.lightIntensity = 1

    return self
end

function LightSensation:constructor()
end

function LightSensation:onStart(comp)
    self.material = comp.entity:searchEntity("VFX"):getComponent("Sprite2DRenderer").material
    self.camera = comp.entity:searchEntity("VFXCamera"):getComponent("Camera")
end

function LightSensation:onUpdate(comp, detalTime)
    self.camera.renderTexture = self.OutputTex
    self.material:setTex("inputImageTexture", self.InputTex)
    self.material:setFloat("intensity", self.lightIntensity)
end

exports.LightSensation = LightSensation
return exports
