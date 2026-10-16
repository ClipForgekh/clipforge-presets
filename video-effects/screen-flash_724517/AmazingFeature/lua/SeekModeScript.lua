local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean
---@field utime number
---@field u_fov number

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
	["ADBE_Optics_Compensation_0001_0_0"]={
		{{0.001, 0, 0, 1, }, {9, 10, }, {{0, }, {55, }, }, }, 
		{{1, 0, 0.999, 1, }, {10, 14, }, {{55, }, {0, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur_2_0001_0_1"]={
		{{0.9, 0.1, 0.999, 1, }, {0, 9, }, {{0, }, {100, }, }, }, 
		{{0.001, 0, 0, 1, }, {9, 12, }, {{100, }, {15, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {12, 14, }, {{15, }, {40, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur_2_0001_0_2"]={
		{{0.001, 0, 0, 1, }, {9, 12, }, {{0, }, {12, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {12, 14, }, {{12, }, {40, }, }, }, 
	}, 
	["ADBE_Radial_Blur_0001_0_3"]={
		{{0.001, 0, 0, 1, }, {9, 10, }, {{0, }, {80, }, }, }, 
		{{0.79, 0.2, 0.999, 1, }, {10, 14, }, {{80, }, {0, }, }, }, 
	}, 
	["tc_Starglow_0057_0_4"]={
		{{0.9, 0.1, 0.999, 1, }, {0, 7, }, {{0, }, {80, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {7, 8, }, {{80, }, {52, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {8, 9, }, {{52, }, {95, }, }, }, 
		{{0.166666667, 0, 0.833333333, 0.833333333, }, {9, 15, }, {{95, }, {75, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {15, 16, }, {{75, }, {60, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 17, }, {{60, }, {80, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {17, 21, }, {{80, }, {90, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {21, 24, }, {{90, }, {73, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {24, 25, }, {{73, }, {0, }, }, }, 
	}, 
	["ADBE_IE_ccbd66aa580459426c9d301-0002_0_5"]={
		{{0.001, 0, 0, 1, }, {9, 24, }, {{0, }, {-25, }, }, }, 
	}, 
	["ADBE_IE_ccbd66aa580459426c9d301-0008_0_6"]={
		{{0.001, 0, 0, 1, }, {9, 24, }, {{0, }, {33, }, }, }, 
	}, 
	["ADBE_IE_ccbd66aa580459426c9d301-0009_0_7"]={
		{{0.001, 0, 0, 1, }, {9, 24, }, {{0, }, {-100, }, }, }, 
	}, 
	["ADBE_IE_ccbd66aa580459426c9d301-0010_0_8"]={
		{{0.001, 0, 0, 1, }, {9, 24, }, {{0, }, {33, }, }, }, 
	}, 
	["ADBE_IE_ccbd66aa580459426c9d301-0011_0_9"]={
		{{0.001, 0, 0, 1, }, {9, 24, }, {{0, }, {-28, }, }, }, 
	}, 
	["ADBE_Exposure2_0003_0_10"]={
		{{0.9, 0.1, 0.999, 1, }, {0, 7, }, {{0, }, {0.8, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {7, 8, }, {{0.8, }, {0.4, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {8, 9, }, {{0.4, }, {1.75, }, }, }, 
		{{0.001, 0, 0.833333333, 0.833333333, }, {9, 12, }, {{1.75, }, {-1, }, }, }, 
		{{0.166666667, 0.166666667, 0.66666667, 1, }, {12, 14, }, {{-1, }, {0, }, }, }, 
		{{0.33333333, 0, 0.833333333, 0.833333333, }, {14, 16, }, {{0, }, {-0.7, }, }, }, 
		{{0.166666667, 0.166666667, 0.66666667, 1, }, {16, 17, }, {{-0.7, }, {0, }, }, }, 
		{{0.33333333, 0, 0.833333333, 0.833333333, }, {17, 19, }, {{0, }, {-0.4, }, }, }, 
		{{0.166666667, 0.166666667, 0.66666667, 1, }, {19, 20, }, {{-0.4, }, {0, }, }, }, 
		{{0.33333333, 0, 0.833333333, 0.833333333, }, {20, 22, }, {{0, }, {-0.5, }, }, }, 
		{{0.166666667, 0.166666667, 0.66666667, 1, }, {22, 24, }, {{-0.5, }, {0, }, }, }, 
	}, 
	["ADBE_Position_1_11"]={
		{{0.3, 0, 0.833333, 0.833333, }, {0, 2, }, {{540, 540, 0, }, {536.335571289, 541.678894043, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {2, 4, }, {{536.335571289, 541.678894043, 0, }, {549.874389648, 535.673461914, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {4, 6, }, {{549.874389648, 535.673461914, 0, }, {509.716827393, 534.688964844, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {6, 8, }, {{509.716827393, 534.688964844, 0, }, {574.323120117, 540, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {8, 9, }, {{574.323120117, 540, 0, }, {540, 540, 0, }, }, }, 
	}, 
	["ADBE_Scale_1_12"]={
		{{0.250533537,0.250533537,0.274308837, 0.363109569,0.363109569,0.274308837, 0.647237577,0.647237577,0.441620609, 0.909457467,0.909457467,0.441620609, }, {9, 13, }, {{100, 100, 100, }, {47, 47, 100, }, }, }, 
		{{0.243828688,0.243828688,0.14, 0.512076547,0.512076547,0.14, 0.602124827,0.602124827,0.56, 1,1,0.56, }, {13, 24, }, {{47, 47, 100, }, {33.299999237, 33.299999237, 100, }, }, }, 
	}, 
    ["starglow_threshould"]={
        {{0.250533537,0.250533537,0.274308837, 0.363109569,0.363109569,0.274308837, 0.647237577,0.647237577,0.441620609, 0.909457467,0.909457467,0.441620609, }, {9, 13, }, {{0.55, 100, 100, }, {0.4, 47, 100, }, }, }, 
		{{0.243828688,0.243828688,0.14, 0.512076547,0.512076547,0.14, 0.602124827,0.602124827,0.56, 1,1,0.56, }, {13, 24, }, {{0.4, 47, 100, }, {0.4, 33.299999237, 100, }, }, }, 
	}, 
	["ADBE_Opacity_1_13"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {14, 15, }, {{100, }, {50, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {15, 16, }, {{50, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 20, }, {{100, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {20, 21, }, {{100, }, {75, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {21, 22, }, {{75, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {22, 23, }, {{100, }, {33, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {23, 24, }, {{33, }, {66, }, }, }, 
		{{0.001, 0, 0.2, 1, }, {24, 25, }, {{66, }, {0, }, }, }, 
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
    Amaz.LOGI("lrc onstart", "SeekModeScript")

    -- if util == nil then
    --     util = includeRelativePath("Util")
    -- end
    util.registerRootDir(comp.entity.scene.assetMgr.rootDir)

    self.basemove_mat = comp.entity.scene:findEntityBy("basemove"):getComponent("MeshRenderer").material
    self.res_mat = comp.entity.scene:findEntityBy("res"):getComponent("MeshRenderer").material

    self.gaussian_blur1_lua = comp.entity.scene:findEntityBy("Gaussian_Blur_Root1"):getComponent("ScriptComponent")
    self.gaussian_blur1_lua = getluaobj(self.gaussian_blur1_lua)

    self.gaussian_blur2_lua = comp.entity.scene:findEntityBy("Gaussian_Blur_Root2"):getComponent("ScriptComponent")
    self.gaussian_blur2_lua = getluaobj(self.gaussian_blur2_lua)

    self.radial_blur_lua = comp.entity.scene:findEntityBy("Radial_Blur_Root"):getComponent("ScriptComponent")
    self.radial_blur_lua = getluaobj(self.radial_blur_lua)

    self.retouch_adjust_lua = comp.entity.scene:findEntityBy("lumi_ajust"):getComponent("ScriptComponent")
    self.retouch_adjust_lua = getluaobj(self.retouch_adjust_lua)

    self.starglow_lua = comp.entity.scene:findEntityBy("starglow"):getComponent("ScriptComponent")
    self.starglow_lua = getluaobj(self.starglow_lua)

    Amaz.LOGI("lrc 1", tostring(self.gaussian_blur1_lua))
    Amaz.LOGI("lrc 2", tostring(self.gaussian_blur2_lua))
    Amaz.LOGI("lrc 3", tostring(self.radial_blur_lua))
    Amaz.LOGI("lrc 4", tostring(self.retouch_adjust_lua))
    Amaz.LOGI("lrc 5", tostring(self.starglow_lua))


    self.attrs = AETools:new(ae_attribute)
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
    if isEditor then
        p = math.floor(p*25)/25
    end

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()

    self:_UpdateBasemove(p)
    self:_UpdateBlur(p)
    self:_UpdateColor(p)
    self:_UpdateStarglow(p)
end

function SeekModeScript:_UpdateStarglow(_p)
    local p = _p

    local alpha = self.attrs:GetVal("tc_Starglow_0057_0_4", p)
    alpha = alpha[1]
    alpha = alpha * 0.01
    -- alpha = alpha * 0.5 + 0.5
    -- alpha = 1
    self.starglow_lua.starglow_alpha = alpha

    local threshould = self.attrs:GetVal("starglow_threshould", p)
    threshould = threshould[1]
    self.starglow_lua.threshould = Amaz.Vector2f(threshould, self.starglow_lua.threshould.y)
end

function SeekModeScript:_UpdateBasemove(_p)
    local p = _p

    local pos = self.attrs:GetVal("ADBE_Position_1_11", p)
    pos = Amaz.Vector2f(pos[1], pos[2])
    pos = Amaz.Vector2f(-(pos.x/1080-0.5), pos.y/1080-0.5)
    self.basemove_mat:setVec2("pos", pos)

    local scale = self.attrs:GetVal("ADBE_Scale_1_12", p)
    scale = scale[1]*0.01
    -- Amaz.LOGI("lrc "..p*36, tostring(scale))
    self.basemove_mat:setFloat("scale", scale)

    local u_fov = self.attrs:GetVal("ADBE_Optics_Compensation_0001_0_0", p)
    u_fov = u_fov[1]
    u_fov = u_fov * 2.
    self.basemove_mat:setFloat("u_fov", u_fov)

    local alpha = self.attrs:GetVal("ADBE_Opacity_1_13", p)
    alpha = alpha[1] * 0.01
    self.res_mat:setFloat("alpha", alpha)
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
    -- Amaz.LOGI("lrc p", p*36) 

    local brightness = self.attrs:GetVal("ADBE_IE_ccbd66aa580459426c9d301-0002_0_5", p)
    brightness = brightness[1] * 0.01
    self.retouch_adjust_lua.brightness = brightness

    local saturation = self.attrs:GetVal("ADBE_IE_ccbd66aa580459426c9d301-0008_0_6", p)
    saturation = saturation[1] * 0.01
    self.retouch_adjust_lua.saturation = saturation

    local shadow = self.attrs:GetVal("ADBE_IE_ccbd66aa580459426c9d301-0009_0_7", p)
    shadow = shadow[1] * 0.01
    self.retouch_adjust_lua.shadow = shadow

    local temperature = self.attrs:GetVal("ADBE_IE_ccbd66aa580459426c9d301-0010_0_8", p)
    temperature = temperature[1] * 0.01
    self.retouch_adjust_lua.temperature = temperature

    local tone = self.attrs:GetVal("ADBE_IE_ccbd66aa580459426c9d301-0011_0_9", p)
    tone = tone[1] * 0.01
    self.retouch_adjust_lua.tone = tone

    local exposure = self.attrs:GetVal("ADBE_Exposure2_0003_0_10", p)
    exposure = exposure[1] * 1.25
    -- exposure = math.min(1, exposure)
    Amaz.LOGE("lrc exposure "..p*25, exposure)
    self.res_mat:setFloat("exposure", exposure)
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
