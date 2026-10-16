local utils = utils or {}
utils.__index = utils

local function isLumiNegativeEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "LumiNegative"
        or (name and string.sub(name, 1, 13) == "LumiNegative_")
end

local function isLumiAdjustEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "LumiAdjust"
        or (name and string.sub(name, 1, 11) == "LumiAdjust_")
end

local function isLumiSGlowEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "LumiSGlow"
        or (name and string.sub(name, 1, 10) == "LumiSGlow_")
end

local function isLumiBrightnessEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "LumiBrightness"
        or (name and string.sub(name, 1, 15) == "LumiBrightness_")
end

local function isLumiMotionBlur2DEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "LumiMotionBlur2D"
        or (name and string.sub(name, 1, 17) == "LumiMotionBlur2D_")
end

local function isLumiGaussianBlurEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "LumiGaussianBlur"
        or (name and string.sub(name, 1, 17) == "LumiGaussianBlur_")
end

local function isLumiDirectionalBlursEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "LumiDirectionalBlurs"
        or (name and string.sub(name, 1, 21) == "LumiDirectionalBlurs_")
end

local function isLumiDropShadowEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "LumiDropShadow"
        or (name and string.sub(name, 1, 15) == "LumiDropShadow_")
end

-- cumCam is a scriptless custom post-effect camera.  Both the scene template
-- and every data-driven clone must stay outside the generic camera traversal.
local function isLumiCumCamEntity(entity)
    if entity == nil then return false end
    local name = entity.name
    return name == "cumCam"
        or (name and string.sub(name, 1, 7) == "cumCam_")
end

local function isLumiPostEffectEntity(entity)
    if entity and entity.name == "afterEffect" then
        return true
    end
    return isLumiNegativeEntity(entity)
        or isLumiAdjustEntity(entity)
        or isLumiSGlowEntity(entity)
        or isLumiBrightnessEntity(entity)
        or isLumiMotionBlur2DEntity(entity)
        or isLumiGaussianBlurEntity(entity)
        or isLumiDirectionalBlursEntity(entity)
        or isLumiDropShadowEntity(entity)
        or isLumiCumCamEntity(entity)
end

local function copyVec3(value)
    return { value[1], value[2], value[3] }
end

-- LumiBlit uses the AE-facing sign convention: X is direct, Y/Z are inverted.
local function eulerToQuaternion(rotation)
    local rx = math.rad(rotation[1])
    local ry = math.rad(-rotation[2])
    local rz = math.rad(-rotation[3])
    local qx = Amaz.Quaternionf.axisAngleToQuaternion(Amaz.Vector3f(1, 0, 0), rx)
    local qy = Amaz.Quaternionf.axisAngleToQuaternion(Amaz.Vector3f(0, 1, 0), ry)
    local qz = Amaz.Quaternionf.axisAngleToQuaternion(Amaz.Vector3f(0, 0, 1), rz)
    return qx * qy * qz
end

-- ============================================================
-- LumiBlit component implementation
-- The ScriptComponent keeps only its public/lifecycle entry points; all
-- camera, data, transform and render-pass work is centralized here.
-- ============================================================

function utils:createLeafCamera(lb, comp, name, outputRT, splitLines)
    local camEntity = comp.entity.scene:cloneEntityFrom(lb.cameraTemplate)
    camEntity.name = name
    table.insert(lb.clonedEntities, camEntity)

    local camTransform = camEntity:getComponent("Transform")
    camTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(camTransform)

    local fatherTrans = camTransform.children:get(0)
    local childTrans = fatherTrans.children:get(0)
    childTrans.entity.name = "pass_" .. name
    local material = childTrans.entity:getComponent("MeshRenderer").material

    lb.nextCloneIndex = lb.nextCloneIndex + 1

    return {
        entity = camEntity,
        camera = camEntity:getComponent("Camera"),
        material = material,
        outputRT = outputRT,
        splitLines = splitLines,
        inputSource = nil,
        translation = { 0.0, 0.0, 0.0 },
        rotation = { 0.0, 0.0, 0.0 },
        selfRotation = { 0.0, 0.0, 0.0 },
        scale = { 1.0, 1.0, 1.0 },
        alpha = 1.0,
        baseTranslation = { 0.0, 0.0, 0.0 },
        baseRotation = { 0.0, 0.0, 0.0 },
        baseSelfRotation = { 0.0, 0.0, 0.0 },
        baseScale = { 1.0, 1.0, 1.0 },
        baseAlpha = 1.0,
        baseDepth = nil,
        anchorType = 1,
        anchorPoint = { 0.5, 0.5, 0.0 },
        depth = nil,
        postEffectTex = outputRT,
        postEffectScratchRT = nil,
        postEffectPassCount = 0,
        blendRT = outputRT,
    }
end

-- A fragment keeps its original camera RT as slot A and lazily allocates one
-- scratch RT as slot B. Every enabled post effect alternates between them, so
-- an arbitrary-length fragment chain never needs more than two external RTs.
function utils:allocateFragmentPostEffectOutput(leafCamera, outputW, outputH)
    leafCamera.postEffectPassCount =
        (leafCamera.postEffectPassCount or 0) + 1
    if leafCamera.postEffectScratchRT == nil then
        leafCamera.postEffectScratchRT =
            self:createRenderTexture(outputW, outputH)
    else
        self:updateTexSize(leafCamera.postEffectScratchRT, outputW, outputH)
    end

    if leafCamera.postEffectPassCount % 2 == 1 then
        return leafCamera.postEffectScratchRT
    end
    return leafCamera.outputRT
end

-- The complete global chain owns only two external RTs: the final OutputTex
-- and one scratch RT. The blend target is selected from the pass-count parity
-- so alternating every pass always leaves the last result in OutputTex.
local function getOrderedGlobalPostEffectPasses(lb)
    local passes = {}
    local function append(passInfo)
        if passInfo then table.insert(passes, passInfo) end
    end
    append(lb.globalAdjustPass)
    append(lb.globalNegativePass)
    append(lb.globalBrightnessPass)
    append(lb.globalMotionBlur2DPass)
    append(lb.globalGaussianBlurPass)
    append(lb.globalDirectionalBlursPass)
    append(lb.globalDropShadowPass)
    append(lb.globalSGlowPass)
    append(lb.globalCumCamPass)
    return passes
end

function utils:prepareGlobalPostEffectPingPong(lb, passCount, outputW, outputH)
    local finalOutputRT = lb.OutputTex or lb.blendCameraOutputTex
    if finalOutputRT == nil then
        finalOutputRT = self:createRenderTexture(outputW, outputH)
        lb.blendCameraOutputTex = finalOutputRT
    end

    lb.globalPingPongPassCount = passCount or 0
    lb.globalPingPongPassIndex = 0
    lb.globalPingPongFinalRT = finalOutputRT

    if lb.globalPingPongPassCount > 0 then
        if lb.globalPingPongScratchRT == nil then
            lb.globalPingPongScratchRT =
                self:createRenderTexture(outputW, outputH)
        else
            self:updateTexSize(lb.globalPingPongScratchRT, outputW, outputH)
        end

        lb.globalPingPongCurrentIsFinal =
            lb.globalPingPongPassCount % 2 == 0
        if lb.globalPingPongCurrentIsFinal then
            lb.globalPingPongCurrentRT = finalOutputRT
        else
            lb.globalPingPongCurrentRT = lb.globalPingPongScratchRT
        end
    else
        lb.globalPingPongCurrentIsFinal = true
        lb.globalPingPongCurrentRT = finalOutputRT
    end

    if lb.blendCam then
        lb.blendCam.renderTexture = lb.globalPingPongCurrentRT
    end
end

function utils:allocateGlobalPostEffectPass(lb)
    local inputRT = lb.globalPingPongCurrentRT
    local outputRT
    if lb.globalPingPongCurrentIsFinal then
        outputRT = lb.globalPingPongScratchRT
    else
        outputRT = lb.globalPingPongFinalRT
    end

    lb.globalPingPongCurrentIsFinal =
        not lb.globalPingPongCurrentIsFinal
    lb.globalPingPongCurrentRT = outputRT
    lb.globalPingPongPassIndex = (lb.globalPingPongPassIndex or 0) + 1
    return inputRT, outputRT
end

-- Rebuild the lightweight RT bindings without recreating entities. This is
-- also called every frame so a host-side OutputTex replacement cannot leave
-- an earlier ping-pong pass referencing the old output object.
function utils:refreshGlobalPostEffectPingPong(lb, outputW, outputH)
    local passes = getOrderedGlobalPostEffectPasses(lb)
    self:prepareGlobalPostEffectPingPong(lb, #passes, outputW, outputH)
    for _, passInfo in ipairs(passes) do
        local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)
        passInfo.inputRT = inputRT
        passInfo.inputTex = inputRT
        passInfo.outputRT = outputRT
    end
end

local function getNegativeConfig(fragmentData)
    if fragmentData == nil then return nil end
    local config = fragmentData.negative
    if config == nil or config == false then return nil end
    if type(config) ~= "table" then
        config = {}
    elseif config.enabled == false then
        return nil
    end
    return config
end

-- LumiBrightness is a single-camera post effect.  Keep the data-facing name
-- separate from SGlow's `brightness` field, while accepting the common
-- brightness/intensity aliases for convenient fragmentsData authoring.
local function getBrightnessField(data)
    if type(data) ~= "table" then return nil end
    if data.brightness ~= nil then return data.brightness end
    if data.Brightness ~= nil then return data.Brightness end
    return data.brightnessEffect
end

local function getBrightnessConfig(fragmentData)
    if fragmentData == nil then return nil end
    local config = getBrightnessField(fragmentData)
    if config == nil or config == false then return nil end
    if type(config) == "number" then
        config = { brightnessIntensity = config }
    elseif type(config) ~= "table" then
        config = {}
    elseif config.enabled == false then
        return nil
    end
    return config
end

local BRIGHTNESS_FIELDS = { "brightnessIntensity" }
local BRIGHTNESS_DEFAULTS = { brightnessIntensity = 0.0 }

