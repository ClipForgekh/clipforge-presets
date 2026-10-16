local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiAnimSeqLayout_100-effect0'] = {
        ['nodeDuration'] = {{1.26666666666667, 3.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.26666666666667, 3.26666666666667}, },
            ['seqTex'] = {{0, 2}, },
        },
    },
    ['LumiBulge_100-effect1'] = {
        ['nodeDuration'] = {{1.26666666666667, 3.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.26666666666667, 3.26666666666667}, },
        },
    },
    ['LumiAnimSeqLayout_96-effect0'] = {
        ['nodeDuration'] = {{0.33333333333333, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.33333333333333, 2.33333333333333}, },
            ['seqTex'] = {{0, 2}, },
        },
    },
    ['LumiAnimSeqLayout_90-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_96-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.33333333333333, 2.33333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiAnimSeqLayout_97-effect0'] = {
        ['nodeDuration'] = {{0.66666666666667, 2.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 2.66666666666667}, },
            ['seqTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_97-blend'] = {
        ['nodeDuration'] = {{0, 2.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 2.66666666666667}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiAnimSeqLayout_98-effect0'] = {
        ['nodeDuration'] = {{0.86666666666667, 2.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.86666666666667, 2.86666666666667}, },
            ['seqTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_98-blend'] = {
        ['nodeDuration'] = {{0, 2.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.86666666666667, 2.86666666666667}, },
            ['baseTex'] = {{0, 2.66666666666667}, },
        },
    },
    ['LumiAnimSeqLayout_99-effect0'] = {
        ['nodeDuration'] = {{1.06666666666667, 3.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.06666666666667, 3.06666666666667}, },
            ['seqTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_99-blend'] = {
        ['nodeDuration'] = {{0, 3.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.06666666666667, 3.06666666666667}, },
            ['baseTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiLayer_100-blend'] = {
        ['nodeDuration'] = {{0, 3.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.26666666666667, 3.26666666666667}, },
            ['baseTex'] = {{0, 3.06666666666667}, },
        },
    },
    ['LumiSoftGlow_102-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.26666666666667}, },
        },
    },
    ['LumiLayer_102-blend'] = {
        ['nodeDuration'] = {{0, 3.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3.26666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiAnimSeqLayout_100-effect0'] = {
        ['animSeqType'] = 2,
        ['alignmentType'] = 4,
        ['edgeType'] = 2,
        ['enableVideoAlphaBlend'] = false,
        ['offsetGlobalX'] = 0,
        ['offsetGlobalY'] = 0,
        ['offsetLocalX'] = 0,
        ['offsetLocalY'] = 0,
        ['rotation'] = 0,
        ['scale'] = 0.09928003726887,
        ['opacity'] = 0.03341423564759,
        ['enableInputBlend'] = false,
        ['speed'] = 1,
        ['playMode'] = 0,
        ['enableAdaptiveScale'] = false,
        ['designRatio'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiBulge_100-effect1'] = {
        ['bulge_height'] = 0,
        ['taper_radius'] = 0,
        ['pinning'] = 0,
        ['bulge_radius_x'] = 1,
        ['bulge_radius_y'] = 1,
        ['bulge_center_x'] = 0,
        ['bulge_center_y'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiAnimSeqLayout_96-effect0'] = {
        ['animSeqType'] = 2,
        ['alignmentType'] = 4,
        ['edgeType'] = 2,
        ['enableVideoAlphaBlend'] = false,
        ['offsetGlobalX'] = 0,
        ['offsetGlobalY'] = 0,
        ['offsetLocalX'] = 0,
        ['offsetLocalY'] = 0,
        ['rotation'] = 0,
        ['scale'] = 5,
        ['opacity'] = 1,
        ['enableInputBlend'] = false,
        ['speed'] = 1,
        ['playMode'] = 0,
        ['enableAdaptiveScale'] = false,
        ['designRatio'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiAnimSeqLayout_90-effect0'] = {
        ['animSeqType'] = 2,
        ['alignmentType'] = 4,
        ['edgeType'] = 2,
        ['enableVideoAlphaBlend'] = false,
        ['offsetGlobalX'] = 0,
        ['offsetGlobalY'] = 0,
        ['offsetLocalX'] = 0,
        ['offsetLocalY'] = 0,
        ['rotation'] = 0,
        ['scale'] = 5,
        ['opacity'] = 1,
        ['enableInputBlend'] = false,
        ['speed'] = 1,
        ['playMode'] = 0,
        ['enableAdaptiveScale'] = false,
        ['designRatio'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_96-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLayout_97-effect0'] = {
        ['animSeqType'] = 2,
        ['alignmentType'] = 4,
        ['edgeType'] = 2,
        ['enableVideoAlphaBlend'] = false,
        ['offsetGlobalX'] = 0,
        ['offsetGlobalY'] = 0,
        ['offsetLocalX'] = 0,
        ['offsetLocalY'] = 0,
        ['rotation'] = 0,
        ['scale'] = 5,
        ['opacity'] = 1,
        ['enableInputBlend'] = false,
        ['speed'] = 1,
        ['playMode'] = 0,
        ['enableAdaptiveScale'] = false,
        ['designRatio'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_97-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLayout_98-effect0'] = {
        ['animSeqType'] = 2,
        ['alignmentType'] = 4,
        ['edgeType'] = 2,
        ['enableVideoAlphaBlend'] = false,
        ['offsetGlobalX'] = 0,
        ['offsetGlobalY'] = 0,
        ['offsetLocalX'] = 0,
        ['offsetLocalY'] = 0,
        ['rotation'] = 0,
        ['scale'] = 4.24558025168069,
        ['opacity'] = 1,
        ['enableInputBlend'] = false,
        ['speed'] = 1,
        ['playMode'] = 0,
        ['enableAdaptiveScale'] = false,
        ['designRatio'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_98-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLayout_99-effect0'] = {
        ['animSeqType'] = 2,
        ['alignmentType'] = 4,
        ['edgeType'] = 2,
        ['enableVideoAlphaBlend'] = false,
        ['offsetGlobalX'] = 0,
        ['offsetGlobalY'] = 0,
        ['offsetLocalX'] = 0,
        ['offsetLocalY'] = 0,
        ['rotation'] = 0,
        ['scale'] = 1.54803426761382,
        ['opacity'] = 0.96658576435241,
        ['enableInputBlend'] = false,
        ['speed'] = 1,
        ['playMode'] = 0,
        ['enableAdaptiveScale'] = false,
        ['designRatio'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_99-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
    ['LumiLayer_100-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
    ['LumiSoftGlow_102-effect0'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0.49159434112084,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 1.04539055794748,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_102-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiAnimSeqLayout_100-effect0#scale#number'] =
{
	{
		{0.48, 0.031111111, 0.52, 0.968888889, }, 
		{1.266667, 1.733333, }, 
		{{0.04, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.733333, 1.933333, }, 
		{{5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_100-effect0#opacity#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.266667, 1.533333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBulge_100-effect1#bulge_height#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.466667, 1.633333, }, 
		{{0, }, {0.42, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.633333, 1.933333, }, 
		{{0.42, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBulge_100-effect1#taper_radius#number'] =
{
	{
		{0.48, 0, 0.52, 0, }, 
		{1.466667, 1.633333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBulge_100-effect1#pinning#number'] =
{
	{
		{0.48, 0, 0.52, 0, }, 
		{1.466667, 1.633333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBulge_100-effect1#bulge_radius_x#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.466667, 1.633333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBulge_100-effect1#bulge_radius_y#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.466667, 1.633333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_96-effect0#scale#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{0.333333, 0.933333, }, 
		{{0.04, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_96-effect0#opacity#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{0.333333, 0.6, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_90-effect0#scale#number'] =
{
	{
		{0.48, 0.0496, 0.52, 0.9504, }, 
		{0, 0.6, }, 
		{{1, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_97-effect0#scale#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{0.666667, 1.266667, }, 
		{{0.04, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_97-effect0#opacity#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{0.666667, 0.933333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_98-effect0#scale#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{0.866667, 1.466667, }, 
		{{0.04, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_98-effect0#opacity#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{0.866667, 1.133333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_99-effect0#scale#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.066667, 1.666667, }, 
		{{0.04, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLayout_99-effect0#opacity#number'] =
{
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.066667, 1.333333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_102-effect0#thresholdLow#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.266667, }, 
		{{0.5, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.266667, 1.666667, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_102-effect0#thresholdHigh#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.266667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.48, 0, 0.52, 0, }, 
		{1.266667, 1.666667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_102-effect0#thresholdSmooth#number'] =
{
	{
		{0.166666667, 0, 0.52, 0, }, 
		{0, 1.266667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_102-effect0#grayScale#number'] =
{
	{
		{0.166666667, 0, 0.52, 0, }, 
		{0, 1.266667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_102-effect0#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.266667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.266667, 1.666667, }, 
		{{1, }, {3.7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.48, 0.04, 0.52, 0.96, }, 
		{1.666667, 1.933333, }, 
		{{3.7, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_102-effect0#glowIntensity#number'] =
{
	{
		{0.166666667, 0, 0.52, 0, }, 
		{0, 1.266667, }, 
		{{50, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_102-effect0#glowColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.52, 0.52, }, 
		{0, 1.266667, }, 
		{{1, 1, 1, 1, }, {1, 1, 1, 1, }, }, 
		{6418, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_102-effect0#quality#number'] =
{
	{
		{0.166666667, 0, 0.52, 0, }, 
		{0, 1.266667, }, 
		{{0.5, }, {0.5, }, }, 
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
