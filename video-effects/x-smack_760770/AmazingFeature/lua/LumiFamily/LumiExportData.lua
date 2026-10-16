local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLinearWipe_29-effect0', 'InputTex', 0},
    {'LumiLinearWipe_28-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_29-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_28-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_29-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiSShake_32-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiFill_32-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiSoftGlow_32-effect2'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_32-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_29-effect0'] = {
        ['progress'] = 0.72483711816939,
        ['rotation'] = -32,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiLinearWipe_28-effect0'] = {
        ['progress'] = 0.72483711816939,
        ['rotation'] = 148,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiLayer_29-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiSShake_32-effect0'] = {
        ['ampRatio'] = 0,
        ['frqRatio'] = 8,
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiFill_32-effect1'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiSoftGlow_32-effect2'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0.5,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 0,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiLayer_32-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLinearWipe_29-effect0#progress#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0, 0.666667, }, 
		{{1, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.666667, 1, }, 
		{{0.5, }, {0.55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{1, 1.333333, }, 
		{{0.55, }, {0.55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.333333, 1.666667, }, 
		{{0.55, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_29-effect0#rotation#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.666667, 1, }, 
		{{-32, }, {-32, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1, 1.333333, }, 
		{{-32, }, {34, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_28-effect0#progress#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0, 0.666667, }, 
		{{1, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.666667, 1, }, 
		{{0.5, }, {0.55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{1, 1.333333, }, 
		{{0.55, }, {0.55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.333333, 1.666667, }, 
		{{0.55, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_28-effect0#rotation#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.666667, 1, }, 
		{{148, }, {148, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1, 1.333333, }, 
		{{148, }, {214, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_32-effect0#ampRatio#number'] =
{
	{
		{0.166666667, 0, 0.66666667, 1, }, 
		{0.566667, 0.666667, }, 
		{{0, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.666667, 0.766667, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.766667, 1.566667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.66666667, 1, }, 
		{1.566667, 1.666667, }, 
		{{0, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.666667, 1.766667, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiFill_32-effect1#opacity#number'] =
{
	{
		{0.166666667, 0, 0.66666667, 1, }, 
		{0.6, 0.666667, }, 
		{{0, }, {0.63, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.666667, 0.733333, }, 
		{{0.63, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_32-effect2#exposure#number'] =
{
	{
		{0.166666667, 0, 0.66666667, 1, }, 
		{1.566667, 1.666667, }, 
		{{0, }, {3.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.666667, 1.766667, }, 
		{{3.4, }, {0, }, }, 
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
