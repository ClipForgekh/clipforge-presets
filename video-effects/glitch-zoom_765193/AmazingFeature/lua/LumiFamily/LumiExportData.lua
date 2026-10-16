local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiAnimSeqLoadAndCrop_1640-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['seqTex_1_1'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiChromaticAberration_1257-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_1257-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiMotionBlur2D_1635-effect0'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiMotionBlur3D_1635-effect1'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiLayer_1635-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiDisplacementMap_1622-effect0'] = {
        ['nodeDuration'] = {{0, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['horizontalImage'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiMotionBlur2D_1622-effect1'] = {
        ['nodeDuration'] = {{0, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
        },
    },
    ['LumiExposure_1622-effect2'] = {
        ['nodeDuration'] = {{0, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
        },
    },
    ['LumiDirectionalBlurs_1622-effect3'] = {
        ['nodeDuration'] = {{0, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
        },
    },
    ['LumiLayer_1622-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiAnimSeqLoadAndCrop_1640-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 2,
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
    ['LumiChromaticAberration_1257-effect0'] = {
        ['offsetX'] = 0.48888888888889,
        ['offsetY'] = 0.48888888888889,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_1257-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(154.008746350346, 154.008746350346, 100),
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
    ['LumiMotionBlur2D_1635-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
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
    ['LumiMotionBlur3D_1635-effect1'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 11,
        ['ae_pre_direction_y'] = 11,
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
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_1635-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiDisplacementMap_1622-effect0'] = {
        ['horizontalType'] = 0,
        ['horizontalIntensity'] = 0.08,
        ['verticalType'] = 0,
        ['verticalIntensity'] = 0,
        ['edgeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiMotionBlur2D_1622-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.49810730031375, 0.4990702920207),
        ['ae_pre_position'] = Amaz.Vector2f(0.49810730031375, 0.4990702920207),
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
    ['LumiExposure_1622-effect2'] = {
        ['channelType'] = 0,
        ['exposure'] = 0.72,
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
    ['LumiDirectionalBlurs_1622-effect3'] = {
        ['blurIntensity'] = 3.0355143663213e-7,
        ['angle'] = 0,
        ['directionNum'] = 1.45,
        ['exposure'] = 1,
        ['quality'] = 1,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_1622-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiChromaticAberration_1257-effect0#offsetX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.37832, 0.558333, }, 
		{{0, }, {0.45, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.558333, 0.783333, }, 
		{{0.45, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.783333, 1.2, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_1257-effect0#offsetY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.37832, 0.558333, }, 
		{{0, }, {0.45, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.558333, 0.783333, }, 
		{{0.45, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.783333, 1.2, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_1257-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.333333, 0.566667, }, 
		{{100, 100, 100, }, {150, 150, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.566667, 0.8, }, 
		{{150, 150, 100, }, {155, 155, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.8, 1.233333, }, 
		{{155, 155, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1257-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur2D_1635-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.149422672, 3e-9, 0.357153105, 0.999999978, }, 
		{0.03333333333333, 0.33333333333333, }, 
		{{1.3, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1635-effect0#scale_x#number'] =
{
	{
		{0.149422672, 3e-9, 0.357153105, 0.999999978, }, 
		{0, 0.3, }, 
		{{1.3, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_1635-effect1#ae_pre_direction_y#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.36666633333333, 0.53333333333333, }, 
		{{0, }, {11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.53333333333333, 0.83333333333333, }, 
		{{11, }, {11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.83333333333333, 1.13333333333333, }, 
		{{11, }, {360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_1635-effect1#direction_y#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.333333, 0.5, }, 
		{{0, }, {11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.5, 0.8, }, 
		{{11, }, {11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.8, 1.1, }, 
		{{11, }, {360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDisplacementMap_1622-effect0#horizontalIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 0.6, }, 
		{{0, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.733333, }, 
		{{0.05, }, {0.08, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.733333, 1.066667, }, 
		{{0.08, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur2D_1622-effect1#ae_pre_position#vector'] =
{
	{
		{0.333333, 0.327471, 0.666667, 0.663125, }, 
		{0.10000033333333, 0.20371133333333, }, 
		{{0.5, 0.5, }, {0.5, 0.33333331346481, }, {0.5, 0.5, }, {0.5, 0.33333331346481, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.323207, 0.666667, 0.758448, }, 
		{0.20371133333333, 0.35924433333333, }, 
		{{0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, {0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.442228, 0.666667, 0.805525, }, 
		{0.35924433333333, 0.51481133333333, }, 
		{{0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, {0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.511618, 0.666667, 0.771171, }, 
		{0.51481133333333, 0.67037733333333, }, 
		{{0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, {0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.419221, 0.666667, 0.726777, }, 
		{0.67037733333333, 0.82591133333333, }, 
		{{0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.33587, 0.666667, 0.814417, }, 
		{0.82591133333333, 0.92962233333333, }, 
		{{0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.641979, 0.666667, 1, }, 
		{0.92962233333333, 1.03333333333333, }, 
		{{0.5, 0.5046296417713, }, {0.5, 0.5, }, {0.5, 0.5046296417713, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1622-effect1#position#vector'] =
{
	{
		{0.333333, 0.327471, 0.666667, 0.663125, }, 
		{0.066667, 0.170378, }, 
		{{0.5, 0.5, }, {0.5, 0.33333331346481, }, {0.5, 0.5, }, {0.5, 0.33333331346481, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.323207, 0.666667, 0.758448, }, 
		{0.170378, 0.325911, }, 
		{{0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, {0.5, 0.33333331346481, }, {0.46942239999792, 0.58811682462685, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.442228, 0.666667, 0.805525, }, 
		{0.325911, 0.481478, }, 
		{{0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, {0.46942239999792, 0.58811682462685, }, {0.52038502693177, 0.4783484339713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.511618, 0.666667, 0.771171, }, 
		{0.481478, 0.637044, }, 
		{{0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, {0.52038502693177, 0.4783484339713, }, {0.5, 0.51851850748056, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.419221, 0.666667, 0.726777, }, 
		{0.637044, 0.792578, }, 
		{{0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.51851850748056, }, {0.49716871976875, 0.48942601680741, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.33587, 0.666667, 0.814417, }, 
		{0.792578, 0.896289, }, 
		{{0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, {0.49716871976875, 0.48942601680741, }, {0.5, 0.5046296417713, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.641979, 0.666667, 1, }, 
		{0.896289, 1, }, 
		{{0.5, 0.5046296417713, }, {0.5, 0.5, }, {0.5, 0.5046296417713, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiExposure_1622-effect2#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.933333, }, 
		{{3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDirectionalBlurs_1622-effect3#blurIntensity#number'] =
{
	{
		{0.182859926, 5e-9, 0.228818738, 0.99999998, }, 
		{0, 0.4, }, 
		{{150, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.228818738, 0.000002695, }, 
		{0.4, 0.766667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.766667, 0.966667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.966667, 1.133333, }, 
		{{100, }, {0, }, }, 
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
