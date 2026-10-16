local ae_attribute = {
	["ADBE_Camera_Lens_Blur_0001_0"]={
		[1]={{0, 16.666666667, }, {0, 16.666666667, }, 14, 0, }, 
		[2]={{0, 33.333333, }, {0, 16.666666667, }, 25, 18, }, 
	}, 
	["ADBE_Wave_Warp_0002_0"]={
		[1]={{0, 16.666666667, }, {0.00000533773997, 26.4119050644324, }, 2, 0, }, 
		[2]={{0.00000377635441, 52.6077977560446, }, {0, 16.666666667, }, 25, 35, }, 
	}, 
	["ADBE_Optics_Compensation_0001_0"]={
		[1]={{0, 16.666666667, }, {0, 16.666666667, }, 0, 0, }, 
		[2]={{0, 33.333333, }, {0, 16.666666667, }, 25, 100, }, 
	}, 
	["ADBE_Scale_0"]={
		[1]={{0, 16.666666667, }, {0, 16.666666667, }, 7, {100, 100, 100, }, }, 
		[2]={{0, 33.333333, }, {0, 16.666666667, }, 25, {180, 180, 100, }, }, 
	}, 
	["ADBE_Rotate_Z_0"]={
		[1]={{0, 16.666666667, }, {0, 16.666666667, }, 11, 0, }, 
		[2]={{0, 33.333333, }, {0, 16.666666667, }, 25, -45, }, 
	}, 
    ["ADBE_Vector_Scale_0"]={
		[1]={{0, 16.666666667, }, {-0.00000192196215, 71.0029179854547, }, 0, {59, 82, }, }, 
		[2]={{-0.00000432473755, 31.9072486603813, }, {0, 16.666666667, }, 25, {0, 100, }, }, 
	}, 
	["ADBE_Vector_Rotation_0"]={
		[1]={{0, 16.666666667, }, {-0.0000010475344, 14.5116948384851, }, 3, 0, }, 
		[2]={{-52.7209486806431, 26.3095721379998, }, {0, 16.666666667, }, 25, -45, }, 
	}, 
}

local util = nil    ---@class Util

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean

local util = nil      ---@type Util

local AETools = AETools or {}     ---@class AETools
AETools.__index = AETools

function AETools:new(frameRate)
    local self = setmetatable({}, AETools)
    self.key_frame_info = {}
    self.frameRate = frameRate == nil and 16 or frameRate
    return self
end

function AETools:addKeyFrameInfo(in_val, out_val, frame, val)
    local key_frame_count = #self.key_frame_info
    if key_frame_count == 0 and frame > 0 then
        self.key_frame_info[key_frame_count + 1] = {
            ["v_in"] = in_val,
            ["v_out"] = out_val,
            ["cur_frame"] = 0,
            ["value"] = val
        }
    end

    key_frame_count = #self.key_frame_info
    self.key_frame_info[key_frame_count + 1] = {
        ["v_in"] = in_val,
        ["v_out"] = out_val,
        ["cur_frame"] = frame,
        ["value"] = val
    }
    self:_updateKeyFrameInfo()
end

function AETools._remap01(a,b,x)
    if x < a then return 0 end
    if x > b then return 1 end
    return (x-a)/(b-a)
end

function AETools._cubicBezier(p1, p2, p3, p4, t)
    return {
        p1[1]*(1.-t)*(1.-t)*(1.-t) + 3*p2[1]*(1.-t)*(1.-t)*t + 3*p3[1]*(1.-t)*t*t + p4[1]*t*t*t,
        p1[2]*(1.-t)*(1.-t)*(1.-t) + 3*p2[2]*(1.-t)*(1.-t)*t + 3*p3[2]*(1.-t)*t*t + p4[2]*t*t*t,
    }
end

function AETools:_cubicBezier01(_bezier_val, p)
    local x = self:_getBezier01X(_bezier_val, p)
    return self._cubicBezier(
        {0,0},
        {_bezier_val[1], _bezier_val[2]},
        {_bezier_val[3], _bezier_val[4]},
        {1,1},
        x
    )[2]
end

