local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_1257-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiMotionBlur2D_1622-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiExposure_1622-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiDirectionalBlurs_1622-effect2'] = {
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
    ['LumiMotionBlur2D_1632-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_1632-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_1257-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiMotionBlur2D_1622-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.51732411346615, 0.48494133479441),
        ['ae_pre_position'] = Amaz.Vector2f(0.51732411346615, 0.48494133479441),
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
    ['LumiExposure_1622-effect1'] = {
        ['channelType'] = 0,
        ['exposure'] = 1.68,
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
    ['LumiDirectionalBlurs_1622-effect2'] = {
        ['blurIntensity'] = 11.4290887046767,
        ['angle'] = 270,
        ['directionNum'] = 1.45,
        ['exposure'] = 1,
        ['quality'] = 1,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_1622-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_1632-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
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
    ['LumiLayer_1632-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_1257-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
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
    ['LumiExposure_1622-effect1#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.933333, }, 
		{{3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDirectionalBlurs_1622-effect2#blurIntensity#number'] =
{
	{
		{0.182859926, 7e-9, 0.228818738, 0.999999971, }, 
		{0.066667, 0.666667, }, 
		{{150, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1632-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.03333333333333, 0.26666633333333, }, 
		{{-1.70364583333333, 0.5, }, {0.5, 0.5, }, {-1.70364583333333, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1632-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0, 0.233333, }, 
		{{-1.70364583333333, 0.5, }, {0.5, 0.5, }, {-1.70364583333333, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
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
