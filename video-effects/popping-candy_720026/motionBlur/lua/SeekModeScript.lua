      
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
    local diff = val2-val1
    if(math.abs(diff) < 0.001) then return val2 end

    local average = diff/duration + 0.0001
    -- local xas = 124/duration
    -- local yas = -8/duration
    -- average = math.sqrt(xas*xas+yas*yas)

    local x1 = info1[2]/100
    local y1 = x1*info1[1]/average
    local x2 = 1-info2[2]/100
    local y2 = 1-(1-x2)*info2[1]/average

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
            -- Amaz.LOGI("============= lrc frame1 ", i.." =============")
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
--@input float curTime = 0.0{"widget":"slider","min":0,"max":1}
local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.width = 0
    self.height = 0
    self.GlowRange = 100
    
    return self
end
local ae_attribute = {
	["ADBE_Slider_Control_0001_0_0"]={
		[1]={{0, 33.333333, }, {-32.6218164564699, 22.8212373102264, }, 15, 100, }, 
		[2]={{-4.76077427551745, 70.5482857072906, }, {0, 33.333333, }, 25, 300, }, 
        [3]={{-4.76077427551745, 70.5482857072906, }, {0, 33.333333, }, 32, 300, }, 
	},
    ["ADBE_Position_1_0_2"]={
		[1]={{0, 33.333333, }, {-10351.5285827637, 3.75, }, 15, 640, }, 
		[2]={{0, 53.600774868782, }, {0, 50.899658203125, }, 23, 478, }, 
		[3]={{4264.33029889287, 3.75, }, {0, 10, }, 31, 540, }, 
		[4]={{0, 19.7909192884521, }, {0, 33.333333, }, 32, 540, }, 
	}, 
    ["ADBE_Displacement_Map_0003_0_0"]={
		[1]={{0, 42, }, {0, 0.1, }, 15, 10, }, 
		[2]={{0, 32, }, {16.0714285714286, 24, }, 22, -7, }, 
		[3]={{0, 50, }, {0, 16.666666667, }, 28, 0, }, 
        [4]={{0, 50, }, {0, 16.666666667, }, 32, 0, }, 
	}, 
	["ADBE_Displacement_Map_0005_0_1"]={
		[1]={{0, 42, }, {0, 0.1, }, 15, -80, }, 
		[2]={{0, 32, }, {-16.0714285714286, 24, }, 21, 21, }, 
		[3]={{0, 50, }, {0, 16.666666667, }, 28, 0, }, 
        [4]={{0, 50, }, {0, 16.666666667, }, 32, 0, }, 
	}, 
    ["ADBE_Displacement2_Map_0003_0_0"]={
		[1]={{0, 42, }, {0, 0.1, }, 15, 3, }, 
		[2]={{0, 32, }, {6.06617647058823, 34, }, 25, -5, }, 
		[3]={{0, 37, }, {0, 16.666666667, }, 32, 0, }, 
	}, 
	["ADBE_Displacement2_Map_0005_0_1"]={
		[1]={{0, 42, }, {0, 0.1, }, 15, -15, }, 
		[2]={{0, 32, }, {-16.1764705882353, 34, }, 24, 15, }, 
		[3]={{0, 37, }, {0, 16.666666667, }, 32, 0, }, 
	}, 
    ["ADBE_Gaussian_Blur_2_0001_0_0"]={
		-- [1]={{0, 50, }, {0, 0.1, }, 15, 77, }, 
		-- [2]={{0, 50, }, {0, 16.666666667, }, 21, 0, }, 
        -- [1]={{0, 33.333333, }, {-551.27754837355, 18.1936340177612, }, 15, 77, }, 
		-- [2]={{-96.2694094041786, 63.8498680437164, }, {0, 33.333333, }, 21, 0, }, 
        [1]={{0, 50, }, {0, 0.1, }, 15, 77, }, 
		[2]={{0, 50, }, {0, 16.666666667, }, 21, 0, }, 
		[3]={{0, 50, }, {0, 16.666666667, }, 32, 0, }, 
	}, 
}
function SeekModeScript:initKeyFrame() 
    for _name, info_list in pairs(ae_attribute) do
        local tool = AETools:new(30)
        for i = 1, #info_list do
            tool:addKeyFrameInfo(info_list[i][1], info_list[i][2], info_list[i][3], info_list[i][4])
        end
        self[_name] = tool
    end
end
function SeekModeScript:constructor()

end

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
local function mix(a,b,x)
	return a+(b-a)*x
end
local function clamp(x,a,b)
    if x<a then
        x=a
    elseif x>b then
        x=b
    end
    return x
