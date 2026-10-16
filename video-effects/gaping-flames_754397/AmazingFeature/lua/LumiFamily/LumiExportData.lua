local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_101-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiAnimSeqLoadAndCrop_101-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex_1_1'] = {{0, 1.52}, },
            ['seqTex_9_16'] = {{0, 1.52}, },
            ['seqTex_16_9'] = {{0, 1.52}, },
            ['seqTex_5.8'] = {{0, 1.52}, },
            ['seqTex_2_1'] = {{0, 1.52}, },
            ['seqTex_3_4'] = {{0, 1.52}, },
            ['seqTex_4_3'] = {{0, 1.52}, },
            ['seqTex_1.85_1'] = {{0, 1.52}, },
            ['seqTex_2.35_1'] = {{0, 1.52}, },
        },
    },
    ['LumiGlow_101-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_101-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiAnimSeqLoadAndCrop_101-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 0,
        ['cropType_1_1'] = 2,
        ['edgeType_1_1'] = 3,
        ['enableVideoAlphaBlend_1_1'] = true,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.54583333333333, 0.5),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.54583333333333, 0.5),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 1.92,
        ['opacity_1_1'] = 1,
        ['speed_1_1'] = 1,
        ['playMode_1_1'] = 0,
        ['specify_9_16'] = true,
        ['animSeqType_9_16'] = 0,
        ['cropType_9_16'] = 2,
        ['edgeType_9_16'] = 3,
        ['enableVideoAlphaBlend_9_16'] = true,
        ['pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['position_9_16'] = Amaz.Vector2f(0.57407407407407, 0.56805555555556),
        ['ae_pre_position_9_16'] = Amaz.Vector2f(0.57407407407407, 0.56805555555556),
        ['rotation_9_16'] = -90,
        ['scale_9_16'] = 3.25,
        ['opacity_9_16'] = 1,
        ['speed_9_16'] = 1,
        ['playMode_9_16'] = 0,
        ['specify_16_9'] = true,
        ['animSeqType_16_9'] = 0,
        ['cropType_16_9'] = 2,
        ['edgeType_16_9'] = 3,
        ['enableVideoAlphaBlend_16_9'] = true,
        ['pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_16_9'] = 0,
        ['scale_16_9'] = 1,
        ['opacity_16_9'] = 1,
        ['speed_16_9'] = 1,
        ['playMode_16_9'] = 0,
        ['specify_5.8'] = true,
        ['animSeqType_5.8'] = 0,
        ['cropType_5.8'] = 2,
        ['edgeType_5.8'] = 3,
        ['enableVideoAlphaBlend_5.8'] = true,
        ['pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['position_5.8'] = Amaz.Vector2f(0.55705705705706, 0.53888888888889),
        ['ae_pre_position_5.8'] = Amaz.Vector2f(0.55705705705706, 0.53888888888889),
        ['rotation_5.8'] = -90,
        ['scale_5.8'] = 3.91,
        ['opacity_5.8'] = 1,
        ['speed_5.8'] = 1,
        ['playMode_5.8'] = 0,
        ['specify_2_1'] = true,
        ['animSeqType_2_1'] = 0,
        ['cropType_2_1'] = 2,
        ['edgeType_2_1'] = 3,
        ['enableVideoAlphaBlend_2_1'] = true,
        ['pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2_1'] = Amaz.Vector2f(0.5, 0.4671875),
        ['ae_pre_position_2_1'] = Amaz.Vector2f(0.5, 0.4671875),
        ['rotation_2_1'] = 0,
        ['scale_2_1'] = 1.24,
        ['opacity_2_1'] = 1,
        ['speed_2_1'] = 1,
        ['playMode_2_1'] = 0,
        ['specify_3_4'] = true,
        ['animSeqType_3_4'] = 0,
        ['cropType_3_4'] = 2,
        ['edgeType_3_4'] = 3,
        ['enableVideoAlphaBlend_3_4'] = true,
        ['pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['position_3_4'] = Amaz.Vector2f(0.54814814814815, 0.55416666666667),
        ['ae_pre_position_3_4'] = Amaz.Vector2f(0.54814814814815, 0.55416666666667),
        ['rotation_3_4'] = -90,
        ['scale_3_4'] = 2.56,
        ['opacity_3_4'] = 1,
        ['speed_3_4'] = 1,
        ['playMode_3_4'] = 0,
        ['specify_4_3'] = true,
        ['animSeqType_4_3'] = 0,
        ['cropType_4_3'] = 2,
        ['edgeType_4_3'] = 3,
        ['enableVideoAlphaBlend_4_3'] = true,
        ['pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['position_4_3'] = Amaz.Vector2f(0.51770833333333, 0.5),
        ['ae_pre_position_4_3'] = Amaz.Vector2f(0.51770833333333, 0.5),
        ['rotation_4_3'] = 0,
        ['scale_4_3'] = 1.35,
        ['opacity_4_3'] = 1,
        ['speed_4_3'] = 1,
        ['playMode_4_3'] = 0,
        ['specify_1.85_1'] = true,
        ['animSeqType_1.85_1'] = 0,
        ['cropType_1.85_1'] = 2,
        ['edgeType_1.85_1'] = 3,
        ['enableVideoAlphaBlend_1.85_1'] = true,
        ['pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1.85_1'] = Amaz.Vector2f(0.5328125, 0.5),
        ['ae_pre_position_1.85_1'] = Amaz.Vector2f(0.5328125, 0.5),
        ['rotation_1.85_1'] = 0,
        ['scale_1.85_1'] = 1.14,
        ['opacity_1.85_1'] = 1,
        ['speed_1.85_1'] = 1,
        ['playMode_1.85_1'] = 0,
        ['specify_2.35_1'] = true,
        ['animSeqType_2.35_1'] = 0,
        ['cropType_2.35_1'] = 2,
        ['edgeType_2.35_1'] = 3,
        ['enableVideoAlphaBlend_2.35_1'] = true,
        ['pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2.35_1'] = Amaz.Vector2f(0.53125, 0.5),
        ['ae_pre_position_2.35_1'] = Amaz.Vector2f(0.53125, 0.5),
        ['rotation_2.35_1'] = 0,
        ['scale_2.35_1'] = 1.42,
        ['opacity_2.35_1'] = 1,
        ['speed_2.35_1'] = 1,
        ['playMode_2.35_1'] = 0,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiGlow_101-effect1'] = {
        ['threshold'] = 0.6,
        ['radius'] = 84,
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
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiLayer_101-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiAnimSeqLoadAndCrop_101-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {2, }, }, 
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
