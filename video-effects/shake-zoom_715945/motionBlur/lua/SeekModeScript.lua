local util = nil    ---@class Util

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
   

    local average = diff/duration + 0.0001


    local x1 = info1[2]/100
    local y1 = x1*info1[1]/average
    local x2 = 1-info2[2]/100
    local y2 = 1-(1-x2)*info2[1]/average

   

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

end



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


    

    
-- }
local ae_attribute = {
    ["ADBE_Motion_Blur_0002_0"]={
        [1]={{0, 16.666666667, }, {0, 16.666666667, }, 39.333984375, 0, }, 
		[2]={{0, 33.333333, }, {0, 16.666666667, }, 51, 104.4, }, 
    }, 

    ["ADBE_Exposure2_paopao_0"]={
        [1]={{0, 0.01, }, {-1.70454545454545, 0.01, }, 0, 1.5, }, 
		[2]={{-1.70454545454545, 0.01, }, {0, 0.01, }, 22, 0, }, 

    }, 
    ["ADBE_Exposure2_0003_0"]={
        [1]={{0, 16.666666667, }, {0, 16.666666667, }, 39.333984375, 0, }, 
		[2]={{3.21446509291813, 0.01, }, {0, 0.01, }, 51, 1.5, }, 

    }, 
    -- ["ADBE_Position_0"]={
    --         [1]={{0, 0.01, }, {2629.42873629544, 0.01, }, 0, 120.618789672852, }, 
    --         [2]={{2629.42873629544, 0.01, }, {0, 33.333333, }, 3.384765625, 476.618789672852, }, 
    --         [3]={{0, 33.333333, }, {195.05355712638, 0.01, }, 5.9228515625, 436.618789672852, }, 
    --         [4]={{0, 33.333333, }, {64.0204983908434, 0.01, }, 8.4619140625, 455.618789672852, }, 
    --         [5]={{0, 33.333333, }, {0, 16.666666667, }, 11, 450, }, 
    --         [6]={{0, 33.333333, }, {0, 16.666666667, }, 22, 450, }, 
    -- }, 
	["ADBE_Position_0"]={
        [1]={{0, 16.666666667, }, {0, 16.666666667, }, 34,  450, }, 
		[2]={{0, 33.333333, }, {375, 0.01, }, 42,  423.618789672852, }, 
		[3]={{375, 0.01, }, {0, 0.01, }, 51,  558.618789672852, }, 

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
    self._duration = 2
    self.autoplay = true
    self.width = 0
    self.height = 0
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
    self.sportMaterial = comp.entity.scene:findEntityBy("sport"):getComponent("MeshRenderer").material
    -- self.lightMaterial = comp.entity.scene:findEntityBy("select"):getComponent("MeshRenderer").material
    self.pass0Material = comp.entity.scene:findEntityBy("Pass0"):getComponent("MeshRenderer").material
    self.pass4Material = comp.entity.scene:findEntityBy("Pass4"):getComponent("MeshRenderer").material
    self.horizontalBlurMaterial = comp.entity.scene:findEntityBy("horizontalBlur"):getComponent("MeshRenderer").material
    self.verticalBlurMaterial = comp.entity.scene:findEntityBy("verticalBlur"):getComponent("MeshRenderer").material
    self.pass3Material = comp.entity.scene:findEntityBy("SeekModeScript"):getComponent("MeshRenderer").material
    self.yblurMaterial = comp.entity.scene:findEntityBy("yblur"):getComponent("MeshRenderer").material

    self:initKeyFrame()
    -- local w = Amaz.BuiltinObject:getInputTextureWidth()
    -- local h = Amaz.BuiltinObject:getInputTextureHeight()
    -- self.width = w
    -- self.height = h
    -- self.sportMaterial:setInt("inputWidth", w)
    -- self.sportMaterial:setInt("inputHeight", h)
    -- self.lightMaterial:setInt("inputWidth", w)
    -- self.lightMaterial:setInt("inputHeight", h)
    -- self.selectMaterial:setInt("inputWidth", w)
    -- self.selectMaterial:setInt("inputHeight", h)
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

        -- if self.autoplay then
		-- 	self.curTime = self.curTime + detalTime
		-- 	self.curTime = self.curTime % 3.0
		-- end

        self.blendMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        self.modelMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        -- if self.isAutoPlay then
		-- 	self.curTime = self.curTime + detalTime
		-- 	self.curTime = self.curTime % 3.0
		-- end
        self.lastTime = self.curTime
        self.curTime = self.curTime + detalTime
        -- self:autoPlay(self.curTime)
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


    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.sportMaterial:setInt("inputWidth", self.width)
        self.sportMaterial:setInt("inputHeight", self.height)
        -- self.lightMaterial:setInt("inputWidth", self.width)
        -- self.lightMaterial:setInt("inputHeight", self.height)
        self.verticalBlurMaterial:setInt("inputWidth", self.width)
        self.verticalBlurMaterial:setInt("inputHeight", self.height)
        self.horizontalBlurMaterial:setInt("inputWidth", self.width)
        self.horizontalBlurMaterial:setInt("inputHeight", self.height)
        self.yblurMaterial:setInt("inputWidth", self.width)
        self.yblurMaterial:setInt("inputHeight", self.height)
  
        -- if math.abs(w/(h + 0.0001) - self.width/(self.height + 0.0001)) > 0.001 then
            if w<h then
                self.width=720
                self.height = h/w*720
            else
                self.width = w/h*720
                self.height = 720
            end
            self.pass0Material:setInt("inputWidth",self.width)
            self.pass0Material:setInt("inputHeight",self.height)
            self.pass3Material:setInt("inputWidth",self.width)
            self.pass3Material:setInt("inputHeight",self.height)
         
  
    
            local x = 2.0
            self.pass4Material:setVec2("iResolution", Amaz.Vector2f(self.width/x, self.height/x))
        -- end
    
    end


    local start_p = 0.3
    local e_p = 0.8

    local scale_progress = 0
    local fish_progress = 0
    local blur_progress = 0
    local wave_progress = 0

    local mix = function(a,b,x)
        return a+(b-a)*x
    end

    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    if t>1 then
        t=1
    end
    local progress = util.bezier({0.66,-0.02,0.86,1.})(self.progress, 0, 1, 1) --math.pow(self.progress,2.0)

    local ADBE_Motion_Blur_0002_0 = self.ADBE_Motion_Blur_0002_0:getCurPartVal(self.progress) *0.5---sportblur
    self.sportMaterial:setFloat("blurSize", ADBE_Motion_Blur_0002_0)
    -- yblurMaterial
    self.yblurMaterial:setFloat("blurSize", ADBE_Motion_Blur_0002_0)
    local ADBE_Exposure2_paopao_0_1 = self.ADBE_Exposure2_paopao_0:getCurPartVal(self.progress)
    local ADBE_Exposure2_paopao_0_2 = self.ADBE_Exposure2_paopao_0:getCurPartVal(self.progress)
    ---paopaoblur

    self.pass4Material:setFloat("blurSize",2.235-ADBE_Exposure2_paopao_0_1*1.5)
    self.pass0Material:setFloat("blurSize",0.6-ADBE_Exposure2_paopao_0_1*0.4)
    self.pass3Material:setFloat("blurSize",0.6-ADBE_Exposure2_paopao_0_1*0.4)
    local ADBE_Exposure2_0003_0_1 = self.ADBE_Exposure2_0003_0:getCurPartVal(self.progress)
    self.verticalBlurMaterial:setFloat("lightIns", ADBE_Exposure2_0003_0_1+1.0)--fanguang
    self.verticalBlurMaterial:setFloat("intensity", ADBE_Exposure2_0003_0_1*1.0)--fanguang

    local ADBE_Position_0 = self.ADBE_Position_0:getCurPartVal(self.progress)
    ADBE_Position_0 = ADBE_Position_0/720
    ADBE_Position_0 = ADBE_Position_0 * 2 - 1

   self.yblurMaterial:setVec2("uv_yy", Amaz.Vector2f(360/720 * 2 - 1, ADBE_Position_0))---sport



end


function SeekModeScript:setParams(name, value)
    if name == "u_size" then

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
