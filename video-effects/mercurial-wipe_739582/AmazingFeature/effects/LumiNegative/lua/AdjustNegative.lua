local exports = exports or {}
local AdjustNegative = AdjustNegative or {}
AdjustNegative.__index = AdjustNegative
---@class AdjustNegative: ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture
---@field negativeAlpha number

function AdjustNegative.new(construct, ...)
    local self = setmetatable({}, AdjustNegative)
    if construct and AdjustNegative.constructor then AdjustNegative.constructor(self, ...) end

    self.InputTex = nil
    self.OutputTex = nil
    self.negativeAlpha = 1

    return self
end

function AdjustNegative:constructor()
end

function AdjustNegative:onStart(comp)
    self.matNegative = comp.entity:searchEntity("PassNegative"):getComponent("MeshRenderer").material
    self.camNegative = comp.entity:searchEntity("CameraNegative"):getComponent("Camera")
end

function AdjustNegative:onUpdate(comp, deltaTime)
    self.matNegative:setTex("u_albedo", self.InputTex)
    self.camNegative.renderTexture = self.OutputTex

    self.matNegative:setFloat("negativeAlpha", self.negativeAlpha)
    self.matNegative:setVec2('u_size', Amaz.Vector2f(self.InputTex.width, self.InputTex.height))
end

exports.AdjustNegative = AdjustNegative
return exports