local function buildBrightnessValues(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.brightnessIntensity
    if type(value) ~= "number" then value = source.brightness end
    if type(value) ~= "number" then value = source.intensity end
    if type(value) ~= "number" then value = BRIGHTNESS_DEFAULTS.brightnessIntensity end
    return { brightnessIntensity = value }
end

local function copyBrightnessValues(values)
    return {
        brightnessIntensity = values.brightnessIntensity,
    }
end

local function getBrightnessAnimation(config)
    if config == nil then return nil end
    if config.animation then return config.animation end
    return config.animations
end

local function brightnessShaderIntensity(value)
    value = tonumber(value) or BRIGHTNESS_DEFAULTS.brightnessIntensity
    value = math.min(math.max(value, -1.0), 1.0)
    if value > 0.0 and value <= 0.7 then
        return 0.3 * value
    elseif value > 0.7 then
        return 0.6333 * value - 0.2333
    end
    return value
end

local MOTION_BLUR_NUMERIC_FIELDS = {
    "currRotate",
    "prevRotate",
    "vIntensity",
    "vCenter",
    "minSamples",
    "maxSamples",
    "dither",
}

local MOTION_BLUR_VECTOR_FIELDS = {
    "currAnchor",
    "prevAnchor",
    "currPosition",
    "prevPosition",
    "currScale",
    "prevScale",
}

local MOTION_BLUR_DEFAULTS = {
    currRotate = 0.0,
    prevRotate = 0.0,
    currAnchor = { 0.0, 0.0 },
    prevAnchor = { 0.0, 0.0 },
    currPosition = { 0.0, 0.0 },
    prevPosition = { 0.0, 0.0 },
    currScale = { 1.0, 1.0 },
    prevScale = { 1.0, 1.0 },
    vIntensity = 1.0,
    vCenter = 0.0,
    minSamples = 2.0,
    maxSamples = 24.0,
    dither = 1.0,
    unifiedScale = false,
    mirrorEdge = false,
}

local function getMotionBlurField(data)
    if type(data) ~= "table" then return nil end
    if data.motionBlur2D ~= nil then return data.motionBlur2D end
    if data.MotionBlur2D ~= nil then return data.MotionBlur2D end
    if data.motionBlur ~= nil then return data.motionBlur end
    return data.motionblur2d
end

local function getMotionBlurConfig(fragmentData)
    if fragmentData == nil then return nil end
    local config = getMotionBlurField(fragmentData)
    if config == nil or config == false then return nil end
    if config == true then
        config = {}
    elseif type(config) ~= "table" then
        config = {}
    elseif config.enabled == false then
        return nil
    end
    return config
end

local function normalizeMotionBlurVec2(value, fallback)
    if type(value) == "table" then
        return {
            value[1] or value.x or fallback[1],
            value[2] or value.y or fallback[2],
        }
    end
    if type(value) == "userdata" then
        return {
            value.x or fallback[1],
            value.y or fallback[2],
        }
    end
    return { fallback[1], fallback[2] }
end

local function copyMotionBlurValues(values)
    local result = {}
    for _, field in ipairs(MOTION_BLUR_NUMERIC_FIELDS) do
        result[field] = values[field]
    end
    for _, field in ipairs(MOTION_BLUR_VECTOR_FIELDS) do
        local value = values[field]
        result[field] = { value[1], value[2] }
    end
    result.unifiedScale = values.unifiedScale
    result.mirrorEdge = values.mirrorEdge
    return result
end

local function getMotionBlurPositionAspectAdapt(config)
    if type(config) ~= "table" then return nil end
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    return config.positionAspectAdapt
        or source.positionAspectAdapt
        or config.positionDistanceAdapt
        or source.positionDistanceAdapt
end

local function applyMotionBlurPositionAspectAdapt(values, config, outputW, outputH)
    if type(config) ~= "table" or config.enabled == false then return end
    if type(outputW) ~= "number" or type(outputH) ~= "number"
        or outputW <= 0.0 or outputH <= 0.0 then
        return
    end

    local referenceAspect = config.referenceAspect or config.baseAspect
        or (9.0 / 16.0)
    if type(referenceAspect) ~= "number" or referenceAspect <= 0.0 then
        referenceAspect = 9.0 / 16.0
    end

    local strength = config.strength
    if type(strength) ~= "number" then strength = 1.0 end
    local aspectRatio = (outputW / outputH) / referenceAspect
    local distanceScale = 1.0 + (aspectRatio - 1.0) * strength
    if config.wideOnly ~= false then
        distanceScale = math.max(distanceScale, 1.0)
    end

    local minScale = config.minScale
    if type(minScale) ~= "number" then minScale = 0.0 end
    local maxScale = config.maxScale
    if type(maxScale) ~= "number" then maxScale = math.huge end
    distanceScale = math.max(minScale, math.min(distanceScale, maxScale))

    local axis = config.axis or "both"
    for _, field in ipairs({ "currPosition", "prevPosition" }) do
        local position = values[field]
        if type(position) == "table" then
            if axis == "x" or axis == "both" or axis == "xy" then
                position[1] = position[1] * distanceScale
            end
            if axis == "y" or axis == "both" or axis == "xy" then
                position[2] = position[2] * distanceScale
            end
        end
    end
end

-- Convert a direction authored in normalized UV space into the corresponding
-- angle in output-pixel space. A UV line changes its visible angle when the
-- output aspect ratio changes, while DirectionalBlurs and cumCam both consume
-- pixel-space degrees.
local function atan2Compat(y, x)
    if math.atan2 then return math.atan2(y, x) end
    if x > 0.0 then return math.atan(y / x) end
    if x < 0.0 and y >= 0.0 then return math.atan(y / x) + math.pi end
    if x < 0.0 and y < 0.0 then return math.atan(y / x) - math.pi end
    if y > 0.0 then return math.pi * 0.5 end
    if y < 0.0 then return -math.pi * 0.5 end
    return 0.0
end

local function getAngleAspectAdapt(config, primaryField, aliasField)
    if type(config) ~= "table" then return nil end
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    return config[primaryField]
        or source[primaryField]
        or (aliasField and config[aliasField])
        or (aliasField and source[aliasField])
end

local function applyUvDirectionAngle(angle, config, outputW, outputH,
                                    convention)
    if type(config) ~= "table" or config.enabled == false then return angle end
    if type(outputW) ~= "number" or type(outputH) ~= "number"
        or outputW <= 0.0 or outputH <= 0.0 then
        return angle
    end

    local direction = config.uvDirection or config.direction
        or config.tangent
    if type(direction) ~= "table" and type(direction) ~= "userdata" then
        return angle
    end
    local dx, dy
    if type(direction) == "table" then
        dx = direction[1] or direction.x
        dy = direction[2] or direction.y
    else
        dx = direction.x
        dy = direction.y
    end
    if type(dx) ~= "number" or type(dy) ~= "number"
        or (math.abs(dx) < 0.000001 and math.abs(dy) < 0.000001) then
        return angle
    end

    local pixelAngle = math.deg(atan2Compat(dy * outputH, dx * outputW))
    if convention == "directionalBlurs" then
        -- ScriptCompDirectionalBlurs internally evaluates
        -- startAngle = -angle - 90 degrees.
        return -pixelAngle - 90.0
    end
    return pixelAngle
end

local function getMotionBlurAnimation(config)
    if config == nil then return nil end
    if config.animation then return config.animation end
    return config.animations
end

local function motionBlurSourceValue(source, field, fallback)
    local value = source[field]
    if value ~= nil then return value end

    -- The effect's public setter also exposes scale as independent X/Y
    -- channels.  Accept those channels in fragmentsData while retaining the
    -- vector form used by the script properties.
    if field == "currScale" or field == "prevScale" then
        local xField = field == "currScale" and "scale_x" or "ae_pre_scale_x"
        local yField = field == "currScale" and "scale_y" or "ae_pre_scale_y"
        if source[xField] ~= nil or source[yField] ~= nil then
            return {
                source[xField] or fallback[1],
                source[yField] or fallback[2],
            }
        end
    end

    -- Accept the same AE-facing aliases understood by MotionBlur2D.lua.
    local aliases = {
        currRotate = { "rotate" },
        prevRotate = { "ae_pre_rotate" },
        currPosition = { "position" },
        prevPosition = { "ae_pre_position" },
        currAnchor = { "anchor" },
        prevAnchor = { "ae_pre_anchor" },
        currScale = { "scale" },
        prevScale = { "ae_pre_scale" },
    }
    for _, alias in ipairs(aliases[field] or {}) do
        value = source[alias]
        if value ~= nil then
            if field == "currRotate" or field == "prevRotate" then
                return value
            end
            value = normalizeMotionBlurVec2(value, fallback)
            if field == "currPosition" or field == "prevPosition"
                or field == "currAnchor" or field == "prevAnchor" then
                value[1] = value[1] - 0.5
                value[2] = value[2] - 0.5
            end
            return value
        end
    end
    return fallback
end

local function buildMotionBlurValues(config)
    local values = {}
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end

    for _, field in ipairs(MOTION_BLUR_NUMERIC_FIELDS) do
        local value = motionBlurSourceValue(source, field,
            MOTION_BLUR_DEFAULTS[field])
        if type(value) ~= "number" then value = MOTION_BLUR_DEFAULTS[field] end
        values[field] = value
    end
    for _, field in ipairs(MOTION_BLUR_VECTOR_FIELDS) do
        local fallback = MOTION_BLUR_DEFAULTS[field]
        local value = motionBlurSourceValue(source, field, fallback)
        values[field] = normalizeMotionBlurVec2(value, fallback)
    end

    local unifiedScale = source.unifiedScale
    if unifiedScale == nil then unifiedScale = MOTION_BLUR_DEFAULTS.unifiedScale end
    local mirrorEdge = source.mirrorEdge
    if mirrorEdge == nil then mirrorEdge = MOTION_BLUR_DEFAULTS.mirrorEdge end
    values.unifiedScale = unifiedScale == true or unifiedScale == 1
    values.mirrorEdge = mirrorEdge == true or mirrorEdge == 1
    return values
end

-- Defaults mirror effects/LumiGaussianBlur/lua/ScriptCompGaussianBlur.lua.
-- LumiBlit owns only the external InputTex/OutputTex endpoints; the Gaussian
-- script keeps control of its downsample and X/Y blur render textures.
local GAUSSIAN_BLUR_NUMERIC_FIELDS = {
    "blurIntensity",
    "horizontalStrength",
    "verticalStrength",
    "quality",
    "spaceDither",
}

local GAUSSIAN_BLUR_STATIC_FIELDS = {
    "blurDirection",
    "borderType",
    "blurAlpha",
    "inverseGammaCorrection",
}

local GAUSSIAN_BLUR_DEFAULTS = {
    blurIntensity = 0.0,
    horizontalStrength = 1.0,
    verticalStrength = 1.0,
    quality = 0.5,
    spaceDither = 0.0,
    blurDirection = "Horizontal and Vertical",
    borderType = "Normal",
    blurAlpha = true,
    inverseGammaCorrection = true,
}

local function getGaussianBlurField(data)
    if type(data) ~= "table" then return nil end
    if data.gaussianBlur ~= nil then return data.gaussianBlur end
    if data.GaussianBlur ~= nil then return data.GaussianBlur end
    if data.gaussianblur ~= nil then return data.gaussianblur end
    return data.gaussian
end

local function getGaussianBlurConfig(fragmentData)
    if fragmentData == nil then return nil end
    local config = getGaussianBlurField(fragmentData)
    if config == nil or config == false then return nil end
    if type(config) == "number" then
        return { blurIntensity = config }
    end
    if config == true then return {} end
    if type(config) ~= "table" then return {} end
    if config.enabled == false then return nil end
    return config
end

local function normalizeGaussianBlurDirection(value)
    local numericNames = {
        [0] = "Horizontal and Vertical",
        [1] = "Horizontal",
        [2] = "Vertical",
    }
    if type(value) == "number" then value = numericNames[value] end
    if value ~= "Horizontal and Vertical" and value ~= "Horizontal"
        and value ~= "Vertical" then
        value = GAUSSIAN_BLUR_DEFAULTS.blurDirection
    end
    return value
end

local function normalizeGaussianBlurBorderType(value)
    local numericNames = {
        [0] = "Normal",
        [1] = "Replicate",
        [2] = "Black",
        [3] = "Reflect",
    }
    if type(value) == "number" then value = numericNames[value] end
    if value ~= "Normal" and value ~= "Replicate" and value ~= "Black"
        and value ~= "Reflect" then
        value = GAUSSIAN_BLUR_DEFAULTS.borderType
    end
    return value
end

local function normalizeGaussianBlurBool(value, fallback)
    if value == nil then return fallback end
    return value == true or value == 1
end

local function buildGaussianBlurValues(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local values = {}
    for _, field in ipairs(GAUSSIAN_BLUR_NUMERIC_FIELDS) do
        local value = source[field]
        if field == "blurIntensity" and type(value) ~= "number" then
            value = source.intensity
        end
        if type(value) ~= "number" then value = GAUSSIAN_BLUR_DEFAULTS[field] end
        values[field] = value
    end
    values.blurDirection = normalizeGaussianBlurDirection(source.blurDirection)
    values.borderType = normalizeGaussianBlurBorderType(source.borderType)
    values.blurAlpha = normalizeGaussianBlurBool(source.blurAlpha,
        GAUSSIAN_BLUR_DEFAULTS.blurAlpha)
    values.inverseGammaCorrection = normalizeGaussianBlurBool(
        source.inverseGammaCorrection,
        GAUSSIAN_BLUR_DEFAULTS.inverseGammaCorrection)
    return values
end

local function copyGaussianBlurValues(values)
    local result = {}
    for _, field in ipairs(GAUSSIAN_BLUR_NUMERIC_FIELDS) do
        result[field] = values[field]
    end
    for _, field in ipairs(GAUSSIAN_BLUR_STATIC_FIELDS) do
        result[field] = values[field]
    end
    return result
end

local function getGaussianBlurAnimation(config)
    if type(config) ~= "table" then return nil end
    return config.animation or config.animations
end

-- Defaults mirror
-- effects/LumiDirectionalBlurs/lua/ScriptCompDirectionalBlurs.lua.  Its Lua
-- script owns the downsample and per-direction RTs; LumiBlit only connects
-- the external InputTex/OutputTex endpoints.
local DIRECTIONAL_BLURS_NUMERIC_FIELDS = {
    "blurIntensity",
    "angle",
    "directionNum",
    "exposure",
    "quality",
    "spaceDither",
}

local DIRECTIONAL_BLURS_STATIC_FIELDS = {
    "borderType",
    "blendMode",
}

local DIRECTIONAL_BLURS_DEFAULTS = {
    blurIntensity = 0.0,
    angle = 0.0,
    directionNum = 1.0,
    exposure = 1.0,
    quality = 0.5,
    spaceDither = 0.0,
    borderType = "Normal",
    blendMode = "Screen",
}

local function getDirectionalBlursField(data)
    if type(data) ~= "table" then return nil end
    if data.directionalBlurs ~= nil then return data.directionalBlurs end
    if data.DirectionalBlurs ~= nil then return data.DirectionalBlurs end
    if data.directionalBlur ~= nil then return data.directionalBlur end
    if data.directionalblurs ~= nil then return data.directionalblurs end
    return data.directionBlur
end

local function getDirectionalBlursConfig(fragmentData)
    if fragmentData == nil then return nil end
    local config = getDirectionalBlursField(fragmentData)
    if config == nil or config == false then return nil end
    if type(config) == "number" then
        return { blurIntensity = config }
    end
    if config == true then return {} end
    if type(config) ~= "table" then return {} end
    if config.enabled == false then return nil end
    return config
end

local function normalizeDirectionalBlursBorderType(value)
    local numericNames = {
        [0] = "Normal",
        [1] = "Black",
        [2] = "Mirror",
    }
    if type(value) == "number" then value = numericNames[value] end
    if value ~= "Normal" and value ~= "Black" and value ~= "Mirror" then
        value = DIRECTIONAL_BLURS_DEFAULTS.borderType
    end
    return value
end

local function normalizeDirectionalBlursBlendMode(value)
    local numericNames = {
        [0] = "Screen",
        [1] = "Add",
        [2] = "Mean",
    }
    if type(value) == "number" then value = numericNames[value] end
    if value ~= "Screen" and value ~= "Add" and value ~= "Mean" then
        value = DIRECTIONAL_BLURS_DEFAULTS.blendMode
    end
    return value
end

local function buildDirectionalBlursValues(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local values = {}
    for _, field in ipairs(DIRECTIONAL_BLURS_NUMERIC_FIELDS) do
        local value = source[field]
        if field == "blurIntensity" and type(value) ~= "number" then
            value = source.intensity
        end
        if type(value) ~= "number" then
            value = DIRECTIONAL_BLURS_DEFAULTS[field]
        end
        values[field] = value
    end
    values.borderType = normalizeDirectionalBlursBorderType(source.borderType)
    values.blendMode = normalizeDirectionalBlursBlendMode(source.blendMode)
    return values
end

local function copyDirectionalBlursValues(values)
    local result = {}
    for _, field in ipairs(DIRECTIONAL_BLURS_NUMERIC_FIELDS) do
        result[field] = values[field]
    end
    for _, field in ipairs(DIRECTIONAL_BLURS_STATIC_FIELDS) do
        result[field] = values[field]
    end
    return result
end

local function getDirectionalBlursAnimation(config)
    if type(config) ~= "table" then return nil end
    return config.animation or config.animations
end

-- Defaults follow the LumiDropShadow template currently mounted in the scene.
-- Its script retains ownership of the intermediate blur RT.
local DROP_SHADOW_NUMERIC_FIELDS = {
    "shadowOpacity",
    "shadowAngle",
    "shadowDistance",
    "width",
}

local DROP_SHADOW_DEFAULTS = {
    shadowColor = { 1.0, 0.0, 0.0, 1.0 },
    shadowOpacity = 1.0,
    shadowAngle = 135.0,
    shadowDistance = 5.0,
    width = 0.0,
    onlyShadow = true,
}

local function getDropShadowField(data)
    if type(data) ~= "table" then return nil end
    if data.dropShadow ~= nil then return data.dropShadow end
    if data.DropShadow ~= nil then return data.DropShadow end
    if data.dropshadow ~= nil then return data.dropshadow end
    return data.shadow
end

local function getDropShadowConfig(fragmentData)
    if fragmentData == nil then return nil end
    local config = getDropShadowField(fragmentData)
    if config == nil or config == false then return nil end
    if type(config) == "number" then
        return { shadowOpacity = config }
    end
    if config == true then return {} end
    if type(config) ~= "table" then return {} end
    if config.enabled == false then return nil end
    return config
end

local function normalizeDropShadowColor(value, fallback)
    fallback = fallback or DROP_SHADOW_DEFAULTS.shadowColor
    if type(value) == "table" then
        return {
            value[1] or value.r or fallback[1],
            value[2] or value.g or fallback[2],
            value[3] or value.b or fallback[3],
            value[4] or value.a or fallback[4],
        }
    end
    if type(value) == "userdata" then
        return {
            value.r or fallback[1],
            value.g or fallback[2],
            value.b or fallback[3],
            value.a or fallback[4],
        }
    end
    return { fallback[1], fallback[2], fallback[3], fallback[4] }
end

local function buildDropShadowValues(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local values = {
        shadowColor = normalizeDropShadowColor(source.shadowColor),
        maskTex = source.maskTex,
    }
    for _, field in ipairs(DROP_SHADOW_NUMERIC_FIELDS) do
        local value = source[field]
        if type(value) ~= "number" then value = DROP_SHADOW_DEFAULTS[field] end
        values[field] = value
    end
    local onlyShadow = source.onlyShadow
    if onlyShadow == nil then onlyShadow = DROP_SHADOW_DEFAULTS.onlyShadow end
    values.onlyShadow = onlyShadow == true or onlyShadow == 1
    return values
end

local function copyDropShadowValues(values)
    return {
        shadowColor = normalizeDropShadowColor(values.shadowColor),
        shadowOpacity = values.shadowOpacity,
        shadowAngle = values.shadowAngle,
        shadowDistance = values.shadowDistance,
        width = values.width,
        onlyShadow = values.onlyShadow,
        maskTex = values.maskTex,
    }
end

local function getDropShadowAnimation(config)
    if type(config) ~= "table" then return nil end
    return config.animation or config.animations
end

-- cumCam has no Lua component.  Its material controls are read directly from
-- fragmentsData and written to the cloned cumPass material.  Keep one field
-- resolver for fragment and global declarations so both paths enter the same
-- RT chain regardless of the author's casing/alias choice.
local function getCumCamField(data)
    if type(data) ~= "table" then return nil end
    if data.cumCam ~= nil then return data.cumCam end
    if data.CumCam ~= nil then return data.CumCam end
    return data.cumcam
end

local function getCumCamConfig(fragmentData)
    local config = getCumCamField(fragmentData)
    if config == nil or config == false then return nil end
    if config == true then return {} end
    if type(config) ~= "table" then return {} end
    if config.enabled == false then return nil end
    return config
end

local function getCumCamBlackWhiteIntensity(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.blackWhiteIntensity
    if type(value) ~= "number" then value = source.blackWhite end
    if type(value) ~= "number" then value = source.grayscale end
    if type(value) ~= "number" then value = 1.0 end
    return math.min(math.max(value, 0.0), 1.0)
end

-- Contrast is centered at zero in fragmentsData: zero keeps the normal
-- grayscale range, positive values increase separation around middle gray,
-- and negative values flatten it.
local function getCumCamBlackWhiteContrast(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.blackWhiteContrast
    if type(value) ~= "number" then value = source.contrast end
    if type(value) ~= "number" then value = 0.0 end
    return math.min(math.max(value, -1.0), 3.0)
end

local function getCumCamOverlayProgress(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.overlayProgress
    if type(value) ~= "number" then value = source.overlay end
    if type(value) ~= "number" then value = source.expandProgress end
    if type(value) ~= "number" then value = 0.0 end
    return math.min(math.max(value, 0.0), 1.0)
end

local function getCumCamRgbSeparation(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.rgbSeparation
    if type(value) ~= "number" then value = source.rgbSeparationIntensity end
    if type(value) ~= "number" then value = 0.0 end
    return math.max(value, 0.0)
end

local function getCumCamRgbSeparationAngle(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.rgbSeparationAngle
    if type(value) ~= "number" then value = source.separationAngle end
    if type(value) ~= "number" then value = 0.0 end
    return value
end

local function getCumCamTransformRotation(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.transformRotation
    if type(value) ~= "number" then value = source.rotation end
    if type(value) ~= "number" then value = source.rotate end
    if type(value) ~= "number" then value = 0.0 end
    return value
end

local function getCumCamTransformPosition(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.transformPosition
    if value == nil then value = source.position end
    if value == nil then value = source.translation end
    return normalizeMotionBlurVec2(value, { 0.0, 0.0 })
end

local function getCumCamTransformScale(config)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source.transformScale
    if value == nil then value = source.scale end
    if type(value) == "number" then return { value, value } end
    return normalizeMotionBlurVec2(value, { 1.0, 1.0 })
end

local function getCumCamBool(config, field, alias, defaultValue)
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end
    local value = source[field]
    if value == nil and alias then value = source[alias] end
    if value == nil then return defaultValue end
    return value == true or value == 1
end

local function getCumCamAnimation(config)
    if type(config) ~= "table" then return nil end
    return config.animation or config.animations
end

local ADJUST_FIELDS = {
    "brilliance",
    "brightness",
    "contrast",
    "exposure",
    "fade",
    "highlight",
    "lightSensation",
    "saturation",
    "shadow",
    "temperature",
    "tone",
    "vibrance",
}

-- These are the neutral values used by AdjustXT: all color controls are zero,
-- while brilliance is converted to the shader's neutral ins value (0.5).
local ADJUST_DEFAULTS = {
    brilliance = 0.0,
    brightness = 0.0,
    contrast = 0.0,
    exposure = 0.0,
    fade = 0.0,
    highlight = 0.0,
    lightSensation = 0.0,
    saturation = 0.0,
    shadow = 0.0,
    temperature = 0.0,
    tone = 0.0,
    vibrance = 0.0,
}

local function getAdjustConfig(fragmentData)
    if fragmentData == nil then return nil end
    local config = fragmentData.adjust
    if config == nil or config == false then return nil end
    if type(config) ~= "table" then
        config = {}
    elseif config.enabled == false then
        return nil
    end
    return config
end

local function buildAdjustValues(config)
    local values = {}
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then
        source = config
    end
    for _, field in ipairs(ADJUST_FIELDS) do
        local value = source[field]
        if type(value) ~= "number" then
            value = ADJUST_DEFAULTS[field]
        end
        values[field] = value
    end
    return values
end

local function getAdjustAnimation(config)
    if config == nil then return nil end
    if config.animation then return config.animation end
    return config.animations
end

local function setAdjustCameraEnabled(camera)
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end
end

local function copyAdjustValues(values)
    local result = {}
    for _, field in ipairs(ADJUST_FIELDS) do
        result[field] = values[field]
    end
    return result
end

local SGLOW_NUMERIC_FIELDS = {
    "brightness",
    "threshold",
    "glowWidth",
    "widthX",
    "widthY",
    "widthRed",
    "widthGreen",
    "widthBlue",
    "glowFromAlpha",
    "glowUnderSource",
    "sourceOpacity",
    "lightBackground",
    "bgBrightness",
    "quality",
    "dither",
}

local SGLOW_COLOR_FIELDS = {
    "thresholdAddColor",
    "glowColor",
}

local SGLOW_STATIC_FIELDS = {
    "show",
    "combine",
    "edgeMode",
    "bgTexture",
}

-- Defaults mirror effects/LumiSGlow/lua/SGlow.lua.
local SGLOW_DEFAULTS = {
    brightness = 2.0,
    threshold = 0.5,
    thresholdAddColor = { 0.0, 0.0, 0.0, 1.0 },
    glowColor = { 1.0, 1.0, 1.0, 1.0 },
    glowWidth = 0.1,
    widthX = 1.0,
    widthY = 1.0,
    widthRed = 1.0,
    widthGreen = 1.2,
    widthBlue = 1.4,
    combine = "Screen",
    edgeMode = "Reflect",
    glowFromAlpha = 0.0,
    glowUnderSource = 0.0,
    sourceOpacity = 1.0,
    bgTexture = nil,
    lightBackground = 0.0,
    bgBrightness = 1.0,
    show = "Result",
    quality = 0.2,
    dither = 0.0,
}

local function getSGlowField(data)
    if type(data) ~= "table" then return nil end
    if data.sGlow ~= nil then return data.sGlow end
    if data.SGlow ~= nil then return data.SGlow end
    if data.sglow ~= nil then return data.sglow end
    return data.glow
end

local function getSGlowConfig(fragmentData)
    if fragmentData == nil then return nil end
    local config = getSGlowField(fragmentData)
    if config == nil or config == false then return nil end
    if type(config) ~= "table" then
        config = {}
    elseif config.enabled == false then
        return nil
    end
    return config
end

local function getSGlowAnimation(config)
    if config == nil then return nil end
    if config.animation then return config.animation end
    return config.animations
end

local function normalizeSGlowColor(value, fallback)
    if value == nil then
        return { fallback[1], fallback[2], fallback[3], fallback[4] }
    end

    if type(value) == "table" then
        return {
            value[1] or value.r or fallback[1],
            value[2] or value.g or fallback[2],
            value[3] or value.b or fallback[3],
            value[4] or value.a or fallback[4],
        }
    end

    if type(value) == "userdata" then
        return {
            value.r or fallback[1],
            value.g or fallback[2],
            value.b or fallback[3],
            value.a or fallback[4],
        }
    end

    return { fallback[1], fallback[2], fallback[3], fallback[4] }
end

local function buildSGlowValues(config)
    local values = {}
    local source = config.values or config.parameters or config
    if type(source) ~= "table" then source = config end

    for _, field in ipairs(SGLOW_NUMERIC_FIELDS) do
        local value = source[field]
        if type(value) ~= "number" then value = SGLOW_DEFAULTS[field] end
        values[field] = value
    end
    for _, field in ipairs(SGLOW_COLOR_FIELDS) do
        values[field] = normalizeSGlowColor(source[field], SGLOW_DEFAULTS[field])
    end
    for _, field in ipairs(SGLOW_STATIC_FIELDS) do
        local value = source[field]
        if value == nil then value = SGLOW_DEFAULTS[field] end
        values[field] = value
    end
    return values
end

local function copySGlowValues(values)
    local result = {}
    for _, field in ipairs(SGLOW_NUMERIC_FIELDS) do
        result[field] = values[field]
    end
    for _, field in ipairs(SGLOW_COLOR_FIELDS) do
        local value = values[field]
        result[field] = { value[1], value[2], value[3], value[4] }
    end
    for _, field in ipairs(SGLOW_STATIC_FIELDS) do
        result[field] = values[field]
    end
    return result
end

local function toAmazColor(value)
    return Amaz.Color(value[1], value[2], value[3], value[4] or 1.0)
end

function utils:updateAdjustPass(adjustInfo, outputW, outputH, time)
    if adjustInfo == nil then return end

    -- AdjustXT owns the internal three-camera RT wiring.  LumiBlit only
    -- supplies the pass InputTex/OutputTex and the animated controls here.
    local inputTex = adjustInfo.inputTex
    local outputTex = adjustInfo.outputRT
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)
    local values = copyAdjustValues(adjustInfo.values or ADJUST_DEFAULTS)
    local animation = adjustInfo.animation
    if type(animation) == "table" then
        for _, field in ipairs(ADJUST_FIELDS) do
            if animation[field] then
                local animated = self:sampleTrack(animation[field], time or 0.0,
                    values[field])
                if type(animated) == "number" then
                    values[field] = animated
                end
            end
        end
    end
    adjustInfo.currentValues = values

    local scriptComp = adjustInfo.scriptComp
    if adjustInfo.script == nil and scriptComp then
        -- Cloned ScriptComponents may expose their Lua object one frame after
        -- the entity is created.  Resolve it lazily so animated controls are
        -- not lost during that first update.
        adjustInfo.script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end
    if scriptComp and scriptComp.properties then
        scriptComp.properties:set("InputTex", inputTex)
        scriptComp.properties:set("OutputTex", outputTex)
        for _, field in ipairs(ADJUST_FIELDS) do
            scriptComp.properties:set(field, values[field])
        end
    end
    if adjustInfo.script then
        adjustInfo.script.InputTex = inputTex
        adjustInfo.script.OutputTex = outputTex
        for _, field in ipairs(ADJUST_FIELDS) do
            adjustInfo.script[field] = values[field]
        end
    end

    -- Keep the color-map material in sync with the sampled values as well.
    -- This makes nested effect tracks (especially exposure) effective even
    -- when the cloned AdjustXT lifecycle update runs after LumiBlit.
    if adjustInfo.material then
        adjustInfo.material:setFloat("intensityBrightness", values.brightness)
        adjustInfo.material:setFloat("intensityContrast", values.contrast)
        adjustInfo.material:setFloat("intensityExposure", values.exposure)
        adjustInfo.material:setFloat("intensityFade", values.fade)
        adjustInfo.material:setFloat("intensityHighlight", values.highlight)
        adjustInfo.material:setFloat("intensityLightSensation", values.lightSensation)
        adjustInfo.material:setFloat("intensitySaturation", values.saturation)
        adjustInfo.material:setFloat("intensityShadow", values.shadow)
        adjustInfo.material:setFloat("intensityTemperature", values.temperature)
        adjustInfo.material:setFloat("intensityVibrance", values.vibrance)
        adjustInfo.material:setFloat("intensityTone", values.tone)
    end
    if adjustInfo.splendorMaterial then
        adjustInfo.splendorMaterial:setFloat("ins", values.brilliance * 0.5 + 0.5)
    end
    if adjustInfo.script and adjustInfo.script.updateMaterial then
        -- Let AdjustXT apply the same values through its native material path.
        -- Its internal camera/RT wiring remains owned by AdjustXT itself.
        adjustInfo.script:updateMaterial()
    end
end

function utils:updateAdjustPasses(lb, outputW, outputH)
    for _, adjustInfo in ipairs(lb.adjustPasses or {}) do
        self:updateAdjustPass(adjustInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalAdjustPass then
        self:updateAdjustPass(lb.globalAdjustPass, outputW, outputH, lb.u_time)
    end
end

local function getEntityCamera(entity, childName)
    local child = entity and entity:searchEntity(childName)
    return child and child:getComponent("Camera")
end

function utils:createAdjustPass(lb, comp, leafCamera, fragmentData, index,
                                outputW, outputH)
    local config = getAdjustConfig(fragmentData)
    if config == nil or lb.LumiAdjust == nil then
        return nil
    end

    local adjustEntity = comp.entity.scene:cloneEntityFrom(lb.LumiAdjust)
    adjustEntity.name = "LumiAdjust_" .. (leafCamera.leafKey or tostring(index))
    adjustEntity.visible = true
    table.insert(lb.clonedEntities, adjustEntity)

    local adjustTransform = adjustEntity:getComponent("Transform")
    adjustTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(adjustTransform)

    local cameraMap = getEntityCamera(adjustEntity, "Camera_entity_map")
    local camera2 = getEntityCamera(adjustEntity, "Camera_entity")
    local camera3 = getEntityCamera(adjustEntity, "Camera_entity_3")
    local mapRenderer = adjustEntity:searchEntity("map_renderer")
    local splendorRenderer = adjustEntity:searchEntity("splendor_renderer")
    setAdjustCameraEnabled(cameraMap)
    setAdjustCameraEnabled(camera2)
    setAdjustCameraEnabled(camera3)

    local scriptComp = adjustEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local adjustInfo = {
        entity = adjustEntity,
        cameraMap = cameraMap,
        camera2 = camera2,
        camera3 = camera3,
        cameras = { cameraMap, camera2, camera3 },
        material = mapRenderer and mapRenderer:getComponent("MeshRenderer").material,
        splendorMaterial = splendorRenderer
            and splendorRenderer:getComponent("MeshRenderer").material,
        scriptComp = scriptComp,
        script = script,
        inputTex = inputTex,
        outputRT = outputRT,
        values = buildAdjustValues(config),
        animation = getAdjustAnimation(config),
        fragmentData = fragmentData,
    }
    leafCamera.postEffectTex = adjustInfo.outputRT
    leafCamera.adjustPass = adjustInfo
    leafCamera.blendRT = adjustInfo.outputRT
    table.insert(lb.adjustPasses, adjustInfo)

    self:updateAdjustPass(adjustInfo, outputW, outputH, 0.0)
    return adjustInfo
end

function utils:createGlobalAdjustPass(lb, comp, config, outputW, outputH,
                                      hasNextEffect)
    config = getAdjustConfig({ adjust = config })
    if config == nil or lb.LumiAdjust == nil then
        return nil
    end

    local adjustEntity = comp.entity.scene:cloneEntityFrom(lb.LumiAdjust)
    adjustEntity.name = "LumiAdjust_Global"
    adjustEntity.visible = true
    table.insert(lb.clonedEntities, adjustEntity)

    local adjustTransform = adjustEntity:getComponent("Transform")
    adjustTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(adjustTransform)

    local cameraMap = getEntityCamera(adjustEntity, "Camera_entity_map")
    local camera2 = getEntityCamera(adjustEntity, "Camera_entity")
    local camera3 = getEntityCamera(adjustEntity, "Camera_entity_3")
    local mapRenderer = adjustEntity:searchEntity("map_renderer")
    local splendorRenderer = adjustEntity:searchEntity("splendor_renderer")
    setAdjustCameraEnabled(cameraMap)
    setAdjustCameraEnabled(camera2)
    setAdjustCameraEnabled(camera3)

    local scriptComp = adjustEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)

    local adjustInfo = {
        entity = adjustEntity,
        cameraMap = cameraMap,
        camera2 = camera2,
        camera3 = camera3,
        cameras = { cameraMap, camera2, camera3 },
        material = mapRenderer and mapRenderer:getComponent("MeshRenderer").material,
        splendorMaterial = splendorRenderer
            and splendorRenderer:getComponent("MeshRenderer").material,
        scriptComp = scriptComp,
        script = script,
        inputRT = inputRT,
        outputRT = outputRT,
        values = buildAdjustValues(config),
        animation = getAdjustAnimation(config),
        isGlobal = true,
    }
    adjustInfo.inputTex = adjustInfo.inputRT
    lb.globalAdjustPass = adjustInfo

    self:updateAdjustPass(adjustInfo, outputW, outputH, 0.0)
    return adjustInfo
end

function utils:updateNegativePass(negativeInfo, outputW, outputH, time)
    if negativeInfo == nil then return end

    local inputTex = negativeInfo.inputTex
    if inputTex == nil and negativeInfo.leafCamera then
        inputTex = negativeInfo.leafCamera.outputRT
    end
    local outputTex = negativeInfo.outputRT
    local alpha = negativeInfo.alpha
    if negativeInfo.alphaAnimation then
        alpha = self:sampleTrack(negativeInfo.alphaAnimation, time or 0.0, alpha)
    end
    negativeInfo.currentAlpha = alpha
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)
    local scriptComp = negativeInfo.scriptComp
    if scriptComp and scriptComp.properties then
        scriptComp.properties:set("InputTex", inputTex)
        scriptComp.properties:set("OutputTex", outputTex)
        scriptComp.properties:set("negativeAlpha", alpha)
    end

    -- Keep the Lua object and render components in sync immediately;
    -- AdjustNegative:onUpdate consumes these same property values.
    if negativeInfo.script then
        negativeInfo.script.InputTex = inputTex
        negativeInfo.script.OutputTex = outputTex
        negativeInfo.script.negativeAlpha = alpha
    end
    if negativeInfo.camera then
        negativeInfo.camera.renderTexture = outputTex
    end
    if negativeInfo.material then
        negativeInfo.material:setTex("u_inputTex", inputTex)
        negativeInfo.material:setFloat("u_negativeAlpha", alpha)
    end
end

function utils:updateNegativePasses(lb, outputW, outputH)
    for _, negativeInfo in ipairs(lb.negativePasses or {}) do
        self:updateNegativePass(negativeInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalNegativePass then
        self:updateNegativePass(lb.globalNegativePass, outputW, outputH, lb.u_time)
    end
end

function utils:updateBrightnessPass(brightnessInfo, outputW, outputH, time)
    if brightnessInfo == nil then return end

    local inputTex = brightnessInfo.inputTex
    if inputTex == nil and brightnessInfo.leafCamera then
        inputTex = brightnessInfo.leafCamera.outputRT
    end
    local outputTex = brightnessInfo.outputRT
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)
    local values = copyBrightnessValues(
        brightnessInfo.values or BRIGHTNESS_DEFAULTS)
    local animation = brightnessInfo.animation
    if type(animation) == "table" then
        local track = animation.brightnessIntensity
            or animation.brightness
            or animation.intensity
        if track == nil and #animation > 0 then track = animation end
        if track then
            local animated = self:sampleTrack(track, time or 0.0,
                values.brightnessIntensity)
            if type(animated) == "number" then
                values.brightnessIntensity = animated
            end
        end
    end
    values.brightnessIntensity = math.min(math.max(
        tonumber(values.brightnessIntensity) or 0.0, -1.0), 1.0)
    brightnessInfo.currentValues = values

    local scriptComp = brightnessInfo.scriptComp
    if brightnessInfo.script == nil and scriptComp then
        brightnessInfo.script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end
    if scriptComp and scriptComp.properties then
        scriptComp.properties:set("InputTex", inputTex)
        scriptComp.properties:set("OutputTex", outputTex)
        scriptComp.properties:set("brightnessIntensity", values.brightnessIntensity)
    end
    if brightnessInfo.script then
        brightnessInfo.script.InputTex = inputTex
        brightnessInfo.script.OutputTex = outputTex
        brightnessInfo.script.brightnessIntensity = values.brightnessIntensity
    end
    if brightnessInfo.camera then
        brightnessInfo.camera.renderTexture = outputTex
    end
    if brightnessInfo.material then
        brightnessInfo.material:setTex("u_inputTexture", inputTex)
        brightnessInfo.material:setFloat("u_intensity",
            brightnessShaderIntensity(values.brightnessIntensity))
    end
end

function utils:updateBrightnessPasses(lb, outputW, outputH)
    for _, brightnessInfo in ipairs(lb.brightnessPasses or {}) do
        self:updateBrightnessPass(brightnessInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalBrightnessPass then
        self:updateBrightnessPass(lb.globalBrightnessPass, outputW, outputH,
            lb.u_time)
    end
end

local function setMotionBlurVec2Vector(material, uniformName, values)
    local vector = Amaz.Vec2Vector()
    for _, value in ipairs(values) do
        vector:pushBack(Amaz.Vector2f(value[1], value[2]))
    end
    material:setVec2Vector(uniformName, vector)
end

local function setMotionBlurFloatVector(material, uniformName, values)
    local vector = Amaz.FloatVector()
    for _, value in ipairs(values) do
        vector:pushBack(value)
    end
    material:setFloatVector(uniformName, vector)
end

local function updateMotionBlurMaterial(material, values, outputW, outputH)
    if material == nil then return end

    -- MotionBlur2D's affine transform is aspect-aware.  The standalone
    -- material receives this built-in from the host, but cloned passes are
    -- driven directly by LumiBlit, so keep the uniform explicit and in sync
    -- with the current output size.
    if outputW and outputH and outputW > 0 and outputH > 0 then
        material:setVec4("u_ScreenParams", Amaz.Vector4f(
            outputW, outputH, outputW / outputH, outputH / outputW))
    end

    local pivotValues = {}
    local positionValues = {}
    local scaleValues = {}
    local rotationValues = {}
    for index = 0, 5 do
        local weight = values.vIntensity * (index / 5.0) + values.vCenter + 1.0
        local pivot = {
            values.prevAnchor[1] * (1.0 - weight)
                + values.currAnchor[1] * weight,
            values.prevAnchor[2] * (1.0 - weight)
                + values.currAnchor[2] * weight,
        }
        local position = {
            values.prevPosition[1] * (1.0 - weight)
                + values.currPosition[1] * weight,
            values.prevPosition[2] * (1.0 - weight)
                + values.currPosition[2] * weight,
        }
        local scale = {
            values.prevScale[1] * (1.0 - weight)
                + values.currScale[1] * weight,
            values.prevScale[2] * (1.0 - weight)
                + values.currScale[2] * weight,
        }
        if values.unifiedScale then scale[2] = scale[1] end
        table.insert(pivotValues, pivot)
        table.insert(positionValues, position)
        table.insert(scaleValues, scale)
        table.insert(rotationValues,
            values.prevRotate * (1.0 - weight) + values.currRotate * weight)
    end

    setMotionBlurVec2Vector(material, "u_pivotVec2Vector", pivotValues)
    setMotionBlurVec2Vector(material, "u_positionVec2Vector", positionValues)
    setMotionBlurVec2Vector(material, "u_scaleVec2Vector", scaleValues)
    setMotionBlurFloatVector(material, "u_rotationFloatVector", rotationValues)
    material:setFloat("u_minSamples", values.minSamples)
    material:setFloat("u_maxSamples", values.maxSamples)
    material:setFloat("u_dither", values.dither)
    material:setFloat("u_mirrorEdge", values.mirrorEdge and 1.0 or 0.0)
    material:setInt("u_skipSample", math.abs(values.vIntensity) < 0.001 and 1 or 0)
end

function utils:updateMotionBlur2DPass(motionInfo, outputW, outputH, time)
    if motionInfo == nil then return end

    local inputTex = motionInfo.inputTex
    if inputTex == nil and motionInfo.leafCamera then
        inputTex = motionInfo.leafCamera.outputRT
    end
    local outputTex = motionInfo.outputRT
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)
    local values = copyMotionBlurValues(
        motionInfo.values or MOTION_BLUR_DEFAULTS)
    local animation = motionInfo.animation
    if type(animation) == "table" then
        local aliases = {
            rotate = "currRotate",
            position = "currPosition",
            anchor = "currAnchor",
            scale = "currScale",
            ae_pre_rotate = "prevRotate",
            ae_pre_position = "prevPosition",
            ae_pre_anchor = "prevAnchor",
            ae_pre_scale = "prevScale",
        }
        for _, field in ipairs(MOTION_BLUR_NUMERIC_FIELDS) do
            local track = animation[field]
            if track == nil then
                for alias, mappedField in pairs(aliases) do
                    if mappedField == field then track = animation[alias] end
                end
            end
            if track then
                local animated = self:sampleTrack(track, time or 0.0, values[field])
                if type(animated) == "number" then values[field] = animated end
            end
        end
        for _, field in ipairs(MOTION_BLUR_VECTOR_FIELDS) do
            local track = animation[field]
            if track == nil then
                for alias, mappedField in pairs(aliases) do
                    if mappedField == field then track = animation[alias] end
                end
            end
            if track then
                local animated = self:sampleTrack(track, time or 0.0, values[field])
                if type(animated) == "table" or type(animated) == "userdata" then
                    values[field] = normalizeMotionBlurVec2(animated, values[field])
                end
            end
        end
    end
    applyMotionBlurPositionAspectAdapt(values, motionInfo.positionAspectAdapt,
        outputW, outputH)
    motionInfo.currentValues = values

    local scriptComp = motionInfo.scriptComp
    if motionInfo.script == nil and scriptComp then
        motionInfo.script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end
    if scriptComp and scriptComp.properties then
        local props = scriptComp.properties
        props:set("InputTex", inputTex)
        props:set("OutputTex", outputTex)
        for _, field in ipairs(MOTION_BLUR_NUMERIC_FIELDS) do
            props:set(field, values[field])
        end
        for _, field in ipairs(MOTION_BLUR_VECTOR_FIELDS) do
            props:set(field, Amaz.Vector2f(values[field][1], values[field][2]))
        end
        props:set("unifiedScale", values.unifiedScale)
        props:set("mirrorEdge", values.mirrorEdge)
    end
    if motionInfo.script then
        motionInfo.script.InputTex = inputTex
        motionInfo.script.OutputTex = outputTex
        for _, field in ipairs(MOTION_BLUR_NUMERIC_FIELDS) do
            motionInfo.script[field] = values[field]
        end
        for _, field in ipairs(MOTION_BLUR_VECTOR_FIELDS) do
            motionInfo.script[field] = Amaz.Vector2f(values[field][1], values[field][2])
        end
        motionInfo.script.unifiedScale = values.unifiedScale
        motionInfo.script.mirrorEdge = values.mirrorEdge
    end
    if motionInfo.camera then
        motionInfo.camera.renderTexture = outputTex
    end
    if motionInfo.material then
        motionInfo.material:setTex("u_inputImageTexture", inputTex)
        updateMotionBlurMaterial(motionInfo.material, values, outputW, outputH)
    end
end

function utils:updateMotionBlur2DPasses(lb, outputW, outputH)
    for _, motionInfo in ipairs(lb.motionBlur2DPasses or {}) do
        self:updateMotionBlur2DPass(motionInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalMotionBlur2DPass then
        self:updateMotionBlur2DPass(lb.globalMotionBlur2DPass, outputW, outputH,
            lb.u_time)
    end
end

local function setGaussianBlurCameraEnabled(camera)
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end
end

local function getGaussianBlurCameras(entity)
    local result = {
        downScale = getEntityCamera(entity, "CameraDownScale"),
        horizontal = getEntityCamera(entity, "CameraGaussianBlurX"),
        vertical = getEntityCamera(entity, "CameraGaussianBlurY"),
        upScale = getEntityCamera(entity, "CameraUpScale"),
        ordered = {},
    }
    for _, key in ipairs({ "downScale", "horizontal", "vertical", "upScale" }) do
        local camera = result[key]
        if camera then
            setGaussianBlurCameraEnabled(camera)
            table.insert(result.ordered, camera)
        end
    end
    return result
end

function utils:updateGaussianBlurPass(blurInfo, outputW, outputH, time)
    if blurInfo == nil then return end

    local inputTex = blurInfo.inputTex
    if inputTex == nil and blurInfo.leafCamera then
        inputTex = blurInfo.leafCamera.outputRT
    end
    local outputTex = blurInfo.outputRT
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)

    local values = copyGaussianBlurValues(
        blurInfo.values or GAUSSIAN_BLUR_DEFAULTS)
    local animation = blurInfo.animation
    if type(animation) == "table" then
        for _, field in ipairs(GAUSSIAN_BLUR_NUMERIC_FIELDS) do
            local track = animation[field]
            if field == "blurIntensity" and track == nil then
                track = animation.intensity
            end
            if track then
                local animated = self:sampleTrack(track, time or 0.0, values[field])
                if type(animated) == "number" then values[field] = animated end
            end
        end
    end

    values.blurIntensity = math.min(math.max(values.blurIntensity, 0.0), 1000.0)
    values.horizontalStrength = math.min(math.max(
        values.horizontalStrength, 0.0), 1.0)
    values.verticalStrength = math.min(math.max(
        values.verticalStrength, 0.0), 1.0)
    values.quality = math.min(math.max(values.quality, 0.0), 1.0)
    values.spaceDither = math.min(math.max(values.spaceDither, 0.0), 1.0)
    blurInfo.currentValues = values

    local scriptComp = blurInfo.scriptComp
    if blurInfo.script == nil and scriptComp then
        blurInfo.script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end
    if scriptComp and scriptComp.properties then
        local props = scriptComp.properties
        props:set("InputTex", inputTex)
        props:set("OutputTex", outputTex)
        for _, field in ipairs(GAUSSIAN_BLUR_NUMERIC_FIELDS) do
            props:set(field, values[field])
        end
        for _, field in ipairs(GAUSSIAN_BLUR_STATIC_FIELDS) do
            props:set(field, values[field])
        end
    end
    if blurInfo.script then
        blurInfo.script.InputTex = inputTex
        blurInfo.script.OutputTex = outputTex
        for _, field in ipairs(GAUSSIAN_BLUR_NUMERIC_FIELDS) do
            blurInfo.script[field] = values[field]
        end
        for _, field in ipairs(GAUSSIAN_BLUR_STATIC_FIELDS) do
            blurInfo.script[field] = values[field]
        end
    end
end

function utils:updateGaussianBlurPasses(lb, outputW, outputH)
    for _, blurInfo in ipairs(lb.gaussianBlurPasses or {}) do
        self:updateGaussianBlurPass(blurInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalGaussianBlurPass then
        self:updateGaussianBlurPass(lb.globalGaussianBlurPass, outputW, outputH,
            lb.u_time)
    end
end

function utils:createGaussianBlurPass(lb, comp, leafCamera, fragmentData, index,
                                      outputW, outputH)
    local config = getGaussianBlurConfig(fragmentData)
    if config == nil or lb.LumiGaussianBlur == nil then return nil end

    local blurEntity = comp.entity.scene:cloneEntityFrom(lb.LumiGaussianBlur)
    blurEntity.name = "LumiGaussianBlur_" ..
        (leafCamera.leafKey or tostring(index))
    blurEntity.visible = true
    table.insert(lb.clonedEntities, blurEntity)

    local blurTransform = blurEntity:getComponent("Transform")
    blurTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(blurTransform)

    local blurCameras = getGaussianBlurCameras(blurEntity)
    local scriptComp = blurEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local blurInfo = {
        entity = blurEntity,
        cameras = blurCameras.ordered,
        downScaleCamera = blurCameras.downScale,
        horizontalCamera = blurCameras.horizontal,
        verticalCamera = blurCameras.vertical,
        upScaleCamera = blurCameras.upScale,
        scriptComp = scriptComp,
        script = script,
        leafCamera = leafCamera,
        inputTex = inputTex,
        outputRT = outputRT,
        values = buildGaussianBlurValues(config),
        animation = getGaussianBlurAnimation(config),
        fragmentData = fragmentData,
    }
    leafCamera.gaussianBlurPass = blurInfo
    leafCamera.postEffectTex = blurInfo.outputRT
    leafCamera.blendRT = blurInfo.outputRT
    table.insert(lb.gaussianBlurPasses, blurInfo)

    self:updateGaussianBlurPass(blurInfo, outputW, outputH, 0.0)
    return blurInfo
end

function utils:createGlobalGaussianBlurPass(lb, comp, config, outputW, outputH,
                                            hasNextEffect)
    config = getGaussianBlurConfig({ gaussianBlur = config })
    if config == nil or lb.LumiGaussianBlur == nil then return nil end

    local blurEntity = comp.entity.scene:cloneEntityFrom(lb.LumiGaussianBlur)
    blurEntity.name = "LumiGaussianBlur_Global"
    blurEntity.visible = true
    table.insert(lb.clonedEntities, blurEntity)

    local blurTransform = blurEntity:getComponent("Transform")
    blurTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(blurTransform)

    local blurCameras = getGaussianBlurCameras(blurEntity)
    local scriptComp = blurEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)
    local blurInfo = {
        entity = blurEntity,
        cameras = blurCameras.ordered,
        downScaleCamera = blurCameras.downScale,
        horizontalCamera = blurCameras.horizontal,
        verticalCamera = blurCameras.vertical,
        upScaleCamera = blurCameras.upScale,
        scriptComp = scriptComp,
        script = script,
        inputRT = inputRT,
        inputTex = inputRT,
        outputRT = outputRT,
        values = buildGaussianBlurValues(config),
        animation = getGaussianBlurAnimation(config),
        isGlobal = true,
    }
    lb.globalGaussianBlurPass = blurInfo

    self:updateGaussianBlurPass(blurInfo, outputW, outputH, 0.0)
    return blurInfo
end

local function setDirectionalBlursCameraEnabled(camera)
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end
end

local function getDirectionalBlursCameras(entity)
    local result = {
        downScale = getEntityCamera(entity, "CameraDownScale"),
        blurCameras = {},
        blend = getEntityCamera(entity, "CameraBlend"),
        ordered = {},
    }
    if result.downScale then
        setDirectionalBlursCameraEnabled(result.downScale)
        table.insert(result.ordered, result.downScale)
    end
    for index = 1, 4 do
        local camera = getEntityCamera(entity,
            "CameraDirectionalBlurs_" .. tostring(index))
        result.blurCameras[index] = camera
        if camera then
            setDirectionalBlursCameraEnabled(camera)
            table.insert(result.ordered, camera)
        end
    end
    if result.blend then
        setDirectionalBlursCameraEnabled(result.blend)
        table.insert(result.ordered, result.blend)
    end
    return result
end

function utils:updateDirectionalBlursPass(blurInfo, outputW, outputH, time)
    if blurInfo == nil then return end

    local inputTex = blurInfo.inputTex
    if inputTex == nil and blurInfo.leafCamera then
        inputTex = blurInfo.leafCamera.outputRT
    end
    local outputTex = blurInfo.outputRT
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)

    local values = copyDirectionalBlursValues(
        blurInfo.values or DIRECTIONAL_BLURS_DEFAULTS)
    local animation = blurInfo.animation
    if type(animation) == "table" then
        for _, field in ipairs(DIRECTIONAL_BLURS_NUMERIC_FIELDS) do
            local track = animation[field]
            if field == "blurIntensity" and track == nil then
                track = animation.intensity
            end
            if track then
                local animated = self:sampleTrack(track, time or 0.0, values[field])
                if type(animated) == "number" then values[field] = animated end
            end
        end
    end

    values.angle = applyUvDirectionAngle(values.angle,
        blurInfo.angleAspectAdapt, outputW, outputH, "directionalBlurs")

    values.blurIntensity = math.min(math.max(values.blurIntensity, 0.0), 1000.0)
    values.directionNum = math.min(math.max(values.directionNum, 1.0), 4.0)
    values.exposure = math.min(math.max(values.exposure, 0.0), 10.0)
    values.quality = math.min(math.max(values.quality, 0.0), 1.0)
    values.spaceDither = math.min(math.max(values.spaceDither, 0.0), 1.0)
    blurInfo.currentValues = values

    local scriptComp = blurInfo.scriptComp
    if blurInfo.script == nil and scriptComp then
        blurInfo.script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end
    if scriptComp and scriptComp.properties then
        local props = scriptComp.properties
        props:set("InputTex", inputTex)
        props:set("OutputTex", outputTex)
        for _, field in ipairs(DIRECTIONAL_BLURS_NUMERIC_FIELDS) do
            props:set(field, values[field])
        end
        for _, field in ipairs(DIRECTIONAL_BLURS_STATIC_FIELDS) do
            props:set(field, values[field])
        end
    end
    if blurInfo.script then
        blurInfo.script.InputTex = inputTex
        blurInfo.script.OutputTex = outputTex
        for _, field in ipairs(DIRECTIONAL_BLURS_NUMERIC_FIELDS) do
            blurInfo.script[field] = values[field]
        end
        for _, field in ipairs(DIRECTIONAL_BLURS_STATIC_FIELDS) do
            blurInfo.script[field] = values[field]
        end
    end
end

function utils:updateDirectionalBlursPasses(lb, outputW, outputH)
    for _, blurInfo in ipairs(lb.directionalBlursPasses or {}) do
        self:updateDirectionalBlursPass(blurInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalDirectionalBlursPass then
        self:updateDirectionalBlursPass(lb.globalDirectionalBlursPass, outputW,
            outputH, lb.u_time)
    end
end

function utils:createDirectionalBlursPass(lb, comp, leafCamera, fragmentData,
                                          index, outputW, outputH)
    local config = getDirectionalBlursConfig(fragmentData)
    if config == nil or lb.LumiDirectionalBlurs == nil then return nil end

    local blurEntity = comp.entity.scene:cloneEntityFrom(lb.LumiDirectionalBlurs)
    blurEntity.name = "LumiDirectionalBlurs_" ..
        (leafCamera.leafKey or tostring(index))
    blurEntity.visible = true
    table.insert(lb.clonedEntities, blurEntity)

    local blurTransform = blurEntity:getComponent("Transform")
    blurTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(blurTransform)

    local blurCameras = getDirectionalBlursCameras(blurEntity)
    local scriptComp = blurEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local blurInfo = {
        entity = blurEntity,
        cameras = blurCameras.ordered,
        downScaleCamera = blurCameras.downScale,
        blurCameras = blurCameras.blurCameras,
        blendCamera = blurCameras.blend,
        scriptComp = scriptComp,
        script = script,
        leafCamera = leafCamera,
        inputTex = inputTex,
        outputRT = outputRT,
        values = buildDirectionalBlursValues(config),
        animation = getDirectionalBlursAnimation(config),
        angleAspectAdapt = getAngleAspectAdapt(config,
            "angleAspectAdapt", "directionAspectAdapt"),
        fragmentData = fragmentData,
    }
    leafCamera.directionalBlursPass = blurInfo
    leafCamera.postEffectTex = blurInfo.outputRT
    leafCamera.blendRT = blurInfo.outputRT
    table.insert(lb.directionalBlursPasses, blurInfo)

    self:updateDirectionalBlursPass(blurInfo, outputW, outputH, 0.0)
    return blurInfo
end

function utils:createGlobalDirectionalBlursPass(lb, comp, config, outputW,
                                                outputH, hasNextEffect)
    config = getDirectionalBlursConfig({ directionalBlurs = config })
    if config == nil or lb.LumiDirectionalBlurs == nil then return nil end

    local blurEntity = comp.entity.scene:cloneEntityFrom(lb.LumiDirectionalBlurs)
    blurEntity.name = "LumiDirectionalBlurs_Global"
    blurEntity.visible = true
    table.insert(lb.clonedEntities, blurEntity)

    local blurTransform = blurEntity:getComponent("Transform")
    blurTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(blurTransform)

    local blurCameras = getDirectionalBlursCameras(blurEntity)
    local scriptComp = blurEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)

    local blurInfo = {
        entity = blurEntity,
        cameras = blurCameras.ordered,
        downScaleCamera = blurCameras.downScale,
        blurCameras = blurCameras.blurCameras,
        blendCamera = blurCameras.blend,
        scriptComp = scriptComp,
        script = script,
        inputRT = inputRT,
        inputTex = inputRT,
        outputRT = outputRT,
        values = buildDirectionalBlursValues(config),
        animation = getDirectionalBlursAnimation(config),
        angleAspectAdapt = getAngleAspectAdapt(config,
            "angleAspectAdapt", "directionAspectAdapt"),
        isGlobal = true,
    }
    lb.globalDirectionalBlursPass = blurInfo

    self:updateDirectionalBlursPass(blurInfo, outputW, outputH, 0.0)
    return blurInfo
end

local function setDropShadowCameraEnabled(camera)
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end
end

local function getDropShadowCameras(entity)
    local result = {
        input = getEntityCamera(entity, "CameraInput"),
        horizontal = getEntityCamera(entity, "CameraBlurX"),
        vertical = getEntityCamera(entity, "CameraBlurY"),
        light = getEntityCamera(entity, "CameraLight"),
        ordered = {},
    }
    for _, key in ipairs({ "input", "horizontal", "vertical", "light" }) do
        local camera = result[key]
        if camera then
            setDropShadowCameraEnabled(camera)
            table.insert(result.ordered, camera)
        end
    end
    return result
end

function utils:updateDropShadowPass(shadowInfo, outputW, outputH, time)
    if shadowInfo == nil then return end

    local inputTex = shadowInfo.inputTex
    if inputTex == nil and shadowInfo.leafCamera then
        inputTex = shadowInfo.leafCamera.outputRT
    end
    local outputTex = shadowInfo.outputRT
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)

    local values = copyDropShadowValues(
        shadowInfo.values or DROP_SHADOW_DEFAULTS)
    local animation = shadowInfo.animation
    if type(animation) == "table" then
        for _, field in ipairs(DROP_SHADOW_NUMERIC_FIELDS) do
            local track = animation[field]
            if track then
                local animated = self:sampleTrack(track, time or 0.0, values[field])
                if type(animated) == "number" then values[field] = animated end
            end
        end
        if animation.shadowColor then
            local animated = self:sampleTrack(animation.shadowColor,
                time or 0.0, values.shadowColor)
            values.shadowColor = normalizeDropShadowColor(animated,
                values.shadowColor)
        end
    end

    values.shadowOpacity = math.min(math.max(values.shadowOpacity, 0.0), 1.0)
    values.shadowAngle = math.min(math.max(values.shadowAngle, -360.0), 360.0)
    values.shadowDistance = math.min(math.max(values.shadowDistance, 0.0), 10000.0)
    values.width = math.min(math.max(values.width, 0.0), 10000.0)
    shadowInfo.currentValues = values

    local scriptComp = shadowInfo.scriptComp
    if shadowInfo.script == nil and scriptComp then
        shadowInfo.script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end
    if scriptComp and scriptComp.properties then
        local props = scriptComp.properties
        props:set("InputTex", inputTex)
        props:set("OutputTex", outputTex)
        props:set("shadowColor", toAmazColor(values.shadowColor))
        for _, field in ipairs(DROP_SHADOW_NUMERIC_FIELDS) do
            props:set(field, values[field])
        end
        props:set("onlyShadow", values.onlyShadow)
        if values.maskTex ~= nil then props:set("maskTex", values.maskTex) end
    end
    if shadowInfo.script then
        shadowInfo.script.InputTex = inputTex
        shadowInfo.script.OutputTex = outputTex
        shadowInfo.script.shadowColor = toAmazColor(values.shadowColor)
        for _, field in ipairs(DROP_SHADOW_NUMERIC_FIELDS) do
            shadowInfo.script[field] = values[field]
        end
        shadowInfo.script.onlyShadow = values.onlyShadow
        if values.maskTex ~= nil then shadowInfo.script.maskTex = values.maskTex end
    end
end

function utils:updateDropShadowPasses(lb, outputW, outputH)
    for _, shadowInfo in ipairs(lb.dropShadowPasses or {}) do
        self:updateDropShadowPass(shadowInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalDropShadowPass then
        self:updateDropShadowPass(lb.globalDropShadowPass, outputW, outputH,
            lb.u_time)
    end
end

function utils:createDropShadowPass(lb, comp, leafCamera, fragmentData, index,
                                    outputW, outputH)
    local config = getDropShadowConfig(fragmentData)
    if config == nil or lb.LumiDropShadow == nil then return nil end

    local shadowEntity = comp.entity.scene:cloneEntityFrom(lb.LumiDropShadow)
    shadowEntity.name = "LumiDropShadow_" ..
        (leafCamera.leafKey or tostring(index))
    shadowEntity.visible = true
    table.insert(lb.clonedEntities, shadowEntity)

    local shadowTransform = shadowEntity:getComponent("Transform")
    shadowTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(shadowTransform)

    local shadowCameras = getDropShadowCameras(shadowEntity)
    local scriptComp = shadowEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local shadowInfo = {
        entity = shadowEntity,
        cameras = shadowCameras.ordered,
        inputCamera = shadowCameras.input,
        horizontalCamera = shadowCameras.horizontal,
        verticalCamera = shadowCameras.vertical,
        lightCamera = shadowCameras.light,
        scriptComp = scriptComp,
        script = script,
        leafCamera = leafCamera,
        inputTex = inputTex,
        outputRT = outputRT,
        values = buildDropShadowValues(config),
        animation = getDropShadowAnimation(config),
        fragmentData = fragmentData,
    }
    leafCamera.dropShadowPass = shadowInfo
    leafCamera.postEffectTex = shadowInfo.outputRT
    leafCamera.blendRT = shadowInfo.outputRT
    table.insert(lb.dropShadowPasses, shadowInfo)

    self:updateDropShadowPass(shadowInfo, outputW, outputH, 0.0)
    return shadowInfo
end

function utils:createGlobalDropShadowPass(lb, comp, config, outputW, outputH,
                                          hasNextEffect)
    config = getDropShadowConfig({ dropShadow = config })
    if config == nil or lb.LumiDropShadow == nil then return nil end

    local shadowEntity = comp.entity.scene:cloneEntityFrom(lb.LumiDropShadow)
    shadowEntity.name = "LumiDropShadow_Global"
    shadowEntity.visible = true
    table.insert(lb.clonedEntities, shadowEntity)

    local shadowTransform = shadowEntity:getComponent("Transform")
    shadowTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(shadowTransform)

    local shadowCameras = getDropShadowCameras(shadowEntity)
    local scriptComp = shadowEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)

    local shadowInfo = {
        entity = shadowEntity,
        cameras = shadowCameras.ordered,
        inputCamera = shadowCameras.input,
        horizontalCamera = shadowCameras.horizontal,
        verticalCamera = shadowCameras.vertical,
        lightCamera = shadowCameras.light,
        scriptComp = scriptComp,
        script = script,
        inputRT = inputRT,
        inputTex = inputRT,
        outputRT = outputRT,
        values = buildDropShadowValues(config),
        animation = getDropShadowAnimation(config),
        isGlobal = true,
    }
    lb.globalDropShadowPass = shadowInfo

    self:updateDropShadowPass(shadowInfo, outputW, outputH, 0.0)
    return shadowInfo
end

-- Scriptless custom camera pass.  cumCam's camera owns the render target and
-- its child cumPass samples the source texture through u_inputTexture.
function utils:updateCumCamPass(cumInfo, outputW, outputH, time)
    if cumInfo == nil then return end

    local inputTex = cumInfo.inputTex
    if inputTex == nil and cumInfo.leafCamera then
        inputTex = cumInfo.leafCamera.postEffectTex
            or cumInfo.leafCamera.outputRT
    end
    local outputTex = cumInfo.outputRT
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)
    local blackWhiteIntensity = cumInfo.blackWhiteIntensity or 1.0
    local blackWhiteContrast = cumInfo.blackWhiteContrast or 0.0
    local animation = cumInfo.animation
    if type(animation) == "table" then
        local track = animation.blackWhiteIntensity
            or animation.blackWhite
            or animation.grayscale
        if track then
            local animated = self:sampleTrack(track, time or 0.0,
                blackWhiteIntensity)
            if type(animated) == "number" then
                blackWhiteIntensity = animated
            end
        end
    end
    blackWhiteIntensity = math.min(math.max(blackWhiteIntensity, 0.0), 1.0)
    cumInfo.currentBlackWhiteIntensity = blackWhiteIntensity

    if type(animation) == "table" then
        local track = animation.blackWhiteContrast
            or animation.contrast
        if track then
            local animated = self:sampleTrack(track, time or 0.0,
                blackWhiteContrast)
            if type(animated) == "number" then
                blackWhiteContrast = animated
            end
        end
    end
    blackWhiteContrast = math.min(math.max(blackWhiteContrast, -1.0), 3.0)
    cumInfo.currentBlackWhiteContrast = blackWhiteContrast

    local overlayProgress = cumInfo.overlayProgress or 0.0
    if type(animation) == "table" then
        local track = animation.overlayProgress
            or animation.overlay
            or animation.expandProgress
        if track then
            local animated = self:sampleTrack(track, time or 0.0,
                overlayProgress)
            if type(animated) == "number" then
                overlayProgress = animated
            end
        end
    end
    overlayProgress = math.min(math.max(overlayProgress, 0.0), 1.0)
    cumInfo.currentOverlayProgress = overlayProgress

    local rgbSeparation = cumInfo.rgbSeparation or 0.0
    local rgbSeparationAngle = cumInfo.rgbSeparationAngle or 0.0
    if type(animation) == "table" then
        local strengthTrack = animation.rgbSeparation
            or animation.rgbSeparationIntensity
        if strengthTrack then
            local animated = self:sampleTrack(strengthTrack, time or 0.0,
                rgbSeparation)
            if type(animated) == "number" then rgbSeparation = animated end
        end

        local angleTrack = animation.rgbSeparationAngle
            or animation.separationAngle
        if angleTrack then
            local animated = self:sampleTrack(angleTrack, time or 0.0,
                rgbSeparationAngle)
            if type(animated) == "number" then rgbSeparationAngle = animated end
        end
    end
    rgbSeparationAngle = applyUvDirectionAngle(rgbSeparationAngle,
        cumInfo.rgbSeparationAngleAspectAdapt, outputW, outputH)
    rgbSeparation = math.max(rgbSeparation, 0.0)
    cumInfo.currentRgbSeparation = rgbSeparation
    cumInfo.currentRgbSeparationAngle = rgbSeparationAngle

    local transformRotation = cumInfo.transformRotation or 0.0
    local transformPosition = normalizeMotionBlurVec2(
        cumInfo.transformPosition, { 0.0, 0.0 })
    local transformScale = normalizeMotionBlurVec2(
        cumInfo.transformScale, { 1.0, 1.0 })
    if type(animation) == "table" then
        local rotationTrack = animation.transformRotation
            or animation.rotation or animation.rotate
        if rotationTrack then
            local animated = self:sampleTrack(rotationTrack, time or 0.0,
                transformRotation)
            if type(animated) == "number" then transformRotation = animated end
        end

        local positionTrack = animation.transformPosition
            or animation.position or animation.translation
        if positionTrack then
            local animated = self:sampleTrack(positionTrack, time or 0.0,
                transformPosition)
            if type(animated) == "table" or type(animated) == "userdata" then
                transformPosition = normalizeMotionBlurVec2(animated,
                    transformPosition)
            end
        end

        local scaleTrack = animation.transformScale or animation.scale
        if scaleTrack then
            local animated = self:sampleTrack(scaleTrack, time or 0.0,
                transformScale)
            if type(animated) == "number" then
                transformScale = { animated, animated }
            elseif type(animated) == "table" or type(animated) == "userdata" then
                transformScale = normalizeMotionBlurVec2(animated,
                    transformScale)
            end
        end
    end
    transformScale[1] = math.max(math.abs(transformScale[1]), 0.0001)
    transformScale[2] = math.max(math.abs(transformScale[2]), 0.0001)
    cumInfo.currentTransformRotation = transformRotation
    cumInfo.currentTransformPosition = transformPosition
    cumInfo.currentTransformScale = transformScale

    if cumInfo.camera then
        cumInfo.camera.enabled = true
        cumInfo.camera.isRootCamera = false
        cumInfo.camera.renderTexture = outputTex
    end
    if cumInfo.material then
        cumInfo.material:setTex("u_inputTexture", inputTex)
        cumInfo.material:setFloat("u_blackWhiteIntensity", blackWhiteIntensity)
        cumInfo.material:setFloat("u_blackWhiteContrast", blackWhiteContrast)
        cumInfo.material:setFloat("u_overlayProgress", overlayProgress)
        cumInfo.material:setFloat("u_rgbSeparation", rgbSeparation)
        cumInfo.material:setFloat("u_rgbSeparationAngle", rgbSeparationAngle)
        cumInfo.material:setFloat("u_transformRotation", transformRotation)
        cumInfo.material:setVec2("u_transformPosition", Amaz.Vector2f(
            transformPosition[1], transformPosition[2]))
        cumInfo.material:setVec2("u_transformScale", Amaz.Vector2f(
            transformScale[1], transformScale[2]))
        cumInfo.material:setFloat("u_mirrorEdge",
            cumInfo.mirrorEdge and 1.0 or 0.0)
        cumInfo.material:setFloat("u_tileEdge",
            cumInfo.tileEdge and 1.0 or 0.0)
        if outputW and outputH and outputW > 0 and outputH > 0 then
            cumInfo.material:setVec4("u_ScreenParams", Amaz.Vector4f(
                outputW, outputH, outputW / outputH, outputH / outputW))
        end
    end
end

function utils:updateCumCamPasses(lb, outputW, outputH)
    for _, cumInfo in ipairs(lb.cumCamPasses or {}) do
        self:updateCumCamPass(cumInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalCumCamPass then
        self:updateCumCamPass(lb.globalCumCamPass, outputW, outputH, lb.u_time)
    end
end

function utils:createNegativePass(lb, comp, leafCamera, fragmentData, index,
                                  outputW, outputH)
    local config = getNegativeConfig(fragmentData)
    if config == nil or lb.LumiNegative == nil then
        return nil
    end

    local negativeEntity = comp.entity.scene:cloneEntityFrom(lb.LumiNegative)
    negativeEntity.name = "LumiNegative_" .. (leafCamera.leafKey or tostring(index))
    negativeEntity.visible = true
    table.insert(lb.clonedEntities, negativeEntity)

    local negativeTransform = negativeEntity:getComponent("Transform")
    negativeTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(negativeTransform)

    local cameraEntity = negativeEntity:searchEntity("CameraNegative")
    local passEntity = negativeEntity:searchEntity("PassNegative")
    local camera = cameraEntity and cameraEntity:getComponent("Camera")
    local material = passEntity and passEntity:getComponent("MeshRenderer").material
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end
    local scriptComp = negativeEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local alpha = config.negativeAlpha
    if alpha == nil then alpha = config.alpha end
    if alpha == nil then alpha = fragmentData.negativeAlpha end
    if alpha == nil then alpha = 1.0 end
    local alphaAnimation = config.alphaAnimation
    if alphaAnimation == nil and type(config.animation) == "table" then
        alphaAnimation = config.animation.negativeAlpha or config.animation.alpha
        if alphaAnimation == nil and #config.animation > 0 then
            alphaAnimation = config.animation
        end
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local negativeInfo = {
        entity = negativeEntity,
        camera = camera,
        material = material,
        scriptComp = scriptComp,
        script = script,
        leafCamera = leafCamera,
        inputTex = inputTex,
        outputRT = outputRT,
        alpha = alpha,
        alphaAnimation = alphaAnimation,
        fragmentData = fragmentData,
    }
    leafCamera.negativePass = negativeInfo
    leafCamera.postEffectTex = negativeInfo.outputRT
    leafCamera.blendRT = negativeInfo.outputRT
    table.insert(lb.negativePasses, negativeInfo)

    self:updateNegativePass(negativeInfo, outputW, outputH, 0.0)
    return negativeInfo
end

function utils:createGlobalNegativePass(lb, comp, config, outputW, outputH,
                                        hasNextEffect)
    config = getNegativeConfig({ negative = config })
    if config == nil or lb.LumiNegative == nil then
        return nil
    end

    local negativeEntity = comp.entity.scene:cloneEntityFrom(lb.LumiNegative)
    negativeEntity.name = "LumiNegative_Global"
    negativeEntity.visible = true
    table.insert(lb.clonedEntities, negativeEntity)

    local negativeTransform = negativeEntity:getComponent("Transform")
    negativeTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(negativeTransform)

    local cameraEntity = negativeEntity:searchEntity("CameraNegative")
    local passEntity = negativeEntity:searchEntity("PassNegative")
    local camera = cameraEntity and cameraEntity:getComponent("Camera")
    local material = passEntity and passEntity:getComponent("MeshRenderer").material
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end
    local scriptComp = negativeEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local alpha = config.negativeAlpha
    if alpha == nil then alpha = config.alpha end
    if alpha == nil then alpha = 1.0 end
    local alphaAnimation = config.alphaAnimation
    if alphaAnimation == nil and type(config.animation) == "table" then
        alphaAnimation = config.animation.negativeAlpha or config.animation.alpha
        if alphaAnimation == nil and #config.animation > 0 then
            alphaAnimation = config.animation
        end
    end

    local negativeInputRT, outputRT =
        self:allocateGlobalPostEffectPass(lb)
    local negativeInfo = {
        entity = negativeEntity,
        camera = camera,
        material = material,
        scriptComp = scriptComp,
        script = script,
        inputRT = negativeInputRT,
        outputRT = outputRT,
        alpha = alpha,
        alphaAnimation = alphaAnimation,
        isGlobal = true,
    }
    negativeInfo.inputTex = negativeInfo.inputRT
    lb.globalNegativePass = negativeInfo

    self:updateNegativePass(negativeInfo, outputW, outputH, 0.0)
    return negativeInfo
end

function utils:createBrightnessPass(lb, comp, leafCamera, fragmentData, index,
                                    outputW, outputH)
    local config = getBrightnessConfig(fragmentData)
    if config == nil or lb.LumiBrightness == nil then
        return nil
    end

    local brightnessEntity = comp.entity.scene:cloneEntityFrom(lb.LumiBrightness)
    brightnessEntity.name = "LumiBrightness_" .. (leafCamera.leafKey or tostring(index))
    brightnessEntity.visible = true
    table.insert(lb.clonedEntities, brightnessEntity)

    local brightnessTransform = brightnessEntity:getComponent("Transform")
    brightnessTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(brightnessTransform)

    local cameraEntity = brightnessEntity:searchEntity("CameraBrightness")
    local passEntity = brightnessEntity:searchEntity("EntityBrightness")
    local camera = cameraEntity and cameraEntity:getComponent("Camera")
    local material = passEntity and passEntity:getComponent("MeshRenderer").material
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end

    local scriptComp = brightnessEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local brightnessInfo = {
        entity = brightnessEntity,
        camera = camera,
        material = material,
        scriptComp = scriptComp,
        script = script,
        leafCamera = leafCamera,
        inputTex = inputTex,
        outputRT = outputRT,
        values = buildBrightnessValues(config),
        animation = getBrightnessAnimation(config),
        fragmentData = fragmentData,
    }
    leafCamera.brightnessPass = brightnessInfo
    leafCamera.postEffectTex = brightnessInfo.outputRT
    leafCamera.blendRT = brightnessInfo.outputRT
    table.insert(lb.brightnessPasses, brightnessInfo)

    self:updateBrightnessPass(brightnessInfo, outputW, outputH, 0.0)
    return brightnessInfo
end

function utils:createGlobalBrightnessPass(lb, comp, config, outputW, outputH,
                                          hasNextEffect)
    config = getBrightnessConfig({ brightness = config })
    if config == nil or lb.LumiBrightness == nil then
        return nil
    end

    local brightnessEntity = comp.entity.scene:cloneEntityFrom(lb.LumiBrightness)
    brightnessEntity.name = "LumiBrightness_Global"
    brightnessEntity.visible = true
    table.insert(lb.clonedEntities, brightnessEntity)

    local brightnessTransform = brightnessEntity:getComponent("Transform")
    brightnessTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(brightnessTransform)

    local cameraEntity = brightnessEntity:searchEntity("CameraBrightness")
    local passEntity = brightnessEntity:searchEntity("EntityBrightness")
    local camera = cameraEntity and cameraEntity:getComponent("Camera")
    local material = passEntity and passEntity:getComponent("MeshRenderer").material
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end

    local scriptComp = brightnessEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)

    local brightnessInfo = {
        entity = brightnessEntity,
        camera = camera,
        material = material,
        scriptComp = scriptComp,
        script = script,
        inputRT = inputRT,
        inputTex = inputRT,
        outputRT = outputRT,
        values = buildBrightnessValues(config),
        animation = getBrightnessAnimation(config),
        isGlobal = true,
    }
    lb.globalBrightnessPass = brightnessInfo

    self:updateBrightnessPass(brightnessInfo, outputW, outputH, 0.0)
    return brightnessInfo
end

local function setMotionBlurCameraEnabled(camera)
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end
end

function utils:createMotionBlur2DPass(lb, comp, leafCamera, fragmentData, index,
                                     outputW, outputH)
    local config = getMotionBlurConfig(fragmentData)
    if config == nil or lb.LumiMotionBlur2D == nil then
        return nil
    end

    local motionEntity = comp.entity.scene:cloneEntityFrom(lb.LumiMotionBlur2D)
    motionEntity.name = "LumiMotionBlur2D_" .. (leafCamera.leafKey or tostring(index))
    motionEntity.visible = true
    table.insert(lb.clonedEntities, motionEntity)

    local motionTransform = motionEntity:getComponent("Transform")
    motionTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(motionTransform)

    local cameraEntity = motionEntity:searchEntity("cam")
    local passEntity = motionEntity:searchEntity("motion_blur_2d")
    local camera = cameraEntity and cameraEntity:getComponent("Camera")
    local material = passEntity and passEntity:getComponent("MeshRenderer").material
    setMotionBlurCameraEnabled(camera)

    local scriptComp = motionEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local motionInfo = {
        entity = motionEntity,
        camera = camera,
        material = material,
        scriptComp = scriptComp,
        script = script,
        leafCamera = leafCamera,
        inputTex = inputTex,
        outputRT = outputRT,
        values = buildMotionBlurValues(config),
        animation = getMotionBlurAnimation(config),
        positionAspectAdapt = getMotionBlurPositionAspectAdapt(config),
        fragmentData = fragmentData,
    }
    leafCamera.motionBlur2DPass = motionInfo
    leafCamera.postEffectTex = motionInfo.outputRT
    leafCamera.blendRT = motionInfo.outputRT
    table.insert(lb.motionBlur2DPasses, motionInfo)

    self:updateMotionBlur2DPass(motionInfo, outputW, outputH, 0.0)
    return motionInfo
end

function utils:createGlobalMotionBlur2DPass(lb, comp, config, outputW, outputH,
                                            hasNextEffect)
    config = getMotionBlurConfig({ motionBlur2D = config })
    if config == nil or lb.LumiMotionBlur2D == nil then
        return nil
    end

    local motionEntity = comp.entity.scene:cloneEntityFrom(lb.LumiMotionBlur2D)
    motionEntity.name = "LumiMotionBlur2D_Global"
    motionEntity.visible = true
    table.insert(lb.clonedEntities, motionEntity)

    local motionTransform = motionEntity:getComponent("Transform")
    motionTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(motionTransform)

    local cameraEntity = motionEntity:searchEntity("cam")
    local passEntity = motionEntity:searchEntity("motion_blur_2d")
    local camera = cameraEntity and cameraEntity:getComponent("Camera")
    local material = passEntity and passEntity:getComponent("MeshRenderer").material
    setMotionBlurCameraEnabled(camera)

    local scriptComp = motionEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)

    local motionInfo = {
        entity = motionEntity,
        camera = camera,
        material = material,
        scriptComp = scriptComp,
        script = script,
        inputRT = inputRT,
        inputTex = inputRT,
        outputRT = outputRT,
        values = buildMotionBlurValues(config),
        animation = getMotionBlurAnimation(config),
        positionAspectAdapt = getMotionBlurPositionAspectAdapt(config),
        isGlobal = true,
    }
    lb.globalMotionBlur2DPass = motionInfo

    self:updateMotionBlur2DPass(motionInfo, outputW, outputH, 0.0)
    return motionInfo
end

function utils:createCumCamPass(lb, comp, leafCamera, fragmentData, index,
                                outputW, outputH)
    local config = getCumCamConfig(fragmentData)
    if config == nil or lb.cumCam == nil then
        return nil
    end

    local cumEntity = comp.entity.scene:cloneEntityFrom(lb.cumCam)
    cumEntity.name = "cumCam_" .. (leafCamera.leafKey or tostring(index))
    cumEntity.visible = true
    table.insert(lb.clonedEntities, cumEntity)

    -- cumCam itself owns the Camera; cumPass is its only child renderer.
    local cumTransform = cumEntity:getComponent("Transform")
    cumTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(cumTransform)

    local camera = cumEntity:getComponent("Camera")
    local passEntity = cumEntity:searchEntity("cumPass")
    local material = passEntity
        and passEntity:getComponent("MeshRenderer").material
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local cumInfo = {
        entity = cumEntity,
        camera = camera,
        material = material,
        leafCamera = leafCamera,
        inputTex = inputTex,
        outputRT = outputRT,
        blackWhiteIntensity = getCumCamBlackWhiteIntensity(config),
        blackWhiteContrast = getCumCamBlackWhiteContrast(config),
        overlayProgress = getCumCamOverlayProgress(config),
        rgbSeparation = getCumCamRgbSeparation(config),
        rgbSeparationAngle = getCumCamRgbSeparationAngle(config),
        rgbSeparationAngleAspectAdapt = getAngleAspectAdapt(config,
            "rgbSeparationAngleAspectAdapt", "angleAspectAdapt"),
        transformRotation = getCumCamTransformRotation(config),
        transformPosition = getCumCamTransformPosition(config),
        transformScale = getCumCamTransformScale(config),
        mirrorEdge = getCumCamBool(config, "mirrorEdge", "mirror", false),
        tileEdge = getCumCamBool(config, "tileEdge", "tile", false),
        animation = getCumCamAnimation(config),
        config = config,
    }
    leafCamera.cumCamPass = cumInfo
    leafCamera.postEffectTex = cumInfo.outputRT
    leafCamera.blendRT = cumInfo.outputRT
    table.insert(lb.cumCamPasses, cumInfo)

    self:updateCumCamPass(cumInfo, outputW, outputH, 0.0)
    return cumInfo
end

function utils:createGlobalCumCamPass(lb, comp, config, outputW, outputH)
    config = getCumCamConfig({ cumCam = config })
    if config == nil or lb.cumCam == nil then
        return nil
    end

    local cumEntity = comp.entity.scene:cloneEntityFrom(lb.cumCam)
    cumEntity.name = "cumCam_Global"
    cumEntity.visible = true
    table.insert(lb.clonedEntities, cumEntity)

    local cumTransform = cumEntity:getComponent("Transform")
    cumTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(cumTransform)

    local camera = cumEntity:getComponent("Camera")
    local passEntity = cumEntity:searchEntity("cumPass")
    local material = passEntity
        and passEntity:getComponent("MeshRenderer").material
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end

    local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)

    local cumInfo = {
        entity = cumEntity,
        camera = camera,
        material = material,
        inputRT = inputRT,
        inputTex = inputRT,
        outputRT = outputRT,
        blackWhiteIntensity = getCumCamBlackWhiteIntensity(config),
        blackWhiteContrast = getCumCamBlackWhiteContrast(config),
        overlayProgress = getCumCamOverlayProgress(config),
        rgbSeparation = getCumCamRgbSeparation(config),
        rgbSeparationAngle = getCumCamRgbSeparationAngle(config),
        rgbSeparationAngleAspectAdapt = getAngleAspectAdapt(config,
            "rgbSeparationAngleAspectAdapt", "angleAspectAdapt"),
        transformRotation = getCumCamTransformRotation(config),
        transformPosition = getCumCamTransformPosition(config),
        transformScale = getCumCamTransformScale(config),
        mirrorEdge = getCumCamBool(config, "mirrorEdge", "mirror", false),
        tileEdge = getCumCamBool(config, "tileEdge", "tile", false),
        animation = getCumCamAnimation(config),
        config = config,
        isGlobal = true,
    }
    lb.globalCumCamPass = cumInfo

    self:updateCumCamPass(cumInfo, outputW, outputH, 0.0)
    return cumInfo
end

local function setSGlowCameraEnabled(camera)
    if camera then
        camera.enabled = true
        camera.isRootCamera = false
    end
end

local function getSGlowCameras(entity)
    -- SGlow.lua owns every internal Mask/Blur/BlendCamera RT.  LumiBlit only
    -- keeps references for activation; it must not overwrite those endpoints.
    local result = {
        mask = getEntityCamera(entity, "MaskCamera"),
        horizontal = getEntityCamera(entity, "BlurHorzCamera"),
        vertical = getEntityCamera(entity, "BlurVertCamera"),
        horizontal2 = getEntityCamera(entity, "BlurHorzCamera_2"),
        vertical2 = getEntityCamera(entity, "BlurVertCamera_2"),
        blend = getEntityCamera(entity, "BlendCamera"),
        ordered = {},
    }
    for _, key in ipairs({
        "mask", "horizontal", "vertical",
        "horizontal2", "vertical2", "blend",
    }) do
        local camera = result[key]
        if camera then
            setSGlowCameraEnabled(camera)
            table.insert(result.ordered, camera)
        end
    end
    return result
end

function utils:updateSGlowPass(glowInfo, outputW, outputH, time)
    if glowInfo == nil then return end

    -- These are the only RTs controlled by LumiBlit for SGlow: the external
    -- source and final destination.  Internal camera RT routing stays in
    -- SGlow.lua, matching the standalone effect's behavior.
    local inputTex = glowInfo.inputTex
    if inputTex == nil and glowInfo.leafCamera then
        inputTex = glowInfo.leafCamera.outputRT
    end
    local outputTex = glowInfo.outputRT
    self:updateTexSize(inputTex, outputW, outputH)
    self:updateTexSize(outputTex, outputW, outputH)
    local values = copySGlowValues(glowInfo.values or SGLOW_DEFAULTS)
    local animation = glowInfo.animation
    if type(animation) == "table" then
        for _, field in ipairs(SGLOW_NUMERIC_FIELDS) do
            if animation[field] then
                local animated = self:sampleTrack(animation[field], time or 0.0,
                    values[field])
                if type(animated) == "number" then values[field] = animated end
            end
        end
        for _, field in ipairs(SGLOW_COLOR_FIELDS) do
            if animation[field] then
                local animated = self:sampleTrack(animation[field], time or 0.0,
                    values[field])
                values[field] = normalizeSGlowColor(animated, values[field])
            end
        end
    end
    glowInfo.currentValues = values

    local scriptComp = glowInfo.scriptComp
    if scriptComp and scriptComp.properties then
        local props = scriptComp.properties
        props:set("InputTex", inputTex)
        props:set("OutputTex", outputTex)
        for _, field in ipairs(SGLOW_NUMERIC_FIELDS) do
            props:set(field, values[field])
        end
        for _, field in ipairs(SGLOW_COLOR_FIELDS) do
            props:set(field, toAmazColor(values[field]))
        end
        for _, field in ipairs(SGLOW_STATIC_FIELDS) do
            if values[field] ~= nil then props:set(field, values[field]) end
        end
    end

    local script = glowInfo.script
    if script then
        script.InputTex = inputTex
        script.OutputTex = outputTex
        for _, field in ipairs(SGLOW_NUMERIC_FIELDS) do
            script[field] = values[field]
        end
        for _, field in ipairs(SGLOW_COLOR_FIELDS) do
            script[field] = toAmazColor(values[field])
        end
        for _, field in ipairs(SGLOW_STATIC_FIELDS) do
            script[field] = values[field]
        end
    end
end

function utils:updateSGlowPasses(lb, outputW, outputH)
    for _, glowInfo in ipairs(lb.sGlowPasses or {}) do
        self:updateSGlowPass(glowInfo, outputW, outputH, lb.u_time)
    end

    if lb.globalSGlowPass then
        self:updateSGlowPass(lb.globalSGlowPass, outputW, outputH, lb.u_time)
    end
end

function utils:createSGlowPass(lb, comp, leafCamera, fragmentData, index,
                               outputW, outputH)
    local config = getSGlowConfig(fragmentData)
    if config == nil or lb.LumiSGlow == nil then return nil end

    local glowEntity = comp.entity.scene:cloneEntityFrom(lb.LumiSGlow)
    glowEntity.name = "LumiSGlow_" .. (leafCamera.leafKey or tostring(index))
    glowEntity.visible = true
    table.insert(lb.clonedEntities, glowEntity)

    local glowTransform = glowEntity:getComponent("Transform")
    glowTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(glowTransform)

    local glowCameras = getSGlowCameras(glowEntity)
    local scriptComp = glowEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputTex = leafCamera.postEffectTex or leafCamera.outputRT
    local outputRT = self:allocateFragmentPostEffectOutput(
        leafCamera, outputW, outputH)
    local glowInfo = {
        entity = glowEntity,
        cameras = glowCameras.ordered,
        maskCamera = glowCameras.mask,
        blendCamera = glowCameras.blend,
        scriptComp = scriptComp,
        script = script,
        leafCamera = leafCamera,
        inputTex = inputTex,
        outputRT = outputRT,
        values = buildSGlowValues(config),
        animation = getSGlowAnimation(config),
        fragmentData = fragmentData,
    }
    leafCamera.sGlowPass = glowInfo
    leafCamera.postEffectTex = glowInfo.outputRT
    leafCamera.blendRT = glowInfo.outputRT
    table.insert(lb.sGlowPasses, glowInfo)

    self:updateSGlowPass(glowInfo, outputW, outputH, 0.0)
    return glowInfo
end

function utils:createGlobalSGlowPass(lb, comp, config, outputW, outputH,
                                     hasNextEffect)
    config = getSGlowConfig({ sGlow = config })
    if config == nil or lb.LumiSGlow == nil then return nil end

    local glowEntity = comp.entity.scene:cloneEntityFrom(lb.LumiSGlow)
    glowEntity.name = "LumiSGlow_Global"
    glowEntity.visible = true
    table.insert(lb.clonedEntities, glowEntity)

    local glowTransform = glowEntity:getComponent("Transform")
    glowTransform.parent = lb.fatherTrans
    lb.fatherTrans.children:pushBack(glowTransform)

    local glowCameras = getSGlowCameras(glowEntity)
    local scriptComp = glowEntity:getComponent("ScriptComponent")
    local script = nil
    if scriptComp then
        script = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
    end

    local inputRT, outputRT = self:allocateGlobalPostEffectPass(lb)

    local glowInfo = {
        entity = glowEntity,
        cameras = glowCameras.ordered,
        maskCamera = glowCameras.mask,
        blendCamera = glowCameras.blend,
        scriptComp = scriptComp,
        script = script,
        inputRT = inputRT,
        inputTex = inputRT,
        outputRT = outputRT,
        values = buildSGlowValues(config),
        animation = getSGlowAnimation(config),
        isGlobal = true,
    }
    lb.globalSGlowPass = glowInfo

    self:updateSGlowPass(glowInfo, outputW, outputH, 0.0)
    return glowInfo
end

function utils:reloadFragmentsData(lb, comp, suppliedFragmentsData)
    local fragmentsData = suppliedFragmentsData
    if fragmentsData == nil then
        fragmentsData = includeRelativePath("fragmentsData.lua")
    end
    self:validateFragmentsData(fragmentsData)
    lb.fragmentsData = fragmentsData
    lb.cameraType = fragmentsData.cameraType or "perspective"

    if lb.clonedEntities then
        for _, entity in ipairs(lb.clonedEntities) do
            comp.entity.scene:removeEntity(entity)
        end
    end
    lb.clonedEntities = {}
    lb.cameraTemplate.visible = true
    if lb.LumiNegative then
        lb.LumiNegative.visible = false
    end
    if lb.LumiAdjust then
        lb.LumiAdjust.visible = false
    end
    if lb.LumiSGlow then
        lb.LumiSGlow.visible = false
    end
    if lb.LumiBrightness then
        lb.LumiBrightness.visible = false
    end
    if lb.LumiMotionBlur2D then
        lb.LumiMotionBlur2D.visible = false
    end
    if lb.LumiGaussianBlur then
        lb.LumiGaussianBlur.visible = false
    end
    if lb.LumiDirectionalBlurs then
        lb.LumiDirectionalBlurs.visible = false
    end
    if lb.LumiDropShadow then
        lb.LumiDropShadow.visible = false
    end
    if lb.cumCam then
        lb.cumCam.visible = false
    end

    lb.allCameras = {}
    lb.leafRTs = {}
    lb.leafCameras = {}
    lb.adjustPasses = {}
    lb.negativePasses = {}
    lb.brightnessPasses = {}
    lb.motionBlur2DPasses = {}
    lb.gaussianBlurPasses = {}
    lb.directionalBlursPasses = {}
    lb.dropShadowPasses = {}
    lb.cumCamPasses = {}
    lb.sGlowPasses = {}
    lb.globalAdjustPass = nil
    lb.globalNegativePass = nil
    lb.globalBrightnessPass = nil
    lb.globalMotionBlur2DPass = nil
    lb.globalGaussianBlurPass = nil
    lb.globalDirectionalBlursPass = nil
    lb.globalDropShadowPass = nil
    lb.globalCumCamPass = nil
    lb.globalSGlowPass = nil
    lb.nextCloneIndex = 0
    lb.parts = {}

    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()

    local data = fragmentsData.input1
    local part = {
        name = "input1",
        splitType = data.splitType or "lineSplit",
        global = data.global or {},
        fragments = data.fragments or {},
        rt = {
            lineMaskProgress = (data.global and data.global.lineMaskProgress) or 0.0,
            localPosition = copyVec3((data.global and data.global.localPosition)
                or { 0.0, 0.0, 0.0 }),
        },
    }
    table.insert(lb.parts, part)

    if data.splitTrees then
        for index, tree in ipairs(data.splitTrees) do
            self:buildPipeline(tree, "InputTex", {}, {}, comp, lb, part.splitType,
                index, part, "tex1_")
        end
    else
        local activeSplitTree = self:resolveSplitTree(data)
        self:buildPipeline(activeSplitTree, "InputTex", {}, {}, comp, lb,
            part.splitType, nil, part, "tex1_")
    end

    for _, leafCamera in ipairs(lb.leafCameras) do
        local polygon, bounds
        if leafCamera.splitType == "circleSplit" or leafCamera.splitType == "loveType" then
            bounds = self:computeLeafBoundsBySampling(leafCamera.splitPath, leafCamera.splitType)
            polygon = {
                { bounds.minX, bounds.minY },
                { bounds.maxX, bounds.minY },
                { bounds.maxX, bounds.maxY },
                { bounds.minX, bounds.maxY },
            }
        else
            polygon = self:computeLeafPolygon(leafCamera.splitPath)
            bounds = self:computeBounds(polygon)
        end
        leafCamera.polygon = polygon
        leafCamera.bounds = bounds

        local fragmentData = leafCamera.part.fragments[leafCamera.leafKey]
        if fragmentData then
            if fragmentData.localPosition then
                leafCamera.translation = copyVec3(fragmentData.localPosition)
                leafCamera.baseTranslation = copyVec3(fragmentData.localPosition)
            end
            if fragmentData.localRotation then
                leafCamera.rotation = copyVec3(fragmentData.localRotation)
                leafCamera.baseRotation = copyVec3(fragmentData.localRotation)
            end
            if fragmentData.selfRotation then
                leafCamera.selfRotation = copyVec3(fragmentData.selfRotation)
                leafCamera.baseSelfRotation = copyVec3(fragmentData.selfRotation)
            end
            if fragmentData.localScale then
                leafCamera.scale = copyVec3(fragmentData.localScale)
                leafCamera.baseScale = copyVec3(fragmentData.localScale)
            end
            if fragmentData.alpha ~= nil then
                leafCamera.alpha = fragmentData.alpha
                leafCamera.baseAlpha = fragmentData.alpha
            end
            if fragmentData.anchor then
                leafCamera.anchorType = fragmentData.anchor.type or leafCamera.anchorType
                leafCamera.anchorPoint = fragmentData.anchor.point or leafCamera.anchorPoint
            end
            if fragmentData.depth ~= nil then
                leafCamera.depth = fragmentData.depth
                leafCamera.baseDepth = fragmentData.depth
            end
        end

        self:createAdjustPass(lb, comp, leafCamera, fragmentData,
            #lb.adjustPasses + 1, outputW, outputH)
        self:createNegativePass(lb, comp, leafCamera, fragmentData,
            #lb.negativePasses + 1, outputW, outputH)
        self:createBrightnessPass(lb, comp, leafCamera, fragmentData,
            #lb.brightnessPasses + 1, outputW, outputH)
        self:createMotionBlur2DPass(lb, comp, leafCamera, fragmentData,
            #lb.motionBlur2DPasses + 1, outputW, outputH)
        self:createGaussianBlurPass(lb, comp, leafCamera, fragmentData,
            #lb.gaussianBlurPasses + 1, outputW, outputH)
        self:createDirectionalBlursPass(lb, comp, leafCamera, fragmentData,
            #lb.directionalBlursPasses + 1, outputW, outputH)
        self:createDropShadowPass(lb, comp, leafCamera, fragmentData,
            #lb.dropShadowPasses + 1, outputW, outputH)
        self:createCumCamPass(lb, comp, leafCamera, fragmentData,
            #lb.cumCamPasses + 1, outputW, outputH)
        self:createSGlowPass(lb, comp, leafCamera, fragmentData,
            #lb.sGlowPasses + 1, outputW, outputH)
    end

    local globalAdjustConfig = part.global.adjust
    if globalAdjustConfig == nil then
        local rootGlobal = fragmentsData.global
        if rootGlobal and rootGlobal.adjust ~= nil then
            globalAdjustConfig = rootGlobal.adjust
        else
            globalAdjustConfig = fragmentsData.adjust
        end
    end
    local globalNegativeConfig = part.global.negative
    if globalNegativeConfig == nil then
        local rootGlobal = fragmentsData.global
        if rootGlobal and rootGlobal.negative ~= nil then
            globalNegativeConfig = rootGlobal.negative
        else
            globalNegativeConfig = fragmentsData.negative
        end
    end
    local globalBrightnessConfig = getBrightnessField(part.global)
    if globalBrightnessConfig == nil then
        local rootGlobal = fragmentsData.global
        globalBrightnessConfig = getBrightnessField(rootGlobal)
        if globalBrightnessConfig == nil then
            globalBrightnessConfig = getBrightnessField(fragmentsData)
        end
    end
    local globalMotionBlurConfig = getMotionBlurField(part.global)
    if globalMotionBlurConfig == nil then
        local rootGlobal = fragmentsData.global
        globalMotionBlurConfig = getMotionBlurField(rootGlobal)
        if globalMotionBlurConfig == nil then
            globalMotionBlurConfig = getMotionBlurField(fragmentsData)
        end
    end
    local globalGaussianBlurConfig = getGaussianBlurField(part.global)
    if globalGaussianBlurConfig == nil then
        local rootGlobal = fragmentsData.global
        globalGaussianBlurConfig = getGaussianBlurField(rootGlobal)
        if globalGaussianBlurConfig == nil then
            globalGaussianBlurConfig = getGaussianBlurField(fragmentsData)
        end
    end
    local globalDirectionalBlursConfig = getDirectionalBlursField(part.global)
    if globalDirectionalBlursConfig == nil then
        local rootGlobal = fragmentsData.global
        globalDirectionalBlursConfig = getDirectionalBlursField(rootGlobal)
        if globalDirectionalBlursConfig == nil then
            globalDirectionalBlursConfig = getDirectionalBlursField(fragmentsData)
        end
    end
    local globalDropShadowConfig = getDropShadowField(part.global)
    if globalDropShadowConfig == nil then
        local rootGlobal = fragmentsData.global
        globalDropShadowConfig = getDropShadowField(rootGlobal)
        if globalDropShadowConfig == nil then
            globalDropShadowConfig = getDropShadowField(fragmentsData)
        end
    end
    local globalSGlowConfig = getSGlowField(part.global)
    if globalSGlowConfig == nil then
        local rootGlobal = fragmentsData.global
        globalSGlowConfig = getSGlowField(rootGlobal)
        if globalSGlowConfig == nil then
            globalSGlowConfig = getSGlowField(fragmentsData)
        end
    end
    -- Resolve the global cumCam through the same alias-aware helper used by
    -- fragment passes.  This keeps global RT wiring active for cumCam,
    -- CumCam, and cumcam declarations alike.
    local globalCumCamConfig = getCumCamField(part.global)
    if globalCumCamConfig == nil then
        local rootGlobal = fragmentsData.global
        globalCumCamConfig = getCumCamField(rootGlobal)
        if globalCumCamConfig == nil then
            globalCumCamConfig = getCumCamField(fragmentsData)
        end
    end

    local hasGlobalAdjust = lb.LumiAdjust ~= nil
        and getAdjustConfig({ adjust = globalAdjustConfig }) ~= nil
    local hasGlobalNegative = lb.LumiNegative ~= nil
        and getNegativeConfig({ negative = globalNegativeConfig }) ~= nil
    local hasGlobalBrightness = lb.LumiBrightness ~= nil
        and getBrightnessConfig({ brightness = globalBrightnessConfig }) ~= nil
    local hasGlobalMotionBlur = lb.LumiMotionBlur2D ~= nil
        and getMotionBlurConfig({ motionBlur2D = globalMotionBlurConfig }) ~= nil
    local hasGlobalGaussianBlur = lb.LumiGaussianBlur ~= nil
        and getGaussianBlurConfig({ gaussianBlur = globalGaussianBlurConfig }) ~= nil
    local hasGlobalDirectionalBlurs = lb.LumiDirectionalBlurs ~= nil
        and getDirectionalBlursConfig({
            directionalBlurs = globalDirectionalBlursConfig,
        }) ~= nil
    local hasGlobalDropShadow = lb.LumiDropShadow ~= nil
        and getDropShadowConfig({
            dropShadow = globalDropShadowConfig,
        }) ~= nil
    local hasGlobalSGlow = lb.LumiSGlow ~= nil
        and getSGlowConfig({ sGlow = globalSGlowConfig }) ~= nil
    local hasGlobalCumCam = lb.cumCam ~= nil
        and getCumCamConfig({ cumCam = globalCumCamConfig }) ~= nil

    local globalPostEffectCount = 0
    local globalPostEffectFlags = {
        hasGlobalAdjust,
        hasGlobalNegative,
        hasGlobalBrightness,
        hasGlobalMotionBlur,
        hasGlobalGaussianBlur,
        hasGlobalDirectionalBlurs,
        hasGlobalDropShadow,
        hasGlobalSGlow,
        hasGlobalCumCam,
    }
    for _, enabled in ipairs(globalPostEffectFlags) do
        if enabled then globalPostEffectCount = globalPostEffectCount + 1 end
    end
    self:prepareGlobalPostEffectPingPong(
        lb, globalPostEffectCount, outputW, outputH)

    self:createGlobalAdjustPass(lb, comp, globalAdjustConfig, outputW, outputH,
        hasGlobalNegative or hasGlobalBrightness or hasGlobalMotionBlur
            or hasGlobalGaussianBlur or hasGlobalDirectionalBlurs
            or hasGlobalDropShadow or hasGlobalSGlow or hasGlobalCumCam)
    self:createGlobalNegativePass(lb, comp, globalNegativeConfig, outputW, outputH,
        hasGlobalBrightness or hasGlobalMotionBlur or hasGlobalGaussianBlur
            or hasGlobalDirectionalBlurs or hasGlobalDropShadow
            or hasGlobalSGlow or hasGlobalCumCam)
    self:createGlobalBrightnessPass(lb, comp, globalBrightnessConfig, outputW, outputH,
        hasGlobalMotionBlur or hasGlobalGaussianBlur or hasGlobalSGlow
            or hasGlobalDirectionalBlurs or hasGlobalDropShadow
            or hasGlobalCumCam)
    self:createGlobalMotionBlur2DPass(lb, comp, globalMotionBlurConfig, outputW, outputH,
        hasGlobalGaussianBlur or hasGlobalDirectionalBlurs
            or hasGlobalDropShadow or hasGlobalSGlow or hasGlobalCumCam)
    self:createGlobalGaussianBlurPass(lb, comp, globalGaussianBlurConfig,
        outputW, outputH, hasGlobalDirectionalBlurs or hasGlobalSGlow
            or hasGlobalDropShadow or hasGlobalCumCam)
    self:createGlobalDirectionalBlursPass(lb, comp,
        globalDirectionalBlursConfig, outputW, outputH,
        hasGlobalDropShadow or hasGlobalSGlow or hasGlobalCumCam)
    self:createGlobalDropShadowPass(lb, comp, globalDropShadowConfig,
        outputW, outputH, hasGlobalSGlow or hasGlobalCumCam)
    self:createGlobalSGlowPass(lb, comp, globalSGlowConfig, outputW, outputH,
        hasGlobalCumCam)
    self:createGlobalCumCamPass(lb, comp, globalCumCamConfig, outputW, outputH)
    self:refreshGlobalPostEffectPingPong(lb, outputW, outputH)

    self:orderCam(lb, comp)

    if fragmentsData.fov and fragmentsData.fov ~= lb.fov then
        lb.fov = fragmentsData.fov
    end
    self:applyPerspectiveSetup(lb)
    lb.cameraTemplate.visible = false
    if lb.LumiAdjust then
        lb.LumiAdjust.visible = false
    end
    if lb.LumiSGlow then
        lb.LumiSGlow.visible = false
    end
    if lb.LumiBrightness then
        lb.LumiBrightness.visible = false
    end
    if lb.LumiMotionBlur2D then
        lb.LumiMotionBlur2D.visible = false
    end
    if lb.LumiGaussianBlur then
        lb.LumiGaussianBlur.visible = false
    end
    if lb.LumiDirectionalBlurs then
        lb.LumiDirectionalBlurs.visible = false
    end
    if lb.LumiDropShadow then
        lb.LumiDropShadow.visible = false
    end
    if lb.cumCam then
        lb.cumCam.visible = false
    end
end

function utils:applyPerspectiveSetup(lb)
    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
    local ratio = outputW / outputH
    local posZ0 = ratio / math.tan(math.rad(lb.fov * 0.5))
    local fovy = 2 * math.deg(math.atan(1 / posZ0))

    local templateCam = lb.cameraTemplate:getComponent("Camera")
    if templateCam then
        templateCam.type = lb.cameraType == "ortho" and 1 or 0
        templateCam.fovy = fovy
    end

    local position = lb.cameraPosition
    local cameraScale = lb.cameraScale
    local basePosition = Amaz.Vector3f(
        (position.x - 0.5) * 2 * ratio,
        (position.y - 0.5) * 2,
        -posZ0 - position.z * 2
    )

    local fatherTrans = lb.fatherEntity_1:getComponent("Transform")
    fatherTrans.localPosition = basePosition
    fatherTrans.localScale = Amaz.Vector3f(cameraScale.x, cameraScale.y, cameraScale.z)

    local passTrans = lb.pass_camera_1:getComponent("Transform")
    passTrans.localPosition = Amaz.Vector3f(0, 0, 0)
    passTrans.localScale = Amaz.Vector3f(ratio, 1, 1)

    for _, camInfo in ipairs(lb.allCameras) do
        camInfo.camera.type = lb.cameraType == "ortho" and 1 or 0
        camInfo.camera.fovy = fovy
        local camTransform = camInfo.entity:getComponent("Transform")
        if camTransform.children and camTransform.children:size() > 0 then
            local cameraFather = camTransform.children:get(0)
            cameraFather.localPosition = Amaz.Vector3f(
                basePosition.x, basePosition.y, basePosition.z)
            cameraFather.localScale = Amaz.Vector3f(
                cameraScale.x, cameraScale.y, cameraScale.z)
            if cameraFather.children and cameraFather.children:size() > 0 then
                local cameraPass = cameraFather.children:get(0)
                cameraPass.localPosition = Amaz.Vector3f(0, 0, 0)
                cameraPass.localScale = Amaz.Vector3f(ratio, 1, 1)
            end
        end
    end
end

function utils:applyFragmentTransform(lb)
    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
    local ratio = outputW / outputH
    local posZ0 = ratio / math.tan(math.rad(lb.fov * 0.5))
    local cameraPosition = lb.cameraPosition
    local basePx = (cameraPosition.x - 0.5) * 2 * ratio
    local basePy = (cameraPosition.y - 0.5) * 2
    local basePz = -posZ0 - cameraPosition.z * 2

    for _, leafCamera in ipairs(lb.leafCameras) do
        local camTransform = leafCamera.entity:getComponent("Transform")
        if camTransform.children and camTransform.children:size() > 0 then
            local fatherTrans = camTransform.children:get(0)
            local ndcAnchor = { 0.0, 0.0, 0.0 }
            local anchorType = leafCamera.anchorType or 1
            local anchorPoint = leafCamera.anchorPoint or { 0.5, 0.5, 0.0 }

            if anchorType == 0 and leafCamera.bounds then
                local bounds = leafCamera.bounds
                ndcAnchor[1] = (bounds.minX
                    + anchorPoint[1] * (bounds.maxX - bounds.minX)) * 2.0 - 1.0
                ndcAnchor[2] = (bounds.minY
                    + anchorPoint[2] * (bounds.maxY - bounds.minY)) * 2.0 - 1.0
            else
                ndcAnchor[1] = anchorPoint[1] * 2.0 - 1.0
                ndcAnchor[2] = anchorPoint[2] * 2.0 - 1.0
            end
            ndcAnchor[3] = anchorPoint[3] or 0.0

            -- One shared global position track moves every fragment equally.
            -- Apply it to renderer localPosition, not the camera hierarchy;
            -- moving both cameras and renderers would cancel the visible shake.
            local globalPosition = leafCamera.part and leafCamera.part.rt
                and leafCamera.part.rt.localPosition or { 0.0, 0.0, 0.0 }
            fatherTrans.localPosition = Amaz.Vector3f(
                basePx + leafCamera.translation[1] + globalPosition[1] + ndcAnchor[1] * ratio,
                basePy + leafCamera.translation[2] + globalPosition[2] + ndcAnchor[2],
                basePz + leafCamera.translation[3] + globalPosition[3] + ndcAnchor[3]
            )

            local cameraScale = lb.cameraScale
            fatherTrans.localScale = Amaz.Vector3f(
                cameraScale.x * leafCamera.scale[1],
                cameraScale.y * leafCamera.scale[2],
                cameraScale.z * leafCamera.scale[3]
            )
            fatherTrans.localOrientation = eulerToQuaternion(leafCamera.rotation)

            if fatherTrans.children and fatherTrans.children:size() > 0 then
                local passTrans = fatherTrans.children:get(0)
                passTrans.localPosition = Amaz.Vector3f(
                    -ndcAnchor[1] * ratio,
                    -ndcAnchor[2],
                    -ndcAnchor[3]
                )
                passTrans.localOrientation = eulerToQuaternion(
                    leafCamera.selfRotation or { 0.0, 0.0, 0.0 })
            end

            leafCamera.material:setFloat("u_alpha", leafCamera.alpha)
        end
    end
end

function utils:updateLeafCameraPass(lb, camInfo, outputW, outputH)
    camInfo.camera.renderTexture = camInfo.outputRT
    self:updateTexSize(camInfo.outputRT, outputW, outputH)
    camInfo.material:setTex("u_inputTexture", lb.InputTex)
    local splitLines = camInfo.splitLines
    if camInfo.splitTransform then
        splitLines = self:applySplitTransform(camInfo.splitPath,
            camInfo.splitTransform, lb.u_time, camInfo.splitType)
    end

    local splitCount = #splitLines
    local splitTypeInt = 0
    if camInfo.splitType == "circleSplit" then
        splitTypeInt = 1
    elseif camInfo.splitType == "loveType" then
        splitTypeInt = 2
    end
    camInfo.material:setInt("u_splitType", splitTypeInt)
    camInfo.material:setInt("u_splitCount", splitCount)

    for index = 1, math.min(splitCount, 7) do
        local splitLine = splitLines[index]
        camInfo.material:setVec4("u_split" .. (index - 1), Amaz.Vector4f(
            splitLine.lineA, splitLine.lineB, splitLine.lineC,
            splitLine.hidePositive))
    end
    for index = splitCount + 1, 7 do
        camInfo.material:setVec4("u_split" .. (index - 1),
            Amaz.Vector4f(0.0, 0.0, 0.0, 0.0))
    end

    for index = 1, math.min(splitCount, 7) do
        camInfo.material:setFloat("u_loveAngle" .. (index - 1),
            splitLines[index].loveAngle or 0.0)
    end
    for index = splitCount + 1, 7 do
        camInfo.material:setFloat("u_loveAngle" .. (index - 1), 0.0)
    end

    camInfo.material:setVec4("u_ScreenParams", Amaz.Vector4f(
        outputW, outputH, outputW / outputH, outputH / outputW))

    local global = camInfo.part.global
    local lineColor = global.lineColor or { 0.0, 0.0, 0.0, 1.0 }
    camInfo.material:setVec4("u_lineColor", Amaz.Vector4f(
        lineColor[1], lineColor[2], lineColor[3], lineColor[4]))
    camInfo.material:setFloat("u_lineWidth",
        math.min(outputW, outputH) / 720 * global.lineWidth)
    camInfo.material:setFloat("u_showLine", global.showLine == false and 0.0 or 1.0)
    camInfo.material:setFloat("u_lineMaskProgress",
        camInfo.part.rt.lineMaskProgress or 0.0)
    camInfo.material:setInt("u_maskType", global.maskType == "circle" and 1 or 0)

    local lineMask = global.lineMask
    if lineMask then
        local maskA, maskB, maskC = self:pointsToLineABC(lineMask.p1, lineMask.p2)
        camInfo.material:setFloat("u_maskA", maskA)
        camInfo.material:setFloat("u_maskB", maskB)
        camInfo.material:setFloat("u_maskC", maskC)
        local maskCenter = lineMask.center or { 0.5, 0.5 }
        camInfo.material:setVec2("u_maskCenter",
            Amaz.Vector2f(maskCenter[1], maskCenter[2]))
    end
end

function utils:updateBlendPass(lb)
    local blendMaterial = lb.blendMr.material
    local leafCount = #lb.leafCameras
    local uploadCount = math.min(leafCount, 15)
    blendMaterial:setInt("u_frag_num", uploadCount)

    local cameraOrder = {}
    for index = 1, leafCount do
        local leafCamera = lb.leafCameras[index]
        local depth = leafCamera.depth
        if depth == nil then depth = leafCamera.translation[3] end
        table.insert(cameraOrder, {
            cam = leafCamera,
            depth = depth,
            index = index,
        })
    end
    table.sort(cameraOrder, function(a, b)
        if a.depth ~= b.depth then return a.depth < b.depth end
        return a.index < b.index
    end)

    for index = 1, uploadCount do
        local cam = cameraOrder[index].cam
        local fragmentRT = cam.blendRT or cam.outputRT
        blendMaterial:setTex("u_fragmentTexture_" .. index, fragmentRT)
    end

    if lb.midTex then
        if lb.midTex.width ~= lb.OutputTex.width
            or lb.midTex.height ~= lb.OutputTex.height then
            lb.midTex.width = lb.OutputTex.width
            lb.midTex.height = lb.OutputTex.height
        end
    end
end

-- ============================================================
-- Camera ordering and layers
-- ============================================================

function utils:setLayer(cam, layer)
    local str = "1"
    for i = 1, layer do
        str = str .. "0"
    end
    local dynamic_bitset = Amaz.DynamicBitset.new(str)
    cam.layerVisibleMask = dynamic_bitset
end

local function setCameraOrderAndLayer(utilsObj, camera, layer, renderOrder)
    if camera == nil then
        return
    end
    camera.renderOrder = renderOrder
    utilsObj:setLayer(camera, layer)

    -- A camera only needs to see the renderers directly below its own
    -- transform.  Keeping those renderer layers in lockstep with the camera
    -- prevents one post-effect pass from accidentally sampling another pass.
    local transform = camera.entity:getComponent("Transform")
    if transform == nil or transform.children == nil then
        return
    end
    for i = 1, transform.children:size() do
        local rendererTrans = transform.children:get(i - 1)
        local renderers = rendererTrans.entity:getComponentsRecursive("Renderer")
        for j = 0, renderers:size() - 1 do
            local renderer = renderers:get(j)
            if renderer then
                renderer.entity.layer = layer
            end
        end
    end
end

-- LumiObjectExtension assigns the base layer/order of a LumiBlit group.  The
-- custom post-effect cameras are deliberately excluded from that generic
-- traversal; this hook appends them in the render graph and returns the next
-- free slot for any sibling effect.
function utils:orderManagedCameras(lb, startLayer, startOrder)
    local layer = startLayer or 1
    local renderOrder = startOrder or 1

    -- camera_1 is a hidden clone template.  The generic Lumi traversal still
    -- reserves its first slot, so keep that slot occupied to avoid sharing a
    -- layer with the first visible fragment camera.
    if lb.cameraTemplate then
        local templateCamera = lb.cameraTemplate:getComponent("Camera")
        if templateCamera then
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    for _, leafCamera in ipairs(lb.leafCameras or {}) do
        setCameraOrderAndLayer(self, leafCamera.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    -- Each Adjust clone is a three-camera pipeline: LUT generation, LUT
    -- application, then the splendor pass.
    for _, adjustInfo in ipairs(lb.adjustPasses or {}) do
        for _, camera in ipairs(adjustInfo.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    for _, negativeInfo in ipairs(lb.negativePasses or {}) do
        setCameraOrderAndLayer(self, negativeInfo.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    -- Brightness is a single full-screen camera and runs after Negative.
    for _, brightnessInfo in ipairs(lb.brightnessPasses or {}) do
        setCameraOrderAndLayer(self, brightnessInfo.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    -- MotionBlur2D is a single full-screen camera and runs after Brightness.
    for _, motionInfo in ipairs(lb.motionBlur2DPasses or {}) do
        setCameraOrderAndLayer(self, motionInfo.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    -- GaussianBlur keeps its own four-camera RT pipeline intact; only its
    -- cameras' layer/order are managed here.
    for _, blurInfo in ipairs(lb.gaussianBlurPasses or {}) do
        for _, camera in ipairs(blurInfo.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    -- DirectionalBlurs owns a downsample camera, four optional directional
    -- cameras and a final blend camera.  Their RT endpoints remain script-owned.
    for _, blurInfo in ipairs(lb.directionalBlursPasses or {}) do
        for _, camera in ipairs(blurInfo.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    -- DropShadow keeps its input, horizontal blur, vertical blur and final
    -- composite cameras in script-defined RT order.
    for _, shadowInfo in ipairs(lb.dropShadowPasses or {}) do
        for _, camera in ipairs(shadowInfo.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    -- cumCam is a scriptless custom camera pass and runs after the blur passes.
    for _, cumInfo in ipairs(lb.cumCamPasses or {}) do
        setCameraOrderAndLayer(self, cumInfo.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    -- SGlow is a six-camera pipeline: mask, two horizontal/vertical blur
    -- pairs, then the final glow composite.
    for _, glowInfo in ipairs(lb.sGlowPasses or {}) do
        for _, camera in ipairs(glowInfo.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    if lb.blendCam then
        setCameraOrderAndLayer(self, lb.blendCam, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    if lb.globalAdjustPass then
        for _, camera in ipairs(lb.globalAdjustPass.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    if lb.globalNegativePass and lb.globalNegativePass.camera then
        setCameraOrderAndLayer(self, lb.globalNegativePass.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    if lb.globalBrightnessPass and lb.globalBrightnessPass.camera then
        setCameraOrderAndLayer(self, lb.globalBrightnessPass.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    if lb.globalMotionBlur2DPass and lb.globalMotionBlur2DPass.camera then
        setCameraOrderAndLayer(self, lb.globalMotionBlur2DPass.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    if lb.globalGaussianBlurPass then
        for _, camera in ipairs(lb.globalGaussianBlurPass.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    if lb.globalDirectionalBlursPass then
        for _, camera in ipairs(lb.globalDirectionalBlursPass.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    if lb.globalDropShadowPass then
        for _, camera in ipairs(lb.globalDropShadowPass.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    if lb.globalSGlowPass then
        for _, camera in ipairs(lb.globalSGlowPass.cameras or {}) do
            setCameraOrderAndLayer(self, camera, layer, renderOrder)
            layer = layer + 1
            renderOrder = renderOrder + 1
        end
    end

    -- Global cumEffect runs after every other global post effect.
    if lb.globalCumCamPass and lb.globalCumCamPass.camera then
        setCameraOrderAndLayer(self, lb.globalCumCamPass.camera, layer, renderOrder)
        layer = layer + 1
        renderOrder = renderOrder + 1
    end

    return layer, renderOrder
end

--  fatherTrans  Camera blendCamEntity
function utils:findChild(lb, fatherTran, camArray)
    if isLumiPostEffectEntity(fatherTran.entity) then
        return
    end
    local cam = fatherTran.entity:getComponent("Camera")
    if cam and fatherTran.entity ~= lb.blendCamEntity then
        camArray[lb.orderIndex] = cam
        lb.orderIndex = lb.orderIndex + 1
    end
    if fatherTran.children then
        for i = 1, fatherTran.children:size() do
            local camTrans = fatherTran.children:get(i - 1)
            self:findChild(lb, camTrans, camArray)
        end
    end
end

--  layer
function utils:orderCam(lb, comp)
    lb.trans = comp.entity:getComponent("Transform")
    lb.orderIndex = 1
    local camArray = {}
    self:findChild(lb, lb.trans, camArray)

    -- Fragment Adjust passes are sorted before fragment negative passes.
    for _, adjustInfo in ipairs(lb.adjustPasses or {}) do
        for _, camera in ipairs(adjustInfo.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    -- Negative passes are sorted after every fragment Adjust pass.
    for _, negativeInfo in ipairs(lb.negativePasses or {}) do
        if negativeInfo.camera then
            camArray[lb.orderIndex] = negativeInfo.camera
            lb.orderIndex = lb.orderIndex + 1
        end
    end

    -- Brightness runs after every fragment Adjust/Negative pass.
    for _, brightnessInfo in ipairs(lb.brightnessPasses or {}) do
        if brightnessInfo.camera then
            camArray[lb.orderIndex] = brightnessInfo.camera
            lb.orderIndex = lb.orderIndex + 1
        end
    end

    -- MotionBlur2D runs after every fragment Adjust/Negative/Brightness pass.
    for _, motionInfo in ipairs(lb.motionBlur2DPasses or {}) do
        if motionInfo.camera then
            camArray[lb.orderIndex] = motionInfo.camera
            lb.orderIndex = lb.orderIndex + 1
        end
    end

    -- GaussianBlur keeps its four internal cameras in their original order.
    for _, blurInfo in ipairs(lb.gaussianBlurPasses or {}) do
        for _, camera in ipairs(blurInfo.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    -- DirectionalBlurs keeps its six internal cameras in pipeline order.
    for _, blurInfo in ipairs(lb.directionalBlursPasses or {}) do
        for _, camera in ipairs(blurInfo.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    -- DropShadow keeps all four internal cameras in its original RT order.
    for _, shadowInfo in ipairs(lb.dropShadowPasses or {}) do
        for _, camera in ipairs(shadowInfo.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    -- Scriptless cumCam passes run after the blur passes and before SGlow.
    for _, cumInfo in ipairs(lb.cumCamPasses or {}) do
        if cumInfo.camera then
            camArray[lb.orderIndex] = cumInfo.camera
            lb.orderIndex = lb.orderIndex + 1
        end
    end

    -- SGlow runs after every fragment Adjust/Negative/Brightness pass and before blendCam.
    for _, glowInfo in ipairs(lb.sGlowPasses or {}) do
        for _, camera in ipairs(glowInfo.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    -- blendCam always stays after all fragment post effects.
    if lb.blendCam then
        camArray[lb.orderIndex] = lb.blendCam
        lb.orderIndex = lb.orderIndex + 1
    end

    -- A global Adjust pass runs on the fully blended texture, after blendCam.
    if lb.globalAdjustPass then
        for _, camera in ipairs(lb.globalAdjustPass.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    -- A global negative pass runs after the global Adjust pass (or directly
    -- after blendCam when no global Adjust is configured).
    if lb.globalNegativePass and lb.globalNegativePass.camera then
        camArray[lb.orderIndex] = lb.globalNegativePass.camera
        lb.orderIndex = lb.orderIndex + 1
    end

    -- Global Brightness runs after the global Negative pass.
    if lb.globalBrightnessPass and lb.globalBrightnessPass.camera then
        camArray[lb.orderIndex] = lb.globalBrightnessPass.camera
        lb.orderIndex = lb.orderIndex + 1
    end

    -- Global MotionBlur2D runs after global Brightness and before SGlow.
    if lb.globalMotionBlur2DPass and lb.globalMotionBlur2DPass.camera then
        camArray[lb.orderIndex] = lb.globalMotionBlur2DPass.camera
        lb.orderIndex = lb.orderIndex + 1
    end

    if lb.globalGaussianBlurPass then
        for _, camera in ipairs(lb.globalGaussianBlurPass.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    if lb.globalDirectionalBlursPass then
        for _, camera in ipairs(lb.globalDirectionalBlursPass.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    if lb.globalDropShadowPass then
        for _, camera in ipairs(lb.globalDropShadowPass.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    -- Global SGlow runs before the optional global cumEffect pass.
    if lb.globalSGlowPass then
        for _, camera in ipairs(lb.globalSGlowPass.cameras or {}) do
            if camera then
                camArray[lb.orderIndex] = camera
                lb.orderIndex = lb.orderIndex + 1
            end
        end
    end

    -- Global cumEffect is the final pass after the complete global chain.
    if lb.globalCumCamPass and lb.globalCumCamPass.camera then
        camArray[lb.orderIndex] = lb.globalCumCamPass.camera
        lb.orderIndex = lb.orderIndex + 1
    end

    for i = 1, lb.orderIndex - 1 do
        camArray[i].renderOrder = i
        self:setLayer(camArray[i], i)
        local transform = camArray[i].entity:getComponent("Transform")
        if transform.children then
            for j = 1, transform.children:size() do
                local rendererTrans = transform.children:get(j - 1)
                local renderers = rendererTrans.entity:getComponentsRecursive("Renderer")
                for k = 0, renderers:size() - 1 do
                    local renderer = renderers:get(k)
                    if renderer then
                        renderer.entity.layer = i
                    end
                end
            end
        end
    end
end

-- ============================================================
-- RenderTexture
-- ============================================================

function utils:createRenderTexture(width, height, filterMag, filterMin)
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

function utils:updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

-- ============================================================
--  splitTree
-- ============================================================
function utils:resolveSplitTree(fragmentsData)
    if not fragmentsData.useMultiAspect then
        return fragmentsData.splitTree["1:1"]
    end

    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
    local aspect = outputW / outputH

    local ratios = {
        { key = "1:1",  val = 1.0 },
        { key = "16:9", val = 16.0 / 9.0 },
        { key = "4:3",  val = 4.0 / 3.0 },
        { key = "3:4",  val = 3.0 / 4.0 },
        { key = "9:16", val = 9.0 / 16.0 },
    }

    local best = ratios[1]
    local bestDiff = math.abs(aspect - best.val)
    for _, r in ipairs(ratios) do
        local diff = math.abs(aspect - r.val)
        if diff < bestDiff then
            best = r
            bestDiff = diff
        end
    end

    return fragmentsData.splitTree[best.key]
end

-- ============================================================
-- 
-- ============================================================

--  UV  A*x + B*y + C = 0
-- //
function utils:pointsToLineABC(p1, p2)
    local A = p1[2] - p2[2]                 -- y1 - y2
    local B = p2[1] - p1[1]                 -- x2 - x1
    local C = p1[1] * p2[2] - p2[1] * p1[2] -- x1*y2 - x2*y1
    return A, B, C
end

-- ============================================================
--  / 
-- ============================================================

-- sidePath →  {0, 0} → "camera_1_1"
function utils:pathToName(sidePath)
    local parts = { "camera" }
    for _, s in ipairs(sidePath) do
        table.insert(parts, s == 0 and "1" or "2")
    end
    return table.concat(parts, "_")
end

-- 
function utils:copyTable(t)
    local new = {}
    for _, v in ipairs(t or {}) do
        table.insert(new, v)
    end
    return new
end

-- ============================================================
--  InputTex
--  splitPath 
--  RT 
--  alpha 
-- ============================================================
function utils:buildPipeline(node, inputSource, sidePath, splitPath, comp, lb, splitType, treeIndex, part, namePrefix)
    -- customLine: flat list of splits, one camera per tree
    if splitType == "customLine" then
        local splitPath = {}
        for _, sp in ipairs(node.splits) do
            local a, b, c = self:pointsToLineABC(sp.p1, sp.p2)
            table.insert(splitPath, { lineA = a, lineB = b, lineC = c, hidePositive = sp.hidePositive })
        end
        local leafKey = "camera_t" .. treeIndex
        local rt = self:createRenderTexture(1, 1)
        local cam = self:createLeafCamera(lb, comp, namePrefix .. leafKey, rt, splitPath)
        cam.inputSource = inputSource
        cam.splitPath = splitPath
        cam.splitTransform = node.transform -- split-level TRS + animation
        cam.isLeaf = true
        cam.leafKey = leafKey
        cam.part = part
        cam.splitType = splitType
        table.insert(lb.allCameras, cam)
        table.insert(lb.leafRTs, rt)
        table.insert(lb.leafCameras, cam)
        return
    end

    local lineA, lineB, lineC
    if splitType == "circleSplit" then
        lineA = node.center[1]
        lineB = node.center[2]
        lineC = node.radius * node.radius
    elseif splitType == "loveType" then
        lineA = node.center[1]
        lineB = node.center[2]
        lineC = node.scale
    else
        lineA, lineB, lineC = self:pointsToLineABC(node.p1, node.p2)
    end

    -- ---------- below (_1) ----------
    local belowPath = self:copyTable(sidePath)
    table.insert(belowPath, 0)
    local belowName
    if treeIndex then
        belowName = "camera_t" .. treeIndex
    else
        belowName = self:pathToName(belowPath)
    end

    local belowSplitPath = self:copyTable(splitPath)
    local belowEntry = { lineA = lineA, lineB = lineB, lineC = lineC, hidePositive = 1.0 }
    if splitType == "loveType" then belowEntry.loveAngle = node.angle or 0.0 end
    table.insert(belowSplitPath, belowEntry)

    if node.below == false then
        -- skip: false,
    elseif node.below ~= nil then
        self:buildPipeline(node.below, inputSource, belowPath, belowSplitPath, comp, lb, splitType, treeIndex, part, namePrefix)
    else
        local belowRT = self:createRenderTexture(1, 1)
        local belowCam = self:createLeafCamera(lb, comp, namePrefix .. belowName,
            belowRT, belowSplitPath)
        belowCam.inputSource = inputSource
        belowCam.splitPath = belowSplitPath
        belowCam.splitTransform = node.transform
        belowCam.isLeaf = true
        belowCam.leafKey = belowName
        belowCam.part = part
        belowCam.splitType = splitType
        table.insert(lb.allCameras, belowCam)
        table.insert(lb.leafRTs, belowRT)
        table.insert(lb.leafCameras, belowCam)
    end

    -- ---------- above (_2) ----------
    local abovePath = self:copyTable(sidePath)
    table.insert(abovePath, 1)
    local aboveName
    if treeIndex then
        aboveName = "camera_t" .. treeIndex
    else
        aboveName = self:pathToName(abovePath)
    end

    local aboveSplitPath = self:copyTable(splitPath)
    local aboveEntry = { lineA = lineA, lineB = lineB, lineC = lineC, hidePositive = 0.0 }
    if splitType == "loveType" then aboveEntry.loveAngle = node.angle or 0.0 end
    table.insert(aboveSplitPath, aboveEntry)

    if node.above == false then
        -- skip: false,
    elseif node.above ~= nil then
        self:buildPipeline(node.above, inputSource, abovePath, aboveSplitPath, comp, lb, splitType, treeIndex, part, namePrefix)
    else
        local aboveRT = self:createRenderTexture(1, 1)
        local aboveCam = self:createLeafCamera(lb, comp, namePrefix .. aboveName,
            aboveRT, aboveSplitPath)
        aboveCam.inputSource = inputSource
        aboveCam.splitPath = aboveSplitPath
        aboveCam.splitTransform = node.transform
        aboveCam.isLeaf = true
        aboveCam.leafKey = aboveName
        aboveCam.part = part
        aboveCam.splitType = splitType
        table.insert(lb.allCameras, aboveCam)
        table.insert(lb.leafRTs, aboveRT)
        table.insert(lb.leafCameras, aboveCam)
    end
end

-- ============================================================
-- Sutherland–Hodgman A*x+B*y+C=0 
-- keepSign > 0  A*x+B*y+C >= 0 
-- keepSign < 0  A*x+B*y+C <= 0 
-- ============================================================
function utils:clipPolygon(poly, A, B, C, keepSign)
    local out = {}
    local n = #poly
    if n == 0 then return out end

    for i = 1, n do
        local curr = poly[i]
        local next = poly[i % n + 1]

        local cv = A * curr[1] + B * curr[2] + C
        local nv = A * next[1] + B * next[2] + C

        local currInside = false
        local nextInside = false
        if keepSign > 0 then
            currInside = (cv >= -0.000001)
            nextInside = (nv >= -0.000001)
        else
            currInside = (cv <= 0.000001)
            nextInside = (nv <= 0.000001)
        end

        if currInside then
            table.insert(out, { curr[1], curr[2] })
        end

        if currInside ~= nextInside then
            local t = cv / (cv - nv)
            table.insert(out, { curr[1] + t * (next[1] - curr[1]),
                curr[2] + t * (next[2] - curr[2]) })
        end
    end

    return out
end

-- ============================================================
-- 
-- splitPath: { {lineA, lineB, lineC, hidePositive}, ... }
-- ============================================================
function utils:computeLeafPolygon(splitPath)
    local poly = { { 0, 0 }, { 1, 0 }, { 1, 1 }, { 0, 1 } } -- UV 
    for _, sp in ipairs(splitPath) do
        -- hidePositive=1 → keep negative side, hidePositive=0 → keep positive side
        local keepSign = (sp.hidePositive == 1.0) and -1 or 1
        poly = self:clipPolygon(poly, sp.lineA, sp.lineB, sp.lineC, keepSign)
        if #poly == 0 then break end
    end
    return poly
end

-- ============================================================
-- UV 
-- ============================================================
function utils:computeCentroid(poly)
    if #poly == 0 then return { 0.5, 0.5 } end
    local cx, cy = 0.0, 0.0
    for _, v in ipairs(poly) do
        cx = cx + v[1]
        cy = cy + v[2]
    end
    return { cx / #poly, cy / #poly } -- UV 
end

-- ============================================================
-- UV 
-- ============================================================
function utils:computeBounds(poly)
    if #poly == 0 then return { minX = 0, maxX = 1, minY = 0, maxY = 1 } end
    local minX, maxX = 1.0, 0.0
    local minY, maxY = 1.0, 0.0
    for _, v in ipairs(poly) do
        if v[1] < minX then minX = v[1] end
        if v[1] > maxX then maxX = v[1] end
        if v[2] < minY then minY = v[2] end
        if v[2] > maxY then maxY = v[2] end
    end
    return { minX = minX, maxX = maxX, minY = minY, maxY = maxY }
end

-- ============================================================
-- circleSplit: 20x20 grid sampling, splitPath (lineA=cx,lineB=cy,lineC=r²)
-- ============================================================
function utils:computeLeafBoundsBySampling(splitPath, splitType)
    local minX, maxX, minY, maxY = 1.0, 0.0, 1.0, 0.0
    local W = Amaz.BuiltinObject.getOutputTextureWidth()
    local H = Amaz.BuiltinObject.getOutputTextureHeight()
    local minDim = math.min(W, H)
    local samples = 20
    for i = 0, samples do
        for j = 0, samples do
            local x, y = i / samples, j / samples
            local keep = true
            for _, sp in ipairs(splitPath) do
                local dx = x - sp.lineA
                local dy = y - sp.lineB
                local sideVal
                if splitType == "loveType" then
                    local angle = sp.loveAngle or 0.0
                    local ux = dx * W / minDim
                    local uy = dy * H / minDim
                    local ca, sa = math.cos(angle), math.sin(angle)
                    local rx = ux*ca - uy*sa
                    local ry = ux*sa + uy*ca
                    local sc = math.max(sp.lineC, 0.001)
                    local hx, hy = rx/sc, ry/sc
                    local h2 = hx*hx + hy*hy
                    local h2m1 = h2 - 1.0
                    sideVal = h2m1*h2m1*h2m1 - hx*hx * hy*hy*hy
                else
                    sideVal = dx*dx*W*W + dy*dy*H*H - sp.lineC * minDim * minDim
                end
                local isPositive = (sideVal >= -0.000001)
                if sp.hidePositive == 1.0 then
                    if isPositive then keep = false; break end
                else
                    if not isPositive then keep = false; break end
                end
            end
            if keep then
                if x < minX then minX = x end
                if x > maxX then maxX = x end
                if y < minY then minY = y end
                if y > maxY then maxY = y end
            end
        end
    end
    return { minX = minX, maxX = maxX, minY = minY, maxY = maxY }
end

-- ============================================================
-- anchorPoint[0..1]
-- anchorPoint=(0.5,0.5) → =
-- anchorPoint=(0,0)     →
-- anchorPoint=(1,1)     →
--  NDC
-- ============================================================
function utils:computeAnchorFromBounds(bounds, anchorPoint)
    local ax = anchorPoint[1] or 0.5
    local ay = anchorPoint[2] or 0.5
    local ndcX = (bounds.minX + ax * (bounds.maxX - bounds.minX)) * 2.0 - 1.0
    local ndcY = (bounds.minY + ay * (bounds.maxY - bounds.minY)) * 2.0 - 1.0
    return { ndcX, ndcY, anchorPoint[3] or 0.0 }
end

-- ============================================================
-- 
-- ============================================================
local Easing = {}

local EPSILON = 0.000001

local function clamp01(v)
    if v < 0.0 then return 0.0 end
    if v > 1.0 then return 1.0 end
    return v
end

function Easing.linear(t) return t end

function Easing.easeIn(t) return t * t end

function Easing.easeOut(t) return 1.0 - (1.0 - t) * (1.0 - t) end

function Easing.easeInOut(t)
    if t < 0.5 then return 2.0 * t * t end
    return 1.0 - (-2.0 * t + 2.0) ^ 2.0 / 2.0
end

function Easing.easeOutBack(t)
    local c1 = 1.70158
    local c3 = c1 + 1.0
    return 1.0 + c3 * (t - 1.0) ^ 3.0 + c1 * (t - 1.0) ^ 2.0
end

function Easing.easeOutElastic(t)
    if t == 0.0 or t == 1.0 then return t end
    return 2.0 ^ (-10.0 * t) * math.sin((t - 1.0) * (2.0 * math.pi) / 0.3) + 1.0
end

-- softened elastic: wobble amplitude ramps up with t, much gentler overshoot than easeOutElastic
function Easing.easeOutElasticSoft(t)
    if t == 0.0 or t == 1.0 then return t end
    return 0.8 * t * 2.0 ^ (-10.0 * t) * math.sin((t - 1.0) * (2.0 * math.pi) / 0.3) + 1.0
end

function Easing.easeOutBounce(t)
    local n1 = 7.5625
    local d1 = 2.75
    if t < 1.0 / d1 then
        return n1 * t * t
    elseif t < 2.0 / d1 then
        t = t - 1.5 / d1
        return n1 * t * t + 0.75
    elseif t < 2.5 / d1 then
        t = t - 2.25 / d1
        return n1 * t * t + 0.9375
    else
        t = t - 2.625 / d1
        return n1 * t * t + 0.984375
    end
end

-- 
function Easing.easeInQuart(t)
    return t * t * t * t
end

function Easing.easeOutQuart(t)
    local u = 1.0 - t
    return 1.0 - u * u * u * u
end

function Easing.easeInExpo(t)
    if t <= 0.0 then return 0.0 end
    return 2.0 ^ (10.0 * (t - 1.0))
end

function Easing.easeOutExpo(t)
    return (1.0 - 2.0 ^ (-10.0 * t)) / (1.0 - 2.0 ^ (-10.0))
end

local function bezierValue(s, p1, p2)
    local inv = 1.0 - s
    return 3.0 * inv * inv * s * p1 + 3.0 * inv * s * s * p2 + s * s * s
end

local function bezierDerivative(s, p1, p2)
    local inv = 1.0 - s
    return 3.0 * inv * inv * p1 + 6.0 * inv * s * (p2 - p1) + 3.0 * s * s * (1.0 - p2)
end

-- Timing cubic Bezier: x is time, y is animation progress. y may overshoot [0, 1].
function Easing.cubicBezier(t, spec)
    if t <= 0.0 then return 0.0 end
    if t >= 1.0 then return 1.0 end

    local values = spec.value or spec.values or spec
    local x1 = spec.x1 or values[1]
    local y1 = spec.y1 or values[2]
    local x2 = spec.x2 or values[3]
    local y2 = spec.y2 or values[4]

    -- Newton iteration is fast for normal timing curves.
    local s = t
    for _ = 1, 7 do
        local errorX = bezierValue(s, x1, x2) - t
        if math.abs(errorX) <= EPSILON then break end
        local derivative = bezierDerivative(s, x1, x2)
        if math.abs(derivative) <= EPSILON then break end
        s = clamp01(s - errorX / derivative)
    end

    -- A bisection fallback makes very flat handles deterministic and seek-safe.
    if math.abs(bezierValue(s, x1, x2) - t) > 0.00001 then
        local low, high = 0.0, 1.0
        for _ = 1, 16 do
            s = (low + high) * 0.5
            if bezierValue(s, x1, x2) < t then low = s else high = s end
        end
    end

    return bezierValue(s, y1, y2)
end

-- Analytic damped spring response. The normalized segment duration is one second.
-- The sampler pins t=0 and t=1 exactly so a transition always has stable endpoints.
function Easing.spring(t, spec)
    if t <= 0.0 then return 0.0 end
    if t >= 1.0 then return 1.0 end

    local mass = spec.mass or 1.0
    local stiffness = spec.stiffness or 170.0
    local damping = spec.damping or 20.0
    local initialVelocity = spec.initialVelocity or 0.0

    local omega0 = math.sqrt(stiffness / mass)
    local zeta = damping / (2.0 * math.sqrt(stiffness * mass))
    local y

    -- y is displacement from the target: y(0)=-1, progress=1+y.
    if zeta < 1.0 - EPSILON then
        local omegaD = omega0 * math.sqrt(1.0 - zeta * zeta)
        local a = -1.0
        local b = (initialVelocity - zeta * omega0) / omegaD
        y = math.exp(-zeta * omega0 * t)
            * (a * math.cos(omegaD * t) + b * math.sin(omegaD * t))
    elseif zeta > 1.0 + EPSILON then
        local root = math.sqrt(zeta * zeta - 1.0)
        local r1 = -omega0 * (zeta - root)
        local r2 = -omega0 * (zeta + root)
        local a = -1.0
        local c1 = (initialVelocity - r2 * a) / (r1 - r2)
        local c2 = a - c1
        y = c1 * math.exp(r1 * t) + c2 * math.exp(r2 * t)
    else
        local a = -1.0
        local b = initialVelocity - omega0
        y = (a + b * t) * math.exp(-omega0 * t)
    end

    return 1.0 + y
end

function Easing.getValue(t, curveSpec)
    if curveSpec == nil then return t end
    if type(curveSpec) == "string" then
        local fn = Easing[curveSpec]
        return fn and fn(t) or t
    end
    if type(curveSpec) == "table" then
        local curveType = curveSpec.type or curveSpec.name
        if curveType == "cubicBezier" then return Easing.cubicBezier(t, curveSpec) end
        if curveType == "spring" then return Easing.spring(t, curveSpec) end
        local fn = Easing[curveType]
        return fn and fn(t) or t
    end
    return t
end

-- ============================================================
-- 
-- ============================================================
function utils:lerp(a, b, t)
    if type(a) == "table" then
        local r = {}
        for i = 1, #a do r[i] = a[i] + (b[i] - a[i]) * t end
        return r
    end
    return a + (b - a) * t
end

function utils:copyValue(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for key, item in pairs(value) do result[key] = self:copyValue(item) end
    return result
end

-- The single sampling policy used by fragment, global and split-transform tracks.
-- Before the first segment: first start value. In a gap: previous end value.
-- After the final segment: final end value. This makes seeking deterministic.
function utils:sampleTrack(parts, t, defaultValue)
    if type(parts) ~= "table" or #parts == 0 then
        return self:copyValue(defaultValue)
    end

    local previousEnd = nil
    for _, part in ipairs(parts) do
        local tStart, tEnd = part.time[1], part.time[2]
        if t < tStart then
            return self:copyValue(previousEnd ~= nil and previousEnd or part.startVal)
        end
        if t <= tEnd then
            local duration = tEnd - tStart
            if duration <= EPSILON then return self:copyValue(part.endVal) end
            local rawT = clamp01((t - tStart) / duration)
            local easedT = Easing.getValue(rawT, part.curve or "linear")
            return self:lerp(part.startVal, part.endVal, easedT)
        end
        previousEnd = part.endVal
    end

    return self:copyValue(previousEnd ~= nil and previousEnd or defaultValue)
end

-- Sample an animation track inside an optional normalized time window.  A
-- timed descriptor has the form { track = <track>, startTime = 0.2,
-- endTime = 0.8 }.  Outside the window the additive value is zero/default;
-- inside it, the wrapped track is remapped to its own [0, 1] timeline.
function utils:sampleTimedTrack(spec, t, defaultValue)
    if type(spec) ~= "table" then
        return self:copyValue(defaultValue)
    end

    local parts = spec
    local startTime = 0.0
    local endTime = 1.0
    if spec.track ~= nil then
        parts = spec.track
        startTime = tonumber(spec.startTime) or 0.0
        endTime = tonumber(spec.endTime) or 1.0
    end

    if endTime <= startTime then
        return self:copyValue(defaultValue)
    end
    if t < startTime then
        return self:copyValue(defaultValue)
    end

    local localTime = (t - startTime) / (endTime - startTime)
    if localTime < 0.0 then localTime = 0.0 end
    if localTime > 1.0 then localTime = 1.0 end
    return self:sampleTrack(parts, localTime, defaultValue)
end

-- Stable pseudo-random values. The result depends only on seed+salt, never call order.
local RANDOM_MOD = 2147483647
local RANDOM_MIX_MOD = 10000019
local function seedToNumber(seed)
    if type(seed) == "number" then
        local value = math.floor(math.abs(seed)) % RANDOM_MOD
        return value == 0 and 1 or value
    end
    local text = tostring(seed or 1)
    local value = 1
    for i = 1, #text do value = (value * 131 + string.byte(text, i)) % RANDOM_MOD end
    return value == 0 and 1 or value
end

function utils:random01(seed, salt)
    local text = tostring(seed or 1) .. ":" .. tostring(salt or 0)
    local state = (seedToNumber(text) + 3 * seedToNumber(string.reverse(text))) % RANDOM_MIX_MOD
    -- Squaring under a small prime breaks the correlation between sequential salts while
    -- remaining exactly representable by Lua's double-precision number type.
    state = (state * state + 19349663) % RANDOM_MIX_MOD
    state = (state * state + 83492791) % RANDOM_MIX_MOD
    state = (state * state + 2654435761) % RANDOM_MIX_MOD
    return state / (RANDOM_MIX_MOD - 1)
end

function utils:randomSigned(seed, salt)
    return self:random01(seed, salt) * 2.0 - 1.0
end

local function normalizedOrdinal(value, count, from)
    if not value or not count or count <= 1 then return 0.0 end
    local n = clamp01((value - 1.0) / (count - 1.0))
    if from == "end" or from == "bottom" or from == "right" then return 1.0 - n end
    if from == "center" then return math.abs(n - 0.5) * 2.0 end
    if from == "edges" then return 1.0 - math.abs(n - 0.5) * 2.0 end
    return n
end

local function normalizedDistance(point, origin)
    local dx, dy = point[1] - origin[1], point[2] - origin[2]
    local farX = math.max(math.abs(origin[1]), math.abs(1.0 - origin[1]))
    local farY = math.max(math.abs(origin[2]), math.abs(1.0 - origin[2]))
    local maxDistance = math.sqrt(farX * farX + farY * farY)
    if maxDistance <= EPSILON then return 0.0 end
    return clamp01(math.sqrt(dx * dx + dy * dy) / maxDistance)
end

-- Composable stagger from index, row, column, fragment center, impact distance and seeded jitter.
function utils:computeStagger(meta, cfg)
    meta, cfg = meta or {}, cfg or {}
    local delay = cfg.base or 0.0
    local center = meta.center or { 0.5, 0.5 }

    delay = delay + (meta.index and (meta.index - 1) or 0) * (cfg.indexAmount or 0.0)
    delay = delay + normalizedOrdinal(meta.row, meta.rowCount, cfg.rowFrom)
        * (cfg.rowAmount or 0.0)
    delay = delay + normalizedOrdinal(meta.column, meta.columnCount, cfg.columnFrom)
        * (cfg.columnAmount or 0.0)

    if cfg.centerAmount then
        delay = delay + normalizedDistance(center, cfg.centerPoint or { 0.5, 0.5 })
            * cfg.centerAmount
    end
    if cfg.impactAmount and cfg.impactPoint then
        delay = delay + normalizedDistance(center, cfg.impactPoint) * cfg.impactAmount
    end
    if cfg.randomAmount and cfg.randomAmount ~= 0.0 then
        local salt = meta.id or meta.index or (tostring(meta.row) .. ":" .. tostring(meta.column))
        local randomValue = self:random01(cfg.seed or 1, salt)
        if cfg.randomSigned ~= false then randomValue = randomValue * 2.0 - 1.0 end
        delay = delay + randomValue * cfg.randomAmount
    end

    local minDelay = cfg.minDelay or 0.0
    if delay < minDelay then delay = minDelay end
    if cfg.maxDelay and delay > cfg.maxDelay then delay = cfg.maxDelay end
    return delay
end

-- Generates anticipation -> main -> settle -> hold segments for one property.
function utils:buildPhaseTrack(spec)
    assert(type(spec) == "table", "buildPhaseTrack: spec must be a table")
    assert(spec.startVal ~= nil, "buildPhaseTrack: startVal is required")

    local track = {}
    local cursor = (spec.startTime or 0.0) + (spec.delay or 0.0)
    local current = self:copyValue(spec.startVal)

    local function appendStage(name, stage)
        if not stage then return end
        local duration = stage.duration or 0.0
        assert(duration >= 0.0, "buildPhaseTrack: " .. name .. " duration must be >= 0")
        local endValue = stage.endVal
        if endValue == nil then endValue = stage.value end
        assert(endValue ~= nil, "buildPhaseTrack: " .. name .. " endVal is required")
        if duration > EPSILON then
            table.insert(track, {
                stage = name,
                time = { cursor, cursor + duration },
                curve = stage.curve or "linear",
                startVal = self:copyValue(current),
                endVal = self:copyValue(endValue),
            })
            cursor = cursor + duration
        end
        current = self:copyValue(endValue)
    end

    appendStage("anticipation", spec.anticipation)
    appendStage("main", spec.main)
    appendStage("settle", spec.settle)

    local holdEnd = spec.holdEnd
        or (spec.hold and (spec.hold.endTime or spec.hold.time))
        or 1.0
    assert(holdEnd + EPSILON >= cursor,
        "buildPhaseTrack: hold end precedes the settle end")
    if holdEnd > cursor + EPSILON then
        table.insert(track, {
            stage = "hold",
            time = { cursor, holdEnd },
            curve = "linear",
            startVal = self:copyValue(current),
            endVal = self:copyValue(current),
        })
    end
    return track
end

function utils:buildPhasedAnimation(trackSpecs)
    local animation = {}
    for property, spec in pairs(trackSpecs or {}) do
        animation[property] = self:buildPhaseTrack(spec)
    end
    return animation
end

local FRAGMENT_TRACKS = {
    localPosition = 3,
    localRotation = 3,
    localScale = 3,
    selfRotation = 3,
    alpha = 1,
    depth = 1,
}

local SPLIT_TRACKS = {
    splitPosition = 3,
    splitRotation = 3,
    splitScale = 3,
}

local GLOBAL_TRACKS = {
    lineMaskProgress = 1,
    localPosition = 3,
}

local function validationError(path, message)
    error("fragmentsData validation failed at " .. path .. ": " .. message, 0)
end

local function isFiniteNumber(value)
    return type(value) == "number" and value == value
        and value > -math.huge and value < math.huge
end

local function validateValue(value, dimension, path)
    if dimension == 1 then
        if not isFiniteNumber(value) then validationError(path, "expected a finite number") end
        return
    end
    if type(value) ~= "table" or #value ~= dimension then
        validationError(path, "expected a " .. dimension .. "-component vector")
    end
    for i = 1, dimension do
        if not isFiniteNumber(value[i]) then
            validationError(path .. "[" .. i .. "]", "expected a finite number")
        end
    end
end

local function validateCurve(curve, path)
    if curve == nil then return end
    if type(curve) == "string" then
        if curve == "cubicBezier" or curve == "spring" then
            validationError(path, curve .. " requires a parameter table")
        end
        if type(Easing[curve]) ~= "function" then validationError(path, "unknown curve '" .. curve .. "'") end
        return
    end
    if type(curve) ~= "table" then validationError(path, "curve must be a name or parameter table") end

    local curveType = curve.type or curve.name
    if curveType == "cubicBezier" then
        local values = curve.value or curve.values or curve
        local x1 = curve.x1 or values[1]
        local y1 = curve.y1 or values[2]
        local x2 = curve.x2 or values[3]
        local y2 = curve.y2 or values[4]
        if not isFiniteNumber(x1) or not isFiniteNumber(y1)
            or not isFiniteNumber(x2) or not isFiniteNumber(y2) then
            validationError(path, "cubicBezier requires four finite control values")
        end
        if x1 < 0.0 or x1 > 1.0 or x2 < 0.0 or x2 > 1.0 then
            validationError(path, "cubicBezier x1/x2 must stay in [0, 1]")
        end
    elseif curveType == "spring" then
        local mass = curve.mass or 1.0
        local stiffness = curve.stiffness or 170.0
        local damping = curve.damping or 20.0
        local velocity = curve.initialVelocity or 0.0
        if not isFiniteNumber(mass) or mass <= 0.0 then validationError(path .. ".mass", "must be > 0") end
        if not isFiniteNumber(stiffness) or stiffness <= 0.0 then validationError(path .. ".stiffness", "must be > 0") end
        if not isFiniteNumber(damping) or damping < 0.0 then validationError(path .. ".damping", "must be >= 0") end
        if not isFiniteNumber(velocity) then validationError(path .. ".initialVelocity", "must be finite") end
    elseif type(Easing[curveType]) ~= "function" then
        validationError(path, "unknown curve type '" .. tostring(curveType) .. "'")
    end
end

local function validateTrack(parts, dimension, path)
    if type(parts) ~= "table" or #parts == 0 then validationError(path, "track must contain at least one segment") end
    local previousEnd = nil
    for i, part in ipairs(parts) do
        local partPath = path .. "[" .. i .. "]"
        if type(part) ~= "table" or type(part.time) ~= "table" then
            validationError(partPath, "segment.time is required")
        end
        local tStart, tEnd = part.time[1], part.time[2]
        if not isFiniteNumber(tStart) or not isFiniteNumber(tEnd) then
            validationError(partPath .. ".time", "start/end must be finite numbers")
        end
        if tStart < 0.0 or tEnd > 1.0 then
            validationError(partPath .. ".time", "time must stay inside [0, 1]")
        end
        if tEnd - tStart <= EPSILON then
            validationError(partPath .. ".time", "segment duration must be greater than zero")
        end
        if previousEnd and tStart < previousEnd - EPSILON then
            validationError(partPath .. ".time", "segments overlap or are out of order")
        end
        validateValue(part.startVal, dimension, partPath .. ".startVal")
        validateValue(part.endVal, dimension, partPath .. ".endVal")
        validateCurve(part.curve, partPath .. ".curve")
        previousEnd = tEnd
    end
end

local function validateAnimation(animation, allowedTracks, path)
    if animation == nil then return end
    if type(animation) ~= "table" then validationError(path, "animation must be a table") end
    for property, track in pairs(animation) do
        local dimension = allowedTracks[property]
        if not dimension then validationError(path .. "." .. tostring(property), "unsupported animated property") end
        if type(track) == "table" and track.track ~= nil then
            local startTime = track.startTime
            local endTime = track.endTime
            if startTime == nil then startTime = 0.0 end
            if endTime == nil then endTime = 1.0 end
            if not isFiniteNumber(startTime) or not isFiniteNumber(endTime) then
                validationError(path .. "." .. property .. ".time",
                    "startTime/endTime must be finite numbers")
            end
            if startTime < 0.0 or endTime > 1.0 or endTime <= startTime then
                validationError(path .. "." .. property .. ".time",
                    "startTime/endTime must satisfy 0 <= startTime < endTime <= 1")
            end
            validateTrack(track.track, dimension, path .. "." .. property .. ".track")
        else
            validateTrack(track, dimension, path .. "." .. property)
        end
    end
end

local function validateSplitNode(node, splitType, depth, path)
    if type(node) ~= "table" then validationError(path, "split node must be a table") end
    if depth > 7 then validationError(path, "split depth exceeds shader limit 7") end
    if node.transform then
        validateAnimation(node.transform.animation, SPLIT_TRACKS, path .. ".transform.animation")
    end

    local leafCount = 0
    for _, branchName in ipairs({ "below", "above" }) do
        local branch = node[branchName]
        if branch == false then
            -- Explicitly empty side.
        elseif type(branch) == "table" then
            leafCount = leafCount + validateSplitNode(branch, splitType, depth + 1,
                path .. "." .. branchName)
        elseif branch == nil then
            leafCount = leafCount + 1
        else
            validationError(path .. "." .. branchName, "must be a split node, false or nil")
        end
    end
    return leafCount
end

local function validateCustomTrees(trees, path)
    if type(trees) ~= "table" or #trees == 0 then
        validationError(path, "customLine requires a non-empty splitTrees array")
    end
    for i, tree in ipairs(trees) do
        local treePath = path .. "[" .. i .. "]"
        if type(tree) ~= "table" or type(tree.splits) ~= "table" then
            validationError(treePath, "splits array is required")
        end
        if #tree.splits > 7 then validationError(treePath .. ".splits", "exceeds shader limit 7") end
        if tree.transform then
            validateAnimation(tree.transform.animation, SPLIT_TRACKS,
                treePath .. ".transform.animation")
        end
    end
    return #trees
end

function utils:validateFragmentsData(data)
    if type(data) ~= "table" then validationError("root", "expected a table") end
    if type(data.input1) ~= "table" then validationError("input1", "single-texture configuration is required") end
    local totalLeaves = 0

    for _, inputName in ipairs({ "input1" }) do
        local input = data[inputName]
        if input then
            local inputPath = inputName
            local splitType = input.splitType or "lineSplit"
            if input.fragments then
                for fragmentId, fragment in pairs(input.fragments) do
                    local fragmentPath = inputPath .. ".fragments." .. tostring(fragmentId)
                    if type(fragment) ~= "table" then validationError(fragmentPath, "expected a table") end
                    for property, dimension in pairs(FRAGMENT_TRACKS) do
                        if property ~= "depth" and fragment[property] ~= nil then
                            validateValue(fragment[property], dimension, fragmentPath .. "." .. property)
                        elseif property == "depth" and fragment.depth ~= nil then
                            validateValue(fragment.depth, 1, fragmentPath .. ".depth")
                        end
                    end
                    validateAnimation(fragment.animation, FRAGMENT_TRACKS,
                        fragmentPath .. ".animation")
                    validateAnimation(fragment.additiveAnimation, FRAGMENT_TRACKS,
                        fragmentPath .. ".additiveAnimation")
                end
            end
            if input.global then
                if input.global.localPosition ~= nil then
                    validateValue(input.global.localPosition, 3,
                        inputPath .. ".global.localPosition")
                end
                validateAnimation(input.global.animation, GLOBAL_TRACKS,
                    inputPath .. ".global.animation")
            end

            if splitType == "customLine" then
                totalLeaves = totalLeaves + validateCustomTrees(input.splitTrees,
                    inputPath .. ".splitTrees")
            elseif input.splitTrees then
                for i, tree in ipairs(input.splitTrees) do
                    totalLeaves = totalLeaves + validateSplitNode(tree, splitType, 1,
                        inputPath .. ".splitTrees[" .. i .. "]")
                end
            elseif input.splitTree then
                local foundTree = false
                local maxVariantLeaves = 0
                for ratioName, tree in pairs(input.splitTree) do
                    if type(tree) == "table" then
                        foundTree = true
                        local variantLeaves = validateSplitNode(tree, splitType, 1,
                            inputPath .. ".splitTree." .. tostring(ratioName))
                        if variantLeaves > maxVariantLeaves then maxVariantLeaves = variantLeaves end
                    end
                end
                if not foundTree then validationError(inputPath .. ".splitTree", "contains no split tree") end
                -- Aspect-ratio variants are mutually exclusive at runtime.
                totalLeaves = totalLeaves + maxVariantLeaves
            else
                validationError(inputPath, "splitTrees or splitTree is required")
            end
        end
    end

    if totalLeaves == 0 then validationError("root", "configuration produces no fragments") end
    if totalLeaves > 15 then
        validationError("root", "configuration produces " .. totalLeaves
            .. " fragments, exceeding blend limit 15")
    end
    return true
end

-- ============================================================
--  curTime / startTime / endTime  RTS + alpha
--  LumiBlit_old 
-- ============================================================
function utils:applyAnimation(lb)
    local t = lb.u_time --u_time value0-1
    if t < 0.0 then t = 0.0 elseif t > 1.0 then t = 1.0 end

    local function addValue(base, delta)
        if type(base) == "table" and type(delta) == "table" then
            local result = {}
            for i = 1, #base do
                result[i] = base[i] + (delta[i] or 0.0)
            end
            return result
        end
        if type(base) == "number" and type(delta) == "number" then
            return base + delta
        end
        return base
    end

    for _, lc in ipairs(lb.leafCameras or {}) do
        local fragData = lc.part.fragments[lc.leafKey]

        -- Start each frame from the authored state.  This prevents an
        -- additive track from accumulating its previous frame's offset when
        -- no base animation is present, while still allowing base animation
        -- tracks to be sampled below.
        lc.translation = copyVec3(lc.baseTranslation or lc.translation)
        lc.rotation = copyVec3(lc.baseRotation or lc.rotation)
        lc.selfRotation = copyVec3(lc.baseSelfRotation or lc.selfRotation)
        lc.scale = copyVec3(lc.baseScale or lc.scale)
        if lc.baseAlpha ~= nil then lc.alpha = lc.baseAlpha end
        if lc.baseDepth ~= nil then lc.depth = lc.baseDepth end

        local anim = fragData and fragData.animation
        if anim then
            for key, parts in pairs(anim) do
                local defaultValue
                if key == "localPosition" then defaultValue = lc.translation
                elseif key == "localRotation" then defaultValue = lc.rotation
                elseif key == "localScale" then defaultValue = lc.scale
                elseif key == "selfRotation" then defaultValue = lc.selfRotation
                elseif key == "alpha" then defaultValue = lc.alpha
                elseif key == "depth" then defaultValue = lc.depth or 0.0
                end
                local value = self:sampleTimedTrack(parts, t, defaultValue)
                if key == "localPosition" then lc.translation = value
                elseif key == "localRotation" then lc.rotation = value
                elseif key == "localScale" then lc.scale = value
                elseif key == "selfRotation" then lc.selfRotation = value
                elseif key == "alpha" then lc.alpha = value
                elseif key == "depth" then lc.depth = value
                end
            end
        end

        -- Additive tracks are evaluated after the base animation and summed
        -- onto its current value, so a shake can coexist with any authored
        -- position/rotation/scale animation instead of replacing it.
        local additive = fragData and fragData.additiveAnimation
        if additive then
            for key, parts in pairs(additive) do
                local defaultValue = (key == "alpha" or key == "depth")
                    and 0.0 or { 0.0, 0.0, 0.0 }
                local delta = self:sampleTimedTrack(parts, t, defaultValue)
                if key == "localPosition" then
                    lc.translation = addValue(lc.translation, delta)
                elseif key == "localRotation" then
                    lc.rotation = addValue(lc.rotation, delta)
                elseif key == "localScale" then
                    lc.scale = addValue(lc.scale, delta)
                elseif key == "selfRotation" then
                    lc.selfRotation = addValue(lc.selfRotation, delta)
                elseif key == "alpha" then
                    lc.alpha = math.min(math.max(
                        addValue(lc.alpha, delta), 0.0), 1.0)
                elseif key == "depth" then
                    lc.depth = addValue(lc.depth or 0.0, delta)
                end
            end
        end
    end

    for _, p in ipairs(lb.parts or {}) do
        local g = p.global
        -- Reset the shared offset on every seek; never accumulate shake.
        p.rt.localPosition = copyVec3((g and g.localPosition)
            or { 0.0, 0.0, 0.0 })
        if g and g.animation then
            for key, parts in pairs(g.animation) do
                p.rt[key] = self:sampleTrack(parts, t, p.rt[key])
            end
        end
    end
end

-- ============================================================
-- split-level transform: supports customLine(line eq), circleSplit, loveType
-- ============================================================
function utils:applySplitTransform(splitPath, st, t, splitType)
    if not st or not st.animation then return splitPath end
    local anim = st.animation
    local cx = (st.center and st.center[1]) or 0.5
    local cy = (st.center and st.center[2]) or 0.5

    local width = Amaz.BuiltinObject.getOutputTextureWidth()
    local height = Amaz.BuiltinObject.getOutputTextureHeight()
    local aspect = width / height

    local function getAnimVal(key, default)
        return self:sampleTrack(anim[key], t, default)
    end

    local pos  = getAnimVal("splitPosition", {0, 0, 0})
    local scl  = getAnimVal("splitScale",    {1, 1, 1})
    local rot  = getAnimVal("splitRotation", {0, 0, 0})
    local tx, ty = pos[1], pos[2]
    local sx, sy = scl[1], scl[2]
    if sx <= 0.001 then sx = 0.001 end
    if sy <= 0.001 then sy = 0.001 end
    local rz = math.rad(rot[3] or rot[1] or 0)
    local cosR, sinR = math.cos(rz), math.sin(rz)

    local isCircle = (splitType == "circleSplit")
    local isLove   = (splitType == "loveType")

    local result = {}
    for _, sp in ipairs(splitPath) do
        local entry = {
            lineA = sp.lineA, lineB = sp.lineB, lineC = sp.lineC,
            hidePositive = sp.hidePositive,
            loveAngle = sp.loveAngle or 0.0,
        }

        if isCircle or isLove then
            -- position: move center
            entry.lineA = sp.lineA + tx
            entry.lineB = sp.lineB + ty
            -- uniform scale: circle stores radius squared; loveType stores linear scale.
            local s = (sx + sy) * 0.5
            entry.lineC = isCircle and (sp.lineC * s * s) or (sp.lineC * s)
            -- rotation (loveType: add to loveAngle)
            if isLove then
                entry.loveAngle = (sp.loveAngle or 0.0) + math.rad(rot[3] or 0.0)
            end
        else
            -- line equation transform
            local A, B, C = sp.lineA, sp.lineB, sp.lineC
            A = A / sx
            B = B / sy
            C = C + sp.lineA * cx * (1.0 - 1.0/sx) + sp.lineB * cy * (1.0 - 1.0/sy)
            local Ar = A * cosR - B * aspect * sinR
            local Br = A * sinR / aspect + B * cosR
            local Cr = C + A * cx + B * cy - Ar * cx - Br * cy
            Cr = Cr - Ar * tx - Br * ty
            entry.lineA, entry.lineB, entry.lineC = Ar, Br, Cr
        end

        table.insert(result, entry)
    end
    return result
end

return utils
