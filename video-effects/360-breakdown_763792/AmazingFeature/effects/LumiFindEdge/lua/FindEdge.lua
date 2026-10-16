local exports = exports or {}
local FindEdge = FindEdge or {}
FindEdge.__index = FindEdge
---@class FindEdge: ScriptComponent
---@field brightness number
---@field grayColor Bool
---@field upperLimit number
---@field lowerLimit number
---@field InputTex Texture
---@field OutputTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function FindEdge.new(construct, ...)
    local self = setmetatable({}, FindEdge)
    if construct and FindEdge.constructor then
        FindEdge.constructor(self, ...)
    end

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function FindEdge:constructor()
end

function FindEdge:onStart(comp)
    self:start(comp)
end

function FindEdge:start(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.first = true
    self.properties = comp.properties
    self.material = comp.entity:searchEntity("edge_renderer"):getComponent("MeshRenderer").material
    self.camera = comp.entity:searchEntity("Camera_entity_edge"):getComponent("Camera")
end

function FindEdge:updateMaterial()
    if self.first == nil then
        return
    end

    self.material:setTex("inputImageTexture", self.InputTex)
    self.material:setFloat("brightness", self.brightness);
    self.material:setFloat("upperLimit", self.upperLimit);
    self.material:setFloat("lowerLimit", self.lowerLimit);
    self.material:setFloat("grayColor", self.grayColor and 1 or 0);
end

function FindEdge:onUpdate(comp, detalTime)
    if self.first == nil then
        self:start(comp)
    end

    self.camera.renderTexture = self.OutputTex

    self:updateMaterial()
end

exports.FindEdge = FindEdge
return exports
