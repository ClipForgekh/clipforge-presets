local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur3D_142-effect0'] = {
        ['nodeDuration'] = {{0, 1.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.66666666666667}, },
        },
    },
    ['LumiTritone_142-effect1'] = {
        ['nodeDuration'] = {{0, 1.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.66666666666667}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_228-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex_1_1'] = {{0, 2.03333333333333}, },
            ['seqTex_16_9'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_228-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 1.66666666666667}, },
        },
    },
    ['LumiGlow_211-effect0'] = {
        ['nodeDuration'] = {{1.36666666666667, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.36666666666667, 2.03333333333333}, },
        },
    },
    ['LumiMotionBlur2D_211-effect1'] = {
        ['nodeDuration'] = {{1.36666666666667, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.36666666666667, 2.03333333333333}, },
        },
    },
    ['LumiLayer_211-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.36666666666667, 2.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur3D_142-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.85,
        ['ae_pre_scale_x'] = 0.85,
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
        ['rotation_x'] = -5,
        ['ae_pre_rotation_x'] = -5,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = -7.57752561996457,
        ['ae_pre_rotation_z'] = -7.57752561996457,
        ['vIntensity'] = 0,
        ['vCenter'] = 0,
        ['samples'] = 6,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiTritone_142-effect1'] = {
        ['highlightColor'] = Amaz.Color(1, 0.93613135814667, 0.79562032222748, 1),
        ['middleColor'] = Amaz.Color(0.63322824239731, 0.51762491464615, 0.38842126727104, 1),
        ['shadowColor'] = Amaz.Color(0.0927150323987, 0.07865580171347, 0.06084745749831, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiAnimSeqLoadAndCrop_228-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 0,
        ['cropType_1_1'] = 1,
        ['edgeType_1_1'] = 0,
        ['enableVideoAlphaBlend_1_1'] = true,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 1,
        ['opacity_1_1'] = 1,
        ['speed_1_1'] = 1,
        ['playMode_1_1'] = 0,
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
        ['specify_16_9'] = true,
        ['animSeqType_16_9'] = 0,
        ['cropType_16_9'] = 1,
        ['edgeType_16_9'] = 0,
        ['enableVideoAlphaBlend_16_9'] = true,
        ['pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_16_9'] = 0,
        ['scale_16_9'] = 1.1,
        ['opacity_16_9'] = 1,
        ['speed_16_9'] = 1,
        ['playMode_16_9'] = 0,
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
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_228-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
    ['LumiGlow_211-effect0'] = {
        ['threshold'] = 0.09,
        ['radius'] = 50,
        ['glowIntensity'] = 1,
        ['blendMode'] = 0,
        ['show'] = 0,
        ['glowColor'] = 0,
        ['colorLooping'] = 0,
        ['colorLoops'] = 1,
        ['colorPhase'] = 0,
        ['midpoint'] = 0.5,
        ['colorA'] = Amaz.Color(1, 1, 1, 1),
        ['colorB'] = Amaz.Color(0, 0, 0, 1),
        ['glowDimensions'] = 0,
        ['quality'] = 0.2,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiMotionBlur2D_211-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.2,
        ['ae_pre_scale_x'] = 1.2,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0,
        ['vCenter'] = 0,
        ['minSamples'] = 0.02,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_211-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_142-effect0#ae_pre_scale_x#number'] =
{
	{
		{1, 5.8e-8, 0.910679592, 0.999999995, }, 
		{1.03333333333333, 1.46666633333333, }, 
		{{0.85, }, {1.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_142-effect0#scale_x#number'] =
{
	{
		{1, 5.8e-8, 0.910679592, 0.999999995, }, 
		{1, 1.433333, }, 
		{{0.85, }, {1.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_142-effect0#ae_pre_rotation_x#number'] =
{
	{
		{0.675728142, -6e-9, 0.66666667, 1, }, 
		{0.36666633333333, 1.46666633333333, }, 
		{{-5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_142-effect0#rotation_x#number'] =
{
	{
		{0.675728142, -6e-9, 0.66666667, 1, }, 
		{0.333333, 1.433333, }, 
		{{-5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_142-effect0#ae_pre_rotation_z#number'] =
{
	{
		{0.652427183, 0.236799687, 0.66666667, 1, }, 
		{0.03333333333333, 1.70000033333333, }, 
		{{-8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_142-effect0#rotation_z#number'] =
{
	{
		{0.652427183, 0.236799687, 0.66666667, 1, }, 
		{0, 1.666667, }, 
		{{-8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_228-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlow_211-effect0#threshold#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.5, }, 
		{{0.09, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur2D_211-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.397769675, 1.4e-8, 0, 0.999999984, }, 
		{1.53333333333333, 1.76666633333333, }, 
		{{1.2, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_211-effect1#scale_x#number'] =
{
	{
		{0.397769675, 1.4e-8, 0, 0.999999984, }, 
		{1.5, 1.733333, }, 
		{{1.2, }, {1, }, }, 
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
