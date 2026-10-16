local util = nil ---@class Util

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field offsetRange Vector2f
---@field rotationAxis1 number
---@field rotationAxis2 number
---@field offsetRange Vector2f
---@field _duration number
---@field blurIntensity number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean

local util = nil ---@type Util

local AETools = {} ---@class AETools
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

function AETools._remap01(a, b, x)
    if x < a then
        return 0
    end
    if x > b then
        return 1
    end
    return (x - a) / (b - a)
end

function AETools._cubicBezier(p1, p2, p3, p4, t)
    return {
        p1[1] * (1. - t) * (1. - t) * (1. - t) + 3 * p2[1] * (1. - t) * (1. - t) * t + 3 * p3[1] * (1. - t) * t * t +
            p4[1] * t * t * t,
        p1[2] * (1. - t) * (1. - t) * (1. - t) + 3 * p2[2] * (1. - t) * (1. - t) * t + 3 * p3[2] * (1. - t) * t * t +
            p4[2] * t * t * t
    }
end

function AETools:_cubicBezier01(_bezier_val, p)
    local x = self:_getBezier01X(_bezier_val, p)
    return self._cubicBezier({0, 0}, {_bezier_val[1], _bezier_val[2]}, {_bezier_val[3], _bezier_val[4]}, {1, 1}, x)[2]
end

function AETools:_getBezier01X(_bezier_val, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts + te) * 0.5
        local value =
            self._cubicBezier({0, 0}, {_bezier_val[1], _bezier_val[2]}, {_bezier_val[3], _bezier_val[4]}, {1, 1}, tm)
        if (value[1] > x) then
            te = tm
        else
            ts = tm
        end
    until (te - ts < 0.0001)

    return (te + ts) * 0.5
end

function AETools._mix(a, b, x)
    return a * (1 - x) + b * x
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
            res[i] = math.abs(val1 - val2)
        end
    else
        res = math.abs(val1 - val2)
    end
    return res
end

function AETools:_getSingleCurPartVal(val1, val2, duration, info1, info2, part_progress)
    local diff = val2 - val1
    if (math.abs(diff) < 0.001) then
        return val2
    end

    local average = diff / duration + 0.0001
    -- local xas = 124/duration
    -- local yas = -8/duration
    -- average = math.sqrt(xas*xas+yas*yas)

    local x1 = info1[2] / 100
    local y1 = x1 * info1[1] / average
    local x2 = 1 - info2[2] / 100
    local y2 = 1 - (1 - x2) * info2[1] / average

    -- if val1 > val2 then
    --     x1 = info1[2]/100
    --     y1 = -x1*info1[1]/average
    --     x2 = info2[2]/100
    --     y2 = 1-x2*info2[1]/average
    --     x2 = 1-x2
    --     if(x1 < 0.0002)then y1 = 0 end
    --     if(y2 < 0.0002)then y2 = 0 end
    -- end
    local bezier_val = {x1, y1, x2, y2}
    -- Amaz.LOGI("lrc x1", x1)
    -- Amaz.LOGI("lrc y1", y1)
    -- Amaz.LOGI("lrc x2", x2)
    -- Amaz.LOGI("lrc y2", y2)
    local progress = self:_cubicBezier01(bezier_val, part_progress)

    -- Amaz.LOGI("lrc val1", val1)
    -- Amaz.LOGI("lrc val2", val2)
    -- Amaz.LOGI("lrc progress", progress)
    -- Amaz.LOGI("lrc part_progress", part_progress)
    local res = self._mix(val1, val2, progress)
    return res
end

