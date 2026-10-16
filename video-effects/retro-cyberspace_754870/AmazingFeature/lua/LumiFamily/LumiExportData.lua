local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_48-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_95-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex_1_1'] = {{0, 2}, },
            ['seqTex_9_16'] = {{0, 2}, },
            ['seqTex_16_9'] = {{0, 2}, },
        },
    },
    ['LumiLayer_95-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_48-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiGodRay_88-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_88-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_48-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 18,
        ['fadeType'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiAnimSeqLoadAndCrop_95-effect0'] = {
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
        ['specify_9_16'] = true,
        ['animSeqType_9_16'] = 0,
        ['cropType_9_16'] = 1,
        ['edgeType_9_16'] = 0,
        ['enableVideoAlphaBlend_9_16'] = true,
        ['pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_9_16'] = 0,
        ['scale_9_16'] = 1,
        ['opacity_9_16'] = 1,
        ['speed_9_16'] = 1,
        ['playMode_9_16'] = 0,
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
        ['scale_16_9'] = 1,
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
        ['playMode_5.8'] = 0,
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
        ['playMode_2_1'] = 0,
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
        ['playMode_3_4'] = 0,
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
        ['playMode_4_3'] = 0,
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
        ['playMode_1.85_1'] = 0,
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
        ['playMode_2.35_1'] = 0,
        ['globalRotation'] = 0,
        ['globalScale'] = 1.02,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiLayer_95-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(640, 360, 0),
        ['position'] = Amaz.Vector3f(640, 360, 98),
        ['scale'] = Amaz.Vector3f(106, 106, 106),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100313,
        ['compositeSize'] = Amaz.Vector2f(1280, 720),
        ['layerSize'] = Amaz.Vector2f(1280, 720),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_48-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 360, 0),
        ['position'] = Amaz.Vector3f(641.231666513632, 643.882154208226, 1330.86316906086),
        ['scale'] = Amaz.Vector3f(74, 74, 74),
        ['orientation'] = Amaz.Vector3f(35.6001691430631, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100313,
        ['compositeSize'] = Amaz.Vector2f(1280, 720),
        ['layerSize'] = Amaz.Vector2f(1280, 720),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGodRay_88-effect0'] = {
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['range'] = 0,
        ['smoothness'] = 1,
        ['weightDecay'] = 1.01,
        ['colorDecay'] = 1,
        ['borderType'] = 0,
        ['lightSource'] = 0,
        ['brightness'] = 0.1,
        ['grayscaleCorrection'] = 0,
        ['useAngle'] = false,
        ['angleRange'] = 360,
        ['angleType'] = 0,
        ['angle'] = 0,
        ['directionPoint'] = Amaz.Vector2f(0.5, 0.5),
        ['scaleType'] = 5,
        ['quality'] = 10,
        ['colorType'] = 1,
        ['lightColor'] = Amaz.Color(0.77254903316498, 0.94380623102188, 1, 1),
        ['blendMode'] = 1,
        ['displayRayOnly'] = false,
        ['dither'] = 0,
        ['noiseIntensity'] = 0,
        ['inverseGammaCorrection'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiLayer_88-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_48-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.833333, 1.933333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRoundCorner_48-effect0#fade#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.833333, 1.933333, }, 
		{{18, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_95-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_48-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.832483, }, 
		{0, 0.466667, }, 
		{{641.231666514, 819.912857385, -466.380782978, }, {641.231666514, 682.349507677, 1202.82794415, }, {641.231666514, 819.912857385, -466.380782978, }, {641.231666514, 682.349507677, 1202.82794415, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.33099, 0.666667, 1, }, 
		{0.466667, 1, }, 
		{{641.231666514, 682.349507677, 1202.82794415, }, {641.231666514, 403.600633186, 2130.619217022, }, {641.231666514, 682.349507677, 1202.82794415, }, {641.231666514, 403.600633186, 2130.619217022, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.333333, }, 
		{{641.231666514, 403.600633186, 2130.619217022, }, {641.231666514, 403.600633186, 2265.619217022, }, {641.231666514, 403.600633186, 2130.619217022, }, {641.231666514, 403.600633186, 2265.619217022, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.333333, 1.933333, }, 
		{{641.231666514, 403.600633186, 2265.619217022, }, {641.231666514, 363.6006, -0.3808, }, {641.231666514, 403.600633186, 2265.619217022, }, {641.231666514, 363.6006, -0.3808, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_48-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.133333, 1.666667, }, 
		{{74, 74, 74, }, {40, 40, 40, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.666667, 1.966667, }, 
		{{40, 40, 40, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_48-trs-blend#orientation#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.933333, }, 
		{{90.4508, 0, 0, }, {0, 0, 0, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_48-trs-blend#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.866667, 1.666667, }, 
		{{0, }, {1080, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGodRay_88-effect0#range#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.266667, 1.8, }, 
		{{0, }, {0.62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.8, 1.966667, }, 
		{{0.62, }, {0, }, }, 
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
