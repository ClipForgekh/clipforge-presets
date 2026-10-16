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

local AETools = AETools or {}     ---@class AETools
AETools.__index = AETools

function AETools:new(frameRate)
    local self = setmetatable({}, AETools)
    self.key_frame_info = {}
    self.frameRate = frameRate == nil and 25 or frameRate
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
        local tmp_sum = 0
        -- for i = 1, #val1 do
        --     local tmp_v = math.abs(val1[i]-val2[i])
        --     tmp_sum = tmp_sum + tmp_v * tmp_v
        -- end
        -- res = math.sqrt(tmp_sum)
        for i = 1, #val1 do
            local tmp_v = math.abs(val1[i]-val2[i])
            tmp_sum = tmp_sum + tmp_v
        end
        res = tmp_sum/#val1
    else
        res = math.abs(val1-val2)
    end
    return res
end

function AETools._getAverage(val1, val2, duration)
    local res = nil
    if type(val1) == "table" then
        local tmp_sum = 0
        for i = 1, #val1 do
            local tmp_v = math.abs(val1[i]-val2[i])
            tmp_v = tmp_v/duration
            tmp_sum = tmp_sum + tmp_v * tmp_v
        end
        res = math.sqrt(tmp_sum)
    else
        res = math.abs(val1-val2)
        res = res/duration
    end
    return res + 0.000001
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
    local diff = self._getDiff(frame1["value"], frame2["value"])
    -- Amaz.LOGI("lrc duration", duration)

    local average = diff/duration + 0.0001
    -- Amaz.LOGI("lrc average1", average)
    -- average = self._getAverage(frame1["value"], frame2["value"], duration)
    -- Amaz.LOGI("lrc average2", average)

    local x1 = info1[2]/100
    local y1 = x1*info1[1]/average
    local x2 = 1-info2[2]/100
    local y2 = 1-(1-x2)*info2[1]/average

    -- Amaz.LOGI("lrc x1", x1)
    -- Amaz.LOGI("lrc y1", y1)
    -- Amaz.LOGI("lrc x2", x2)
    -- Amaz.LOGI("lrc y2", y2)
    -- Amaz.LOGI("lrc average", x1*info1[1])

    -- Amaz.LOGI("lrc info1[1]", info1[1])
    -- Amaz.LOGI("lrc info1[2]", info1[2])
    -- Amaz.LOGI("lrc info2[1]", info2[1])
    -- Amaz.LOGI("lrc info2[2]", info2[2])

    local res = nil
    if type(frame1["value"]) == "number" then
        if frame1["value"] > frame2["value"] then
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

        res = self._mix(frame1["value"], frame2["value"], progress)
    else
        res = {}
        local bezier_val = {x1, y1, x2, y2}
        for i = 1, #frame1["value"] do
            if frame1["value"][i] > frame2["value"][i] then
                x1 = info1[2]/100
                y1 = -x1*info1[1]/average
                x2 = info2[2]/100
                y2 = 1+x2*info2[1]/average
                x2 = 1-x2
            end
            bezier_val = {x1, y1, x2, y2}
            local progress = self:_cubicBezier01(bezier_val, part_progress)

            res[i] = self._mix(frame1["value"][i], frame2["value"][i], progress)
        end

        -- Amaz.LOGI("lrc 1", bezier_val[1])
        -- Amaz.LOGI("lrc 2", bezier_val[2])
        -- Amaz.LOGI("lrc 3", bezier_val[3])
        -- Amaz.LOGI("lrc 4", bezier_val[4])
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

