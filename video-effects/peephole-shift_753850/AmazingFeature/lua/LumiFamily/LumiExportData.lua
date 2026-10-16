local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBulge_447-effect0'] = {
        ['nodeDuration'] = {{0, 3.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.16666666666667}, },
        },
    },
    ['LumiMotionBlur2D_447-effect1'] = {
        ['nodeDuration'] = {{0, 3.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.16666666666667}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_847-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex_1_1'] = {{0, 2.16666666666667}, },
            ['seqTex_16_9'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiLayer_847-blend'] = {
        ['nodeDuration'] = {{0, 3.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3.16666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBulge_447-effect0'] = {
        ['bulge_height'] = 0.2,
        ['taper_radius'] = 0,
        ['pinning'] = 0,
        ['bulge_radius_x'] = 1,
        ['bulge_radius_y'] = 1,
        ['bulge_center_x'] = 0,
        ['bulge_center_y'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiMotionBlur2D_447-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.67051029522764, 0.72109375),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.67051029522764, 0.72109375),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.8,
        ['ae_pre_scale_x'] = 1.8,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 2,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiAnimSeqLoadAndCrop_847-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 0,
        ['cropType_1_1'] = 1,
        ['edgeType_1_1'] = 1,
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
        ['playMode_9_16'] = 1,
        ['specify_16_9'] = false,
        ['animSeqType_16_9'] = 0,
        ['cropType_16_9'] = 1,
        ['edgeType_16_9'] = 2,
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
        ['playMode_5.8'] = 1,
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
        ['playMode_2_1'] = 1,
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
        ['playMode_3_4'] = 1,
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
        ['playMode_4_3'] = 1,
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
        ['playMode_1.85_1'] = 1,
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
        ['playMode_2.35_1'] = 1,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_847-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiBulge_447-effect0#bulge_height#number'] =
{
	{
		{0.33333333, 0.033820899, 0, 0.898537302, }, 
		{1.440527, 1.666667, }, 
		{{0.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_447-effect1#ae_pre_anchor#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.36666633333333, 0.71800133333333, }, 
		{{0.5, 0.72109375, }, {0.34877124005278, 0.72109375, }, {0.5, 0.72109375, }, {0.34877124005278, 0.72109375, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.020041, 1, }, 
		{0.71800133333333, 1.11207633333333, }, 
		{{0.34877124005278, 0.72109375, }, {0.68222293678472, 0.72109375, }, {0.34877124005278, 0.72109375, }, {0.68222293678472, 0.72109375, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0, 1, }, 
		{1.11207633333333, 1.47386033333333, }, 
		{{0.68222293678472, 0.72109375, }, {0.5, 0.72109375, }, {0.68222293678472, 0.72109375, }, {0.5, 0.72109375, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0, 1, }, 
		{1.47386033333333, 1.70000033333333, }, 
		{{0.5, 0.72109375, }, {0.5, 0.5, }, {0.5, 0.72109375, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_447-effect1#anchor#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.333333, 0.684668, }, 
		{{0.5, 0.72109375, }, {0.34877124005278, 0.72109375, }, {0.5, 0.72109375, }, {0.34877124005278, 0.72109375, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.020041, 1, }, 
		{0.684668, 1.078743, }, 
		{{0.34877124005278, 0.72109375, }, {0.68222293678472, 0.72109375, }, {0.34877124005278, 0.72109375, }, {0.68222293678472, 0.72109375, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0, 1, }, 
		{1.078743, 1.440527, }, 
		{{0.68222293678472, 0.72109375, }, {0.5, 0.72109375, }, {0.68222293678472, 0.72109375, }, {0.5, 0.72109375, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0, 1, }, 
		{1.440527, 1.666667, }, 
		{{0.5, 0.72109375, }, {0.5, 0.5, }, {0.5, 0.72109375, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_447-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.078612549, 0.999999974, }, 
		{1.47386033333333, 1.70000033333333, }, 
		{{1.8, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_447-effect1#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.078612549, 0.999999974, }, 
		{1.440527, 1.666667, }, 
		{{1.8, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_447-effect1#vIntensity#number'] =
{
	{
		{0.33333333, 0, 0.078612549, 0.99999999, }, 
		{1.440527, 1.666667, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_847-effect0#seqTime#number'] =
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
