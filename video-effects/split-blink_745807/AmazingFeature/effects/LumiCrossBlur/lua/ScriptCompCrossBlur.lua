---@class ScriptCompCrossBlur: ScriptComponent
---@field radiusX number [UI(Range={0., 100.}, Drag)]
---@field radiusY number [UI(Range={0., 100.}, Drag)]
---@field steps number [UI(Range={0.1, 10.}, Drag)]
---@field transferMode string[UI(Option={"Blend", "Add", "Screen", "Multiply", "Lighten", "Darken"})]
---@field borderType string [UI(Option={"Normal", "Replicate", "Black", "Reflect"})]
---@field blurAlpha boolean
---@field inverseGammaCorrection boolean
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

local exports = exports or {}
local ScriptCompCrossBlur = ScriptCompCrossBlur or {}
ScriptCompCrossBlur.__index = ScriptCompCrossBlur

------------ util functions ------------
local function clamp(value, min, max)
    --[[
        Description: clamp value between [min, max]
    ]]
    return math.min(math.max(value, min), max)
end

local function getXYScale(width, height)
    --[[
        Description: get XY scale for adjusting width/height ratio.
    ]]
    -- the following computation for baseSize is to avoid too small or too large width/height ratio.
    local size1 = math.min(width, height)
    local size2 = math.max(width, height) / 2.
    local baseSize = math.max(size1, size2)

    local xScale = baseSize / width
    local yScale = baseSize / height
    return xScale, yScale
end

local function getTransferMode(transferMode)
    --[[
        Description: convert transferMode from string to int
    ]]
    local transferModeTable = {
        ["Blend"] = 0, -- default
        ["Add"] = 1,
        ["Screen"] = 2,
        ["Multiply"] = 3,
        ["Lighten"] = 4,
        ["Darken"] = 5,
    }
    local flag = transferModeTable[transferMode]
    if flag == nil then flag = 0 end
    return flag
end

local function getBorderType(borderType)
    --[[
        Description: convert borderType from string to int
    ]]
    local borderTypeTable = {
        ["Normal"] = 0, -- default
        ["Replicate"] = 1,
        ["Black"] = 2,
        ["Reflect"] = 3
    }
    local flag = borderTypeTable[borderType]
    if flag == nil then flag = 0 end
    return flag
end

local function boolToInt(flag)
    --[[
        Description: convert flag from bool to int
    ]]
    if flag then return 1 end
    return 0
end

------------ class functions for ScriptComponent ------------
function ScriptCompCrossBlur.new(construct, ...)
    local self = setmetatable({}, ScriptCompCrossBlur)

    if construct and ScriptCompCrossBlur.constructor then ScriptCompCrossBlur.constructor(self, ...) end
    -- user parameters
    self.radiusX = 0.   -- radius actually refers to sample in the following code
    self.radiusY = 0.
    self.transferMode = "Blend"
    self.steps = 1.
    self.borderType = "Normal"
    self.blurAlpha = true
    self.inverseGammaCorrection = false

    -- other parameters
    self.NormalizationSize = 1000.
    self.MaxRadius = 100.
    self.MinSteps = 0.1
    self.MaxSteps = 10.
    self.RadiusOverSigma = 2.5
    self.Gamma = 2.2
    self.Eps = 1e-5

    self.InputTex = nil
    self.OutputTex = nil
    self.midTex = nil

    return self
end

function ScriptCompCrossBlur:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end

    if key == "transferMode" then
        local typeTable = {
            [0] = "Blend",
            [1] = "Add",
            [2] = "Screen",
            [3] = "Multiply",
            [4] = "Lighten",
            [5] = "Darken"
        }
        local transferMode = typeTable[value]
        if transferMode == nil then transferMode = "Normal" end
        _setEffectAttr(key, transferMode, comp)
    elseif key == "borderType" then
        local typeTable = {
            [0] = "Normal",
            [1] = "Replicate",
            [2] = "Black",
            [3] = "Reflect"
        }
        local borderType = typeTable[value]
        if borderType == nil then borderType = "Normal" end
        _setEffectAttr(key, borderType, comp)
    elseif key == "radiusX"
        or key == "radiusY"
        or key == "steps"
        or key == "blurAlpha"
        or key == "inverseGammaCorrection"
    then
        _setEffectAttr(key, value, comp)
    else
        _setEffectAttr(key, value, comp)
    end
end

