local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiGodRay_33-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_33-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_33-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGodRay_33-effect0'] = {
        ['center'] = Amaz.Vector2f(0.5078125, 0.50390625),
        ['range'] = 0.59701492537313,
        ['smoothness'] = 0,
        ['weightDecay'] = 1,
        ['colorDecay'] = 0.60074626865672,
        ['borderType'] = 0,
        ['lightSource'] = 0,
        ['brightness'] = 0.17910447761194,
        ['grayscaleCorrection'] = -0.05223880597015,
        ['useAngle'] = false,
        ['angleRange'] = 360,
        ['angleType'] = 1,
        ['angle'] = 0,
        ['directionPoint'] = Amaz.Vector2f(0.5, 0.5),
        ['scaleType'] = 4,
        ['quality'] = 10,
        ['colorType'] = 0,
        ['lightColor'] = Amaz.Color(0.84305864572525, 0.8132444024086, 0.88496732711792, 1),
        ['blendMode'] = 0,
        ['displayRayOnly'] = false,
        ['dither'] = 0,
        ['noiseIntensity'] = 0,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_33-effect1'] = {
        ['progress'] = 0.6540350877193,
        ['rotation'] = 0,
        ['feather'] = 0.05964912280702,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_33-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiGodRay_33-effect0#range#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.533333, }, 
		{{0, }, {0.59701493, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLinearWipe_33-effect1#progress#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 1, }, 
		{{0.01052632, }, {0.42105263, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1, 1.866667, }, 
		{{0.42105263, }, {0.81754386, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.866667, 2.2, }, 
		{{0.81754386, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{2.2, 3.4, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_33-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.9, }, 
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
