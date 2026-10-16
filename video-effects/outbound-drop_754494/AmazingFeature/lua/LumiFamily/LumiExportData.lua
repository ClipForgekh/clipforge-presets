local data = {}

local ae_compDurations = {0, 1.08333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiMotionBlur3D_228-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur3D_228-effect0'] = {
        ['nodeDuration'] = {{0, 1.125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.125}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_229-effect0'] = {
        ['nodeDuration'] = {{0, 1.125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.125}, },
            ['seqTex_1_1'] = {{0, 1.125}, },
        },
    },
    ['LumiMotionBlur3D_229-effect1'] = {
        ['nodeDuration'] = {{0, 1.125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.125}, },
        },
    },
    ['LumiLayer_228-matte'] = {
        ['nodeDuration'] = {{0, 1.125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.125}, },
            ['maskTex'] = {{0, 1.125}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur3D_228-effect0'] = {
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
        ['rotation_z'] = 360,
        ['ae_pre_rotation_z'] = 360,
        ['vIntensity'] = 0.2,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiAnimSeqLoadAndCrop_229-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 2,
        ['cropType_1_1'] = 1,
        ['edgeType_1_1'] = 1,
        ['enableVideoAlphaBlend_1_1'] = false,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 1,
        ['opacity_1_1'] = 1,
        ['speed_1_1'] = 1,
        ['playMode_1_1'] = 1,
        ['specify_9_16'] = false,
        ['animSeqType_9_16'] = 2,
        ['cropType_9_16'] = 1,
        ['edgeType_9_16'] = 0,
        ['enableVideoAlphaBlend_9_16'] = false,
        ['pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_9_16'] = 0,
        ['scale_9_16'] = 1,
        ['opacity_9_16'] = 1,
        ['speed_9_16'] = 1,
        ['playMode_9_16'] = 1,
        ['specify_16_9'] = false,
        ['animSeqType_16_9'] = 2,
        ['cropType_16_9'] = 1,
        ['edgeType_16_9'] = 0,
        ['enableVideoAlphaBlend_16_9'] = false,
        ['pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_16_9'] = 0,
        ['scale_16_9'] = 1,
        ['opacity_16_9'] = 1,
        ['speed_16_9'] = 1,
        ['playMode_16_9'] = 1,
        ['specify_5.8'] = false,
        ['animSeqType_5.8'] = 2,
        ['cropType_5.8'] = 1,
        ['edgeType_5.8'] = 0,
        ['enableVideoAlphaBlend_5.8'] = false,
        ['pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['position_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_5.8'] = 0,
        ['scale_5.8'] = 1,
        ['opacity_5.8'] = 1,
        ['speed_5.8'] = 1,
        ['playMode_5.8'] = 1,
        ['specify_2_1'] = false,
        ['animSeqType_2_1'] = 2,
        ['cropType_2_1'] = 1,
        ['edgeType_2_1'] = 0,
        ['enableVideoAlphaBlend_2_1'] = false,
        ['pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_2_1'] = 0,
        ['scale_2_1'] = 1,
        ['opacity_2_1'] = 1,
        ['speed_2_1'] = 1,
        ['playMode_2_1'] = 1,
        ['specify_3_4'] = false,
        ['animSeqType_3_4'] = 2,
        ['cropType_3_4'] = 1,
        ['edgeType_3_4'] = 0,
        ['enableVideoAlphaBlend_3_4'] = false,
        ['pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['position_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_3_4'] = 0,
        ['scale_3_4'] = 1,
        ['opacity_3_4'] = 1,
        ['speed_3_4'] = 1,
        ['playMode_3_4'] = 1,
        ['specify_4_3'] = false,
        ['animSeqType_4_3'] = 2,
        ['cropType_4_3'] = 1,
        ['edgeType_4_3'] = 0,
        ['enableVideoAlphaBlend_4_3'] = false,
        ['pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['position_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_4_3'] = 0,
        ['scale_4_3'] = 1,
        ['opacity_4_3'] = 1,
        ['speed_4_3'] = 1,
        ['playMode_4_3'] = 1,
        ['specify_1.85_1'] = false,
        ['animSeqType_1.85_1'] = 2,
        ['cropType_1.85_1'] = 1,
        ['edgeType_1.85_1'] = 0,
        ['enableVideoAlphaBlend_1.85_1'] = false,
        ['pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1.85_1'] = 0,
        ['scale_1.85_1'] = 1,
        ['opacity_1.85_1'] = 1,
        ['speed_1.85_1'] = 1,
        ['playMode_1.85_1'] = 1,
        ['specify_2.35_1'] = false,
        ['animSeqType_2.35_1'] = 2,
        ['cropType_2.35_1'] = 1,
        ['edgeType_2.35_1'] = 0,
        ['enableVideoAlphaBlend_2.35_1'] = false,
        ['pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_2.35_1'] = 0,
        ['scale_2.35_1'] = 1,
        ['opacity_2.35_1'] = 1,
        ['speed_2.35_1'] = 1,
        ['playMode_2.35_1'] = 1,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiMotionBlur3D_229-effect1'] = {
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
        ['rotation_z'] = 360,
        ['ae_pre_rotation_z'] = 360,
        ['vIntensity'] = 0.2,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiLayer_228-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_228-effect0#ae_pre_position#vector'] =
{
	{
		{1, 0, 0, 0.236541, }, 
		{0.20833366666667, 0.70833366666667, }, 
		{{0.5, 0.5, 0, }, {0.5, 1.04946880637187, 0, }, {0.5, 0.5, 0, }, {0.5, 1.04946880637187, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0.205794, 0.9999, 0.999926, }, 
		{0.70833366666667, 1.04166666666667, }, 
		{{0.5, 1.04946880637187, 0, }, {0.5, -0.13515625, 0, }, {0.5, 1.04946880637187, 0, }, {0.5, -0.13515625, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_228-effect0#position#vector'] =
{
	{
		{1, 0, 0, 0.236541, }, 
		{0.166667, 0.666667, }, 
		{{0.5, 0.5, 0, }, {0.5, 1.04946880637187, 0, }, {0.5, 0.5, 0, }, {0.5, 1.04946880637187, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0.205794, 0.9999, 0.999926, }, 
		{0.666667, 1, }, 
		{{0.5, 1.04946880637187, 0, }, {0.5, -0.13515625, 0, }, {0.5, 1.04946880637187, 0, }, {0.5, -0.13515625, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_228-effect0#ae_pre_scale_x#number'] =
{
	{
		{1, 0.000001259, 0.67, 1, }, 
		{0.04166666666667, 0.54166666666667, }, 
		{{1, }, {0.201, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_228-effect0#scale_x#number'] =
{
	{
		{1, 0.000001259, 0.67, 1, }, 
		{0, 0.5, }, 
		{{1, }, {0.201, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_228-effect0#ae_pre_rotation_z#number'] =
{
	{
		{1, 0, 0.712149562, 0.585099568, }, 
		{0.37499966666667, 0.70833366666667, }, 
		{{360, }, {303, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.485981351, 0.279212858, 0.327102855, 0.999999935, }, 
		{0.70833366666667, 1.04166666666667, }, 
		{{303, }, {160, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_228-effect0#rotation_z#number'] =
{
	{
		{1, 0, 0.712149562, 0.585099568, }, 
		{0.333333, 0.666667, }, 
		{{360, }, {303, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.485981351, 0.279212858, 0.327102855, 0.999999935, }, 
		{0.666667, 1, }, 
		{{303, }, {160, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_229-effect1#ae_pre_position#vector'] =
{
	{
		{1, 0, 0, 0.236541, }, 
		{0.20833366666667, 0.70833366666667, }, 
		{{0.5, 0.5, 0, }, {0.5, 1.04946880637187, 0, }, {0.5, 0.5, 0, }, {0.5, 1.04946880637187, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0.192585, 0.9999, 0.999931, }, 
		{0.70833366666667, 1.04166666666667, }, 
		{{0.5, 1.04946880637187, 0, }, {0.5, -0.21640625, 0, }, {0.5, 1.04946880637187, 0, }, {0.5, -0.21640625, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_229-effect1#position#vector'] =
{
	{
		{1, 0, 0, 0.236541, }, 
		{0.166667, 0.666667, }, 
		{{0.5, 0.5, 0, }, {0.5, 1.04946880637187, 0, }, {0.5, 0.5, 0, }, {0.5, 1.04946880637187, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0.192585, 0.9999, 0.999931, }, 
		{0.666667, 1, }, 
		{{0.5, 1.04946880637187, 0, }, {0.5, -0.21640625, 0, }, {0.5, 1.04946880637187, 0, }, {0.5, -0.21640625, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_229-effect1#ae_pre_scale_x#number'] =
{
	{
		{1, 0.000001259, 0.67, 1, }, 
		{0.04166666666667, 0.54166666666667, }, 
		{{1, }, {0.201, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_229-effect1#scale_x#number'] =
{
	{
		{1, 0.000001259, 0.67, 1, }, 
		{0, 0.5, }, 
		{{1, }, {0.201, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_229-effect1#ae_pre_rotation_z#number'] =
{
	{
		{1, 0, 0.712149562, 0.585099568, }, 
		{0.37499966666667, 0.70833366666667, }, 
		{{360, }, {303, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.485981351, 0.279212858, 0.327102855, 0.999999935, }, 
		{0.70833366666667, 1.04166666666667, }, 
		{{303, }, {160, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_229-effect1#rotation_z#number'] =
{
	{
		{1, 0, 0.712149562, 0.585099568, }, 
		{0.333333, 0.666667, }, 
		{{360, }, {303, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.485981351, 0.279212858, 0.327102855, 0.999999935, }, 
		{0.666667, 1, }, 
		{{303, }, {160, }, }, 
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
