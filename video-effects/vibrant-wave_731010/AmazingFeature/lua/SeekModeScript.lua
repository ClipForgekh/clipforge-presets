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
--@input float curTime = 0.0{"widget":"slider","min":0,"max":50}
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
    ["quantity_01"]={
        {{0.0001, 0, 0.4, 1, }, {10, 50, }, {{0, }, {0, }, }, }, 
		{{0.0001, 0, 0.4, 1, }, {10, 50, }, {{0.22, }, {0.22, }, }, }, 
	}, 
	["ADBE_IE_92959d1fb849aa97f8ff858-0001_0_0"]={
		{{0.0001, 0, 0.4, 1, }, {14, 50, }, {{5, }, {0, }, }, }, 
	}, 
	["ADBE_IE_92959d1fb849aa97f8ff858-0004_0_1"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 1, }, {{0, }, {26.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {1, 2, }, {{26.666667, }, {53.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {2, 3, }, {{53.333333, }, {80, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {3, 4, }, {{80, }, {106.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {4, 5, }, {{106.666667, }, {133.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 6, }, {{133.333333, }, {160, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {6, 7, }, {{160, }, {186.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {7, 8, }, {{186.666667, }, {213.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {8, 9, }, {{213.333333, }, {240, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {9, 10, }, {{240, }, {266.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {10, 11, }, {{266.666667, }, {293.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {11, 12, }, {{293.333333, }, {320, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {12, 13, }, {{320, }, {346.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {13, 14, }, {{346.666667, }, {373.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {14, 15, }, {{373.333333, }, {400, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {15, 16, }, {{400, }, {426.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 17, }, {{426.666667, }, {453.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {17, 18, }, {{453.333333, }, {480, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {18, 19, }, {{480, }, {506.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {19, 20, }, {{506.666667, }, {533.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {20, 21, }, {{533.333333, }, {560, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {21, 22, }, {{560, }, {586.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {22, 23, }, {{586.666667, }, {613.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {23, 24, }, {{613.333333, }, {640, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {24, 25, }, {{640, }, {666.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {25, 26, }, {{666.666667, }, {693.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {26, 27, }, {{693.333333, }, {720, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {27, 28, }, {{720, }, {746.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {28, 29, }, {{746.666667, }, {773.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {29, 30, }, {{773.333333, }, {800, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {30, 31, }, {{800, }, {826.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {31, 32, }, {{826.666667, }, {853.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {32, 33, }, {{853.333333, }, {880, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {33, 34, }, {{880, }, {906.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {34, 35, }, {{906.666667, }, {933.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {35, 36, }, {{933.333333, }, {960, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {36, 37, }, {{960, }, {986.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {37, 38, }, {{986.666667, }, {1013.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {38, 39, }, {{1013.333333, }, {1040, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {39, 40, }, {{1040, }, {1066.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {40, 41, }, {{1066.666667, }, {1093.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {41, 42, }, {{1093.333333, }, {1120, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {42, 43, }, {{1120, }, {1146.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {43, 44, }, {{1146.666667, }, {1173.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {44, 45, }, {{1173.333333, }, {1200, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {45, 46, }, {{1200, }, {1226.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {46, 47, }, {{1226.666667, }, {1253.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {47, 48, }, {{1253.333333, }, {1280, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {48, 49, }, {{1280, }, {1306.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {49, 50, }, {{1306.666667, }, {1333.333333, }, }, }, 
	}, 
	["ADBE_IE_92959d1fb849aa97f8ff858-0007_0_2"]={
		{{0.0001, 0, 0.4, 1, }, {10, 50, }, {{0, }, {10, }, }, }, 
	}, 
	["ADBE_Motion_Blur_0001_0_3"]={
		{{0.33333333, 0, 0.66666667, 1, }, {1, 2, }, {{25, }, {-15, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {2, 3, }, {{-15, }, {40, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {3, 4, }, {{40, }, {-22, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {4, 5, }, {{-22, }, {20, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {5, 8, }, {{20, }, {0, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {8, 11, }, {{0, }, {-85, }, }, }, 
	}, 
	["ADBE_Motion_Blur_0002_0_4"]={
		{{0.33333333, 0, 0.66666667, 0.77777778, }, {0, 2, }, {{100, }, {150, }, }, }, 
		{{0.33333333, -0.512820508, 0.66666667, 1, }, {2, 14, }, {{150, }, {20, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {14, 30, }, {{20, }, {0, }, }, }, 
	}, 
	["ADBE_Exposure2_0003_0_5"]={
		{{0.001, 0, 0.2, 1, }, {0, 26, }, {{2, }, {0, }, }, }, 
	}, 
	["ADBE_Position_0_6"]={
		{{0.333333, 0, 0.666667, 1, }, {0, 1, }, {{1160.771712642, -219.86143472, 0, }, {425.314239502, 1106.282592773, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {1, 2, }, {{425.314239502, 1106.282592773, 0, }, {277.592884399, 577.385874321, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {2, 3, }, {{277.592884399, 577.385874321, 0, }, {524.003492337, 295.49209996, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {3, 4, }, {{524.003492337, 295.49209996, 0, }, {655.047088135, 658.680386274, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {4, 5, }, {{655.047088135, 658.680386274, 0, }, {411.315240602, 403.129592632, 0, }, }, }, 
		{{0.255564, 0, 0.221805, 0.790203, }, {5, 8, }, {{411.315240602, 403.129592632, 0, }, {513.367294312, 759.7421875, 0, }, }, }, 
		{{0.567642, 0.265384, 0.344086, 0.846673, }, {8, 12, }, {{513.367294312, 759.7421875, 0, }, {512.296736888, 474.552054754, 0, }, }, }, 
		{{0.347397, 0.137294, 0.677323, 1, }, {12, 16, }, {{512.296736888, 474.552054754, 0, }, {513.067808584, 643.237615462, 0, }, }, }, 
		{{0.088464, 0, 0.231321, 1, }, {16, 24, }, {{513.067808584, 643.237615462, 0, }, {553.367294312, 541.4921875, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {24, 31, }, {{553.367294312, 541.4921875, 0, }, {526.75, 538.5, 0, }, }, }, 
		{{0.197737, 0, 0.66117, 0.890789, }, {31, 38, }, {{526.75, 538.5, 0, }, {553.196778394, 541.883700411, 0, }, }, }, 
		{{0.14618, 0, 0, 1, }, {38, 45, }, {{553.196778394, 541.883700411, 0, }, {540, 540, 0, }, }, }, 
	}, 
	["ADBE_Scale_0_7"]={
		{{0.039434894,0.039434894,0.166666667, 0.000493149,0.000493149,0.166666667, 0.443378337,0.443378337,0, 0.99999997,0.99999997,0, }, {13, 44, }, {{100, 100, 100, }, {160, 160, 100, }, }, }, 
	}, 
	["ADBE_Rotate_Z_0_8"]={
		{{0.361378217, 0.461660127, 0.58, 1, }, {5, 8, }, {{4, }, {-4, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {8, 11, }, {{-4, }, {8, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {11, 15, }, {{8, }, {-2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {15, 23, }, {{-2, }, {1, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {23, 30, }, {{1, }, {-0.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {30, 36, }, {{-0.5, }, {0, }, }, }, 
	}, 
	["ADBE_Opacity_0_9"]={
        -- {{0.139819367, 0.570876209, 0.440547907, 0.878163729, }, {0, 13, }, {{0, }, {0, }, }, },
        -- {{0.139819367, 0.570876209, 0.440547907, 0.878163729, }, {13, 18, }, {{50, }, {100, }, }, },
		{{0.139819367, 0.570876209, 0.440547907, 0.878163729, }, {18, 50, }, {{100, }, {0, }, }, }, 
	}, 


	
	["ADBE_IE_92959d1fb849aa97f8ff858-0001_1_10"]={
		{{0.0001, 0, 0.4, 1, }, {14, 50, }, {{5, }, {0, }, }, }, 
	}, 
	["ADBE_IE_92959d1fb849aa97f8ff858-0004_1_11"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 1, }, {{0, }, {26.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {1, 2, }, {{26.666667, }, {53.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {2, 3, }, {{53.333333, }, {80, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {3, 4, }, {{80, }, {106.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {4, 5, }, {{106.666667, }, {133.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {5, 6, }, {{133.333333, }, {160, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {6, 7, }, {{160, }, {186.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {7, 8, }, {{186.666667, }, {213.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {8, 9, }, {{213.333333, }, {240, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {9, 10, }, {{240, }, {266.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {10, 11, }, {{266.666667, }, {293.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {11, 12, }, {{293.333333, }, {320, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {12, 13, }, {{320, }, {346.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {13, 14, }, {{346.666667, }, {373.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {14, 15, }, {{373.333333, }, {400, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {15, 16, }, {{400, }, {426.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {16, 17, }, {{426.666667, }, {453.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {17, 18, }, {{453.333333, }, {480, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {18, 19, }, {{480, }, {506.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {19, 20, }, {{506.666667, }, {533.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {20, 21, }, {{533.333333, }, {560, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {21, 22, }, {{560, }, {586.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {22, 23, }, {{586.666667, }, {613.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {23, 24, }, {{613.333333, }, {640, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {24, 25, }, {{640, }, {666.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {25, 26, }, {{666.666667, }, {693.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {26, 27, }, {{693.333333, }, {720, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {27, 28, }, {{720, }, {746.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {28, 29, }, {{746.666667, }, {773.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {29, 30, }, {{773.333333, }, {800, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {30, 31, }, {{800, }, {826.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {31, 32, }, {{826.666667, }, {853.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {32, 33, }, {{853.333333, }, {880, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {33, 34, }, {{880, }, {906.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {34, 35, }, {{906.666667, }, {933.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {35, 36, }, {{933.333333, }, {960, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {36, 37, }, {{960, }, {986.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {37, 38, }, {{986.666667, }, {1013.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {38, 39, }, {{1013.333333, }, {1040, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {39, 40, }, {{1040, }, {1066.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {40, 41, }, {{1066.666667, }, {1093.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {41, 42, }, {{1093.333333, }, {1120, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {42, 43, }, {{1120, }, {1146.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {43, 44, }, {{1146.666667, }, {1173.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {44, 45, }, {{1173.333333, }, {1200, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {45, 46, }, {{1200, }, {1226.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {46, 47, }, {{1226.666667, }, {1253.333333, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {47, 48, }, {{1253.333333, }, {1280, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {48, 49, }, {{1280, }, {1306.666667, }, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {49, 50, }, {{1306.666667, }, {1333.333333, }, }, }, 
	}, 
	["ADBE_IE_92959d1fb849aa97f8ff858-0007_1_12"]={
		{{0.0001, 0, 0.4, 1, }, {10, 50, }, {{0, }, {10, }, }, }, 
	}, 
	["PEDG_0002_1_13"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 4, }, {{4, }, {4, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {4, 24, }, {{4, }, {0, }, }, },  
	}, 
	["ADBE_Motion_Blur_0001_1_14"]={
		{{0.33333333, 0, 0.66666667, 1, }, {1, 2, }, {{25, }, {-15, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {2, 3, }, {{-15, }, {40, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {3, 4, }, {{40, }, {-22, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {4, 5, }, {{-22, }, {20, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {5, 8, }, {{20, }, {0, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {8, 11, }, {{0, }, {-85, }, }, }, 
	}, 
	["ADBE_Motion_Blur_0002_1_15"]={
		{{0.33333333, 0, 0.66666667, 0.77777778, }, {0, 2, }, {{100, }, {150, }, }, }, 
		{{0.33333333, -0.512820508, 0.66666667, 1, }, {2, 14, }, {{150, }, {20, }, }, }, 
		{{0.33333333, 0, 0.66666667, 1, }, {14, 30, }, {{20, }, {0, }, }, }, 
	}, 
	["ADBE_Exposure2_0003_1_16"]={
		{{0.001, 0, 0.4, 1, }, {0, 24, }, {{2, }, {0, }, }, }, 
	}, 
	["ADBE_Position_1_17"]={
		{{0.333333, 0, 0.666667, 1, }, {0, 1, }, {{1160.771712642, -219.86143472, 0, }, {425.314239502, 1106.282592773, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {1, 2, }, {{425.314239502, 1106.282592773, 0, }, {277.592884399, 577.385874321, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {2, 3, }, {{277.592884399, 577.385874321, 0, }, {524.003492337, 295.49209996, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {3, 4, }, {{524.003492337, 295.49209996, 0, }, {655.047088135, 658.680386274, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {4, 5, }, {{655.047088135, 658.680386274, 0, }, {411.315240602, 403.129592632, 0, }, }, }, 
		{{0.255564, 0, 0.221805, 0.790203, }, {5, 8, }, {{411.315240602, 403.129592632, 0, }, {513.367294312, 759.7421875, 0, }, }, }, 
		{{0.567642, 0.265384, 0.344086, 0.846673, }, {8, 12, }, {{513.367294312, 759.7421875, 0, }, {512.296736888, 474.552054754, 0, }, }, }, 
		{{0.347397, 0.137294, 0.677323, 1, }, {12, 16, }, {{512.296736888, 474.552054754, 0, }, {513.067808584, 643.237615462, 0, }, }, }, 
		{{0.088464, 0, 0.231321, 1, }, {16, 24, }, {{513.067808584, 643.237615462, 0, }, {553.367294312, 541.4921875, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {24, 31, }, {{553.367294312, 541.4921875, 0, }, {526.75, 538.5, 0, }, }, }, 
		{{0.197737, 0, 0.66117, 0.890789, }, {31, 38, }, {{526.75, 538.5, 0, }, {553.196778394, 541.883700411, 0, }, }, }, 
		{{0.14618, 0, 0, 1, }, {38, 45, }, {{553.196778394, 541.883700411, 0, }, {540, 540, 0, }, }, }, 
	}, 
	["ADBE_Rotate_Z_1_18"]={
        {{0.361378217, 0.461660127, 0.58, 1, }, {5, 8, }, {{4, }, {-4, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {8, 11, }, {{-4, }, {8, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {11, 15, }, {{8, }, {-2, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {15, 23, }, {{-2, }, {1, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {23, 30, }, {{1, }, {-0.5, }, }, }, 
		{{0.42, 0, 0.58, 1, }, {30, 36, }, {{-0.5, }, {0, }, }, }, 
	}, 
    ["dddd"]={
		{{0.166666667, 0, 0.833333333, 1, }, {0, 1, }, {{0.35, }, {0.35, }, }, }, 
		-- {{0.33333333, 0, 0.66666667, 1, }, {1, 1, }, {{0.15, }, {0.35, }, }, }, 
        {{0.33333333, 0, 0.66666667, 1, }, {1, 2, }, {{0.15, }, {0.35, }, }, }, 
        {{0.33333333, 0, 0.66666667, 1, }, {2, 5, }, {{0.45, }, {0.45, }, }, },
        {{0.33333333, 0, 0.66666667, 1, }, {5, 6, }, {{0.15, }, {0.15, }, }, }, 
        {{0.33333333, 0, 0.66666667, 1, }, {6, 7, }, {{0.15, }, {0, }, }, },
        {{0.33333333, 0, 0.66666667, 1, }, {7, 24, }, {{0, }, {0, }, }, },
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
            self.curTime= props:get("curTime")/50.
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
    self.transformMaterial1 = comp.entity.scene:findEntityBy("transform1"):getComponent("MeshRenderer").material
    self.transformMaterial2 = comp.entity.scene:findEntityBy("transform2"):getComponent("MeshRenderer").material
    self.Horizontal_Blur = comp.entity.scene:findEntityBy("Horizontal_Blur"):getComponent("MeshRenderer").material
    self.Horizontal_Blur2 = comp.entity.scene:findEntityBy("Horizontal_Blur2"):getComponent("MeshRenderer").material
    self.Displacement = comp.entity.scene:findEntityBy("Displacement"):getComponent("MeshRenderer").material
    self.color = comp.entity.scene:findEntityBy("color"):getComponent("MeshRenderer").material
    -- self.S_Glow = comp.entity.scene:findEntityBy("Deep_Glow_Root"):getComponent("ScriptComponent").properties
    self.Displacement_properties = comp.entity.scene:findEntityBy("TurbulenceDisplacement"):getComponent("ScriptComponent").properties
    self.BlendPass = comp.entity.scene:findEntityBy("Deep_Glow_Root"):searchEntity("Blend"):getComponent("MeshRenderer").material
    self.Displacement_mat = comp.entity.scene:findEntityBy("TurbulenceDisplacement"):searchEntity("Displacement"):getComponent("MeshRenderer").material
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

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
    end


    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    local progress = t 
    local angle1 = self.attrs:GetVal("ADBE_Rotate_Z_1_18", progress)[1]
    local moveSize1X = self.attrs:GetVal("ADBE_Position_1_17", progress)[1]
    local moveSize1Y = self.attrs:GetVal("ADBE_Position_1_17", progress)[2]
    local angle1 = self.attrs:GetVal("ADBE_Rotate_Z_1_18", progress)[1]
    local u_Intensity = self.attrs:GetVal("ADBE_Exposure2_0003_1_16", progress)[1]

    self.transformMaterial1:setVec2("moveSize1",Amaz.Vector2f(moveSize1X,moveSize1Y))
    self.transformMaterial1:setFloat("angle1",angle1)

    self.transformMaterial1:setFloat("u_Intensity",u_Intensity)


    local angle2 = self.attrs:GetVal("ADBE_Rotate_Z_0_8", progress)[1]
    local moveSize2X = self.attrs:GetVal("ADBE_Position_0_6", progress)[1]
    local moveSize2Y = self.attrs:GetVal("ADBE_Position_0_6", progress)[2]
    local size2 = self.attrs:GetVal("ADBE_Scale_0_7", progress)[1]/100.
    local opcity2 = self.attrs:GetVal("ADBE_Opacity_0_9", progress)[1]/100.
    local u_Intensity2 = self.attrs:GetVal("ADBE_Exposure2_0003_0_5", progress)[1]

    self.transformMaterial2:setVec2("moveSize2",Amaz.Vector2f(moveSize2X,moveSize2Y))
    self.transformMaterial2:setFloat("angle2",angle2)
    self.transformMaterial2:setVec2("size2",Amaz.Vector2f(size2,size2))
    self.transformMaterial2:setFloat("u_Intensity",u_Intensity2)
    self.BlendPass:setFloat("opcity2",opcity2)
    Amaz.LOGI("opcity2",opcity2)

    -- self.Horizontal_Blur:setFloat("opcity2",opcity2)

    local u_Sample1 = self.attrs:GetVal("ADBE_Motion_Blur_0002_0_4", progress)[1]
    local u_Angle2 = self.attrs:GetVal("ADBE_Motion_Blur_0001_0_3", progress)[1]
    local u_Angle1 = self.attrs:GetVal("ADBE_Motion_Blur_0001_1_14", progress)[1]
    self.Horizontal_Blur:setFloat("u_Sample", u_Sample1)
    self.Horizontal_Blur:setFloat("u_Angle1", 90.-(u_Angle1+angle1))
    -- self.resultMaterial:setFloat("iTime",t)
    -- local u_Sample2 = self.attrs:GetVal("ADBE_Motion_Blur_0002_0_4", progress)[1]
    
    -- self.Horizontal_Blur:setFloat("u_Sample", u_Sample1)
    self.Horizontal_Blur2:setFloat("u_Angle1", 90.-(u_Angle2+angle2))
    self.Horizontal_Blur2:setFloat("u_Sample", u_Sample1)
    self.Horizontal_Blur2:setFloat("u_Steps", 1.)
    self.Horizontal_Blur2:setFloat("u_ExpandFlag", 0.)


    local rl_size = self.attrs:GetVal("ADBE_IE_92959d1fb849aa97f8ff858-0001_0_0", progress)[1]/85.
    local evolution = self.attrs:GetVal("ADBE_IE_92959d1fb849aa97f8ff858-0004_0_1", progress)[1]
    local offset_y = self.attrs:GetVal("ADBE_IE_92959d1fb849aa97f8ff858-0007_0_2", progress)[1]/100.
    self.Displacement_properties:set("size",rl_size)
    self.Displacement_properties:set("evolution",evolution)
    -- if w>=h then
    --    self.Displacement_properties:set("quantity",1.125*w/h)
    --    Amaz.LOGE("self.width>=self.height",w)
    --    Amaz.LOGE("self.height",h)
    -- else
    --     self.Displacement_properties:set("quantity",1.125)
    --     Amaz.LOGE("self.width<self.height",w)
    --     Amaz.LOGE("self.height",h)
    -- end
    self.Displacement_properties:set("quantity",1.1)
    self.Displacement_properties:set("offset_y",offset_y)
    self.Displacement_mat:setFloat("width",self.width)
    self.Displacement_mat:setFloat("height",self.height)

    local brightness = self.attrs:GetVal("PEDG_0002_1_13", progress)[1]/10.
    self.BlendPass:setFloat("u_GlowIntensity", brightness)
    local colorInt = self.attrs:GetVal("dddd", progress)[1]
    self.color:setFloat("colorInt", colorInt)
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
