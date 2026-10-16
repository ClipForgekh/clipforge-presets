local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiReflect = LumiReflect or {}
LumiReflect.__index = LumiReflect
---@class LumiReflect : ScriptComponent
---@field floorPosition Vector2f
---@field reflectionAngle number
---@field reflectionDistance number [UI(Range={0.0, 1.0}, Drag)]
---@field reflectionFalloff number [UI(Range={0.0, 1.0}, Drag)]
---@field skew number [UI(Range={-90.0, 90.0}, Drag)]
---@field tint vector3f
---@field opacity number [UI(Range={0.0, 1.0}, Drag)]
---@field blurType string [UI(Option={"Directional", "Falloff"})]
---@field blurAmount number [UI(Range={0, 100}, Drag)]
---@field blurOffset number [UI(Range={0, 100}, Drag)]
---@field blurFalloff number [UI(Range={0.0, 1.0}, Drag)]
---@field blendStyle string [UI(Option={"Composite", "Behind Original", "Reflection Only"})]
---@field quality number [UI(Range={0.1, 1.0}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local function createRenderTexture(width, height, filterMag, filterMin)
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = filterMag or Amaz.FilterMode.LINEAR
    rt.filterMin = filterMin or Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    return rt
end

local function updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then return end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

local function setRenderTexture(cam, rt)
    if cam == nil or rt == nil then return end
    cam.renderTexture = rt
end

local function getBlurType(blurType)

    local blurdTypeTable = {
        ["Directional"] = 0, -- default
        ["Falloff"] = 1
    }

    local flag = blurdTypeTable[blurType]
    if flag == nil then flag = 0 end
    return flag
end

local function getBlendType(blendType)

    local blendTypeTable = {
        ["Composite"] = 0, -- default
        ["Behind Original"] = 1,
        ["Reflection Only"] = 2
    }

    local flag = blendTypeTable[blendType]
    if flag == nil then flag = 0 end
    return flag
end

local function remap(value, srcMin, srcMax, dstMin, dstMax)
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

local function getSampleNum(intensity)
    --[[
        Description: get sample number and downsample scale
    ]]
    local scale = 1.
    local bias = 0.
    local s = scale
    if intensity <= 30 then
        scale = 0.5
        bias = 2.
        s = 0.78
    elseif intensity <= 100 then
        scale = 0.5
        bias = 10
        s = 0.66
    elseif intensity <= 200 then
        scale = 0.25
        bias = 50.
        s = 0.7
    else
        scale = 0.125
        bias = 80.
        s = 0.8
    end

    local sampleNum = scale * intensity + bias
    sampleNum = sampleNum * s
    if sampleNum < 2. then sampleNum = math.floor(sampleNum + 0.5) end
    return sampleNum, scale
end

local function getQualityParam(quality)
    local qualityParam = quality * 2. - 1.
    if qualityParam < 0. then
        qualityParam = 10 ^ qualityParam
    else
        qualityParam = qualityParam * 2. + 1.
    end
    return qualityParam
end

function LumiReflect.new(construct, ...)
    local self = setmetatable({}, LumiReflect)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.floorPosition = Amaz.Vector2f(0, 0)
    self.reflectionAngle = 0
    self.reflectionDistance = 0
    self.reflectionFalloff = 0

    self.skew = 0
    self.tint = Amaz.Color(1, 1, 1, 1)
    self.opacity = 1
    self.blurType = "Directional"
    self.blurAmount = 0
    self.blurOffset = 0
    self.blurFalloff = 0
    self.blendStyle = "Composite"

    self.normalizationSize = 1000.
    self.maxIntensity = 1000.
    self.radiusOverSigma = 2.5
    self.gamma = 2.2
    self.EPS = 1e-5

    self.quality = 1.0
    self.sharedMaterial = nil

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function LumiReflect:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "blendStyle" then
        local typeTable = {
            [0] = "Composite",
            [1] = "Behind Original",
            [2] = "Reflection Only"
        }
        local blendStyle = typeTable[value]
        if blendStyle == nil then blendStyle = "Composite" end
        _setEffectAttr(key, blendStyle, comp)
    elseif key == "blurType" then
        local typeTable = {[0] = "Directional", [1] = "Falloff"}
        local blurType = typeTable[value]
        if blurType == nil then blurType = "Directional" end
        _setEffectAttr(key, blurType, comp)
    else
        _setEffectAttr(key, value, comp)
    end
end

function LumiReflect:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.baseCam = self.entity:searchEntity("BaseMaskCamera"):getComponent(
                       "Camera")
    self.skewCam = self.entity:searchEntity("ShearSkewCamera"):getComponent(
                       "Camera")
    self.scaleCam = self.entity:searchEntity("ScaleCamera"):getComponent(
                        "Camera")
    self.blurCam = self.entity:searchEntity("BlurYCamera")
                       :getComponent("Camera")

    self.baseMat = self.entity:searchEntity("BaseMaskPass"):getComponent(
                       "MeshRenderer").material
    self.skewMat = self.entity:searchEntity("ShearSkewPass"):getComponent(
                       "MeshRenderer").material
    self.scaleMat = self.entity:searchEntity("ScalePass"):getComponent(
                        "MeshRenderer").material
    self.blurYMat = self.entity:searchEntity("BlurYPass"):getComponent(
                        "MeshRenderer").material

    self.sharedMaterial = {
        self.baseMat, self.skewMat, self.scaleMat, self.blurYMat
    }

    local w, h = self.OutputTex.width, self.OutputTex.height
    self.tmpTex = createRenderTexture(w, h)
end

function LumiReflect:onUpdate(comp, deltaTime)
    local textureWidth = self.OutputTex.width * self.quality
    local textureHeight = self.OutputTex.height * self.quality
    updateTexSize(self.tmpTex, textureWidth, textureHeight)
    setRenderTexture(self.baseCam, self.tmpTex)
    setRenderTexture(self.skewCam, self.OutputTex)
    setRenderTexture(self.scaleCam, self.tmpTex)
    setRenderTexture(self.blurCam, self.OutputTex)

    self.baseMat:setTex("u_inputTexture", self.InputTex)
    self.skewMat:setTex("u_inputTexture", self.tmpTex)
    self.scaleMat:setTex("u_inputTexture", self.OutputTex)
    self.blurYMat:setTex("u_inputTexture", self.tmpTex)
    self.blurYMat:setTex("u_inputTexture2", self.InputTex)

    local position = Amaz.Vector2f(self.floorPosition.x, self.floorPosition.y)
    local blurType = getBlurType(self.blurType)
    local blendStyle = getBlendType(self.blendStyle)
    local intensityY = self.blurAmount * 10.0
    local xScale, yScale = getXYScale(textureWidth, textureHeight)
    local radiusY = yScale * intensityY / self.normalizationSize
    local sigmaY = radiusY / self.radiusOverSigma
    local sampleNum, downScale = getSampleNum(intensityY)
    local qualityParam = getQualityParam(0.5)
    local sampleY = sampleNum * qualityParam
    local dy = radiusY / math.max(sampleY, self.EPS)
    local lineOffsetY = math.min(math.max(0.5 - position.y, -0.5), 0.5)
    local lineOffsetX = math.min(math.max(position.x - 0.5, -0.5), 0.5)
    local reflectionAngle = math.rad(self.reflectionAngle)
    local blurAmount = self.blurAmount / 100.0
    local blurOffset = self.blurOffset / 100.0
    local maskFalloff = math.max(math.min(position.y, 1.0), 0.01)

    for _, mat in ipairs(self.sharedMaterial) do
        mat:setFloat("u_lineOffsetY", lineOffsetY)
        mat:setFloat("u_lineOffsetX", lineOffsetX)
        mat:setFloat("u_reflectionAngle", reflectionAngle)
        mat:setFloat("u_blurAmount", blurAmount)
        mat:setFloat("u_blurOffset", blurOffset)
        mat:setFloat("u_blurFalloff", self.blurFalloff)
        mat:setInt("u_blurType", blurType)
        mat:setInt("u_blendStyle", blendStyle)
    end
    self.baseMat:setFloat("u_opacity", self.opacity)
    self.baseMat:setVec3("u_tintColor",
                         Amaz.Vector3f(self.tint.r, self.tint.g, self.tint.b))
    self.baseMat:setFloat("u_reflectionDistance", self.reflectionDistance)
    self.baseMat:setFloat("u_fixDistance", 1.0 - position.y)
    self.baseMat:setFloat("u_reflectionFalloff", self.reflectionFalloff)

    self.skewMat:setFloat("u_skew", self.skew)

    self.blurYMat:setFloat("u_gamma", self.gamma)
    self.blurYMat:setFloat("u_sampleY", sampleY)
    self.blurYMat:setFloat("u_sigmaY", sigmaY)
    self.blurYMat:setFloat("u_stepY", dy)
    self.blurYMat:setFloat("u_maskFalloff", maskFalloff)
end

exports.LumiReflect = LumiReflect
return exports
