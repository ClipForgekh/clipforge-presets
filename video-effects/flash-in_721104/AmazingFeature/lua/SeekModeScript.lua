local util = nil    ---@class Util

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field offsetRange Vector2f
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean

local util = nil      ---@type Util

local AETools = AETools or {}     ---@class AETools
AETools.__index = AETools

function AETools:new(attrs)
    local self = setmetatable({}, AETools)
    self.attrs = attrs

    local max_frame = 0
    for _,v in pairs(attrs) do
        for i = 1, #v do
            local content = v[i]
            local cur_frame = content[2][2]
            max_frame = math.max(cur_frame, max_frame)
        end
    end

    self:SetAllFrame(max_frame)

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

function AETools:SetAllFrame(val)
    self.all_frame = val
end

function AETools:GetVal(_name, _progress)
    local content = self.attrs[_name]
    if content == nil then
        return nil
    end

    local cur_frame = _progress * self.all_frame

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
    -- self.blurCompProperty = self.entity.scene:findEntityBy("Gaussian_Blur_Root"):getComponent("ScriptComponent").properties
    -- self.modelAnimSeq = self.entity.scene:findEntityBy("quad"):getComponent("AnimSeqComponent")
    self.fxaaMat = self.entity.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.entity.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.transform = self.entity.scene:findEntityBy("quad"):getComponent("Transform")
    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)

    -- if isEditor then
    --     comp.entity.scene:findEntityBy('bgCamera').visible = false
    -- else
    --     comp.entity.scene:findEntityBy('bgCamera').visible = true
    -- end
end
local ae_attribute = {
	["ADBE_Tile_0002_0_0"]={
		{{0.001, 0, 0.2, 1, }, {1, 5, }, {{70, }, {100, }, }, }, 
	}, 
	["ADBE_Tile_0003_0_1"]={
		{{0.001, 0, 0.2, 1, }, {1, 5, }, {{70, }, {100, }, }, }, 
	}, 
	["ADBE_WRPMESH_0003_0_2"]={
		{{1, 0, 0.999, 0, }, {0, 1, }, {{0, }, {-88, }, }, }, 
		{{0.001, 0, 0.2, 1, }, {1, 5, }, {{-88, }, {4, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {5, 11, }, {{4, }, {0, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur_2_0001_0_3"]={
		{{0.001, 0, 0.58, 1, }, {0, 2, }, {{800, }, {15, }, }, }, 
		{{0.001, 0.001, 0.999, 0.999, }, {2, 3, }, {{15, }, {15, }, }, }, 
		{{0.44, 0, 0.67, 1, }, {3, 9, }, {{15, }, {0, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur_2_0001_0_4"]={
		{{0.001, 0, 0.999, 1, }, {1, 3, }, {{15, }, {200, }, }, }, 
		{{0.33, 0, 0.67, 1, }, {3, 8, }, {{200, }, {0, }, }, }, 
	}, 
	["ADBE_Exposure2_0003_0_5"]={
		{{0.42, 0, 0.58, 1, }, {1, 3, }, {{-2, }, {3, }, }, }, 
		{{0.5, 0, 0.75, 1, }, {3, 6, }, {{3, }, {0, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {6, 9, }, {{0, }, {1.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {9, 20, }, {{1.5, }, {0, }, }, }, 
	}, 
	["ADBE_Scale_0_6"]={
		{{0.001,0.001,0.001, 0,0,0.001, 0.2,0.2,0.2, 1,1,0.2, }, {1, 5, }, {{100, 100, 100, }, {105.5, 105.5, 100, }, }, }, 
		{{0.4,0.4,0.4, 0,0,0.4, 0.4,0.4,0.4, 1,1,0.4, }, {5, 20, }, {{105.5, 105.5, 100, }, {100, 100, 100, }, }, }, 
	}, 
}
function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)

    -- if util == nil then
    --     util = includeRelativePath("Util")
    -- end
    util.registerRootDir(comp.entity.scene.assetMgr.rootDir)
    self.AEDemoSize = Amaz.Vector2f(1080,1080)
    self.rootDir = comp.entity.scene.assetMgr.rootDir
    self:initKeyFrame(ae_attribute,30)
    -- local attr = self.attrs:GetVal("ADBE_Tile_0002_0_0", 0)
    -- Amaz.LOGI("ldrldr", attr[1])
    self.tileMat = comp.entity.scene:findEntityBy("PassTile"):getComponent("MeshRenderer").material
    self.distortMat = comp.entity.scene:findEntityBy("PassDistort"):getComponent("MeshRenderer").material
    self.horzBlurMat = comp.entity.scene:findEntityBy("PassHorzBlur"):getComponent("MeshRenderer").material
    self.horzBlurMat1 = comp.entity.scene:findEntityBy("PassHorzBlur1"):getComponent("MeshRenderer").material
    self.horzBlurMat2 = comp.entity.scene:findEntityBy("PassHorzBlur2"):getComponent("MeshRenderer").material
    self.vertBlurMat = comp.entity.scene:findEntityBy("PassVertBlur"):getComponent("MeshRenderer").material
    self.vertBlurMat1 = comp.entity.scene:findEntityBy("PassVertBlur1"):getComponent("MeshRenderer").material
    self.exposureMat = comp.entity.scene:findEntityBy("PassExposure"):getComponent("MeshRenderer").material

    -- if Amaz.Macros and Amaz.Macros.EditorSDK then
    --     comp.entity.scene:findEntityBy("bgCamera").visible = false
    -- else
    --     comp.entity.scene:findEntityBy("bgCamera").visible = true
    -- end
end

function SeekModeScript:initKeyFrame(attribute_table, frameRate) 
    self.attrs = AETools:new(attribute_table)
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
end

function SeekModeScript:seek(time)
    self:_adapt_seek(time)
    self:autoPlay(time)
    -- if self.autoplay then
        -- self.progress = math.mod(time/(self.duration+0.0001), 1)
    -- end

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    
    local progress = math.min(self.progress,0.999)
    local tileVal = self.attrs:GetVal("ADBE_Tile_0002_0_0", self.progress)
    self.tileMat:setFloat("u_tileVal", tileVal[1] / 100)
    local distortVal = self.attrs:GetVal("ADBE_WRPMESH_0003_0_2", self.progress)
    self.distortMat:setFloat("u_strength", distortVal[1] / 100)
    local horzBlurVal = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_3", self.progress)
    self.horzBlurMat:setFloat("u_horzR", horzBlurVal[1] / 800 * 100)
    self.horzBlurMat1:setFloat("u_horzR", horzBlurVal[1] / 800 * 10)
    self.horzBlurMat2:setFloat("u_horzR", horzBlurVal[1] / 800 * 2)
    local vertBlurVal = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_4", self.progress)
    self.vertBlurMat:setFloat("u_vertR", vertBlurVal[1] / 200 * 25)
    self.vertBlurMat1:setFloat("u_vertR", vertBlurVal[1] / 200 * 5)
    local exposureVal = self.attrs:GetVal("ADBE_Exposure2_0003_0_5", self.progress)
    self.exposureMat:setFloat("u_Intensity", exposureVal[1])
    local scaleVal = self.attrs:GetVal("ADBE_Scale_0_6", self.progress)
    self.exposureMat:setFloat("u_scale", scaleVal[1] / 100)
    -- Amaz.LOGI("ldrldr", exposureVal[1])
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
