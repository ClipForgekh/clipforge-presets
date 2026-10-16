local data = {}

local ae_compDurations = {0, 1.93333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRadialBlur_154-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_178-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['seqTex_1_1'] = {{0, 3}, },
            ['seqTex_9_16'] = {{0, 3}, },
            ['seqTex_16_9'] = {{0, 2}, },
        },
    },
    ['LumiLayer_178-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_154-trs-matte'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_191-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.03333333333333, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRadialBlur_154-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 20,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiAnimSeqLoadAndCrop_178-effect0'] = {
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
        ['playMode_9_16'] = 0,
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
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1090, 1090),
    },
    ['LumiLayer_178-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(545, 545, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1090, 1090),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_154-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(543.219620513469, 543.450065234008, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
    },
    ['LumiLayer_191-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRadialBlur_154-effect0#amount#number'] =
{
	{
		{0.531197184, -1.1e-8, 0.320404655, 1.000000006, }, 
		{0.666667, 1, }, 
		{{20, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_178-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_154-trs-matte#position#vector'] =
{
	{
		{0.333333, 0, 0.146711, 1, }, 
		{0.333333, 0.366667, }, 
		{{540, 540, 0, }, {540.07674547, 539.297544688, 0, }, {540.012790911831, 539.882924117148, 0, }, {539.982219886912, 539.635297209038, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.366667, 0.4, }, 
		{{540.07674547, 539.297544688, 0, }, {540.567153495, 537.973484941, 0, }, {540.171271053088, 538.959792166962, 0, }, {540.786719929622, 538.190774388784, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.4, 0.433333, }, 
		{{540.567153495, 537.973484941, 0, }, {538.759346831, 537.993808009, 0, }, {540.347587060378, 537.756195493216, 0, }, {538.368573832667, 537.10165772614, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.433333, 0.466667, }, 
		{{538.759346831, 537.993808009, 0, }, {542.91179157, 543.326386501, 0, }, {539.150119829333, 538.88595829186, 0, }, {542.168412632756, 542.417010296986, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.466667, 0.5, }, 
		{{542.91179157, 543.326386501, 0, }, {543.219620513, 543.450065234, 0, }, {543.655170507244, 544.235762705014, 0, }, {543.666772889175, 544.437587061221, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.5, 0.533333, }, 
		{{543.219620513, 543.450065234, 0, }, {540.228877346, 537.401255502, 0, }, {542.772468136825, 542.462543406779, 0, }, {540.14305790045, 538.438709034219, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.533333, 0.566667, }, 
		{{540.228877346, 537.401255502, 0, }, {543.734537182, 537.225344208, 0, }, {540.31469679155, 536.363801969781, 0, }, {543.023823557046, 537.673038479803, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.566667, 0.6, }, 
		{{543.734537182, 537.225344208, 0, }, {544.493159115, 534.715089784, 0, }, {544.445250806954, 536.777649936197, 0, }, {545.142518281622, 534.818452120755, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.6, 0.633333, }, 
		{{544.493159115, 534.715089784, 0, }, {539.838382049, 536.6051702, 0, }, {543.843799948378, 534.611727447245, 0, }, {540.432363315022, 535.528807828555, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.633333, 0.666667, }, 
		{{539.838382049, 536.6051702, 0, }, {540.929271442, 541.173264278, 0, }, {539.244400782978, 537.681532571445, 0, }, {540.83266541094, 540.483039511269, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 0.7, }, 
		{{540.929271442, 541.173264278, 0, }, {540.418018237, 540.74651873, 0, }, {541.02587747306, 541.863489044731, 0, }, {540.923363223916, 540.566827549413, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.7, 0.733333, }, 
		{{540.418018237, 540.74651873, 0, }, {537.897201566, 542.251411363, 0, }, {539.912673250084, 540.926209910587, 0, }, {538.054339317579, 541.681167229528, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.733333, 0.766667, }, 
		{{537.897201566, 542.251411363, 0, }, {539.475191715, 544.16798351, 0, }, {537.740063814421, 542.821655496472, 0, }, {538.370570543049, 544.047280326885, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.766667, 0.8, }, 
		{{539.475191715, 544.16798351, 0, }, {544.524928824, 542.975630472, 0, }, {540.579812886951, 544.288686693115, 0, }, {544.763882697515, 543.17102074116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.8, 0.833333, }, 
		{{544.524928824, 542.975630472, 0, }, {538.041468477, 542.99564188, 0, }, {544.285974950485, 542.78024020284, 0, }, {539.038771724452, 543.105764352048, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.833333, 0.866667, }, 
		{{538.041468477, 542.99564188, 0, }, {538.541109398, 542.31489563, 0, }, {537.044165229548, 542.885519407952, 0, }, {538.744820192449, 543.321961164592, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.866667, 0.9, }, 
		{{538.541109398, 542.31489563, 0, }, {536.819203741, 536.953248755, 0, }, {538.337398603551, 541.307830095408, 0, }, {536.793057675556, 537.277973459027, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.9, 0.933333, }, 
		{{536.819203741, 536.953248755, 0, }, {538.697985785, 540.366547374, 0, }, {536.845349806444, 536.628524050973, 0, }, {537.960837857716, 539.23451342987, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.933333, 0.966667, }, 
		{{538.697985785, 540.366547374, 0, }, {541.242091358, 543.74545246, 0, }, {539.435133712284, 541.49858131813, 0, }, {541.025088995987, 543.80654368932, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.182967, 1, }, 
		{0.966667, 1.1, }, 
		{{541.242091358, 543.74545246, 0, }, {540, 540, 0, }, {541.459093720013, 543.68436123068, 0, }, {540.207015231252, 540.624242067337, 0, }, }, 
		{6413, }, 
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
