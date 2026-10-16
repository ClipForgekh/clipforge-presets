local util = nil    ---@class Util

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean
---@field noise_value number
---@field input_fov number
---@field d_power number
---@field z_power number
---@field radial_blur_intensity number
---@field circle Vector2f


local util = nil      ---@type Util

local AETools = AETools or {}     ---@class AETools
AETools.__index = AETools

function AETools:new(_util, ...)
    local self = setmetatable({}, AETools)
    util = _util
    self.key_frame_info = {}
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
    -- Amaz.LOGI(tostring(#self.key_frame_info).." lrc add "..tostring(self.key_frame_info), tostring(val))
    self:_updateKeyFrameInfo()
end

function AETools:_updateKeyFrameInfo()
    if self.key_frame_info and #self.key_frame_info > 0 then
        self.finish_frame_time = self.key_frame_info[#self.key_frame_info]["cur_frame"]
    end
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


    local average = (info1[1] + info2[1]) * 0.5 + 0.001
    local affect_val1 = info1[2]/100
    local affect_val2 = 1-info2[2]/100

    local bezier_val = {
        affect_val1,            
        math.abs(info1[1]/average * affect_val1),     
        affect_val2,            
        math.abs(1-info2[1]/average * affect_val2)
    }

    local progress = util.bezier(bezier_val)(part_progress, 0, 1, 1)

    if type(frame1["value"]) == "number" then
        return util.mix(frame1["value"], frame2["value"], progress)
    end

    local res = {}
    for i = 1, #frame1["value"] do
        res[i] = util.mix(frame1["value"][i], frame2["value"][i], progress)
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
            return i, util.remap01(
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


local ae_attribute = {
	["turbulent_number"]={
		[1]={{0, 16.666666667, }, {0, 15.8900555065307, }, 0, 50, }, 
		[2]={{0, 26.9027112438604, }, {0, 41.3659963905399, }, 8, 30, }, 
		[3]={{0, 33.333333, }, {1.02234446288579, 36.1498804860711, }, 16.3, 0, }, 
		[4]={{36.5987739169046, 30.604269818725, }, {9.39699812943627, 100, }, 16.4, 0, }, 
		[5]={{0, 37.5900075916952, }, {0, 33.333333, }, 18, 30, }, 
	}, 
	["turbulent_offset"]={
		[1]={{0, 16.666666667, }, {1094.36833360015, 16.666666667, }, -0.00009765625, {523, 2415.75, }, }, 
		[2]={{0, 86, }, {0, 16.666666667, }, 18, {1240, 2187.75, }, }, 
	}, 
	["radial_blur_number"]={
		[1]={{0, 16.666666667, }, {-426.666666666667, 16.666666667, }, -0.00009765625, 20, }, 
		[2]={{0, 33.333333, }, {0, 16.666666667, }, 2.99990234375, 0, }, 
		[3]={{0, 33.333333, }, {0, 16.666666667, }, 17.99990234375, 0, }, 
	}, 
	["scale_value"]={
		[1]={{0, 16.666666667, }, {-182.044444444444, 16.666666667, }, 0., 200, }, 
		[2]={{0, 98.9766488450656, }, {0, 16.666666667, }, 17, 100, }, 
		[3]={{0, 98.9766488450656, }, {0, 16.666666667, }, 17.99990234375, 100, }, 
	}, 
    ["r_offset"]={
		[1]={{0, 16.666666667, }, {0, 16.666666667, }, 11, 0, }, 
		[2]={{0.8573542919567, 16.666666667, }, {0.8573542919567, 16.666666667, }, 12, 0, }, 
		[3]={{12.7469724223653, 16.666666667, }, {12.7469724223653, 16.666666667, }, 13, 0.10716928649459, }, 
		[4]={{38.9229684593714, 16.666666667, }, {38.9229684593714, 16.666666667, }, 14, 1.59337155279566, }, 
		[5]={{70.2438955205497, 16.666666667, }, {70.2438955205497, 16.666666667, }, 15, 4.97254034391601, }, 
		[6]={{80.2196772486719, 16.666666667, }, {80.2196772486719, 16.666666667, }, 16, 10.3738584928644, }, 
		[7]={{74.01826411417, 16.666666667, }, {0, 16.666666667, }, 17, 15, }, 
	}, 
}

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

    self.ins = 0

	self.cur_frame = 0
    self.noise_value = 0
    self.input_fov = 1
    self.d_power = 2
    self.z_power = 2

    self.radial_blur_intensity = 1

    self.circle = Amaz.Vector2f(0.3, 0.05)

    -- self:registerParams("circle_anim_timer", "vec2")
    -- self:registerParams("blur_info", "vec4")
    -- self:registerParams("rotate_bezier1", "vec4")
    -- self:registerParams("rotate_bezier2", "vec4")
    -- self:registerParams("blur_bezier1", "vec4")
    -- self:registerParams("blur_bezier2", "vec4")

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

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)

    -- if util == nil then
    --     util = includeRelativePath("Util")
    -- end
    util.registerRootDir(comp.entity.scene.assetMgr.rootDir)

    self.rootDir = comp.entity.scene.assetMgr.rootDir

    self.bottom_mat = comp.entity.scene:findEntityBy("bottom"):getComponent("MeshRenderer").material
    self.fisheye_mat = comp.entity.scene:findEntityBy("fisheye"):getComponent("MeshRenderer").material
    self.blur1_mat = comp.entity.scene:findEntityBy("blur1"):getComponent("MeshRenderer").material
    self.blur2_mat = comp.entity.scene:findEntityBy("blur2"):getComponent("MeshRenderer").material
    self.chromatic_mat = comp.entity.scene:findEntityBy("chromatic"):getComponent("MeshRenderer").material
    self.res_mat = comp.entity.scene:findEntityBy("res"):getComponent("MeshRenderer").material

    self:initKeyFrame()

end

function SeekModeScript:initKeyFrame() 
    for _name, info_list in pairs(ae_attribute) do
        local tool = AETools:new(util)
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
end

function SeekModeScript:seek(time)
    self:_adapt_seek(time)
    self.progress = math.mod(time/(self.duration+0.0001), 1)

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()

    local turbulent_number = self.turbulent_number:getCurPartVal(self.progress)
    self.bottom_mat:setFloat("turbulent_number", turbulent_number)

    -- Amaz.LOGI("lrc", turbulent_number)

    local turbulent_offset = self.turbulent_offset:getCurPartVal(self.progress)
    self.bottom_mat:setVec2("turbulent_offset", Amaz.Vector2f(turbulent_offset[0], turbulent_offset[1]))
    self.bottom_mat:setFloat("radial_blur_number", 1+self.radial_blur_number:getCurPartVal(self.progress)/100)
    local scale_value_progress = util.remap01(0., 1, self.progress)
    scale_value_progress = util.bezier({0,1.17,0,.88})(scale_value_progress, 0, 1, 1)
    self.bottom_mat:setFloat("scale_value", util.mix(8, 1, scale_value_progress))

    -- Amaz.LOGI("lrc", self.scale_value:getCurPartVal(self.progress))
    self.chromatic_mat:setVec2("r_offset", Amaz.Vector2f(self.r_offset:getCurPartVal(self.progress)/w*1, 0))
    self.chromatic_mat:setVec2("r_offset", Amaz.Vector2f(0, 0))

    local fov_progress = util.remap01(15/18, 1, self.progress)
    local fov_intensity = util.mix(1, 10, util.bezier({1,.02,.81,.12})(fov_progress, 0, 1, 1))
    self.fisheye_mat:setFloat("input_fov", fov_intensity)
    -- self.fisheye_mat:setFloat("input_fov", self.input_fov)
    self.fisheye_mat:setFloat("d_power", self.d_power)
    self.fisheye_mat:setFloat("z_power", 1/self.z_power)
    self.fisheye_mat:setVec2("circle_info", Amaz.Vector2f(
        0.2 * fov_intensity,
        0.9 * fov_intensity
    ))

    -- Amaz.LOGI("lrc progress", self.progress)
    local blur_progress = util.remap01(16/18, 17/18, self.progress)
    self.blur1_mat:setFloat("blurSize", blur_progress)
    self.blur2_mat:setFloat("blurSize", blur_progress)

    self.res_mat:setVec2("circle", Amaz.Vector2f(
        self.circle.x * blur_progress,
        self.circle.y * blur_progress
        ))
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
