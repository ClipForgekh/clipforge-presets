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
	["ADBE_Gaussian_Blur_2_0001_0_0"]={
		{{0.001, 0, 0.5, 1, }, {0, 12, }, {{500, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.5, 0.5, }, {12, 53, }, {{0, }, {0, }, }, }, 
		{{0.5, 0, 0.999, 1, }, {53, 65, }, {{0, }, {500, }, }, }, 
	}, 
	["ADBE_Position_0_1"]={
		{{0.001, 0, 0, 1, }, {0, 12, }, {{-540, 540, 0, }, {540, 540, 0, }, }, }, 
		{{0.001, 0.001, 0, 0, }, {12, 53, }, {{540, 540, 0, }, {540, 540, 0, }, }, }, 
		{{1, 0, 0.999, 1, }, {53, 65, }, {{540, 540, 0, }, {1620, 540, 0, }, }, }, 
		{{0.166667, 0, 0.999, 1, }, {65, 66, }, {{1620, 540, 0, }, {3333, 540, 0, }, }, }, 
	}, 
	["dropShadow/opacity_0_2"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {23, 24, }, {{75, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {24, 52, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {52, 53, }, {{0, }, {75, }, }, }, 
	}, 

    ["ADBE_Gaussian_Blur_2_0002_0_0"]={
		{{0.001, 0, 0.5, 1, }, {8, 20, }, {{500, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.5, 0.5, }, {20, 59, }, {{0, }, {0, }, }, }, 
		{{0.5, 0, 0.999, 1, }, {59, 70, }, {{0, }, {500, }, }, }, 
	}, 
	["ADBE_Position_0_2"]={
        {{0.001, 0.135, 0, 1, }, {0, 7, }, {{2000, 540, 0, }, {2000, 540, 0, }, }, },
        {{0.001, 0.135, 0, 1, }, {7, 8, }, {{2000, 540, 0, }, {1620, 540, 0, }, }, },
		{{0.001, 0.135, 0, 1, }, {8, 20, }, {{1620, 540, 0, }, {540, 540, 0, }, }, }, 
		{{0.166667, 0.166667, 0, 0, }, {20, 59, }, {{540, 540, 0, }, {540, 540, 0, }, }, }, 
		{{0.62, 0, 0.999, 1, }, {59, 70, }, {{540, 540, 0, }, {-540, 540, 0, }, }, }, 
		{{0.001, 0, 0.999, 1, }, {70, 71, }, {{-540, 540, 0, }, {-2000, 540, 0, }, }, }, 
	}, 
	["dropShadow/opacity_0_3"]={
		{{0.33, 0, 0.41, 1, }, {16, 24, }, {{50, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.41, 0.41, }, {24, 51, }, {{0, }, {0, }, }, }, 
		{{0.59, 0, 0.67, 1, }, {51, 59, }, {{0, }, {50, }, }, }, 
	}, 

    ["ADBE_WRPMESH_0003_0_1"]={
		{{0.422657371, 0, 0.745444792, 0.580909516, }, {0, 2, }, {{5, }, {-12, }, }, }, 
		{{0.001, 0.001, 0.999, 0.999, }, {2, 7, }, {{-12, }, {0, }, }, }, 
		{{0.494475414, 0.301662769, 0.483224468, 1, }, {7, 12, }, {{0, }, {92, }, }, }, 
		{{0.391466147, 0, 0.528546061, 0.798393572, }, {12, 21, }, {{92, }, {0, }, }, }, 
		{{0.001, 0.001, 0.636283446, 0.636283446, }, {21, 32, }, {{0, }, {0, }, }, }, 
		{{0.001, 0.001, 0.999, 0.999, }, {43, 53, }, {{0, }, {0, }, }, }, 
		{{0.363661206, 0.279582468, 0.43119328, 1, }, {53, 62, }, {{0, }, {100, }, }, }, 
	}, 
	["ADBE_WRPMESH_0003_0_2"]={
		{{0.37750473, 0.639153695, 0.66666667, 1, }, {2, 4, }, {{0, }, {0, }, }, }, 
		{{0.515507923, 0, 0.756463601, 0.140259604, }, {4, 7, }, {{0, }, {0, }, }, }, 
		{{0.33333333, 0.33333333, 0.833333333, 0.833333333, }, {7, 21, }, {{0, }, {0, }, }, }, 
		{{0.330213153, 0.672498701, 0.662266059, 1, }, {21, 23, }, {{0, }, {-4, }, }, }, 
		{{0.33333333, 0, 0.508387574, 1, }, {23, 32, }, {{-4, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.66666667, 0.66666667, }, {32, 43, }, {{0, }, {0, }, }, }, 
		{{0.35, 0, 0.54, 1, }, {43, 50, }, {{0, }, {-8, }, }, }, 
		{{0.440582352, 0, 0.725165053, 0.218247908, }, {50, 53, }, {{-8, }, {0, }, }, }, 
	}, 
	["ADBE_IE_5a1ff1b7caffac514aaba44-0001_0_2"]={
		{{0.633678678, 0, 0.687296782, 1, }, {0, 4, }, {{0, }, {-1, }, }, }, 
		{{0.408483342, 0, 0.732758503, 1, }, {4, 12, }, {{-1, }, {1.5, }, }, }, 
		{{0.154174509, 0, 0.34541373, 1, }, {12, 29, }, {{1.5, }, {0, }, }, }, 
		{{0.310930766, 0, 0.632793273, 1, }, {43, 50, }, {{0, }, {-0.5, }, }, }, 
		{{0.448698503, 0, 0.770259585, 1, }, {50, 62, }, {{-0.5, }, {1.5, }, }, }, 
		{{0.532963224, 0, 0.714456566, 1, }, {62, 71, }, {{1.5, }, {0, }, }, }, 
	}, 
    ["ADBE_Scale_0_4"]={
		{{0.38,0.38,0.38, 0.51,0.51,0.38, 0.67,0.67,0.67, 1,1,0.67, }, {2, 4, }, {{100, 100, 100, }, {100, 100, 100, }, }, }, 
		{{0.52,0.52,0.52, 0,0,0.52, 0.76,0.76,0.76, 0.31,0.31,0.76, }, {4, 7, }, {{100, 100, 100, }, {100, 100, 100, }, }, }, 
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {7, 21, }, {{100, 100, 100, }, {100, 100, 100, }, }, }, 
		{{0.33,0.33,0.33, 0.54,0.54,0.33, 0.66,0.66,0.66, 1,1,0.66, }, {21, 23, }, {{100, 100, 100, }, {98, 98, 100, }, }, }, 
		{{0.33,0.33,0.33, 0,0,0.33, 0.51,0.51,0.51, 1,1,0.51, }, {23, 32, }, {{98, 98, 100, }, {100, 100, 100, }, }, }, 
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {32, 43, }, {{100, 100, 100, }, {100, 100, 100, }, }, }, 
		{{0.47,0.47,0.47, 0,0,0.47, 0.61,0.61,0.61, 1,1,0.61, }, {43, 50, }, {{100, 100, 100, }, {96, 96, 100, }, }, }, 
		{{0.44,0.44,0.44, 0,0,0.44, 0.73,0.73,0.73, 0.37,0.37,0.73, }, {50, 53, }, {{96, 96, 100, }, {100, 100, 100, }, }, }, 
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
    -- self.animSeqCom = comp.entity.scene:findEntityBy("imgMovePass"):getComponent("AnimSeqComponent")
    self.material0 = comp.entity.scene:findEntityBy("blur0up"):getComponent("MeshRenderer").material
    self.material1 = comp.entity.scene:findEntityBy("blur1up"):getComponent("MeshRenderer").material
    self.material2 = comp.entity.scene:findEntityBy("blur2up"):getComponent("MeshRenderer").material

    self.material00 = comp.entity.scene:findEntityBy("blur0down"):getComponent("MeshRenderer").material
    self.material11 = comp.entity.scene:findEntityBy("blur1down"):getComponent("MeshRenderer").material
    self.material22 = comp.entity.scene:findEntityBy("blur2down"):getComponent("MeshRenderer").material

    self.resultMaterial = comp.entity.scene:findEntityBy("result"):getComponent("MeshRenderer").material
    self.mixPassMaterial = comp.entity.scene:findEntityBy("mixPass"):getComponent("MeshRenderer").material
    
    
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
       
        self.material0:setFloat("baseTexWidth", w)
        self.material0:setFloat("baseTexHeight", h)
        self.material1:setFloat("baseTexWidth", w)
        self.material1:setFloat("baseTexHeight", h)
        self.material2:setFloat("baseTexWidth", w)
        self.material2:setFloat("baseTexHeight", h)

        self.material00:setFloat("baseTexWidth", w)
        self.material00:setFloat("baseTexHeight", h)
        self.material11:setFloat("baseTexWidth", w)
        self.material11:setFloat("baseTexHeight", h)
        self.material22:setFloat("baseTexWidth", w)
        self.material22:setFloat("baseTexHeight", h)
 
    end


    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    if t>1 then
        t=1
    end
    local AEProgress = t*32/71

    Amaz.LOGI("AEProgress",math.floor(t*32))
    local posX = self.attrs:GetVal("ADBE_Position_0_1", AEProgress)[1]-540
    local posY = self.attrs:GetVal("ADBE_Position_0_1", AEProgress)[2]-540
    -- self.imgMoveMaterial:setFloat("posX", posX)
    -- self.imgMoveMaterial:setFloat("posY", posY)
    self.material0:setFloat("posX", posX)
    self.material0:setFloat("posY", posY)
    self.material1:setFloat("posX", posX)
    self.material1:setFloat("posY", posY)
    self.material2:setFloat("posX", posX)
    self.material2:setFloat("posY", posY)

    local posX2 = self.attrs:GetVal("ADBE_Position_0_2", AEProgress)[1]-540
    local posY2 = self.attrs:GetVal("ADBE_Position_0_2", AEProgress)[2]-540
    -- self.imgMoveMaterial:setFloat("posX", posX)
    -- self.imgMoveMaterial:setFloat("posY", posY)
    self.material00:setFloat("posX", posX2)
    self.material00:setFloat("posY", posY2)
    self.material11:setFloat("posX", posX2)
    self.material11:setFloat("posY", posY2)
    self.material22:setFloat("posX", posX2)
    self.material22:setFloat("posY", posY2)


    
    Amaz.LOGI("posX",posX+540)
    Amaz.LOGI("posY",posY+540)
    -- Amaz.LOGI("rot",self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1])
    -- local imgSize = self.attrs:GetVal("ADBE_Scale_0_6", AEProgress)[1]

    self.material0:setFloat("imgSize", 1.0)

    local blurIns = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0001_0_0", AEProgress)[1]/500*0.6
    self.material0:setFloat("blurIns", blurIns)
    self.material1:setFloat("blurIns", blurIns)
    self.material2:setFloat("blurIns", blurIns)

    local blurIns2 = self.attrs:GetVal("ADBE_Gaussian_Blur_2_0002_0_0", AEProgress)[1]/500*0.6
    self.material00:setFloat("blurIns", blurIns2)
    self.material11:setFloat("blurIns", blurIns2)
    self.material22:setFloat("blurIns", blurIns2)
    
    local exposure = self.attrs:GetVal("ADBE_IE_5a1ff1b7caffac514aaba44-0001_0_2", AEProgress)[1]
    self.resultMaterial:setFloat("exposure", exposure)

    local bulgeIns = self.attrs:GetVal("ADBE_WRPMESH_0003_0_1", AEProgress)[1]/92*0.6
    self.resultMaterial:setFloat("bulgeIns", bulgeIns)
    -- local exposure = self.attrs:GetVal("ADBE_Exposure2_0003_0_4", AEProgress)[1]
    -- self.material2:setFloat("exposure", 0.)
    -- Amaz.LOGI("exposure",exposure)

    local shadowIns =self.attrs:GetVal("dropShadow/opacity_0_3", AEProgress)[1]/50
    self.mixPassMaterial:setFloat("shadowIns", shadowIns)

    local xiruIns =self.attrs:GetVal("ADBE_WRPMESH_0003_0_2", AEProgress)[1]/-8*0.75
    self.resultMaterial:setFloat("xiruIns", xiruIns)

    local imgScale =self.attrs:GetVal("ADBE_Scale_0_4", AEProgress)[1]/100.
    self.resultMaterial:setFloat("imgScale", imgScale)

    
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
