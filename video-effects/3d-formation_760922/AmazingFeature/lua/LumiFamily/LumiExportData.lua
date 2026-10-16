local data = {}

local ae_compDurations = {0, 1.36666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBrightness3DTwist_887-effect0'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiDeepGlow_887-effect1'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBrightness3DTwist_887-effect0'] = {
        ['twistAngle'] = -239.649960821379,
        ['twistAxis'] = 0,
        ['rotationX'] = 0,
        ['rotationY'] = 0,
        ['rotationZ'] = 0,
        ['focalLength'] = -2,
        ['grid'] = true,
        ['invertGrid'] = false,
        ['gridHorizontalNumber'] = 5,
        ['gridVerticalNumber'] = 5,
        ['gridHorizontalSize'] = 0.3,
        ['gridVerticalSize'] = 0.5625,
        ['AEDesignSize'] = Amaz.Vector2f(500, 500),
    },
    ['LumiDeepGlow_887-effect1'] = {
        ['radius'] = 500,
        ['exposure'] = 0.7349999666214,
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
        ['quality'] = 0.2,
        ['AEDesignSize'] = Amaz.Vector2f(500, 500),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiBrightness3DTwist_887-effect0#twistAngle#number'] =
{
	{
		{0.33333333, 0, 0.079505357, 1.000000029, }, 
		{0, 1.333333, }, 
		{{-359, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBrightness3DTwist_887-effect0#gridHorizontalSize#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBrightness3DTwist_887-effect0#gridVerticalSize#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.533333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDeepGlow_887-effect1#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1, }, 
		{{1.05, }, {0, }, }, 
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
