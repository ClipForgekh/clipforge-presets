local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiWarp_153-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiWarp_152-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_152-trs'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_153-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiWarp_154-effect0'] = {
        ['nodeDuration'] = {{0, 1.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.76666666666667}, },
        },
    },
    ['LumiLayer_154-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.76666666666667}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiWarp_155-effect0'] = {
        ['nodeDuration'] = {{0, 1.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.66666666666667}, },
        },
    },
    ['LumiLayer_155-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.66666666666667}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiWarp_156-effect0'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['LumiLayer_156-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiWarp_157-effect0'] = {
        ['nodeDuration'] = {{0, 1.13333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.13333333333333}, },
        },
    },
    ['LumiLayer_157-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.13333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiWarp_153-effect0'] = {
        ['warpStyle'] = 4,
        ['warpAxis'] = 1,
        ['bend'] = -17.451588970073,
    },
    ['LumiWarp_152-effect0'] = {
        ['warpStyle'] = 4,
        ['warpAxis'] = 1,
        ['bend'] = -17.4511059851522,
    },
    ['LumiLayer_152-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 813.823206493198, -158.392796615176),
        ['scale'] = Amaz.Vector3f(35, 35, 35),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 67.7602832565863,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_153-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 1006.09412034926, -181.990968212284),
        ['scale'] = Amaz.Vector3f(40, 40, 40),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 80.6394231204424,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiWarp_154-effect0'] = {
        ['warpStyle'] = 4,
        ['warpAxis'] = 1,
        ['bend'] = -20,
    },
    ['LumiLayer_154-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 1164.8089145744, -179.818556905782),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 88.1030974696637,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiWarp_155-effect0'] = {
        ['warpStyle'] = 4,
        ['warpAxis'] = 1,
        ['bend'] = -20,
    },
    ['LumiLayer_155-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 1198.03276196115, -179.999457746093),
        ['scale'] = Amaz.Vector3f(60, 60, 60),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 89.9094646732258,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiWarp_156-effect0'] = {
        ['warpStyle'] = 4,
        ['warpAxis'] = 1,
        ['bend'] = -20,
    },
    ['LumiLayer_156-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 1200, -180),
        ['scale'] = Amaz.Vector3f(70, 70, 70),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 90,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiWarp_157-effect0'] = {
        ['warpStyle'] = 4,
        ['warpAxis'] = 1,
        ['bend'] = -20,
    },
    ['LumiLayer_157-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 1200, -180),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 90,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiWarp_153-effect0#bend#number'] =
{
	{
		{0.922370546, 3e-8, 0.313203284, 0.999999965, }, 
		{1.240299, 1.8, }, 
		{{0, }, {-20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_152-effect0#bend#number'] =
{
	{
		{0.922370546, 3e-8, 0.313203284, 0.999999965, }, 
		{1.240332, 1.8, }, 
		{{0, }, {-20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_152-trs#position#vector'] =
{
	{
		{0.492638, 0, 0.478937, 1, }, 
		{1.233333, 2, }, 
		{{360, 360, 6, }, {360, 1200, -180, }, {360, 361, -107, }, {360, 792, -179.9999999988, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_152-trs#xRotation#number'] =
{
	{
		{0.498841106, -9e-9, 0.240348014, 0.999999982, }, 
		{1.233333, 2, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_153-trs-blend#position#vector'] =
{
	{
		{0.492638, 0, 0.478937, 1, }, 
		{1.133333, 1.9, }, 
		{{360, 360, 5, }, {360, 1200, -180, }, {360, 362, -223, }, {360, 792, -179.9999999988, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_153-trs-blend#xRotation#number'] =
{
	{
		{0.498841106, -9e-9, 0.240348014, 0.999999982, }, 
		{1.133333, 1.9, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_154-effect0#bend#number'] =
{
	{
		{0.922370546, 3.1e-8, 0.139499884, 0.999999947, }, 
		{1.033333, 1.615625, }, 
		{{0, }, {-20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_154-trs-blend#position#vector'] =
{
	{
		{0.467337, 0.060357, 0.471238, 1, }, 
		{1, 1.766667, }, 
		{{360, 360, 4, }, {360, 1200, -180, }, {360, 366.959122180939, -107.462387084961, }, {360, 795.223846435547, -179.999999998809, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_154-trs-blend#xRotation#number'] =
{
	{
		{0.498841106, -9e-9, 0.240348014, 0.999999982, }, 
		{1, 1.767806, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_155-effect0#bend#number'] =
{
	{
		{0.922370546, 3e-8, 0.071354823, 1.00000001, }, 
		{0.912793, 1.483789, }, 
		{{0, }, {-20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_155-trs-blend#position#vector'] =
{
	{
		{0.492638, 0, 0.478937, 1, }, 
		{0.866667, 1.666667, }, 
		{{360, 360, 3, }, {360, 1200, -180, }, {360, 361, -110, }, {360, 792, -179.9999999988, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_155-trs-blend#xRotation#number'] =
{
	{
		{0.498841106, -9e-9, 0.240348014, 0.999999981, }, 
		{0.866667, 1.666081, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_156-effect0#bend#number'] =
{
	{
		{0.780735418, 2.66e-7, 0, 0.999999941, }, 
		{0.666667, 1.226367, }, 
		{{0, }, {-20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_156-trs-blend#position#vector'] =
{
	{
		{0.492638, 0, 0.478937, 1, }, 
		{0.633333, 1.4, }, 
		{{360, 360, 2, }, {360, 1200, -180, }, {360, 361, -111, }, {360, 792, -179.9999999988, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_156-trs-blend#xRotation#number'] =
{
	{
		{0.498841106, -9e-9, 0.240348014, 0.999999982, }, 
		{0.633333, 1.399447, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_157-effect0#bend#number'] =
{
	{
		{0.878473016, 3.3e-8, 0.48467494, 0.999999979, }, 
		{0.166667, 0.726367, }, 
		{{0, }, {-20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_157-trs-blend#position#vector'] =
{
	{
		{0.766847, 0, 0.478937, 1, }, 
		{0.133333, 1.133333, }, 
		{{360, 360, 0, }, {360, 1200, -180, }, {360, 361, -113, }, {360, 792, -179.9999999988, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_157-trs-blend#xRotation#number'] =
{
	{
		{0.744026365, 1.8e-8, 0.410692862, 0.999999982, }, 
		{0.133333, 1.133333, }, 
		{{0, }, {90, }, }, 
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
