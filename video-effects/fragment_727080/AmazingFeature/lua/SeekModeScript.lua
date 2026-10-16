local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean

local isEditor = Amaz.Macros and Amaz.Macros.EditorSDK

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)

    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end

    -- if util == nil then
    --     util = includeRelativePath("Util")
    -- end

    self.progress = 0
    self.curTime = 0
    self.startTime = 0
    self._duration = 3
    self.autoplay = true

    self.playDuration = 2

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

local function getluaobj(_script)
    return Amaz.ScriptUtils.getLuaObj(_script:getScript())
end

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)
    -- Amaz.LOGI("lrc onstart", "SeekModeScript")

    self.res_mat = comp.entity.scene:findEntityBy("res"):getComponent("MeshRenderer").material
    self.mask_left_mat = comp.entity.scene:findEntityBy("mask_left"):getComponent("MeshRenderer").material
    self.mask_right_mat = comp.entity.scene:findEntityBy("mask_right"):getComponent("MeshRenderer").material


    self.mbl_entity = comp.entity.scene:findEntityBy("MotionBlur2D_left")
    self.mbl_lua = self.mbl_entity:getComponent("ScriptComponent")
    self.mbl_lua = getluaobj(self.mbl_lua)

    self.mbr_entity = comp.entity.scene:findEntityBy("MotionBlur2D_right")
    self.mbr_lua = self.mbr_entity:getComponent("ScriptComponent")
    self.mbr_lua = getluaobj(self.mbr_lua)

    self.mbg_entity = comp.entity.scene:findEntityBy("MotionBlur2D_bg")
    self.mbg_lua = self.mbg_entity:getComponent("ScriptComponent")
    self.mbg_lua = getluaobj(self.mbg_lua)

    self.gbl_entity = comp.entity.scene:findEntityBy("Gaussian_Blur_Root_left")
    self.gbl_lua = self.gbl_entity:getComponent("ScriptComponent")
    self.gbl_lua = getluaobj(self.gbl_lua)

    self.gbr_entity = comp.entity.scene:findEntityBy("Gaussian_Blur_Root_right")
    self.gbr_lua = self.gbr_entity:getComponent("ScriptComponent")
    self.gbr_lua = getluaobj(self.gbr_lua)

    -- Amaz.LOGE("lrc onstart mbl", tostring(self.mbl_lua))
    -- Amaz.LOGE("lrc onstart mbr", tostring(self.mbr_lua))
    -- Amaz.LOGE("lrc onstart mbg", tostring(self.mbg_lua))

    local AETools = includeRelativePath("AETools")
    local AEData = includeRelativePath("AEData")

    self.utils = includeRelativePath("LRCUtils")
    
    self.attrs = AETools.new(AEData.ae_attribute)
    self.attrs_l = AETools.new(AEData.ae_attribute_l)
    self.attrs_r = AETools.new(AEData.ae_attribute_r)
end

function SeekModeScript:autoPlay(time)
    if isEditor then
        if self.autoplay then
            self.progress = time % self._duration / self._duration
        end
    else
        self.duration = self.endTime - self.startTime
        self.progress = time % self.duration / self.duration
    end
end

if isEditor then
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
end

function SeekModeScript:seek(time)
    self:_adapt_seek(time)

    if isEditor then
    else
        self.progress = math.mod(time/(self.duration+0.0001), 1)
    end

    local p = self.progress
    -- p = self.utils.remap01(1/31, 1 , p)
    local all_frame = self.attrs:AllFrame()
    if isEditor then
        p = math.floor(p*all_frame)/all_frame
    end
    p = self.utils.remap01(0, 1-1/all_frame, p) + 1/all_frame
    -- Amaz.LOGI("lrc 111", tostring(self.attrs:AllFrame()))
    -- p = self.utils.remap01(1/31, 1, p)
    -- Amaz.LOGI("lrc frame", self.attrs:CurFrame(p))

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()

    local ow = Amaz.BuiltinObject:getOutputTextureWidth()
    local oh = Amaz.BuiltinObject:getOutputTextureHeight()

    self:_UpdateRight(p)
    self:_UpdateLeft(p)
    self:_UpdateBg(p)
    -- Amaz.LOGE("lrc p", p)
    -- self:_UpdateRes(p)
    -- self:_UpdateSGlow(p)
    
