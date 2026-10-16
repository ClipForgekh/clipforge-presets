local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLightSensation_71-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiNegative_71-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSaturation_71-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_71-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiGlitchSignal_73-effect0'] = {
        ['nodeDuration'] = {{-0.03333333333333, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_73-effect1'] = {
        ['nodeDuration'] = {{-0.03333333333333, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.03333333333333, 1.8}, },
        },
    },
    ['LumiLayer_73-trs-blend'] = {
        ['nodeDuration'] = {{-0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.03333333333333, 1.8}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLightSensation_71-effect0'] = {
        ['lightIntensity'] = 1,
    },
    ['LumiNegative_71-effect1'] = {
        ['negativeAlpha'] = 1,
    },
    ['LumiSaturation_71-effect2'] = {
        ['saturationIntensity'] = -1,
    },
    ['LumiLayer_71-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 7.14636043612366,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGlitchSignal_73-effect0'] = {
        ['lowQuality'] = 1,
        ['filterIntensity'] = 0.12,
        ['sharpen'] = 0,
        ['sharpenSize'] = 0,
        ['chromaNoise'] = 0,
        ['hueNoise'] = 0.1,
        ['chromaloss'] = 0,
        ['moireNoise'] = 0.15230769230769,
        ['moireSize'] = 0.92,
        ['moireSpeed'] = 0.08,
        ['randomSeed'] = 0,
        ['destruction'] = true,
        ['signalStrength'] = 1,
        ['d2dIntensity'] = 0,
    },
    ['LumiLinearWipe_73-effect1'] = {
        ['progress'] = 0,
        ['rotation'] = 135,
        ['feather'] = 0.79,
    },
    ['LumiLayer_73-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_71-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 0.833333333, }, 
		{1.2, 1.7, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_73-effect0#d2dIntensity#number'] =
{
	{
		{0.30157357, 0, 0.648620453, -0.300151888, }, 
		{0.166667, 0.566667, }, 
		{{5.7, }, {3.120432, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.406887048, 0.207430506, 0.825393393, 1, }, 
		{0.566667, 0.633333, }, 
		{{3.120432, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.633333, 0.7, }, 
		{{0, }, {3.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.7, 0.766667, }, 
		{{3.6, }, {2.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.766667, 0.8, }, 
		{{2.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.8, 0.866667, }, 
		{{0, }, {3.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.866667, 0.933333, }, 
		{{3.4, }, {2.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.933333, 1, }, 
		{{2.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.066667, }, 
		{{0, }, {3.7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.066667, 1.133333, }, 
		{{3.7, }, {2.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.133333, 1.2, }, 
		{{2.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_73-effect1#progress#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.233333, 0.633333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_73-effect1#feather#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.166667, 0.4, }, 
		{{0, }, {0.79, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_73-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.866667, 1.566667, }, 
		{{100, }, {0, }, }, 
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
