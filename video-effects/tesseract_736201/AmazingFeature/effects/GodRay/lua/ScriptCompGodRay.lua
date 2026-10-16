---@class ScriptCompGodRay: ScriptComponent
---@field intensity number [UI(Range={0., 1.}, Drag)]
---@field range number [UI(Range={0., 1.}, Drag)]
---@field brightness number [UI(Range={0., 1.}, Drag)]
---@field smoothness number [UI(Range={0., 1.}, Drag)]
---@field weightDecay number [UI(Range={0., 2.}, Drag)]
---@field quality number [UI(Range={10., 100.}, Drag)]
---@field grayscaleCorrection number [UI(Range={-1., 1.}, Drag)]
---@field center Vector2f
---@field blendMode string [UI(Option={"Screen", "Add", "Lighten", "Multiply", "Normal"})]
---@field colorType string [UI(Option={"Source", "Light Color"})]
---@field lightColor Color [UI(NoAlpha)]
---@field displayRayOnly Bool
---@field dither number [UI(Range={0., 1.0}, Drag)]
---@field inverseGammaCorrection Bool
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

local exports = exports or {}
local ScriptCompGodRay = ScriptCompGodRay or {}
ScriptCompGodRay.__index = ScriptCompGodRay


------------ util functions ------------
local function clamp(value, min, max)
    --[[
        Description: clamp value between [min, max]
    ]]
    return math.min(math.max(value, min), max)
end


local function remap(value, srcMin, srcMax, dstMin, dstMax)
    --[[
        Description: linearly remap value from [srcMin, srcMax] to [dstMin, dstMax]
    ]]
    return dstMin + (value - srcMin) * (dstMax - dstMin) / (srcMax - srcMin)
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


local function BoolToInt(flag)
    --[[
        Description: convert flag from bool to int
    ]]
    if flag then return 1 end
    return 0
end


local function getBlendMode(blendMode)
    --[[
        Description: convert colorType from string to int
    ]]
    local blendModeTable = {
        ["Screen"] = 0, -- default
        ["Add"] = 1,
        ["Lighten"] = 2,
        ["Multiply"] = 3,
        ["Normal"] = 4
    }
    local flag = blendModeTable[blendMode]
    if flag == nil then flag = 0 end
    return flag
end


local function getColorType(colorType)
    --[[
        Description: convert colorType from string to int
    ]]
    local colorTypeTable = {
        ["Source"] = 0, -- default
        ["Light Color"] = 1
    }
    local flag = colorTypeTable[colorType]
    if flag == nil then flag = 0 end
    return flag
end


------------ class functions for ScriptComponent ------------
function ScriptCompGodRay.new(construct, ...)
    local self = setmetatable({}, ScriptCompGodRay)

    if construct and ScriptCompGodRay.constructor then ScriptCompGodRay.constructor(self, ...) end
    -- user parameters
    self.intensity = 1.
    self.range = 0.5
    self.brightness = 0.0
    self.smoothness = 0.
    self.weightDecay = 1.
    self.quality = 50.
    self.grayscaleCorrection = 0.
    self.center = Amaz.Vector2f(0.5, 0.5)
    self.blendMode = "Screen"
    self.colorType = "Source"
    self.lightColor = Amaz.Color(1., 1., 1.)
    self.displayRayOnly = false
    self.dither = 0.
    self.inverseGammaCorrection = false

    -- other parameters
    self.MaxIntensity = 1.
    self.MinQuality = 10.
    self.MaxQuality = 100.
    self.MinGrayscaleCorrection = -1.
    self.MaxGrayscaleCorrection = 1.
    self.MinCenter = -1.
    self.MaxCenter = 2.
    self.MinWeightDecay = 0.0
    self.MaxWeightDecay = 2.0
    self.MaxDither = 0.5
    self.Gamma = 2.2
    self.MaxGaussianBlurSample = 30
    self.RadiusOverSigma = 2.5
    self.Eps = 1e-5

    -- finetuned parameters for some GodRay uniform variables
    self.NormalizationSize = 1000.
    self.NormalizationSample = 50.
    self.SampleScale = 15.
    self.SampleBias = 20.

    self.InputTex = nil
    self.OutputTex = nil
    return self
