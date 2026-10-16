local data = {}

local ae_compDurations = {0, 1.20833333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiDistort_103-effect0'] = {
        ['nodeDuration'] = {{0.54166666666667, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.54166666666667, 0.66666666666667}, },
        },
    },
    ['LumiTemperatureTone_103-effect1'] = {
        ['nodeDuration'] = {{0.54166666666667, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.54166666666667, 0.66666666666667}, },
        },
    },
    ['LumiExposure_103-effect2'] = {
        ['nodeDuration'] = {{0.54166666666667, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.54166666666667, 0.66666666666667}, },
        },
    },
    ['LumiTritone_103-effect3'] = {
        ['nodeDuration'] = {{0.54166666666667, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.54166666666667, 0.66666666666667}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_86-effect0'] = {
        ['nodeDuration'] = {{0, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
            ['seqTex_1_1'] = {{0, 1.20833333333333}, },
            ['seqTex_9_16'] = {{0, 1.20833333333333}, },
            ['seqTex_16_9'] = {{0, 1.20833333333333}, },
            ['seqTex_5.8'] = {{0, 1.20833333333333}, },
            ['seqTex_2_1'] = {{0, 1.20833333333333}, },
            ['seqTex_3_4'] = {{0, 1.20833333333333}, },
            ['seqTex_4_3'] = {{0, 1.20833333333333}, },
            ['seqTex_1.85_1'] = {{0, 1.20833333333333}, },
            ['seqTex_2.35_1'] = {{0, 1.20833333333333}, },
        },
    },
    ['LumiDistort_86-effect1'] = {
        ['nodeDuration'] = {{0, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
        },
    },
    ['LumiExtractFrame_86-effect2'] = {
        ['nodeDuration'] = {{0, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
        },
    },
    ['LumiLayer_125-trs'] = {
        ['nodeDuration'] = {{0, 1.20833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.20833333333333}, },
        },
    },
    ['LumiLayer_86-blend'] = {
        ['nodeDuration'] = {{0, 1.20833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
            ['baseTex'] = {{0, 1.20833333333333}, },
        },
    },
    ['LumiLayer_103-blend'] = {
        ['nodeDuration'] = {{0, 1.20833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.54166666666667, 0.66666666666667}, },
            ['baseTex'] = {{0, 1.20833333333333}, },
        },
    },
    ['LumiDistort_126-effect0'] = {
        ['nodeDuration'] = {{0, 0.54166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.54166666666667}, },
        },
    },
    ['LumiTemperatureTone_126-effect1'] = {
        ['nodeDuration'] = {{0, 0.54166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.54166666666667}, },
        },
    },
    ['LumiExposure_126-effect2'] = {
        ['nodeDuration'] = {{0, 0.54166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.54166666666667}, },
        },
    },
    ['LumiLayer_126-blend'] = {
        ['nodeDuration'] = {{0, 1.20833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.54166666666667}, },
            ['baseTex'] = {{0, 1.20833333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiDistort_103-effect0'] = {
        ['amount'] = 0,
        ['rotateWarpDir'] = 92,
        ['blurLens'] = 96,
        ['stride'] = 0.49000000953674,
        ['amountRelX'] = 1,
        ['amountRelY'] = 1,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['fine'] = false,
        ['downScale'] = 0.5,
    },
    ['LumiTemperatureTone_103-effect1'] = {
        ['temperatureIntensity'] = 0,
        ['toneIntensity'] = 0,
    },
    ['LumiExposure_103-effect2'] = {
        ['channelType'] = 0,
        ['exposure'] = 0,
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
    },
    ['LumiTritone_103-effect3'] = {
        ['highlightColor'] = Amaz.Color(1, 1, 1, 1),
        ['middleColor'] = Amaz.Color(0.61254906654358, 0.61254906654358, 0.61254906654358, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 0,
    },
    ['LumiAnimSeqLoadAndCrop_86-effect0'] = {
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
        ['playMode_1_1'] = 1,
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
        ['scale_16_9'] = 1,
        ['opacity_16_9'] = 1,
        ['speed_16_9'] = 1,
        ['playMode_16_9'] = 1,
        ['specify_5.8'] = true,
        ['animSeqType_5.8'] = 0,
        ['cropType_5.8'] = 1,
        ['edgeType_5.8'] = 0,
        ['enableVideoAlphaBlend_5.8'] = true,
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
        ['enableVideoAlphaBlend_2_1'] = true,
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
        ['enableVideoAlphaBlend_3_4'] = true,
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
        ['enableVideoAlphaBlend_4_3'] = true,
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
        ['enableVideoAlphaBlend_1.85_1'] = true,
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
        ['enableVideoAlphaBlend_2.35_1'] = true,
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
    ['LumiDistort_86-effect1'] = {
        ['amount'] = 1.10000002384186,
        ['rotateWarpDir'] = 92,
        ['blurLens'] = 96,
        ['stride'] = 0.49000000953674,
        ['amountRelX'] = 1,
        ['amountRelY'] = 1,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['fine'] = false,
        ['downScale'] = 0.5,
    },
    ['LumiExtractFrame_86-effect2'] = {
        ['fps'] = 15,
    },
    ['LumiLayer_125-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_86-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_103-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Overlay',
    },
    ['LumiDistort_126-effect0'] = {
        ['amount'] = 0,
        ['rotateWarpDir'] = 92,
        ['blurLens'] = 96,
        ['stride'] = 0.49000000953674,
        ['amountRelX'] = 1,
        ['amountRelY'] = 1,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['fine'] = false,
        ['downScale'] = 0.5,
    },
    ['LumiTemperatureTone_126-effect1'] = {
        ['temperatureIntensity'] = 0,
        ['toneIntensity'] = 0,
    },
    ['LumiExposure_126-effect2'] = {
        ['channelType'] = 0,
        ['exposure'] = 0,
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
    },
    ['LumiLayer_126-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiDistort_103-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.666667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_103-effect0#rotateWarpDir#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.666667, }, 
		{{92, }, {92, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_103-effect0#blurLens#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.666667, }, 
		{{96, }, {96, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_103-effect0#stride#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.666667, }, 
		{{0.49, }, {0.49, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_103-effect0#amountRelX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.458333, 0.666667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_103-effect0#amountRelY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.458333, 0.666667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_103-effect0#wrapModeX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.458333, 0.666667, }, 
		{{2, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_103-effect0#wrapModeY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.458333, 0.666667, }, 
		{{2, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTemperatureTone_103-effect1#temperatureIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.583333, }, 
		{{0, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTemperatureTone_103-effect1#toneIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.583333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExposure_103-effect2#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.583333, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_86-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.16666666666667, }, 
		{{0, }, {1.16666666666667, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_86-effect1#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.75, }, 
		{{1.1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_86-effect1#rotateWarpDir#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.75, }, 
		{{92, }, {92, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_86-effect1#blurLens#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.75, }, 
		{{96, }, {96, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_86-effect1#stride#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.75, }, 
		{{0.49, }, {0.49, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_86-effect1#amountRelX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.75, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_86-effect1#amountRelY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.75, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_86-effect1#wrapModeX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.583333, 0.75, }, 
		{{2, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_86-effect1#wrapModeY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.583333, 0.75, }, 
		{{2, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_125-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.875, 1.083333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_126-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.375, 0.541667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_126-effect0#rotateWarpDir#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.375, 0.541667, }, 
		{{92, }, {92, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_126-effect0#blurLens#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.375, 0.541667, }, 
		{{96, }, {96, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_126-effect0#stride#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.375, 0.541667, }, 
		{{0.49, }, {0.49, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_126-effect0#amountRelX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.541667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_126-effect0#amountRelY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.541667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_126-effect0#wrapModeX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.541667, }, 
		{{2, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_126-effect0#wrapModeY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.541667, }, 
		{{2, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTemperatureTone_126-effect1#temperatureIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.375, 0.458333, }, 
		{{0, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTemperatureTone_126-effect1#toneIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.375, 0.458333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExposure_126-effect2#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.416667, 0.5, }, 
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
