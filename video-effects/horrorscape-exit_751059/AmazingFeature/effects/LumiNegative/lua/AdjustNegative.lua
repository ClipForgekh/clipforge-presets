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

function AdjustNegative:onStart(comp)
    self.matNegative = comp.entity:searchEntity("PassNegative"):getComponent("MeshRenderer").material
    self.camNegative = comp.entity:searchEntity("CameraNegative"):getComponent("Camera")
end

function AdjustNegative:onUpdate(comp, deltaTime)
    self.camNegative.renderTexture = self.OutputTex
    self.matNegative:setTex('u_inputTex', self.InputTex)
    self.matNegative:setFloat('u_negativeAlpha', self.negativeAlpha)
end

exports.AdjustNegative = AdjustNegative
return exports