end


function ScriptCompGodRay:constructor()
end


function ScriptCompGodRay:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end

    if key == "colorType" then
        local colorType = "Source"
        if value == 1 then colorType = "Light Color" end
        _setEffectAttr(key, colorType, comp)
    elseif key == "blendMode" then
        local blendMode = "Screen"
        if value == 1 then blendMode = "Add"
        elseif value == 2 then blendMode = "Lighten"
        elseif value == 3 then blendMode = "Multiply" 
        elseif value ==4 then blendMode = "Normal" end
        _setEffectAttr(key, blendMode, comp)
    elseif key == "range"
        or key == "smoothness"
        or key == "brightness"
        or key == "weightDecay"
        or key == "quality"
        or key == "grayscaleCorrection"
        or key == "center"
        or key == "dither"
        or key == "lightColor"
        or key == "displayRayOnly"
        or key == "inverseGammaCorrection"
    then
        _setEffectAttr(key, value, comp)
    end
end


function ScriptCompGodRay:onStart(comp)
    self.matThreshold = comp.entity:searchEntity("EntityThreshold"):getComponent("MeshRenderer").material
    self.matGaussianBlurX = comp.entity:searchEntity("EntityGaussianBlurX"):getComponent("MeshRenderer").material
    self.matGaussianBlurY = comp.entity:searchEntity("EntityGaussianBlurY"):getComponent("MeshRenderer").material
    self.matGodRay = comp.entity:searchEntity("EntityGodRay"):getComponent("MeshRenderer").material

    self.camGaussianBlurX = comp.entity:searchEntity("CameraGaussianBlurX"):getComponent("Camera")
    self.camGaussianBlurY = comp.entity:searchEntity("CameraGaussianBlurY"):getComponent("Camera")
    self.camGodRay = comp.entity:searchEntity("CameraGodRay"):getComponent("Camera")
    self.camThreshold = comp.entity:searchEntity("CameraThreshold"):getComponent("Camera")

    self.midTex = self.lumiSharedRt:get(0)
    self.camThreshold.renderTexture = self.midTex
    self.matGaussianBlurX:setTex("u_inputTexture", self.midTex)
    self.camGaussianBlurY.renderTexture = self.midTex
    self.matGodRay:setTex("u_godRayTexture", self.midTex)
end