local ae_attribute = {
	["ADBE_Brightness_Contrast_2_0001_0"]={
		[1]={{0, 0.01, }, {250, 0.01, }, 13, 0, }, 
		[2]={{250, 0.01, }, {-55.5555555555556, 0.01, }, 15, 20, }, 
		[3]={{-55.5555555555556, 0.01, }, {0, 0.01, }, 24, 0, }, 
		[4]={{-55.5555555555556, 0.01, }, {0, 0.01, }, 29, 0, }, 
	}, 
	["ADBE_Brightness_Contrast_2_0002_0"]={
		[1]={{0, 0.01, }, {625, 0.01, }, 13, 0, }, 
		[2]={{625, 0.01, }, {-138.888888888889, 0.01, }, 15, 50, }, 
		[3]={{-138.888888888889, 0.01, }, {0, 0.01, }, 24, 0, }, 
		[4]={{-138.888888888889, 0.01, }, {0, 0.01, }, 29, 0, }, 
	}, 
	["ADBE_Radial_Blur_0001_0"]={
		[1]={{0, 0.01, }, {156.25, 0.01, }, 0, 0, }, 
		[2]={{156.25, 0.01, }, {-89.2857142857143, 0.01, }, 4, 25, }, 
		[3]={{0, 46, }, {0, 46, }, 11, 0, }, 
		[4]={{0, 0.01, }, {125, 0.01, }, 15, 0, }, 
		[5]={{125, 0.01, }, {-83.3333333333333, 0.01, }, 19, 20, }, 
		[6]={{0, 46, }, {0, 46, }, 25, 0, }, 
		[7]={{0, 46, }, {0, 46, }, 29, 0, }, 
	}, 
	["ADBE_Position_0"]={
		[1]={{0, 0.01, }, {2200, 0.01, }, 0, {480.100006103516, 640, -120, }, }, 
		[2]={{2200, 0.01, }, {2916.66666666667, 0.01, }, 15, {480.100006103516, 640, 1200, }, }, 
		[3]={{2916.66666666667, 0.01, }, {1783.27303247413, 0.01, }, 27, {480.100006103516, 640, -200, }, }, 
		[4]={{1783.27303247413, 0.01, }, {0, 0.01, }, 29, {480.099999999559, 640, -150, }, }, 
	}, 
	["ADBE_Position_0_0"]={
		[1]={{0, 0, }, {0, 1.66666666666667, }, 0, 480.100006103516, }, 
		[2]={{0, 1.66666666666667, }, {0, 2.08333333333333, }, 15, 480.100006103516, }, 
		[3]={{0, 2.08333333333333, }, {0, 12.5, }, 27, 480.100006103516, }, 
		[4]={{0, 12.5, }, {0, 0, }, 29, 480.099999999559, }, 
	}, 
	["ADBE_Position_1_0"]={
		[1]={{0, 0, }, {0, 1.66666666666667, }, 0, 640, }, 
		[2]={{0, 1.66666666666667, }, {0, 2.08333333333333, }, 15, 640, }, 
		[3]={{0, 2.08333333333333, }, {0, 12.5, }, 27, 640, }, 
		[4]={{0, 12.5, }, {0, 0, }, 29, 640, }, 
	}, 
	["ADBE_Position_2_0"]={
		[1]={{0, 0, }, {22000.00000044, 1.66666666666667, }, 0, -120, }, 
		[2]={{5000.0000001, 1.66666666666667, }, {385.008262654219, 2.08333333333333, }, 15, 1200, }, 
		[3]={{-103.388809169471, 2.08333333333333, }, {-12733.5470921275, 12.5, }, 27, -200, }, 
		[4]={{-4796.10503259624, 12.5, }, {0, 0, }, 29, -150, }, 
	}, 
	["ADBE_Rotate_Y_0"]={
		[1]={{0, 33.333333, }, {0, 33.333333, }, 0, 180, }, 
		[2]={{-4.02946398025961e-7, 100, }, {-0.00002717406323, 9.43676756268311, }, 15, 0, }, 
		[3]={{5.65953966837874, 97.5967779755592, }, {0, 16.666666667, }, 27, 180, }, 
		[4]={{5.65953966837874, 97.5967779755592, }, {0, 16.666666667, }, 29, 180, }, 
	}, 
	["ADBE_Rotate_Z_0"]={
		[1]={{0, 33.333333, }, {0.00000462592853, 46.9333334907449, }, 0, -30, }, 
		[2]={{0.00000462592853, 69.8666680996176, }, {0.0000051740614, 9.43025325857129, }, 15, 0, }, 
		[3]={{0.00000672927419, 76.070716403884, }, {-1.00297015137585e-7, 0.01, }, 19, -7, }, 
		[4]={{-0.00000188857875, 100, }, {0, 16.666666667, }, 27, 0, }, 
		[5]={{-0.00000188857875, 100, }, {0, 16.666666667, }, 29, 0, }, 
	}, 
}

