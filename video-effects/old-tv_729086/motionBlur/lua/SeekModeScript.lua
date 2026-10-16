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
	["ADBE_Position_0_0"]={
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {72, 93, }, {{540, 660, 0, }, {540, 476, 0, }, }, }, 
        {{0.166667, 0.166667, 0.833333, 0.833333, }, {93, 120, }, {{540, 476, 0, }, {540, 476, 0, }, }, }, 
	}, 
    ["S_TVDamage_0053_0_0"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {20, 21, }, {{0, }, {0.35, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {21, 22, }, {{0.35, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {22, 27, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {27, 28, }, {{0, }, {0.6, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {28, 29, }, {{0.6, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {29, 37, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {37, 38, }, {{0, }, {1.1, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {38, 39, }, {{1.1, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {39, 73, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {73, 74, }, {{0, }, {0.5, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {74, 75, }, {{0.5, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {75, 79, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {79, 80, }, {{0, }, {0.35, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {80, 81, }, {{0.35, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {81, 82, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {82, 83, }, {{0, }, {0.8, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {83, 84, }, {{0.8, }, {0, }, }, }, 
	}, 
    ["ADBE_Scale_0_0"]={
		{{0.62,0.62,0.62, 0.62,0.16,0.62, 0.999,0.999,0.999, 0.999,1,0.999, }, {16, 18, }, {{100, 4, 100, }, {100, 100, 100, }, }, }, 
		{{0.276574329,0.276574329,0.276574329, 0.276574329,0.276574329,0.276574329, 0.999021982,0.999021982,0.999021982, 0.999021982,0.999021982,0.999021982, }, {18, 93, }, {{100, 100, 100, }, {100, 100, 100, }, }, }, 
		{{0.25,0.25,0.25, 0.25,0.74,0.25, 0.999,0.999,0.999, 0.999,1,0.999, }, {93, 95, }, {{100, 100, 100, }, {100, 4, 100, }, }, }, 
	}, 
    ["ADBE_Opacity_0_1"]={
		{{1, 0, 0.999, 1, }, {17, 18, }, {{0, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {18, 40, }, {{100, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {40, 41, }, {{100, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {41, 71, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {71, 72, }, {{0, }, {100, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {72, 93, }, {{100, }, {100, }, }, }, 
		{{0.001, 0.49, 0, 1, }, {93, 94, }, {{100, }, {0, }, }, }, 
	}, 
    ["ADBE_Displacement_Map_0003_0_0"]={
		{{0.347935821, -0.005169406, 0.681535203, 1, }, {18, 19, }, {{355, }, {276, }, }, }, 
		{{0.377680703, 0, 0.712789092, 1, }, {19, 21, }, {{276, }, {0, }, }, }, 
		{{0.287210908, 0.287210908, 0.838699459, 0.838699459, }, {21, 90, }, {{0, }, {0, }, }, }, 
		{{0.79, 0.205882353, 0.999, 1, }, {90, 92, }, {{0, }, {340, }, }, }, 
		{{0.3, 0.393194833, 0.7, 0.983626563, }, {92, 93, }, {{340, }, {355, }, }, }, 
	}, 
    ["ADBE_Opacity_0_0"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 17, }, {{0, }, {27, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {17, 40, }, {{27, }, {27, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {40, 41, }, {{27, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {41, 71, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {71, 72, }, {{0, }, {27, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {72, 94, }, {{27, }, {27, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {94, 95, }, {{27, }, {0, }, }, }, 
	}, 
    ["ADBE_Opacity_3_0"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 17, }, {{0, }, {30, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {17, 40, }, {{30, }, {30, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {40, 41, }, {{30, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {41, 71, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {71, 72, }, {{0, }, {30, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {72, 94, }, {{30, }, {30, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {94, 95, }, {{30, }, {0, }, }, }, 
	}, 
    ["ADBE_Opacity_0_5"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 17, }, {{0, }, {50, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {17, 40, }, {{50, }, {50, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {40, 41, }, {{50, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {41, 71, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {71, 72, }, {{0, }, {50, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {72, 94, }, {{50, }, {50, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {94, 95, }, {{50, }, {0, }, }, }, 
	}, 
    ["innerGlow/opacity_0_1"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {39, 40, }, {{20, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {40, 70, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {70, 71, }, {{0, }, {20, }, }, }, 
	}, 
	["solidFill/opacity_0_2"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 17, }, {{33, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {17, 94, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {94, 95, }, {{0, }, {33, }, }, }, 
	}, 
    ["ADBE_WRPMESH_0003_0_0"]={
		{{0.56, 0, 0.73, 1, }, {34, 42, }, {{22, }, {0, }, }, }, 
		{{0.27020526, 0.27020526, 0.609941324, 0.609941324, }, {42, 70, }, {{0, }, {0, }, }, }, 
		{{0.001, 0, 0.58, 1, }, {70, 77, }, {{0, }, {22, }, }, }, 
	}, 
    ["ADBE_Scale_3_3"]={
        {{0.472861839,0.23,0.23, 0.108368698,0.23,0.23, 0.633996106,0.29,0.29, 0.379183513,0.29,0.29, }, {0, 19, }, {{0, 100, 100, }, {66, 100, 100, }, }, }, 
        {{0.337000416,0.337000416,0.337000416, 0.007575547,0.337000416,0.337000416, 0.670553649,0.670553649,0.670553649, 0.980759446,0.670553649,0.670553649, }, {19, 21, }, {{66, 100, 100, }, {81, 100, 100, }, }, }, 
        {{0.335521276,0.335521276,0.335521276, -0.008906976,0,0.335521276, 0.668912682,0.668912682,0.668912682, 1.011403127,1,0.668912682, }, {21, 22, }, {{81, 100, 100, }, {64.5, 100, 100, }, }, }, 
        {{0.335763534,0.335763534,0.335763534, 0.042402001,0,0.335763534, 0.669157436,0.669157436,0.669157436, 0.948835132,1,0.669157436, }, {22, 23, }, {{64.5, 100, 100, }, {69, 100, 100, }, }, }, 
        {{0.336028747,0.336028747,0.336028747, -0.233851103,0.336028747,0.336028747, 0.669425542,0.669425542,0.669425542, 1.271467331,0.669425542,0.669425542, }, {23, 24, }, {{69, 100, 100, }, {68, 100, 100, }, }, }, 
        {{0.336321485,0.336321485,0.336321485, 0.199255254,0.336321485,0.336321485, 0.669721647,0.669721647,0.669721647, 0.774979535,0.669721647,0.669721647, }, {24, 25, }, {{68, 100, 100, }, {69.386095358, 100, 100, }, }, }, 
        {{0.569740975,0.427320821,0.427320821, 0.037828301,0.427320821,0.427320821, 0.908650184,0.785783795,0.785783795, 0.478139069,0.785783795,0.785783795, }, {25, 38, }, {{69.386095358, 100, 100, }, {90.978951869, 100, 100, }, }, }, 
        {{0.2,0.2,0.2, 0,0.2,0.2, 0.33,0.33,0.33, 0.92,0.33,0.33, }, {38, 42, }, {{90.978951869, 100, 100, }, {100, 100, 100, }, }, }, 
        {{0.001,0.001,0.001, 0.001,0.001,0.001, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {42, 70, }, {{100, 100, 100, }, {100, 100, 100, }, }, }, 
        {{0.001,0.001,0.001, 0,0.001,0.001, 0.45,0.45,0.45, 0.94,0.45,0.45, }, {70, 92, }, {{100, 100, 100, }, {66, 100, 100, }, }, }, 
        {{0.001,0.001,0.001, 0,0.001,0.001, 0.45,0.45,0.45, 0.94,0.45,0.45, }, {92, 115, }, {{66, 100, 100, }, {0, 100, 100, }, }, }, 
    }, 
    ["ADBE_Scale_4_4"]={
        {{0.26,0.492352678,0.26, 0.26,0.090854365,0.26, 0.84,0.851354302,0.84, 0.84,0.440645558,0.84, }, {0, 14, }, {{100, 14, 100, }, {100, 45, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {14, 16, }, {{100, 45, 100, }, {100, 20, 100, }, }, }, 
        {{0.001,0.001,0.001, 0.001,0,0.001, 0,0,0, 0,1,0, }, {16, 19, }, {{100, 20, 100, }, {100, 66, 100, }, }, }, 
        {{0.68,0.55452805,0.68, 0,0.291078392,0.68, 0.82,0.784088351,0.82, 1,0.487274163,0.82, }, {19, 34, }, {{100, 66, 100, }, {100, 77.280291971, 100, }, }, }, 
        {{0.997571417,0.765563913,0.997571417, 0,0.141393849,0.997571417, 0.997077458,0.997077458,0.997077458, 1,1,0.997077458, }, {34, 38, }, {{100, 77.280291971, 100, }, {100, 115, 100, }, }, }, 
        {{0.2,0.2,0.2, 0.2,0,0.2, 0.33,0.33,0.33, 0.33,0.92,0.33, }, {38, 42, }, {{100, 115, 100, }, {100, 100, 100, }, }, }, 
        {{0.25,0.25,0.25, 0.25,0.25,0.25, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {42, 70, }, {{100, 100, 100, }, {100, 100, 100, }, }, }, 
        {{0.25,0.25,0.25, 0.25,0,0.25, 0.27,0.27,0.27, 0.27,1,0.27, }, {70, 77, }, {{100, 100, 100, }, {100, 105, 100, }, }, }, 
        {{0.09,0.09,0.09, 0.09,0.05,0.09, 0.39,0.39,0.39, 0.39,0.94,0.39, }, {77, 92, }, {{100, 105, 100, }, {100, 66, 100, }, }, }, 
        {{1,1,1, 1,0,1, 0.999,0.999,0.999, 0.999,1,0.999, }, {92, 95, }, {{100, 66, 100, }, {100, 15.412562814, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {95, 96, }, {{100, 15.412562814, 100, }, {100, 69.882110553, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {96, 97, }, {{100, 69.882110553, 100, }, {100, 17.882110553, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {97, 98, }, {{100, 17.882110553, 100, }, {100, 34.412562814, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {98, 99, }, {{100, 34.412562814, 100, }, {100, 28.412562814, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {99, 115, }, {{100, 28.412562814, 100, }, {100, 14, 100, }, }, }, 
        {{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {115, 116, }, {{100, 14, 100, }, {100, 0, 100, }, }, }, 
    }, 
    ["PEDG_0001_0_0"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 16, }, {{22, }, {120, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 21, }, {{120, }, {150, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {21, 90, }, {{150, }, {150, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {90, 95, }, {{150, }, {120, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {95, 115, }, {{120, }, {22, }, }, }, 
	}, 
	["PEDG_0002_0_1"]={
		{{0.29, 0.730285713, 0.999, 1, }, {16, 21, }, {{2, }, {0.25, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {21, 22, }, {{0.25, }, {0.15, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {22, 37, }, {{0.15, }, {0.1, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {37, 38, }, {{0.1, }, {2.24, }, }, }, 
		{{0.001, 0, 0.58, 1, }, {38, 42, }, {{2.24, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {42, 70, }, {{0, }, {0, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {70, 71, }, {{0, }, {2.24, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {71, 74, }, {{2.24, }, {0.3, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {74, 90, }, {{0.3, }, {0.4, }, }, }, 
		{{0.69, 0.3, 0.999, 1, }, {90, 95, }, {{0.4, }, {2, }, }, }, 
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
local createQuadMesh = function(vertexNumber)
    local customMesh = Amaz.Mesh()
    local customSubMesh = Amaz.SubMesh()
    customSubMesh.primitive = Amaz.Primitive.TRIANGLES
    local pos = Amaz.VertexAttribDesc()
    pos.semantic = Amaz.VertexAttribType.POSITION
    local uv = Amaz.VertexAttribDesc()
    uv.semantic = Amaz.VertexAttribType.TEXCOORD0
    local vads = Amaz.Vector()
    vads:pushBack(pos)
    vads:pushBack(uv)
    customMesh.vertexAttribs = vads
    local vertexData = {}
    local indexData = {}
    for i = 0, vertexNumber - 1 do
        for j = 0, vertexNumber - 1 do
            local x = j / (vertexNumber - 1)
            local y = i / (vertexNumber - 1)
            table.insert(vertexData, #vertexData + 1, x * 2 - 1)
            table.insert(vertexData, #vertexData + 1, y * 2 - 1)
            table.insert(vertexData, #vertexData + 1, 0)
            table.insert(vertexData, #vertexData + 1, x)
            table.insert(vertexData, #vertexData + 1, y)
        end
    end


    for i = 0, vertexNumber - 2 do
        for j = 0, vertexNumber - 2 do
            local k = i * vertexNumber + j
            table.insert(indexData, #indexData + 1, k)
            table.insert(indexData, #indexData + 1, k + 1)
            table.insert(indexData, #indexData + 1, k + vertexNumber)
            table.insert(indexData, #indexData + 1, k + 1)
            table.insert(indexData, #indexData + 1, k + vertexNumber + 1)
            table.insert(indexData, #indexData + 1, k + vertexNumber)
        end
    end
    local fv = Amaz.FloatVector()
    for i = 1, table.getn(vertexData) do
        fv:pushBack(vertexData[i])
    end
    customMesh.vertices = fv
    local indices = Amaz.UInt16Vector()
    for i = 1, table.getn(indexData) do
        indices:pushBack(indexData[i])
    end

    customSubMesh.indices16 = indices
    customSubMesh.mesh = customMesh
    customMesh:addSubMesh(customSubMesh)
    return customMesh
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
    self.animSeqCom = comp.entity.scene:findEntityBy("prePassPass"):getComponent("AnimSeqComponent")
    -- self.material = comp.entity.scene:findEntityBy("SeekModeScript"):getComponent("MeshRenderer").material
    -- self.material2 = comp.entity.scene:findEntityBy("SeekModeScript_2"):getComponent("MeshRenderer").material
    self.prePassMaterial = comp.entity.scene:findEntityBy("prePassPass"):getComponent("MeshRenderer").material
    self.animSeqCom = comp.entity.scene:findEntityBy("prePassPass"):getComponent("AnimSeqComponent")
    self.distortMaterial = comp.entity.scene:findEntityBy("distort"):getComponent("MeshRenderer").material
    self.expandMaterial = comp.entity.scene:findEntityBy("expand"):getComponent("MeshRenderer").material

    self.blurX0Material = comp.entity.scene:findEntityBy("blurX0"):getComponent("MeshRenderer").material
    self.blurY0Material = comp.entity.scene:findEntityBy("blurY0"):getComponent("MeshRenderer").material
    self.blurX1Material = comp.entity.scene:findEntityBy("blurX1"):getComponent("MeshRenderer").material
    self.blurY1Material = comp.entity.scene:findEntityBy("blurY1"):getComponent("MeshRenderer").material
    self.blurX2Material = comp.entity.scene:findEntityBy("blurX2"):getComponent("MeshRenderer").material
    self.blurY2Material = comp.entity.scene:findEntityBy("blurY2"):getComponent("MeshRenderer").material
    self.blurX3Material = comp.entity.scene:findEntityBy("blurX3"):getComponent("MeshRenderer").material
    self.blurY3Material = comp.entity.scene:findEntityBy("blurY3"):getComponent("MeshRenderer").material
    self.blurX4Material = comp.entity.scene:findEntityBy("blurX4"):getComponent("MeshRenderer").material
    self.blurY4Material = comp.entity.scene:findEntityBy("blurY4"):getComponent("MeshRenderer").material
    self.blurX5Material = comp.entity.scene:findEntityBy("blurX5"):getComponent("MeshRenderer").material
    self.blurY5Material = comp.entity.scene:findEntityBy("blurY5"):getComponent("MeshRenderer").material

    self.resultPassMaterial = comp.entity.scene:findEntityBy("resultPass"):getComponent("MeshRenderer").material

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
    self.expand_mr = comp.entity.scene:findEntityBy("expand"):getComponent("MeshRenderer")
    self.mesh = createQuadMesh(25)
    self.expand_mr.mesh = self.mesh
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
    -- self.material:setFloat("uTime", time)
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.prePassMaterial:setFloat("baseTexWidth", w)
        self.prePassMaterial:setFloat("baseTexHeight", h)
        self.distortMaterial:setFloat("baseTexWidth", w)
        self.distortMaterial:setFloat("baseTexHeight", h)
        self.expandMaterial:setFloat("baseTexWidth", w)
        self.expandMaterial:setFloat("baseTexHeight", h)

        self.blurX0Material:setFloat("baseTexWidth", w)
        self.blurX0Material:setFloat("baseTexHeight", h)
        self.blurY0Material:setFloat("baseTexWidth", w)
        self.blurY0Material:setFloat("baseTexHeight", h)

        self.blurX1Material:setFloat("baseTexWidth", w)
        self.blurX1Material:setFloat("baseTexHeight", h)
        self.blurY1Material:setFloat("baseTexWidth", w)
        self.blurY1Material:setFloat("baseTexHeight", h)

        self.blurX2Material:setFloat("baseTexWidth", w)
        self.blurX2Material:setFloat("baseTexHeight", h)
        self.blurY2Material:setFloat("baseTexWidth", w)
        self.blurY2Material:setFloat("baseTexHeight", h)

        self.blurX3Material:setFloat("baseTexWidth", w)
        self.blurX3Material:setFloat("baseTexHeight", h)
        self.blurY3Material:setFloat("baseTexWidth", w)
        self.blurY3Material:setFloat("baseTexHeight", h)

        self.blurX4Material:setFloat("baseTexWidth", w)
        self.blurX4Material:setFloat("baseTexHeight", h)
        self.blurY4Material:setFloat("baseTexWidth", w)
        self.blurY4Material:setFloat("baseTexHeight", h)

        self.blurX5Material:setFloat("baseTexWidth", w)
        self.blurX5Material:setFloat("baseTexHeight", h)
        self.blurY5Material:setFloat("baseTexWidth", w)
        self.blurY5Material:setFloat("baseTexHeight", h)
        -- self.blurX0Material
        -- self.material2:setFloat("baseTexWidth", w)
        -- self.material2:setFloat("baseTexHeight", h)
    end
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("blurSize") then
    --     self.GlowRange = props:get("blurSize")
    -- end
    -- self.prePassMaterial:setFloat("ins", props:get("ins"))
    -- self.prePassMaterial:setFloat("centerX", props:get("centerX"))
    -- local controls = {0.21,-0.46,0.33,0.45}

    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    if t>1 then
        t=1
    end
    local AEProgress = (t*45.5+70)/120
    -- Amaz.LOGI("AEProgress",(AEProgress*25))

    local imgHSize = self.attrs:GetVal("ADBE_Scale_0_0", AEProgress)[2]/100
    self.prePassMaterial:setFloat("imgHSize", imgHSize)

    
    local lineMove = self.attrs:GetVal("ADBE_Position_0_0", AEProgress)[2]-660
    self.prePassMaterial:setFloat("lineMove", lineMove)

    local lineIns = self.attrs:GetVal("ADBE_Opacity_0_1", AEProgress)[1]/100
    self.prePassMaterial:setFloat("lineIns", lineIns)

    self.animSeqCom:seekToTime(t*50/30)
    local distortIns = self.attrs:GetVal("S_TVDamage_0053_0_0", AEProgress)[1]/0.8
    self.distortMaterial:setFloat("distortIns",distortIns)

    local displaymentIns = self.attrs:GetVal("ADBE_Displacement_Map_0003_0_0", AEProgress)[1]
    self.distortMaterial:setFloat("displaymentIns",displaymentIns)

    local blueIns = self.attrs:GetVal("ADBE_Opacity_0_0", AEProgress)[1]/100
    self.prePassMaterial:setFloat("blueIns", blueIns)

    local darkAngleIns = self.attrs:GetVal("ADBE_Opacity_3_0", AEProgress)[1]/100
    self.prePassMaterial:setFloat("darkAngleIns", darkAngleIns)

    local colnoiseIns = self.attrs:GetVal("ADBE_Opacity_0_5", AEProgress)[1]/100
    self.prePassMaterial:setFloat("colnoiseIns", colnoiseIns)

    local innerGlowIns = self.attrs:GetVal("innerGlow/opacity_0_1", AEProgress)[1]/100
    self.prePassMaterial:setFloat("innerGlowIns", innerGlowIns)

    local whiteIns = self.attrs:GetVal("solidFill/opacity_0_2", AEProgress)[1]/100
    self.prePassMaterial:setFloat("whiteIns", whiteIns)

    local expandIns = self.attrs:GetVal("ADBE_WRPMESH_0003_0_0", AEProgress)[1]/22
    self.expandMaterial:setFloat("expandIns", expandIns)

    local xSize = self.attrs:GetVal("ADBE_Scale_3_3", AEProgress)[1]/100
    self.expandMaterial:setFloat("xSize", xSize)

    local ySize = self.attrs:GetVal("ADBE_Scale_4_4", AEProgress)[2]/100
    self.expandMaterial:setFloat("ySize", ySize)

    local blurRadiusAdjust = self.attrs:GetVal("PEDG_0001_0_0", AEProgress)[1]/150
    self.blurX0Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurX1Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurX2Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurX3Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurX4Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurX5Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurY0Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurY1Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurY2Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurY3Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurY4Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)
    self.blurY5Material:setFloat("blurRadiusAdjust", blurRadiusAdjust)

    local blurInsAdjust = self.attrs:GetVal("PEDG_0002_0_1", AEProgress)[1]
    self.resultPassMaterial:setFloat("blurInsAdjust", blurInsAdjust)
    Amaz.LOGI("blurInsAdjust",(blurInsAdjust))
    -- blurInsAdjust

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
