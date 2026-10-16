local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiSaturation_59-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiNegative_59-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_59-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiGlitchSignal_68-effect0'] = {
        ['nodeDuration'] = {{0, 2.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_68-effect1'] = {
        ['nodeDuration'] = {{0, 2.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.06666666666667}, },
        },
    },
    ['LumiLayer_68-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.06666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiSaturation_59-effect0'] = {
        ['saturationIntensity'] = -1,
    },
    ['LumiNegative_59-effect1'] = {
        ['negativeAlpha'] = 1,
    },
    ['LumiLayer_59-trs-blend'] = {
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
        ['opacity'] = 87.0695177064392,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGlitchSignal_68-effect0'] = {
        ['lowQuality'] = 0.5,
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
        ['d2dIntensity'] = 2.2,
    },
    ['LumiLinearWipe_68-effect1'] = {
        ['progress'] = 0,
        ['rotation'] = 135,
        ['feather'] = 0.79,
    },
    ['LumiLayer_68-trs-blend'] = {
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
        ['opacity'] = 63.3333333333333,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_59-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0, 0.866667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_68-effect0#d2dIntensity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.9, 1.633333, }, 
		{{2.2, }, {3.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_68-effect1#progress#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{1.2, 1.833333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_68-effect1#feather#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{1.564714, 1.966667, }, 
		{{0.79, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_68-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1, }, 
		{{0, }, {100, }, }, 
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