local ae_attribute1 = {
	["ADBE_Position_0_0"]={
		[1]={{0, 0, }, {0, 1.66666666666667, }, 0, 435, }, 
		[2]={{0, 0.01, }, {0, 0.01, }, 15, 435, }, 
		[3]={{0, 2.08333333333333, }, {0, 0, }, 27, 435, }, 
	}, 
	["ADBE_Position_1_0"]={
		[1]={{0, 0, }, {0, 1.66666666666667, }, 0, 640, }, 
		[2]={{0, 0.01, }, {0, 0.01, }, 15, 640, }, 
		[3]={{0, 2.08333333333333, }, {0, 0, }, 27, 640, }, 
	}, 
	["ADBE_Position_2_0"]={
		[1]={{0, 0, }, {50000.000001, 1.66666666666667, }, 0, 500, }, 
		[2]={{5000, 0.01, }, {-6250, 0.01, }, 15, 3500, }, 
		[3]={{-50000.000001, 2.08333333333333, }, {0, 0, }, 27, 500, }, 
	}, 
	["ADBE_Rotate_Z_0"]={
		[1]={{0, 33.333333, }, {-0.00000304695751, 22.315035675422, }, 0, -15, }, 
		[2]={{-9.40208179756041e-7, 92.4820998454647, }, {0, 29.8947652193161, }, 15, 0, }, 
		[3]={{-0.00000103752287, 69.8782676686469, }, {0, 41.5288436535707, }, 20, 2, }, 
		[4]={{0, 17.8128559387128, }, {0, 16.666666667, }, 27, 0, }, 
	}, 
}

