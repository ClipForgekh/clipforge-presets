local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur3D_149-effect0'] = {
        ['nodeDuration'] = {{0.64, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.64, 2}, },
        },
    },
    ['LumiLinearWipe_25-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_25-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_25-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_149-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.64, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiBrightness_152-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_152-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur3D_149-effect0'] = {
        ['active_cam_fovx'] = 60,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0.20625),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0.20625),
        ['unifiedScale'] = true,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 114,
        ['ae_pre_direction_y'] = 114,
        ['direction_z'] = -6,
        ['ae_pre_direction_z'] = -6,
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
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLinearWipe_25-effect0'] = {
        ['progress'] = 0.37,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLinearWipe_25-effect1'] = {
        ['progress'] = 0.37,
        ['rotation'] = 270,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiMotionBlur3D_25-effect2'] = {
        ['active_cam_fovx'] = 60,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(2.03, 0.47625, 1),
        ['ae_pre_position'] = Amaz.Vector3f(2.03, 0.47625, 1),
        ['unifiedScale'] = true,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 174,
        ['ae_pre_direction_y'] = 174,
        ['direction_z'] = -12,
        ['ae_pre_direction_z'] = -12,
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
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLayer_149-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiBrightness_152-effect0'] = {
        ['brightnessIntensity'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLayer_152-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_149-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166666, 0, 1, }, 
		{0.68, 1, }, 
		{{0.5, 0.5, 0.20625, }, {0.5, 0.5, 0, }, {0.5, 0.5, 0.20625, }, {0.44903968811035, 0.5, 0.0902906036377, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_149-effect0#position#vector'] =
{
	{
		{0.166667, 0.166666, 0, 1, }, 
		{0.64, 0.96, }, 
		{{0.5, 0.5, 0.20625, }, {0.5, 0.5, 0, }, {0.5, 0.5, 0.20625, }, {0.44903968811035, 0.5, 0.0902906036377, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_149-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.108826985, 1.000000012, }, 
		{0.68, 1, }, 
		{{114, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_149-effect0#direction_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.108826985, 1.000000012, }, 
		{0.64, 0.96, }, 
		{{114, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_149-effect0#ae_pre_direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 0.999999959, }, 
		{0.68, 1, }, 
		{{-6, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_149-effect0#direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 0.999999959, }, 
		{0.64, 0.96, }, 
		{{-6, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect2#ae_pre_position#vector'] =
{
	{
		{0.102316, 0.08089, 0.078969, 0.749193, }, 
		{0.04, 0.56, }, 
		{{2.03, 0.47625, 1, }, {0.5375, 0.5, 0.3075, }, {1.78125, 0.48020833343267, 0.88458333015442, }, {0.79645833969116, 0.49604166656733, 0.45083333015442, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.081652, 0.595647, 0.376051, }, 
		{0.56, 0.72, }, 
		{{0.5375, 0.5, 0.3075, }, {0.47625, 0.5, 0.14, }, {0.27854166030884, 0.50395833343267, 0.16416666984558, }, {0.4864583337307, 0.5, 0.1679166674614, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect2#position#vector'] =
{
	{
		{0.102316, 0.08089, 0.078969, 0.749193, }, 
		{0, 0.52, }, 
		{{2.03, 0.47625, 1, }, {0.5375, 0.5, 0.3075, }, {1.78125, 0.48020833343267, 0.88458333015442, }, {0.79645833969116, 0.49604166656733, 0.45083333015442, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.081652, 0.595647, 0.376051, }, 
		{0.52, 0.68, }, 
		{{0.5375, 0.5, 0.3075, }, {0.47625, 0.5, 0.14, }, {0.27854166030884, 0.50395833343267, 0.16416666984558, }, {0.4864583337307, 0.5, 0.1679166674614, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect2#ae_pre_direction_y#number'] =
{
	{
		{0.037205844, 0.011384271, 0.106873744, 0.843756161, }, 
		{0.04, 0.56, }, 
		{{174, }, {-49, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.045152869, 0.843409749, 0.825363171, }, 
		{0.56, 0.72, }, 
		{{-49, }, {-93, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect2#direction_y#number'] =
{
	{
		{0.037205844, 0.011384271, 0.106873744, 0.843756161, }, 
		{0, 0.52, }, 
		{{174, }, {-49, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.045152869, 0.843409749, 0.825363171, }, 
		{0.52, 0.68, }, 
		{{-49, }, {-93, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect2#ae_pre_direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.08, 0.6, }, 
		{{-12, }, {7, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect2#direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.04, 0.56, }, 
		{{-12, }, {7, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBrightness_152-effect0#brightnessIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.52, 0.64, }, 
		{{0, }, {-0.8, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.64, 0.76, }, 
		{{-0.8, }, {0, }, }, 
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
