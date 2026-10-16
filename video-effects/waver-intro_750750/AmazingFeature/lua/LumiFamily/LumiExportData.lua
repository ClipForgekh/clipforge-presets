local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiTurbulenceDisplacement_52-effect0', 'InputTex', 0},
    {'LumiLayer_52-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiTurbulenceDisplacement_52-effect0'] = {
        ['nodeDuration'] = {{-0.03333333333333, 3.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.06666666666667}, },
        },
    },
    ['LumiLayer_52-blend'] = {
        ['nodeDuration'] = {{-0.03333333333333, 3.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.03333333333333, 3.06666666666667}, },
            ['baseTex'] = {{0, 3.06666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiTurbulenceDisplacement_52-effect0'] = {
        ['size'] = 0.03702500240254,
        ['quantity'] = 4.10526315789474,
        ['complexity'] = 2.03,
        ['evolution'] = 224,
        ['cycle'] = 100,
        ['offset_x'] = -3.2,
        ['offset_y'] = 0,
        ['type'] = 0,
        ['fix_type'] = 1,
        ['picture_scale'] = 1,
        ['motion_tile_type'] = 0,
        ['qualityType'] = 3,
    },
    ['LumiLayer_52-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiTurbulenceDisplacement_52-effect0#size#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0, 0.733333, }, 
		{{-0.07, }, {0.03709354, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.733333, 1.933333, }, 
		{{0.03709354, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_52-effect0#quantity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.9, }, 
		{{3.5, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = false
data.ae_reverseKeyframes = ae_reverseKeyframes

local ae_sliderInfos = {
}
data.ae_sliderInfos = ae_sliderInfos

local ae_fadeinInfos = {
    time = 0,
    infos = {
    }
}
data.ae_fadeinInfos = ae_fadeinInfos

local ae_fadeoutInfos = {
    time = 0,
    infos = {
    }
}
data.ae_fadeoutInfos = ae_fadeoutInfos

local ae_animationInfos = {
    animationMode = 0,
    loopStart = 0,
    speedInfo = {1, 0, 1, },
}
data.ae_animationInfos = ae_animationInfos

return data
