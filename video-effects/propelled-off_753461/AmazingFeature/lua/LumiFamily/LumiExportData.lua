local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur3D_30-effect0'] = {
        ['nodeDuration'] = {{0, 40.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 40.4}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur3D_30-effect0'] = {
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
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_30-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.10000033333333, 2.03333333333333, }, 
		{{0.5, 0.5, 0, }, {0.5, 0.5, 6.06573705179283, }, {0.5, 0.5, 0, }, {0.5, 0.5, 6.06573705179283, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_30-effect0#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.066667, 2, }, 
		{{0.5, 0.5, 0, }, {0.5, 0.5, 6.06573705179283, }, {0.5, 0.5, 0, }, {0.5, 0.5, 6.06573705179283, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_30-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.36666633333333, 2.03333333333333, }, 
		{{1, }, {0.001, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_30-effect0#scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 2, }, 
		{{1, }, {0.001, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_30-effect0#ae_pre_direction_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.10000033333333, 2.03333333333333, }, 
		{{0, }, {-392, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_30-effect0#direction_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.066667, 2, }, 
		{{0, }, {-392, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_30-effect0#ae_pre_direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.10000033333333, 2.03333333333333, }, 
		{{0, }, {27, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_30-effect0#direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.066667, 2, }, 
		{{0, }, {27, }, }, 
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
