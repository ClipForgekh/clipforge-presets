local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_33-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_36-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 1}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_34-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_35-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_37-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiFill_40-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_40-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_33-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(720, 1080, 0),
        ['position'] = Amaz.Vector3f(360, 540, 0),
        ['scale'] = Amaz.Vector3f(50, 50, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1080),
        ['layerSize'] = Amaz.Vector2f(1440, 2160),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_36-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(720, 1080, 0),
        ['position'] = Amaz.Vector3f(360, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1080),
        ['layerSize'] = Amaz.Vector2f(1440, 2160),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_34-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(720, 1080, 0),
        ['position'] = Amaz.Vector3f(141, 455, 0),
        ['scale'] = Amaz.Vector3f(33, 33, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 10,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1080),
        ['layerSize'] = Amaz.Vector2f(1440, 2160),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_35-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(720, 1080, 0),
        ['position'] = Amaz.Vector3f(360, 540, 0),
        ['scale'] = Amaz.Vector3f(50, 50, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1080),
        ['layerSize'] = Amaz.Vector2f(1440, 2160),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_37-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(720, 1080, 0),
        ['position'] = Amaz.Vector3f(360, 540, 0),
        ['scale'] = Amaz.Vector3f(50, 50, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1080),
        ['layerSize'] = Amaz.Vector2f(1440, 2160),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiFill_40-effect0'] = {
        ['color'] = Amaz.Color(0, 0, 0, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiLayer_40-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_33-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0, 0.5, }, 
		{{360, -554, 0, }, {360, 540, 0, }, {360, -554, 0, }, {360, 540, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_34-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.666667, 1, }, 
		{{369, 536, 0, }, {141, 455, 0, }, {369, 536, 0, }, {141, 455, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_34-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.666667, 1, }, 
		{{50, 50, 100, }, {33, 33, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_34-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.666667, 1, }, 
		{{100, }, {10, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_37-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_40-effect0#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.666667, 1.833333, }, 
		{{0, }, {1, }, }, 
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
