local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_29-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_32-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_58-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_60-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_56-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 10890.3860714045),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -45.0136230250495,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 130.684712008208,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_29-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 1080, 0),
        ['position'] = Amaz.Vector3f(0, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 7.23693837401213,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 10890.3860714045),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -45.0136230250495,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 130.684712008208,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_32-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 1080, 0),
        ['position'] = Amaz.Vector3f(0, -540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -7.23693837401213,
        ['yRotation'] = 0,
        ['rotation'] = 180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 10890.3860714045),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -45.0136230250495,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 130.684712008208,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_58-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(1080, 540, 0),
        ['position'] = Amaz.Vector3f(540, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -7.23693837401213,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 10890.3860714045),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -45.0136230250495,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 130.684712008208,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_60-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(1080, 540, 0),
        ['position'] = Amaz.Vector3f(-540, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 7.23693837401213,
        ['rotation'] = 180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 10890.3860714045),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -45.0136230250495,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 130.684712008208,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_56-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 2.0870748375413,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_27-trs#p0_position#vector'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 0, }, {540, 540, 15000, }, {540, 540, 2500, }, {540, 540, 12500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#p0_xRotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {-62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#p0_rotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#xRotation#number'] =
{
	{
		{0.15, 0, 0.25, 1, }, 
		{0, 1.5, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#p0_position#vector'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 0, }, {540, 540, 15000, }, {540, 540, 2500, }, {540, 540, 12500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#p0_xRotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {-62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#p0_rotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#xRotation#number'] =
{
	{
		{0.15, 0, 0.25, 1, }, 
		{0, 1.5, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#p0_position#vector'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 0, }, {540, 540, 15000, }, {540, 540, 2500, }, {540, 540, 12500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#p0_xRotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {-62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#p0_rotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs-blend#yRotation#number'] =
{
	{
		{0.15, 0, 0.25, 1, }, 
		{0, 1.5, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs-blend#p0_position#vector'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 0, }, {540, 540, 15000, }, {540, 540, 2500, }, {540, 540, 12500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs-blend#p0_xRotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {-62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs-blend#p0_rotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#yRotation#number'] =
{
	{
		{0.15, 0, 0.25, 1, }, 
		{0, 1.5, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#p0_position#vector'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 0, }, {540, 540, 15000, }, {540, 540, 2500, }, {540, 540, 12500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#p0_xRotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {-62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#p0_rotation#number'] =
{
	{
		{0.71, 0, 0.29, 1, }, 
		{0, 1.966667, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_56-trs-blend#opacity#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1, 1.966667, }, 
		{{0, }, {100, }, }, 
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