end

function SeekModeScript:_UpdateBg(_p)
    local p = _p

    local u_Intensity = self.attrs:GetVal("ADBE_IE_5a1ff1b7caffac514aaba44_0001_2_16", p)
    u_Intensity = u_Intensity[1]
    self.mbg_lua.u_Intensity = u_Intensity

    local frame_time = 1/self.attrs:AllFrame()
    local cp = p
    local lp = math.min(1-frame_time, math.max(0, cp-frame_time))
    
    -- sp attr
    local x_offset = self.attrs:GetVal("ADBE_Position_0_2_18", cp)
    x_offset = x_offset[1]
    local y_offset = self.attrs:GetVal("ADBE_Position_1_2_19", cp)
    y_offset = y_offset[1]
    local CurrOffset = Amaz.Vector2f(x_offset, y_offset)
    CurrOffset = Amaz.Vector2f(CurrOffset.x/1080-0.5, -(CurrOffset.y/1080-0.5))
    self.mbg_lua.CurrOffset = CurrOffset

    local CurrScale = self.attrs:GetVal("ADBE_Scale_0_5", cp)
    CurrScale = CurrScale[1] * 0.01
    CurrScale = Amaz.Vector2f(CurrScale, CurrScale)
    self.mbg_lua.CurrScale = CurrScale

    -- ep attr
    local x_offset = self.attrs:GetVal("ADBE_Position_0_2_18", lp)
    x_offset = x_offset[1]
    local y_offset = self.attrs:GetVal("ADBE_Position_1_2_19", lp)
    y_offset = y_offset[1]
    local PrevOffset = Amaz.Vector2f(x_offset, y_offset)
    PrevOffset = Amaz.Vector2f(PrevOffset.x/1080-0.5, -(PrevOffset.y/1080-0.5))
    self.mbg_lua.PrevOffset = PrevOffset

    local PrevScale = self.attrs:GetVal("ADBE_Scale_0_5", lp)
    PrevScale = PrevScale[1] * 0.01
    PrevScale = Amaz.Vector2f(PrevScale, PrevScale)
    self.mbg_lua.PrevScale = PrevScale

    -- -- cp
    -- local x_offset = self.attrs:GetVal("ADBE_Position_0_2_18", cp)
    -- x_offset = x_offset[1]
    -- local y_offset = self.attrs:GetVal("ADBE_Position_1_2_19", cp)
    -- y_offset = y_offset[1]
    -- local CurrOffset = Amaz.Vector2f(x_offset, y_offset)
    -- -- Amaz.LOGI("lrc "..self.attrs:CurFrame(cp), tostring(CurrOffset))
    -- CurrOffset = Amaz.Vector2f(CurrOffset.x/1080-0.5, -(CurrOffset.y/1080-0.5))
    -- self.mbg_lua.CurrOffset = CurrOffset

    -- local CurrScale = self.attrs:GetVal("ADBE_Scale_2_20", cp)
    -- CurrScale = CurrScale[1] * 0.01
    -- CurrScale = Amaz.Vector2f(CurrScale, CurrScale)
    -- -- Amaz.LOGI("lrc "..self.attrs:CurFrame(cp), tostring(CurrScale))
    -- self.mbg_lua.CurrScale = CurrScale

    local final_alpha = self.attrs:GetVal("ADBE_Opacity_2_21", p)
    final_alpha = final_alpha[1] * 0.01
    self.mbg_lua.final_alpha = final_alpha

    self.mbg_lua.motion_tile_flag = 1

    self.mbg_lua:updateMaterial()

end

