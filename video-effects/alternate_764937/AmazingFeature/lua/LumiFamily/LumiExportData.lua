local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_580-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_576-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_577-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_578-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_579-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_584-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_584-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_580-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(1212, 554, 0),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_576-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(-219, 554, 0),
        ['scale'] = Amaz.Vector3f(40, 40, 40),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_577-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(1212, 554, 0),
        ['scale'] = Amaz.Vector3f(60, 60, 60),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_578-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(-457, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_579-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(1383, 554, 0),
        ['scale'] = Amaz.Vector3f(130, 130, 130),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRadialBlur_584-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 30,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiLayer_584-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_580-trs#position#vector'] =
{
	{
		{0.891126, 0, 0.168676, 1, }, 
		{0.033333, 0.966667, }, 
		{{1212, 554, 0, }, {392, 554, 0, }, {1075.33332824707, 554, 0, }, {528.66667175293, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_576-trs-blend#position#vector'] =
{
	{
		{0.891126, 0, 0.168676, 1, }, 
		{0.266667, 1.2, }, 
		{{-219, 554, 0, }, {392, 554, 0, }, {-117.166664123535, 554, 0, }, {290.166664123535, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_577-trs-blend#position#vector'] =
{
	{
		{0.891126, 0, 0.168676, 1, }, 
		{0.5, 1.433333, }, 
		{{1212, 554, 0, }, {392, 554, 0, }, {1075.33332824707, 554, 0, }, {528.66667175293, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_578-trs-blend#position#vector'] =
{
	{
		{0.891126, 0, 0.168676, 1, }, 
		{0.733333, 1.666667, }, 
		{{-457, 554, 0, }, {392, 554, 0, }, {-315.5, 554, 0, }, {250.5, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_579-trs-blend#position#vector'] =
{
	{
		{0.891126, 0, 0.168676, 1, }, 
		{0.966667, 1.9, }, 
		{{1383, 554, 0, }, {392, 554, 0, }, {1217.83332824707, 554, 0, }, {557.16667175293, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_579-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.566667, 1.9, }, 
		{{130, 130, 130, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_584-effect0#amount#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.433333, 1.766667, }, 
		{{30, }, {0, }, }, 
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