function ScriptCompGodRay:onUpdate(comp, deltaTime)
    if comp.properties:has("brightness") then
        self.brightness = comp.properties:get("brightness")
    end
    if comp.properties:has("center") then
        self.center = comp.properties:get("center")
    end
    if comp.properties:has("smoothness") then
        self.smoothness = comp.properties:get("smoothness")
    end

    local textureWidth = self.OutputTex.width
    local textureHeight = self.OutputTex.height
    if self.midTex.width ~= textureWidth or self.midTex.height ~= textureHeight then
        self.midTex.width = textureWidth
        self.midTex.height = textureHeight
    end

    -- prepare parameters for Threshold material
    self.range = clamp(self.range, 0., 1.)
    local colorType = getColorType(self.colorType)

    -- prepare parameters for GaussianBlur material
    self.smoothness = clamp(self.smoothness, 0., 1.)
    local sample = remap(self.smoothness, 0., 1., 0., self.MaxGaussianBlurSample)
    local xScale, yScale = getXYScale(textureWidth, textureHeight)
    local dx = xScale / self.NormalizationSize
    local dy = yScale / self.NormalizationSize
    local sigmaX = sample * dx / self.RadiusOverSigma
    local sigmaY = sample * dy / self.RadiusOverSigma

    -- prepare parameters for GodRay material
    self.intensity = clamp(self.intensity, 0., self.MaxIntensity)
    self.brightness = clamp(self.brightness, 0., 1.)
    self.quality = clamp(self.quality, self.MinQuality, self.MaxQuality)
    self.grayscaleCorrection = clamp(self.grayscaleCorrection, self.MinGrayscaleCorrection, self.MaxGrayscaleCorrection)
    self.center.x = clamp(self.center.x, self.MinCenter, self.MaxCenter)
    self.center.y = clamp(self.center.y, self.MinCenter, self.MaxCenter)
    self.dither = clamp(self.dither, 0., 1.)
    self.weightDecay = clamp(self.weightDecay, self.MinWeightDecay, self.MaxWeightDecay)
    local blendMode = getBlendMode(self.blendMode)
    local dither = remap(self.dither, 0., 1., 0., self.MaxDither)
    local displayRayOnly = BoolToInt(self.displayRayOnly)
    local inverseGammaCorrection = BoolToInt(self.inverseGammaCorrection)
    local grayscaleCorrection = 10 ^ (-self.grayscaleCorrection)

    -- process lightColor for inverseGammaCorrection
    if self.inverseGammaCorrection then
        self.lightColor.r = self.lightColor.r ^ self.Gamma
        self.lightColor.g = self.lightColor.g ^ self.Gamma
        self.lightColor.b = self.lightColor.b ^ self.Gamma
    end

    -- set InputTex, OutputTex
    if self.smoothness < self.Eps then
        self.camGaussianBlurX.entity.visible = false
        self.camGaussianBlurY.entity.visible = false
    else
        self.camGaussianBlurX.entity.visible = true
        self.camGaussianBlurY.entity.visible = true
    end

    self.matThreshold:setTex("u_inputTexture", self.InputTex)
    self.matGaussianBlurY:setTex("u_inputTexture", self.OutputTex)
    self.camGaussianBlurX.renderTexture = self.OutputTex
    self.camGodRay.renderTexture = self.OutputTex

    -- set material parameters
    self.matThreshold:setFloat("u_threshold", 1. - self.range)
    self.matThreshold:setInt("u_colorType", colorType)

    self.matGaussianBlurX:setFloat("u_sampleX", sample)
    self.matGaussianBlurX:setFloat("u_sigmaX", sigmaX)
    self.matGaussianBlurX:setFloat("u_dx", dx)
    self.matGaussianBlurX:setFloat("u_gamma", self.Gamma)
    self.matGaussianBlurX:setInt("u_inverseGammaCorrection", inverseGammaCorrection)

    self.matGaussianBlurY:setFloat("u_sampleY", sample)
    self.matGaussianBlurY:setFloat("u_sigmaY", sigmaY)
    self.matGaussianBlurY:setFloat("u_dy", dy)
    self.matGaussianBlurY:setFloat("u_gamma", self.Gamma)
    self.matGaussianBlurY:setInt("u_inverseGammaCorrection", inverseGammaCorrection)

    self.matGodRay:setTex("u_inputTexture", self.InputTex)
    self.matGodRay:setFloat("u_intensity", self.intensity)
    self.matGodRay:setFloat("u_brightness", self.brightness)
    self.matGodRay:setFloat("u_quality", self.quality)
    self.matGodRay:setFloat("u_grayscaleCorrection", grayscaleCorrection)
    self.matGodRay:setVec2("u_center", self.center)
    self.matGodRay:setInt("u_blendMode", blendMode)
    self.matGodRay:setInt("u_colorType", colorType)
    self.matGodRay:setVec3("u_lightColor", Amaz.Vector3f(self.lightColor.r, self.lightColor.g, self.lightColor.b))
    self.matGodRay:setFloat("u_dither", dither)
    self.matGodRay:setFloat("u_weightDecay", self.weightDecay)
    self.matGodRay:setInt("u_displayRayOnly", displayRayOnly)
    self.matGodRay:setInt("u_inverseGammaCorrection", inverseGammaCorrection)
    self.matGodRay:setFloat("u_gamma", self.Gamma)
    self.matGodRay:setFloat("u_normalizationSample", self.NormalizationSample)
    self.matGodRay:setFloat("u_sampleScale", self.SampleScale)
    self.matGodRay:setFloat("u_sampleBias", self.SampleBias)
end


exports.ScriptCompGodRay = ScriptCompGodRay
return exports