function SeekModeScript:_UpdateLeft(_p)
    local p = _p


    local Intensity = self.attrs:GetVal("ADBE_IE_f27e10b94d011bf31c57ec1_0002_0_0", p)
    Intensity = Intensity[1]
    self.gbl_lua.Intensity = Intensity

    local u_Intensity = self.attrs:GetVal("ADBE_IE_5a1ff1b7caffac514aaba44_0001_0_1", p)
    u_Intensity = u_Intensity[1]
    self.mbl_lua.u_Intensity = u_Intensity

    local frame_time = 1/self.attrs:AllFrame()
    local cp = p
    local lp = math.min(1-frame_time, math.max(0, cp-frame_time))
    
    -- sp attr
    local x_offset = self.attrs:GetVal("ADBE_Position_0_0_3", cp)
    x_offset = x_offset[1]
    local y_offset = self.attrs:GetVal("ADBE_Position_1_0_4", cp)
    y_offset = y_offset[1]
    local CurrOffset = Amaz.Vector2f(x_offset, y_offset)
    CurrOffset = Amaz.Vector2f(CurrOffset.x/1080-0.5, -(CurrOffset.y/1080-0.5))
    self.mbl_lua.CurrOffset = CurrOffset

    local CurrScale = self.attrs:GetVal("ADBE_Scale_0_5", cp)
    CurrScale = CurrScale[1] * 0.01
    CurrScale = Amaz.Vector2f(CurrScale, CurrScale)
    self.mbl_lua.CurrScale = CurrScale

    -- ep attr
    local x_offset = self.attrs:GetVal("ADBE_Position_0_0_3", lp)
    x_offset = x_offset[1]
    local y_offset = self.attrs:GetVal("ADBE_Position_1_0_4", lp)
    y_offset = y_offset[1]
    local PrevOffset = Amaz.Vector2f(x_offset, y_offset)
    PrevOffset = Amaz.Vector2f(PrevOffset.x/1080-0.5, -(PrevOffset.y/1080-0.5))
    self.mbl_lua.PrevOffset = PrevOffset

    local PrevScale = self.attrs:GetVal("ADBE_Scale_0_5", lp)
    PrevScale = PrevScale[1] * 0.01
    PrevScale = Amaz.Vector2f(PrevScale, PrevScale)
    self.mbl_lua.PrevScale = PrevScale

    local final_alpha = self.attrs:GetVal("ADBE_Opacity_0_6", p)
    final_alpha = final_alpha[1] * 0.01
    self.mbl_lua.final_alpha = final_alpha

    local shadow_alpha = self.attrs:GetVal("dropShadow/opacity_0_7", p)
    shadow_alpha = shadow_alpha[1] * 0.01
    self.mask_left_mat:setFloat("shadow_alpha", shadow_alpha)

    local pos = self.attrs_l:GetVal("ADBE_Position_1_0", p)
    pos = Amaz.Vector2f(pos[1], pos[2])
    pos = Amaz.Vector2f(pos.x/1080-0.5, pos.y/1080-0.5)
    self.mask_left_mat:setVec2("pos", pos)

    -- self.mbl_lua.CurrOffset = Amaz.Vector2f(0,0)
    -- self.mbl_lua.PrevOffset = Amaz.Vector2f(0,0)
    -- self.mbl_lua.CurrScale = Amaz.Vector2f(1,1)
    -- self.mbl_lua.PrevScale = Amaz.Vector2f(1,1)

    self.mbl_lua:updateMaterial()

end

