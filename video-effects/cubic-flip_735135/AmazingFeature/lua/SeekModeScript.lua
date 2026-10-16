
local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean
---@field midRT Texture
function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)

    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end

    self.progress = 0
    self.curTime = 0
    self.startTime = 0
    self._duration = 3
    self.autoplay = true
    self.midRT = nil
    self.playDuration = 2
    self.shakeIntensity = 0.8
    self.ins = 0

	self.cur_frame = 0
    self.first = true

    return self
end

function SeekModeScript:constructor()
end

function SeekModeScript:_adapt_onStart(comp)
    self.curTime = 0
    self.duration = 2.0
    self.values = {}
    self.params = {}
    self.anims = {}
    self.animDirty = true
    self.entity = comp.entity
    self.scaleCorrect = 1.0
    self.videoMat = self.entity.scene:findEntityBy("video"):getComponent("MeshRenderer").material
    self.modelMat = self.entity.scene:findEntityBy("quad"):getComponent("MeshRenderer").material
    self.fxaaMat = self.entity.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.entity.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.transform = self.entity.scene:findEntityBy("quad"):getComponent("Transform")
    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)
end
function SeekModeScript.getAEData()
    local aeTools = includeRelativePath("AETools")
    local aeData = includeRelativePath("AEData")
    local attrs = aeTools.new(aeData.ae_attribute)
    return attrs
end
function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
    else
    end

    self.vatAnimScript = comp.entity.scene:findEntityBy("vatAnim"):getComponent("ScriptComponent").properties
    self.motionBlurScript = comp.entity.scene:findEntityBy("lumi_motion_blur_2d"):getComponent("ScriptComponent").properties
    self.boxBlurScript = comp.entity.scene:findEntityBy("LuaBoxBlur"):getComponent("ScriptComponent").properties

    self.strongSharpenScript = comp.entity.scene:findEntityBy("LuaStrongSharpen"):getComponent("ScriptComponent").properties
    self.deepGlowScript = comp.entity.scene:findEntityBy("Deep_Glow"):getComponent("ScriptComponent").properties

    self.attrs = self.getAEData()

    self.first = true
end

function SeekModeScript:autoPlay(time)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        if self.autoplay then
            self.progress = time % self._duration / self._duration
        end
    else
        -- self.duration = self.endTime - self.startTime
        -- self.progress = time % self.duration / self.duration
        self.progress = math.min(time/math.max(0.00001, self.duration), 1)
    end
end

if Amaz.Macros and Amaz.Macros.EditorSDK then
    function SeekModeScript:onUpdate(comp, detalTime)
        self.blendMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        self.modelMat:enableMacro("AMAZING_EDITOR_DEV", 1)

        self.lastTime = self.curTime
        self.curTime = self.curTime + detalTime
        self:autoPlay(self.curTime)
        self:seek(self.curTime - self.startTime)
    end
end

function SeekModeScript:_adapt_seek(time)
    local inputW = Amaz.BuiltinObject:getInputTextureWidth()
    local inputH = Amaz.BuiltinObject:getInputTextureHeight()
    local inputRatio = inputW / inputH
    local outputW = Amaz.BuiltinObject:getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject:getOutputTextureHeight()
    local outputRatio = outputW / outputH
    local fitScale = Amaz.Vector3f(1, 1, 1)
    local extraScale = 1
    if inputRatio < outputRatio then
        fitScale.x = inputRatio
        extraScale = inputH / outputH
    else
        fitScale.x = outputRatio
        fitScale.y = outputRatio / inputRatio
        extraScale = inputW / outputW
    end

    local uvScale = Amaz.Vector2f(1, 1)
    local xRatio = inputRatio / outputRatio
    local yRatio = outputRatio / inputRatio
    if outputRatio > 1. then
        if outputRatio > inputRatio then
            uvScale.x = xRatio
        else
            uvScale.y = yRatio
        end
    elseif math.abs(outputRatio - 1.) < .1 then
        if inputRatio < 1. then
            uvScale.x = xRatio
        else
            uvScale.y = yRatio
        end
    elseif outputRatio < 1. then
        if math.abs(inputRatio - 1.) < .1 or outputRatio < inputRatio then
            uvScale.y = yRatio
        else
            uvScale.x = xRatio
        end
    end

    self.modelMat:setFloat("u_OutputWidth", outputW)
    self.modelMat:setFloat("u_OutputHeight", outputH)

    local userMat = Amaz.Matrix4x4f()
    userMat:setTRS(
        Amaz.Vector3f(self.userPosition.x * outputRatio, self.userPosition.y, self.userPosition.z),
        Amaz.Quaternionf.EulerToQuaternion(-self.userEulerAngle / 180 * math.pi),
        Amaz.Vector3f(1, 1, 1) * self.userScale.x * extraScale
    )
    userMat:invert_Full()

    local fitMat = Amaz.Matrix4x4f()
    fitMat:setTRS(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.identity(), Amaz.Vector3f(uvScale.x, uvScale.y, 1))
    fitMat:invert_Full()

    self.modelMat:setMat4("userMat", userMat)
    self.modelMat:setMat4("fitMat", fitMat)

    local widthPer = math.max(math.min(2160 / outputW, 2), 1)
    local heightPer = math.max(math.min(2160 / outputH, 2), 1)
    local per = math.max(widthPer, heightPer)
    self.midRT.pecentX = per
    self.midRT.pecentY = per