local ae_attribute2 = {
	["ADBE_Box_Blur2_0001_0"]={
		[1]={{0, 0.01, }, {-125, 0.01, }, 0, 5, }, 
		[2]={{-125, 0.01, }, {0, 0.01, }, 1, 0, }, 
		[3]={{0, 0.01, }, {0, 0.01, }, 27, 0, }, 
		[4]={{0, 0.01, }, {0, 0.01, }, 29, 0, }, 
	}, 
	["ADBE_Radial_Blur_0001_0"]={
		[1]={{0, 0.01, }, {-7000, 0.01, }, 0, 300, }, 
		[2]={{-7000, 0.01, }, {-100, 0.01, }, 1, 20, }, 
		[3]={{-100, 0.01, }, {0, 0.01, }, 6, 0, }, 
		[4]={{0, 0.01, }, {250, 0.01, }, 27, 0, }, 
		[5]={{250, 0.01, }, {0, 0.01, }, 29, 20, }, 
	}, 
}

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)

    Amaz.LOGI()
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

    self.distance_from_cam = -10.
    self.distance_from_cam1 = -10.
    self.composite_size_in_ae = Amaz.Vector2f(960., 1280.)
    self.fovx_in_ae = 39.6

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
    self.duration = 1.0
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

    if self.curvePositionX == nil then
		self.curvePositionX = AETools:new()
		for i = 1, #ae_attribute.ADBE_Position_0_0 do
			local value = ae_attribute.ADBE_Position_0_0[i]
			self.curvePositionX:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curvePositionY == nil then
		self.curvePositionY = AETools:new()
		for i = 1, #ae_attribute.ADBE_Position_1_0 do
			local value = ae_attribute.ADBE_Position_1_0[i]
			self.curvePositionY:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curvePositionZ == nil then
		self.curvePositionZ = AETools:new()
		for i = 1, #ae_attribute.ADBE_Position_2_0 do
			local value = ae_attribute.ADBE_Position_2_0[i]
			self.curvePositionZ:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveRotateY == nil then
		self.curveRotateY = AETools:new()
		for i = 1, #ae_attribute.ADBE_Rotate_Y_0 do
			local value = ae_attribute.ADBE_Rotate_Y_0[i]
			self.curveRotateY:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveRotateZ == nil then
		self.curveRotateZ = AETools:new()
		for i = 1, #ae_attribute.ADBE_Rotate_Z_0 do
			local value = ae_attribute.ADBE_Rotate_Z_0[i]
			self.curveRotateZ:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveRadialBlur == nil then
		self.curveRadialBlur = AETools:new()
		for i = 1, #ae_attribute.ADBE_Radial_Blur_0001_0 do
			local value = ae_attribute.ADBE_Radial_Blur_0001_0[i]
			self.curveRadialBlur:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveContrast == nil then
		self.curveContrast = AETools:new()
		for i = 1, #ae_attribute.ADBE_Brightness_Contrast_2_0002_0 do
			local value = ae_attribute.ADBE_Brightness_Contrast_2_0002_0[i]
			self.curveContrast:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveLight == nil then
		self.curveLight = AETools:new()
		for i = 1, #ae_attribute.ADBE_Brightness_Contrast_2_0001_0 do
			local value = ae_attribute.ADBE_Brightness_Contrast_2_0001_0[i]
			self.curveLight:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curvePositionZ1 == nil then
		self.curvePositionZ1 = AETools:new()
		for i = 1, #ae_attribute1.ADBE_Position_2_0 do
			local value = ae_attribute1.ADBE_Position_2_0[i]
			self.curvePositionZ1:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveRotateZ1 == nil then
		self.curveRotateZ1 = AETools:new()
		for i = 1, #ae_attribute1.ADBE_Rotate_Z_0 do
			local value = ae_attribute1.ADBE_Rotate_Z_0[i]
			self.curveRotateZ1:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveBoxBlur == nil then
		self.curveBoxBlur = AETools:new()
		for i = 1, #ae_attribute2.ADBE_Box_Blur2_0001_0 do
			local value = ae_attribute2.ADBE_Box_Blur2_0001_0[i]
			self.curveBoxBlur:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    if self.curveZoomBlur == nil then
		self.curveZoomBlur = AETools:new()
		for i = 1, #ae_attribute2.ADBE_Radial_Blur_0001_0 do
			local value = ae_attribute2.ADBE_Radial_Blur_0001_0[i]
			self.curveZoomBlur:addKeyFrameInfo(value[1], value[2], value[3], value[4])
		end
	end

    self.meshComp = comp.entity.scene:findEntityBy("PassUpInput"):getComponent("MeshRenderer")
    -- self.customMesh = self:createCustomMesh()
    -- self.meshComp.mesh = self.customMesh

    self.cam = comp.entity.scene:findEntityBy("CameraUp"):getComponent("Camera")
    self.cam1 = comp.entity.scene:findEntityBy("CameraBottom"):getComponent("Camera")
    self.trans = comp.entity.scene:findEntityBy("PassUp"):getComponent("Transform")
    self.trans1 = comp.entity.scene:findEntityBy("PassBottom"):getComponent("Transform")
    self.camUpInput = comp.entity.scene:findEntityBy("CameraUpInput"):getComponent("Camera")
    self.camBottomInput = comp.entity.scene:findEntityBy("CameraBottomInput"):getComponent("Camera")
    self.camHorzBlur = comp.entity.scene:findEntityBy("CameraHorzBlur"):getComponent("Camera")
    self.matUp = comp.entity.scene:findEntityBy("PassUp"):getComponent("MeshRenderer").material
    self.matUpInput = comp.entity.scene:findEntityBy("PassUpInput"):getComponent("MeshRenderer").material
    self.matBottom = comp.entity.scene:findEntityBy("PassBottom"):getComponent("MeshRenderer").material
    self.matHorzBlur1 = comp.entity.scene:findEntityBy("PassHorzBlur1"):getComponent("MeshRenderer").material
    self.matVertBlur1 = comp.entity.scene:findEntityBy("PassVertBlur1"):getComponent("MeshRenderer").material
    self.matZoomBlur = comp.entity.scene:findEntityBy("PassZoomBlur"):getComponent("MeshRenderer").material
    self.OutputMaterial = comp.entity.scene:findEntityBy("Output"):getComponent("MeshRenderer").material

