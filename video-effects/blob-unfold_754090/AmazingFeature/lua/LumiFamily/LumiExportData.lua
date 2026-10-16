local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiOpticsCompensation_191-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiOpticsCompensation_191-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_191-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGodRay_190-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_190-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiOpticsCompensation_191-effect0'] = {
        ['fov'] = 168.150323666449,
        ['inverseLensDistortion'] = false,
        ['fovOrientation'] = 2,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = false,
        ['fillBorders'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiLayer_191-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 360, 0),
        ['position'] = Amaz.Vector3f(640, 360, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1280, 720),
        ['layerSize'] = Amaz.Vector2f(1280, 720),
        ['mirrorEdge'] = false,
    },
    ['LumiGodRay_190-effect0'] = {
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['range'] = 1,
        ['smoothness'] = 0,
        ['weightDecay'] = 1,
        ['colorDecay'] = 1,
        ['borderType'] = 0,
        ['lightSource'] = 0,
        ['brightness'] = 0.1,
        ['grayscaleCorrection'] = 0,
        ['useAngle'] = false,
        ['angleRange'] = 360,
        ['angleType'] = 0,
        ['angle'] = 0,
        ['directionPoint'] = Amaz.Vector2f(0.5, 0.5),
        ['scaleType'] = 4,
        ['quality'] = 3.61592741935484,
        ['colorType'] = 0,
        ['lightColor'] = Amaz.Color(1, 1, 1, 1),
        ['blendMode'] = 0,
        ['displayRayOnly'] = false,
        ['dither'] = 0,
        ['noiseIntensity'] = 0,
        ['inverseGammaCorrection'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiLayer_190-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiOpticsCompensation_191-effect0#fov#number'] =
{
	{
		{0.702584455, 0.005609415, 0.312252333, 1.000769923, }, 
		{0.133333, 1.833333, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_191-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.133333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGodRay_190-effect0#range#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.666667, 1.7, }, 
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
