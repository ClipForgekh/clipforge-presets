local util = nil    ---@class Util

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean
---@field wave_speed number

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

local ae_attribute_out1 = {
	["CC_Radial_Blur_0002_0_0"]={
		[1]={{0, 16.666666667, }, {0, 32, }, 0, 28, }, 
		[2]={{-44.8, 0.01, }, {0, 0.01, }, 8, 0, }, 
		[3]={{-44.8, 0.01, }, {0, 0.01, }, 14, 0, }, 
	}, 
	["CC_Radial_Blur_0004_0_1"]={
		[1]={{0, 16.666666667, }, {0, 32, }, 0, {61.4187643561565, 544.684500615589, }, }, 
		[2]={{410.110666532615, 0.01, }, {0, 0.01, }, 10, {317.605633802817, 552.904290429043, }, }, 
		[3]={{410.110666532615, 0.01, }, {0, 0.01, }, 14, {317.605633802817, 552.904290429043, }, }, 
	}, 
	["CC_Radial_Blur_0002_0_2"]={
		[1]={{0, 16.666666667, }, {0, 32, }, 0, 76, }, 
		[2]={{-121.6, 0.01, }, {0, 0.01, }, 8, 0, }, 
		[3]={{-121.6, 0.01, }, {0, 0.01, }, 14, 0, }, 
	}, 
	["CC_Radial_Blur_0004_0_3"]={
		[1]={{0, 16.666666667, }, {0, 32, }, 0, {61.4187643561565, 544.684500615589, }, }, 
		[2]={{410.110666532615, 0.01, }, {0, 0.01, }, 10, {317.605633802817, 552.904290429043, }, }, 
		[3]={{410.110666532615, 0.01, }, {0, 0.01, }, 14, {317.605633802817, 552.904290429043, }, }, 
	}, 
	["ADBE_Wave_Warp_0002_0_4"]={
		[1]={{0, 0.01, }, {22.8571428571429, 0.01, }, 1, 0, }, 
		[2]={{22.8571428571429, 0.01, }, {-26.6666666666667, 0.01, }, 8, 10, }, 
		[3]={{-26.6666666666667, 0.01, }, {0, 0.01, }, 14, 0, }, 
	}, 
	["ADBE_Exposure2_0003_0_5"]={
		[1]={{0, 0.01, }, {-4.8, 0.01, }, 0, 3, }, 
		[2]={{-4.8, 0.01, }, {0, 0.01, }, 10, 0, }, 
		[3]={{-4.8, 0.01, }, {0, 0.01, }, 14, 0, }, 
	}, 
}

