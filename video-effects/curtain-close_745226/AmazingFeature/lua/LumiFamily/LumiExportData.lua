local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiVATCloth_27-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiVATCloth_27-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiDropShadow_27-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiVATCloth_27-effect0'] = {
        ['speed'] = 1,
        ['duration'] = 2,
        ['frameCount'] = 90,
        ['interpolation'] = 1,
        ['startFrame'] = 6,
        ['endFrame'] = 90,
        ['lightingBlend'] = 0.09322033898305,
        ['shadowIntensity'] = 0.04661016949153,
        ['shadowContrast'] = 0,
    },
    ['LumiDropShadow_27-effect1'] = {
        ['shadowColor'] = Amaz.Color(0.16092218458652, 0.16092218458652, 0.16092218458652, 1),
        ['shadowOpacity'] = 0.5,
        ['shadowAngle'] = 45,
        ['shadowDistance'] = 55,
        ['width'] = 100,
        ['onlyShadow'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiVATCloth_27-effect0#lightingBlend#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.966667, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiVATCloth_27-effect0#shadowIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.966667, }, 
		{{0.25, }, {0, }, }, 
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
