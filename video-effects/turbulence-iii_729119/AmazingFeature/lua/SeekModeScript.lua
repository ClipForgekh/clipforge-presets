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
--@input float curTime = 0.0{"widget":"slider","min":0,"max":51}
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
            self.curTime= props:get("curTime")/51.
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
	["ADBE_Position_0_0"]={
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {0, 3, }, {{-1820, 540, 0, }, {-971.45109557, 540, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {3, 4, }, {{-971.45109557, 540, 0, }, {-397.575920304, 508.459723979, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {4, 5, }, {{-397.575920304, 508.459723979, 0, }, {-120, 701.502206239, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {5, 6, }, {{-120, 701.502206239, 0, }, {-68.59840337, 389.310575576, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {6, 7, }, {{-68.59840337, 389.310575576, 0, }, {1.94437931, 655.22576088, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {7, 8, }, {{1.94437931, 655.22576088, 0, }, {74.961831707, 446.441063641, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {8, 9, }, {{74.961831707, 446.441063641, 0, }, {136.609330271, 617.629546636, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {9, 10, }, {{136.609330271, 617.629546636, 0, }, {186.362083229, 473.91392714, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {10, 11, }, {{186.362083229, 473.91392714, 0, }, {227.103173548, 585.994128062, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {11, 12, }, {{227.103173548, 585.994128062, 0, }, {261.236202065, 491.784302422, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {12, 13, }, {{261.236202065, 491.784302422, 0, }, {290.408296681, 577.02518412, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {13, 14, }, {{290.408296681, 577.02518412, 0, }, {315.737809074, 525.084743026, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {14, 15, }, {{315.737809074, 525.084743026, 0, }, {338.004476264, 571.197607014, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {15, 17, }, {{338.004476264, 571.197607014, 0, }, {375.449564289, 526.923078466, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {17, 18, }, {{375.449564289, 526.923078466, 0, }, {391.361527111, 550.594611474, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {18, 20, }, {{391.361527111, 550.594611474, 0, }, {418.819582944, 532.850274171, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {20, 22, }, {{418.819582944, 532.850274171, 0, }, {441.587913252, 544.184931107, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {22, 24, }, {{441.587913252, 544.184931107, 0, }, {460.633987261, 537.907534447, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {24, 26, }, {{460.633987261, 537.907534447, 0, }, {476.640059926, 540, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {26, 46, }, {{476.640059926, 540, 0, }, {540, 540, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {46, 51, }, {{540, 540, 0, }, {540, 540, 0, }, }, }, 
		
	}, 
	["ADBE_Position_0_0_1"]={
		{{0.6, 0.1, 0.71, 0.97, }, {0, 5, }, {{-1820, }, {-120, }, }, }, 
		{{0.11, 0.28, 0.04, 0.98, }, {5, 46, }, {{-120, }, {540, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {46, 51, }, {{540, }, {540, }, }, }, 
	}, 
    ["ADBE_Position_0_0_1pre"]={
        {{0.6, 0.1, 0.71, 0.97, }, {0, 1, }, {{-1875, }, {-1820, }, }, }, 
		{{0.6, 0.1, 0.71, 0.97, }, {1, 6, }, {{-1820, }, {-120, }, }, }, 
		{{0.11, 0.28, 0.04, 0.98, }, {6, 47, }, {{-120, }, {540, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {47, 51, }, {{540, }, {540, }, }, }, 
	}, 
	["ADBE_Position_1_0_2pre"]={
        -- {{0.744853079, 0, 0.999, 1, }, {0, 3, }, {{540, }, {540, }, }, },
        {{0.744853079, 0, 0.999, 1, }, {3, 4, }, {{520, }, {540, }, }, }, 
		{{0.744853079, 0, 0.999, 1, }, {4, 5, }, {{540, }, {508.459724, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {5, 6, }, {{508.459724, }, {701.502206, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {6, 7, }, {{701.502206, }, {389.310576, }, }, }, 
		{{0.33333333, 0, 0.999, 1, }, {7, 8, }, {{389.310576, }, {655.225761, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {8, 9, }, {{655.225761, }, {446.441064, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {9, 10, }, {{446.441064, }, {617.629547, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {10, 11, }, {{617.629547, }, {473.913927, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {11, 12, }, {{473.913927, }, {585.994128, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {12, 13, }, {{585.994128, }, {491.784302, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {13, 14, }, {{491.784302, }, {577.025184, }, }, }, 
		{{0.33333333, 0, 0.7, 1, }, {14, 15, }, {{577.025184, }, {525.084743, }, }, }, 
		{{0.3, 0, 0.66666667, 1, }, {15, 16, }, {{525.084743, }, {571.197607, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {16, 18, }, {{571.197607, }, {526.923078, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {18, 19, }, {{526.923078, }, {550.594611, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {19, 21, }, {{550.594611, }, {532.850274, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {21, 23, }, {{532.850274, }, {544.184931, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {23, 25, }, {{544.184931, }, {537.907534, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {25, 27, }, {{537.907534, }, {540, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {27, 51, }, {{540, }, {540, }, }, }, 
	}, 
    ["ADBE_Position_1_0_2"]={
        -- {{0.744853079, 0, 0.999, 1, }, {0, 3, }, {{540, }, {540, }, }, },
		{{0.744853079, 0, 0.999, 1, }, {3, 4, }, {{540, }, {508.459724, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {4, 5, }, {{508.459724, }, {701.502206, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {5, 6, }, {{701.502206, }, {389.310576, }, }, }, 
		{{0.33333333, 0, 0.999, 1, }, {6, 7, }, {{389.310576, }, {655.225761, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {7, 8, }, {{655.225761, }, {446.441064, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {8, 9, }, {{446.441064, }, {617.629547, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {9, 10, }, {{617.629547, }, {473.913927, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {10, 11, }, {{473.913927, }, {585.994128, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {11, 12, }, {{585.994128, }, {491.784302, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {12, 13, }, {{491.784302, }, {577.025184, }, }, }, 
		{{0.33333333, 0, 0.7, 1, }, {13, 14, }, {{577.025184, }, {525.084743, }, }, }, 
		{{0.3, 0, 0.66666667, 1, }, {14, 15, }, {{525.084743, }, {571.197607, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {15, 17, }, {{571.197607, }, {526.923078, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {17, 18, }, {{526.923078, }, {550.594611, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {18, 20, }, {{550.594611, }, {532.850274, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {20, 22, }, {{532.850274, }, {544.184931, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {22, 24, }, {{544.184931, }, {537.907534, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {24, 26, }, {{537.907534, }, {540, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {26, 51, }, {{540, }, {540, }, }, }, 
	}, 
	["ADBE_Scale_0_3"]={
		{{0.5,0.5,0.5, 0.03,0.03,0.5, 0.5,0.5,0.5, 0.98,0.98,0.5, }, {0, 51, }, {{80, 68, 100, }, {100, 100, 100, }, }, }, 
	}, 
	["ADBE_Opacity_0_4"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 5, }, {{66, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 51, }, {{100, }, {100, }, }, }, 
	}, 
    ["ADBE_IE_5a1ff1b7caffac514aaba44-0001_0_0"]={
        {{1, 0.1, 0.999, 1, }, {0, 5, }, {{-2, }, {3.5, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 6, }, {{3.5, }, {4, }, }, }, 
		{{0.001, 0, 0, 1, }, {6, 8, }, {{4, }, {0, }, }, }, 
		{{0.33333333, 0, 0.833333333, 0.833333333, }, {8, 9, }, {{0, }, {2.5, }, }, }, 
		{{0.166666667, 0.166666667, 0.66666667, 1, }, {9, 10, }, {{2.5, }, {0, }, }, }, 
		{{0.33333333, 0.33333333, 0.66666667, 0.66666667, }, {10, 11, }, {{0, }, {0, }, }, }, 
		{{0.33333333, 0, 0.833333333, 0.833333333, }, {11, 12, }, {{0, }, {0.8, }, }, }, 
		{{0.166666667, 0.166666667, 0.66666667, 1, }, {12, 18, }, {{0.8, }, {0, }, }, }, 
    }, 

    ["jiaosan_Scale_0_0"]={
		{{0.35,0.35,0.35, 0.673959184,0.673959184,0.35, 0.999,0.999,0.999, 1,1,0.999, }, {5, 27, }, {{76, 76, 100, }, {300, 300, 100, }, }, }, 
        {{0.35,0.35,0.35, 0.673959184,0.673959184,0.35, 0.999,0.999,0.999, 1,1,0.999, }, {27, 51, }, {{300, 300, 100, }, {300, 300, 100, }, }, }, 
	}, 
	["jiaosan_Opacity_0_1"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {4, 5, }, {{0, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 22, }, {{100, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {22, 27, }, {{100, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {27, 51, }, {{0, }, {0, }, }, }, 
	}, 
	["jiaosan_Scale_1_2"]={
		{{0.41,0.41,0.41, 0.57810219,0.57810219,0.41, 0.999,0.999,0.999, 1,1,0.999, }, {5, 51, }, {{26, 26, 100, }, {300, 300, 100, }, }, }, 
	}, 
	["jiaosan_Opacity_1_3"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {8, 15, }, {{0, }, {50, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {15, 45, }, {{50, }, {50, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {45, 51, }, {{50, }, {0, }, }, }, 
	}, 
	["jiaosan_Scale_2_4"]={
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {0, 4, }, {{110, 110, 100, }, {57, 57, 100, }, }, }, 
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {4, 51, }, {{57, 57, 100, }, {57, 57, 100, }, }, }, 
	}, 
	["jiaosan_Opacity_2_5"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {3, 5, }, {{100, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 51, }, {{0, }, {0, }, }, }, 
	}, 

    ["ADBE_Marker_0_0"]={
    }, 
    ["APC_Caustics_0012_0_1"]={
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {3, 5, }, {{0.6, }, {0.2, }, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 36, }, {{0.2, }, {0.2, }, }, }, 
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {20, 23, }, {{0.2, }, {0.2, }, }, }, 
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {23, 28, }, {{0.1, }, {0.1, }, }, }, 
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {28, 30, }, {{0.1, }, {0.1, }, }, }, 
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {30, 33, }, {{0.1, }, {0.1, }, }, }, 
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {33, 36, }, {{0.1, }, {0.1, }, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {36, 42, }, {{0.2, }, {0, }, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {42, 51, }, {{0, }, {0, }, }, }, 
        
    }, 
    ["APC_Caustics_0082_0_2"]={
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 4, }, {{0.8, }, {1.6, }, }, }, 
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {4, 5, }, {{1.8, }, {1.6, }, }, }, 
        -- {{0.42, 0, 0.999, 1, }, {5, 20, }, {{1.6, }, {1.4, }, }, }, 
        -- {{0.42, 0, 0.999, 1, }, {20, 24, }, {{1.4, }, {1.4, }, }, }, 
        -- {{0.42, 0, 0.999, 1, }, {24, 26, }, {{1.4, }, {1.4, }, }, },
        -- {{0.42, 0, 0.999, 1, }, {26, 30, }, {{1.4, }, {1.2, }, }, }, 
        -- {{0.42, 0, 0.999, 1, }, {30, 33, }, {{1.2, }, {0.7, }, }, }, 
        -- {{0.42, 0, 0.999, 1, }, {33, 36, }, {{0.7, }, {0.2, }, }, }, 
        -- {{0.42, 0, 0.999, 1, }, {36, 42, }, {{0.2, }, {0.1, }, }, }, 
        -- {{0.42, 0, 0.999, 1, }, {42, 51, }, {{0.1, }, {0.0, }, }, }, 
        -- {{0.42, 0, 0.999, 1, }, {49, 51, }, {{0.6, }, {0.4, }, }, }, 
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 5, }, {{1.2, }, {0.4, }, }, }, 
		-- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 23, }, {{0.4, }, {0.34, }, }, }, 
		-- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {23, 49, }, {{0.34, }, {0, }, }, }, 


        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 4, }, {{0.8, }, {1.8, }, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {4, 5, }, {{1.8, }, {1.6, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 23, }, {{0.75, }, {0.65, }, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {23, 27, }, {{0.6, }, {0.15, }, }, },
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {27, 31, }, {{0.15, }, {0.1, }, }, },
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {31, 36, }, {{0.11, }, {0.05, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {36, 51, }, {{0.05, }, {0, }, }, }, 
    }, 
    ["BLUR_1"]={
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 4, }, {{1.2, }, {1.2, }, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {4, 5, }, {{1.2, }, {1.5, }, }, }, 
        {{0.42, 0, 0.999, 1, }, {5, 23, }, {{1.5, }, {2.5, }, }, }, 
        {{0.42, 0, 0.999, 1, }, {23, 51, }, {{2.5, }, {3.0, }, }, }, 
    }, 
    ["ADBE_Opacity_0_1"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 14, }, {{100, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {13, 51, }, {{88, }, {88, }, }, }, 
        -- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {20, 51, }, {{88, }, {88, }, }, }, 
	}, 
    
}
function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)
    -- self.animSeqCom = comp.entity.scene:findEntityBy("imgMovePass"):getComponent("AnimSeqComponent")
    -- self.resultMaterial = comp.entity.scene:findEntityBy("result"):getComponent("MeshRenderer").material 
    self.attrs = AETools:new(ae_attribute)
    -- self.tableCom = comp.entity.scene:findEntityBy("Table"):getComponent("TableComponent").table

    self.props    = comp.entity:getComponent("ScriptComponent").properties
    
    self.pass0Mat = comp.entity.scene:findEntityBy("Pass0"):getComponent("MeshRenderer").material
    
    self.putSdfTexMat = comp.entity.scene:findEntityBy("putSdfTex"):getComponent("MeshRenderer").material
    self.waveMat = comp.entity.scene:findEntityBy("wave"):getComponent("MeshRenderer").material
    self.matMotion = comp.entity.scene:findEntityBy("motion_blur_2d"):getComponent("MeshRenderer").material
    self.animSeqCom = comp.entity.scene:findEntityBy("wave"):getComponent("AnimSeqComponent")
    self.bulr_x = comp.entity.scene:findEntityBy("blurX"):getComponent("MeshRenderer").material
    self.bulr_y = comp.entity.scene:findEntityBy("blurY"):getComponent("MeshRenderer").material
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


    -- local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    local AEprogress = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    -- local input1 = Amaz.BuiltinObject.getUserTexture("#TransitionInput0")
    -- local input2 = Amaz.BuiltinObject.getUserTexture("#TransitionInput1")
    -- if input1 and input2 then
    --     self.input1 = input1
    --     self.input2 = input2
    --     -- self.pass0Mat:setTex("inputImageTexture", input1)
    --     self.pass0Mat:setTex("inputImageTexture1", input2)
    --     -- self.curTime = Amaz.Input.frameTimestamp;
    --     AEProgress = Amaz.Input.frameTimestamp;
    -- end
    -- AEProgress =AEProgress*38/41
    -- local fps = AEProgress*82
    -- if fps>17 then
    --     fps = (fps-17)*0.8+17
    -- end
    local progress = AEprogress
    local frameTime = 1./51.
    local frameTime2 = 1./102.
    self.animSeqCom:seek(math.min(math.floor(progress*51),51))
    -- Amaz.LOGI("progress",math.min(math.floor(progress*51),51))

    local inputWidth_pre = self.attrs:GetVal("ADBE_Position_0_0_1pre", math.max(0., progress))[1]
    local inputHeight_pre = self.attrs:GetVal("ADBE_Position_1_0_2", math.max(0., progress-frameTime))[1]

    local inputWidth = self.attrs:GetVal("ADBE_Position_0_0_1", math.max(0, progress))[1]
    local inputHeight = self.attrs:GetVal("ADBE_Position_1_0_2", math.max(0, progress))[1]
    
    local scale_1 = self.attrs:GetVal("ADBE_Scale_0_3", math.max(0., progress - frameTime2))[1]/100
    local scale_2 = self.attrs:GetVal("ADBE_Scale_0_3", math.max(0., progress - frameTime2))[2]/100

    local curscale_1 = self.attrs:GetVal("ADBE_Scale_0_3", math.max(frameTime2, progress))[1]/100
    local curscale_2 = self.attrs:GetVal("ADBE_Scale_0_3", math.max(frameTime2, progress))[2]/100

    local u_Intensity = self.attrs:GetVal("ADBE_IE_5a1ff1b7caffac514aaba44-0001_0_0", AEprogress)[1]

    -- Amaz.LOGI("inputWidth",inputWidth)
    -- Amaz.LOGI("inputWidth_pre",inputWidth_pre)

    -- Amaz.LOGI("inputHeight",inputHeight)
    -- Amaz.LOGI("inputHeight_pre",inputHeight_pre)



    self.matMotion:setVec2("CurrScale", Amaz.Vector2f(curscale_1, curscale_2))
    self.matMotion:setVec2("PrevScale", Amaz.Vector2f(scale_1, scale_2))

    self.matMotion:setVec2("CurrOffset", Amaz.Vector2f(inputWidth/1080.-0.5, inputHeight/1080.-0.5 ))
    self.matMotion:setVec2("PrevOffset", Amaz.Vector2f(inputWidth_pre/1080.-0.5, inputHeight_pre/1080.-0.5))
    
    -- Amaz.LOGI("inputWidth_pre",inputWidth_pre)
    -- Amaz.LOGI("inputHeight_pre",inputHeight_pre)
    
    self.matMotion:setFloat("u_Intensity",u_Intensity)
    

    local jiaosan_scale_1 = self.attrs:GetVal("jiaosan_Scale_0_0", AEprogress)[1]/100
    local jiaosan_scale_2 = self.attrs:GetVal("jiaosan_Scale_1_2", AEprogress)[1]/100
    local jiaosan_scale_3 = (self.attrs:GetVal("jiaosan_Scale_2_4", AEprogress)[1]+43)/100

    local jiaosan_Opacity_1 = self.attrs:GetVal("jiaosan_Opacity_0_1", AEprogress)[1]/100
    local jiaosan_Opacity_2 = self.attrs:GetVal("jiaosan_Opacity_1_3", AEprogress)[1]/100
    local jiaosan_Opacity_3 = self.attrs:GetVal("jiaosan_Opacity_2_5", AEprogress)[1]/100
    
    self.putSdfTexMat:setFloat("scale_1",jiaosan_scale_1)
    self.putSdfTexMat:setFloat("scale_2",jiaosan_scale_2)
    self.putSdfTexMat:setFloat("scale_3",jiaosan_scale_3)

    self.putSdfTexMat:setFloat("opacity_1",jiaosan_Opacity_1)
    self.putSdfTexMat:setFloat("opacity_2",jiaosan_Opacity_2)
    self.putSdfTexMat:setFloat("opacity_3",jiaosan_Opacity_3)
    -- Amaz.LOGI("opacity_3",jiaosan_Opacity_3)



    local waveProgressIns = self.attrs:GetVal("APC_Caustics_0012_0_1", progress)[1]
    self.waveMat:setFloat("waveProgressIns",1.)

    local stepIns = self.attrs:GetVal("APC_Caustics_0082_0_2", progress)[1]*0.95


    local opacity = self.attrs:GetVal("ADBE_Opacity_0_4", AEprogress)[1]/100

    local light_opacity = self.attrs:GetVal("ADBE_Opacity_0_1", AEprogress)[1]/100
    self.waveMat:setFloat("opacity",opacity)
    self.waveMat:setFloat("light_opacity",light_opacity)
    
    self.waveMat:setFloat("stepIns",stepIns)

    self.waveMat:setFloat("baseTexWidth",self.width)
    self.waveMat:setFloat("baseTexHeight",self.height)
    self.putSdfTexMat:setFloat("baseTexWidth",self.width)
    self.putSdfTexMat:setFloat("baseTexHeight",self.height)

    -- self.resultMaterial:setFloat("iTime",t)
    -- local blurSize = self.attrs:GetVal("BLUR_1", AEprogress)[1]
    -- self.bulr_x:setFloat("blurSize",blurSize)
    -- self.bulr_y:setFloat("blurSize",blurSize)
    
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
