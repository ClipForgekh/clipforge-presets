local data = {}

local ae_compDurations = {0, 0.5}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur3D_58-effect0'] = {
        ['nodeDuration'] = {{0, 3.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.53333333333333}, },
        },
    },
    ['LumiLayer_58-trs'] = {
        ['nodeDuration'] = {{0, 3.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.53333333333333}, },
        },
    },
    ['LumiScaleWipe_41-effect0'] = {
        ['nodeDuration'] = {{0, 3.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.53333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur3D_58-effect0'] = {
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
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiLayer_58-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(500, 500, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
    },
    ['LumiScaleWipe_41-effect0'] = {
        ['stretch'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['direction'] = 90,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_58-effect0#ae_pre_position#vector'] =
{
	{
		{0.09, 0, 0, 1, }, 
		{0.06666633333333, 0.53333333333333, }, 
		{{1.044, 0.5, 0, }, {0.5, 0.5, 0, }, {1.044, 0.5, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_58-effect0#position#vector'] =
{
	{
		{0.09, 0, 0, 1, }, 
		{0.033333, 0.5, }, 
		{{1.044, 0.5, 0, }, {0.5, 0.5, 0, }, {1.044, 0.5, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_58-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.11, 0, 0.2, 1, }, 
		{0.06666633333333, 0.53333333333333, }, 
		{{0.77, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_58-effect0#scale_x#number'] =
{
	{
		{0.11, 0, 0.2, 1, }, 
		{0.033333, 0.5, }, 
		{{0.77, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_58-effect0#ae_pre_rotation_y#number'] =
{
	{
		{0.11, 0, 0.2, 1, }, 
		{0.06666633333333, 0.53333333333333, }, 
		{{-9, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_58-effect0#rotation_y#number'] =
{
	{
		{0.11, 0, 0.2, 1, }, 
		{0.033333, 0.5, }, 
		{{-9, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_58-effect0#ae_pre_rotation_z#number'] =
{
	{
		{0.11, 0, 0.2, 1, }, 
		{0.06666633333333, 0.53333333333333, }, 
		{{-1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_58-effect0#rotation_z#number'] =
{
	{
		{0.11, 0, 0.2, 1, }, 
		{0.033333, 0.5, }, 
		{{-1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.066667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiScaleWipe_41-effect0#stretch#number'] =
{
	{
		{0.09, 0, 0, 1, }, 
		{0, 0.5, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = true
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
