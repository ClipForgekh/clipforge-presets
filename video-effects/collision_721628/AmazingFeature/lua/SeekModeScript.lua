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

local isEditor = Amaz.Macros and Amaz.Macros.EditorSDK
local util = nil      ---@type Util

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
	["ADBE_Gaussian_Blur_2_0001_0_0"]={
		{{0.42, 0, 0.999, 1, }, {0, 5, }, {{1200, }, {30, }, }, }, 
		{{0.001, 0, 0.58, 1, }, {5, 60, }, {{30, }, {0, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur_2_0001_0_1"]={
		{{0.001, 0, 0.58, 1, }, {5, 60, }, {{30, }, {0, }, }, }, 
	}, 
	["ADBE_Radial_Blur_0001_0_2"]={
		{{1, 0, 0.999, 0, }, {4, 5, }, {{0, }, {2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {5, 6, }, {{2, }, {5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {6, 7, }, {{5, }, {4, }, }, }, 
		{{0.42, 0.42, 0.58, 0.58, }, {7, 8, }, {{4, }, {4, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {8, 9, }, {{4, }, {6, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {9, 10, }, {{6, }, {7, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {10, 11, }, {{7, }, {8, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {11, 12, }, {{8, }, {7, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {12, 13, }, {{7, }, {3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {13, 14, }, {{3, }, {6, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {14, 15, }, {{6, }, {2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {15, 16, }, {{2, }, {3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {16, 17, }, {{3, }, {6, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {17, 18, }, {{6, }, {3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {18, 19, }, {{3, }, {2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {19, 20, }, {{2, }, {3, }, }, }, 
		{{0.42, 0.42, 0.58, 0.58, }, {20, 21, }, {{3, }, {3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {21, 22, }, {{3, }, {1, }, }, }, 
		{{0.42, 0.42, 0.58, 0.58, }, {22, 23, }, {{1, }, {1, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {23, 24, }, {{1, }, {3, }, }, }, 
		{{0.42, 0.42, 0.58, 0.58, }, {24, 25, }, {{3, }, {3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {25, 26, }, {{3, }, {1.7, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {26, 27, }, {{1.7, }, {1.5, }, }, }, 
		{{0.42, 0.42, 0.58, 0.58, }, {27, 28, }, {{1.5, }, {1.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {28, 29, }, {{1.5, }, {1.2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {29, 31, }, {{1.2, }, {1, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {31, 33, }, {{1, }, {0.9, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {33, 37, }, {{0.9, }, {0.7, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {37, 41, }, {{0.7, }, {0, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {41, 44, }, {{0, }, {0.15, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {44, 48, }, {{0.15, }, {0, }, }, }, 
	}, 
	["ADBE_Radial_Blur_0002_0_3"]={
		{{1, 0, 0, 1, }, {6, 7, }, {{2877.664657593, 1373.265045166, }, {-1525.468475342, -622.274642944, }, }, }, 
		{{1, 0, 0, 1, }, {7, 8, }, {{-1525.468475342, -622.274642944, }, {1020.289627075, 2687.562103271, }, }, }, 
		{{1, 0, 0, 1, }, {8, 9, }, {{1020.289627075, 2687.562103271, }, {172.496704102, -764.563476562, }, }, }, 
		{{1, 0, 0, 1, }, {9, 10, }, {{172.496704102, -764.563476562, }, {584.728012085, 605.723342896, }, }, }, 
		{{1, 0, 0, 1, }, {10, 11, }, {{584.728012085, 605.723342896, }, {785.56350708, -365.032241821, }, }, }, 
		{{1, 0, 0, 1, }, {11, 12, }, {{785.56350708, -365.032241821, }, {623.614105225, 792.190078735, }, }, }, 
		{{1, 0, 0, 1, }, {12, 13, }, {{623.614105225, 792.190078735, }, {749.0105896, -373.420089722, }, }, }, 
		{{1, 0, 0, 1, }, {13, 14, }, {{749.0105896, -373.420089722, }, {596.268814087, 152.488021851, }, }, }, 
		{{1, 0, 0, 1, }, {14, 15, }, {{596.268814087, 152.488021851, }, {1429.705184937, 1704.802871704, }, }, }, 
		{{1, 0, 0, 1, }, {15, 16, }, {{1429.705184937, 1704.802871704, }, {-150.913452148, -1819.441253662, }, }, }, 
		{{1, 0, 0, 1, }, {16, 17, }, {{-150.913452148, -1819.441253662, }, {527.926513672, 101.36706543, }, }, }, 
		{{1, 0, 0, 1, }, {17, 18, }, {{527.926513672, 101.36706543, }, {577.469299316, 733.253875732, }, }, }, 
		{{1, 0, 0, 1, }, {18, 19, }, {{577.469299316, 733.253875732, }, {759.418182373, -887.652694702, }, }, }, 
		{{1, 0, 0, 1, }, {19, 20, }, {{759.418182373, -887.652694702, }, {707.883621216, 37.837738037, }, }, }, 
		{{1, 0, 0, 1, }, {20, 21, }, {{707.883621216, 37.837738037, }, {661.014358521, 470.213668823, }, }, }, 
		{{1, 0, 0, 1, }, {21, 22, }, {{661.014358521, 470.213668823, }, {1620.532287598, 1832.124237061, }, }, }, 
		{{1, 0, 0, 1, }, {22, 23, }, {{1620.532287598, 1832.124237061, }, {-211.387664795, -1402.833511353, }, }, }, 
		{{1, 0, 0, 1, }, {23, 24, }, {{-211.387664795, -1402.833511353, }, {494.567428589, 434.973617554, }, }, }, 
		{{1, 0, 0, 1, }, {24, 25, }, {{494.567428589, 434.973617554, }, {428.587661743, 470.211044312, }, }, }, 
		{{1, 0, 0, 1, }, {25, 26, }, {{428.587661743, 470.211044312, }, {653.03868103, 1717.555160522, }, }, }, 
		{{1, 0, 0, 1, }, {26, 27, }, {{653.03868103, 1717.555160522, }, {172.848587036, 1874.030975342, }, }, }, 
		{{1, 0, 0, 1, }, {27, 28, }, {{172.848587036, 1874.030975342, }, {598.040725708, 231.519699097, }, }, }, 
		{{1, 0, 0, 1, }, {28, 29, }, {{598.040725708, 231.519699097, }, {630.246627808, 334.838577271, }, }, }, 
		{{1, 0, 0, 1, }, {29, 31, }, {{630.246627808, 334.838577271, }, {696.038589478, 1972.741241455, }, }, }, 
		{{1, 0, 0, 1, }, {31, 33, }, {{696.038589478, 1972.741241455, }, {634.835571289, 881.496124268, }, }, }, 
		{{1, 0, 0, 1, }, {33, 37, }, {{634.835571289, 881.496124268, }, {840.870513916, 1733.672210693, }, }, }, 
		{{1, 0, 0, 1, }, {37, 41, }, {{840.870513916, 1733.672210693, }, {606.68572998, 631.456588745, }, }, }, 
		{{1, 0, 0, 1, }, {41, 44, }, {{606.68572998, 631.456588745, }, {965.758163452, 2062.096298218, }, }, }, 
	}, 
	["ADBE_Exposure2_0003_0_4"]={
		{{1, 0, 0.999, 0, }, {4, 5, }, {{0, }, {1.2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {5, 39, }, {{1.2, }, {0, }, }, }, 
	}, 
	["ADBE_Position_0_5"]={
		{{0.389533, 0, 0.723157, 0.505075, }, {0, 2, }, {{546, -400, 0, }, {499, -212.307945047, 0, }, }, }, 
		{{0.66, 0.304137, 0.999, 1, }, {2, 5, }, {{499, -212.307945047, 0, }, {540, 390, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {5, 7, }, {{540, 390, 0, }, {609, 241.75, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {7, 9, }, {{609, 241.75, 0, }, {492.5, 270.125, 0, }, }, }, 
		{{0.493256, 0, 0.617873, 0.678175, }, {9, 11, }, {{492.5, 270.125, 0, }, {557.670597978, 293.63932882, 0, }, }, }, 
		{{0.258354, 0.39726, 0.575561, 1, }, {11, 14, }, {{557.670597978, 293.63932882, 0, }, {500.75, 293.75, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {14, 17, }, {{500.75, 293.75, 0, }, {574.125, 273.5, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {17, 20, }, {{574.125, 273.5, 0, }, {531.875, 265.25, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {20, 24, }, {{531.875, 265.25, 0, }, {567.375, 259.125, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {24, 28, }, {{567.375, 259.125, 0, }, {530.875, 253.25, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {28, 33, }, {{530.875, 253.25, 0, }, {555.1875, 253.5625, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {33, 39, }, {{555.1875, 253.5625, 0, }, {533.8125, 263.8125, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {39, 48, }, {{533.8125, 263.8125, 0, }, {543.804208834, 268.236607633, 0, }, }, }, 
		{{0.44, 0, 0.44, 1, }, {48, 60, }, {{543.804208834, 268.236607633, 0, }, {540, 270, 0, }, }, }, 
	}, 
	["ADBE_Scale_0_6"]={
		{{0.001,0.001,0.001, 0,0,0.001, 0.5,0.5,0.5, 1,1,0.5, }, {5, 60, }, {{116, 116, 100, }, {100, 100, 100, }, }, }, 
	}, 
	["ADBE_Rotate_Z_0_7"]={
		{{0.5, 0, 0.5, 1, }, {0, 2, }, {{0, }, {4, }, }, }, 
		{{0.8, 0, 0.58, 1, }, {2, 4, }, {{4, }, {-3, }, }, }, 
		{{0.70481167, 0.01460353, 0.366823152, 0.99515116, }, {4, 6, }, {{-3, }, {1, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {6, 8, }, {{1, }, {-3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {8, 10, }, {{-3, }, {3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {10, 12, }, {{3, }, {-2.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {12, 15, }, {{-2.5, }, {2.2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {15, 18, }, {{2.2, }, {-1.8, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {18, 22, }, {{-1.8, }, {1.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {22, 26, }, {{1.5, }, {-1.1, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {26, 31, }, {{-1.1, }, {0.8, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {31, 36, }, {{0.8, }, {-0.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {36, 43, }, {{-0.5, }, {0.3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {43, 53, }, {{0.3, }, {-0.1, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {53, 60, }, {{-0.1, }, {0, }, }, }, 
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

    self.basemove_mat = comp.entity.scene:findEntityBy("basemove"):getComponent("MeshRenderer").material
    self.radial_blur_mat = comp.entity.scene:findEntityBy("radial_blur"):getComponent("MeshRenderer").material
    self.blur_mat1 = comp.entity.scene:findEntityBy("blur1"):getComponent("MeshRenderer").material
    self.blur_mat2 = comp.entity.scene:findEntityBy("blur2"):getComponent("MeshRenderer").material
    self.blur_mat3 = comp.entity.scene:findEntityBy("blur3"):getComponent("MeshRenderer").material

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

    self.width = Amaz.BuiltinObject:getOutputTextureWidth()
    self.height = Amaz.BuiltinObject:getOutputTextureHeight()

    local ow = Amaz.BuiltinObject:getOutputTextureWidth()
    local oh = Amaz.BuiltinObject:getOutputTextureHeight()
    local iw = Amaz.BuiltinObject:getInputTextureWidth()
    local ih = Amaz.BuiltinObject:getInputTextureHeight()

    -- if math.abs(ow-iw)<0.001 and math.abs(oh-ih)<0.001 then
    --     self.basemove_mat:setFloat("adapt_mode", 0)
    --     Amaz.LOGE("lrc 111", "111")
    -- else
    --     self.basemove_mat:setFloat("adapt_mode", 1)
    --     Amaz.LOGE("lrc 222", "222")
    -- end

    -- Amaz.LOGE("lrc 333", tostring(Amaz.Vector4f(ow, oh, iw, ih)))
    -- Amaz.LOGE("lrc ow-iw", tostring(ow-iw))
    -- Amaz.LOGE("lrc oh-ih", tostring(oh-ih))

    self.basemove_mat:setVec2("input_ScreenParams", Amaz.Vector2f(iw, ih))

    -- Amaz.LOGE("lrc 111", "tostring(Amaz.Vector4f(ow, oh, iw, ih))")

    self:_UpdateBasemove(p)
    self:_UpdateBlur(p)

    -- self.basemove_mat:setFloat("rotate", self.attrs:GetVal("ADBE_Rotate_Z_0_7"))

    -- local bulge = self.ADBE_WRPMESH_0003_0_0:getCurPartVal(p)
    -- self.bulge_mat:setFloat("bend_intensity", bulge * 0.01 * 0.5)

    -- -- if w<h then
    -- --     self.bulge_mat:setVec2("bulge_radius", Amaz.Vector2f(2*h/w, 2))
    -- -- else
    -- --     self.bulge_mat:setVec2("bulge_radius", Amaz.Vector2f(2, 2*w/h))
    -- -- end

    -- local blur_size = self.ADBE_Gaussian_Blur_0001_0_1:getCurPartVal(p)
    -- for i = 1, 4 do
    --     self["blur"..i.."_mat"]:setFloat("blurSize", blur_size/20)
    -- end

    -- local exposure = self.ADBE_Exposure2_0003_0_2:getCurPartVal(p)
    -- self.res_mat:setFloat("u_Intensity", exposure*0.8*0.8)

    -- self.bulge_mat:setFloat("alpha", util.remap01(0.1, 0.2, p))

    -- local rot = self.ADBE_Rotate_Z_0_3:getCurPartVal(p)
    -- self.res_mat:setFloat("rot", rot*1)
end

function SeekModeScript:_UpdateBasemove(_p)
    local p = _p
    -- p = math.floor(p*60)/60

    local rotate = self.attrs:GetVal("ADBE_Rotate_Z_0_7", p)
    self.basemove_mat:setFloat("rot", rotate[1])

    local scale = self.attrs:GetVal("ADBE_Scale_0_6", p)
    self.basemove_mat:setFloat("scale", scale[1]*0.01)

    local pos = self.attrs:GetVal("ADBE_Position_0_5", p)
    pos = Amaz.Vector2f(pos[1], pos[2])
    -- Amaz.LOGI("lrc pos "..p*60, tostring(pos))
    pos = Amaz.Vector2f(
        (-(pos.x/1080-0.5)), 
        pos.y/1080-0.5
    )
    self.basemove_mat:setVec2("pos", pos)

    local exposure = self.attrs:GetVal("ADBE_Exposure2_0003_0_4", p)
    self.basemove_mat:setFloat("u_Intensity", exposure[1])

    self.basemove_mat:setVec2("pivot", Amaz.Vector2f(540/1080-0.5, 270/1080-0.5))
end

function SeekModeScript:_UpdateBlur(_p)
    local p = _p
    -- p = math.floor(_p*60)/60

    -- Amaz.LOGI("lrc ppp", p*60)
    local rotate = self.attrs:GetVal("ADBE_Radial_Blur_0001_0_2", p)
    -- Amaz.LOGI("lrc p 0 "..p*60, tostring(rotate[1]))
    -- rotate[1] = 0
    self.radial_blur_mat:setFloat("rotate", rotate[1]*0.5)

    local center = self.attrs:GetVal("ADBE_Radial_Blur_0002_0_3", p)
    center = Amaz.Vector2f(center[1], center[2])
    -- center = Amaz.Vector2f(1080*3/4, 1080*1/2)
    -- center = Amaz.Vector2f(
    --     ((center.x/1080) - 0.5) * (1080/self.width) + 0.5, 
    --     (1-(center.y/1080) - 0.5) * (1080/self.height) + 0.5
    -- )
    center = Amaz.Vector2f(
        ((center.x/1080) - 0.5) + 0.5, 
        (1-(center.y/1080) - 0.5) + 0.5
    )
    self.radial_blur_mat:setVec2("center", center)

    local bs1 = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_1", p)
    -- Amaz.LOGI("lrc p 1 "..p*60, tostring(bs1[1]))
    self.blur_mat1:setFloat("blurSize", bs1[1]*0.00025)

    local bs2 = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_0", p)
    -- Amaz.LOGI("lrc p 2 "..p*60, tostring(bs2[1]))
    self.blur_mat2:setFloat("blurSize", bs2[1]*0.0001)

    local bs3 = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_0", p)
    self.blur_mat3:setFloat("blurSize", bs3[1]*0.0005)
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
