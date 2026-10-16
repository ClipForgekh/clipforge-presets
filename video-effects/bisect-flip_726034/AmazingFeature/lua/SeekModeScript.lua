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

local AETools = AETools or {}
AETools.__index = AETools

function AETools:new(attrs)
    local self = setmetatable({}, AETools)
    self.attrs = attrs

    local max_frame = 0
    local min_frame = 100000
    for _,v in pairs(attrs) do
        for i = 1, #v do
            local content = v[i]
            local cur_frame_min = content[2][1]
            local cur_frame_max = content[2][2]
            max_frame = math.max(cur_frame_max, max_frame)
            min_frame = math.min(cur_frame_min, min_frame)
        end
    end

    self.all_frame = max_frame - min_frame
    self.min_frame = min_frame

    return self
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

function AETools:GetVal(_name, _progress)
    local content = self.attrs[_name]
    if content == nil then
        return nil
    end

    local cur_frame = _progress * self.all_frame + self.min_frame

    for i = 1, #content do
        local info = content[i]
        local start_frame = info[2][1]
        local end_frame = info[2][2]
        if cur_frame >= start_frame and cur_frame < end_frame then
            local cur_progress = self._remap01(start_frame, end_frame, cur_frame)
            local bezier = info[1]
            local value_range = info[3]

            if #bezier > 4 then
                -- currently scale attrs contains more than 4 bezier values
                local res = {}
                for k = 1, 3 do
                    local cur_bezier = {bezier[k], bezier[k+3], bezier[k+3*2], bezier[k+3*3]}
                    local p = self:_cubicBezier01(cur_bezier, cur_progress)
                    res[k] = self._mix(value_range[1][k], value_range[2][k], p)
                end
                return res

            else
                local p = self:_cubicBezier01(bezier, cur_progress)
 
                if type(value_range[1]) == "table" then
                    local res = {}
                    for j = 1, #value_range[1] do
                        res[j] = self._mix(value_range[1][j], value_range[2][j], p)
                    end
                    return res
                end
                return self._mix(value_range[1], value_range[2], p)
            end

        end
    end

    local first_info = content[1]
    local start_frame = first_info[2][1]
    if cur_frame<start_frame then
        return first_info[3][1]
    end

    local last_info = content[#content]
    local end_frame = last_info[2][2]
    if cur_frame>=end_frame then
        return last_info[3][2]
    end

    return nil
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
	["ADBE_Rotate_X_0_0"]={
		{{0.001, 0, 0.3, 0.707792208, }, {0, 8, }, {{-80, }, {0, }, }, {6417, }, }, 
	}, 
	["ADBE_Rotate_X_1_1"]={
		{{0.001, 0, 0.3, 0.7, }, {0, 8, }, {{79, }, {0, }, }, {6417, }, }, 
	}, 
	["ADBE_Position_2_2"]={
		{{0.44, 0, 0.61, 1, }, {0, 6, }, {{570, 807, 0, }, {493, 808, 0, }, {570, 807, 0, }, {493, 808, 0, }, }, {6413, }, }, 
		{{0.27, 0, 0.51, 1, }, {6, 17, }, {{493, 808, 0, }, {540, 810, 0, }, {493, 808, 0, }, {540, 810, 0, }, }, {6413, }, }, 
	}, 
	["ADBE_Scale_2_3"]={
		{{0.48,0.48,0.48, 0,0,0, 0.61,0.61,0.61, 1,1,1, }, {0, 7, }, {{94, 94, 94, }, {106, 106, 106, }, }, {6414, }, }, 
		{{0.34806626,0.34806626,0.34806626, 0,0,0, 0.66,0.66,0.66, 1,1,1, }, {7, 14, }, {{106, 106, 106, }, {98.5, 98.5, 98.5, }, }, {6414, }, }, 
		{{0.24454848,0.24454848,0.24454848, 0,0,0, 0.59116647,0.59116647,0.59116647, 1,1,1, }, {14, 21, }, {{98.5, 98.5, 98.5, }, {100, 100, 100, }, }, {6414, }, }, 
	}, 
	["ADBE_Rotate_Z_2_4"]={
		{{0.37250953, 0, 0.579678024, 1, }, {0, 9, }, {{7.5, }, {-2.5, }, }, {6417, }, }, 
		{{0.309484981, 0, 0.58158635, 1, }, {9, 19, }, {{-2.5, }, {0, }, }, {6417, }, }, 
	}, 
}

