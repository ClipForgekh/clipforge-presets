local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiCircleWipe_14203-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_14203-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_14203-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_14202-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex_1_1'] = {{0, 3}, },
            ['seqTex_9_16'] = {{0, 3}, },
            ['seqTex_16_9'] = {{0, 3}, },
        },
    },
    ['LumiLayer_14202-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiCircleWipe_14203-effect0'] = {
        ['radiusMode'] = 0,
        ['progress'] = 0,
        ['radius'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['feather'] = 0.2,
        ['reverse'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiGaussianBlur_14203-effect1'] = {
        ['blurIntensity'] = 0,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_14203-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiAnimSeqLoadAndCrop_14202-effect0'] = {
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
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_14202-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiCircleWipe_14203-effect0#progress#number'] =
{
	{
		{0.7, 0, 0.3, 1, }, 
		{1.133333, 1.6, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_14203-effect1#blurIntensity#number'] =
{
	{
		{0.7, 0, 0.3, 1, }, 
		{0, 0.333333, }, 
		{{0, }, {20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_14203-trs#p0_position#vector'] =
{
	{
		{0.7, 0, 0.5, 1, }, 
		{1.333333, 1.5, }, 
		{{540, 540, 0, }, {544.015144478, 538.876987529, 0, }, {540.669190764427, 539.812831252813, 0, }, {546.144235740817, 536.998188090523, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.5, 1.533333, }, 
		{{544.015144478, 538.876987529, 0, }, {527.225452265, 551.272796932, 0, }, {541.886053215183, 540.755786967477, 0, }, {528.361579736924, 550.9055208893, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.533333, 1.566667, }, 
		{{527.225452265, 551.272796932, 0, }, {537.198379793, 541.080643816, 0, }, {526.089324793076, 551.6400729747, 0, }, {533.720780887437, 545.425318880087, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.566667, 1.6, }, 
		{{537.198379793, 541.080643816, 0, }, {548.091045474, 525.204747307, 0, }, {540.675978698563, 536.735968751913, 0, }, {546.167747353501, 523.703286158738, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.6, 1.633333, }, 
		{{548.091045474, 525.204747307, 0, }, {548.738168293, 550.089410527, 0, }, {550.014343594499, 526.706208455262, 0, }, {547.945480519295, 543.748110039482, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.633333, 1.666667, }, 
		{{548.738168293, 550.089410527, 0, }, {552.847172102, 563.252549716, 0, }, {549.530856066704, 556.430711014518, 0, }, {555.8218687382, 562.174694367413, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.666667, 1.7, }, 
		{{552.847172102, 563.252549716, 0, }, {530.889988184, 556.556542567, 0, }, {549.8724754658, 564.330405064587, 0, }, {534.020515441919, 558.859311989531, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.7, 1.733333, }, 
		{{530.889988184, 556.556542567, 0, }, {534.06400839, 549.435932838, 0, }, {527.759460926081, 554.253773144469, 0, }, {534.127415073505, 553.990414821185, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.733333, 1.766667, }, 
		{{534.06400839, 549.435932838, 0, }, {530.509548082, 529.229650691, 0, }, {534.000601706495, 544.881450854815, 0, }, {529.008362784034, 533.250355437246, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.766667, 1.8, }, 
		{{530.509548082, 529.229650691, 0, }, {543.07112008, 525.311703226, 0, }, {532.010733379966, 525.208945944754, 0, }, {541.489378150946, 523.516644975573, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.8, 1.966667, }, 
		{{543.07112008, 525.311703226, 0, }, {540, 540, 0, }, {544.652862009054, 527.106761476427, 0, }, {540.511853337288, 537.551950454712, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_14202-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_14202-trs-blend#opacity#number'] =
{
	{
		{0.7, 0, 0.3, 1, }, 
		{1.666667, 1.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_14202-trs-blend#p0_position#vector'] =
{
	{
		{0.7, 0, 0.5, 1, }, 
		{1.333333, 1.5, }, 
		{{540, 540, 0, }, {544.015144478, 538.876987529, 0, }, {540.669190764427, 539.812831252813, 0, }, {546.144235740817, 536.998188090523, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.5, 1.533333, }, 
		{{544.015144478, 538.876987529, 0, }, {527.225452265, 551.272796932, 0, }, {541.886053215183, 540.755786967477, 0, }, {528.361579736924, 550.9055208893, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.533333, 1.566667, }, 
		{{527.225452265, 551.272796932, 0, }, {537.198379793, 541.080643816, 0, }, {526.089324793076, 551.6400729747, 0, }, {533.720780887437, 545.425318880087, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.566667, 1.6, }, 
		{{537.198379793, 541.080643816, 0, }, {548.091045474, 525.204747307, 0, }, {540.675978698563, 536.735968751913, 0, }, {546.167747353501, 523.703286158738, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.6, 1.633333, }, 
		{{548.091045474, 525.204747307, 0, }, {548.738168293, 550.089410527, 0, }, {550.014343594499, 526.706208455262, 0, }, {547.945480519295, 543.748110039482, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.633333, 1.666667, }, 
		{{548.738168293, 550.089410527, 0, }, {552.847172102, 563.252549716, 0, }, {549.530856066704, 556.430711014518, 0, }, {555.8218687382, 562.174694367413, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.666667, 1.7, }, 
		{{552.847172102, 563.252549716, 0, }, {530.889988184, 556.556542567, 0, }, {549.8724754658, 564.330405064587, 0, }, {534.020515441919, 558.859311989531, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.7, 1.733333, }, 
		{{530.889988184, 556.556542567, 0, }, {534.06400839, 549.435932838, 0, }, {527.759460926081, 554.253773144469, 0, }, {534.127415073505, 553.990414821185, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.733333, 1.766667, }, 
		{{534.06400839, 549.435932838, 0, }, {530.509548082, 529.229650691, 0, }, {534.000601706495, 544.881450854815, 0, }, {529.008362784034, 533.250355437246, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.766667, 1.8, }, 
		{{530.509548082, 529.229650691, 0, }, {543.07112008, 525.311703226, 0, }, {532.010733379966, 525.208945944754, 0, }, {541.489378150946, 523.516644975573, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.5, 1, }, 
		{1.8, 1.966667, }, 
		{{543.07112008, 525.311703226, 0, }, {540, 540, 0, }, {544.652862009054, 527.106761476427, 0, }, {540.511853337288, 537.551950454712, 0, }, }, 
		{6413, }, 
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