end

function SeekModeScript:_rotateByAEAxis(_trans, _euler_angle)
    -- ae xyz, editor yxz
    local up = Amaz.Vector3f(0.0, 1.0, 0.0)
    local left = Amaz.Vector3f(1.0, 0.0, 0.0)
    local forward = Amaz.Vector3f(0.0, 0.0, 1.0)

    local y_angle = math.pi * _euler_angle.y/180
    local x_angle = math.pi * _euler_angle.x/180
    local z_angle = math.pi * _euler_angle.z/180

    _trans.localOrientation = Amaz.Quaternionf.axisAngleToQuaternion(left, x_angle) * 
                            Amaz.Quaternionf.axisAngleToQuaternion(up, y_angle) * 
                            Amaz.Quaternionf.axisAngleToQuaternion(forward, z_angle)
end

function SeekModeScript:updateFunc(_progress)
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    Amaz.LOGI("ldrldr4", "updateFunc input w-h: "..w.."-"..h)
    local w1 = Amaz.BuiltinObject.getOutputTextureWidth()
    local h1 = Amaz.BuiltinObject.getOutputTextureHeight()
    Amaz.LOGI("ldrldr4", "updateFunc output w-h: "..w1.."-"..h1)

    local focal_length_in_ae = self.composite_size_in_ae.x * 0.5 / math.tan(self.fovx_in_ae*0.5/180*math.pi)

    -- set the camera's fovy
    local y_length = focal_length_in_ae * math.tan(self.fovx_in_ae*0.5/180*math.pi)*h/w
    local fovy = math.atan(y_length/focal_length_in_ae)/math.pi*2*180
    self.cam.fovy = fovy

    -- set the tran's scale
    local y_scale = math.tan(fovy*0.5/180*math.pi)*math.abs(self.distance_from_cam)
    self.trans.localScale = Amaz.Vector3f(y_scale*w/h, y_scale, 1)

    local border = Amaz.Vector2f(y_scale*w/h*2, y_scale*2)

    self.trans.localPosition = Amaz.Vector3f(
        (self.curvePositionX:getCurPartVal(_progress)/self.composite_size_in_ae.x-0.5)*border.x,
        -(self.curvePositionY:getCurPartVal(_progress)/self.composite_size_in_ae.y-0.5)*border.y,
        self.curvePositionZ:getCurPartVal(_progress) / focal_length_in_ae * self.distance_from_cam + self.distance_from_cam
    )
    -- self.trans.localPosition = Amaz.Vector3f(0,0,0)
    -- Amaz.LOGI("lrc zzz", self.curvePositionZ:getCurPartVal(_progress))

    self:_rotateByAEAxis(self.trans, Amaz.Vector3f(
        0,
        -self.curveRotateY:getCurPartVal( _progress),
        -self.curveRotateZ:getCurPartVal( _progress)
    ))

end

