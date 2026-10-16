local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_760-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiOpticsCompensation_766-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_766-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_766-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiSShake_788-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_788-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_760-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['p0_position'] = Amaz.Vector3f(489.874021232199, 500.000540009821, 0),
        ['p0_scale'] = Amaz.Vector3f(139.358600635331, 139.358600635331, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -2.75510204447316,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
    },
    ['LumiOpticsCompensation_766-effect0'] = {
        ['fov'] = 0,
        ['inverseLensDistortion'] = false,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
    },
    ['LumiRadialBlur_766-effect1'] = {
        ['blurType'] = 3,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 1,
    },
    ['LumiLayer_766-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiSShake_788-effect1'] = {
        ['ampRatio'] = 0.42857142857143,
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
    },
    ['LumiLayer_788-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_760-trs#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.033333, 0.166667, }, 
		{{392, 554, 0, }, {508, 490, 0, }, {411.333333969116, 543.333333015442, 0, }, {508, 490, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.166667, 0.366667, }, 
		{{508, 490, 0, }, {295.656053042, 634.810453494, 0, }, {508, 490, 0, }, {328.586621737068, 616.641864855694, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.366667, 0.566667, }, 
		{{295.656053042, 634.810453494, 0, }, {488, 498, 0, }, {275.653911089485, 645.846118052411, 0, }, {488, 498, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.566667, 0.966667, }, 
		{{488, 498, 0, }, {392, 554, 0, }, {488, 498, 0, }, {399.30565404892, 549.969294071198, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_760-trs#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.033333, 0.266667, }, 
		{{100, 100, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0.33333333,0.33333333, 0.66666667,0.66666667,0.66666667, 0.66666667,0.66666667,0.66666667, }, 
		{0.266667, 0.466667, }, 
		{{200, 200, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0.33333333,0.33333333, 0.66666667,0.66666667,0.66666667, 0.66666667,0.66666667,0.66666667, }, 
		{0.466667, 0.7, }, 
		{{200, 200, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.7, 0.966667, }, 
		{{200, 200, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_760-trs#p0_rotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.033333, 0.266667, }, 
		{{0, }, {-7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.266667, 0.533333, }, 
		{{-7, }, {21, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0.932692308, }, 
		{0.533333, 0.766667, }, 
		{{21, }, {-7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.230769231, 0.66666667, 1, }, 
		{0.766667, 0.966667, }, 
		{{-7, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiOpticsCompensation_766-effect0#fov#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.133333, 0.366667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.366667, 0.533333, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.533333, 0.866667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_766-effect1#amount#number'] =
{
	{
		{0.333333332, 0, 0.666666665, 1, }, 
		{0.133333, 0.266667, }, 
		{{0, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333332, 0, 0.666666665, 1, }, 
		{0.266667, 0.466667, }, 
		{{-15, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333332, 0, 0.666666665, 1, }, 
		{0.466667, 0.7, }, 
		{{15, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333332, 0, 0.66666667, 1, }, 
		{0.7, 0.966667, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_788-effect1#ampRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.266667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 0.766667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.766667, 0.933333, }, 
		{{1, }, {0, }, }, 
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
