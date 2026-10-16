---@class ScriptCompGaussianBlur: ScriptComponent
---@field intensity number [UI(Range={0., 100.}, Drag)]
---@field horizontalStrength number [UI(Range={0., 1.}, Drag)]
---@field verticalStrength number [UI(Range={0., 1.}, Drag)]
---@field steps number [UI(Range={0.1, 10.}, Drag)]
---@field blurDirection string [UI(Option={"Horizontal and Vertical", "Horizontal", "Vertical"})]
---@field borderType string [UI(Option={"Normal", "Replicate", "Black", "Reflect"})]
---@field blurAlpha boolean
---@field inverseGammaCorrection boolean
---@field InputTex Texture
---@field OutputTex Texture
---@field MidTex Texture


local exports = exports or {}
local ScriptCompGaussianBlur = ScriptCompGaussianBlur or {}
ScriptCompGaussianBlur.__index = ScriptCompGaussianBlur


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


local function boolToInt(flag)
    --[[
        Description: convert flag from bool to int
    ]]
    if flag then return 1 end
    return 0
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


------------ class functions for ScriptComponent ------------
function ScriptCompGaussianBlur.new(construct, ...)
    local self = setmetatable({}, ScriptCompGaussianBlur)

    if construct and ScriptCompGaussianBlur.constructor then ScriptCompGaussianBlur.constructor(self, ...) end
    -- user parameters
    self.intensity = 0.
    self.horizontalStrength = 1.
    self.verticalStrength = 1.
    self.steps = 1.
    self.blurDirection = "Horizontal and Vertical"
    self.borderType = "Normal"
    self.blurAlpha = true
    self.inverseGammaCorrection = true

    -- other parameters
    self.NormalizationSize = 1000.
    self.MaxIntensity = 1000.
    self.MinSteps = 0.1
    self.MaxSteps = 10.
    self.RadiusOverSigma = 2.5
    self.Gamma = 2.2
    self.Eps = 1e-5

    self.InputTex = nil
    self.OutputTex = nil
    self.MidTex = nil

    return self
end


function ScriptCompGaussianBlur:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end

    if key == "blurDirection" then
        local typeTable = {
            [0] = "Horizontal and Vertical",
            [1] = "Horizontal",
            [2] = "Vertical"
        }
        local blurDirection = typeTable[value]
        if blurDirection == nil then blurDirection = "Horizontal and Vertical" end
        _setEffectAttr(key, blurDirection, comp)
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
    else
        _setEffectAttr(key, value, comp)
    end
end


function ScriptCompGaussianBlur:onStart(comp)
    self.camGaussianBlurX = comp.entity:searchEntity("CameraGaussianBlurX"):getComponent("Camera")
    self.camGaussianBlurY = comp.entity:searchEntity("CameraGaussianBlurY"):getComponent("Camera")

    self.matGaussianBlurX = comp.entity:searchEntity("EntityGaussianBlurX"):getComponent("MeshRenderer").material
    self.matGaussianBlurY = comp.entity:searchEntity("EntityGaussianBlurY"):getComponent("MeshRenderer").material
    self.props = comp.properties
end


function ScriptCompGaussianBlur:onUpdate(comp, deltaTime)
    -- prepare parameters
    local intensity = clamp(self.props:get("intensity"), 0., self.MaxIntensity)
    local horizontalStrength = clamp(self.props:get("horizontalStrength"), 0., 1.)
    local verticalStrength = clamp(self.props:get("verticalStrength"), 0., 1.)
    local sampleX = intensity * horizontalStrength
    local sampleY = intensity * verticalStrength
    local steps = clamp(self.props:get("steps"), self.MinSteps, self.MaxSteps)
    local borderType = getBorderType(self.props:get("borderType"))
    local inverseGammaCorrection = boolToInt(self.props:get("inverseGammaCorrection"))
    local blurAlpha = boolToInt(self.props:get("blurAlpha"))

    -- compute dx, dy
    local textureWidth = Amaz.BuiltinObject.getOutputTextureWidth()
    local textureHeight = Amaz.BuiltinObject.getOutputTextureHeight()
    local xScale, yScale = getXYScale(textureWidth, textureHeight)
    local dx = steps * xScale / self.NormalizationSize
    local dy = steps * yScale / self.NormalizationSize

    -- compute sigmaX, sigmaY. Note that radiusX = sampleX * dx, radiusY = sampleY * dy
    local sigmaX = sampleX * dx / self.RadiusOverSigma
    local sigmaY = sampleY * dy / self.RadiusOverSigma

    -- set blur direction and InputTex, OutputTex
    local blurDirection = self.props:get("blurDirection")
    local InputTex = self.props:get("InputTex")
    local OutputTex = self.props:get("OutputTex")
    local MidTex = self.props:get("MidTex")
    if blurDirection == "Horizontal" then
        self.camGaussianBlurX.entity.visible = true
        self.camGaussianBlurY.entity.visible = false
        self.matGaussianBlurX:setTex("u_inputTexture", InputTex)
        self.camGaussianBlurX.renderTexture = OutputTex
    elseif blurDirection == "Vertical" then
        self.camGaussianBlurX.entity.visible = false
        self.camGaussianBlurY.entity.visible = true
        self.matGaussianBlurY:setTex("u_inputTexture", InputTex)
        self.camGaussianBlurY.renderTexture = OutputTex
    else
        self.camGaussianBlurX.entity.visible = true
        self.camGaussianBlurY.entity.visible = true
        self.matGaussianBlurX:setTex("u_inputTexture", InputTex)
        self.camGaussianBlurX.renderTexture = MidTex
        self.matGaussianBlurY:setTex("u_inputTexture", MidTex)
        self.camGaussianBlurY.renderTexture = OutputTex
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
end


exports.ScriptCompGaussianBlur = ScriptCompGaussianBlur
return exports
