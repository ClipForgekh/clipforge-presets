---@class ScriptCompStrongSharpen: ScriptComponent
---@field strength number [UI(Range={0., 1.}, Drag)]
---@field range number [UI(Range={0., 1.}, Drag)]
---@field steps number [UI(Range={0.1, 10.}, Drag)]
---@field offsetX number [UI(Range={-1., 1.}, Drag)]
---@field offsetY number [UI(Range={-1., 1.}, Drag)]
---@field borderType string [UI(Option={"Normal", "Replicate", "Black", "Reflect"})]
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

local exports = exports or {}
local ScriptCompStrongSharpen = ScriptCompStrongSharpen or {}
ScriptCompStrongSharpen.__index = ScriptCompStrongSharpen


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
function ScriptCompStrongSharpen.new(construct, ...)
    local self = setmetatable({}, ScriptCompStrongSharpen)

    if construct and ScriptCompStrongSharpen.constructor then ScriptCompStrongSharpen.constructor(self, ...) end
    -- user parameters
    self.strength = 0.3
    self.range = 0.1
    self.steps = 1.
    self.offsetX = 0.
    self.offsetY = 0.
    self.borderType = "Normal"

    -- other parameters
    self.NormalizationSize = 1000.
    self.MaxStrength = 10.
    self.SampleScale = 30.
    self.MaxOffset = 0.2
    self.MinSteps = 0.1
    self.MaxSteps = 10.
    self.OffsetScale = 0.2
    self.RadiusOverSigma = 2.5

    self.InputTex = nil
    self.OutputTex = nil

    return self
end


function ScriptCompStrongSharpen:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end

    if key == "borderType" then
        local typeTable = {
            [0] = "Normal",
            [1] = "Replicate",
            [2] = "Black",
            [3] = "Reflect"
        }
        local blurType = typeTable[value]
        if blurType == nil then blurType = "Normal" end
        _setEffectAttr(key, blurType, comp)
    elseif key == "strength"
        or key == "range"
        or key == "steps"
        or key == "offsetX"
        or key == "offsetY"
    then
        _setEffectAttr(key, value, comp)
    end
end


function ScriptCompStrongSharpen:onStart(comp)
    self.camGaussianBlurX = comp.entity:searchEntity("CameraGaussianBlurX"):getComponent("Camera")
    self.camGaussianBlurY = comp.entity:searchEntity("CameraGaussianBlurY"):getComponent("Camera")
    self.camOffset = comp.entity:searchEntity("CameraOffset"):getComponent("Camera")


    self.matGaussianBlurX = comp.entity:searchEntity("EntityGaussianBlurX"):getComponent("MeshRenderer").material
    self.matGaussianBlurY = comp.entity:searchEntity("EntityGaussianBlurY"):getComponent("MeshRenderer").material
    self.matOffset= comp.entity:searchEntity("EntityOffset"):getComponent("MeshRenderer").material

    self.camGaussianBlurY.renderTexture = self.lumiSharedRt:get(0)
    self.matOffset:setTex("u_inputTexture", self.lumiSharedRt:get(0))
end


function ScriptCompStrongSharpen:onUpdate(comp, deltaTime)
    -- prepare parameters
    self.strength = clamp(self.strength, 0., 1.)
    local strength = remap(self.strength, 0., 1., 0., self.MaxStrength)
    self.range = clamp(self.range, 0., 1.)
    local sampleNum =self.range * self.SampleScale
    local sampleX = sampleNum
    local sampleY = sampleNum
    self.steps = clamp(self.steps, self.MinSteps, self.MaxSteps)
    self.offsetX = clamp(self.offsetX, -1., 1.)
    self.offsetY = clamp(self.offsetY, -1., 1.)
    local offsetX = self.offsetX * self.OffsetScale
    local offsetY = self.offsetY * self.OffsetScale
    local borderType = getBorderType(self.borderType)

    -- compute dx, dy
    local textureWidth = Amaz.BuiltinObject.getOutputTextureWidth()
    local textureHeight = Amaz.BuiltinObject.getOutputTextureHeight()
    local xScale, yScale = getXYScale(textureWidth, textureHeight)
    local dx = self.steps * xScale / self.NormalizationSize
    local dy = self.steps * yScale / self.NormalizationSize

    -- compute sigmaX, sigmaY. Note that radiusX = sampleX * dx, radiusY = sampleY * dy
    local sigmaX = sampleX * dx / self.RadiusOverSigma
    local sigmaY = sampleY * dy / self.RadiusOverSigma

    -- set InputTex, OutputTex
    self.matGaussianBlurX:setTex("u_inputTexture", self.InputTex)
    self.matGaussianBlurY:setTex("u_inputTexture", self.InputTex)
    self.matGaussianBlurY:setTex("u_blurMidTexture", self.OutputTex)

    self.camGaussianBlurX.renderTexture = self.OutputTex
    self.camOffset.renderTexture = self.OutputTex

    -- set parameters for materials
    self.matGaussianBlurX:setFloat("u_sampleX", sampleX)
    self.matGaussianBlurX:setFloat("u_sigmaX", sigmaX)
    self.matGaussianBlurX:setFloat("u_dx", dx)
    self.matGaussianBlurX:setInt("u_borderType", borderType)

    self.matGaussianBlurY:setFloat("u_sampleY", sampleY)
    self.matGaussianBlurY:setFloat("u_sigmaY", sigmaY)
    self.matGaussianBlurY:setFloat("u_dy", dy)
    self.matGaussianBlurY:setInt("u_borderType", borderType)
    self.matGaussianBlurY:setFloat("u_strength", strength)

    self.matOffset:setFloat("u_offsetX", offsetX)
    self.matOffset:setFloat("u_offsetY", offsetY)
end


exports.ScriptCompStrongSharpen = ScriptCompStrongSharpen
return exports
