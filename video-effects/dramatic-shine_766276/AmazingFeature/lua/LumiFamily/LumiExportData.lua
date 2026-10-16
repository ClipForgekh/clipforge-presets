local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_41-trs'] = {
        ['nodeDuration'] = {{0, 3.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.03333333333333}, },
        },
    },
    ['LumiRadialBlur_46-effect0'] = {
        ['nodeDuration'] = {{0, 2.96666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.03333333333333}, },
        },
    },
    ['LumiExposure_46-effect1'] = {
        ['nodeDuration'] = {{0, 2.96666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.96666666666667}, },
        },
    },
    ['LumiLayer_46-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.96666666666667}, },
            ['baseTex'] = {{0, 3.03333333333333}, },
        },
    },
    ['LumiSShake_48-effect0'] = {
        ['nodeDuration'] = {{0, 2.96666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.03333333333333}, },
        },
    },
    ['LumiLayer_48-blend'] = {
        ['nodeDuration'] = {{0, 3.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.96666666666667}, },
            ['baseTex'] = {{0, 3.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_41-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(34.0243902439024, 34.0243902439025, 34.0243902439024),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 360,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiRadialBlur_46-effect0'] = {
        ['blurType'] = 1,
        ['amount'] = 127.5,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiExposure_46-effect1'] = {
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
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_46-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 90,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 1,
    },
    ['LumiSShake_48-effect0'] = {
        ['ampRatio'] = 0.05555555555556,
        ['frqRatio'] = 10.2941176470588,
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
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_48-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_41-trs#position#vector'] =
{
	{
		{0.287016, 0.004949, 0, 0.982759, }, 
		{0, 0.333333, }, 
		{{540, 1261, 0, }, {540, 564.033271725, 0, }, {540, 1261, 0, }, {540, 564.033271725, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.170924, 0.170667, 0.125285, 1, }, 
		{0.333333, 1, }, 
		{{540, 564.033271725, 0, }, {540, 540, 0, }, {540, 564.033271725, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0, 1.366667, }, 
		{{30, 30, 30, }, {35, 35, 35, }, }, 
		{6414, }, 
		{1, }, 
	}, 
	{
		{0.941279011,0.941279011,0.941279011, 0.016894821,0.016894821,0.016894821, 0,0,0, 1.000000101,1.000000101,1.000000101, }, 
		{1.366667, 1.833333, }, 
		{{35, 35, 35, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41-trs#yRotation#number'] =
{
	{
		{0.169630081, -3e-9, 0.038695942, 0.876168662, }, 
		{0, 0.466667, }, 
		{{0, }, {347.01799, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.288779064, 1.136416428, 0.619800708, 1.000000316, }, 
		{0.466667, 1, }, 
		{{347.01799, }, {360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_46-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.2, 1.2, }, 
		{{60, }, {135, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExposure_46-effect1#exposure#number'] =
{
	{
		{0.969736911, -1.6e-8, 0.867881507, 1.000000026, }, 
		{1.2, 1.6, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.139331492, 7e-8, 0.118830152, 1.000000068, }, 
		{1.6, 2, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_46-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.2, 1.2, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.2, 1.6, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.528852878, 1, }, 
		{1.6, 2, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_48-effect0#ampRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.2, 0.4, }, 
		{{0.2, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.4, 0.766667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.766667, 1.366667, }, 
		{{0, }, {0.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.366667, 1.533333, }, 
		{{0.1, }, {0.2, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.533333, 1.9, }, 
		{{0.2, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSShake_48-effect0#frqRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.2, 0.4, }, 
		{{25, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.4, 0.8, }, 
		{{5, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 1.366667, }, 
		{{5, }, {15, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.366667, 1.533333, }, 
		{{15, }, {25, }, }, 
		{6417, }, 
		{2, }, 
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
