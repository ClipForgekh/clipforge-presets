local data = {}

local ae_compDurations = {0, 1.5}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiAnimSeqLoadAndCrop_70-effect0'] = {
        ['nodeDuration'] = {{0, 1.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.5}, },
            ['seqTex_1_1'] = {{0, 1.5}, },
            ['seqTex_9_16'] = {{0, 1.5}, },
            ['seqTex_16_9'] = {{0, 1.5}, },
            ['seqTex_5.8'] = {{0, 1.5}, },
            ['seqTex_2_1'] = {{0, 1.5}, },
            ['seqTex_3_4'] = {{0, 1.5}, },
            ['seqTex_4_3'] = {{0, 1.5}, },
            ['seqTex_1.85_1'] = {{0, 1.5}, },
            ['seqTex_2.35_1'] = {{0, 1.5}, },
        },
    },
    ['LumiBCC_Prism_29-effect0'] = {
        ['nodeDuration'] = {{0, 1.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.5}, },
        },
    },
    ['LumiLayer_70-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.5}, },
            ['baseTex'] = {{0, 1.5}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiAnimSeqLoadAndCrop_70-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 0,
        ['cropType_1_1'] = 0,
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
        ['cropType_9_16'] = 0,
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
        ['cropType_16_9'] = 0,
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
        ['cropType_5.8'] = 0,
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
        ['cropType_2_1'] = 0,
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
        ['cropType_3_4'] = 0,
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
        ['cropType_4_3'] = 0,
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
        ['cropType_1.85_1'] = 0,
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
        ['cropType_2.35_1'] = 0,
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
    ['LumiBCC_Prism_29-effect0'] = {
        ['globalTransform'] = 1,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 1,
        ['scaleStart'] = 102,
        ['scaleEnd'] = 98,
        ['angleStart'] = 0,
        ['angleEnd'] = 0,
        ['falloff'] = 0,
        ['offsetStart'] = Amaz.Vector2f(0.5, 0.5),
        ['offsetEnd'] = Amaz.Vector2f(0.5, 0.5),
        ['colorStart'] = Amaz.Color(1, 1, 1, 1),
        ['colorMid'] = Amaz.Color(0.60000002384186, 0.60000002384186, 0.60000002384186, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 0, 1),
    },
    ['LumiLayer_70-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(270, 480, 0),
        ['position'] = Amaz.Vector3f(270, 480, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 20,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Add',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiAnimSeqLoadAndCrop_70-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.5, }, 
		{{0, }, {1.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBCC_Prism_29-effect0#globalTransform#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.208333, }, 
		{{1, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.208333, 1.125, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_29-effect0#smoothness#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.943169396, }, 
		{0.208333, 0.5, }, 
		{{1, }, {0.06, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.04748859, 0.833333333, 0.999973407, }, 
		{0.5, 0.625, }, 
		{{0.06, }, {0.542108, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.000026601, 0.833333333, 0.909723774, }, 
		{0.625, 0.75, }, 
		{{0.542108, }, {0.060154, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 1.083556853, 0.833333333, 1.972630216, }, 
		{0.75, 0.875, }, 
		{{0.060154, }, {0.02, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.036921596, 0.833333333, 0.922794119, }, 
		{0.875, 0.916667, }, 
		{{0.02, }, {0.372593, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.216942151, 0.66666667, 1, }, 
		{0.916667, 1.125, }, 
		{{0.372593, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_29-effect0#center#vector'] =
{
	{
		{0.333333, 0, 0.833333, 0.819729, }, 
		{0.208333, 0.5, }, 
		{{0.5, 0.5, }, {0.5, 0.54770832061771, }, {0.5, 0.50612177898486, }, {0.5, 0.53095288475358, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.15318, 0.833333, 0.672439, }, 
		{0.5, 0.75, }, 
		{{0.5, 0.54770832061771, }, {0.5, 0.59583333333333, }, {0.5, 0.57466918627424, }, {0.5, 0.59561919326273, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.084074, 0.833333, 0.936671, }, 
		{0.75, 0.875, }, 
		{{0.5, 0.59583333333333, }, {0.5, 0.50208333333333, }, {0.5, 0.5961805555659, }, {0.5, 0.51805555522442, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.90515, 0.666667, 1, }, 
		{0.875, 1.125, }, 
		{{0.5, 0.50208333333333, }, {0.5, 0.5, }, {0.5, 0.48611111144225, }, {0.5, 0.50034722223257, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_29-effect0#scaleEnd#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.855957933, }, 
		{0.208333, 0.5, }, 
		{{98, }, {115.463737, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.263086685, 0.833333333, 1.208098821, }, 
		{0.5, 0.625, }, 
		{{115.463737, }, {119.561539, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.05950465, 0.833333333, 0.967659694, }, 
		{0.625, 0.75, }, 
		{{119.561539, }, {105.230766, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.052850862, 0.833333333, 1.115497019, }, 
		{0.75, 0.875, }, 
		{{105.230766, }, {114, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.07502373, 0.66666667, 1, }, 
		{0.875, 1.125, }, 
		{{114, }, {87, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_29-effect0#falloff#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.676923077, }, 
		{0.208333, 0.5, }, 
		{{0, }, {13, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.07826087, 0.833333333, 0.963768116, }, 
		{0.5, 0.625, }, 
		{{13, }, {36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.064102564, 0.833333333, 0.769230769, }, 
		{0.625, 0.75, }, 
		{{36, }, {23, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.130434783, 0.833333333, 0.833333333, }, 
		{0.75, 0.875, }, 
		{{23, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_29-effect0#offsetStart#vector'] =
{
	{
		{0.333333, 0, 0.833333, 0.814625, }, 
		{0.208333, 0.5, }, 
		{{0.5, 0.5, }, {0.50593267370185, 0.68010889689167, }, {0.50099867372601, 0.52707654039065, }, {0.50328990066525, 0.62659673690835, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.149105, 0.833333, 0.825882, }, 
		{0.5, 0.75, }, 
		{{0.50593267370185, 0.68010889689167, }, {0.24387461344444, 0.62163349787396, }, {0.50867544302266, 0.73564583063165, }, {0.24142650476252, 0.55525915225349, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.153516, 0.833333, 0.834942, }, 
		{0.75, 0.875, }, 
		{{0.24387461344444, 0.62163349787396, }, {0.36666666666667, 0.70104166666667, }, {0.2453433507023, 0.66145463784537, }, {0.36666666666667, 0.70104166666667, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.167482, 0.666667, 1, }, 
		{0.875, 1.125, }, 
		{{0.36666666666667, 0.70104166666667, }, {0.5, 0.5, }, {0.36666666666667, 0.70104166666667, }, {0.47777777777778, 0.53350694576899, }, }, 
		{6415, }, 
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
