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
--@input float curTime = 0.0{"widget":"slider","min":0,"max":68}
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
    ["ADBE_IE_92959d1fb849aa97f8ff858_0001_0_0"]={
        {{0.502891566, 0.092055675, 0.597648415, 1, }, {0, 26, }, {{0, }, {1.4, }, }, }, 
        {{0.525261563, 0, 0.713434526, 1, }, {26, 68, }, {{1.4, }, {0.977528, }, }, }, 
	}, 
	["ADBE_IE_92959d1fb849aa97f8ff858_0004_0_1"]={
        {{0.293193137, 0, 0.68201008, 0.445227877, }, {0, 24, }, {{0, }, {168.955993, }, }, }, 
        {{0.317648491, 0.365510962, 0.579632016, 1, }, {24, 68, }, {{168.955993, }, {640, }, }, }, 
	}, 
	["ADBE_Opacity_1_2"]={
        {{0.33333333, 0.33333333, 0.66666667, 0.66666667, }, {0, 10, }, {{0, }, {0, }, }, }, 
		{{0.414996303, 0, 0.700530378, 1, }, {10, 21, }, {{0, }, {100, }, }, }, 
		-- {{0.253171143, 0, 0.566209896, 1, }, {26, 62, }, {{100, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_Marker_2_3"]={
		{{0.1667, 0.1667, 0.8333, 0.8333, }, {26, 62, }, {{}, {}, }, {6420, }, {2, }, }, 

	}, 
	["ADBE_Time_Remapping_2_4"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {26, 62, }, {{0, }, {0, }, }, {6417, }, {1, }, }, 
	}, 
	["ADBE_Position_2_5"]={
        {{0.76, 0.18, 0.999, 1, }, {0, 20, }, {{540, 540, 0, }, {577.745004615, 540, 0, }, }, }, 
        {{0.001, 0, 0.61, 1, }, {20, 68, }, {{577.745004615, 540, 0, }, {783.786085385, 540, 0, }, }, }, 
	}, 
	["ADBE_Scale_2_6"]={
        {{0.224043954,0.224043954,0.29, 0,0,0.29, 0.855215856,0.855215856,0.52, 0.760385075,0.760385075,0.52, }, {0, 68, }, {{100, 100, 100, }, {139.811235955, 139.811235955, 100, }, }, }, 
	}, 
	["ADBE_Opacity_2_7"]={
        {{0.33333333, 0.33333333, 0.66666667, 0.66666667, }, {0, 10, }, {{100, }, {100, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {10, 30, }, {{100, }, {66, }, }, }, 
	}, 
    ["ADBE_Opacity_2_8"]={

		{{0.33333333, 0, 0.66666667, 1, }, {6, 28, }, {{0.0, }, {0.7, }, }, {6417, }, {0, }, }, 
        {{0.33333333, 0, 0.66666667, 1, }, {28, 42, }, {{0.7, }, {1.2, }, }, {6417, }, {0, }, }, 
        {{0.33333333, 0, 0.66666667, 1, }, {42, 68, }, {{1.2, }, {0.7, }, }, {6417, }, {0, }, }, 

		-- {{0.33333333, 0, 0.66666667, 1, }, {0, 26, }, {{0.7, }, {1.2, }, }, {6417, }, {0, }, }, 
        -- {{0.33333333, 0, 0.66666667, 1, }, {26, 40, }, {{1.2, }, {0.7, }, }, {6417, }, {0, }, }, 
        -- {{0.33333333, 0, 0.66666667, 1, }, {40, 62, }, {{0.7, }, {0.0, }, }, {6417, }, {0, }, }, 
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
            self.curTime= props:get("curTime")/68.
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

    self.size = 0
    self.quantity = 2
    self.complexity = 1
    self.evolution = 0
    self.cycle = 100
    self.offset_x = 0
    self.offset_y = 0
    self.type = 0
    self.fix_type = 0
    self.motion_tile_type = 0
    self.picture_scale = 1
end

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)
    -- self.animSeqCom = comp.entity.scene:findEntityBy("imgMovePass"):getComponent("AnimSeqComponent")
    -- self.resultMaterial = comp.entity.scene:findEntityBy("result"):getComponent("MeshRenderer").material
    -- self.pass0Material = comp.entity.scene:findEntityBy("Pass0"):getComponent("MeshRenderer").material
    -- self.pass3Material = comp.entity.scene:findEntityBy("pass3"):getComponent("MeshRenderer").material
    -- self.pass4Material = comp.entity.scene:findEntityBy("Pass4"):getComponent("MeshRenderer").material
    self.putOriMaterial = comp.entity.scene:findEntityBy("putOri"):getComponent("MeshRenderer").material
    -- self.putOriMaterial:setFloat("flag",1.0)

    -- self.material = comp.entity.scene:findEntityBy("putOri"):getComponent("MeshRenderer").material
    self.material2 = comp.entity.scene:findEntityBy("Video"):getComponent("MeshRenderer").material

    self.animVideoCom = comp.entity.scene:findEntityBy("putOri"):getComponent("VideoAnimSeq")
    self.animVideoCom2 = comp.entity.scene:findEntityBy("Video"):getComponent("VideoAnimSeq")

    self.Turbulence = comp.entity.scene:findEntityBy("TurbulenceDisplacement_220-effect0"):getComponent("ScriptComponent").properties

    self.LumiLayerBlend_326 = comp.entity.scene:findEntityBy("LumiLayerBlend_326-blend"):getComponent("ScriptComponent").properties
    self.transform = comp.entity.scene:findEntityBy("AE_Transform_324-trs"):getComponent("ScriptComponent").properties
    self.transform2 = comp.entity.scene:findEntityBy("AE_Transform_326-trs"):getComponent("ScriptComponent").properties 
    self.PaoPaoBlur = comp.entity.scene:findEntityBy("PaoPaoBlur"):getComponent("ScriptComponent").properties 
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

    -- local w = Amaz.BuiltinObject:getInputTextureWidth()
    -- local h = Amaz.BuiltinObject:getInputTextureHeight()
    -- if w ~= self.width or h ~= self.height then
    --     self.width = w
    --     self.height = h
 
    -- end


    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    AEprogress = t
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if math.abs(w/(h + 0.0001) - self.width/(self.height + 0.0001)) > 0.001 then
        if w<h then
            self.width=720
            self.height = h/w*720
        else
            self.width = w/h*720
            self.height = 720
        end
    --     -- self.width = w
    --     -- self.height = h
    --     self.pass0Material:setInt("inputWidth",self.width)
    --     self.pass0Material:setInt("inputHeight",self.height)
    --     self.pass3Material:setInt("inputWidth",self.width)
    --     self.pass3Material:setInt("inputHeight",self.height)
    --     local x = 2.0
    --     self.pass4Material:setVec2("iResolution", Amaz.Vector2f(self.width/x, self.height/x))
    end

    -- local w2 = Amaz.BuiltinObject:getOutputTextureWidth()
    -- local h2 = Amaz.BuiltinObject:getOutputTextureHeight()
    -- self.width = w2
    -- self.height = h2
    local ins =  self.attrs:GetVal("ADBE_Opacity_2_8", AEprogress)[1]
    -- self.putOriMaterial:setFloat("flag",1.0)
    self.PaoPaoBlur:set("intensity",ins)
    self.speed1 = self.putOriMaterial:getFloat("speed")
    self.speed2 = self.material2:getFloat("speed")


    if Amaz.Macros and Amaz.Macros.EditorSDK then
    else
        self.animVideoCom.enableFixedSeekMode = true
        self.animVideoCom2.enableFixedSeekMode = true
    end
    fps = AEprogress*68

    if fps < 10. then
        self.putOriMaterial:setFloat("true_1",0.)
    else
        self.putOriMaterial:setFloat("true_1",1.)
    end

    if fps < 66.5 then
        self.material2:setFloat("true_1",0.)
    else
        self.material2:setFloat("true_1",1.)
    end
    -- Amaz.LOGI()

    self.animVideoCom:seek(math.max(0,fps-10.))
    self.animVideoCom2:seek(fps)

    self.material2:setFloat("width",self.width)
    self.material2:setFloat("height",self.height)
    self.putOriMaterial:setFloat("width",self.width)
    self.putOriMaterial:setFloat("height",self.height)

    -- Amaz.LOGI("22",self.width)
    local size1 = self.attrs:GetVal("ADBE_IE_92959d1fb849aa97f8ff858_0001_0_0", AEprogress)[1]/100.
    local evolution = self.attrs:GetVal("ADBE_IE_92959d1fb849aa97f8ff858_0004_0_1", AEprogress)[1]

    
    self.Turbulence:set("size",size1)
    self.Turbulence:set("evolution",evolution)

    local Opacity = self.attrs:GetVal("ADBE_Opacity_1_2", AEprogress)[1]
    self.LumiLayerBlend_326:set("sourceOpacity",Opacity)


    local pos_x = self.attrs:GetVal("ADBE_Position_2_5", AEprogress)[1]
    local pos_y = self.attrs:GetVal("ADBE_Position_2_5", AEprogress)[2]

    local sca_x = self.attrs:GetVal("ADBE_Scale_2_6", AEprogress)[1]
    local sca_y = self.attrs:GetVal("ADBE_Scale_2_6", AEprogress)[2]

    local Opacity2 = self.attrs:GetVal("ADBE_Opacity_2_7", AEprogress)[1]
    self.transform:set("position",Amaz.Vector3f(pos_x,pos_y,0.))
    self.transform:set("scale",Amaz.Vector3f(sca_x,sca_y,0.))
    self.transform:set("opacity",math.min(Opacity2*1.1,100.))

    self.transform2:set("opacity",Opacity)
    -- local evolution = self.attrs:GetVal("ADBE_IE_92959d1fb849aa97f8ff858_0004_0_1", AEprogress)[1]
    -- self.resultMaterial:setFloat("iTime",t)
    
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