function AETools:_getBezier01X(_bezier_val, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts+te)*0.5
        local value = self._cubicBezier(
            {0,0},
            {_bezier_val[1], _bezier_val[2]},
            {_bezier_val[3], _bezier_val[4]},
            {1,1},
            tm)
        if(value[1]>x) then
            te = tm
        else
            ts = tm
        end
    until(te-ts < 0.0001)

    return (te+ts)*0.5
end

function AETools._mix(a, b, x)
    return a * (1-x) + b * x
end

function AETools:_updateKeyFrameInfo()
    if self.key_frame_info and #self.key_frame_info > 0 then
        self.finish_frame_time = self.key_frame_info[#self.key_frame_info]["cur_frame"]
    end
end

function AETools._getDiff(val1, val2)
    local res = nil
    if type(val1) == "table" then
        res = {}
        for i = 1, #val1 do
            res[i] = math.abs(val1-val2)
        end
    else
        res = math.abs(val1-val2)
    end
    return res
end

function AETools:_getSingleCurPartVal(val1, val2, duration, info1, info2, part_progress)
    local diff = math.abs(val1-val2)
    local average = diff/duration + 0.0001

    local x1 = info1[2]/100
    local y1 = x1*info1[1]/average
    local x2 = 1-info2[2]/100
    local y2 = 1-(1-x2)*info2[1]/average

    if val1 > val2 then
        x1 = info1[2]/100
        y1 = -x1*info1[1]/average
        x2 = info2[2]/100
        y2 = 1+x2*info2[1]/average
        x2 = 1-x2
        if(x1 < 0.0002)then y1 = 0 end
        if(y2 < 0.0002)then y2 = 0 end
    end
    local bezier_val = {x1, y1, x2, y2}
    local progress = self:_cubicBezier01(bezier_val, part_progress)

    local res = self._mix(val1, val2, progress)
    return res
end


function AETools:getCurPartVal(_progress, hard_cut)
    
    local part_id, part_progress = self:_getCurPart(_progress)

    local frame1 = self.key_frame_info[part_id-1]
    local frame2 = self.key_frame_info[part_id]

    if hard_cut == true then
        return frame1["value"]
    end

    local info1 = frame1["v_out"]
    local info2 = frame2["v_in"]

    info1[2] = info1[2] < 0.011 and 0 or info1[2]
    info2[2] = info2[2] < 0.011 and 0 or info2[2]

    local duration = (frame2["cur_frame"]-frame1["cur_frame"])/self.frameRate

    local res = nil
    if type(frame1["value"]) == "table" then
        res = {}
        for i = 1, #frame1["value"] do
            res[i] = self:_getSingleCurPartVal(frame1["value"][i], frame2["value"][i], duration, info1, info2, part_progress)
        end
    else
        res = self:_getSingleCurPartVal(frame1["value"], frame2["value"], duration, info1, info2, part_progress)
    end

    return res

end

function AETools:_getCurPart(progress)
    if progress > 0.999 then
        return #self.key_frame_info, 1
    end

    for i = 1, #self.key_frame_info do
        local info = self.key_frame_info[i]
        if progress < info["cur_frame"]/self.finish_frame_time then
            return i, self._remap01(
                self.key_frame_info[i-1]["cur_frame"]/self.finish_frame_time,
                self.key_frame_info[i]["cur_frame"]/self.finish_frame_time,
                progress
            )
        end
    end
end

function AETools:clear()
    self.key_frame_info = {}
    self:_updateKeyFrameInfo()
end

function AETools:test()
    Amaz.LOGI("lrc "..tostring(self.key_frame_info), tostring(#self.key_frame_info))
end


local util = {}     ---@class Util
local json = cjson.new()
local rootDir = nil
local record_t = {}

local function getBezierValue(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3*xc1*(1-t)*(1-t)*t+3*xc2*(1-t)*t*t+t*t*t
    ret[2] = 3*yc1*(1-t)*(1-t)*t+3*yc2*(1-t)*t*t+t*t*t
    return ret
end

local function getBezierDerivative(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3*xc1*(1-t)*(1-3*t)+3*xc2*(2-3*t)*t+3*t*t
    ret[2] = 3*yc1*(1-t)*(1-3*t)+3*yc2*(2-3*t)*t+3*t*t
    return ret
end

local function getBezierTfromX(controls, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts+te)/2
        local value = getBezierValue(controls, tm)
        if(value[1]>x) then
            te = tm
        else
            ts = tm
        end
    until(te-ts < 0.0001)

    return (te+ts)/2
end

local function changeVec2ToTable(val)
    return {val.x, val.y}
end

local function changeVec3ToTable(val)
    return {val.x, val.y, val.z}
end

local function changeVec4ToTable(val)
    return {val.x, val.y, val.z, val.w}
end

local function changeCol3ToTable(val)
    return {val.r, val.g, val.b}
end

local function changeCol4ToTable(val)
    return {val.r, val.g, val.b, val.a}
end

local function changeTable2Vec4(t)
    return Amaz.Vector4f(t[1], t[2], t[3], t[4])
end

local function changeTable2Vec3(t)
    return Amaz.Vector3f(t[1], t[2], t[3])
end

local function changeTable2Vec2(t)
    return Amaz.Vector2f(t[1], t[2])
end

local function changeTable2Col3(t)
    return Amaz.Color(t[1], t[2], t[3])
end

local function changeTable2Col4(t)
    return Amaz.Color(t[1], t[2], t[3], t[4])
end

local _typeSwitch = {
    ["vec4"] = function(v)
        return changeVec4ToTable(v)
    end,
    ["vec3"] = function(v)
        return changeVec3ToTable(v)
    end,
    ["vec2"] = function(v)
        return changeVec2ToTable(v)
    end,
    ["float"] = function(v)
        return tonumber(v)
    end,
    ["string"] = function(v)
        return tostring(v)
    end,
    ["col3"] = function(v)
        return changeCol3ToTable(v)
    end,
    ["col4"] = function(v)
        return changeCol4ToTable(v)
    end,

    -- change table to userdata
    ["_vec4"] = function(v)
        return changeTable2Vec4(v)
    end,
    ["_vec3"] = function(v)
        return changeTable2Vec3(v)
    end,
    ["_vec2"] = function(v)
        return changeTable2Vec2(v)
    end,
    ["_float"] = function(v)
        return tonumber(v)
    end,
    ["_string"] = function(v)
        return tostring(v)
    end,
    ["_col3"] = function(v)
        return changeTable2Col3(v)
    end,
    ["_col4"] = function(v)
        return changeTable2Col4(v)
    end,
}

local function typeSwitch()
    return _typeSwitch
end

local function createTableContent()
    -- Amaz.LOGI("lrc", "createTableContent")
    local t = {}
    for k,v in pairs(record_t) do
        t[k] = {}
        t[k]["type"] = v["type"]
        t[k]["val"] = v["func"](v["val"])
    end
    return t
end

function util.registerParams(_name, _data, _type)
    record_t[_name] = {
        ["type"] = _type,
        ["val"] = _data,
        ["func"] = _typeSwitch[_type]
    }
end

function util.getRegistedParams()
    return record_t
end

function util.setRegistedVal(_name, _data)
    record_t[_name]["val"] = _data
end

function util.getRootDir()
    if rootDir == nil then
        local str = debug.getinfo(2, "S").source
        rootDir = str:match("@?(.*/)")
    end
    Amaz.LOGI("lrc getRootDir 123", tostring(rootDir))
    return rootDir
end

function util.registerRootDir(path)
    rootDir = path
end

function util.bezier(controls)
    local control = controls
    if type(control) ~= "table" then
        control = changeVec4ToTable(controls)
    end
    return function (t, b, c, d)
        t = t/d
        local tvalue = getBezierTfromX(control, t)
        local value =  getBezierValue(control, tvalue)
        return b + c * value[2]
    end
end

function util.remap01(a,b,x)
    if x < a then return 0 end
    if x > b then return 1 end
    return (x-a)/(b-a)
end

function util.mix(a, b, x)
    return a * (1-x) + b * x
end

function util.CreateJsonFile(file_path)
    local t = createTableContent()
    local content = json.encode(t)
    local file = io.open(util.getRootDir()..file_path, "w+b")
    if file then
      file:write(tostring(content))
      io.close(file)
    end
end

function util.ReadFromJson(file_path)
    local file = io.input(util.getRootDir()..file_path)
    local json_data = json.decode(io.read("*a"))
    local res = {}
    for k, v in pairs(json_data) do
        local func = _typeSwitch["_"..tostring(v["type"])]
        res[k] = func(v["val"])
    end
    return res
end

function util.bezierWithParams(input_val_4, min_val, max_val, in_val, reverse)
    if type(input_val_4) == "tabke" then
        if reverse == nil then
            return util.bezier(input_val_4)(util.remap01(min_val, max_val, in_val), 0, 1, 1)
        else
            return util.bezier(input_val_4)(1-util.remap01(min_val, max_val, in_val), 0, 1, 1)
        end
    else
        if reverse == nil then
            return util.bezier(util.changeVec4ToTable(input_val_4))(util.remap01(min_val, max_val, in_val), 0, 1, 1)
        else
            return util.bezier(util.changeVec4ToTable(input_val_4))(1-util.remap01(min_val, max_val, in_val), 0, 1, 1)
        end
    end
end

function util.test()
    Amaz.LOGI("lrc", "test123")
end

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

	self.cur_frame = 0

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
    self.videoMat = self.entity.scene:findEntityBy("base_AmazingFeature"):searchEntity("video"):getComponent("MeshRenderer").material
    self.modelMat = self.entity.scene:findEntityBy("base_AmazingFeature"):searchEntity("quad"):getComponent("MeshRenderer").material
    self.fxaaMat = self.entity.scene:findEntityBy("base_AmazingFeature"):searchEntity("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.entity.scene:findEntityBy("base_AmazingFeature"):searchEntity("blend"):getComponent("MeshRenderer").material
    self.transform = self.entity.scene:findEntityBy("base_AmazingFeature"):searchEntity("quad"):getComponent("Transform")
    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)
end

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)

    self.matTransform = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassTransform"):getComponent("MeshRenderer").material
    self.matHorzBlur = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassHorzBlur"):getComponent("MeshRenderer").material
    self.matVertBlur = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassVertBlur"):getComponent("MeshRenderer").material
    self.matHorzBlur1 = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassHorzBlur1"):getComponent("MeshRenderer").material
    self.matVertBlur1 = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassVertBlur1"):getComponent("MeshRenderer").material
    self.matWave = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassWave"):getComponent("MeshRenderer").material
    self.matFOV = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassFOV"):getComponent("MeshRenderer").material
    self.matMask = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassMask"):getComponent("MeshRenderer").material

    self.camHorzBlurRT = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("CameraTransform"):getComponent("Camera").renderTexture
    self.camVertBlurRT = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("CameraHorzBlur"):getComponent("Camera").renderTexture
    self.camHorzBlurRT1 = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("CameraVertBlur"):getComponent("Camera").renderTexture
    self.camVertBlurRT1 = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("CameraHorzBlur1"):getComponent("Camera").renderTexture
    if self.curveScale == nil then
		self.curveScale = AETools:new()
		for i = 1, #ae_attribute.ADBE_Scale_0 do
			local value = ae_attribute.ADBE_Scale_0[i]
			self.curveScale:addKeyFrameInfo(value[1], value[2], value[3], value[4][1])
		end
	end

    if self.curveRotate == nil then
		self.curveRotate = AETools:new()
		for i = 1, #ae_attribute.ADBE_Rotate_Z_0 do
			local value = ae_attribute.ADBE_Rotate_Z_0[i]
			self.curveRotate:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveBlur == nil then
		self.curveBlur = AETools:new()
		for i = 1, #ae_attribute.ADBE_Camera_Lens_Blur_0001_0 do
			local value = ae_attribute.ADBE_Camera_Lens_Blur_0001_0[i]
			self.curveBlur:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveWaveHeight == nil then
		self.curveWaveHeight = AETools:new()
		for i = 1, #ae_attribute.ADBE_Wave_Warp_0002_0 do
			local value = ae_attribute.ADBE_Wave_Warp_0002_0[i]
			self.curveWaveHeight:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end
    -- if self.curveWaveWidth == nil then
	-- 	self.curveWaveWidth = AETools:new()
	-- 	for i = 1, #ae_attribute.ADBE_Wave_Warp_0003_0 do
	-- 		local value = ae_attribute.ADBE_Wave_Warp_0003_0[i]
	-- 		self.curveWaveWidth:addKeyFrameInfo(value[1], value[2], value[3], value[4])
	-- 	end
	-- end
    if self.curveFOV == nil then
		self.curveFOV = AETools:new()
		for i = 1, #ae_attribute.ADBE_Optics_Compensation_0001_0 do
			local value = ae_attribute.ADBE_Optics_Compensation_0001_0[i]
			self.curveFOV:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveMaskWidth == nil then
		self.curveMaskWidth = AETools:new()
		for i = 1, #ae_attribute.ADBE_Vector_Scale_0 do
			local value = ae_attribute.ADBE_Vector_Scale_0[i]
			self.curveMaskWidth:addKeyFrameInfo(value[1], value[2], value[3], value[4][1])
		end
	end

    if self.curveMaskAngle == nil then
		self.curveMaskAngle = AETools:new()
		for i = 1, #ae_attribute.ADBE_Vector_Rotation_0 do
			local value = ae_attribute.ADBE_Vector_Rotation_0[i]
			self.curveMaskAngle:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    -- if util == nil then
    --     util = includeRelativePath("Util")
    -- end
    util.registerRootDir(comp.entity.scene.assetMgr.rootDir)

    self.rootDir = comp.entity.scene.assetMgr.rootDir

end

function SeekModeScript:initKeyFrame(attribute_table, frameRate) 
    for _name, info_list in pairs(attribute_table) do
        local tool = AETools:new(frameRate)
        for i = 1, #info_list do
            tool:addKeyFrameInfo(info_list[i][1], info_list[i][2], info_list[i][3], info_list[i][4])
        end
        self[_name] = tool
    end
end

function SeekModeScript:autoPlay(time)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        if self.autoplay then
            self.progress = time % self._duration / self._duration
        end
    else
        self.duration = self.endTime - self.startTime
        self.progress = time % self.duration / self.duration
    end
end

function SeekModeScript:autoPlay(time)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        if self.autoplay then
            self.progress = time % self._duration / self._duration
        end
    else
        -- self.duration = self.endTime - self.startTime
        -- self.progress = time % self.duration / self.duration
        self.progress = math.mod(time/(self.duration+0.0001), 1)
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

    self.progress = time / self.duration
    if self.progress > 1 then
        self.progress = 1
    end

    self.matTransform:setFloat("scale", self.curveScale:getCurPartVal(self.progress) / 100)
    self.matTransform:setFloat("angle", self.curveRotate:getCurPartVal(self.progress))
    self.matHorzBlur:setFloat("horzR", 20 * self.curveBlur:getCurPartVal(self.progress) / 18)
    self.matVertBlur:setFloat("vertR", 20 * self.curveBlur:getCurPartVal(self.progress) / 18)
    self.matHorzBlur1:setFloat("horzR", 20 * self.curveBlur:getCurPartVal(self.progress) / 18)
    self.matVertBlur1:setFloat("vertR", 20 * self.curveBlur:getCurPartVal(self.progress) / 18)
    -- self.camHorzBlurRT.pecentX = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
    -- self.camHorzBlurRT.pecentY = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
    -- self.camVertBlurRT.pecentX = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
    -- self.camVertBlurRT.pecentY = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
    -- self.camHorzBlurRT1.pecentX = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
    -- self.camHorzBlurRT1.pecentY = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
    -- self.camVertBlurRT1.pecentX = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
    -- self.camVertBlurRT1.pecentY = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
    self.matWave:setFloat("waveHeight", self.curveWaveHeight:getCurPartVal(self.progress) / 35)
    self.matWave:setFloat("waveWidth", (300 - 220) / 32)
    self.matWave:setFloat("progress", self.progress)
    self.matFOV:setFloat("fov", self.curveFOV:getCurPartVal(self.progress) / 100)
    self.matMask:setFloat("width", self.curveMaskWidth:getCurPartVal(self.progress) / 59)
    self.matMask:setFloat("angle", -self.curveMaskAngle:getCurPartVal(self.progress))
end

function SeekModeScript:seek(time)
    self:_adapt_seek(time)
    self:autoPlay(time)
    -- if self.autoplay then
        -- self.progress = math.mod(time/(self.duration+0.0001), 1)
    -- end

    -- self.progress = math.floor(self.progress*27)/27

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    
    local progress = self.progress

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
