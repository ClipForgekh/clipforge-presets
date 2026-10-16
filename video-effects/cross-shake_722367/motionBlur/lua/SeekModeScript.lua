local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
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
	["ADBE_Motion_Blur_0001_0_0"]={
		{{0.001, 1, 0, 1, }, {1, 2, }, {{40, }, {-40, }, }, }, 
		{{0.001, 1, 0, 1, }, {2, 3, }, {{-40, }, {15, }, }, }, 
		{{0.001, 1, 0, 1, }, {3, 4, }, {{15, }, {40, }, }, }, 
		{{0.001, 1, 0, 1, }, {4, 6, }, {{40, }, {-45, }, }, }, 
		{{0.001, 1.5, 0, 1, }, {6, 9, }, {{-45, }, {45, }, }, }, 
       
	}, 
	["ADBE_Motion_Blur_0002_0_1"]={
		{{0.166666667, 0.166666667, 0.833343045, 1.003214943, }, {0, 2, }, {{120, }, {222, }, }, }, 
		{{0.79232548, 0.010832935, 0.999, 1, }, {2, 3, }, {{222, }, {150.042258, }, }, }, 
		{{0.001877556, 0, 0.194399629, 0.752562125, }, {3, 4, }, {{150.042258, }, {123.001275, }, }, }, 
		{{0.660248863, 0.053773292, 0.643128052, 0.737041447, }, {4, 5, }, {{123.001275, }, {32.818027, }, }, }, 
		{{0.3, 0.53355858, 0.623951977, 1, }, {5, 6, }, {{32.818027, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 1, }, {6, 7, }, {{0, }, {12, }, }, }, 
		{{0.379389541, 0, 0.784212692, 0.407918493, }, {7, 9, }, {{12, }, {0, }, }, }, 
	}, 
	["ADBE_Exposure2_0003_0_2"]={
		{{0.001, 0, 0.2, 1, }, {0, 14, }, {{4, }, {0, }, }, }, 
	}, 
	["ADBE_Position_0_3"]={
		{{0.42, 0, 0.58, 1, }, {0, 1, }, {{112, 570, 0, }, {376, 304, 0, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {1, 2, }, {{376, 304, 0, }, {663, 616, 0, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {2, 3, }, {{663, 616, 0, }, {736, 214, 0, }, }, }, 
		{{0.153334, 0, 0.846666, 1, }, {3, 4, }, {{736, 214, 0, }, {485.071426392, 522.285720825, 0, }, }, }, 
		{{0.42, 0, 0.726246, 0.948636, }, {4, 6, }, {{485.071426392, 522.285720825, 0, }, {523.547374073, 554.573308314, 0, }, }, }, 
		{{0.001, 0, 0.5, 1, }, {6, 9, }, {{523.547374073, 554.573308314, 0, }, {545.758926392, 531.589279175, 0, }, }, }, 
		{{0.3, 0, 0.45, 1, }, {9, 14, }, {{545.758926392, 531.589279175, 0, }, {545.732147217, 544.508926392, 0, }, }, }, 
		{{0.3, 0, 0.45, 1, }, {14, 20, }, {{545.732147217, 544.508926392, 0, }, {541.883928571, 538, 0, }, }, }, 
		{{0.3, 0, 0.45, 1, }, {20, 25, }, {{541.883928571, 538, 0, }, {540, 540, 0, }, }, }, 
	}, 
	["ADBE_Rotate_Z_0_4"]={
		{{0.361378217, 0.346067437, 0.58, 1, }, {0, 3, }, {{7.672143, }, {-3, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {3, 6, }, {{-3, }, {2.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {6, 10, }, {{2.5, }, {-0.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {10, 16, }, {{-0.5, }, {0.2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {16, 22, }, {{0.2, }, {-0.1, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {22, 25, }, {{-0.1, }, {0, }, }, }, 
	}, 
}

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
        if props:has("curTime") and isEditor then
            self.curTime= props:get("curTime")
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
    -- local w = Amaz.BuiltinObject:getInputTextureWidth()
    -- local h = Amaz.BuiltinObject:getInputTextureHeight()
    -- self.width = w
    -- self.height = h
    -- self.material:setFloat("baseTexWidth", w)
    -- self.material:setFloat("baseTexHeight", h)
    -- self.material2:setFloat("baseTexWidth", w)
    -- self.material2:setFloat("baseTexHeight", h)
    
    self.attrs = AETools:new(ae_attribute)
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
        self.lasiMaterial:setFloat("baseTexWidth", w)
        self.lasiMaterial:setFloat("baseTexHeight", h)
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
    local AEProgress = t
    -- Amaz.LOGI("AEProgress",(AEProgress*25))
    
    local rotAngle = self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]/180*3.14159
    self.lasiMaterial:setFloat("rotAngle", rotAngle)
    self.material:setFloat("rotAngle", -rotAngle)
    self.material2:setFloat("rotAngle", -rotAngle)


    Amaz.LOGI("AEProgress",(AEProgress*25))
    local posX = self.attrs:GetVal("ADBE_Position_0_3", AEProgress)[1]-540
    local posY = self.attrs:GetVal("ADBE_Position_0_3", AEProgress)[2]-540
    self.lasiMaterial:setFloat("posX", posX)
    self.lasiMaterial:setFloat("posY", posY)
    Amaz.LOGI("posX",posX+540)
    Amaz.LOGI("posY",posY+540)
    Amaz.LOGI("rot",self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1])


    local blurIns = self.attrs:GetVal("ADBE_Motion_Blur_0002_0_1", AEProgress)[1]/60
    self.material:setFloat("blurIns", blurIns)
    self.material2:setFloat("blurIns", blurIns)


    local blurAngle = self.attrs:GetVal("ADBE_Motion_Blur_0001_0_0", AEProgress)[1]/180*3.14159
    self.material:setFloat("blurAngle", -blurAngle)
    self.material2:setFloat("blurAngle", -blurAngle)

    local lightIns = self.attrs:GetVal("ADBE_Exposure2_0003_0_2", AEProgress)[1]
    self.material2:setFloat("lightIns", lightIns)
    -- Amaz.LOGI("rot",self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1])
    -- self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]
    -- local midMove = (self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]-500)/1000
    -- self.lasiMaterial:setFloat("midMove", midMove)

    -- local bottomMove = (self.attrs:GetVal("ADBE_Position_0_bottom", AEProgress)[1]-500)/1000
    -- self.lasiMaterial:setFloat("bottomMove", bottomMove)

    -- local topMove = (self.attrs:GetVal("ADBE_Position_0_top", AEProgress)[1]-500)/1000
    -- self.lasiMaterial:setFloat("topMove", topMove)
    
    -- Amaz.LOGI("asdasd",self.attrs:GetVal("ADBE_Position_0_bottom", AEProgress)[1])
    -- Amaz.LOGI("progress",t*12)
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