end
if Amaz.Macros and Amaz.Macros.EditorSDK then
    function SeekModeScript:onUpdate(comp, detalTime)
        --ceshiyong
        local props = comp.entity:getComponent("ScriptComponent").properties
        
        -- shijiyong
        self.curTime=self.curTime + detalTime
        if props:has("curTime") then
            -- self.curTime= props:get("curTime")
        end
        self:seek(self.curTime - self.startTime)
    end
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
    self.animSeqCom = comp.entity.scene:findEntityBy("lasiPass"):getComponent("AnimSeqComponent")
    self.material = comp.entity.scene:findEntityBy("SeekModeScript"):getComponent("MeshRenderer").material
    self.material2 = comp.entity.scene:findEntityBy("SeekModeScript_2"):getComponent("MeshRenderer").material
    self.lasiMaterial = comp.entity.scene:findEntityBy("lasiPass"):getComponent("MeshRenderer").material
    -- self.rgbMaterial = comp.entity.scene:findEntityBy("RGBpass"):getComponent("MeshRenderer").material
    -- self.blurYMaterial = comp.entity.scene:findEntityBy("blurYpass"):getComponent("MeshRenderer").material
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    self.width = w
    self.height = h
    self.material:setFloat("baseTexWidth", w)
    self.material:setFloat("baseTexHeight", h)
    self.material2:setFloat("baseTexWidth", w)
    self.material2:setFloat("baseTexHeight", h)
    self:initKeyFrame()
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
    self.material:setFloat("uTime", time)
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.material:setFloat("baseTexWidth", w)
        self.material:setFloat("baseTexHeight", h)
        self.material2:setFloat("baseTexWidth", w)
        self.material2:setFloat("baseTexHeight", h)
    end
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("blurSize") then
    --     self.GlowRange = props:get("blurSize")
    -- end
    -- self.lasiMaterial:setFloat("ins", props:get("ins"))
    -- self.lasiMaterial:setFloat("centerX", props:get("centerX"))
    -- local controls = {0.21,-0.46,0.33,0.45}

    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    if t>1 then
        t=1
    end
    if self.duration<0.566 then
        self.animSeqCom:seek(t*57)
    else
        
        self.animSeqCom:seek(math.min(time*57,56.999))
    end
    local AEProgress = (t*17+15)/32
    -- Amaz.LOGI("AEProgress",(t*19+15))
    local noiseScale = self.ADBE_Slider_Control_0001_0_0:getCurPartVal(AEProgress)/100
    self.lasiMaterial:setFloat("noiseScale", noiseScale)
    
    local imgMove = self.ADBE_Position_1_0_2:getCurPartVal(AEProgress)-540
    self.lasiMaterial:setFloat("imgMove", imgMove)
    -- Amaz.LOGI("AEProgress",imgMove+540)
    -- Amaz.LOGI("imgMove",imgMove)
    -- self.lasiMaterial:setFloat("iTime", time)
    
    local noiseX = self.ADBE_Displacement_Map_0003_0_0:getCurPartVal(AEProgress)
    self.lasiMaterial:setFloat("noiseX", noiseX)
    -- Amaz.LOGI("noiseX",noiseX)
    local noiseY = self.ADBE_Displacement_Map_0005_0_1:getCurPartVal(AEProgress)
    self.lasiMaterial:setFloat("noiseY", noiseY)
    -- Amaz.LOGI("noiseY",noiseY)
    local noiseX2 = self.ADBE_Displacement2_Map_0003_0_0:getCurPartVal(AEProgress)
    self.lasiMaterial:setFloat("noiseX2", noiseX2)
    -- Amaz.LOGI("noiseX2",noiseX2)

    local noiseY2 = self.ADBE_Displacement2_Map_0005_0_1:getCurPartVal(AEProgress)
    self.lasiMaterial:setFloat("noiseY2", noiseY2)
    -- Amaz.LOGI("noiseY2",noiseY2)

    local blurIns = self.ADBE_Gaussian_Blur_2_0001_0_0:getCurPartVal(AEProgress)/77
    -- Amaz.LOGI("blurIns",blurIns*77)
    self.material:setFloat("blurIns", blurIns)
    self.material2:setFloat("blurIns", blurIns)
    -- -- Amaz.LOGI("asdasd",t)
    -- local tvalue = getBezierTfromX(controls, t)
    -- local value = getBezierValue(controls, tvalue)[2]
    -- value=clamp(value,0.0,1.0)
    -- value=value*value*value
    -- -- self.lasiMaterial:setFloat("offset",0.03*(1.0-t))
    -- -- self.lasiMaterial:setFloat("ins", value*1.0+0.00)
    -- -- self.lasiMaterial:setFloat("centerX", 0.5-t*0.5)
    -- -- self.rgbMaterial:setFloat("RGBins",(1.0-t)*20.)
    -- -- self.blurYMaterial:setFloat("y_index",1.5*(1.0-value))
    -- self.GlowRange = 75*(1.0-t)
    -- if value<0.05 then
    --     self.GlowRange=25*(1.0-t)
    -- end
    -- local range = math.abs(self.GlowRange)
    -- local myrange1 = math.ceil(math.sqrt(range))
    -- if myrange1 == 0 then
    --     myrange1 = 0.5
    -- end
    -- local y_index =range/myrange1
    -- local myrange2 = math.ceil(y_index)
    -- self.material:setFloat("GlowRange",myrange1)
    -- -- Amaz.LOGI("myrange1",myrange1)
    -- self.material:setFloat("y_indez", y_index)
    -- self.material2:setFloat("GlowRange",myrange2) 
    
    -- Amaz.LOGI("myrange2",myrange2)
end

-- function SeekModeScript:onEvent(sys, event)
--     if("effects_adjust_horizontal_shift" == event.args:get(0)) then
--         local intensity = event.args:get(1)
--         self.GlowRange = intensity*200.0
--         if self.GlowRange > 100 then
--             self.material:enableMacro('RightBlur', 1)
--             self.material2:enableMacro('RightBlur2', 1)
--         else
--             self.material:disableMacro('RightBlur')
--             self.material2:disableMacro('RightBlur2')
--         end
--         local range = math.abs(self.GlowRange-100)
--         local myrange1 = math.ceil(math.sqrt(range))
--         if myrange1 == 0 then
--             myrange1 = 0.5
--         end
--         local y_index =range/myrange1
--         local myrange2 = math.ceil(y_index)
--         self.material:setFloat("GlowRange",myrange1)
--         self.material:setFloat("y_indez", y_index)
--         self.material2:setFloat("GlowRange",myrange2) 
--     end

--     if("effects_adjust_intensity" == event.args:get(0)) then
--         local intensity = event.args:get(1)
--         self.material2:setFloat("alpha", intensity)
--     end
-- end

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
