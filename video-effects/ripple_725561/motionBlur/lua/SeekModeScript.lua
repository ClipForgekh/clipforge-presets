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
	["ADBE_IE_92959d1fb849aa97f8ff858-0001_0_0"]={
		{{0.33333333, 0, 0.66666667, 1, }, {4, 12, }, {{-100, }, {-40, }, }, }, 
		{{0.17, 0, 0.31, 1, }, {12, 47, }, {{-40, }, {-100, }, }, }, 
		{{0.166666667, 0.166666667, 0.66666667, 0.66666667, }, {47, 60, }, {{-100, }, {-100, }, }, }, 
		{{0.33, 0, 0.21, 1, }, {60, 101, }, {{-100, }, {-20, }, }, }, 
	}, 
	["ADBE_IE_92959d1fb849aa97f8ff858-0004_0_1"]={
		{{0.46, 0.85, 0.58, 1, }, {0, 47, }, {{0, }, {90, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {47, 60, }, {{90, }, {90, }, }, }, 
		{{0.33, 0, 0.999, 1, }, {60, 101, }, {{90, }, {200, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur_2_0001_0_2"]={
		{{0.001, 0, 0.550302368, 0.982621764, }, {0, 4, }, {{999, }, {50, }, }, }, 
		{{0.225017877, 0.30879823, 0.58, 1, }, {4, 20, }, {{50, }, {0, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur_2_0001_0_3"]={
		{{0.4, 0, 0.8, 1, }, {81, 101, }, {{0, }, {40, }, }, }, 
	}, 
	["ADBE_Exposure2_0003_0_4"]={
		{{0.335056718, 0, 0.417472024, 1, }, {0, 12, }, {{-1, }, {0.9, }, }, }, 
		{{0.307592196, 0, 0.58, 1, }, {12, 47, }, {{0.9, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {47, 60, }, {{0, }, {0, }, }, }, 
		{{0.370243305, 0, 0.481550685, 1, }, {60, 76, }, {{0, }, {0.7, }, }, }, 
		{{0.307592196, 0, 0.58, 1, }, {76, 101, }, {{0.7, }, {0, }, }, }, 
	}, 
	["ADBE_Position_0_5"]={
		{{0.001, 0, 0.5, 0.8, }, {0, 4, }, {{540, -415, 0, }, {540, 540, 0, }, }, }, 
	}, 
	["ADBE_Scale_0_6"]={
		{{0.001,0.001,0.001, 0,0,0.001, 0.636188008,0.578136586,0.5, 1,1,0.5, }, {0, 12, }, {{99, 103, 100, }, {88, 88, 100, }, }, }, 
		{{0.267822913,0.267822913,0.42, 0,0,0.42, 0.391083227,0.391083227,0.58, 1,1,0.58, }, {12, 26, }, {{88, 88, 100, }, {103, 103, 100, }, }, }, 
		{{0.224370877,0.224370877,0.156888882, 0,0,0.156888882, 0.448185842,0.448185842,0.66051582, 1,1,0.66051582, }, {26, 47, }, {{103, 103, 100, }, {100, 100, 100, }, }, }, 
		{{0.436809464,0.436809464,0.436809464, 0.436809464,0.436809464,0.436809464, 0.798133308,0.798133308,0.798133308, 0.798133308,0.798133308,0.798133308, }, {47, 60, }, {{100, 100, 100, }, {100, 100, 100, }, }, }, 
		{{0.313211921,0.313211921,0.42, 0,0,0.42, 0.500374155,0.500374155,0.58, 1,1,0.58, }, {60, 76, }, {{100, 100, 100, }, {93, 93, 100, }, }, }, 
		{{0.619247752,0.619247752,0.67, 0,0,0.67, 0.999,0.999,0.999, 1,1,0.999, }, {76, 101, }, {{93, 93, 100, }, {133, 133, 100, }, }, }, 
	}, 
	["ADBE_Opacity_0_7"]={
		{{0.42, 0, 0.999, 1, }, {88, 101, }, {{100, }, {0, }, }, }, 
	}, 


    ["ADBE_Scale_3_0"]={
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {0, 30, }, {{90, 90, 100, }, {333, 333, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {30, 64, }, {{333, 333, 100, }, {333, 333, 100, }, }, }, 
		{{0.67,0.67,0.67, 0.33,0.33,0.67, 0.999,0.999,0.999, 1,1,0.999, }, {64, 93, }, {{70, 70, 100, }, {400, 400, 100, }, }, }, 
	}, 
	["ADBE_Opacity_3_1"]={
		{{0.33, 0, 0.67, 1, }, {24, 31, }, {{100, }, {0, }, }, }, 
        {{0.33, 0, 0.67, 1, }, {31, 64, }, {{0, }, {0, }, }, }, 
		{{0.370531484, 0, 0.414486316, 1, }, {64, 87, }, {{0, }, {100, }, }, }, 
		{{0.33, 0, 0.67, 1, }, {87, 94, }, {{100, }, {0, }, }, }, 
	}, 
	["ADBE_Scale_3_2"]={
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {0, 35, }, {{30, 30, 100, }, {200, 200, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {35, 64, }, {{200, 200, 100, }, {200, 200, 100, }, }, }, 
		{{0.67,0.67,0.67, 0.301714286,0.301714286,0.67, 0.999,0.999,0.999, 1,1,0.999, }, {64, 99, }, {{30, 30, 100, }, {240, 240, 100, }, }, }, 
	}, 
	["ADBE_Opacity_3_3"]={
		{{0.157599534, 0, 0.358879574, 1, }, {0, 25, }, {{0, }, {10, }, }, }, 
		{{0.33, 0, 0.67, 1, }, {25, 37, }, {{10, }, {0, }, }, }, 
        {{0.33, 0, 0.67, 1, }, {37, 70, }, {{0, }, {0, }, }, }, 
		{{0.16, 0, 0.36, 1, }, {70, 89, }, {{0, }, {10, }, }, }, 
		{{0.33, 0, 0.67, 1, }, {89, 101, }, {{10, }, {0, }, }, }, 
	}, 

    ["APC_Caustics_0012_0_0"]={
		{{0.22, 0, 0.78, 1, }, {9, 23, }, {{0.55, }, {0.77, }, }, }, 
        {{0.22, 0, 0.78, 1, }, {23, 64, }, {{0.77, }, {0.77, }, }, }, 
		{{0.21, 0, 0.56, 1, }, {64, 91, }, {{0, }, {0.95, }, }, }, 
	}, 
	["APC_Caustics_0082_0_1"]={
		{{0.282435445, 0, 0.478727754, 1, }, {0, 23, }, {{0, }, {0.6, }, }, }, 
        {{0.282435445, 0, 0.478727754, 1, }, {23, 64, }, {{0.6 }, {0.6, }, }, }, 
		{{0.21, 0, 0.46, 1, }, {64, 91, }, {{0, }, {0.6, }, }, }, 
	}, 
	["ADBE_Opacity_0_2"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {2, 4, }, {{0, }, {100, }, }, }, 
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
    self.animSeqCom = comp.entity.scene:findEntityBy("imgMovePass"):getComponent("AnimSeqComponent")
    self.material0 = comp.entity.scene:findEntityBy("blur0"):getComponent("MeshRenderer").material
    self.material1 = comp.entity.scene:findEntityBy("blur1"):getComponent("MeshRenderer").material
    self.material2 = comp.entity.scene:findEntityBy("blur2"):getComponent("MeshRenderer").material
    self.imgMoveMaterial = comp.entity.scene:findEntityBy("imgMovePass"):getComponent("MeshRenderer").material
    self.displacementMat = comp.entity.scene:findEntityBy("displacement"):getComponent("MeshRenderer").material
    self.putCircleMat = comp.entity.scene:findEntityBy("putCircle"):getComponent("MeshRenderer").material
    self.blurX0Mat = comp.entity.scene:findEntityBy("blurX0"):getComponent("MeshRenderer").material
    self.blurY0Mat = comp.entity.scene:findEntityBy("blurY0"):getComponent("MeshRenderer").material
    self.blurX1Mat = comp.entity.scene:findEntityBy("blurX1"):getComponent("MeshRenderer").material
    self.blurY1Mat = comp.entity.scene:findEntityBy("blurY1"):getComponent("MeshRenderer").material
    self.waterMat = comp.entity.scene:findEntityBy("water"):getComponent("MeshRenderer").material
    self.animSeqCom = comp.entity.scene:findEntityBy("water"):getComponent("AnimSeqComponent")
    -- self.rgbMaterial = comp.entity.scene:findEntityBy("RGBpass"):getComponent("MeshRenderer").material
    -- self.blurYMaterial = comp.entity.scene:findEntityBy("blurYpass"):getComponent("MeshRenderer").material
    -- local w = Amaz.BuiltinObject:getInputTextureWidth()
    -- local h = Amaz.BuiltinObject:getInputTextureHeight()
    -- self.width = w
    -- self.height = h
    -- self.material:setFloat("baseTexWidth", w)
    -- self.material:setFloat("baseTexHeight", h)
    -- self.material1:setFloat("baseTexWidth", w)
    -- self.material1:setFloat("baseTexHeight", h)
    
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
    self.material0:setFloat("uTime", time)
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.imgMoveMaterial:setFloat("baseTexWidth", w)
        self.imgMoveMaterial:setFloat("baseTexHeight", h)
        self.displacementMat:setFloat("baseTexWidth", w)
        self.displacementMat:setFloat("baseTexHeight", h)
        self.material0:setFloat("baseTexWidth", w)
        self.material0:setFloat("baseTexHeight", h)
        self.material1:setFloat("baseTexWidth", w)
        self.material1:setFloat("baseTexHeight", h)
        self.material2:setFloat("baseTexWidth", w)
        self.material2:setFloat("baseTexHeight", h)
        self.putCircleMat:setFloat("baseTexWidth", w)
        self.putCircleMat:setFloat("baseTexHeight", h)
        self.blurX0Mat:setFloat("baseTexWidth", w)
        self.blurY0Mat:setFloat("baseTexWidth", w)
        self.blurX1Mat:setFloat("baseTexWidth", w)
        self.blurY1Mat:setFloat("baseTexWidth", w)
        self.blurX0Mat:setFloat("baseTexHeight", h)
        self.blurY0Mat:setFloat("baseTexHeight", h)
        self.blurX1Mat:setFloat("baseTexHeight", h)
        self.blurY1Mat:setFloat("baseTexHeight", h)
        self.waterMat:setFloat("baseTexWidth", w)
        self.waterMat:setFloat("baseTexHeight", h)
    end
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("blurSize") then
    --     self.GlowRange = props:get("blurSize")
    -- end
    -- self.imgMoveMaterial:setFloat("ins", props:get("ins"))
    -- self.imgMoveMaterial:setFloat("centerX", props:get("centerX"))
    -- local controls = {0.21,-0.46,0.33,0.45}

    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    if t>1 then
        t=1
    end
    local AEProgress = t*47/101
    -- Amaz.LOGI("AEProgress",(AEProgress*25))
    
    -- local rotAngle = self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]/180*3.14159
    -- self.imgMoveMaterial:setFloat("rotAngle", rotAngle)
    -- self.material:setFloat("rotAngle", -rotAngle)
    -- self.material1:setFloat("rotAngle", -rotAngle)
    self.animSeqCom:seek(math.min(math.floor(t*47),37))

    Amaz.LOGI("AEProgress",math.floor(t*47))
    local posX = self.attrs:GetVal("ADBE_Position_0_5", AEProgress)[1]-540
    local posY = self.attrs:GetVal("ADBE_Position_0_5", AEProgress)[2]-540
    self.imgMoveMaterial:setFloat("posX", posX)
    self.imgMoveMaterial:setFloat("posY", posY)
    self.material0:setFloat("posX", posX)
    self.material0:setFloat("posY", posY)
    self.material1:setFloat("posX", posX)
    self.material1:setFloat("posY", posY)
    self.material2:setFloat("posX", posX)
    self.material2:setFloat("posY", posY)
    
    Amaz.LOGI("posX",posX+540)
    Amaz.LOGI("posY",posY+540)
    -- Amaz.LOGI("rot",self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1])
    local imgSize = self.attrs:GetVal("ADBE_Scale_0_6", AEProgress)[1]
    -- self.imgMoveMaterial:setFloat("imgSize", imgSize/100)
    self.material0:setFloat("imgSize", imgSize/100)
    -- local blurIns = self.attrs:GetVal("ADBE_Motion_Blur_0002_0_1", AEProgress)[1]/60
    -- self.material:setFloat("blurIns", blurIns)
    -- self.material1:setFloat("blurIns", blurIns)
    local blurIns = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_2", AEProgress)[1]/999
    self.material0:setFloat("blurIns", blurIns)
    self.material1:setFloat("blurIns", blurIns)
    self.material2:setFloat("blurIns", blurIns)
    

    local exposure = self.attrs:GetVal("ADBE_Exposure2_0003_0_4", AEProgress)[1]
    self.material2:setFloat("exposure", exposure)
    Amaz.LOGI("exposure",exposure)

    
    self.size = self.attrs:GetVal("ADBE_IE_92959d1fb849aa97f8ff858-0001_0_0", AEProgress)[1]/100
    self.quantity = 4
    self.complexity = 1
    self.evolution = self.attrs:GetVal("ADBE_IE_92959d1fb849aa97f8ff858-0004_0_1", AEProgress)[1]
    self.cycle = 100
    self.offset_x = 2.1
    self.offset_y = 0
    self.type = 0
    self.fix_type = 0
    self.motion_tile_type = 2
    self.picture_scale = 1
    
    self.displacementMat:setFloat("u_Contrast", self.size);
    self.displacementMat:setVec2("u_Scale", Amaz.Vector2f(self.quantity, self.quantity));
    self.displacementMat:setFloat("u_Complexity", self.complexity);
    self.displacementMat:setFloat("u_Evolution", math.abs(self.evolution)/36.0);
    self.displacementMat:setFloat("u_Cycle", math.max(2, math.floor(self.cycle+0.5)));
    self.displacementMat:setVec2("u_Offset", Amaz.Vector2f(self.offset_x, self.offset_y))
    self.displacementMat:setFloat("u_type", self.type);
    self.displacementMat:setFloat("u_fix_type", self.fix_type)
    self.displacementMat:setFloat("motion_tile_type", self.motion_tile_type)
    self.displacementMat:setFloat("picture_scale", self.picture_scale)

    

    -- ["ADBE_Scale_3_0"]={
	-- 	{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {0, 30, }, {{90, 90, 100, }, {333, 333, 100, }, }, }, 
	-- 	{{0.67,0.67,0.67, 0.33,0.33,0.67, 0.999,0.999,0.999, 1,1,0.999, }, {64, 93, }, {{70, 70, 100, }, {400, 400, 100, }, }, }, 
	-- }, 
	-- ["ADBE_Opacity_3_1"]={
	-- 	{{0.33, 0, 0.67, 1, }, {24, 31, }, {{100, }, {0, }, }, }, 
	-- 	{{0.370531484, 0, 0.414486316, 1, }, {64, 87, }, {{0, }, {100, }, }, }, 
	-- 	{{0.33, 0, 0.67, 1, }, {87, 94, }, {{100, }, {0, }, }, }, 
	-- }, 
	-- ["ADBE_Scale_3_2"]={
	-- 	{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {0, 35, }, {{30, 30, 100, }, {200, 200, 100, }, }, }, 
	-- 	{{0.67,0.67,0.67, 0.301714286,0.301714286,0.67, 0.999,0.999,0.999, 1,1,0.999, }, {64, 99, }, {{30, 30, 100, }, {240, 240, 100, }, }, }, 
	-- }, 
	-- ["ADBE_Opacity_3_3"]={
	-- 	{{0.157599534, 0, 0.358879574, 1, }, {0, 25, }, {{0, }, {10, }, }, }, 
	-- 	{{0.33, 0, 0.67, 1, }, {25, 37, }, {{10, }, {0, }, }, }, 
	-- 	{{0.16, 0, 0.36, 1, }, {70, 89, }, {{0, }, {10, }, }, }, 
	-- 	{{0.33, 0, 0.67, 1, }, {89, 101, }, {{10, }, {0, }, }, }, 
	-- }, 
    local outSize = self.attrs:GetVal("ADBE_Scale_3_0", AEProgress)[1]/100
    self.putCircleMat:setFloat("outSize", outSize)
    self.waterMat:setFloat("outSize", outSize)
    local outIns = self.attrs:GetVal("ADBE_Opacity_3_1", AEProgress)[1]/100
    self.putCircleMat:setFloat("outIns", outIns)
    self.waterMat:setFloat("outIns", outIns)
    local inSize = self.attrs:GetVal("ADBE_Scale_3_2", AEProgress)[1]/100
    self.putCircleMat:setFloat("inSize", inSize)
    self.waterMat:setFloat("inSize", inSize)
    local inIns = self.attrs:GetVal("ADBE_Opacity_3_3", AEProgress)[1]/100
    self.putCircleMat:setFloat("inIns", inIns)
    self.waterMat:setFloat("inIns", inIns)
    
    local waterImgIns = self.attrs:GetVal("ADBE_Opacity_0_2", AEProgress)[1]/100
    self.waterMat:setFloat("waterImgIns",waterImgIns)

    local waterAdjustIns = self.attrs:GetVal("APC_Caustics_0012_0_0", AEProgress)[1]/0.77
    self.waterMat:setFloat("waterAdjustIns",waterAdjustIns)
    -- Amaz.LOGI("outIns",outIns)
    -- Amaz.LOGI("inIns",inIns)
    -- local blurAngle = self.attrs:GetVal("ADBE_Motion_Blur_0001_0_0", AEProgress)[1]/180*3.14159
    -- self.material:setFloat("blurAngle", -blurAngle)
    -- self.material1:setFloat("blurAngle", -blurAngle)

    -- local lightIns = self.attrs:GetVal("ADBE_Exposure2_0003_0_2", AEProgress)[1]
    -- self.material1:setFloat("lightIns", lightIns)
    -- Amaz.LOGI("rot",self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1])
    -- self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]
    -- local midMove = (self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]-500)/1000
    -- self.imgMoveMaterial:setFloat("midMove", midMove)

    -- local bottomMove = (self.attrs:GetVal("ADBE_Position_0_bottom", AEProgress)[1]-500)/1000
    -- self.imgMoveMaterial:setFloat("bottomMove", bottomMove)

    -- local topMove = (self.attrs:GetVal("ADBE_Position_0_top", AEProgress)[1]-500)/1000
    -- self.imgMoveMaterial:setFloat("topMove", topMove)
    
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
