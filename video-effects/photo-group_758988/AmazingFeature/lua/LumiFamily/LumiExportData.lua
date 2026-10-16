local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_42-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_43-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_42-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_39-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_39-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_40-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_40-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_41-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_42-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(-0.06942701594696, -0.24023889454707),
        ['ae_pre_position'] = Amaz.Vector2f(-0.06942701594696, -0.24023889454707),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.58284444496531,
        ['ae_pre_scale_x'] = 0.58284444496531,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0,
        ['vCenter'] = 0,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_43-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.75717534662689, 1.31473427730159),
        ['ae_pre_position'] = Amaz.Vector2f(0.75717534662689, 1.31473427730159),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.8692855685837,
        ['ae_pre_scale_x'] = 0.8692855685837,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0,
        ['vCenter'] = 0,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_42-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur3D_39-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(1.40347087567215, 0.25265483199077, 0),
        ['ae_pre_position'] = Amaz.Vector3f(1.40347087567215, 0.25265483199077, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.95163859764121,
        ['ae_pre_scale_x'] = 0.95163859764121,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = -30,
        ['ae_pre_direction_y'] = -30,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0,
        ['vCenter'] = 0,
        ['samples'] = 10,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_39-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_40-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(-0.39084290007455, 0.81739545863607),
        ['ae_pre_position'] = Amaz.Vector2f(-0.39084290007455, 0.81739545863607),
        ['unifiedScale'] = true,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0,
        ['vCenter'] = 0,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_40-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_41-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.3853523626278, -0.00630517313502),
        ['ae_pre_position'] = Amaz.Vector2f(0.3853523626278, -0.00630517313502),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.82447229105298,
        ['ae_pre_scale_x'] = 0.82447229105298,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0,
        ['vCenter'] = 0,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_41-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_42-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.06666633333333, 1.83333333333333, }, 
		{{-0.31851851851852, -0.51944444444444, }, {0.30185185185185, 0.17592592592593, }, {-0.31851851851852, -0.51944444444444, }, {0.30185185185185, 0.17592592592593, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_42-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.033333, 1.8, }, 
		{{-0.31851851851852, -0.51944444444444, }, {0.30185185185185, 0.17592592592593, }, {-0.31851851851852, -0.51944444444444, }, {0.30185185185185, 0.17592592592593, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_42-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.20000033333333, 1.20000033333333, }, 
		{{1, }, {0.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_42-effect0#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.166667, 1.166667, }, 
		{{1, }, {0.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_43-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.33333333333333, 1.90000033333333, }, 
		{{0.74537037037037, 1.54259259259259, }, {0.79444444444444, 0.59537037037037, }, {0.74537037037037, 1.54259259259259, }, {0.79444444444444, 0.59537037037037, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_43-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.3, 1.866667, }, 
		{{0.74537037037037, 1.54259259259259, }, {0.79444444444444, 0.59537037037037, }, {0.74537037037037, 1.54259259259259, }, {0.79444444444444, 0.59537037037037, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_43-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.40000033333333, 1.53333333333333, }, 
		{{1, }, {0.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_43-effect0#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.366667, 1.5, }, 
		{{1, }, {0.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_39-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.53333333333333, 2.00000033333333, }, 
		{{1.48404557969815, 0.25185186598056, 0, }, {0.74074074074074, 0.25925925925926, 0, }, {1.48404557969815, 0.25185186598056, 0, }, {0.74074074074074, 0.25925925925926, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_39-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.5, 1.966667, }, 
		{{1.48404557969815, 0.25185186598056, 0, }, {0.74074074074074, 0.25925925925926, 0, }, {1.48404557969815, 0.25185186598056, 0, }, {0.74074074074074, 0.25925925925926, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_39-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.66666633333333, 1.53333333333333, }, 
		{{1, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.53333333333333, 2.00000033333333, }, 
		{{0.5, }, {0.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_39-effect0#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.633333, 1.5, }, 
		{{1, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.5, 1.966667, }, 
		{{0.5, }, {0.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_39-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.03333333333333, 1.70000033333333, }, 
		{{-30, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_39-effect0#direction_y#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.666667, }, 
		{{-30, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_40-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.36666633333333, 2.00000033333333, }, 
		{{-0.50740740740741, 0.83703703703704, }, {0.08055555555556, 0.73796296296296, }, {-0.50740740740741, 0.83703703703704, }, {0.08055555555556, 0.73796296296296, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_40-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.333333, 1.966667, }, 
		{{-0.50740740740741, 0.83703703703704, }, {0.08055555555556, 0.73796296296296, }, {-0.50740740740741, 0.83703703703704, }, {0.08055555555556, 0.73796296296296, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_40-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.00000033333333, 2.00000033333333, }, 
		{{1, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_40-effect0#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.966667, 1.966667, }, 
		{{1, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.20000033333333, 2.00000033333333, }, 
		{{0.33981481481481, -0.20740740740741, }, {0.5, 0.5, }, {0.33981481481481, -0.20740740740741, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.166667, 1.966667, }, 
		{{0.33981481481481, -0.20740740740741, }, {0.5, 0.5, }, {0.33981481481481, -0.20740740740741, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.26666633333333, 2.00000033333333, }, 
		{{1, }, {0.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.233333, 1.966667, }, 
		{{1, }, {0.3, }, }, 
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