function SeekModeScript:updateFunc1(_progress)
    local w = Amaz.BuiltinObject.getOutputTextureWidth()
    local h = Amaz.BuiltinObject.getOutputTextureHeight()
    Amaz.LOGI("ldrldr4", "updateFunc1 input w-h: "..w.."-"..h)
    local w1 = Amaz.BuiltinObject.getOutputTextureWidth()
    local h1 = Amaz.BuiltinObject.getOutputTextureHeight()
    Amaz.LOGI("ldrldr4", "updateFunc1 output w-h: "..w1.."-"..h1)

    local focal_length_in_ae = self.composite_size_in_ae.x * 0.5 / math.tan(self.fovx_in_ae*0.5/180*math.pi)

    -- set the camera's fovy
    local y_length = focal_length_in_ae * math.tan(self.fovx_in_ae*0.5/180*math.pi)*h/w
    local fovy = math.atan(y_length/focal_length_in_ae)/math.pi*2*180
    self.cam1.fovy = fovy

    -- set the tran's scale
    local y_scale = math.tan(fovy*0.5/180*math.pi)*math.abs(self.distance_from_cam1)
    self.trans1.localScale = Amaz.Vector3f(y_scale*w/h, y_scale, 1)

    local border = Amaz.Vector2f(y_scale*w/h*2, y_scale*2)

    self.trans1.localPosition = Amaz.Vector3f(
        0,
        0,
        self.curvePositionZ1:getCurPartVal(_progress) / focal_length_in_ae * self.distance_from_cam1 + self.distance_from_cam1
    )
    -- self.trans.localPosition = Amaz.Vector3f(0,0,0)
    -- Amaz.LOGI("lrc zzz", self.curvePositionZ:getCurPartVal(_progress))

    self:_rotateByAEAxis(self.trans1, Amaz.Vector3f(
        0,
        0,
        0---self.curveRotateZ1:getCurPartVal( _progress)
    ))
    self.matBottom:setFloat("w", w)
    self.matBottom:setFloat("h", h)
    self.matBottom:setFloat("angle", -self.curveRotateZ1:getCurPartVal( _progress))
end

function SeekModeScript:initKeyFrame() 
    for _name, info_list in pairs(ae_attribute) do
        local tool = AETools:new(25)
        for i = 1, #info_list do
            tool:addKeyFrameInfo(info_list[i][1], info_list[i][2], info_list[i][3], info_list[i][4])
        end
        self[_name] = tool
    end
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
    local inputW = Amaz.BuiltinObject.getInputTextureWidth()
    local inputH = Amaz.BuiltinObject.getInputTextureHeight()
    local inputRatio = inputW / inputH
    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
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

    -- self.curTime = self.curTime + deltaTime
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("curTime") then
    --     self.curTime = props:get("curTime")
    -- end
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    self.matUp["baseTexWidth"] = w
    self.matUp["baseTexHeight"] = 1. * h
    self.matBottom["baseTexWidth"] = w
    self.matBottom["baseTexHeight"] = 1. * h
    self.cam.renderTexture.width = 1. * w
    self.cam.renderTexture.height = 1. * h
    self.camUpInput.renderTexture.width = w * 3.
    self.camUpInput.renderTexture.height = h * 3.
    self.camBottomInput.renderTexture.width = w / 1.5
    self.camBottomInput.renderTexture.height = h / 1.5
    self.camHorzBlur.renderTexture.width = w / 1.5
    self.camHorzBlur.renderTexture.height = h / 1.5
    -- local duration = self.endTime - self.startTime
    -- local time = (self.curTime * self.speedIntensity) % 1
    local progress = self.progress
    self.matBottom:setFloat("angle", self.curveRotateZ1:getCurPartVal(progress))
    self:updateFunc(progress)
    self:updateFunc1(progress)
    local flipFlag1 = 4. / 30.
    local flipFlag2 = 17. / 30.
    if progress < flipFlag1 then
        self.matUp["flip"] = 1
    elseif progress < flipFlag2 then
        self.matUp["flip"] = 0
    else
        self.matUp["flip"] = 1
    end

    -- radial blur
    self.matUp["sampleCount"] = 25 -- self.curveRadialBlur:getCurPartVal(progress) * 1
    self.matUp["factor"] = self.curveRadialBlur:getCurPartVal(progress) / 25. * 6 / (self.duration + .5) 

    -- sharpen
    self.matUpInput["sharpenIntensity"] = self.curveContrast:getCurPartVal(progress) / 100

    -- light
    self.matUpInput["lightIntensity"] = self.curveLight:getCurPartVal(progress) / 100

    -- box blur
    self.matHorzBlur1["horzR"] = self.curveBoxBlur:getCurPartVal(progress) * 2
    self.matVertBlur1["vertR"] = self.curveBoxBlur:getCurPartVal(progress) * 2
    -- Amaz.LOGI("ly@", self.matVertBlur1["vertR"]);

    -- zoom blur
    self.matZoomBlur["strength"] = self.curveZoomBlur:getCurPartVal(progress) / 300. * 1

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
