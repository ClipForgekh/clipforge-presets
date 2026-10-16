local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiTone_61-effect0', 'InputTex', 0},
    {'LumiTone_53-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiTone_61-effect0'] = {
        ['nodeDuration'] = {{0.83333333333333, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.83333333333333, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_61-effect1'] = {
        ['nodeDuration'] = {{0.83333333333333, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.83333333333333, 2.33333333333333}, },
        },
    },
    ['LumiTone_53-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_53-effect2'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_53-trs'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_61-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.83333333333333, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiBCC_Prism_60-effect0'] = {
        ['nodeDuration'] = {{0, 2.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_60-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.26666666666667}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiTone_61-effect0'] = {
        ['amount'] = 0,
        ['whiteColor'] = Amaz.Color(0.38039216399193, 0.38039216399193, 0.38039216399193, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_61-effect1'] = {
        ['radius'] = 0,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTone_53-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.38039216399193, 0.38039216399193, 0.38039216399193, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_53-effect2'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_53-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(399, 540, 1851),
        ['scale'] = Amaz.Vector3f(81, 81, 81),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -48,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_61-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_60-effect0'] = {
        ['globalTransform'] = 0,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 0,
        ['scaleStart'] = 102,
        ['scaleEnd'] = 98,
        ['angleStart'] = 0,
        ['angleEnd'] = 0,
        ['falloff'] = 0,
        ['offsetStart'] = Amaz.Vector2f(0.5, 0.5),
        ['offsetEnd'] = Amaz.Vector2f(0.5, 0.5),
        ['colorStart'] = Amaz.Color(1, 0, 0, 1),
        ['colorMid'] = Amaz.Color(0, 1, 0, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 1, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_60-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiTone_61-effect0#amount#number'] =
{
	{
		{0.76, 0, 0.24, 1, }, 
		{1.433333, 1.966667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTone_61-effect0#whiteColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.266667, 1.3, }, 
		{{0.380392, 0.380392, 0.380392, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.3, 1.766667, }, 
		{{1, 1, 1, 1, }, {0.380392, 0.380392, 0.380392, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiTone_61-effect0#blackColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.266667, 1.3, }, 
		{{0, 0, 0, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.3, 1.766667, }, 
		{{1, 1, 1, 1, }, {0, 0, 0, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiRoundCorner_61-effect1#radius#number'] =
{
	{
		{0.13, 0, 0.22, 1, }, 
		{1.466667, 1.966667, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTone_53-effect0#whiteColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 0.5, }, 
		{{0.380392, 0.380392, 0.380392, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.966667, }, 
		{{1, 1, 1, 1, }, {0.380392, 0.380392, 0.380392, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiTone_53-effect0#blackColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 0.5, }, 
		{{0, 0, 0, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.966667, }, 
		{{1, 1, 1, 1, }, {0, 0, 0, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_53-trs#position#vector'] =
{
	{
		{0.76, 0, 0.24, 1, }, 
		{0, 0.666667, }, 
		{{-823, 540, 1851, }, {399, 540, 1851, }, {-823, 540, 1851, }, {399, 540, 1851, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_53-trs#yRotation#number'] =
{
	{
		{0.76, 0, 0.24, 1, }, 
		{0, 0.666667, }, 
		{{-104, }, {-48, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_61-trs-blend#position#vector'] =
{
	{
		{0.76, 0, 0.24, 1, }, 
		{0.833333, 1.433333, }, 
		{{399, 540, 1851, }, {1509, 540, 1851, }, {399, 540, 1851, }, {1509, 540, 1851, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.24, 1, }, 
		{1.433333, 1.966667, }, 
		{{1509, 540, 1851, }, {960, 540, 0, }, {1509, 540, 1851, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_61-trs-blend#scale#vector'] =
{
	{
		{0.13,0.13,0.13, 0,0,0, 0.22,0.22,0.22, 1,1,1, }, 
		{1.433333, 1.966667, }, 
		{{81, 81, 81, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_61-trs-blend#yRotation#number'] =
{
	{
		{0.76, 0, 0.22, 1, }, 
		{0.833333, 1.433333, }, 
		{{-48, }, {48, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.13, 0, 0.22, 1, }, 
		{1.433333, 1.966667, }, 
		{{48, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_60-effect0#globalTransform#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.366667, 1.933333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBCC_Prism_60-effect0#weight#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.366667, 1.933333, }, 
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
