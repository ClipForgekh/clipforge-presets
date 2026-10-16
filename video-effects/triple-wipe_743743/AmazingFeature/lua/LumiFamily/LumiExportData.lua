local data = {}

local ae_compDurations = {0, 1.04166666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiDirectionalBlurs_125-effect0'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiDirectionalBlurs_45-effect0'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_47-trs'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_45-matte'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
            ['maskTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_50-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
            ['baseTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_126-trs'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_125-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
            ['baseTex'] = {{0, 1.04166666666667}, },
            ['maskTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_127-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
            ['baseTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiDirectionalBlurs_85-effect0'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_86-trs'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_85-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
            ['baseTex'] = {{0, 1.04166666666667}, },
            ['maskTex'] = {{0, 1.04166666666667}, },
        },
    },
    ['LumiLayer_87-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.04166666666667}, },
            ['baseTex'] = {{0, 1.04166666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiDirectionalBlurs_125-effect0'] = {
        ['intensity'] = 80,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = NaN,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
    },
    ['LumiDirectionalBlurs_45-effect0'] = {
        ['intensity'] = 80,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = NaN,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
    },
    ['LumiLayer_47-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(90, 600, 0),
        ['position'] = Amaz.Vector3f(0, 1202, 0),
        ['scale'] = Amaz.Vector3f(100, 120, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(90, 480, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(180, 1200),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_45-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 'Luma',
    },
    ['LumiLayer_50-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(90, 600, 0),
        ['position'] = Amaz.Vector3f(0, 1193, 0),
        ['scale'] = Amaz.Vector3f(100, 120, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(90, 480, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(180, 1200),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Add',
    },
    ['LumiLayer_126-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(90, 600, 0),
        ['position'] = Amaz.Vector3f(0, -1293, 0),
        ['scale'] = Amaz.Vector3f(100, 120, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(270, 480, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(180, 1200),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_125-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_127-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(90, 600, 0),
        ['position'] = Amaz.Vector3f(0, -1302, 0),
        ['scale'] = Amaz.Vector3f(100, 120, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(270, 480, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(180, 1200),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Add',
    },
    ['LumiDirectionalBlurs_85-effect0'] = {
        ['intensity'] = 80,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = NaN,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
    },
    ['LumiLayer_86-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(90, 600, 0),
        ['position'] = Amaz.Vector3f(0, 1202, 0),
        ['scale'] = Amaz.Vector3f(100, 120, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(450, 480, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(180, 1200),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_85-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 'Alpha',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_87-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(90, 600, 0),
        ['position'] = Amaz.Vector3f(0, 1193, 0),
        ['scale'] = Amaz.Vector3f(100, 120, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(450, 480, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(180, 1200),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Add',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiDirectionalBlurs_125-effect0#intensity#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.451375, 0.625, }, 
		{{80, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_45-effect0#intensity#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.243042, 0.416667, }, 
		{{80, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_47-trs#position#vector'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0, 0.416667, }, 
		{{0, 1202, 0, }, {0, -237, 0, }, {0, 962.16667175293, 0, }, {0, 2.83332824707031, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_50-trs-blend#position#vector'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0, 0.416667, }, 
		{{0, 1193, 0, }, {0, -237, 0, }, {0, 954.66667175293, 0, }, {0, 1.33332824707031, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_50-trs-blend#opacity#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.173625, 0.277791, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_126-trs#position#vector'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.208333, 0.625, }, 
		{{0, -1293, 0, }, {0, 211, 0, }, {0, -1042.33332824707, 0, }, {0, -39.6666717529297, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_127-trs-blend#position#vector'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.208333, 0.625, }, 
		{{0, -1302, 0, }, {0, 211, 0, }, {0, -1049.83332824707, 0, }, {0, -41.1666717529297, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_127-trs-blend#opacity#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.381958, 0.486125, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_85-effect0#intensity#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.736125, 0.93453, }, 
		{{80, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_86-trs#position#vector'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.458333, 0.93453, }, 
		{{0, 1202, 0, }, {0, -237, 0, }, {0, 962.16667175293, 0, }, {0, 2.83332824707031, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_87-trs-blend#position#vector'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.458333, 0.93453, }, 
		{{0, 1193, 0, }, {0, -237, 0, }, {0, 954.66667175293, 0, }, {0, 1.33332824707031, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_87-trs-blend#opacity#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0.656738, 0.775798, }, 
		{{100, }, {0, }, }, 
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
