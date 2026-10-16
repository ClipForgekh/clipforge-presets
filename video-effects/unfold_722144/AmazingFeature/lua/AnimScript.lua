-- Use requireFile to include other lua modules within the same folder

local exports = exports or {}
local AnimScript = AnimScript or {}

---@class AnimScript : ScriptComponent
---@field progress number [UI(Range={0.0, 1.0}, Slider)]
---@field duration number
---@field autoPlay boolean
AnimScript.__index = AnimScript



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
    Amaz.LOGI("lrc registerRootDir", tostring(path))
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

function util.ReadFromJson(file_path, jsonData)
    local file = io.input(util.getRootDir() .. file_path)
    local text = io.read("*a")
    if jsonData ~= "" then
        text = jsonData
    end
    local json_data = json.decode(text)
    return json_data
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


function util.clamp(min, max, value)
	return math.min(math.max(value, min), max)
end

function util.test()
    Amaz.LOGI("lrc", "test123")
end

local ae_attribute = {
	["ADBE_Gaussian_Blur_H"]={
		{{0.001, 0, 0.58, 1, }, {0, 6, }, {{222, }, {0, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur_V"]={
		{{0.001, 0, 0.58, 1, }, {0, 6, }, {{55, }, {0, }, }, }, 
	}, 
	["ADBE_Exposure"]={
		{{0.42, 0, 0.58, 1, }, {0, 17, }, {{2, }, {0, }, }, }, 
	}, 
	["ADBE_Position"]={
		{{0.001, 0, 0.58, 1, }, {0, 4, }, {{535, 476, 0, }, {534.5, 556.0625, 0, }, }, }, 
		{{0.3, 0, 0.5, 1, }, {4, 10, }, {{534.5, 556.0625, 0, }, {537.3125, 533.4375, 0, }, }, }, 
		{{0.3, 0, 0.5, 1, }, {10, 17, }, {{537.3125, 533.4375, 0, }, {540, 540, 0, }, }, }, 
	}, 
	["ADBE_Scale"]={
		{{0.001,0.001,0.001, 0,0.001,0.001, 0.2,0.2,0.2, 1,0.2,0.2, }, {0, 6, }, {{80, 100, 100, }, {100, 100, 100, }, }, }, 
	}, 
	["ADBE_Rotate_Z"]={
		{{0.42, 0, 0.58, 1, }, {0, 9, }, {{-0.4, }, {0.17, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {9, 17, }, {{0.17, }, {0, }, }, }, 
	}, 
}

function AnimScript.new()
    local self = {}
    setmetatable(self, AnimScript)
    self.transform = {}
    self.progress = 0
    self.duration = 3
    self.autoPlay = false
    self.curTime = 0
    return self
end

---@param comp Component
function AnimScript:onStart(comp)
    -- Amaz.LOGE("AnimScript", "onStart")
    self.transMat = comp.entity.scene:findEntityBy("Trans"):getComponent("MeshRenderer").material
    self.GaussianRootHLua = comp.entity.scene:findEntityBy("Gaussian_Blur_Root_H"):getComponent("ScriptComponent").properties
    self.GaussianRootVLua = comp.entity.scene:findEntityBy("Gaussian_Blur_Root_V"):getComponent("ScriptComponent").properties
    self.exposureMat = comp.entity.scene:findEntityBy("Exposure"):getComponent("MeshRenderer").material

    self.attrs = AETools:new(ae_attribute)

end

---@param comp Component
---@param deltaTime number
function AnimScript:onUpdate(comp, deltaTime)
    if self.autoPlay == true then
        self.curTime = self.curTime + deltaTime
        self.progress = self.curTime / self.duration % 1
    else
        self.curTime = 0

    end
    -- Amaz.LOGE("AnimScript", "onUpdate")
    local scale = self.attrs:GetVal("ADBE_Scale", self.progress)[1] * 0.01
    self.transMat:setVec2("u_Scale", Amaz.Vector2f(scale, 1))
    local pos = self.attrs:GetVal("ADBE_Position", self.progress)
    self.transMat:setVec2("u_Position", Amaz.Vector2f((pos[1] - 540) / 1080, -(pos[2] - 540) / 1080))


    local blurInsH = self.attrs:GetVal("ADBE_Gaussian_Blur_H", self.progress)[1]
    local blurInsV = self.attrs:GetVal("ADBE_Gaussian_Blur_V", self.progress)[1]
    self.GaussianRootHLua:set("Intensity", blurInsH * 0.7)
    self.GaussianRootVLua:set("Intensity", blurInsV * 0.7)

    local exposure = self.attrs:GetVal("ADBE_Exposure", self.progress)[1]
    self.exposureMat:setFloat("u_Intensity", exposure)

    local rotate = self.attrs:GetVal("ADBE_Rotate_Z", self.progress)[1]
    self.transMat:setFloat("u_Rotate", rotate)
end

---@param comp Component
---@param event Event
function AnimScript:onEvent(comp, event)
end

exports.AnimScript = AnimScript
return exports
