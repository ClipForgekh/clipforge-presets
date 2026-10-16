local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_48-effect0'] = {
        ['nodeDuration'] = {{-0.63333333333333, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.3, 2}, },
        },
    },
    ['LumiLayer_48-blend'] = {
        ['nodeDuration'] = {{-0.63333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.63333333333333, 1.36666666666667}, },
            ['baseTex'] = {{0.3, 2}, },
        },
    },
    ['LumiOpticsCompensation_50-effect0'] = {
        ['nodeDuration'] = {{-0.63333333333333, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.63333333333333, 2}, },
        },
    },
    ['LumiLayer_50-blend'] = {
        ['nodeDuration'] = {{-0.63333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.63333333333333, 1.36666666666667}, },
            ['baseTex'] = {{-0.63333333333333, 2}, },
        },
    },
    ['LumiSShake_52-effect0'] = {
        ['nodeDuration'] = {{0.33333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.63333333333333, 2}, },
        },
    },
    ['LumiLayer_52-blend'] = {
        ['nodeDuration'] = {{-0.63333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.33333333333333, 0.66666666666667}, },
            ['baseTex'] = {{-0.63333333333333, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_48-effect0'] = {
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
        ['vIntensity'] = 1,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 720),
    },
    ['LumiLayer_48-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiOpticsCompensation_50-effect0'] = {
        ['fov'] = 25.1999965667725,
        ['inverseLensDistortion'] = true,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 720),
    },
    ['LumiLayer_50-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiSShake_52-effect0'] = {
        ['ampRatio'] = 0.125,
        ['frqRatio'] = 0.27500000130385,
        ['phase0'] = 0,
        ['scale0'] = 1,
        ['blurEnabled'] = false,
        ['blurIntensity'] = 1,
        ['blurQuality'] = 0,
        ['seed'] = 0,
        ['xFill'] = 2,
        ['yFill'] = 2,
        ['xAmpR'] = 192,
        ['xFrqR'] = 1,
        ['xAmp'] = 0,
        ['xFrq'] = 0.5,
        ['xPhase'] = 0,
        ['yAmpR'] = 192,
        ['yFrqR'] = 1,
        ['yAmp'] = 0,
        ['yFrq'] = 0.5,
        ['yPhase'] = 0,
        ['zAmpR'] = 0,
        ['zFrqR'] = 1,
        ['zAmp'] = 0,
        ['zFrq'] = 0.5,
        ['zPhase'] = 0,
        ['wAmpR'] = 0,
        ['wFrqR'] = 1,
        ['wAmp'] = 0,
        ['wFrq'] = 0.5,
        ['wPhase'] = 0,
        ['rAmpRatio'] = 1,
        ['gAmpRatio'] = 1,
        ['bAmpRatio'] = 1,
        ['rPhase'] = 0,
        ['gPhase'] = 0,
        ['bPhase'] = 0,
        ['rgbRnd'] = 0,
        ['rgbFrq'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 720),
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
    ['LumiMotionBlur2D_48-effect0#ae_pre_rotate#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.33333333333333, 0.53333333333333, }, 
		{{-22, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#rotate#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.3, 0.5, }, 
		{{-22, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.10000033333333, 0.33333333333333, }, 
		{{1, }, {0.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.33333333333333, 0.53333333333333, }, 
		{{0.8, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.066667, 0.3, }, 
		{{1, }, {0.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.3, 0.5, }, 
		{{0.8, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#ae_pre_scale_y#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.10000033333333, 0.33333333333333, }, 
		{{1, }, {0.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.33333333333333, 0.53333333333333, }, 
		{{0.8, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#scale_y#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.066667, 0.3, }, 
		{{1, }, {0.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.3, 0.5, }, 
		{{0.8, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiOpticsCompensation_50-effect0#fov#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.3, }, 
		{{0, }, {125.999983, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.3, 0.633333, }, 
		{{125.999983, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSShake_52-effect0#ampRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.6, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSShake_52-effect0#frqRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.6, }, 
		{{1.5, }, {0.1, }, }, 
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
