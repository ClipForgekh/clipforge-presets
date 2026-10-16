local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiWarp_1171-effect0', 'InputTex', 0},
    {'LumiLayer_1171-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiWarp_1171-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
        },
    },
    ['LumiLayer_1171-blend'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 2.03333333333333}, },
            ['baseTex'] = {{0, 5}, },
        },
    },
    ['LumiWarp_1170-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
        },
    },
    ['LumiLayer_1170-blend'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 2.03333333333333}, },
            ['baseTex'] = {{0, 5}, },
        },
    },
    ['LumiMotionBlur2D_1173-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
        },
    },
    ['LumiLayer_1173-blend'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 2.03333333333333}, },
            ['baseTex'] = {{0, 5}, },
        },
    },
    ['LumiDirectionalBlurs_1175-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
        },
    },
    ['LumiLayer_1175-blend'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.4}, },
            ['baseTex'] = {{0, 5}, },
        },
    },
    ['LumiFill_1179-effect0'] = {
        ['nodeDuration'] = {{0, 0.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.03333333333333}, },
        },
    },
    ['LumiLayer_1179-blend'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.03333333333333}, },
            ['baseTex'] = {{0, 5}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiWarp_1171-effect0'] = {
        ['warpStyle'] = 3,
        ['warpAxis'] = 0,
        ['bend'] = 0.01727842519648,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_1171-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiWarp_1170-effect0'] = {
        ['warpStyle'] = 14,
        ['warpAxis'] = 1,
        ['bend'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_1170-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_1173-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0,
        ['vCenter'] = 0,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_1173-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiDirectionalBlurs_1175-effect0'] = {
        ['blurIntensity'] = 0,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_1175-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiFill_1179-effect0'] = {
        ['color'] = Amaz.Color(0, 0, 0, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_1179-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiWarp_1171-effect0#bend#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.033333, 0.1, }, 
		{{-8, }, {-41, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.666666665, 0.929083207, }, 
		{0.1, 0.333333, }, 
		{{-41, }, {18.487556, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333334, -0.549121242, 0.666666668, -0.185132258, }, 
		{0.333333, 0.5, }, 
		{{18.487556, }, {13, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333335, 0.193491942, 0.666666668, 1, }, 
		{0.5, 0.566667, }, 
		{{13, }, {-0.444444, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.666666665, 1.008674308, }, 
		{0.566667, 0.7, }, 
		{{-0.444444, }, {-4.234562, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333334, 0.017468739, 0.666666667, 0.815443392, }, 
		{0.7, 1, }, 
		{{-4.234562, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333335, 1.215692259, 0.666666669, 0, }, 
		{1, 1.466667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_1170-effect0#bend#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.033333, 0.1, }, 
		{{83, }, {43, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333331, 0, 0.666666665, 0.836045664, }, 
		{0.1, 0.2, }, 
		{{43, }, {12.727941, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333333, 0.291923452, 0.66666667, 1, }, 
		{0.2, 0.333333, }, 
		{{12.727941, }, {-9.941176, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333331, 0, 0.666666665, -58.999982141, }, 
		{0.333333, 0.5, }, 
		{{-9.941176, }, {-9.825882, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333334, 0.295032615, 0.66666667, 1, }, 
		{0.5, 0.733333, }, 
		{{-9.825882, }, {23, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.733333, 1, }, 
		{{23, }, {-8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.233333, }, 
		{{-8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1173-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.06666633333333, 0.13333333333333, }, 
		{{0.5, 0.03697916666667, }, {0.5, 0.36301200243438, }, {0.5, 0.03697916666667, }, {0.5, 0.36301200243438, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.13333333333333, 0.23333333333333, }, 
		{{0.5, 0.36301200243438, }, {0.5, 0.6309390791349, }, {0.5, 0.36301200243438, }, {0.5, 0.6309390791349, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 0.724625, }, 
		{0.23333333333333, 0.36666633333333, }, 
		{{0.5, 0.6309390791349, }, {0.5, 0.58537885507969, }, {0.5, 0.6309390791349, }, {0.5, 0.58537885507969, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.184951, 0.666667, 1, }, 
		{0.36666633333333, 0.53333333333333, }, 
		{{0.5, 0.58537885507969, }, {0.5, 0.50058489437656, }, {0.5, 0.58537885507969, }, {0.5, 0.50058489437656, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.53333333333333, 0.70000033333333, }, 
		{{0.5, 0.50058489437656, }, {0.5, 0.46918857658073, }, {0.5, 0.50058489437656, }, {0.5, 0.46918857658073, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.70000033333333, 0.93333333333333, }, 
		{{0.5, 0.46918857658073, }, {0.5, 0.5, }, {0.5, 0.46918857658073, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1173-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.033333, 0.1, }, 
		{{0.5, 0.03697916666667, }, {0.5, 0.36301200243438, }, {0.5, 0.03697916666667, }, {0.5, 0.36301200243438, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.1, 0.2, }, 
		{{0.5, 0.36301200243438, }, {0.5, 0.6309390791349, }, {0.5, 0.36301200243438, }, {0.5, 0.6309390791349, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 0.724625, }, 
		{0.2, 0.333333, }, 
		{{0.5, 0.6309390791349, }, {0.5, 0.58537885507969, }, {0.5, 0.6309390791349, }, {0.5, 0.58537885507969, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.184951, 0.666667, 1, }, 
		{0.333333, 0.5, }, 
		{{0.5, 0.58537885507969, }, {0.5, 0.50058489437656, }, {0.5, 0.58537885507969, }, {0.5, 0.50058489437656, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.5, 0.666667, }, 
		{{0.5, 0.50058489437656, }, {0.5, 0.46918857658073, }, {0.5, 0.50058489437656, }, {0.5, 0.46918857658073, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 0.9, }, 
		{{0.5, 0.46918857658073, }, {0.5, 0.5, }, {0.5, 0.46918857658073, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_1175-effect0#blurIntensity#number'] =
{
	{
		{0.33333333, 0, 0.666666667, 0.311425003, }, 
		{0.066667, 0.166667, }, 
		{{200, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333334, 4.820024996, 0.666666668, 1, }, 
		{0.166667, 0.4, }, 
		{{50, }, {0, }, }, 
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
