local data = {}

local ae_compDurations = {0.8, 1.43333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiAnimSeqLoadAndCrop_29-effect0', 'InputTex', 0},
    {'LumiAnimSeqLoadAndCrop_29-effect0', 'seqTex_1_1', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiAnimSeqLoadAndCrop_29-effect0'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
            ['seqTex_1_1'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiGlow_29-effect1'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiTurbulenceDisplacement_385-effect0'] = {
        ['nodeDuration'] = {{1.1, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiLayer_385-blend'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.1, 1.36666666666667}, },
            ['baseTex'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiCCLens_381-effect0'] = {
        ['nodeDuration'] = {{1.1, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.36666666666667}, },
        },
    },
    ['LumiExposure_381-effect1'] = {
        ['nodeDuration'] = {{1.1, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.1, 1.36666666666667}, },
        },
    },
    ['LumiLayer_381-blend'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.1, 1.36666666666667}, },
            ['baseTex'] = {{0, 1.36666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiAnimSeqLoadAndCrop_29-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 2,
        ['cropType_1_1'] = 1,
        ['edgeType_1_1'] = 3,
        ['enableVideoAlphaBlend_1_1'] = false,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 1.24,
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiGlow_29-effect1'] = {
        ['threshold'] = 1,
        ['radius'] = 17,
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiTurbulenceDisplacement_385-effect0'] = {
        ['size'] = -0.37,
        ['quantity'] = 1.61999999999998,
        ['complexity'] = 3.02,
        ['evolution'] = -229,
        ['cycle'] = 100,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['type'] = 0,
        ['fix_type'] = 0,
        ['picture_scale'] = 1,
        ['motion_tile_type'] = 0,
        ['qualityType'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiLayer_385-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiCCLens_381-effect0'] = {
        ['convergence'] = 100,
        ['radius'] = 150,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiExposure_381-effect1'] = {
        ['channelType'] = 0,
        ['exposure'] = 1.2,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiLayer_381-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiAnimSeqLoadAndCrop_29-effect0#scale_1_1#number'] =
{
	{
		{0.082917914, 1.6e-8, 0, 0.63838554, }, 
		{0, 0.233333, }, 
		{{1.24, }, {1.04, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.160578291, 0.663627793, 0.757991381, 1.131778606, }, 
		{0.233333, 0.766667, }, 
		{{1.04, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.397997763, 0.000541795, 0.73591932, -0.00112438, }, 
		{0.766667, 0.8, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.44737626, 0.428579928, 0.870134355, 0.139916436, }, 
		{0.8, 1.1, }, 
		{{1, }, {1.04, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.988449847, 1.01832531, 0.893009337, 1.000000006, }, 
		{1.1, 1.333333, }, 
		{{1.04, }, {1.24, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlow_29-effect1#threshold#number'] =
{
	{
		{0.160486305, 4.3e-8, 0, 7.9e-8, }, 
		{0, 0.233333, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, -9.8e-8, 0.870134355, -0.005963246, }, 
		{0.233333, 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.988449847, -0.00328492, 0.893009337, 0, }, 
		{1.1, 1.333333, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlow_29-effect1#radius#number'] =
{
	{
		{0.160486305, -2.51e-7, 0, 0.999999533, }, 
		{0, 0.233333, }, 
		{{17, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, -0.000009819, 0.870134355, -0.596324604, }, 
		{0.233333, 1.1, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.988449847, 0.328492036, 0.893009337, 1.000000002, }, 
		{1.1, 1.333333, }, 
		{{0, }, {17, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_385-effect0#size#number'] =
{
	{
		{0.949544074, -3.7e-8, 0.885714751, 1, }, 
		{1.1, 1.333333, }, 
		{{0, }, {-0.37, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_385-effect0#quantity#number'] =
{
	{
		{0.949544074, -0.000003561, 0.885714751, 0.999999995, }, 
		{1.1, 1.333333, }, 
		{{2, }, {1.62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_385-effect0#complexity#number'] =
{
	{
		{0.949544074, 6.7e-7, 0.885714751, 1.000000001, }, 
		{1.1, 1.333333, }, 
		{{1, }, {3.02, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_385-effect0#evolution#number'] =
{
	{
		{0.949544074, -6e-9, 0.885714751, 1, }, 
		{1.1, 1.333333, }, 
		{{0, }, {-229, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCCLens_381-effect0#convergence#number'] =
{
	{
		{1, -6.9e-8, 0.873556308, 1.000000005, }, 
		{1.1, 1.233333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiExposure_381-effect1#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.1, 1.333333, }, 
		{{0, }, {1.2, }, }, 
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