function SeekModeScript:_UpdateRight(_p)
    local p = _p

    local Intensity = self.attrs:GetVal("ADBE_IE_f27e10b94d011bf31c57ec1_0002_1_8", p)
    Intensity = Intensity[1]
    self.gbr_lua.Intensity = Intensity

    local u_Intensity = self.attrs:GetVal("ADBE_IE_5a1ff1b7caffac514aaba44_0001_1_9", p)
    u_Intensity = u_Intensity[1]
    self.mbr_lua.u_Intensity = u_Intensity

    local frame_time = 1/self.attrs:AllFrame()
    local cp = p
    local lp = math.min(1-frame_time, math.max(0, cp-frame_time))

    -- cp = 1/self.attrs:AllFrame()
    -- lp = 0/self.attrs:AllFrame()

    -- cp attr
    local x_offset = self.attrs:GetVal("ADBE_Position_0_1_11", cp)
    x_offset = x_offset[1]
    local y_offset = self.attrs:GetVal("ADBE_Position_1_1_12", cp)
    y_offset = y_offset[1]
    local CurrOffset = Amaz.Vector2f(x_offset, y_offset)
    -- Amaz.LOGI("lrc cp "..cp*self.attrs:AllFrame(), tostring(CurrOffset))
    CurrOffset = Amaz.Vector2f(CurrOffset.x/1080-0.5, -(CurrOffset.y/1080-0.5))
    self.mbr_lua.CurrOffset = CurrOffset

    local CurrScale = self.attrs:GetVal("ADBE_Scale_1_13", cp)
    CurrScale = CurrScale[1] * 0.01
    CurrScale = Amaz.Vector2f(CurrScale, CurrScale)
    self.mbr_lua.CurrScale = CurrScale

    -- sp attr
    local x_offset = self.attrs:GetVal("ADBE_Position_0_1_11", lp)
    x_offset = x_offset[1]
    local y_offset = self.attrs:GetVal("ADBE_Position_1_1_12", lp)
    y_offset = y_offset[1]
    local PrevOffset = Amaz.Vector2f(x_offset, y_offset)
    -- Amaz.LOGI("lrc lp "..lp*self.attrs:AllFrame(), tostring(PrevOffset))
    PrevOffset = Amaz.Vector2f(PrevOffset.x/1080-0.5, -(PrevOffset.y/1080-0.5))
    self.mbr_lua.PrevOffset = PrevOffset

    local PrevScale = self.attrs:GetVal("ADBE_Scale_1_13", lp)
    PrevScale = PrevScale[1] * 0.01
    PrevScale = Amaz.Vector2f(PrevScale, PrevScale)
    self.mbr_lua.PrevScale = PrevScale

    local final_alpha = self.attrs:GetVal("ADBE_Opacity_1_14", p)
    final_alpha = final_alpha[1] * 0.01
    self.mbr_lua.final_alpha = final_alpha

    local shadow_alpha = self.attrs:GetVal("dropShadow/opacity_1_15", p)
    shadow_alpha = shadow_alpha[1] * 0.01
    self.mask_right_mat:setFloat("shadow_alpha", shadow_alpha)

    local pos = self.attrs_r:GetVal("ADBE_Position_1_0", p)
    pos = Amaz.Vector2f(pos[1], pos[2])
    Amaz.LOGI("lrc "..self.attrs_r:CurFrame(p), tostring(pos))
    pos = Amaz.Vector2f(pos.x/1080-0.5, pos.y/1080-0.5)
    self.mask_right_mat:setVec2("pos", pos)


    local vIntensity = self.attrs:GetVal("motion_right_blur_intensity", cp)
    vIntensity = vIntensity[1] * 0.01
    -- Amaz.LOGE("lrc 123 "..self.attrs:CurFrame(cp), vIntensity)
    self.mbr_lua.vIntensity = vIntensity

    local vCenter = self.attrs:GetVal("motion_right_blur_center", cp)
    vCenter = vCenter[1] * 0.01
    self.mbr_lua.vCenter = vCenter
    -- Amaz.LOGE("lrc 233 "..self.attrs:CurFrame(cp), vCenter)
    
    -- self.mbr_lua.CurrOffset = Amaz.Vector2f(0,0)
    -- self.mbr_lua.PrevOffset = Amaz.Vector2f(0,0)
    -- self.mbr_lua.CurrScale = Amaz.Vector2f(1,1)
    -- self.mbr_lua.PrevScale = Amaz.Vector2f(1,1)

    self.mbr_lua:updateMaterial()
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
