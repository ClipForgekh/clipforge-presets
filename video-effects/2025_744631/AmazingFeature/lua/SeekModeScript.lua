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
--@input float curTime = 0.0
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
            self.curTime= props:get("curTime")/27.
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

local ae_attribute = {
	-- ["ADBE_Gaussian_Blur_2_0001_0_0"]={
	-- 	{{0.001, 0, 0.58, 1, }, {0, 9, }, {{555, }, {44, }, }, }, 
	-- 	{{0.415547418, 0, 0.66666667, 1, }, {9, 15, }, {{44, }, {88, }, }, }, 
	-- 	{{0.442868786, 0, 0.721730456, 1, }, {15, 24, }, {{88, }, {0, }, }, }, 
	-- }, 
	["ADBE_Position_0_1"]={
		{{0.42, 0, 0.58, 1, }, {5, 18, }, {{540, 540, 0, }, {662, 540, 0, }, }, }, 
		{{0.5, 0, 0.999, 1, }, {18, 26.5, }, {{662, 540, 0, }, {-472, 540, 0, }, }, }, 
	}, 
	["ADBE_Scale_0_2"]={
		{{0.3,0.3,0.3, 0,0,0.3, 0.52,0.52,0.52, 1,1,0.52, }, {0, 12, }, {{64, 72, 100, }, {76, 82, 100, }, }, }, 
		{{0.4,0.4,0.4, 0,0,0.4, 0.53,0.53,0.53, 1,1,0.53, }, {12, 27, }, {{76, 82, 100, }, {55, 54, 100, }, }, }, 
	}, 
	["ADBE_Scale_1_3"]={
        {{0.54,0.54,0.54, 0,0.54,0.54, 0.69,0.69,0.69, 1,0.69,0.69, }, {15, 23, }, {{130, 210, 100, }, {160, 210, 100, }, }, }, 
	}, 
	["ADBE_Opacity_1_4"]={
        {{0.42, 0, 0.58, 1, }, {15, 23, }, {{0, }, {40, }, }, }, 
	}, 
    ["ADBE_Gaussian_Blur_2_0001_0_2"]={
        {{0.228694197, 0, 0.483766241, 1, }, {0, 5, }, {{0, }, {20, }, }, }, 
		{{0.33333333, 0, 0.598107782, 1, }, {5, 27, }, {{20, }, {80, }, }, }, 

	}, 
    ["ADBE_Gaussian_Blur_3_3"]={
        {{0.228694197, 0, 0.483766241, 1, }, {0, 5, }, {{0, }, {1, }, }, }, 
		{{0.33333333, 0, 0.598107782, 1, }, {5, 27, }, {{1, }, {1.5, }, }, }, 
		
	}, 
    ["ADBE_Position_0_2"]={
		{{0.42, 0, 0.58, 1, }, {0, 5, }, {{540, 540, 0, }, {505, 540, 0, }, }, }, 
		{{0.29, 0, 0.39, 0.711768, }, {5, 25, }, {{505, 540, 0, }, {1317.327604884, 540, 0, }, }, }, 
		{{0.296913, 0.666435, 0.662746, 0.656673, }, {25, 26, }, {{1317.327604884, 540, 0, }, {1342.931875196, 540, 0, }, }, }, 
		{{0.150245, 1, 0.995497, 1, }, {26, 27, }, {{1342.931875196, 540, 0, }, {1346.848053194, 540, 0, }, }, }, 
	}, 
    ["ADBE_Gaussian_Blur_2_0001_0_3"]={
		{{0.42, 0, 0.71, 1, }, {0, 20, }, {{0, }, {50, }, }, }, 
        
	}, 
    ["PEDG_0001_0_2"]={
		{{0.42, 0, 0.75, 1, }, {10, 11, }, {{0.34, }, {0.45, }, }, }, 
	}, 
    ["PEDG_0001_0_1"]={
		{{0.209100834, 0, 0.58, 1, }, {2, 8, }, {{0, }, {222, }, }, }, 
	}, 
	["PEDG_0002_0_2"]={
		{{0.343097578, 0, 0.558768935, 0.754312357, }, {2, 9, }, {{0, }, {0.371629, }, }, }, 
		{{1, 0.176577254, 0.85, 1, }, {9, 11, }, {{0.371629, }, {0.45, }, }, }, 
		{{0.164996729, 0, 0.703306035, 0.874340188, }, {11, 14, }, {{0.45, }, {0.37, }, }, }, 
		{{0.344438166, 0.194508102, 0.555795956, 1, }, {14, 19, }, {{0.37, }, {0.35, }, }, }, 
        {{0.344438166, 0.194508102, 0.555795956, 1, }, {19, 24, }, {{0.35, }, {0.28, }, }, }, 
	}, 
    ["ADBE_Position_1_1"]={
		{{0.6, 0, 0.999, 1, }, {0, 20, }, {{540, 540, 0, }, {733, 540, 0, }, }, }, 
	}, 
	["ADBE_Scale_1_2"]={
		{{1,1,1, 0,0,1, 0.999,0.999,0.999, 1,1,0.999, }, {0, 20, }, {{100, 100, 100, }, {85, 80, 100, }, }, }, 
	}, 
	["ADBE_Opacity_1_3"]={
		{{0.440309544, 0, 0.500332735, 0.586074082, }, {0, 19, }, {{100, }, {10, }, }, }, 
        {{0.440309544, 0, 0.500332735, 0.586074082, }, {19, 20, }, {{0, }, {0, }, }, }, 
	}, 
    ["ADBE_Opacity_3_3"]={
		{{0.415547418, 0, 0.66666667, 1,  }, {0, 20, }, {{100, }, {100, }, }, }, 
        -- {{0.415547418, 0, 0.66666667, 1, }, {20, 27, }, {{100, }, {100, }, }, },
	}, 
    ["ADBE_Gaussian_Blur_2_0001_0_0"]={
        {{0.001, 0, 0.58, 1,}, {10, 18, }, {{0, }, {7, }, }, }, 
        {{0.001, 0, 0.58, 1,}, {18, 21, }, {{7, }, {19, }, }, }, 
        {{0.001, 0, 0.58, 1,}, {21, 23, }, {{20, }, {40, }, }, }, 
        {{0.001, 0, 0.58, 1,}, {23, 25, }, {{40, }, {45, }, }, }, 
        {{0.001, 0, 0.58, 1,}, {25, 27, }, {{45, }, {50, }, }, }, 

        -- {{0.001, 0, 0.58, 1, }, {0, 2, }, {{50, }, {45, }, }, }, 
        -- {{0.001, 0, 0.58, 1, }, {2, 4, }, {{45, }, {40, }, }, }, 
        -- {{0.001, 0, 0.58, 1, }, {4, 6, }, {{40, }, {30, }, }, }, 
        -- {{0.001, 0, 0.58, 1, }, {6, 9, }, {{30, }, {7, }, }, }, 
		-- {{0.001, 0, 0.58, 1,}, {9, 17, }, {{7, }, {0, }, }, }, 
	}, 
    ["ADBE_Gaussian_Blur_3"]={
        {{0.001, 0, 0.58, 1, }, {10, 18, }, {{1, }, {1.5, }, }, }, 
        {{0.001, 0, 0.58, 1, }, {18, 27, }, {{1.5, }, {3, }, }, }, 
        
		-- {{0.415547418, 0, 0.66666667, 1, }, {9, 15, }, {{1, }, {1.5, }, }, }, 
		-- {{0.442868786, 0, 0.721730456, 1, }, {18, 25, }, {{2, }, {3, }, }, }, 
	}, 
	["ADBE_IE_5a1ff1b7caffac514aaba44-0001_0_1"]={
		{{0.232727035, 0, 0.811672376, 0.613026883, }, {0, 9, }, {{0, }, {2, }, }, }, 
		{{0.870136461, 0.366853896, 0.85, 1, }, {9, 11, }, {{2, }, {2.8, }, }, }, 
		{{0.123895168, 0, 0.449775937, 0.658855431, }, {11, 14, }, {{2.8, }, {2, }, }, }, 
		{{0.200427914, 0.553317891, 0.678259363, 0.841499869, }, {14, 27, }, {{2, }, {0.4, }, }, }, 
	}, 
   
}

	

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)
    self.attrs = AETools:new(ae_attribute)
    self.Gaussian_Blur = comp.entity.scene:findEntityBy("Gaussian_Blur_Root"):getComponent("ScriptComponent").properties
    self.Gaussian_Blur2= comp.entity.scene:findEntityBy("Gaussian_Blur_Root2"):getComponent("ScriptComponent").properties
    self.Gaussian_Blur3= comp.entity.scene:findEntityBy("Gaussian_Blur_Root3"):getComponent("ScriptComponent").properties
    self.Gaussian_Blur2_mat= comp.entity.scene:findEntityBy("Gaussian_Blur_Root2"):searchEntity("Horizontal_Blur"):getComponent("MeshRenderer").material
    self.aetransform = comp.entity.scene:findEntityBy("AE_Transform_91-trs"):getComponent("ScriptComponent").properties
    self.aetransform2 = comp.entity.scene:findEntityBy("AE_Transform_92"):getComponent("ScriptComponent").properties
    self.Deep_Glow_Root = comp.entity.scene:findEntityBy("Deep_Glow_Root_1"):getComponent("ScriptComponent").properties
    self.aetransform3 = comp.entity.scene:findEntityBy("AE_Transform_136-trs"):getComponent("ScriptComponent").properties
    self.Exposure = comp.entity.scene:findEntityBy("Exposure_Root_91-effect2"):getComponent("ScriptComponent").properties
    self.dtpt = comp.entity.scene:findEntityBy("dtpt"):getComponent("MeshRenderer").material
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

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
    end
    
    local w_h = self.width/self.height
    local h_w = self.height/self.width

    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)

    AEprogress = t
    f = 1./27.
    local intensity = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_0", AEprogress)[1]
    local steps = self.attrs:GetVal("ADBE_Gaussian_Blur_3", AEprogress)[1]
    self.Gaussian_Blur:set("intensity",intensity)
    self.Gaussian_Blur:set("steps",steps)

    local position1_x = self.attrs:GetVal("ADBE_Position_0_1", AEprogress)[1]
    local position1_y = self.attrs:GetVal("ADBE_Position_0_1", AEprogress)[2]
    self.aetransform:set("position",Amaz.Vector3f(position1_x,position1_y,0))

    Amaz.LOGI("xxxx",position1_x)


    local Scale1_x = self.attrs:GetVal("ADBE_Scale_0_2", AEprogress)[1]*2.3
    local Scale1_y = self.attrs:GetVal("ADBE_Scale_0_2", AEprogress)[2]*1.2
    
    local opacity3_3 = self.attrs:GetVal("ADBE_Opacity_3_3", AEprogress)[1]
    

    local Scale2_x = self.attrs:GetVal("ADBE_Scale_1_3", AEprogress)[1]/3.
    local Scale2_y = self.attrs:GetVal("ADBE_Scale_1_3", AEprogress)[2]/10.
   

    if self.height <= self.width then
        if w_h >=16./9. then
            Scale1_y = Scale1_y*w_h*(16./10.)/w_h
            Scale2_y = Scale2_y*w_h*(16./10.)/w_h
            
            Scale1_x = Scale1_x*(16./10.)/w_h
            Scale2_x = Scale2_x*(16./10.)/w_h
        else
            Scale1_y = Scale1_y*w_h
            Scale2_y = Scale2_y*w_h
        end
        -- Scale1_y = Scale1_y*w_h
        -- Scale2_y = Scale2_y*w_h
    else
        if h_w >=16./9. then
            Scale1_x = Scale1_x*h_w*(16./10.)/h_w
            Scale2_x = Scale2_x*h_w*(16./10.)/h_w
            
            Scale1_y = Scale1_y*(16./10.)/h_w
            Scale2_y = Scale2_y*(16./10.)/h_w
        else
            Scale1_x = Scale1_x*h_w
            Scale2_x = Scale2_x*h_w
        end
        -- Scale1_x = Scale1_x*h_w
        -- Scale2_x = Scale2_x*h_w
    end

    -- Amaz.LOGI("w_h",self.width/self.height)
    -- Amaz.LOGI("w_h",self.width)
    -- Amaz.LOGI("w_h",self.height)


    self.aetransform:set("scale",Amaz.Vector3f(Scale1_x/3.35,Scale1_y/4.9,0))
    self.aetransform:set("opacity",opacity3_3)
    self.aetransform2:set("scale",Amaz.Vector3f(Scale2_x*1.49,Scale2_y*1.27,0))

    local opacity2_x = self.attrs:GetVal("ADBE_Opacity_1_4", AEprogress)[1]
    local position3_x = self.attrs:GetVal("ADBE_Position_0_1", math.max(0,AEprogress-0.75*f))[1]
    local position3_y = self.attrs:GetVal("ADBE_Position_0_1", math.max(0,AEprogress-0.75*f))[2]
    self.aetransform2:set("position",Amaz.Vector3f(position3_x,position3_y,0))

    self.aetransform2:set("opacity",opacity2_x)

    local intensity2 = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_2", AEprogress)[1]
    local steps2 = self.attrs:GetVal("ADBE_Gaussian_Blur_3_3", AEprogress)[1]
    -- Amaz.LOGI("intensity2",intensity2)
    -- Amaz.LOGI("steps2",steps2)
    self.Gaussian_Blur2:set("intensity",intensity2)
    self.Gaussian_Blur2:set("steps",steps2)
    local position2_x = self.attrs:GetVal("ADBE_Position_0_2", AEprogress)[1]
    local position2_y = self.attrs:GetVal("ADBE_Position_0_2", AEprogress)[2]
    self.dtpt:setVec2("pos1",Amaz.Vector2f(position2_x,position2_y))


    local intensity3 = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_3", AEprogress)[1]/2
    self.Gaussian_Blur3:set("intensity",intensity3)

    local glow_intensity = self.attrs:GetVal("PEDG_0002_0_2", AEprogress)[1]
    local radius = self.attrs:GetVal("PEDG_0001_0_1", AEprogress)[1]
    local radius1 = self.attrs:GetVal("PEDG_0001_0_2", AEprogress)[1]
    self.Deep_Glow_Root:set("glow_intensity",glow_intensity*0.40)
    self.Deep_Glow_Root:set("radius",radius*radius1)
    Amaz.LOGI("glow",glow_intensity)

    local position3_x = self.attrs:GetVal("ADBE_Position_1_1", AEprogress)[1]
    local position3_y = self.attrs:GetVal("ADBE_Position_1_1", AEprogress)[2]
    local Scale3_x = self.attrs:GetVal("ADBE_Scale_1_2", AEprogress)[1]
    local Scale3_y = self.attrs:GetVal("ADBE_Scale_1_2", AEprogress)[2]
    local opacity3_x = self.attrs:GetVal("ADBE_Opacity_1_3", AEprogress)[1]

    self.aetransform3:set("position",Amaz.Vector3f(position3_x,position3_y,0.))
    self.aetransform3:set("scale",Amaz.Vector3f(Scale3_x,Scale3_y,0.))
    self.aetransform3:set("opacity",opacity3_x)

    local exposure = self.attrs:GetVal("ADBE_IE_5a1ff1b7caffac514aaba44-0001_0_1", AEprogress)[1]*0.75
    self.Exposure:set("exposure",exposure)
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
