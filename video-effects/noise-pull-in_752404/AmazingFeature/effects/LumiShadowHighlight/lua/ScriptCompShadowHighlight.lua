---@class ScriptCompShadowHighlight: ScriptComponent
---@field shadowIntensity number [UI(Range={-1., 1.}, Drag)]
---@field highlightIntensity number [UI(Range={-1., 1.}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture

local exports = exports or {}
local ScriptCompShadowHighlight = ScriptCompShadowHighlight or {}
ScriptCompShadowHighlight.__index = ScriptCompShadowHighlight

------------ util functions ------------
local function clamp(value, min, max)
    --[[
        Description: clamp value between [min, max]
    ]]
    return math.min(math.max(value, min), max)
end

local function getShadowParam(intensity)
    --[[
        Description: mapping user parameter `intensity` to formula parameter.
        Formula is implemented in shader file.
    ]]
    local p = intensity
    local p2 = p * p
    local p3 = p2 * p
    local p4 = p3 * p
    local param = 1.0 - 0.503 * p + 0.183 * p2 - 0.147 * p3 + 0.067 * p4
    return param
end

local function getHighlightParam(intensity)
    --[[
        Description: mapping user parameter `intensity` to formula parameter.
        Formula is implemented in shader file.
    ]]
    local p = intensity
    local p2 = p * p
    local p3 = p2 * p
    local p4 = p3 * p
    local param = 1.0 + 0.503 * p + 0.183 * p2 + 0.147 * p3 + 0.067 * p4
    return param
end

------------ class functions for ScriptComponent ------------
function ScriptCompShadowHighlight.new(construct, ...)
    local self = setmetatable({}, ScriptCompShadowHighlight)

    if construct and ScriptCompShadowHighlight.constructor then ScriptCompShadowHighlight.constructor(self, ...) end
    -- user parameters
    self.shadowIntensity = 0.
    self.highlightIntensity = 0.

    -- other parameters
    self.MinIntensity = -1.
    self.MaxIntensity = 1.
    self.Eps = 1e-5

    self.InputTex = nil
    self.OutputTex = nil
    return self
end

function ScriptCompShadowHighlight:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end

    if key == "shadowIntensity"
        or key == "highlightIntensity"
    then
        _setEffectAttr(key, value, comp)
    else
        _setEffectAttr(key, value, comp)
    end
end

function ScriptCompShadowHighlight:onStart(comp)
    self.matShadowHighlight = comp.entity:searchEntity("EntityShadowHighlight"):getComponent("MeshRenderer").material
    self.camShadowHighlight = comp.entity:searchEntity("CameraShadowHighlight"):getComponent("Camera")
end

function ScriptCompShadowHighlight:onUpdate(comp, deltaTime)
    -- prepare parameters
    self.shadowIntensity = clamp(self.shadowIntensity, self.MinIntensity, self.MaxIntensity)
    self.highlightIntensity = clamp(self.highlightIntensity, self.MinIntensity, self.MaxIntensity)

    local shadowParam = getShadowParam(self.shadowIntensity)
    local highlightParam = getHighlightParam(self.highlightIntensity)

    -- set InputTex and OutputTex
    self.matShadowHighlight:setTex("u_inputTexture", self.InputTex)
    self.camShadowHighlight.renderTexture = self.OutputTex

    -- set material parameters
    self.matShadowHighlight:setFloat("u_shadowParam", shadowParam)
    self.matShadowHighlight:setFloat("u_highlightParam", highlightParam)
end

exports.ScriptCompShadowHighlight = ScriptCompShadowHighlight
return exports
