local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_29-trs'] = {
        ['nodeDuration'] = {{0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 2}, },
        },
    },
    ['LumiLayer_37-trs-blend'] = {
        ['nodeDuration'] = {{0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.33333333333333}, },
            ['baseTex'] = {{0.03333333333333, 2}, },
        },
    },
    ['LumiLayer_40-trs-blend'] = {
        ['nodeDuration'] = {{0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.73333333333333, 1.03333333333333}, },
            ['baseTex'] = {{0.03333333333333, 2}, },
        },
    },
    ['LumiLayer_42-trs-blend'] = {
        ['nodeDuration'] = {{0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.33333333333333, 1.6}, },
            ['baseTex'] = {{0.03333333333333, 2}, },
        },
    },
    ['LumiVignette_34-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 2}, },
        },
    },
    ['LumiBCC_Prism_34-effect1'] = {
        ['nodeDuration'] = {{0.03333333333333, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 1.7}, },
        },
    },
    ['LumiLayer_34-trs-blend'] = {
        ['nodeDuration'] = {{0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 1.7}, },
            ['baseTex'] = {{0.03333333333333, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_29-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(1268, 540, 0),
        ['scale'] = Amaz.Vector3f(189, 189, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_37-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_40-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_42-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 62,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiVignette_34-effect0'] = {
        ['color'] = Amaz.Color(0, 0, 0, 1),
        ['amount'] = 1,
        ['midpoint'] = 0,
        ['roundness'] = -0.89,
        ['feather'] = 0.54,
        ['highlight'] = 0,
        ['transparent'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiBCC_Prism_34-effect1'] = {
        ['globalTransform'] = 400,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 1,
        ['scaleStart'] = 102,
        ['scaleEnd'] = 100,
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
    ['LumiLayer_34-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_29-trs#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0, 0.3, }, 
		{{1268, 540, 0, }, {960, 540, 0, }, {1268, 540, 0, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0, 0, }, 
		{0.3, 0.7, }, 
		{{960, 540, 0, }, {960, 540, 0, }, {960, 540, 0, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.7, 0.733333, }, 
		{{960, 540, 0, }, {820, 540, 0, }, {960, 540, 0, }, {820, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0, 1, }, 
		{0.733333, 1.033333, }, 
		{{820, 540, 0, }, {960, 540, 0, }, {820, 540, 0, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0, 0, }, 
		{1.033333, 1.3, }, 
		{{960, 540, 0, }, {960, 540, 0, }, {960, 540, 0, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0, 0, }, 
		{1.3, 1.333333, }, 
		{{960, 540, 0, }, {960, 540, 0, }, {960, 540, 0, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0, 0, }, 
		{1.333333, 1.566667, }, 
		{{960, 540, 0, }, {960, 540, 0, }, {960, 540, 0, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.7, 0.733333, }, 
		{{189, 189, 100, }, {119.277777778, 119.277777778, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.733333, 1.3, }, 
		{{119.277777778, 119.277777778, 100, }, {119.277777778, 119.277777778, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.674992352,0.674992352,0.674992352, 1,1,0.674992352, }, 
		{1.3, 1.333333, }, 
		{{119.277777778, 119.277777778, 100, }, {105.5, 105.5, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{1.333333, 1.566667, }, 
		{{105.5, 105.5, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_37-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.333333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_40-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.733333, 0.866667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_42-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.6, }, 
		{{62, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_34-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.7, }, 
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
