local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_2344-trs-blend', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_2350-trs'] = {
        ['nodeDuration'] = {{0, 10}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 10}, },
        },
    },
    ['LumiLayer_2359-trs-blend'] = {
        ['nodeDuration'] = {{0, 10}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 10}, },
            ['baseTex'] = {{0, 10}, },
        },
    },
    ['LumiLayer_2356-trs-blend'] = {
        ['nodeDuration'] = {{0, 10}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 10}, },
            ['baseTex'] = {{0, 10}, },
        },
    },
    ['LumiLayer_2355-trs-blend'] = {
        ['nodeDuration'] = {{0, 10}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 10}, },
            ['baseTex'] = {{0, 10}, },
        },
    },
    ['LumiLayer_2351-trs-blend'] = {
        ['nodeDuration'] = {{0, 10}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 10}, },
            ['baseTex'] = {{0, 10}, },
        },
    },
    ['LumiLayer_2344-trs-blend'] = {
        ['nodeDuration'] = {{0, 10}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 10}, },
            ['baseTex'] = {{0, 10}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_2350-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 120),
        ['scale'] = Amaz.Vector3f(149, 149, 149),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(540, -256.851282114505, 2612.1078731418),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -18.4181518620001,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2359-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 90),
        ['scale'] = Amaz.Vector3f(149, 149, 149),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(540, -256.851282114505, 2612.1078731418),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -18.4181518620001,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2356-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 60),
        ['scale'] = Amaz.Vector3f(149, 149, 149),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(540, -256.851282114505, 2612.1078731418),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -18.4181518620001,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2355-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 32),
        ['scale'] = Amaz.Vector3f(149, 149, 149),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(540, -256.851282114505, 2612.1078731418),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -18.4181518620001,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2351-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(149, 149, 149),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(540, -256.851282114505, 2612.1078731418),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -18.4181518620001,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2344-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, -256.851282114505, 2612.1078731418),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -18.4181518620001,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_2350-trs#p0_position#vector'] =
{
	{
		{0.747253, 0.009784, 0.65, 1, }, 
		{0, 2.366667, }, 
		{{540, 540, 0, }, {540, -6838.520241415, 12236.907240244, }, {540, -384, 5964, }, {540, -6795.52004305074, 9058.90675196275, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2350-trs#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 3.666667, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2359-trs-blend#p0_position#vector'] =
{
	{
		{0.747253, 0.009784, 0.65, 1, }, 
		{0, 2.366667, }, 
		{{540, 540, 0, }, {540, -6838.520241415, 12236.907240244, }, {540, -384, 5964, }, {540, -6795.52004305074, 9058.90675196275, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2359-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 3.666667, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2356-trs-blend#p0_position#vector'] =
{
	{
		{0.747253, 0.009784, 0.65, 1, }, 
		{0, 2.366667, }, 
		{{540, 540, 0, }, {540, -6838.520241415, 12236.907240244, }, {540, -384, 5964, }, {540, -6795.52004305074, 9058.90675196275, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2356-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 3.666667, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2355-trs-blend#p0_position#vector'] =
{
	{
		{0.747253, 0.009784, 0.65, 1, }, 
		{0, 2.366667, }, 
		{{540, 540, 0, }, {540, -6838.520241415, 12236.907240244, }, {540, -384, 5964, }, {540, -6795.52004305074, 9058.90675196275, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2355-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 3.666667, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2351-trs-blend#p0_position#vector'] =
{
	{
		{0.747253, 0.009784, 0.65, 1, }, 
		{0, 2.366667, }, 
		{{540, 540, 0, }, {540, -6838.520241415, 12236.907240244, }, {540, -384, 5964, }, {540, -6795.52004305074, 9058.90675196275, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2351-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 3.666667, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2344-trs-blend#position#vector'] =
{
	{
		{0.747253, 0.009784, 0.65, 1, }, 
		{0, 2.366667, }, 
		{{540, 540, 0, }, {540, -6838.520241415, 12236.907240244, }, {540, -384, 5964, }, {540, -6795.52004305074, 9058.90675196275, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2344-trs-blend#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 3.666667, }, 
		{{0, }, {-90, }, }, 
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
