local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_646-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_653-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_645-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_644-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_643-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_642-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_648-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_648-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_646-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 1110, 0),
        ['position'] = Amaz.Vector3f(0, 1110, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_653-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(800, 1110, 0),
        ['position'] = Amaz.Vector3f(800, 1110, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_645-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(-2, 1128, 0),
        ['position'] = Amaz.Vector3f(-2, 1128, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_644-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(800, 1110, 0),
        ['position'] = Amaz.Vector3f(800, 1110, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_643-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(8.88178419700125e-16, 1110, 0),
        ['position'] = Amaz.Vector3f(0, 1110, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_642-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(800, 1110, 0),
        ['position'] = Amaz.Vector3f(800, 1110, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRadialBlur_648-effect0'] = {
        ['blurType'] = 1,
        ['amount'] = 7.77777780749714,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiLayer_648-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_646-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.304347892,0.304347892,0.66666667, 1.653953722,1.653953722,0.66666667, }, 
		{0.166667, 1.133333, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_646-trs#rotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.1, 1.133333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_653-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.304347892,0.304347892,0.66666667, 1.541203081,1.541203081,0.66666667, }, 
		{0.3, 1.1, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_653-trs-blend#rotation#number'] =
{
	{
		{0.800813076, 6.8e-8, 0.66666667, 1, }, 
		{0.266667, 0.666667, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.734030255, -7.3e-8, 0.66666667, 1, }, 
		{0.666667, 1.133333, }, 
		{{10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_645-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.304347892,0.304347892,0.66666667, 1.541203081,1.541203081,0.66666667, }, 
		{0.4, 1.2, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_645-trs-blend#rotation#number'] =
{
	{
		{0.800813076, -6.8e-8, 0.66666667, 1, }, 
		{0.366667, 0.766667, }, 
		{{0, }, {-10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.734030255, 7.3e-8, 0.66666667, 1, }, 
		{0.766667, 1.233333, }, 
		{{-10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_644-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.304347892,0.304347892,0.66666667, 1.541203081,1.541203081,0.66666667, }, 
		{0.5, 1.3, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_644-trs-blend#rotation#number'] =
{
	{
		{0.800813076, 6.8e-8, 0.66666667, 1, }, 
		{0.5, 0.9, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.734030255, -7.3e-8, 0.66666667, 1, }, 
		{0.9, 1.366667, }, 
		{{10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_643-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.304347892,0.304347892,0.66666667, 1.541203081,1.541203081,0.66666667, }, 
		{0.6, 1.4, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_643-trs-blend#rotation#number'] =
{
	{
		{0.800813076, -6.8e-8, 0.66666667, 1, }, 
		{0.633333, 1.033333, }, 
		{{0, }, {-10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.734030255, 7.3e-8, 0.66666667, 1, }, 
		{1.033333, 1.5, }, 
		{{-10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_642-trs-blend#scale#vector'] =
{
	{
		{0.360857158,0.360857158,0.33333333, -4.1e-8,-4.1e-8,0.33333333, 0.40591993,0.40591993,0.666666665, 0.697068221,0.697068221,0.666666665, }, 
		{0.8, 1.266667, }, 
		{{0, 0, 100, }, {120, 120, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.217159745,0.217159745,0.333333335, -0.522029535,-0.522029535,0.333333335, 0.527685771,0.527685771,0.66666667, 0.426304901,0.426304901,0.66666667, }, 
		{1.266667, 1.633333, }, 
		{{120, 120, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_642-trs-blend#rotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.8, 1.166667, }, 
		{{0, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.166667, 1.6, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_648-effect0#amount#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.5, 1.9, }, 
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
