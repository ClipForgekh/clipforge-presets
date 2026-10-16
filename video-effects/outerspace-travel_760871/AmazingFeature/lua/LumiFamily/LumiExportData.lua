local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_42-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_42-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_74-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_74-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_42-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(506.734654457352, 540, 894.339716968512),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 17.6443149640178,
        ['yRotation'] = -6.13480327710697,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiRadialBlur_74-effect0'] = {
        ['blurType'] = 1,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_74-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_42-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.833333, 0.87194, }, 
		{0, 0.9, }, 
		{{2078, 540, 497, }, {540, 540, 1195, }, {1847.83332824707, 540, 497, }, {770.16667175293, 540, 1277.83333587646, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.281048, 0.601619, 0.376479, }, 
		{0.9, 1.566667, }, 
		{{540, 540, 1195, }, {544.463331111, 540, 650.859394796, }, {421.827934265137, 540, 1152.47174835205, }, {505.17182720475, 540, 990.596058614359, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.9, 0.497948, 0.717161, 1, }, 
		{1.566667, 1.833333, }, 
		{{544.463331111, 540, 650.859394796, }, {540, 540, 0, }, {562.666557200478, 540, 493.463963277445, }, {540, 540, 6.52283334732056, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_42-trs#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.166667, 1.8, }, 
		{{89, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_42-trs#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.768050204, }, 
		{0.166667, 0.976465, }, 
		{{-180, }, {-54, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.359563478, 1.18741615, 0.66666667, 1, }, 
		{0.976465, 1.8, }, 
		{{-54, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_42-trs#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.166667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_74-effect0#amount#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.5, 1.766667, }, 
		{{0, }, {60, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.766667, 1.933333, }, 
		{{60, }, {0, }, }, 
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