local ae_attribute_out1_1 = {
	["ADBE_Position_0"]={
		[1]={{0, 0.01, }, {471.539313382389, 0.01, }, 0, {357, 659, 0, }, }, 
		[2]={{471.539313382389, 0.01, }, {0, 0.01, }, 20, {550, 550, 0, }, }, 
		[3]={{0, 0.01, }, {0, 0.01, }, 27, {550, 550, 0, }, }, 
	}, 
	["ADBE_Position_0_0"]={
		[1]={{0, 16.666666667, }, {1123.42703206136, 16.666666667, }, 0, 355, }, 
		[2]={{1075.98554165312, 16.666666667, }, {1075.98554165312, 16.666666667, }, 1, 392.447567735379, }, 
		[3]={{992.906573446869, 16.666666667, }, {992.906573446869, 16.666666667, }, 2, 426.732369443541, }, 
		[4]={{925.073083957503, 16.666666667, }, {925.073083957503, 16.666666667, }, 3, 458.641339298503, }, 
		[5]={{861.893587859241, 16.666666667, }, {861.893587859241, 16.666666667, }, 4, 488.403908374042, }, 
		[6]={{800.17781314565, 16.666666667, }, {800.17781314565, 16.666666667, }, 5, 516.100911822453, }, 
		[7]={{736.886318495617, 16.666666667, }, {736.886318495617, 16.666666667, }, 6, 541.749095917085, }, 
		[8]={{668.129625427906, 16.666666667, }, {668.129625427906, 16.666666667, }, 7, 565.226666388827, }, 
		[9]={{584.887316569163, 16.666666667, }, {584.887316569163, 16.666666667, }, 8, 586.291070945612, }, 
		[10]={{456.823069567336, 16.666666667, }, {456.823069567336, 16.666666667, }, 9, 604.219154160105, }, 
		[11]={{206.817042385284, 16.666666667, }, {206.817042385284, 16.666666667, }, 10, 616.745942250101, }, 
		[12]={{-116.027028680613, 16.666666667, }, {-116.027028680613, 16.666666667, }, 11, 618.00695698579, }, 
		[13]={{-310.054683380356, 16.666666667, }, {-310.054683380356, 16.666666667, }, 12, 609.010807004727, }, 
		[14]={{-347.797804927084, 16.666666667, }, {-347.797804927084, 16.666666667, }, 13, 597.336644760433, }, 
		[15]={{-328.939872277264, 16.666666667, }, {-328.939872277264, 16.666666667, }, 14, 585.824286676255, }, 
		[16]={{-289.974523398262, 16.666666667, }, {-289.974523398262, 16.666666667, }, 15, 575.407319941949, }, 
		[17]={{-240.868904758157, 16.666666667, }, {-240.868904758157, 16.666666667, }, 16, 566.492651783037, }, 
		[18]={{-184.906824970905, 16.666666667, }, {-184.906824970905, 16.666666667, }, 17, 559.349392958072, }, 
		[19]={{-124.702284272493, 16.666666667, }, {-124.702284272493, 16.666666667, }, 18, 554.16553011831, }, 
		[20]={{-62.4829517746537, 16.666666667, }, {-62.4829517746537, 16.666666667, }, 19, 551.035907339906, }, 
		[21]={{-19.1819246953759, 16.666666667, }, {-19.1819246953759, 16.666666667, }, 20, 550, }, 
		[22]={{-9.99764938720148, 16.666666667, }, {-9.99764938720148, 16.666666667, }, 21, 549.757112360214, }, 
		[23]={{-6.95225926200294, 16.666666667, }, {-6.95225926200294, 16.666666667, }, 22, 549.333490040853, }, 
		[24]={{4.0532020337065, 16.666666667, }, {4.0532020337065, 16.666666667, }, 23, 549.293628409414, }, 
		[25]={{8.00019851438378, 16.666666667, }, {8.00019851438378, 16.666666667, }, 24, 549.603703509767, }, 
		[26]={{5.31108265878288, 16.666666667, }, {5.31108265878288, 16.666666667, }, 25, 549.826974977039, }, 
		[27]={{2.59537534440881, 16.666666667, }, {2.59537534440881, 16.666666667, }, 26, 549.957775687019, }, 
		[28]={{1.2667293894242, 16.666666667, }, {0, 16.666666667, }, 27, 550, }, 
	}, 
	["ADBE_Position_1_0"]={
		[1]={{0, 16.666666667, }, {-144.816192967088, 16.666666667, }, 0, 681, }, 
		[2]={{-149.717444980729, 16.666666667, }, {-149.717444980729, 16.666666667, }, 1, 676.172793567764, }, 
		[3]={{-161.193947033488, 16.666666667, }, {-161.193947033488, 16.666666667, }, 2, 671.018837001285, }, 
		[4]={{-175.532389721999, 16.666666667, }, {-175.532389721999, 16.666666667, }, 3, 665.426530432198, }, 
		[5]={{-192.499310947608, 16.666666667, }, {-192.499310947608, 16.666666667, }, 4, 659.316677686485, }, 
		[6]={{-213.070243278088, 16.666666667, }, {-213.070243278088, 16.666666667, }, 5, 652.593243035691, }, 
		[7]={{-238.967498429912, 16.666666667, }, {-238.967498429912, 16.666666667, }, 6, 645.111994801279, }, 
		[8]={{-273.770245037778, 16.666666667, }, {-273.770245037778, 16.666666667, }, 7, 636.662076473697, }, 
		[9]={{-324.78591165947, 16.666666667, }, {-324.78591165947, 16.666666667, }, 8, 626.860645132094, }, 
		[10]={{-405.035430821329, 16.666666667, }, {-405.035430821329, 16.666666667, }, 9, 615.009682363065, }, 
		[11]={{-491.088371985413, 16.666666667, }, {-491.088371985413, 16.666666667, }, 10, 599.858283077338, }, 
		[12]={{-465.684251124216, 16.666666667, }, {-465.684251124216, 16.666666667, }, 11, 582.270457564038, }, 
		[13]={{-331.866845820046, 16.666666667, }, {-331.866845820046, 16.666666667, }, 12, 568.812666335724, }, 
		[14]={{-213.220177615459, 16.666666667, }, {-213.220177615459, 16.666666667, }, 13, 560.146001176035, }, 
		[15]={{-133.579047516745, 16.666666667, }, {-133.579047516745, 16.666666667, }, 14, 554.597987828027, }, 
		[16]={{-76.2095452469129, 16.666666667, }, {-76.2095452469129, 16.666666667, }, 15, 551.240731341585, }, 
		[17]={{-33.5436674747802, 16.666666667, }, {-33.5436674747802, 16.666666667, }, 16, 549.517351478233, }, 
		[18]={{-3.88098266737472, 16.666666667, }, {-3.88098266737472, 16.666666667, }, 17, 549.004486843266, }, 
		[19]={{11.3265082002079, 16.666666667, }, {11.3265082002079, 16.666666667, }, 18, 549.258619300408, }, 
		[20]={{11.1207104938853, 16.666666667, }, {11.1207104938853, 16.666666667, }, 19, 549.759587389947, }, 
		[21]={{4.52679169449937, 16.666666667, }, {4.52679169449937, 16.666666667, }, 20, 550, }, 
		[22]={{2.52623297065213, 16.666666667, }, {2.52623297065213, 16.666666667, }, 21, 550.061373502913, }, 
		[23]={{1.75671559263037, 16.666666667, }, {1.75671559263037, 16.666666667, }, 22, 550.168415531377, }, 
		[24]={{-1.02417400507989, 16.666666667, }, {-1.02417400507989, 16.666666667, }, 23, 550.178487875755, }, 
		[25]={{-2.0215117050077, 16.666666667, }, {-2.0215117050077, 16.666666667, }, 24, 550.100137264371, }, 
		[26]={{-1.34201866887338, 16.666666667, }, {-1.34201866887338, 16.666666667, }, 25, 550.043720428755, }, 
		[27]={{-0.65580643132364, 16.666666667, }, {-0.65580643132364, 16.666666667, }, 26, 550.010669353113, }, 
		[28]={{-0.32008059339773, 16.666666667, }, {0, 16.666666667, }, 27, 550, }, 
	}, 
	["ADBE_Scale_0"]={
		[1]={{0, 0.01, }, {43.8089310437723, 53.9724347037076, }, 0, {71, 71, 100, }, }, 
		[2]={{32.8628945700308, 19.5048706145376, }, {32.8628945700307, 15.3806843913724, }, 10, {111.748763649175, 111.748763649175, 100, }, }, 
		[3]={{0.0000070916735, 46.9969973019935, }, {0, 16.666666667, }, 27, {100, 100, 100, }, }, 
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
    self.wave_speed = 2
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

    self.Fading_Zoom_Radial_Blur_mat = comp.entity.scene:findEntityBy("Fading_Zoom_Radial_Blur"):getComponent("MeshRenderer").material
    self.Centered_Zoom_Radial_Blur_mat = comp.entity.scene:findEntityBy("Centered_Zoom_Radial_Blur"):getComponent("MeshRenderer").material
    self.wavewarp_mat = comp.entity.scene:findEntityBy("wavewarp"):getComponent("MeshRenderer").material
    self.res_mat = comp.entity.scene:findEntityBy("res"):getComponent("MeshRenderer").material

    self:initKeyFrame(ae_attribute_out1, 16)
    self:initKeyFrame(ae_attribute_out1_1, 30)

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

function SeekModeScript:autoPlay(time)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        if self.autoplay then
            self.progress = time % self._duration / (self._duration + 0.01)
        end
    else
        -- self.duration = self.endTime - self.startTime
        -- -- local whole = self._duration / self.duration
        -- self.progress = time % (self._duration+0.001) / (self._duration + 0.001)
        self.progress = util.clamp(0, 1, (time / self._duration))
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
    -- self:autoPlay(time)
    self.progress = math.mod(time/(self.duration+0.0001), 1)

    -- self.progress = math.floor(self.progress*27)/27

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    
    local progress = self.progress
    self.Fading_Zoom_Radial_Blur_mat:setFloat("u_Amount", 1*self.CC_Radial_Blur_0002_0_0:getCurPartVal(progress) * 1.5)
    local center1 = Amaz.Vector2f(
        self.CC_Radial_Blur_0004_0_1:getCurPartVal(progress)[1]/1100,
        self.CC_Radial_Blur_0004_0_1:getCurPartVal(progress)[2]/1100
    )
    self.Fading_Zoom_Radial_Blur_mat:setVec2("u_Center", center1)
    
    self.Centered_Zoom_Radial_Blur_mat:setFloat("u_Amount", 1*self.CC_Radial_Blur_0002_0_2:getCurPartVal(progress) * 1.5)
    local center2 = Amaz.Vector2f(
        self.CC_Radial_Blur_0004_0_3:getCurPartVal(progress)[1]/1100,
        self.CC_Radial_Blur_0004_0_3:getCurPartVal(progress)[2]/1100
    )
    self.Centered_Zoom_Radial_Blur_mat:setVec2("u_Center", center2)

    self.wavewarp_mat:setFloat("wave_speed", self.wave_speed)
    self.wavewarp_mat:setFloat("wave_height", self.ADBE_Wave_Warp_0002_0_4:getCurPartVal(progress)/1100)
    self.wavewarp_mat:setFloat("wave_width", 232/1100*3)
    self.wavewarp_mat:setFloat("x_phase", progress)

    self.wavewarp_mat:setFloat("u_Intensity", self.ADBE_Exposure2_0003_0_5:getCurPartVal(progress)*1*0.85 * 0.9)

    local offset = Amaz.Vector2f(
        -(self.ADBE_Position_0_0:getCurPartVal(progress)/1100 - 0.5) * 2 *1,
        (self.ADBE_Position_1_0:getCurPartVal(progress)/1100 - 0.5) * 2 *1
    )
    self.res_mat:setVec2("offset", offset)
    self.res_mat:setFloat("scale", 1/(self.ADBE_Scale_0:getCurPartVal(progress)[1]/100))
    -- self.res_mat:setFloat("scale", 1)

    -- Amaz.LOGI("lrc "..self.progress*27, self.ADBE_Scale_0:getCurPartVal(progress)[1])

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
