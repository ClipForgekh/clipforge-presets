local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiAnimSeqLoadAndCrop_599-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['seqTex_1_1'] = {{0, 2}, },
            ['seqTex_9_16'] = {{0, 2}, },
            ['seqTex_16_9'] = {{0, 2}, },
            ['seqTex_5.8'] = {{0, 2}, },
            ['seqTex_2_1'] = {{0, 2}, },
            ['seqTex_3_4'] = {{0, 2}, },
            ['seqTex_4_3'] = {{0, 2}, },
            ['seqTex_1.85_1'] = {{0, 2}, },
            ['seqTex_2.35_1'] = {{0, 2}, },
        },
    },
    ['LumiLayer_68-trs'] = {
        ['nodeDuration'] = {{1.1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.1, 3}, },
        },
    },
    ['LumiLayer_599-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{1.1, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiAnimSeqLoadAndCrop_599-effect0'] = {
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
        ['specify_9_16'] = true,
        ['animSeqType_9_16'] = 0,
        ['cropType_9_16'] = 1,
        ['edgeType_9_16'] = 3,
        ['enableVideoAlphaBlend_9_16'] = false,
        ['pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_9_16'] = 90,
        ['scale_9_16'] = 0.58,
        ['opacity_9_16'] = 1,
        ['speed_9_16'] = 1,
        ['playMode_9_16'] = 0,
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
        ['playMode_16_9'] = 0,
        ['specify_5.8'] = true,
        ['animSeqType_5.8'] = 0,
        ['cropType_5.8'] = 1,
        ['edgeType_5.8'] = 3,
        ['enableVideoAlphaBlend_5.8'] = false,
        ['pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['position_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_5.8'] = 90,
        ['scale_5.8'] = 0.6,
        ['opacity_5.8'] = 1,
        ['speed_5.8'] = 1,
        ['playMode_5.8'] = 0,
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
        ['playMode_2_1'] = 0,
        ['specify_3_4'] = true,
        ['animSeqType_3_4'] = 0,
        ['cropType_3_4'] = 1,
        ['edgeType_3_4'] = 3,
        ['enableVideoAlphaBlend_3_4'] = false,
        ['pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['position_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_3_4'] = 90,
        ['scale_3_4'] = 0.76,
        ['opacity_3_4'] = 1,
        ['speed_3_4'] = 1,
        ['playMode_3_4'] = 0,
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
        ['playMode_4_3'] = 0,
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
        ['playMode_1.85_1'] = 0,
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
        ['playMode_2.35_1'] = 0,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_68-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(30, 30, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = true,
    },
    ['LumiLayer_599-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 12,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiAnimSeqLoadAndCrop_599-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 3, }, 
		{{0, }, {3, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_68-trs#position#vector'] =
{
	{
		{0, 0, 0.38947, 1, }, 
		{1.1, 1.140007, }, 
		{{540, 540, 0, }, {527.434766686, 520.261391034, 0, }, {540, 540, 0, }, {527.434766686, 520.261391034, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.289589, 0, 0.628913, 1, }, 
		{1.140007, 1.180013, }, 
		{{527.434766686, 520.261391034, 0, }, {559.564653462, 525.925626392, 0, }, {527.434766686, 520.261391034, 0, }, {559.564653462, 525.925626392, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.31421, 0, 0.651174, 1, }, 
		{1.180013, 1.219987, }, 
		{{559.564653462, 525.925626392, 0, }, {562.157200842, 554.835810419, 0, }, {559.564653462, 525.925626392, 0, }, {562.157200842, 554.835810419, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.325936, 0, 0.662236, 1, }, 
		{1.219987, 1.259993, }, 
		{{562.157200842, 554.835810419, 0, }, {547.96151616, 536.59337138, 0, }, {562.157200842, 554.835810419, 0, }, {547.96151616, 536.59337138, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.334784, 0, 0.671006, 1, }, 
		{1.259993, 1.3, }, 
		{{547.96151616, 536.59337138, 0, }, {518.147984252, 560.504623554, 0, }, {547.96151616, 536.59337138, 0, }, {518.147984252, 560.504623554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.344582, 0, 0.681234, 1, }, 
		{1.3, 1.366667, }, 
		{{518.147984252, 560.504623554, 0, }, {549.336375011, 540.650807215, 0, }, {518.147984252, 560.504623554, 0, }, {549.336375011, 540.650807215, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.361114, 0, 0.699273, 1, }, 
		{1.366667, 1.466667, }, 
		{{549.336375011, 540.650807215, 0, }, {529.912869655, 551.156804102, 0, }, {549.336375011, 540.650807215, 0, }, {529.912869655, 551.156804102, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.418945, 0, 0.765303, 1, }, 
		{1.466667, 1.566667, }, 
		{{529.912869655, 551.156804102, 0, }, {538.38023011, 539.709311197, 0, }, {529.912869655, 551.156804102, 0, }, {538.38023011, 539.709311197, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.637559, 0, 1, 1, }, 
		{1.566667, 1.7, }, 
		{{538.38023011, 539.709311197, 0, }, {540, 540, 0, }, {538.38023011, 539.709311197, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_68-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0,0,0.66666667, 1.000000049,1.000000049,0.66666667, }, 
		{1.1, 1.7, }, 
		{{30, 30, 100, }, {100, 100, 100, }, }, 
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
