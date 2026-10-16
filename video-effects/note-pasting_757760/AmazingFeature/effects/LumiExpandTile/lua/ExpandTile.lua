local exports = exports or {}
local ExpandTile = ExpandTile or {}
ExpandTile.__index = ExpandTile
---@class ExpandTile: ScriptComponent
---@field expandRight number
---@field expandLeft number
---@field expandUp number
---@field expandDown number
---@field expandMode number
---@field blendBorders number
---@field runningMode number
---@field InputTex Texture
---@field OutputTex Texture

function ExpandTile.new(construct, ...)
    local self = setmetatable({}, ExpandTile)
    if construct and ExpandTile.constructor then
        ExpandTile.constructor(self, ...)
    end

    self.InputTex = nil
    self.OutputTex = nil

    self.expandRight = 0
    self.expandLeft = 0
    self.expandUp = 0
    self.expandDown = 0
    self.expandMode = 0
    self.blendBorders = 0
    self.runningMode = 0

    return self
end

function ExpandTile:constructor()
end

function ExpandTile:onUpdate(comp, detalTime)
    self:seekToTime(comp, detalTime)
end

function ExpandTile:start(comp)
    self.first = true
    self.camera = comp.entity:searchEntity("Camera_entity"):getComponent("Camera")
    self.material = comp.entity:searchEntity("PassEntity"):getComponent("MeshRenderer").material
end

function ExpandTile:seekToTime(comp, time)
    if self.first == nil then
        self:start(comp)
    end

    self.camera.renderTexture = self.OutputTex
    self.material:setTex("inputImageTexture", self.InputTex)
    self.material:setFloat("expandRight", self.expandRight)
    self.material:setFloat("expandLeft", self.expandLeft)
    self.material:setFloat("expandUp", self.expandUp)
    self.material:setFloat("expandDown", self.expandDown)
    self.material:setFloat("expandMode", self.expandMode)
    self.material:setFloat("runningMode", self.runningMode)
    self.material:setFloat("blendBorders", self.blendBorders)
end

exports.ExpandTile = ExpandTile
return exports
