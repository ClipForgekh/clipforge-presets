local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiSShake_28-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiDirectionalBlurs_28-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSoftGlow_28-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_28-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiSShake_28-effect0'] = {
        ['ampRatio'] = 0.2,
        ['frqRatio'] = 3.00000000000001,
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
    },
    ['LumiDirectionalBlurs_28-effect1'] = {
        ['blurIntensity'] = 0,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
    },
    ['LumiSoftGlow_28-effect2'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 1,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 2.4,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
    },
    ['LumiLayer_28-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(500, 500, 0),
        ['scale'] = Amaz.Vector3f(30, 30, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiSShake_28-effect0#ampRatio#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.8, }, 
		{{0.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_28-effect1#blurIntensity#number'] =
{
	{
		{1, -8.8e-8, 0.66666667, 1, }, 
		{0, 0.480013, }, 
		{{0, }, {200, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.480013, 0.719987, }, 
		{{200, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_28-effect2#thresholdLow#number'] =
{
	{
		{1, 2.41e-7, 0.66666667, 1, }, 
		{0, 0.466667, }, 
		{{1, }, {0.11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.67318101, -1.16e-7, 0.750185925, 0.999999995, }, 
		{0.466667, 0.8, }, 
		{{0.11, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.501327599, 7.5e-8, 0.66666667, 1, }, 
		{0.8, 1.1, }, 
		{{1, }, {0.11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.764524639, -1.27e-7, 0.765055852, 0.999999979, }, 
		{1.1, 1.49707, }, 
		{{0.11, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs#scale#vector'] =
{
	{
		{1,1,0.33333333, 5e-8,5e-8,0.33333333, 0.582580937,0.582580937,0.66666667, 0.999999948,0.999999948,0.66666667, }, 
		{0, 0.480013, }, 
		{{30, 30, 100, }, {114, 114, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0,0,0.166666667, 0.833333333,0.833333333,0.833333333, 1,1,0.833333333, }, 
		{0.480013, 1, }, 
		{{114, 114, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
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
