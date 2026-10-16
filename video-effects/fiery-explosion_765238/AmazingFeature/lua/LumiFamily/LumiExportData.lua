local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_175368984-trs'] = {
        ['nodeDuration'] = {{0.5, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 3}, },
        },
    },
    ['LumiMotionBlur2D_80-effect0'] = {
        ['nodeDuration'] = {{0.5, 2.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 3}, },
        },
    },
    ['LumiRadialBlur_80-effect1'] = {
        ['nodeDuration'] = {{0.5, 2.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 2.5}, },
        },
    },
    ['LumiExposure_80-effect2'] = {
        ['nodeDuration'] = {{0.5, 2.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 2.5}, },
        },
    },
    ['LumiLayer_80-blend'] = {
        ['nodeDuration'] = {{0.5, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 2.5}, },
            ['baseTex'] = {{0.5, 3}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_175368988-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['seqTex_1_1'] = {{0, 2.2}, },
        },
    },
    ['LumiLayer_175368988-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0.5, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_175368984-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiMotionBlur2D_80-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.50033493420093, 0.51785849699757),
        ['ae_pre_position'] = Amaz.Vector2f(0.50033493420093, 0.51785849699757),
        ['unifiedScale'] = true,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRadialBlur_80-effect1'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiExposure_80-effect2'] = {
        ['channelType'] = 0,
        ['exposure'] = 1.08,
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
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_80-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLoadAndCrop_175368988-effect0'] = {
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
        ['playMode_9_16'] = 0,
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
        ['lite_mode'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_175368988-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 12,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_175368984-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.533333, 0.733333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur2D_80-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0.327471, 0.666667, 0.663125, }, 
		{0.60000033333333, 0.70371133333333, }, 
		{{0.5, 0.5, }, {0.5, 0.33333331346481, }, {0.5, 0.5, }, {0.5, 0.33333331346481, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.323207, 0.666667, 0.758448, }, 
		{0.70371133333333, 0.85924433333333, }, 
		{{0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, {0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.442228, 0.666667, 0.805525, }, 
		{0.85924433333333, 1.01481133333333, }, 
		{{0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, {0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.511618, 0.666667, 0.771171, }, 
		{1.01481133333333, 1.17037733333333, }, 
		{{0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, {0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.419221, 0.666667, 0.726777, }, 
		{1.17037733333333, 1.32591133333333, }, 
		{{0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.33587, 0.666667, 0.814417, }, 
		{1.32591133333333, 1.42962233333333, }, 
		{{0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.641979, 0.666667, 1, }, 
		{1.42962233333333, 1.53333333333333, }, 
		{{0.5, 0.5046296417713, }, {0.5, 0.5, }, {0.5, 0.5046296417713, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_80-effect0#position#vector'] =
{
	{
		{0.333333, 0.327471, 0.666667, 0.663125, }, 
		{0.566667, 0.670378, }, 
		{{0.5, 0.5, }, {0.5, 0.33333331346481, }, {0.5, 0.5, }, {0.5, 0.33333331346481, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.323207, 0.666667, 0.758448, }, 
		{0.670378, 0.825911, }, 
		{{0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, {0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.442228, 0.666667, 0.805525, }, 
		{0.825911, 0.981478, }, 
		{{0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, {0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.511618, 0.666667, 0.771171, }, 
		{0.981478, 1.137044, }, 
		{{0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, {0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.419221, 0.666667, 0.726777, }, 
		{1.137044, 1.292578, }, 
		{{0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.33587, 0.666667, 0.814417, }, 
		{1.292578, 1.396289, }, 
		{{0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.641979, 0.666667, 1, }, 
		{1.396289, 1.5, }, 
		{{0.5, 0.5046296417713, }, {0.5, 0.5, }, {0.5, 0.5046296417713, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_80-effect1#amount#number'] =
{
	{
		{0.234548317, 5e-9, 0.198098315, 0.999999983, }, 
		{0.5, 1, }, 
		{{150, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiExposure_80-effect2#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 1.433333, }, 
		{{3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_175368988-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2.03333333333333, }, 
		{{0, }, {2.03333333333333, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_175368988-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.833333, 1.1, }, 
		{{100, }, {0, }, }, 
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
