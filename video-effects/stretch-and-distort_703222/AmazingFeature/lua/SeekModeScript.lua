---@class SeekModeScript : ScriptComponent
----@field curTime number [UI(Range={0, 3}, Slider)]
----@field duration number [UI(Input)]
local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

local function getBezierValue(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3 * xc1 * (1 - t) * (1 - t) * t + 3 * xc2 * (1 - t) * t * t + t * t * t
    ret[2] = 3 * yc1 * (1 - t) * (1 - t) * t + 3 * yc2 * (1 - t) * t * t + t * t * t
    return ret
end

local function getBezierDerivative(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3 * xc1 * (1 - t) * (1 - 3 * t) + 3 * xc2 * (2 - 3 * t) * t + 3 * t * t
    ret[2] = 3 * yc1 * (1 - t) * (1 - 3 * t) + 3 * yc2 * (2 - 3 * t) * t + 3 * t * t
    return ret
end

local function getBezierTfromX(controls, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts + te) / 2
        local value = getBezierValue(controls, tm)
        if (value[1] > x) then
            te = tm
        else
            ts = tm
        end
    until (te - ts < 0.0001)

    return (te + ts) / 2
end

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then
        SeekModeScript.constructor(self, ...)
    end
    return self
end

---@function [UI(Button="bofang")]
---@return void
function SeekModeScript:ButtonClip()
    self.curTime = 0
    self.isPlay = true
end

function SeekModeScript:constructor()
end

function SeekModeScript:onStart(comp)
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

    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)
end

function SeekModeScript:updateAnim()
    if not self.animDirty then
        return
    end
    self.animDirty = false
    -- time【0-1】
    self.params = {
        -- zidingyishuxingdonghuapeizhi
        -- xiamianliziyongyuchuanrusuishijianbianhuaerbianhuadeuniformdaoshader
        {
            -- shijian，buxuyaoxiugai
            key = "u_Distort",
            obj = self.values,
            startValue = 0.36, -- qishizhi
            endValue = 0.0, -- jieshuzhi
            defaultValue = 0.0, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.17, 0, 0.21, 1.0} -- beisaierquxiancanshu
                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.0, -- qishishijian
            endTime = 0.2 -- jieshushijian
        },
        {
            -- shijian，buxuyaoxiugai
            key = "dirBlurStep",
            obj = self.values,
            startValue = 3, -- qishizhi
            endValue = 0.0, -- jieshuzhi
            defaultValue = 0.0, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
                if value > 0 then
                    material:enableMacro("USE_DIR_BLUR", 1)
                end
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.17, 0, 0.21, 1.0} -- beisaierquxiancanshu
                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.0, -- qishishijian
            endTime = 0.25 -- jieshushijian
        },
        {
            -- xiexiangyundongdeyundongliang
            key = "u_TwistRotFactor",
            obj = self.values,
            startValue = 350, -- qishizhi
            endValue = 0, -- jieshuzhi
            defaultValue = 350, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.30, 0.62, 0.47, 0.91} -- beisaierquxiancanshu
                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.0, -- qishishijian
            endTime = 0.4 -- jieshushijian
        },
        {
            -- xiefangxiangfangxiangmohu，
            key = "u_TwistFactor",
            obj = self.values,
            startValue = 4, -- qishizhi
            endValue = 0.1, -- jieshuzhi
            defaultValue = 2, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.07, 0.76, 0.67, 0.96} -- beisaierquxiancanshu

                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.0, -- qishishijian
            endTime = 0.4 -- jieshushijian
        },
        {
            -- qianbanduanniuqudeqiangdu，kuaisujianruo
            key = "u_ScaleFactor",
            obj = self.values,
            startValue = 1.75, -- qishizhi
            endValue = 1.03, -- jieshuzhi
            defaultValue = 1.75, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.09, 0.74, 0.67, 0.90} -- beisaierquxiancanshu
                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.0, -- qishishijian
            endTime = 0.4 -- jieshushijian
        },
        {
            -- qianbanduanniuqudeqiangdu，huanmanjianruo
            key = "u_TwistRotFactor",
            obj = self.values,
            startValue = 0, -- qishizhi
            endValue = 240, -- jieshuzhi
            defaultValue = 240, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.68, -0.06, 0.83, 0.22} -- beisaierquxiancanshu
                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.4, -- qishishijian
            endTime = 1.0 -- jieshushijian
        },
        {
            -- qianbanduanniuqudeqiangdu，huanmanjianruo
            key = "u_TwistFactor",
            obj = self.values,
            startValue = 0.1, -- qishizhi
            endValue = 1, -- jieshuzhi
            defaultValue = 0.45, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.59, -0.22, 0.83, -0.19} -- beisaierquxiancanshu
                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.4, -- qishishijian
            endTime = 1.0 -- jieshushijian
        },
        {
            -- qianbanduanniuqudeqiangdu，huanmanjianruo
            key = "u_ScaleFactor",
            obj = self.values,
            startValue = 1.03, -- qishizhi
            endValue = 0.001, -- jieshuzhi
            defaultValue = 1.03, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.33, 0.10, 0.84, 0.12} -- beisaierquxiancanshu0.38, 0.13, 0.84, 0.12
                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.4, -- qishishijian
            endTime = 1.0 -- jieshushijian
        },
        {
            -- suofangmohuqiangdu，zhujianjianruo
            key = "scaleBlurStep",
            obj = self.values,
            startValue = 0.0, -- qishizhi
            endValue = 0.25, -- jieshuzhi
            defaultValue = 0.0, -- morenzhi，gaijieduanmeiyouzhixing，huozhezhixingwanchengzhihougaiyingyongdezhi
            actionHandle = function(material, key, value) -- seekshidehuidiaofangfa
                material:setFloat(key, value)
                if value > 0 then
                    material:enableMacro("USE_SACLE_BLUR", 1)
                end
            end,
            curve = function(t, b, c, d)
                t = t / d
                local controls = {0.38, 0.13, 0.84, 0.12} -- beisaierquxiancanshu
                local tvalue = getBezierTfromX(controls, t)
                local value = getBezierValue(controls, tvalue)
                return b + c * value[2]
            end,
            startTime = 0.4, -- qishishijian
            endTime = 1.0
         -- jieshushijian
        }
    }
    for i = 1, #self.params do
        local param = self.params[i]
        self.anims[i] =
            self.entity.scene.tween:fromTo(
            param.obj,
            {[param.key] = param.startValue},
            {[param.key] = param.endValue},
            param.endTime - param.startTime,
            param.curve,
            nil,
            0.0,
            nil,
            false
        )
    end
