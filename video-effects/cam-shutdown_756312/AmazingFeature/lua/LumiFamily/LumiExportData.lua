local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiTritone_194-effect0', 'InputTex', 0},
    {'LumiTritone_193-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiTritone_194-effect0'] = {
        ['nodeDuration'] = {{0.36666666666667, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 0.43333333333333}, },
        },
    },
    ['LumiContrast_194-effect1'] = {
        ['nodeDuration'] = {{0.36666666666667, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 0.43333333333333}, },
        },
    },
    ['LumiWaveWarp_194-effect2'] = {
        ['nodeDuration'] = {{0.36666666666667, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 0.43333333333333}, },
        },
    },
    ['LumiGeometry_194-effect3'] = {
        ['nodeDuration'] = {{0.36666666666667, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 0.43333333333333}, },
        },
    },
    ['LumiTritone_193-effect0'] = {
        ['nodeDuration'] = {{0, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.43333333333333}, },
        },
    },
    ['LumiContrast_193-effect1'] = {
        ['nodeDuration'] = {{0, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.43333333333333}, },
        },
    },
    ['LumiGeometry_193-effect2'] = {
        ['nodeDuration'] = {{0, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.43333333333333}, },
        },
    },
    ['LumiLayer_194-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 0.43333333333333}, },
            ['baseTex'] = {{0, 0.43333333333333}, },
        },
    },
    ['LumiPixelSort_195-effect0'] = {
        ['nodeDuration'] = {{0.36666666666667, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.43333333333333}, },
        },
    },
    ['LumiLayer_195-blend'] = {
        ['nodeDuration'] = {{0, 0.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 0.43333333333333}, },
            ['baseTex'] = {{0, 0.43333333333333}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_212-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['seqTex_1_1'] = {{0, 1}, },
            ['seqTex_9_16'] = {{0, 1}, },
            ['seqTex_16_9'] = {{0, 1}, },
            ['seqTex_5.8'] = {{0, 1}, },
            ['seqTex_2_1'] = {{0, 1}, },
            ['seqTex_3_4'] = {{0, 1}, },
            ['seqTex_4_3'] = {{0, 1}, },
            ['seqTex_1.85_1'] = {{0, 1}, },
            ['seqTex_2.35_1'] = {{0, 1}, },
        },
    },
    ['LumiLayer_212-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 0.43333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiTritone_194-effect0'] = {
        ['highlightColor'] = Amaz.Color(1, 1, 1, 1),
        ['middleColor'] = Amaz.Color(0.52941179275513, 0.52941179275513, 0.52941179275513, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiContrast_194-effect1'] = {
        ['contrastIntensity'] = 1,
        ['pivot'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiWaveWarp_194-effect2'] = {
        ['type'] = 0,
        ['amplitude'] = 60,
        ['wavelength'] = 100,
        ['direction'] = 0,
        ['speed'] = 1,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiGeometry_194-effect3'] = {
        ['rotation'] = 0,
        ['rotationAxis'] = 270,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiTritone_193-effect0'] = {
        ['highlightColor'] = Amaz.Color(1, 1, 1, 1),
        ['middleColor'] = Amaz.Color(0.52941179275513, 0.52941179275513, 0.52941179275513, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiContrast_193-effect1'] = {
        ['contrastIntensity'] = 1,
        ['pivot'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiGeometry_193-effect2'] = {
        ['rotation'] = 0,
        ['rotationAxis'] = 270,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_194-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 448, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiPixelSort_195-effect0'] = {
        ['threshold'] = 0,
        ['rotate'] = 90,
        ['randomly'] = 1,
        ['reverseSort'] = false,
        ['affectType'] = 0,
        ['triggerType'] = 0,
        ['sortType'] = 0,
        ['featherStart'] = 0,
        ['featherEnd'] = 0,
        ['length'] = 1,
        ['offset'] = 0,
        ['offsetRandom'] = 0,
        ['randomSeed'] = 0,
        ['cycle'] = 0.45,
        ['blockSize'] = 0.241,
        ['blurSize'] = 0,
        ['outputType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_195-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLoadAndCrop_212-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 1,
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
        ['specify_9_16'] = true,
        ['animSeqType_9_16'] = 1,
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
        ['specify_16_9'] = true,
        ['animSeqType_16_9'] = 1,
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
        ['specify_5.8'] = true,
        ['animSeqType_5.8'] = 1,
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
        ['specify_2_1'] = true,
        ['animSeqType_2_1'] = 1,
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
        ['specify_3_4'] = true,
        ['animSeqType_3_4'] = 1,
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
        ['specify_4_3'] = true,
        ['animSeqType_4_3'] = 1,
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
        ['specify_1.85_1'] = true,
        ['animSeqType_1.85_1'] = 1,
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
        ['playMode_1.85_1'] = 0,
        ['specify_2.35_1'] = true,
        ['animSeqType_2.35_1'] = 1,
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
        ['playMode_2.35_1'] = 0,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_212-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiTritone_194-effect0#highlightColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{1, 1, 1, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiTritone_194-effect0#middleColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{0.529412, 0.529412, 0.529412, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiTritone_194-effect0#shadowColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{0, 0, 0, 1, }, {0, 0, 0, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiTritone_194-effect0#oriAlpha#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiContrast_194-effect1#contrastIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiContrast_194-effect1#pivot#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGeometry_194-effect3#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 0.4, }, 
		{{0, }, {-45, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTritone_193-effect0#highlightColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{1, 1, 1, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiTritone_193-effect0#middleColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{0.529412, 0.529412, 0.529412, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiTritone_193-effect0#shadowColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{0, 0, 0, 1, }, {0, 0, 0, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiTritone_193-effect0#oriAlpha#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiContrast_193-effect1#contrastIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiContrast_193-effect1#pivot#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.366667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGeometry_193-effect2#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 0.4, }, 
		{{0, }, {-45, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_194-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.366667, 0.4, }, 
		{{100, 100, 100, }, {204.365079365, 100, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_212-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1, }, 
		{{0, }, {1, }, }, 
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