function AETools:getCurPartVal(_progress, hard_cut)
    local part_id, part_progress = self:_getCurPart(_progress)

    local frame1 = self.key_frame_info[part_id - 1]
    local frame2 = self.key_frame_info[part_id]

    if hard_cut == true then
        return frame1["value"]
    end

    local info1 = frame1["v_out"]
    local info2 = frame2["v_in"]

    info1[2] = info1[2] < 0.011 and 0 or info1[2]
    info2[2] = info2[2] < 0.011 and 0 or info2[2]

    local duration = (frame2["cur_frame"] - frame1["cur_frame"]) / self.frameRate

    local res = nil
    if type(frame1["value"]) == "table" then
        res = {}
        for i = 1, #frame1["value"] do
            -- Amaz.LOGI("============= lrc frame1 ", i.." =============")
            res[i] =
                self:_getSingleCurPartVal(frame1["value"][i], frame2["value"][i], duration, info1, info2, part_progress)
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
        if progress < info["cur_frame"] / self.finish_frame_time then
            return i, self._remap01(
                self.key_frame_info[i - 1]["cur_frame"] / self.finish_frame_time,
                self.key_frame_info[i]["cur_frame"] / self.finish_frame_time,
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
    Amaz.LOGI("lrc " .. tostring(self.key_frame_info), tostring(#self.key_frame_info))
end

local util = {} ---@class Util
local json = cjson.new()
local rootDir = nil
local record_t = {}

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
    end
}

local function typeSwitch()
    return _typeSwitch
end

local function createTableContent()
    -- Amaz.LOGI("lrc", "createTableContent")
    local t = {}
    for k, v in pairs(record_t) do
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
    return function(t, b, c, d)
        t = t / d
        local tvalue = getBezierTfromX(control, t)
        local value = getBezierValue(control, tvalue)
        return b + c * value[2]
    end
end

function util.remap01(a, b, x)
    if x < a then
        return 0
    end
    if x > b then
        return 1
    end
    return (x - a) / (b - a)
end

function util.mix(a, b, x)
    return a * (1 - x) + b * x
end

function util.CreateJsonFile(file_path)
    local t = createTableContent()
    local content = json.encode(t)
    local file = io.open(util.getRootDir() .. file_path, "w+b")
    if file then
        file:write(tostring(content))
        io.close(file)
    end
end

function util.ReadFromJson(file_path)
    local file = io.input(util.getRootDir() .. file_path)
    local json_data = json.decode(io.read("*a"))
    local res = {}
    for k, v in pairs(json_data) do
        local func = _typeSwitch["_" .. tostring(v["type"])]
        res[k] = func(v["val"])
    end
    return res
end

function util.bezierWithParams(input_val_4, min_val, max_val, in_val, reverse)
    if type(input_val_4) == "tabke" then
        if reverse == nil then
            return util.bezier(input_val_4)(util.remap01(min_val, max_val, in_val), 0, 1, 1)
        else
            return util.bezier(input_val_4)(1 - util.remap01(min_val, max_val, in_val), 0, 1, 1)
        end
    else
        if reverse == nil then
            return util.bezier(util.changeVec4ToTable(input_val_4))(util.remap01(min_val, max_val, in_val), 0, 1, 1)
        else
            return util.bezier(util.changeVec4ToTable(input_val_4))(1 - util.remap01(min_val, max_val, in_val), 0, 1, 1)
        end
    end
end

function util.test()
    Amaz.LOGI("lrc", "test123")
end

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)

    if construct and SeekModeScript.constructor then
        SeekModeScript.constructor(self, ...)
    end

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

local isEditor = Amaz.Macros and Amaz.Macros.EditorSDK

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
    self.wavelMat = self.entity.scene:findEntityBy("wave"):getComponent("MeshRenderer").material
    self.blurCompProperty =
        self.entity.scene:findEntityBy("Gaussian_Blur_Root"):getComponent("ScriptComponent").properties
    self.radiusBlurCompProperty =
        self.entity.scene:findEntityBy("Radial_Blur_Root"):getComponent("ScriptComponent").properties
    self.modelAnimSeq = self.entity.scene:findEntityBy("wave"):getComponent("AnimSeqComponent")
    self.fxaaMat = self.entity.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.entity.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.transform = self.entity.scene:findEntityBy("quad"):getComponent("Transform")
    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)

    if isEditor then
        comp.entity.scene:findEntityBy("bgCamera").visible = false
    else
        comp.entity.scene:findEntityBy("bgCamera").visible = true
    end
