local exports = exports or {}
local TurbulentSpectrum = TurbulentSpectrum or {}
TurbulentSpectrum.__index = TurbulentSpectrum
---@class TurbulentSpectrum: ScriptComponent
---@field brightness number
---@field contrast number
---@field complexity number
---@field evolution number
---@field cycle number
---@field rotate number
---@field sub_impact number
---@field sub_rotate number
---@field sub_scale number
---@field offset_x number
---@field offset_y number
---@field scale_x number
---@field scale_y number
---@field sub_offset_x number
---@field sub_offset_y number
---@field InputTex Texture
---@field OutputTex Texture

function TurbulentSpectrum.new(construct, ...)
    local self = setmetatable({}, TurbulentSpectrum)
    if construct and TurbulentSpectrum.constructor then
        TurbulentSpectrum.constructor(self, ...)
    end

    self.InputTex = nil
    self.OutputTex = nil

    self.brightness = 0
    self.contrast = 0
    self.complexity = 6
    self.evolution = 0
    self.cycle = 100
    self.rotate = 0
    self.offset_x = 0
    self.offset_y = 0
    self.scale_x = 0.1
    self.scale_y = 0.1
    self.sub_impact = 0.6
    self.sub_rotate = 0
    self.sub_scale = 0.056
    self.sub_offset_x = 0
    self.sub_offset_y = 0

    return self
end

function TurbulentSpectrum:constructor()
end

function TurbulentSpectrum:onUpdate(comp, detalTime)
    self:seekToTime(comp, detalTime)
end

function TurbulentSpectrum:start(comp)
    self.first = true
    self.camera = comp.entity:searchEntity("Camera_entity"):getComponent("Camera")
    self.material = comp.entity:searchEntity("PassEntity"):getComponent("MeshRenderer").material

    self.offset = Amaz.Vector2f(0., 0.)
    self.scale = Amaz.Vector2f(1, 1)
    self.SubOffset = Amaz.Vector2f(0., 0.)
end

function TurbulentSpectrum:seekToTime(comp, time)
    if self.first == nil then
        self:start(comp)
    end

    self.offset = Amaz.Vector2f(self.offset_x, self.offset_y)
    self.scale = Amaz.Vector2f(self.scale_x * 10, self.scale_y * 10)
    self.SubOffset = Amaz.Vector2f(self.sub_offset_x, self.sub_offset_y)

    self.camera.renderTexture = self.OutputTex
    self.material:setTex("inputImageTexture", self.InputTex)
    self.material:setFloat("u_Brightness", self.brightness)
    self.material:setFloat("u_Contrast", self.contrast)
    self.material:setFloat("u_Complexity", self.complexity*10)
    self.material:setFloat("u_Evolution", math.abs(self.evolution) / 120.0)
    self.material:setFloat("u_Cycle", math.max(2, math.floor(self.cycle * 100*3 + 0.5)))
    self.material:setFloat("u_Rotate", self.rotate)
    self.material:setVec2("u_Offset", self.offset)
    self.material:setVec2("u_Scale", self.scale)
    self.material:setFloat("u_SubImpact", self.sub_impact)
    self.material:setFloat("u_SubRotate", self.sub_rotate)
    self.material:setFloat("u_SubScale", self.sub_scale * 10)
    self.material:setVec2("u_SubOffset", self.SubOffset)
end

exports.TurbulentSpectrum = TurbulentSpectrum
return exports
