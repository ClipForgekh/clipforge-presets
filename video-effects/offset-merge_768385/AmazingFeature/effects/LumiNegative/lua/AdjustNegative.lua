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
    local props = comp.entity:getComponent("ScriptComponent").properties
    if props:has("InputTex") then
        self.InputTex = props:get("InputTex")
    end
    if props:has("OutputTex") then
        self.OutputTex = props:get("OutputTex")
    end
    if props:has("negativeAlpha") then
        self.negativeAlpha = props:get("negativeAlpha")
    end

    self.camNegative.renderTexture = self.OutputTex
    self.matNegative:setTex('u_inputTex', self.InputTex)
    self.matNegative:setFloat('u_negativeAlpha', self.negativeAlpha)
end

exports.AdjustNegative = AdjustNegative
return exports
