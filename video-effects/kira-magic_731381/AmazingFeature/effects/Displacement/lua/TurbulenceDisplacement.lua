local exports = exports or {}
local TurbulenceDisplacement = TurbulenceDisplacement or {}
TurbulenceDisplacement.__index = TurbulenceDisplacement
---@class TurbulenceDisplacement : ScriptComponent
---@field size number
---@field quantity number
---@field complexity number
---@field evolution number
---@field cycle number
---@field offset_x number
---@field offset_y number
---@field type number
---@field fix_type number
---@field picture_scale number
---@field motion_tile_type number
---@field InputTex Texture
---@field OutputTex Texture

function TurbulenceDisplacement.new(construct, ...)
    local self = setmetatable({}, TurbulenceDisplacement)
    if construct and TurbulenceDisplacement.constructor then
        TurbulenceDisplacement.constructor(self, ...)
    end

    self.InputTex = nil
    self.OutputTex = nil

    self.size = 0
    self.quantity = 2
    self.complexity = 1
    self.evolution = 0
    self.cycle = 100
    self.offset_x = 0
    self.offset_y = 0
    self.type = 0
    self.fix_type = 0
    self.motion_tile_type = 0
    self.picture_scale = 1
    self.width = 0
    self.height = 0

    return self
end

function TurbulenceDisplacement:constructor()
end

function TurbulenceDisplacement:onUpdate(comp, detalTime)
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
    end
    if self.first == nil then
        self:start(comp)
    end
    local props = comp.entity:getComponent("ScriptComponent").properties
    if props:has("size") then
        self.size = props:get("size")
    end
    if props:has("evolution") then
        self.evolution = props:get("evolution")
    end
    self.camera.renderTexture = self.OutputTex
    self.material:setTex("inputImageTexture", self.InputTex)
    self.material:setFloat("u_Contrast", self.size);
    self.material:setVec2("u_Scale", Amaz.Vector2f(self.quantity, self.quantity));
    self.material:setFloat("u_Complexity", self.complexity);
    self.material:setFloat("u_Evolution", math.abs(self.evolution) / 120.0);
    self.material:setFloat("u_Cycle", math.max(2, math.floor(self.cycle*3.0 + 0.5)));
    self.material:setVec2("u_Offset", Amaz.Vector2f(self.offset_x, self.offset_y))
    self.material:setFloat("u_type", self.type);
    self.material:setFloat("u_fix_type", self.fix_type)
    self.material:setFloat("motion_tile_type", self.motion_tile_type)
    self.material:setFloat("picture_scale", self.picture_scale)
    self.material:setFloat("width", self.width)
    self.material:setFloat("height", self.height)
end

function TurbulenceDisplacement:onStart(comp)
    self:start(comp)
end

function TurbulenceDisplacement:start(comp)
    self.first = true
    self.camera = comp.entity:searchEntity("cam_Displacement"):getComponent("Camera")
    self.material = comp.entity:searchEntity("Displacement"):getComponent("MeshRenderer").material
end

exports.TurbulenceDisplacement = TurbulenceDisplacement
return exports