end
local ae_attribute = {
    ["ADBE_Tile_0004_0_0"] = {
        [1] = {{0, 0.01}, {-60, 0.01}, 20, 130},
        [2] = {{-60, 0.01}, {0, 0.01}, 25, 120},
        [3] = {{-60, 0.01}, {0, 0.01}, 28, 120}
    },
    ["ADBE_Tile_0005_0_1"] = {
        [1] = {{0, 0.01}, {-60, 0.01}, 20, 130},
        [2] = {{-60, 0.01}, {0, 0.01}, 25, 120},
        [3] = {{-60, 0.01}, {0, 0.01}, 28, 120}
    },
    ["ADBE_Geometry2_0005_0_2"] = {
        [1] = {{0, 33.333333}, {1330.29029049497, 14.6478784972982}, 0, 23.6109016042767},
        [2] = {{-979.906933868673, 19.0040113175468}, {-968.769524217949, 24.2629775548534}, 3, 23.4443249385292},
        [3] = {{0, 24.9939130390243}, {0, 32.8050495827751}, 6, -7.52712661642552},
        [4] = {{95.2897343949769, 43.9739541853027}, {87.885994888245, 26.2412773216324}, 9, 5.56530591291065},
        [5] = {{-29.6562671248925, 39.8644285047607}, {-26.5976903221606, 38.1254207496782}, 15, 6.54255874238636},
        [6] = {{-28.0812762723857, 35.1190136516647}, {-25.495480856829, 18.5931809815892}, 19, 2.85231676030018},
        [7] = {{0, 41.7498685988911}, {0, 16.666666667}, 25, 0},
        [8] = {{0, 41.7498685988911}, {0, 16.666666667}, 28, 0}
    },
    ["ADBE_Geometry2_0005_0_3"] = {
        [1] = {{0, 33.333333}, {0, 36.7918558418751}, 0, -10.974978138051},
        [2] = {{321.848703470846, 32.9120361948566}, {312.33509845617, 33.7159687424259}, 3, 9.24088706370158},
        [3] = {{0, 36.6541759813385}, {0, 39.6516600394802}, 5, 19.2504119773356},
        [4] = {{-72.6275593512424, 49.6818998599606}, {-60.4039336343003, 29.651178582962}, 9, 1},
        [5] = {{7.85873189990923, 25.1249389494019}, {4.54931285396456, 26.3045886476913}, 15, -2.73447340560387},
        [6] = {{7.94943776289107, 35.5928444513205}, {8.44992157076568, 31.0380952370686}, 20, -1.23416496053978},
        [7] = {{0, 18.9662456447655}, {0, 0.01}, 25, 0},
        [8] = {{0, 18.9662456447655}, {0, 0.01}, 28, 0}
    },
    ["ADBE_WRPMESH_0003_0_4"] = {
        [1] = {{0, 0.1}, {-37.0786516853932, 89}, 20, 0},
        [2] = {{0, 0.1}, {0, 89}, 28, -100}
    },
    ["ADBE_Gaussian_Blur_2_0001_0_5"] = {
        [1] = {{0, 100}, {0, 0.1}, 0, 88},
        [2] = {{0, 100}, {0, 16.666666667}, 20, 0},
        [3] = {{0, 100}, {0, 16.666666667}, 28, 0}
    },
    ["ADBE_Exposure2_0003_0_6"] = {
        [1] = {{0, 88}, {0, 0.1}, 0, 2.5},
        [2] = {{0, 88}, {0, 0.1}, 20, 0},
        [3] = {{0, 88}, {0, 0.1}, 28, 0}
    },
    ["ADBE_Scale_0_7"] = {
        [1] = {{0, 0.01}, {-8763.41029597207, 18.0619500949979}, 0, {409, 189.621376770701, 100}},
        [2] = {
            {-910.316839874252, 38.6530549967842},
            {-826.86798612885, 31.1196015918808},
            3,
            {182.736368858952, 241.77729482186, 100}
        },
        [3] = {
            {-72.4447531532825, 32.6098857283592},
            {-85.2059378715064, 35.3179665053444},
            6,
            {143.837585293632, 97.2967730721235, 100}
        },
        [4] = {
            {-210.22475582786, 32.2848121328508},
            {-175.039389132726, 19.4536400794983},
            9,
            {113.063861082738, 89.4214696440138, 100}
        },
        [5] = {
            {61.0636451887782, 52.4974895477295},
            {51.8018556507441, 14.3333745956421},
            14,
            {95.8532761010478, 106.513435477149, 100}
        },
        [6] = {{0, 53.6924947391857}, {0, 0.01}, 25, {100, 100, 100}},
        [7] = {{0, 53.6924947391857}, {0, 0.01}, 28, {100, 100, 100}}
    },
    ["ADBE_Radial_Blur_0001_0_0"] = {
        [1] = {{0, 0.1}, {93.75, 80}, 20, 0},
        [2] = {{0, 0.1}, {0, 80}, 28, 100}
    },
    ["ADBE_Slider_Control_0001_0_7"]={
		[1]={{0, 33.333333, }, {163.095211569454, 38.213929883595, }, 0, 189.6, }, 
		[2]={{65.0734956417637, 42.5854975128727, }, {210.021020060287, 27.7366133177834, }, 3, 241.8, }, 
		[3]={{-125.236226801361, 33.3176122749405, }, {-242.529470505887, 32.356390953064, }, 6, 97.3, }, 
		[4]={{220.504176332961, 32.0723967397766, }, {34.8057492660822, 28.9024309957581, }, 9, 89.4, }, 
		[5]={{52.5321622935958, 35.4100422704773, }, {26.5134871010698, 30.1050912529241, }, 14, 106.5, }, 
		[6]={{-17.7272727272727, 0.01, }, {0, 0.01, }, 25, 100, }, 
		[7]={{-17.7272727272727, 0.01, }, {0, 0.01, }, 28, 100, }, 
	}, 
    ["ADBE_Radial_Blur_0001_0_1"] = {
        [1] = {{0, 42}, {0, 42}, 0, 9},
        [2] = {{0, 42}, {0, 42}, 20, 0},
        [3] = {{0, 42}, {0, 42}, 25, 0},
        [4] = {{0, 42}, {0, 42}, 28, 0}
    }
}
function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)

    -- if util == nil then
    --     util = includeRelativePath("Util")
    -- end
    util.registerRootDir(comp.entity.scene.assetMgr.rootDir)
    self.AEDemoSize = Amaz.Vector2f(1080, 1080)
    self.rootDir = comp.entity.scene.assetMgr.rootDir
    self:initKeyFrame(ae_attribute, 30)
    self.wavelMat:setVec2(
        "u_maskOffsetRange",
        Amaz.Vector2f(self.offsetRange.x / self.AEDemoSize.x, self.offsetRange.y / self.AEDemoSize.y)
    )

    if Amaz.Macros and Amaz.Macros.EditorSDK then
        comp.entity.scene:findEntityBy("bgCamera").visible = false
    else
        comp.entity.scene:findEntityBy("bgCamera").visible = true
    end
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
        self.progress = math.mod(time / (self.duration + 0.0001), 1)
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
    self:autoPlay(time)
    -- if self.autoplay then
    -- self.progress = math.mod(time/(self.duration+0.0001), 1)
    -- end

    -- self.progress = math.floor(self.progress*27)/27
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()

    local progress = math.min(self.progress, 1.0)
    -- progress = math.floor(progress * 28) / 28
    -- Amaz.LOGI('yyb',math.floor(self.modelAnimSeq.animSeq:getFrameCount()*progress))
    local nowScale = self.ADBE_Scale_0_7:getCurPartVal(progress)
    -- Amaz.LOGI('yyb',tostring(Amaz.Vector2f(inputOffset[1]/self.AEDemoSize.x,inputOffset[2]/self.AEDemoSize.y)))
    self.wavelMat:setVec2("u_inputScale", Amaz.Vector2f(nowScale[1] / 100, self.ADBE_Slider_Control_0001_0_7:getCurPartVal(progress) / 100))
    -- self.wavelMat:setVec2("u_inputScale", Amaz.Vector2f(1, 1))
    -- Amaz.LOGI('yyb'..progress,tostring(Amaz.Vector2f(nowScale[1] / 100, self.ADBE_Slider_Control_0001_0_7:getCurPartVal(progress) / 100)))
    local wrapIntensity = self.ADBE_WRPMESH_0003_0_4:getCurPartVal(progress)

    -- Amaz.LOGI("zyl wrapIntensity", wrapIntensity)

    self.wavelMat:setFloat("u_inputWarpIntensity", wrapIntensity / -200 * 1.2)
    self.wavelMat:setFloat("u_rotationAxis1", self.rotationAxis1 / 180 * math.pi)
    self.wavelMat:setFloat("u_rotationAxis2", self.rotationAxis2 / 180 * math.pi)
    self.wavelMat:setFloat("u_inputRotation1", -self.ADBE_Geometry2_0005_0_2:getCurPartVal(progress) / 180 * math.pi * 1.0)
    -- self.wavelMat:setFloat("u_inputRotation1", self.blurIntensity*math.pi/180)
    self.wavelMat:setFloat("u_inputRotation2", -self.ADBE_Geometry2_0005_0_3:getCurPartVal(progress) / 180 * math.pi * 1.0)
    self.modelMat:setFloat("u_lightIntensity", self.ADBE_Exposure2_0003_0_6:getCurPartVal(progress) * 1.0)
    -- self.blurCompProperty:set("Intensity", self.blurIntensity)
    self.blurCompProperty:set("Intensity", self.ADBE_Gaussian_Blur_2_0001_0_5:getCurPartVal(progress) * 1.0)
    
    if wrapIntensity >= 0 then
        self.radiusBlurCompProperty:set("Amount", self.ADBE_Radial_Blur_0001_0_1:getCurPartVal(progress) * 0.5)
        self.radiusBlurCompProperty:set("Type", "Scratch")
        -- Amaz.LOGI("zyl", "Scratch")
    else
        self.radiusBlurCompProperty:set("Amount", self.ADBE_Radial_Blur_0001_0_0:getCurPartVal(progress))
        self.radiusBlurCompProperty:set("Type", "Centered Zoom")
        Amaz.LOGI("zyl", self.ADBE_Radial_Blur_0001_0_0:getCurPartVal(progress))
        
    end
    -- Amaz.LOGI('yyb '..math.floor(progress*28), -self.ADBE_Geometry2_0005_0_2:getCurPartVal(progress) * 1.0)
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
