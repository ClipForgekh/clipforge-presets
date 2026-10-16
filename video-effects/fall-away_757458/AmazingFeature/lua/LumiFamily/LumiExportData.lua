local data = {}

local ae_compDurations = {0, 1.33333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_74-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_74-effect0'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiOpticsCompensation_74-effect1'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiMotionBlur3D_74-effect2'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiLayer_74-trs'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_74-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 6,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiOpticsCompensation_74-effect1'] = {
        ['fov'] = 0,
        ['inverseLensDistortion'] = false,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur3D_74-effect2'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 0,
        ['ae_pre_direction_y'] = 0,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 540,
        ['ae_pre_rotation_y'] = 540,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 1,
        ['vCenter'] = -0.25,
        ['samples'] = 26,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_74-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -180,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 56.7380925879944,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_74-effect0#radius#number'] =
{
	{
		{0.245, 0, 0.876, 0.202577827, }, 
		{0.233333, 0.766667, }, 
		{{0, }, {256, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.3, 0.833333333, 0.833333333, }, 
		{0.766667, 1.066667, }, 
		{{256, }, {60, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiOpticsCompensation_74-effect1#fov#number'] =
{
	{
		{0.153, 0.806665808, 0.636, 1, }, 
		{0.033333, 1.066667, }, 
		{{0, }, {61, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect2#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 1.10000033333333, }, 
		{{1, }, {0.12, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect2#scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 1.066667, }, 
		{{1, }, {0.12, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect2#ae_pre_rotation_y#number'] =
{
	{
		{0.345, 0.070148294, 0.738, 0.085957283, }, 
		{0.06666633333333, 1.10000033333333, }, 
		{{540, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect2#rotation_y#number'] =
{
	{
		{0.345, 0.070148294, 0.738, 0.085957283, }, 
		{0.033333, 1.066667, }, 
		{{540, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect2#ae_pre_rotation_z#number'] =
{
	{
		{0.661667801, 1e-7, 0.556918892, 0.999999688, }, 
		{0.06666633333333, 1.10000033333333, }, 
		{{0, }, {120, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect2#rotation_z#number'] =
{
	{
		{0.661667801, 1e-7, 0.556918892, 0.999999688, }, 
		{0.033333, 1.066667, }, 
		{{0, }, {120, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_74-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.766667, 1.066667, }, 
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
