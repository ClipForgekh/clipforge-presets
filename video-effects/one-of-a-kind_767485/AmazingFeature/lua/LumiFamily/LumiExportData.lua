local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_8025-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_8025-trs'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiMotionBlur3D_8026-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiSaturation_8026-effect1'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiMotionBlur3D_8027-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_8027-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_8025-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(96, 96, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiMotionBlur3D_8026-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.47693750158836, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.47693750158836, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.56739810553105,
        ['ae_pre_scale_x'] = 0.56739810553105,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 15.4500676596055,
        ['ae_pre_direction_x'] = 15.4500676596055,
        ['direction_y'] = 18.5400811915266,
        ['ae_pre_direction_y'] = 18.5400811915266,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiSaturation_8026-effect1'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur3D_8027-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.47693750158836, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.47693750158836, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.56739810553105,
        ['ae_pre_scale_x'] = 0.56739810553105,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 15.4500676596055,
        ['ae_pre_direction_x'] = 15.4500676596055,
        ['direction_y'] = 18.5400811915266,
        ['ae_pre_direction_y'] = 18.5400811915266,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_8027-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_8025-trs#scale#vector'] =
{
	{
		{0.28,0.28,0.28, 0,0,0.28, 0.72,0.72,0.72, 1,1,0.72, }, 
		{1.666667, 2, }, 
		{{96, 96, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8026-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.03333333333333, 1.53333333333333, }, 
		{{0.5, -0.53425925925926, 0, }, {0.5, 0.5, 0, }, {0.5, -0.53425925925926, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8026-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 1.5, }, 
		{{0.5, -0.53425925925926, 0, }, {0.5, 0.5, 0, }, {0.5, -0.53425925925926, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8026-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.03333333333333, 1.86666633333333, }, 
		{{0.3, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8026-effect0#scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1, 1.833333, }, 
		{{0.3, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8026-effect0#ae_pre_direction_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.03333333333333, 1.86666633333333, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8026-effect0#direction_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1, 1.833333, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8026-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.03333333333333, 1.86666633333333, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8026-effect0#direction_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1, 1.833333, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8027-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.03333333333333, 1.53333333333333, }, 
		{{0.5, -0.53425925925926, 0, }, {0.5, 0.5, 0, }, {0.5, -0.53425925925926, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8027-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 1.5, }, 
		{{0.5, -0.53425925925926, 0, }, {0.5, 0.5, 0, }, {0.5, -0.53425925925926, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8027-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.03333333333333, 1.86666633333333, }, 
		{{0.3, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8027-effect0#scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1, 1.833333, }, 
		{{0.3, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8027-effect0#ae_pre_direction_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.03333333333333, 1.86666633333333, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8027-effect0#direction_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1, 1.833333, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8027-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.03333333333333, 1.86666633333333, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_8027-effect0#direction_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1, 1.833333, }, 
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
