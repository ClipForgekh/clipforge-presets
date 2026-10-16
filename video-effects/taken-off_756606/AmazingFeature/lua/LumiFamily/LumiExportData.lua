local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiMotionBlur3D_3338-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur3D_3338-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_3448-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_3448-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur3D_3338-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(-0.38746946974954, 1.38746946974954, 0),
        ['ae_pre_position'] = Amaz.Vector3f(-0.38746946974954, 1.38746946974954, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.44373497935761,
        ['ae_pre_scale_x'] = 1.44373497935761,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 45,
        ['ae_pre_direction_y'] = 45,
        ['direction_z'] = 10,
        ['ae_pre_direction_z'] = 10,
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
    ['LumiMotionBlur3D_3448-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(-0.38746946974954, 1.38746946974954, 0),
        ['ae_pre_position'] = Amaz.Vector3f(-0.38746946974954, 1.38746946974954, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.44373497935761,
        ['ae_pre_scale_x'] = 1.44373497935761,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 45,
        ['ae_pre_direction_y'] = 45,
        ['direction_z'] = 10,
        ['ae_pre_direction_z'] = 10,
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
    ['LumiLayer_3448-trs-blend'] = {
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
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 4,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_3338-effect0#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.30000033333333, 2.00000033333333, }, 
		{{0.5, 0.5, 0, }, {-0.5, 1.5, 0, }, {0.5, 0.5, 0, }, {-0.5, 1.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3338-effect0#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.266667, 1.966667, }, 
		{{0.5, 0.5, 0, }, {-0.5, 1.5, 0, }, {0.5, 0.5, 0, }, {-0.5, 1.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3338-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.30000033333333, 2.00000033333333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3338-effect0#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.266667, 1.966667, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3338-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.23333333333333, 1.80000033333333, }, 
		{{0, }, {45, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3338-effect0#direction_y#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.2, 1.766667, }, 
		{{0, }, {45, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3338-effect0#ae_pre_direction_z#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.23333333333333, 1.80000033333333, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3338-effect0#direction_z#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.2, 1.766667, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3448-effect0#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.30000033333333, 2.00000033333333, }, 
		{{0.5, 0.5, 0, }, {-0.5, 1.5, 0, }, {0.5, 0.5, 0, }, {-0.5, 1.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3448-effect0#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.266667, 1.966667, }, 
		{{0.5, 0.5, 0, }, {-0.5, 1.5, 0, }, {0.5, 0.5, 0, }, {-0.5, 1.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3448-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.30000033333333, 2.00000033333333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3448-effect0#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.266667, 1.966667, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3448-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.23333333333333, 1.80000033333333, }, 
		{{0, }, {45, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3448-effect0#direction_y#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.2, 1.766667, }, 
		{{0, }, {45, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3448-effect0#ae_pre_direction_z#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.23333333333333, 1.80000033333333, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_3448-effect0#direction_z#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.2, 1.766667, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_3448-trs-blend#opacity#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.2, 1.766667, }, 
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
