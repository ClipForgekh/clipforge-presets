local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_1405-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1406-trs-matte'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1403-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1404-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1401-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_1405-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(1080, 270, 0),
        ['position'] = Amaz.Vector3f(540, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_1406-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(1080, 270, 0),
        ['p0_position'] = Amaz.Vector3f(540, 270, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(540, 540, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
    },
    ['LumiLayer_1403-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(0, 270, 0),
        ['position'] = Amaz.Vector3f(-540, -270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_1404-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 270, 0),
        ['p0_position'] = Amaz.Vector3f(-540, -270, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(540, 540, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_1401-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_1405-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1, }, 
		{{540, 336, 0, }, {540, 270, 0, }, {540, 325, 0, }, {540, 281, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1405-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0.33333333,0.33333333, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.166667, 0.333333, }, 
		{{0, 100, 100, }, {-50, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.333333, 0.5, }, 
		{{-50, 100, 100, }, {0, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0.33333333,0.33333333, 0.66666667,0.66666667,0.66666667, 1,0.66666667,0.66666667, }, 
		{0.5, 1, }, 
		{{0, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1405-trs#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.333333, 1, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1406-trs-matte#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1, }, 
		{{540, 336, 0, }, {540, 270, 0, }, {540, 325, 0, }, {540, 281, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1406-trs-matte#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0.33333333,0.33333333, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.166667, 0.333333, }, 
		{{0, 100, 100, }, {-50, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.333333, 0.5, }, 
		{{-50, 100, 100, }, {0, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0.33333333,0.33333333, 0.66666667,0.66666667,0.66666667, 1,0.66666667,0.66666667, }, 
		{0.5, 1, }, 
		{{0, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1406-trs-matte#p1_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.333333, 1, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1403-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1, }, 
		{{-540, -336, 0, }, {-540, -270, 0, }, {-540, -325, 0, }, {-540, -281, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1403-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0.33333333,0.33333333, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.166667, 0.333333, }, 
		{{0, 100, 100, }, {-50, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.333333, 0.5, }, 
		{{-50, 100, 100, }, {0, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0.33333333,0.33333333, 0.66666667,0.66666667,0.66666667, 1,0.66666667,0.66666667, }, 
		{0.5, 1, }, 
		{{0, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1403-trs#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.333333, 1, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1404-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1, }, 
		{{-540, -336, 0, }, {-540, -270, 0, }, {-540, -325, 0, }, {-540, -281, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1404-trs-matte-blend#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0.33333333,0.33333333, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.166667, 0.333333, }, 
		{{0, 100, 100, }, {-50, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.333333, 0.5, }, 
		{{-50, 100, 100, }, {0, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0.33333333,0.33333333, 0.66666667,0.66666667,0.66666667, 1,0.66666667,0.66666667, }, 
		{0.5, 1, }, 
		{{0, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1404-trs-matte-blend#p1_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.333333, 1, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
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