local ae_attribute1 = {
	["ADBE_Marker_0_0"]={
	}, 
	["Smart_Motion_Blur_3.x_0001_0_1"]={
		{{0.299636066, 0, 0.523494946, 1, }, {0, 8, }, {{0.4, }, {2.736738, }, }, {6417, }, }, 
		{{0.491418413, 0, 0.806619584, 1, }, {8, 21, }, {{2.736738, }, {0, }, }, {6417, }, }, 
	}, 
	["ADBE_IE_5a1ff1b7caffac514aaba44-0001_0_2"]={
		{{0.47425566, 0, 0.601431696, 1, }, {0, 4, }, {{0.6, }, {1.5, }, }, {6417, }, }, 
		{{0.240009846, 0, 0.468602522, 1, }, {4, 21, }, {{1.5, }, {0, }, }, {6417, }, }, 
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

    self.radial_blur_intensity = 1
    self.utime = 0

    self.u_fov = 0
    self.u_Size = 100
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

local function getluaobj(_script)
    return Amaz.ScriptUtils.getLuaObj(_script:getScript())
end

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)
    Amaz.LOGE("lrc onstart", "SeekModeScript")

    -- if util == nil then
    --     util = includeRelativePath("Util")
    -- end
    util.registerRootDir(comp.entity.scene.assetMgr.rootDir)

    -- self.basemove_mat = comp.entity.scene:findEntityBy("basemove"):getComponent("MeshRenderer").material
    self.res_mat = comp.entity.scene:findEntityBy("res"):getComponent("MeshRenderer").material

    -- self.gaussian_blur_lua = comp.entity.scene:findEntityBy("Gaussian_Blur_Root"):getComponent("ScriptComponent")
    -- self.gaussian_blur_lua = getluaobj(self.gaussian_blur_lua)

    -- -- self.gaussian_blur2_lua = comp.entity.scene:findEntityBy("Gaussian_Blur_Root2"):getComponent("ScriptComponent")
    -- -- self.gaussian_blur2_lua = getluaobj(self.gaussian_blur2_lua)

    self.ae_trans_up_entity = comp.entity.scene:findEntityBy("AE_Transform_up")
    self.ae_trans_up_lua = self.ae_trans_up_entity:getComponent("ScriptComponent")
    self.ae_trans_up_lua = getluaobj(self.ae_trans_up_lua)

    self.ae_trans_down_entity = comp.entity.scene:findEntityBy("AE_Transform_down")
    self.ae_trans_down_lua = self.ae_trans_down_entity:getComponent("ScriptComponent")
    self.ae_trans_down_lua = getluaobj(self.ae_trans_down_lua)

    self.ae_trans_entity = comp.entity.scene:findEntityBy("AE_Transform")
    self.ae_trans_lua = self.ae_trans_entity:getComponent("ScriptComponent")
    self.ae_trans_lua = getluaobj(self.ae_trans_lua)

    -- self.retouch_adjust_lua = comp.entity.scene:findEntityBy("lumi_ajust"):getComponent("ScriptComponent")
    -- self.retouch_adjust_lua = getluaobj(self.retouch_adjust_lua)

    -- self.adjust_glow_lua = comp.entity.scene:findEntityBy("AdjustGlow"):getComponent("ScriptComponent")
    -- self.adjust_glow_lua = getluaobj(self.adjust_glow_lua)


    self.attrs = AETools:new(ae_attribute)
    self.attrs1 = AETools:new(ae_attribute1)
    -- Amaz.LOGI("lrc "..111, tostring())
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


    local input_size = Amaz.Vector2f(inputW, inputH)
    local output_size = Amaz.Vector2f(outputW, outputH)
    local uv_scale = Amaz.Vector2f(0,0)
    self.modelMat:setVec2("uv_scale", uv_scale)

    self.res_mat:setVec2("output_size", output_size)

    -- local 
    -- self.modelMat:setFloat("uv_rot", )

end

function SeekModeScript:seek(time)
    self:_adapt_seek(time)

    if isEditor then
    else
        self.progress = math.mod(time/(self.duration+0.0001), 1)
    end

    local p = self.progress
    if isEditor then
        p = math.floor(p*21)/21
    end

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()

    local ow = Amaz.BuiltinObject:getOutputTextureWidth()
    local oh = Amaz.BuiltinObject:getOutputTextureHeight()

    Amaz.LOGE("lrc seek", "seek")

    self:_UpdateBasemove(p)
    self:_UpdateRes(p)
    -- self:_UpdateSGlow(p)

    -- local op_wh = Amaz.Vector2f(ow, oh)
    -- local ip_wh = Amaz.Vector2f(w, h)
    -- self.basemove_mat:setVec2("output_size", ip_wh)
    -- self.res_mat:setVec2("output_size", ip_wh)

    -- local blur_alpha = self.attrs1:GetVal("outerGlow/blur_2_6", p)
    -- blur_alpha = blur_alpha[1]
    -- self.res_mat:setFloat("blur_alpha", blur_alpha/200)
end

function SeekModeScript:_UpdateRes(_p)
    local p = _p
    local u_Intensity = self.attrs1:GetVal("ADBE_IE_5a1ff1b7caffac514aaba44-0001_0_2", p)
    u_Intensity = u_Intensity[1]
    -- Amaz.LOGI("lrc "..p*21, tostring(u_Intensity))
    self.res_mat:setFloat("u_Intensity", u_Intensity)
    self.res_mat:setFloat("u_Offset", 0)
    self.res_mat:setFloat("u_GrayscaleCorrect", 1)
    self.res_mat:setFloat("use_linear_light", 0)
end

function SeekModeScript:_UpdateBasemove(_p)
    local p = _p
    local ow = Amaz.BuiltinObject:getOutputTextureWidth()
    local oh = Amaz.BuiltinObject:getOutputTextureHeight()

    local blur_range = 0.07
    local left_p = p-blur_range*0.5
    left_p = left_p<0 and 0 or left_p

    local right_p = p+blur_range*0.5
    right_p = right_p>1 and 1 or right_p

    -- if p * 21 > 8 then
    if p * 21 > 8 then
        self.ae_trans_lua.cam_visible = true
        self.ae_trans_up_lua.cam_visible = false
        self.ae_trans_down_lua.cam_visible = false

        self.ae_trans_lua.pivot = Amaz.Vector3f(540, 810, 0)
        -- self.ae_trans_lua.pivot = Amaz.Vector3f(540, 540, 0)

        local pos_left = self.attrs:GetVal("ADBE_Position_2_2", left_p)
        pos_left = Amaz.Vector3f(pos_left[1], pos_left[2], 0)
        local pos_right = self.attrs:GetVal("ADBE_Position_2_2", right_p)
        pos_right = Amaz.Vector3f(pos_right[1], pos_right[2], 0)
        self.ae_trans_lua.position = pos_right
        self.ae_trans_lua.prePosition = pos_left

        -- self.ae_trans_lua.position = Amaz.Vector3f(540, 540, 0)
        -- self.ae_trans_lua.prePosition = Amaz.Vector3f(540, 540, 0)
    
        local scale_left = self.attrs:GetVal("ADBE_Scale_2_3", left_p)
        scale_left = Amaz.Vector3f(scale_left[1]*0.01, scale_left[2]*0.01, scale_left[2]*0.01)
        local scale_right = self.attrs:GetVal("ADBE_Scale_2_3", right_p)
        scale_right = Amaz.Vector3f(scale_right[1]*0.01, scale_right[2]*0.01, scale_right[2]*0.01)
        
        -- scale_left = scale_left*0.5
        -- scale_right = scale_right*0.5

        self.ae_trans_lua.preScale = scale_left
        self.ae_trans_lua.scale = scale_right

        -- self.ae_trans_lua.preScale = Amaz.Vector3f(0.5,0.5,1)
        -- self.ae_trans_lua.scale = Amaz.Vector3f(0.5,0.5,1)
    
        local rot_left = self.attrs:GetVal("ADBE_Rotate_Z_2_4", left_p)
        rot_left = rot_left[1]
        local rot_right = self.attrs:GetVal("ADBE_Rotate_Z_2_4", right_p)
        rot_right = rot_right[1]

        -- rot_left = -40
        -- rot_right = -40

        self.ae_trans_lua.preRotation = Amaz.Vector3f(0,0, rot_left)
        self.ae_trans_lua.rotation = Amaz.Vector3f(0,0, rot_right)

        self.ae_trans_lua.y_offset = 0.

    else
        self.ae_trans_lua.cam_visible = false
        self.ae_trans_up_lua.cam_visible = true
        self.ae_trans_down_lua.cam_visible = true

        self.ae_trans_up_lua.pivot = Amaz.Vector3f(540, 810, 0)
        self.ae_trans_down_lua.pivot = Amaz.Vector3f(540, 810, 0)
        self.ae_trans_lua.pivot = Amaz.Vector3f(540, 810, 0)
    
        local pos_left = self.attrs:GetVal("ADBE_Position_2_2", left_p)
        pos_left = Amaz.Vector3f(pos_left[1], pos_left[2], 0)
        local pos_right = self.attrs:GetVal("ADBE_Position_2_2", right_p)
        pos_right = Amaz.Vector3f(pos_right[1], pos_right[2], 0)
        self.ae_trans_up_lua.position = pos_right
        self.ae_trans_up_lua.prePosition = pos_left
        self.ae_trans_down_lua.position = pos_right
        self.ae_trans_down_lua.prePosition = pos_left
        self.ae_trans_lua.position = pos_right
        self.ae_trans_lua.prePosition = pos_left
    
        local scale_left = self.attrs:GetVal("ADBE_Scale_2_3", left_p)
        scale_left = Amaz.Vector3f(scale_left[1]*0.01, scale_left[2]*0.01, scale_left[2]*0.01)
        local scale_right = self.attrs:GetVal("ADBE_Scale_2_3", right_p)
        scale_right = Amaz.Vector3f(scale_right[1]*0.01, scale_right[2]*0.01, scale_right[2]*0.01)
        
        -- scale_left = scale_left*0.5
        -- scale_right = scale_right*0.5

        self.ae_trans_up_lua.preScale = scale_left
        self.ae_trans_up_lua.scale = scale_right
        self.ae_trans_down_lua.preScale = scale_left
        self.ae_trans_down_lua.scale = scale_right
        self.ae_trans_lua.preScale = scale_left
        self.ae_trans_lua.scale = scale_right
    
        local rot_left = self.attrs:GetVal("ADBE_Rotate_Z_2_4", left_p)
        rot_left = rot_left[1]
        local rot_right = self.attrs:GetVal("ADBE_Rotate_Z_2_4", right_p)
        rot_right = rot_right[1]
        self.ae_trans_up_lua.preRotation = Amaz.Vector3f(0,0, rot_left)
        self.ae_trans_up_lua.rotation = Amaz.Vector3f(0,0, rot_right)
        self.ae_trans_down_lua.preRotation = Amaz.Vector3f(0,0, rot_left)
        self.ae_trans_down_lua.rotation = Amaz.Vector3f(0,0, rot_right)
        self.ae_trans_lua.preRotation = Amaz.Vector3f(0,0, rot_left)
        self.ae_trans_lua.rotation = Amaz.Vector3f(0,0, rot_right)
    
        local rot_x1_left = self.attrs:GetVal("ADBE_Rotate_X_0_0", left_p)
        rot_x1_left = rot_x1_left[1]
        local rot_x1_right = self.attrs:GetVal("ADBE_Rotate_X_0_0", right_p)
        rot_x1_right = rot_x1_right[1]
        self.ae_trans_up_lua.preChildRotation = Amaz.Vector3f(rot_x1_left, 0, 0)
        self.ae_trans_up_lua.child_rotation = Amaz.Vector3f(rot_x1_right, 0, 0)
        
    
        local rot_x2_left = self.attrs:GetVal("ADBE_Rotate_X_1_1", left_p)
        rot_x2_left = rot_x2_left[1]
        local rot_x2_right = self.attrs:GetVal("ADBE_Rotate_X_1_1", right_p)
        rot_x2_right = rot_x2_right[1]
        self.ae_trans_down_lua.preChildRotation = Amaz.Vector3f(rot_x2_left, 0, 0)
        self.ae_trans_down_lua.child_rotation = Amaz.Vector3f(rot_x2_right, 0, 0)
    
        self.ae_trans_up_lua.y_offset = 0.5
        self.ae_trans_down_lua.y_offset = -0.5
    end

end

function SeekModeScript:_UpdateBlur(_p)
    local p = _p

    local gaussain_blur1 = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_1", p)
    gaussain_blur1 = gaussain_blur1[1]
    self.gaussian_blur1_lua.Intensity = gaussain_blur1

    local gaussain_blur2 = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_2", p)
    gaussain_blur2 = gaussain_blur2[1]
    self.gaussian_blur2_lua.Intensity = gaussain_blur2

    local radial_blur = self.attrs:GetVal("ADBE_Radial_Blur_0001_0_3", p)
    radial_blur = radial_blur[1]
    self.radial_blur_lua.Amount = radial_blur

end

function SeekModeScript:_UpdateColor(_p)
    local p = _p

    local brightness = self.attrs1:GetVal("ADBE_IE_ccbd66aa580459426c9d301-0002_2_2", p)
    brightness = brightness[1] * 0.01
    self.retouch_adjust_lua.brightness = brightness

    local shadow = self.attrs1:GetVal("ADBE_IE_ccbd66aa580459426c9d301-0009_2_3", p)
    shadow = shadow[1] * 0.01
    self.retouch_adjust_lua.shadow = shadow

    local temperature = self.attrs1:GetVal("ADBE_IE_ccbd66aa580459426c9d301-0010_2_4", p)
    temperature = temperature[1] * 0.01
    self.retouch_adjust_lua.temperature = temperature

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
