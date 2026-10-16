local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiAnimSeqLoadAndCrop_102-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex_1_1'] = {{0, 2.1}, },
        },
    },
    ['LumiFill_102-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRoughEdge_106-effect0'] = {
        ['nodeDuration'] = {{0, 1.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.46666666666667}, },
        },
    },
    ['LumiLayer_106-trs'] = {
        ['nodeDuration'] = {{0, 1.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.46666666666667}, },
        },
    },
    ['LumiRoughEdge_105-effect0'] = {
        ['nodeDuration'] = {{0, 1.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.46666666666667}, },
        },
    },
    ['LumiLayer_105-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.46666666666667}, },
            ['baseTex'] = {{0, 1.46666666666667}, },
        },
    },
    ['LumiRoughEdge_104-effect0'] = {
        ['nodeDuration'] = {{0, 1.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.46666666666667}, },
        },
    },
    ['LumiLayer_104-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.46666666666667}, },
            ['baseTex'] = {{0, 1.46666666666667}, },
        },
    },
    ['LumiLayer_102-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 1.46666666666667}, },
        },
    },
    ['LumiExtractFrame_101-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_101-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiAnimSeqLoadAndCrop_102-effect0'] = {
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
        ['playMode_16_9'] = 1,
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
        ['AEDesignSize'] = Amaz.Vector2f(784, 1108),
    },
    ['LumiFill_102-effect1'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(784, 1108),
    },
    ['LumiRoughEdge_106-effect0'] = {
        ['edgeSize'] = 47.0000000002115,
        ['edgeSmooth'] = 0.81,
        ['edgeOffset'] = 0.55,
        ['noiseIntensity'] = 0,
        ['noiseSizeX'] = 0.5,
        ['noiseSizeY'] = 0.5,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['complexity'] = 3,
        ['evolution'] = 0,
        ['cycle'] = 100,
        ['AEDesignSize'] = Amaz.Vector2f(784, 1108),
    },
    ['LumiLayer_106-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(391.889166057078, 550.107139941867, 0),
        ['scale'] = Amaz.Vector3f(61.0407790617924, 61.0407790617924, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
    },
    ['LumiRoughEdge_105-effect0'] = {
        ['edgeSize'] = 94,
        ['edgeSmooth'] = 0.81,
        ['edgeOffset'] = 0.55,
        ['noiseIntensity'] = 0,
        ['noiseSizeX'] = 0.5,
        ['noiseSizeY'] = 0.5,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['complexity'] = 3,
        ['evolution'] = 0,
        ['cycle'] = 100,
        ['AEDesignSize'] = Amaz.Vector2f(784, 1108),
    },
    ['LumiLayer_105-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 1334.33540980489, 0),
        ['scale'] = Amaz.Vector3f(38, 38, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoughEdge_104-effect0'] = {
        ['edgeSize'] = 94,
        ['edgeSmooth'] = 0.81,
        ['edgeOffset'] = 0.55,
        ['noiseIntensity'] = 0,
        ['noiseSizeX'] = 0.5,
        ['noiseSizeY'] = 0.5,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['complexity'] = 3,
        ['evolution'] = 0,
        ['cycle'] = 100,
        ['AEDesignSize'] = Amaz.Vector2f(784, 1108),
    },
    ['LumiLayer_104-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 1332.33540980487, 0),
        ['scale'] = Amaz.Vector3f(38, 38, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_102-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
    ['LumiExtractFrame_101-effect0'] = {
        ['fps'] = 15,
        ['AEDesignSize'] = Amaz.Vector2f(784, 1108),
    },
    ['LumiLayer_101-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiAnimSeqLoadAndCrop_102-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRoughEdge_106-effect0#edgeSize#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.2, }, 
		{{0, }, {94, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs#xPosition#number'] =
{
	{
		{0.033333333, 0.164816963, 0.966666667, 0.588506284, }, 
		{0.033333, 0.333333, }, 
		{{392, }, {391.470569, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.033333333, -0.374466733, 0.966666667, 1.149986421, }, 
		{0.333333, 0.633333, }, 
		{{391.470569, }, {392, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs#yPosition#number'] =
{
	{
		{0.033333333, 0, 0.390447262, 0.268852563, }, 
		{0.033333, 0.333333, }, 
		{{554, }, {531, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.55566968, 0.048512218, 0.711178311, 0.90919263, }, 
		{0.333333, 0.633333, }, 
		{{531, }, {215, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs#scale#vector'] =
{
	{
		{0.023076923,0.023076923,0.33333333, 0.687882741,0.687882741,0.33333333, 0.288804595,0.288804595,0.66666667, 0.945414029,0.945414029,0.66666667, }, 
		{0.033333, 0.466667, }, 
		{{100, 100, 100, }, {38, 38, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs-blend#xPosition#number'] =
{
	{
		{0.015, 0, 0.66666667, 0, }, 
		{0.333333, 1, }, 
		{{392, }, {392, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs-blend#yPosition#number'] =
{
	{
		{0.461299821, 0.406419492, 0.28463231, 0.781075804, }, 
		{0.333333, 1, }, 
		{{1334.33541, }, {566.33541, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#xPosition#number'] =
{
	{
		{0.025, 0, 0.975, 0, }, 
		{0.666667, 1.066667, }, 
		{{392, }, {392, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#yPosition#number'] =
{
	{
		{0.749207163, 0.576488089, 0.325147545, 0.841089512, }, 
		{0.666667, 1.066667, }, 
		{{1332.33541, }, {898.33541, }, }, 
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