function ScriptCompCrossBlur:onStart(comp)
    self.camGaussianBlurX = comp.entity:searchEntity("CameraGaussianBlurX"):getComponent("Camera")
    self.camGaussianBlurY = comp.entity:searchEntity("CameraGaussianBlurY"):getComponent("Camera")
    self.camBlend = comp.entity:searchEntity("CameraBlend"):getComponent("Camera")

    self.matGaussianBlurX = comp.entity:searchEntity("EntityGaussianBlurX"):getComponent("MeshRenderer").material
    self.matGaussianBlurY = comp.entity:searchEntity("EntityGaussianBlurY"):getComponent("MeshRenderer").material
    self.matBlend = comp.entity:searchEntity("EntityBlend"):getComponent("MeshRenderer").material

    self.midTex = self.lumiSharedRt:get(0)
end

function ScriptCompCrossBlur:onUpdate(comp, deltaTime)
    local textureWidth = self.OutputTex.width
    local textureHeight = self.OutputTex.height
    if self.midTex.width ~= textureWidth or self.midTex.height ~= textureHeight then
        self.midTex.width = textureWidth
        self.midTex.height = textureHeight
    end

    -- prepare parameters
    self.radiusX = clamp(self.radiusX, 0., self.MaxRadius)
    self.radiusY = clamp(self.radiusY, 0., self.MaxRadius)
    self.steps = clamp(self.steps, self.MinSteps, self.MaxSteps)
    local borderType = getBorderType(self.borderType)
    local transferMode = getTransferMode(self.transferMode)
    local inverseGammaCorrection = boolToInt(self.inverseGammaCorrection)
    local blurAlpha = boolToInt(self.blurAlpha)

    -- change variable name from `radius` to `sample`
    local sampleX = self.radiusX
    local sampleY = self.radiusY

    -- compute dx, dy
    local xScale, yScale = getXYScale(textureWidth, textureHeight)
    local dx = self.steps * xScale / self.NormalizationSize
    local dy = self.steps * yScale / self.NormalizationSize

    -- compute sigmaX, sigmaY. Note that radiusX = sampleX * dx, radiusY = sampleY * dy
    local sigmaX = sampleX * dx / self.RadiusOverSigma
    local sigmaY = sampleY * dy / self.RadiusOverSigma

    -- set InputTex and OutputTex
    self.camGaussianBlurX.entity.visible = false
    self.camGaussianBlurY.entity.visible = false
    self.matBlend:setTex("u_gaussianBlurXTexture", self.InputTex)
    self.matBlend:setTex("u_gaussianBlurYTexture", self.InputTex)
    self.camBlend.renderTexture = self.OutputTex

    if sampleX > self.Eps then
        self.camGaussianBlurX.entity.visible = true
        self.matGaussianBlurX:setTex("u_inputTexture", self.InputTex)
        if sampleY > self.Eps then
            self.camGaussianBlurX.renderTexture = self.OutputTex
            self.matBlend:setTex("u_gaussianBlurXTexture", self.OutputTex)
        else
            self.camGaussianBlurX.renderTexture = self.midTex
            self.matBlend:setTex("u_gaussianBlurXTexture", self.midTex)
        end
    end

    if sampleY > self.Eps then
        self.camGaussianBlurY.entity.visible = true
        self.camGaussianBlurY.renderTexture = self.midTex
        self.matGaussianBlurY:setTex("u_inputTexture", self.InputTex)
        self.matBlend:setTex("u_gaussianBlurYTexture", self.midTex)
    end

    -- set parameters for materials
    self.matGaussianBlurX:setFloat("u_sampleX", sampleX)
    self.matGaussianBlurX:setFloat("u_sigmaX", sigmaX)
    self.matGaussianBlurX:setFloat("u_stepX", dx)
    self.matGaussianBlurX:setFloat("u_gamma", self.Gamma)
    self.matGaussianBlurX:setInt("u_borderType", borderType)
    self.matGaussianBlurX:setInt("u_inverseGammaCorrection", inverseGammaCorrection)
    self.matGaussianBlurX:setInt("u_blurAlpha", blurAlpha)

    self.matGaussianBlurY:setFloat("u_sampleY", sampleY)
    self.matGaussianBlurY:setFloat("u_sigmaY", sigmaY)
    self.matGaussianBlurY:setFloat("u_stepY", dy)
    self.matGaussianBlurY:setFloat("u_gamma", self.Gamma)
    self.matGaussianBlurY:setInt("u_borderType", borderType)
    self.matGaussianBlurY:setInt("u_inverseGammaCorrection", inverseGammaCorrection)
    self.matGaussianBlurY:setInt("u_blurAlpha", blurAlpha)

    self.matBlend:setInt("u_blendType", transferMode)
end

exports.ScriptCompCrossBlur = ScriptCompCrossBlur
return exports
