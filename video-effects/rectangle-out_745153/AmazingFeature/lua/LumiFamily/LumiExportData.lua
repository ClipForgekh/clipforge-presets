local data = {}

local ae_compDurations = {0, 1.2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiSaturation_25-effect0', 'InputTex', 0},
    {'LumiRadialWipe_192-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiSaturation_25-effect0'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiContrast_25-effect1'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiVignette_25-effect2'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiMotionBlur2D_25-effect3'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiRadialWipe_192-effect0'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiRadialWipe_192-effect1'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiRadialWipe_192-effect2'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiRadialWipe_192-effect3'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiMotionBlur2D_192-effect4'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiDropShadow_192-effect5'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiDropShadow_192-effect6'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiLayer_192-blend'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
            ['baseTex'] = {{0, 1.2}, },
        },
    },
    ['LumiExposure_209-effect0'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiLayer_209-blend'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
            ['baseTex'] = {{0, 1.2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiSaturation_25-effect0'] = {
        ['saturationIntensity'] = -0.7,
    },
    ['LumiContrast_25-effect1'] = {
        ['contrastIntensity'] = 0.8,
        ['pivot'] = 0.43000000715256,
    },
    ['LumiVignette_25-effect2'] = {
        ['color'] = Amaz.Color(0, 0, 0, 1),
        ['amount'] = 0.2,
        ['midpoint'] = 0.5,
        ['roundness'] = 0,
        ['feather'] = 0.5,
        ['highlight'] = 0,
        ['transparent'] = false,
    },
    ['LumiMotionBlur2D_25-effect3'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.40309554884696, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.40309554884696, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.2,
        ['ae_pre_scale_x'] = 1.2,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiRadialWipe_192-effect0'] = {
        ['progress'] = 0.5,
        ['rotation'] = 0,
        ['wipeCenter'] = Amaz.Vector2f(0.125, 0.55833333333333),
        ['wipeMode'] = 1,
        ['feather'] = 0,
        ['stride'] = 1,
        ['quality'] = 0.5,
    },
    ['LumiRadialWipe_192-effect1'] = {
        ['progress'] = 0.5,
        ['rotation'] = 90,
        ['wipeCenter'] = Amaz.Vector2f(0.49166666666667, 0.74166666666667),
        ['wipeMode'] = 1,
        ['feather'] = 0,
        ['stride'] = 1,
        ['quality'] = 0.5,
    },
    ['LumiRadialWipe_192-effect2'] = {
        ['progress'] = 0.5,
        ['rotation'] = 180,
        ['wipeCenter'] = Amaz.Vector2f(0.875, 0.49833333333333),
        ['wipeMode'] = 1,
        ['feather'] = 0,
        ['stride'] = 1,
        ['quality'] = 0.5,
    },
    ['LumiRadialWipe_192-effect3'] = {
        ['progress'] = 0.5,
        ['rotation'] = 270,
        ['wipeCenter'] = Amaz.Vector2f(0.51666666666667, 0.28),
        ['wipeMode'] = 1,
        ['feather'] = 0,
        ['stride'] = 1,
        ['quality'] = 0.5,
    },
    ['LumiMotionBlur2D_192-effect4'] = {
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
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiDropShadow_192-effect5'] = {
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['shadowOpacity'] = 0.5,
        ['shadowAngle'] = 134,
        ['shadowDistance'] = 30,
        ['width'] = 20,
        ['onlyShadow'] = false,
    },
    ['LumiDropShadow_192-effect6'] = {
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['shadowOpacity'] = 0.5,
        ['shadowAngle'] = 314,
        ['shadowDistance'] = 30,
        ['width'] = 20,
        ['onlyShadow'] = false,
    },
    ['LumiLayer_192-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
    ['LumiExposure_209-effect0'] = {
        ['channelType'] = 0,
        ['exposure'] = 0,
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
    },
    ['LumiLayer_209-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_25-effect3#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.117402, 0.33, 1, }, 
		{0.64, 1.24, }, 
		{{0.40309554884667, 0.5, }, {-0.64666666666667, 0.5, }, {0.40309554884667, 0.5, }, {-0.50083333333334, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_25-effect3#position#vector'] =
{
	{
		{0.166667, 0.117402, 0.33, 1, }, 
		{0.6, 1.2, }, 
		{{0.40309554884667, 0.5, }, {-0.64666666666667, 0.5, }, {0.40309554884667, 0.5, }, {-0.50083333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiRadialWipe_192-effect0#wipeCenter#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0, 0.12, }, 
		{{-0.155, 0.555, }, {0.125, 0.55833333333333, }, {-0.10833333333333, 0.55555555557211, }, {0.07833333333333, 0.55777777776122, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiRadialWipe_192-effect1#wipeCenter#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0, 0.12, }, 
		{{0.46166666666667, 1.075, }, {0.49166666666667, 0.74166666666667, }, {0.46666666666667, 1.01944444656372, }, {0.48666666666667, 0.79722222010295, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiRadialWipe_192-effect2#wipeCenter#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0, 0.12, }, 
		{{1.075, 0.48833333333333, }, {0.875, 0.49833333333333, }, {1.04166666666667, 0.49, }, {0.90833333333333, 0.49666666666667, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiRadialWipe_192-effect3#wipeCenter#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0, 0.12, }, 
		{{0.52, -0.05333333333333, }, {0.51666666666667, 0.28, }, {0.51944444442789, 0.00222222010295, }, {0.51722222223878, 0.22444444656372, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur2D_192-effect4#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.635995, 0.635995, }, 
		{0.04, 0.64, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.33, 1, }, 
		{0.64, 1.24, }, 
		{{0.5, 0.5, }, {1.375, 0.5, }, {0.5, 0.5, }, {1.52083333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_192-effect4#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.635995, 0.635995, }, 
		{0, 0.6, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.33, 1, }, 
		{0.6, 1.2, }, 
		{{0.5, 0.5, }, {1.375, 0.5, }, {0.5, 0.5, }, {1.52083333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiExposure_209-effect0#exposure#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 0.08, }, 
		{{0, }, {3.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.71, 0, 0.29, 1, }, 
		{0.08, 0.24, }, 
		{{3.6, }, {0, }, }, 
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