end

if Amaz.Macros and Amaz.Macros.EditorSDK then
    function SeekModeScript:onUpdate(comp, deltaTime)
        self.blendMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        self.modelMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        self.modelMat:setTex("u_inputTexture", comp.entity.scene.assetMgr:SyncLoad("share://input.texture"))
        -- local props = comp.entity:getComponent("ScriptComponent").properties
        -- if props:has("curTime") then
        --     self:seek(props:get("curTime"))
        -- end
        if self.isPlay and self.curTime < self.duration then
            self.curTime = (self.curTime + deltaTime)
        else
            self.isPlay = false
        end
        self:seek(math.min(self.curTime,self.duration))
    end
end

function SeekModeScript:setDuration(duration)
    self.duration = duration
    self.animDirty = true
end

function SeekModeScript:seek(time)
    self.modelMat:disableMacro("USE_SACLE_BLUR")
    self.modelMat:disableMacro("USE_DIR_BLUR")
    self:updateAnim()

    if self.duration < 1e-4 then
        return
    end

    local progress = time / self.duration

    -- seekzhiqianxianjiangzidingyishuxingdezhishezhichengmorenzhi，buranhuicanliushangyiciseekdezhi
    for i = 1, #self.anims do
        local param = self.params[i]
        if param.actionHandle ~= nil then
            param.actionHandle(self.modelMat, param.key, param.defaultValue)
        end
    end

    for i = 1, #self.anims do
        local param = self.params[i]
        if progress >= param.startTime and progress <= param.endTime then
            self.anims[i]:set(progress - param.startTime)
            if param.actionHandle ~= nil then
                param.actionHandle(self.modelMat, param.key, self.values[param.key])
            end
        elseif progress < param.startTime then
            self.anims[i]:set(0)
        elseif progress > param.endTime then
            self.anims[i]:set(1)
        end
    end



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
    -- self.quadTrans.localScale = fitScale

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

    -- self.modelMat:setFloat('u_InputWidth', inputW)
    -- self.modelMat:setFloat('u_InputHeight', inputH)
    self.modelMat:setFloat('u_OutputWidth', outputW)
    self.modelMat:setFloat('u_OutputHeight', outputH)
    -- self.modelMat:setVec2('u_UVScale', uvScale)


    local userMat = Amaz.Matrix4x4f()
    -- userMat:setTRS(
    --     Amaz.Vector3f(self.userPosition.x * outputRatio, self.userPosition.y, self.userPosition.z),
    --     Amaz.Quaternionf.EulerToQuaternion(-self.userEulerAngle / 180 * math.pi),
    --     Amaz.Vector3f(1, 1, 1) * self.userScale.x * extraScale
    -- )
    -- userMat:invert_Full()

    local fitMat = Amaz.Matrix4x4f()
    fitMat:setTRS(
        Amaz.Vector3f(0, 0, 0),
        Amaz.Quaternionf.identity(),
        Amaz.Vector3f(uvScale.x, uvScale.y, 1)
    )
    fitMat:invert_Full()

    self.modelMat:setMat4('userMat', userMat)
    self.modelMat:setMat4('fitMat', fitMat)
end

function SeekModeScript:clear()
    self.anims = {}
    self.params = {}
    self.animDirty = true
end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        -- self.videoMat:setVec4("u_size", value)
        -- self.modelMat:setVec4("u_size", value)
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
        -- local bgAspect = value.x / value.y
        -- local videoAspect = value.z / value.w
        -- if bgAspect > videoAspect then
        --     self.scaleCorrect = value.w / value.y
        -- else
        --     self.scaleCorrect = value.z / value.x
        -- end
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

function SeekModeScript:clear()
end

exports.SeekModeScript = SeekModeScript
return exports
