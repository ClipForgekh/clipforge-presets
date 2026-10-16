local data = {}

local ae_compDurations = {0, 0.5}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiOpticsCompensation_63-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiOpticsCompensation_63-effect0'] = {
        ['nodeDuration'] = {{0, 0.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.36666666666667}, },
        },
    },
    ['LumiDeepGlow_63-effect1'] = {
        ['nodeDuration'] = {{0, 0.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.36666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiOpticsCompensation_63-effect0'] = {
        ['fov'] = 0,
        ['inverseLensDistortion'] = true,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(504, 504),
    },
    ['LumiDeepGlow_63-effect1'] = {
        ['radius'] = 0,
        ['exposure'] = 0,
        ['threshold'] = 0,
        ['thresholdSmooth'] = 0,
        ['greyScale'] = 0,
        ['blendMode'] = 1,
        ['view'] = 1,
        ['ratio'] = 1,
        ['rotate'] = 0,
        ['ca'] = false,
        ['redOffset'] = 0.0025,
        ['greenOffset'] = 0,
        ['blueOffset'] = -0.0025,
        ['tint'] = false,
        ['tintMode'] = 1,
        ['tintColor'] = Amaz.Color(1, 0, 0, 1),
        ['tintMix'] = 1,
        ['sourceOpacity'] = 1,
        ['unmult'] = true,
        ['gammaCorrect'] = true,
        ['gammaValue'] = 2,
        ['glowIter'] = 8,
        ['stepsMult'] = 1.5,
        ['downSample'] = 0.80000001192093,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(504, 504),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiOpticsCompensation_63-effect0#fov#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0, 0.333333, }, 
		{{0, }, {170, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDeepGlow_63-effect1#radius#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0, 0.333333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDeepGlow_63-effect1#exposure#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0, 0.333333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
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
