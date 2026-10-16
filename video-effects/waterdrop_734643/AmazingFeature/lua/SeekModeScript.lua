local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false

local function _remap01(a,b,x)
    if x < a then return 0 end
    if x > b then return 1 end
    return (x-a)/(b-a)
end

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean
---@field utime number
---@field u_fov number
---@field u_Size number

local isEditor = Amaz.Macros and Amaz.Macros.EditorSDK


function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.progress = 0
    self.curTime = 0
    self.startTime = 0
    self._duration = 3
    self.autoplay = true

    self.playDuration = 2

    self.ins = 0

	self.cur_frame = 0

    self.radial_blur_intensity = 1
    self.utime = 0

    self.u_fov = 0
    self.u_Size = 100
    return self
end

local ae_attribute = {


	["APC_Caustics_0012_0_1"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {9, 12, }, {{0, }, {0.2, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {12, 24, }, {{0.2, }, {0.27, }, }, {6417, }, {1, }, }, 
	}, 

	["APC_Caustics_0080_0_2"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {9, 12, }, {{0, }, {0.299988, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {12, 31, }, {{0.299988, }, {0.729988, }, }, {6417, }, {1, }, },
	}, 


	["ADBE_IE_b5a436a58f761f7fd4975e2_0001_0_3"]={
		{{0.386789244, -2.6e-8, 0.726408109, 0.468796656, }, {25, 38, }, {{0, }, {12.022472, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_Scale_0_5"]={
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {22, 43, }, {{100, 100, 100, }, {125, 125, 100, }, }, {6414, }, {1, }, }, 
	}, 
	["ADBE_Opacity_0_6"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {22, 43, }, {{100, }, {0, }, }, {6417, }, {1, }, }, 
	}, 
    
	["ADBE_IE_b5a436a58f761f7fd4975e2_0001_0_4"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 20, }, {{0, }, {0, }, }, {6417, }, {1, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {20, 25, }, {{0, }, {12, }, }, {6417, }, {1, }, }, 
	}, 


  

    ["ADBE_IE_b5a436a58f761f7fd4975e2_0001_0_0"]={
		{{0.166666667, 0, 0.833333333, 1, }, {20, 29, }, {{0, }, {5, }, }, {6417, }, {0, }, }, 
		{{0.527310649, -3e-9, 0.833333333, 1, }, {29, 32, }, {{5, }, {37, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_IE_94ef1214fce0c3a65f82dd6_0002_0_1"]={
		{{0.166666667, 0, 0.666666665, 1.172216216, }, {20, 29, }, {{0, }, {74, }, }, {6417, }, {0, }, }, 
		{{0.333333335, -2.123999999, 0.833333333, 1, }, {29, 38, }, {{74, }, {80, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_IE_cfd060d81c820aaffc3cd7c_0001_0_2"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {29, 39, }, {{0, }, {0.32, }, }, {6417, }, {1, }, }, 
	}, 



    ["ADBE_Position_0_0"]={
		{{0.165002, 0, 0.587933, 0.269199, }, {19, 29, }, {{640, 640, 0, }, {640, 387.086856282, 0, }, {640, 709.211807250977, 0, }, {640, 628.484897053484, 0, }, }, {6413, }, {0, }, }, 
		{{0.420841, 0.36069, 0.831484, 1, }, {29, 38, }, {{640, 387.086856282, 0, }, {640, -158.497680664, 0, }, {640, 163.442782795672, 0, }, {640, -222.619201660094, 0, }, }, {6413, }, {0, }, }, 
	}, 
	["ADBE_Scale_0_1"]={
		{{0.445617678,0.445617678,0.33333333, -1e-9,-1e-9,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, {19, 38, }, {{100, 100, 100, }, {0, 0, 100, }, }, {6414, }, {0, }, }, 
	}, 

	["ADBE_Vector_Rect_Roundness_0_0"]={
        {{0.166666667, 0, 0.66666667, 1, }, {14, 15, }, {{0, }, {146, }, }, {6417, }, {0, }, }, 
        {{0.166666667, 0, 0.66666667, 1, }, {15, 29, }, {{146, }, {146, }, }, {6417, }, {0, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {29, 38, }, {{146, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_IE_b5a436a58f761f7fd4975e2_0001_0_1"]={
		{{0.166666667, 0, 0.833333333, 1, }, {25, 31, }, {{0, }, {24, }, }, {6417, }, {0, }, }, 
	}, 

}

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

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)
    local ae_tools = includeRelativePath("AETools")
    -- Amaz.LOGE("=====>>:",tostring(ae_tools))
    self.attrs = ae_tools.new(ae_attribute)

    self.tableCom = comp.entity.scene:findEntityBy("Table"):getComponent("TableComponent").table

    self.props    = comp.entity:getComponent("ScriptComponent").properties
    
    
    self.putSdfTexMat = comp.entity.scene:findEntityBy("putSdfTex"):getComponent("MeshRenderer").material
    self.waveMat = comp.entity.scene:findEntityBy("wave"):getComponent("MeshRenderer").material
    self.animSeqCom = comp.entity.scene:findEntityBy("putSdfTex"):getComponent("AnimSeqComponent")
    
    self.animSeqCom1 = comp.entity.scene:findEntityBy("blend1"):getComponents("AnimSeqComponent"):get(0)


    self.animSeqCom2 = comp.entity.scene:findEntityBy("blend1"):getComponents("AnimSeqComponent"):get(1)

    -- self.animSeqCom3 = comp.entity.scene:findEntityBy("blend1"):getComponents("AnimSeqComponent"):get(1)


    self.blendMat = comp.entity.scene:findEntityBy("blend1"):getComponent("MeshRenderer").material

    local Gaussian_lua = comp.entity.scene:findEntityBy("LuaGaussianBlur1"):getComponent("ScriptComponent")
    self.input2_LuaObj1 = Amaz.ScriptUtils.getLuaObj(Gaussian_lua:getScript())

    local LuaGaussianBlur = comp.entity.scene:findEntityBy("LuaGaussianBlur"):getComponent("ScriptComponent")
    self.LuaObj1 = Amaz.ScriptUtils.getLuaObj(LuaGaussianBlur:getScript())
    

    LuaGaussianBlur = comp.entity.scene:findEntityBy("LuaGaussianBlur5"):getComponent("ScriptComponent")
    self.LuaObj3 = Amaz.ScriptUtils.getLuaObj(LuaGaussianBlur:getScript())


    local LuaGaussianBlur = comp.entity.scene:findEntityBy("LuaGaussianBlur3"):getComponent("ScriptComponent")
    self.LuaObj2 = Amaz.ScriptUtils.getLuaObj(LuaGaussianBlur:getScript())

    local LuaDirBlur = comp.entity.scene:findEntityBy("LumiDirectionBlur"):getComponent("ScriptComponent")
    self.DirLuaObj1 = Amaz.ScriptUtils.getLuaObj(LuaDirBlur:getScript())

    local LuaLight = comp.entity.scene:findEntityBy("LuaBrightness"):getComponent("ScriptComponent")

    self.lightLua = Amaz.ScriptUtils.getLuaObj(LuaLight:getScript())


    self.maskMat = comp.entity.scene:findEntityBy("mask"):getComponent("MeshRenderer").material

    self.cutMat = comp.entity.scene:findEntityBy("inputcut"):getComponent("MeshRenderer").material
    self.directionBlurMat = comp.entity.scene:findEntityBy("BlitPass"):getComponent("MeshRenderer").material
    self.blurXMat = comp.entity.scene:findEntityBy("blurX"):getComponent("MeshRenderer").material
    self.blurYMat = comp.entity.scene:findEntityBy("blurY"):getComponent("MeshRenderer").material

    -- Amaz.LOGE("=====>>:",tostring(self.input2_LuaObj1))
    --"Transform"、"AnimSeqComponent"
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
    
    local AEProgress = self.progress
    local input1 = Amaz.BuiltinObject.getUserTexture("#TransitionInput0")
    local input2 = Amaz.BuiltinObject.getUserTexture("#TransitionInput1")
    if input1 and input2 then
        self.input1 = input1
        self.input2 = input2
        -- self.curTime = Amaz.Input.frameTimestamp;
        AEProgress = Amaz.Input.frameTimestamp;

        -- self.waveMat:setTex("inputImageTexture",self.input1)
        -- self.input2_LuaObj1.InputTex = self.input2

    end
    if self.duration < 0.4 then
        AEProgress = AEProgress*1.1
    else
        AEProgress = AEProgress*1.08
    end
    AEProgress = AEProgress <= 1.0 and AEProgress or 1.0
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
 
    end

    local wh = Amaz.Vector2f(w,h)
    local startframe = 0
    local endframe = 43
    local caustic_start_frame = 17
    local curFrame = startframe + AEProgress*(endframe- startframe)
    local caustic_total_frame = 24

    local caustic_frame = math.ceil(caustic_total_frame*_remap01(0, 1, (curFrame-caustic_start_frame)/(endframe-caustic_start_frame)))

    local blur1_stren = self.attrs:GetVal("ADBE_IE_b5a436a58f761f7fd4975e2_0001_0_3", AEProgress)[1]
    self.LuaObj1.intensity = blur1_stren * 0.5

    local blur2_stren = self.attrs:GetVal("ADBE_IE_b5a436a58f761f7fd4975e2_0001_0_4", AEProgress)[1]
    self.LuaObj3.intensity = blur2_stren * 0.5


    local blur2_stren = self.attrs:GetVal("ADBE_IE_b5a436a58f761f7fd4975e2_0001_0_0", AEProgress)[1]
    local dir_blur_stren = self.attrs:GetVal("ADBE_IE_94ef1214fce0c3a65f82dd6_0002_0_1", AEProgress)[1]
    

    local light_stren = self.attrs:GetVal("ADBE_IE_cfd060d81c820aaffc3cd7c_0001_0_2", AEProgress)[1]

    self.input2_LuaObj1.intensity = blur2_stren * 0.5
    self.DirLuaObj1.intensity = dir_blur_stren

    local frame1 = curFrame - startframe
    frame1 = frame1 < 38 and frame1 or 37
    self.animSeqCom1:seek(frame1)

    frame1 = curFrame - startframe



    frame1 = curFrame - startframe
    frame1 = frame1 < 14 and frame1 or 13
    self.animSeqCom2:seek(frame1)


    caustic_frame = AEProgress*43 - 14
    caustic_frame = caustic_frame < 0 and 0 or caustic_frame
    self.animSeqCom:seek(caustic_frame)
    -- Amaz.LOGI("caustic_frame",caustic_frame)
    -- Amaz.LOGI("fps",AEProgress*43)
    -- self.lightLua.radius = deep_glow_radius
    -- Amaz.LOGI("light_stren",light_stren)
    self.lightLua.brightnessIntensity = light_stren*1.50

    local mask_scale = self.attrs:GetVal("ADBE_Scale_0_1", AEProgress)[1]/100
    local offset = (self.attrs:GetVal("ADBE_Position_0_0", AEProgress)[2]-640)/640
    
    self.maskMat:setFloat("scale",mask_scale)
    self.maskMat:setVec2("offset",Amaz.Vector2f(0,offset))


    local sdf_rect = 1.0*self.attrs:GetVal("ADBE_Vector_Rect_Roundness_0_0", math.pow(AEProgress,1.50))[1]/1280
    self.maskMat:setFloat("strength",sdf_rect)


    local stren = self.attrs:GetVal("ADBE_IE_b5a436a58f761f7fd4975e2_0001_0_1", math.pow(AEProgress,1.0))[1]
    self.LuaObj2.intensity = stren

    mask_scale = mask_scale <= 0.0001 and 0.0001 or mask_scale
    self.cutMat:setFloat("scale",mask_scale)
    self.cutMat:setVec2("offset",Amaz.Vector2f(0,offset))

    local scale = self.attrs:GetVal("ADBE_Scale_0_5", AEProgress)[1]/100
    local opt = self.attrs:GetVal("ADBE_Opacity_0_6", AEProgress)[1]/100
    self.blendMat:setFloat("u_scale",scale);
    self.blendMat:setFloat("u_opt",opt);
    -- Amaz.LOGE("=======",opt)
    local waveProgressIns = self.attrs:GetVal("APC_Caustics_0012_0_1",AEProgress)[1]
    local waveIns = self.attrs:GetVal("APC_Caustics_0080_0_2",AEProgress)[1]
    self.waveMat:setFloat("waveProgressIns",waveProgressIns * 1.5)
    self.waveMat:setFloat("waveIns",waveIns * 2.0)

    self.blendMat:setVec2("wh",wh)
    self.blurXMat:setVec2("wh",wh)
    self.blurYMat:setVec2("wh",wh)
    self.maskMat:setVec2("wh",wh)
    self.putSdfTexMat:setVec2("wh",wh)
    self.waveMat:setVec2("wh",wh)
    self.directionBlurMat:setVec2("wh",wh)
    -- self.cutMat:setFloat("fps",AEProgress*43)
    -- Amaz.LOGI("waveIns",waveIns)
    -- Amaz.LOGE("======>>curFrame",curFrame)
end


function SeekModeScript:autoPlay(time)
    if isEditor then
        if self.autoplay then
            self.progress = time % self._duration / self._duration
        end
    else
        self.duration = self.endTime - self.startTime
        self.progress = time % (self.duration+0.0001) / self.duration
    end
end



function SeekModeScript:setDuration(duration)
    self.duration = duration
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

exports.SeekModeScript = SeekModeScript
return exports






