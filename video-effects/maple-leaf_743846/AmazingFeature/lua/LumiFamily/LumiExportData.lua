local data = {}

local ae_compDurations = {0, 2.3}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_382-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_382-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.3}, },
            ['baseTex'] = {{0, 2.3}, },
        },
    },
    ['LumiGaussianBlur_270-effect0'] = {
        ['nodeDuration'] = {{0, 2.3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.3}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_336-effect0'] = {
        ['nodeDuration'] = {{0, 2.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.43333333333333}, },
            ['seqTex_1_1'] = {{0, 2.33333333333333}, },
            ['seqTex_9_16'] = {{0, 2.33333333333333}, },
            ['seqTex_16_9'] = {{0, 2.33333333333333}, },
            ['seqTex_5.8'] = {{0, 2.33333333333333}, },
            ['seqTex_2_1'] = {{0, 2.33333333333333}, },
            ['seqTex_3_4'] = {{0, 2.33333333333333}, },
            ['seqTex_4_3'] = {{0, 2.33333333333333}, },
            ['seqTex_1.85_1'] = {{0, 2.33333333333333}, },
            ['seqTex_2.35_1'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_270-trs-matte'] = {
        ['nodeDuration'] = {{0, 2.3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.3}, },
            ['maskTex'] = {{0, 2.43333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_382-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(430, 430, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiGaussianBlur_270-effect0'] = {
        ['intensity'] = 0,
        ['quality'] = NaN,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
    },
    ['LumiAnimSeqLoadAndCrop_336-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 0,
        ['cropType_1_1'] = 1,
        ['edgeType_1_1'] = 0,
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
        ['specify_9_16'] = true,
        ['animSeqType_9_16'] = 0,
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
        ['specify_5.8'] = true,
        ['animSeqType_5.8'] = 0,
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
        ['specify_2_1'] = true,
        ['animSeqType_2_1'] = 0,
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
        ['specify_3_4'] = true,
        ['animSeqType_3_4'] = 0,
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
        ['specify_4_3'] = true,
        ['animSeqType_4_3'] = 0,
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
        ['specify_1.85_1'] = true,
        ['animSeqType_1.85_1'] = 0,
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
        ['specify_2.35_1'] = true,
        ['animSeqType_2.35_1'] = 0,
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
    },
    ['LumiLayer_270-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
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
        ['mirrorEdge'] = true,
        ['matteMode'] = 'Luma',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_382-trs-blend#scale#vector'] =
{
	{
		{0.001,0.001,0.001, 0,0,0.001, 0.47,0.47,0.47, 1,1,0.47, }, 
		{0.6, 1.3, }, 
		{{430, 430, 100, }, {240, 240, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_382-trs-blend#opacity#number'] =
{
	{
		{0.001, 0, 0.46, 1, }, 
		{0.6, 1.3, }, 
		{{0, }, {28, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{1.3, 1.9, }, 
		{{28, }, {28, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.9, 1.933333, }, 
		{{28, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_270-effect0#intensity#number'] =
{
	{
		{0.5, 0, 0.79, 1, }, 
		{0.633333, 1.566667, }, 
		{{0, }, {28, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_336-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2.43333333333333, }, 
		{{0, }, {2.43333333333333, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_270-trs-matte#position#vector'] =
{
	{
		{0.42, 0, 0.66, 1, }, 
		{0.633333, 0.933333, }, 
		{{540, 540, 0, }, {540, 572.680478899, 0, }, {540, 540, 0, }, {540, 572.680478899, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.31, 0, 0.54, 1, }, 
		{0.933333, 1.366667, }, 
		{{540, 572.680478899, 0, }, {540, 500, 0, }, {540, 572.680478899, 0, }, {540, 500, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.25, 0.25, 0.65, 0.65, }, 
		{1.366667, 1.7, }, 
		{{540, 500, 0, }, {540, 500, 0, }, {540, 500, 0, }, {540, 500, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.65, 0, 0.999, 1, }, 
		{1.7, 2, }, 
		{{540, 500, 0, }, {780, 500, 0, }, {540, 500, 0, }, {780, 500, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_270-trs-matte#scale#vector'] =
{
	{
		{0.23,0.23,0.23, 0,0,0.23, 0.25,0.25,0.25, 1,1,0.25, }, 
		{0.633333, 1.366667, }, 
		{{100, 100, 100, }, {77, 77, 100, }, }, 
		{6414, }, 
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
