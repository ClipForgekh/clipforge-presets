local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_95-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGrain_101-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSaturation_101-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_101-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_105-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex_1_1'] = {{0, 2}, },
        },
    },
    ['LumiLayer_105-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiSShake_108-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_108-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_95-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
    },
    ['LumiGrain_101-effect0'] = {
        ['grainIntensity'] = 1,
        ['intensityR'] = 10,
        ['intensityG'] = 10,
        ['intensityB'] = 10,
        ['scale'] = 0.3,
        ['scaleR'] = 1,
        ['scaleG'] = 1,
        ['scaleB'] = 1,
        ['brightness'] = 0,
        ['contrast'] = 1,
        ['saturation'] = 0.5,
        ['monochrome'] = false,
        ['combine'] = 4,
        ['speed'] = 1,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiSaturation_101-effect1'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_101-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLoadAndCrop_105-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 2,
        ['cropType_1_1'] = 0,
        ['edgeType_1_1'] = 1,
        ['enableVideoAlphaBlend_1_1'] = false,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 2.21,
        ['opacity_1_1'] = 0,
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
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_105-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 6,
    },
    ['LumiSShake_108-effect0'] = {
        ['ampRatio'] = 0,
        ['frqRatio'] = 0.10000000149012,
        ['phase0'] = 0,
        ['scale0'] = 1,
        ['blurEnabled'] = false,
        ['blurIntensity'] = 1,
        ['blurQuality'] = 0,
        ['seed'] = 0,
        ['xFill'] = 2,
        ['yFill'] = 2,
        ['xAmpR'] = 25,
        ['xFrqR'] = 1,
        ['xAmp'] = 0,
        ['xFrq'] = 0.5,
        ['xPhase'] = 0,
        ['yAmpR'] = 25,
        ['yFrqR'] = 1,
        ['yAmp'] = 0,
        ['yFrq'] = 0.5,
        ['yPhase'] = 0,
        ['zAmpR'] = 0,
        ['zFrqR'] = 1,
        ['zAmp'] = 0,
        ['zFrq'] = 0.5,
        ['zPhase'] = 0,
        ['wAmpR'] = 0,
        ['wFrqR'] = 1,
        ['wAmp'] = 0,
        ['wFrq'] = 0.5,
        ['wPhase'] = 0,
        ['rAmpRatio'] = 1,
        ['gAmpRatio'] = 1,
        ['bAmpRatio'] = 1,
        ['rPhase'] = 0,
        ['gPhase'] = 0,
        ['bPhase'] = 0,
        ['rgbRnd'] = 0,
        ['rgbFrq'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_108-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_95-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.1, 1, }, 
		{0.166667, 0.833333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_101-trs-blend#opacity#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.166667, 1.333333, }, 
		{{100, }, {75, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.333333, 1.5, }, 
		{{75, }, {50, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.5, 1.666667, }, 
		{{50, }, {25, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.666667, 1.833333, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_105-effect0#ae_pre_position_1_1#vector'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.36666633333333, 0.53333333333333, }, 
		{{0.5, 0.5, }, {0.912109375, 0.5, }, {1, 1, }, {1.412109375, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.53333333333333, 0.70000033333333, }, 
		{{0.912109375, 0.5, }, {-0.078125, 0.5, }, {1.82421875, 1, }, {0.833984375, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.70000033333333, 0.86666633333333, }, 
		{{-0.078125, 0.5, }, {0.5, -0.083984375, }, {-0.15625, 1, }, {0.421875, 0.416015625, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.86666633333333, 1.03333333333333, }, 
		{{0.5, -0.083984375, }, {0.912109375, 1.55078125, }, {1, -0.16796875, }, {1.412109375, 1.466796875, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.03333333333333, 1.20000033333333, }, 
		{{0.912109375, 1.55078125, }, {1.810546875, 0.5, }, {1.82421875, 3.1015625, }, {2.72265625, 2.05078125, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.20000033333333, 1.36666633333333, }, 
		{{1.810546875, 0.5, }, {2.837890625, 0.5, }, {3.62109375, 1, }, {4.6484375, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.36666633333333, 1.53750033333333, }, 
		{{2.837890625, 0.5, }, {0, 0.5, }, {5.67578125, 1, }, {2.837890625, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.53750033333333, 1.70000033333333, }, 
		{{0, 0.5, }, {0.875, 0.5, }, {0, 1, }, {0.875, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_105-effect0#position_1_1#vector'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.333333, 0.5, }, 
		{{0.5, 0.5, }, {0.912109375, 0.5, }, {1, 1, }, {1.412109375, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.5, 0.666667, }, 
		{{0.912109375, 0.5, }, {-0.078125, 0.5, }, {1.82421875, 1, }, {0.833984375, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.666667, 0.833333, }, 
		{{-0.078125, 0.5, }, {0.5, -0.083984375, }, {-0.15625, 1, }, {0.421875, 0.416015625, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.833333, 1, }, 
		{{0.5, -0.083984375, }, {0.912109375, 1.55078125, }, {1, -0.16796875, }, {1.412109375, 1.466796875, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1, 1.166667, }, 
		{{0.912109375, 1.55078125, }, {1.810546875, 0.5, }, {1.82421875, 3.1015625, }, {2.72265625, 2.05078125, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.166667, 1.333333, }, 
		{{1.810546875, 0.5, }, {2.837890625, 0.5, }, {3.62109375, 1, }, {4.6484375, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.333333, 1.504167, }, 
		{{2.837890625, 0.5, }, {0, 0.5, }, {5.67578125, 1, }, {2.837890625, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.504167, 1.666667, }, 
		{{0, 0.5, }, {0.875, 0.5, }, {0, 1, }, {0.875, 1, }, }, 
		{6415, }, 
		{2, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_105-effect0#opacity_1_1#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.166667, 0.333333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.333333, 1.666667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.666667, 1.833333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiSShake_108-effect0#ampRatio#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.333333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.333333, 1.666667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.666667, 2, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_108-effect0#frqRatio#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.333333, }, 
		{{0.1, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.333333, 1.666667, }, 
		{{15, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.666667, 2, }, 
		{{15, }, {0.1, }, }, 
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