end
local getLuaObj = function(script_component)
    return Amaz.ScriptUtils.getLuaObj(script_component:getScript())
end
function SeekModeScript:seek(time)
    if self.first == true then
        -- self.motionBlurScript = getLuaObj(self.motionBlurScript)
        -- self.boxBlurScript = getLuaObj(self.boxBlurScript)
        -- self.strongSharpenScript = getLuaObj(self.strongSharpenScript)
        -- self.deepGlowScript = getLuaObj(self.deepGlowScript)
        self.first = false
    end
    self:_adapt_seek(time)
    self:autoPlay(time)

    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()

    self.vatAnimScript:set("progress", self.progress)

    local motionBlurPos = self.attrs:GetVal("ADBE_MotionBlur_Pos", self.progress)
    motionBlurPos = Amaz.Vector2f((motionBlurPos[1] - 400) / 800 * self.shakeIntensity, -(motionBlurPos[2] - 720) / 1440 * self.shakeIntensity)
    -- self.motionBlurScript.CurrPosition = motionBlurPos
    self.motionBlurScript:set("CurrPosition", motionBlurPos)

    local boxBlur = self.attrs:GetVal("ADBE_BoxBlur", self.progress)[1] * 0.5
    boxBlur = boxBlur
    -- self.boxBlurScript.intensity = boxBlur
    self.boxBlurScript:set("intensity", boxBlur)

    local motionBlurScaleX = self.attrs:GetVal("ADBE_MotionBlur_ScaleX", self.progress)[1] * 0.01
    self.vatAnimScript:set("imageScale", 1.0 / motionBlurScaleX)

    local constrast = self.attrs:GetVal("ADBE_Constrast", self.progress)[1]
    -- self.motionBlurScript.contrastIntensity = constrast
    self.motionBlurScript:set("contrastIntensity", constrast)

    local strongSharpenHorizationOffset = self.attrs:GetVal("ADBE_Horization_Offset", self.progress)[1]
    local strongSharpeVerticalOffset = self.attrs:GetVal("ADBE_Vertical_Offset", self.progress)[1]
    -- self.strongSharpenScript.offsetX = strongSharpenHorizationOffset
    -- self.strongSharpenScript.offsetY = strongSharpeVerticalOffset
    self.strongSharpenScript:set("offsetX", strongSharpenHorizationOffset)
    self.strongSharpenScript:set("offsetY", strongSharpeVerticalOffset)

    local deepGlowExposure = self.attrs:GetVal("ADBE_DeepGlow_Exposure", self.progress)[1]
    -- self.deepGlowScript.glow_intensity = deepGlowExposure
    self.deepGlowScript:set("glow_intensity", deepGlowExposure)

    local saturation = self.attrs:GetVal("ADBE_Saturation", self.progress)[1] * 0.01
    -- self.deepGlowScript.saturationIntensity = saturation
    self.deepGlowScript:set("saturationIntensity", saturation)

end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        -- local bgAspect = value.x / value.y
        -- local videoAspect = value.z / value.w
        -- if bgAspect > videoAspect then
        --     self.scaleCorrect = value.w / value.y
        -- else
        --     self.scaleCorrect = value.z / value.x
        -- end
        -- self.videoMat:setVec4("u_size", value)
        -- self.modelMat:setVec4("u_size", value)
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
    elseif name == "u_pos" then
        -- self.videoMat:setVec2("u_pos", value)
        -- self.blendMat:setVec2("u_pos", value)
        self.userPosition:set(value.x, value.y, 0)
    elseif name == "u_angle" then
        -- self.videoMat:setFloat("u_angle", value)
        -- self.blendMat:setFloat("u_angle", value)
        self.userEulerAngle:set(0, 0, value / math.pi * 180)
    elseif name == "u_scale" then
        -- self.videoMat:setFloat("u_scale", value)
        -- self.blendMat:setFloat("u_scale", value * self.scaleCorrect)
        self.userScale:set(value, value, 1)
    elseif name == "u_flipX" then
        self.videoMat:setFloat("u_flipX", value)
    elseif name == "u_flipY" then
        self.videoMat:setFloat("u_flipY", value)
    elseif name == "_alpha" then
        self.blendMat:setFloat("_alpha", value)
    end
end

function SeekModeScript:setDuration(duration)
    self.duration = duration
end

exports.SeekModeScript = SeekModeScript
return exports
