local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_1630-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_1630-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiMotionBlur2D_1622-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiRadialBlur_1622-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiExposure_1622-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1622-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_1630-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.98876917555359,
        ['ae_pre_scale_x'] = 0.98876917555359,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_1630-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_1622-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.49839020137671, 0.52572308377215),
        ['ae_pre_position'] = Amaz.Vector2f(0.49839020137671, 0.52572308377215),
        ['unifiedScale'] = true,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRadialBlur_1622-effect1'] = {
        ['blurType'] = 0,
        ['amount'] = 3.54091171954149,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiExposure_1622-effect2'] = {
        ['channelType'] = 0,
        ['exposure'] = 1.92,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_1622-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_1630-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.273375607, 7e-9, 0.319334397, 0.999999963, }, 
		{0.03333333333333, 0.50000033333333, }, 
		{{0.3, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1630-effect0#scale_x#number'] =
{
	{
		{0.273375607, 7e-9, 0.319334397, 0.999999963, }, 
		{0, 0.466667, }, 
		{{0.3, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1622-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0.327471, 0.666667, 0.663125, }, 
		{0.10000033333333, 0.20371133333333, }, 
		{{0.5, 0.5, }, {0.5, 0.33333331346481, }, {0.5, 0.5, }, {0.5, 0.33333331346481, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.323207, 0.666667, 0.758448, }, 
		{0.20371133333333, 0.35924433333333, }, 
		{{0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, {0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.442228, 0.666667, 0.805525, }, 
		{0.35924433333333, 0.51481133333333, }, 
		{{0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, {0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.511618, 0.666667, 0.771171, }, 
		{0.51481133333333, 0.67037733333333, }, 
		{{0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, {0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.419221, 0.666667, 0.726777, }, 
		{0.67037733333333, 0.82591133333333, }, 
		{{0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.33587, 0.666667, 0.814417, }, 
		{0.82591133333333, 0.92962233333333, }, 
		{{0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.641979, 0.666667, 1, }, 
		{0.92962233333333, 1.03333333333333, }, 
		{{0.5, 0.5046296417713, }, {0.5, 0.5, }, {0.5, 0.5046296417713, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1622-effect0#position#vector'] =
{
	{
		{0.333333, 0.327471, 0.666667, 0.663125, }, 
		{0.066667, 0.170378, }, 
		{{0.5, 0.5, }, {0.5, 0.33333331346481, }, {0.5, 0.5, }, {0.5, 0.33333331346481, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.323207, 0.666667, 0.758448, }, 
		{0.170378, 0.325911, }, 
		{{0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, {0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.442228, 0.666667, 0.805525, }, 
		{0.325911, 0.481478, }, 
		{{0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, {0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.511618, 0.666667, 0.771171, }, 
		{0.481478, 0.637044, }, 
		{{0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, {0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.419221, 0.666667, 0.726777, }, 
		{0.637044, 0.792578, }, 
		{{0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.33587, 0.666667, 0.814417, }, 
		{0.792578, 0.896289, }, 
		{{0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.641979, 0.666667, 1, }, 
		{0.896289, 1, }, 
		{{0.5, 0.5046296417713, }, {0.5, 0.5, }, {0.5, 0.5046296417713, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_1622-effect1#amount#number'] =
{
	{
		{0.234548317, 5e-9, 0.198098315, 0.999999983, }, 
		{0, 0.5, }, 
		{{150, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiExposure_1622-effect2#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.933333, }, 
		{{3, }, {0, }, }, 
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
