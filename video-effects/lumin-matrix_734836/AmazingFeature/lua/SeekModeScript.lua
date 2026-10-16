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
local exports = exports or {}
local SeekModeScript = SeekModeScript or {}

---@class SeekModeScript : ScriptComponent
---@field progress number [UI(Range={0, 1}, Slider)]
---@field auto_play boolean
SeekModeScript.__index = SeekModeScript
function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.progress = 0.0
    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.width = 0
    self.height = 0
    self.GlowRange = 100
    self.auto_play = false
    self.duration = 1.0
    return self
end

local ae_attribute = {
    ["ADBE_Position_0_0"]={
		{{0.166667, 0.166667, 0.46, 0.46, }, {0, 2, }, {{540, 540, 0, }, {540, 540, 0, }, {540, 540, 0, }, {540, 540, 0, }, }, {6413, }, {0, }, }, 
		{{0.54, 0, 0.73, 1, }, {2, 6, }, {{540, 540, 0, }, {540, 526, 0, }, {540, 540, 0, }, {540, 526, 0, }, }, {6413, }, {0, }, }, 
		{{0.4, 0, 0.7, 1, }, {6, 14, }, {{540, 526, 0, }, {540, 590, 0, }, {540, 526, 0, }, {540, 590, 0, }, }, {6413, }, {0, }, }, 
		{{0.29, 0, 0.6, 1, }, {14, 22, }, {{540, 590, 0, }, {540, 540, 0, }, {540, 590, 0, }, {540, 540, 0, }, }, {6413, }, {0, }, }, 
	}, 
	["ADBE_Scale_0_1"]={
		{{0.180373033,0.180373033,0.180373033, 0.180373033,0.180373033,0.180373033, 0.541960442,0.541960442,0.541960442, 0.541960442,0.541960442,0.541960442, }, {0, 2, }, {{100, 100, 100, }, {100, 100, 100, }, }, {6414, }, {0, }, }, 
		{{0.256274914,0.256274914,0.256274914, 0,0,0, 0.590852855,0.590852855,0.590852855, 1,1,1, }, {2, 5, }, {{100, 100, 100, }, {102, 102, 102, }, }, {6414, }, {0, }, }, 
		{{0.333875956,0.333875956,0.333875956, 0,0,0, 0.547317738,0.547317738,0.547317738, 0.555894058,0.555894058,0.555894058, }, {5, 22, }, {{102, 102, 102, }, {50, 50, 50, }, }, {6414, }, {0, }, }, 
	}, 
	["ADBE_Rotate_X_0_2"]={
		{{0.166666667, 0, 0.482265754, 0, }, {0, 2, }, {{0, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.517734246, 0, 0.774609486, 1, }, {2, 6, }, {{0, }, {-4, }, }, {6417, }, {0, }, }, 
		{{0.317315598, 0, 0.509891752, 0.92407336, }, {6, 22, }, {{-4, }, {90, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_Opacity_0_3"]={
		{{0.166666667, 0, 0.66666667, 0, }, {0, 12, }, {{100, }, {100, }, }, {6417, }, {0, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {12, 22, }, {{100, }, {33, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_WRPMESH_0003_0_0"]={
		{{0.303131537, 0, 0.575602393, 1, }, {0, 5, }, {{0, }, {20, }, }, {6417, }, {0, }, }, 
		{{0.320338702, 0, 0.368349194, 1, }, {5, 11, }, {{20, }, {-22, }, }, {6417, }, {0, }, }, 
		{{0.375425108, 0, 0.767432751, 1, }, {11, 25, }, {{-22, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_Rotate_Z_3_6"]={
		{{0.3, 0, 0.87, 0.1, }, {2, 18, }, {{0, }, {109.8634, }, }, {6417, }, {0, }, }, 
		{{0.23, 0.17, 0.73, 0.76, }, {18, 23, }, {{109.8634, }, {406.2651, }, }, {6417, }, {0, }, }, 
		{{0.13, 0.46, 0.53, 0.77, }, {23, 33, }, {{406.2651, }, {550, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_Scale_4_7"]={
		{{0.24, 0, 0.71, 0.27, }, {5, 10, }, {{100, }, {96.9443, }, }, {6417, }, {0, }, }, 
		{{0.29, 0.09, 0.91, 0.42, }, {10, 21, }, {{96.9443, }, {38, }, }, {6417, }, {0, }, }, 
		{{0.06, 0.57, 0.58, 1, }, {21, 30, }, {{38, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_IE_GlowRadius_0001_2_4"]={
		{{0.001, 0, 0, 1, }, {10, 33, }, {{400, }, {200, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_IE_GlowIns_0002_2_5"]={
		{{0.574371143, 0, 0.848652616, 0.562863694, }, {10, 21, }, {{0.9, }, {1, }, }, {6417, }, {0, }, }, 
		{{0.192020098, 0.453772813, 0.537290573, 1, }, {21, 30, }, {{1, }, {1.1, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_IE_GlowThreshold_0003_2_6"]={
		{{0.33333333, 0, 0.716966136, 0.329655447, }, {17, 25, }, {{75, }, {50, }, }, {6417, }, {0, }, }, 
		{{0.411472158, 0.330309036, 0.723010858, 1, }, {25, 30, }, {{50, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_Rotate_Z_3_5"]={
		{{0.3, 0, 0.87, 0.1, }, {2, 18, }, {{0, }, {109.8634, }, }, {6417, }, {0, }, }, 
		{{0.23, 0.17, 0.73, 0.76, }, {18, 23, }, {{109.8634, }, {406.2651, }, }, {6417, }, {0, }, }, 
		{{0.13, 0.46, 0.53, 0.77, }, {23, 33, }, {{406.2651, }, {550, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_Scale_4_6"]={
		{{0.08, 0, 0.73, 0.6, }, {5, 21, }, {{287.2722, }, {94.5018, }, }, {6417, }, {0, }, }, 
		{{0.28, 0.63, 0.6, 0.94, }, {21, 33, }, {{94.5018, }, {0, }, }, {6417, }, {0, }, }, 
        {{0.28, 0.63, 0.6, 0.94, }, {33, 34, }, {{0, }, {0, }, }, {6417, }, {0, }, }, 

	}, 
	["solidFill/color_4_13"]={
		{{0.29, 0, 0.81, 1, }, {10, 33, }, {{255, 255, 255, 255, }, {191, 191, 191, 255, }, }, {6418, }, {0, }, }, 
	}, 
    ["solidop21e4"]={
		{{0.29, 0, 0.81, 1, }, {32, 33, }, {{1,  }, {0,  }, }, {6418, }, {0, }, }, 
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
    ---@param comp Component
    ---@param deltaTime number
    function SeekModeScript:onUpdate(comp, detalTime)
        --ceshiyong
        local props = comp.entity:getComponent("ScriptComponent").properties
        
        -- shijiyong
        self.curTime=self.curTime + detalTime
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
    -- self.mixImgMaterial = comp.entity.scene:findEntityBy("mixPass"):getComponent("MeshRenderer").material
    -- self.Blur = comp.entity.scene:findEntityBy("Gaussian_Blur_Root"):getComponent("ScriptComponent").properties
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("intensity") then
    --     self.intensity = props:get("intensity")
    -- end
    -- self.shadowSeq = comp.entity.scene:findEntityBy("maskPass"):getComponent("AnimSeqComponent")
    -- self.shadowSeq = comp.entity.scene:findEntityBy("maskPass"):getComponents("AnimSeqComponent"):get(0)
    -- self.tree1Seq = comp.entity.scene:findEntityBy("maskPass"):getComponents("AnimSeqComponent"):get(1)
    self.firstMat = comp.entity.scene:findEntityBy("firstMat"):getComponent("MeshRenderer").material
    self.motionBlur0 = comp.entity.scene:findEntityBy("lumi_motion_blur_2d_0"):getComponent("ScriptComponent").properties
    self.motionBlur1 = comp.entity.scene:findEntityBy("lumi_motion_blur_2d_1"):getComponent("ScriptComponent").properties
    self.deepGlow = comp.entity.scene:findEntityBy("Deep_Glow_65-effect0"):getComponent("ScriptComponent").properties
    self.aeTransform = comp.entity.scene:findEntityBy("AE_Transform_55-trs"):getComponent("ScriptComponent").properties
    self.motionBlur2 = comp.entity.scene:findEntityBy("lumi_motion_blur_2d_2"):getComponent("ScriptComponent").properties
    self.deform = comp.entity.scene:findEntityBy("Deform"):getComponent("MeshRenderer").material
    
    if isEditor then
        self.orderIndex = 1
        self:orderCam(comp)
    end
    self.attrs = AETools:new(ae_attribute)
end

local function _setLayer(_cam, _layer)
    local str = "1"
    for i = 1, _layer do
        str = str.."0"
    end
    local dynamic_bitset = Amaz.DynamicBitset.new(str)
    _cam.layerVisibleMask = dynamic_bitset
end

function SeekModeScript:_findChild(fatherTran, camArray)
    local cam = fatherTran.entity:getComponent("Camera")
    if cam then
        camArray[self.orderIndex] = cam;
        self.orderIndex = self.orderIndex + 1
    end
    if fatherTran.children then
        for i = 1, fatherTran.children:size() do
            local camTrans = fatherTran.children:get(i-1)
            self:_findChild(camTrans, camArray, self.orderIndex)
        end
    end
end

function SeekModeScript:orderCam(comp)
    self.trans = comp.entity.scene:findEntityBy("orderGroup"):getComponent("Transform")
    local camArray = {}
    self:_findChild(self.trans, camArray, 1)
    for i = 1, self.orderIndex - 1 do
        camArray[i].renderOrder = i
        _setLayer(camArray[i], i)
        local transform = camArray[i].entity:getComponent("Transform")
        if transform.children then
            for j = 1, transform.children:size() do
                local rendererTrans = transform.children:get(j-1)
                local renderers = rendererTrans.entity:getComponentsRecursive("Renderer")
                for k = 0, renderers:size() - 1 do
                    local renderer = renderers:get(k)
                    if renderer then
                        renderer.entity.layer = i
                    end
                end
            end
        end
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
    if isEditor then
        if self.auto_play then
            self.progress = time % self.duration
            time = self.progress
        else
            time = self.progress
        end
    end

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
    end


    local t = math.mod(time, self.duration + 0.0001) / (self.duration + 0.0001)
    local AEprogress = time / self.duration
    local fps = time * 34
    -- Amaz.LOGI("fps", "fps: " .. fps)

    -- Shape and Motion Blur 0
    local color = self.attrs:GetVal("solidFill/color_4_13", AEprogress)[1] / 255
    self.firstMat:setFloat("u_color", color)

    local frame_time = 1.0 / 34.0
    
    local preScale_out = self.attrs:GetVal("ADBE_Scale_4_6", math.max(0., AEprogress - frame_time))[1] / 100.0
    local curScale_out = self.attrs:GetVal("ADBE_Scale_4_6", math.max(frame_time, AEprogress))[1] / 100.0
    local preRotate_out = self.attrs:GetVal("ADBE_Rotate_Z_3_5", math.max(0., AEprogress - frame_time))[1]
    local curRotate_out = self.attrs:GetVal("ADBE_Rotate_Z_3_5", math.max(frame_time, AEprogress))[1]

    -- if fps > self.endTime * 30 - 1 then
    --     preScale_out = 0
    --     curScale_out = 0
    -- end

    self.motionBlur0:set("PrevScale", Amaz.Vector2f(preScale_out, preScale_out))
    self.motionBlur0:set("CurrScale", Amaz.Vector2f(curScale_out, curScale_out))
    self.motionBlur0:set("PrevRotate", preRotate_out)
    self.motionBlur0:set("CurrRotate", curRotate_out)
    
    -- Deep Glow
    local glowIntensity = self.attrs:GetVal("ADBE_IE_GlowIns_0002_2_5", AEprogress)[1]
    local glowRadius = self.attrs:GetVal("ADBE_IE_GlowRadius_0001_2_4", AEprogress)[1]
    local glowThreshold = self.attrs:GetVal("ADBE_IE_GlowThreshold_0003_2_6", AEprogress)[1] / 100.0

    self.deepGlow:set("glow_intensity", glowIntensity)
    self.deepGlow:set("radius", glowRadius)
    self.deepGlow:set("threshold", glowThreshold)

    -- inside image AETransform
    local positionX = self.attrs:GetVal("ADBE_Position_0_0", AEprogress)[1]
    local positionY = self.attrs:GetVal("ADBE_Position_0_0", AEprogress)[2]
    local scale = self.attrs:GetVal("ADBE_Scale_0_1", AEprogress)[1]
    local rotateX = self.attrs:GetVal("ADBE_Rotate_X_0_2", AEprogress)[1]
    local opacity = self.attrs:GetVal("ADBE_Opacity_0_3", AEprogress)[1]
    local op = self.attrs:GetVal("solidop21e4", AEprogress)[1]

    self.aeTransform:set("position", Amaz.Vector3f(positionX, positionY, 0.0))
    self.aeTransform:set("scale", Amaz.Vector3f(scale, scale, scale))
    self.aeTransform:set("xRotation", rotateX)
    self.aeTransform:set("opacity", opacity)

    -- Motion Blur 1 and 2
    local preScale_in = self.attrs:GetVal("ADBE_Scale_4_7", math.max(0., AEprogress - frame_time))[1] / 100.0
    local curScale_in = self.attrs:GetVal("ADBE_Scale_4_7", math.max(frame_time, AEprogress))[1] / 100.0
    local preRotate_in = self.attrs:GetVal("ADBE_Rotate_Z_3_6", math.max(0., AEprogress - frame_time))[1]
    local curRotate_in = self.attrs:GetVal("ADBE_Rotate_Z_3_6", math.max(frame_time, AEprogress))[1]

    self.motionBlur1:set("PrevScale", Amaz.Vector2f(preScale_in, preScale_in))
    self.motionBlur1:set("CurrScale", Amaz.Vector2f(curScale_in, curScale_in))
    self.motionBlur1:set("PrevRotate", preRotate_in)
    self.motionBlur1:set("CurrRotate", curRotate_in)

    self.motionBlur2:set("PrevScale", Amaz.Vector2f(preScale_in, preScale_in))
    self.motionBlur2:set("CurrScale", Amaz.Vector2f(curScale_in, curScale_in))
    self.motionBlur2:set("PrevRotate", preRotate_in)
    self.motionBlur2:set("CurrRotate", curRotate_in)

    -- Deform
    local deform = self.attrs:GetVal("ADBE_WRPMESH_0003_0_0", AEprogress)[1] / 100.0
    self.deform:setFloat("u_Twist", deform)
    self.deform:setFloat("op", op)

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
