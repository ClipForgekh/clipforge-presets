local data = {}

local ae_compDurations = {0, 0.8}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_3904-trs', 'InputTex', 0},
    {'LumiLayer_3902-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_3904-trs'] = {
        ['nodeDuration'] = {{0, 0.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.8}, },
        },
    },
    ['LumiLayer_3902-trs'] = {
        ['nodeDuration'] = {{0, 0.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.8}, },
        },
    },
    ['LumiLayer_3903-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.8}, },
            ['baseTex'] = {{0, 0.8}, },
            ['maskTex'] = {{0, 0.8}, },
        },
    },
    ['LumiDirectionalBlurs_3901-effect0'] = {
        ['nodeDuration'] = {{0, 0.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.8}, },
        },
    },
    ['LumiLayer_3901-blend'] = {
        ['nodeDuration'] = {{0, 0.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.8}, },
            ['baseTex'] = {{0, 0.8}, },
        },
    },
    ['LumiMeshWarp_2702-effect0'] = {
        ['nodeDuration'] = {{0, 0.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.8}, },
        },
    },
    ['LumiLinearWipe_2701-effect0'] = {
        ['nodeDuration'] = {{0, 0.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.8}, },
        },
    },
    ['LumiLayer_2701-blend'] = {
        ['nodeDuration'] = {{0, 0.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.8}, },
            ['baseTex'] = {{0, 0.8}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_3904-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 0, 0),
        ['position'] = Amaz.Vector3f(540, 463.752030347779, 0),
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
    },
    ['LumiLayer_3902-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 0, 0),
        ['position'] = Amaz.Vector3f(540, 463.752030347779, 0),
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
    },
    ['LumiLayer_3903-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 1080, 0),
        ['position'] = Amaz.Vector3f(540, 1080, 0),
        ['scale'] = Amaz.Vector3f(100, 94.4712280974949, 100),
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
        ['blendMode'] = 2,
    },
    ['LumiDirectionalBlurs_3901-effect0'] = {
        ['blurIntensity'] = 84.6540570076641,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.3538344935367,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
    },
    ['LumiLayer_3901-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiMeshWarp_2702-effect0'] = {
        ['meshMode'] = 0,
        ['transpose'] = false,
        ['point1'] = Amaz.Vector2f(0.83333333333333, 0),
        ['point2'] = Amaz.Vector2f(0.74074074074074, 0),
        ['point3'] = Amaz.Vector2f(0.82407407407407, 0.33333333333333),
        ['point4'] = Amaz.Vector2f(0, 1),
        ['point5'] = Amaz.Vector2f(0, 0.66600006103516),
        ['point6'] = Amaz.Vector2f(0.33299987792969, 1),
        ['point7'] = Amaz.Vector2f(0.83333333333333, 0),
        ['point8'] = Amaz.Vector2f(0.84259259259259, 0.33300003051758),
        ['point9'] = Amaz.Vector2f(0.92592592592593, 0),
        ['point10'] = Amaz.Vector2f(1, 1),
        ['point11'] = Amaz.Vector2f(1, 0.66600006103516),
        ['point12'] = Amaz.Vector2f(0.66599990844727, 1),
        ['point13'] = Amaz.Vector2f(0.5, 0.5),
        ['point14'] = Amaz.Vector2f(0.5, 0.5),
        ['point15'] = Amaz.Vector2f(0.5, 0.5),
        ['point16'] = Amaz.Vector2f(0.5, 0.5),
        ['point17'] = Amaz.Vector2f(0.5, 0.5),
        ['point18'] = Amaz.Vector2f(0.5, 0.5),
        ['point19'] = Amaz.Vector2f(0.5, 0.5),
        ['point20'] = Amaz.Vector2f(0.5, 0.5),
        ['point21'] = Amaz.Vector2f(0.5, 0.5),
        ['point22'] = Amaz.Vector2f(0.5, 0.5),
        ['point23'] = Amaz.Vector2f(0.5, 0.5),
        ['point24'] = Amaz.Vector2f(0.5, 0.5),
        ['point25'] = Amaz.Vector2f(0.5, 0.5),
        ['point26'] = Amaz.Vector2f(0.5, 0.5),
        ['point27'] = Amaz.Vector2f(0.5, 0.5),
        ['point28'] = Amaz.Vector2f(0.5, 0.5),
        ['point29'] = Amaz.Vector2f(0.5, 0.5),
        ['point30'] = Amaz.Vector2f(0.5, 0.5),
        ['point31'] = Amaz.Vector2f(0.5, 0.5),
        ['point32'] = Amaz.Vector2f(0.5, 0.5),
        ['point33'] = Amaz.Vector2f(0.5, 0.5),
        ['point34'] = Amaz.Vector2f(0.5, 0.5),
        ['point35'] = Amaz.Vector2f(0.5, 0.5),
        ['point36'] = Amaz.Vector2f(0.5, 0.5),
        ['point37'] = Amaz.Vector2f(0.5, 0.5),
        ['point38'] = Amaz.Vector2f(0.5, 0.5),
        ['point39'] = Amaz.Vector2f(0.5, 0.5),
        ['point40'] = Amaz.Vector2f(0.5, 0.5),
        ['point41'] = Amaz.Vector2f(0.5, 0.5),
        ['point42'] = Amaz.Vector2f(0.5, 0.5),
        ['point43'] = Amaz.Vector2f(0.5, 0.5),
        ['point44'] = Amaz.Vector2f(0.5, 0.5),
        ['point45'] = Amaz.Vector2f(0.5, 0.5),
        ['point46'] = Amaz.Vector2f(0.5, 0.5),
        ['point47'] = Amaz.Vector2f(0.5, 0.5),
        ['point48'] = Amaz.Vector2f(0.5, 0.5),
        ['point49'] = Amaz.Vector2f(0.5, 0.5),
        ['point50'] = Amaz.Vector2f(0.5, 0.5),
        ['point51'] = Amaz.Vector2f(0.5, 0.5),
        ['point52'] = Amaz.Vector2f(0.5, 0.5),
        ['point53'] = Amaz.Vector2f(0.5, 0.5),
        ['point54'] = Amaz.Vector2f(0.5, 0.5),
        ['point55'] = Amaz.Vector2f(0.5, 0.5),
        ['point56'] = Amaz.Vector2f(0.5, 0.5),
        ['point57'] = Amaz.Vector2f(0.5, 0.5),
        ['point58'] = Amaz.Vector2f(0.5, 0.5),
        ['point59'] = Amaz.Vector2f(0.5, 0.5),
        ['point60'] = Amaz.Vector2f(0.5, 0.5),
        ['point61'] = Amaz.Vector2f(0.5, 0.5),
        ['point62'] = Amaz.Vector2f(0.5, 0.5),
        ['point63'] = Amaz.Vector2f(0.5, 0.5),
        ['point64'] = Amaz.Vector2f(0.5, 0.5),
        ['point65'] = Amaz.Vector2f(0.5, 0.5),
        ['point66'] = Amaz.Vector2f(0.5, 0.5),
        ['point67'] = Amaz.Vector2f(0.5, 0.5),
        ['point68'] = Amaz.Vector2f(0.5, 0.5),
        ['point69'] = Amaz.Vector2f(0.5, 0.5),
        ['point70'] = Amaz.Vector2f(0.5, 0.5),
        ['point71'] = Amaz.Vector2f(0.5, 0.5),
        ['point72'] = Amaz.Vector2f(0.5, 0.5),
        ['point73'] = Amaz.Vector2f(0.5, 0.5),
        ['point74'] = Amaz.Vector2f(0.5, 0.5),
        ['point75'] = Amaz.Vector2f(0.5, 0.5),
        ['point76'] = Amaz.Vector2f(0.5, 0.5),
        ['point77'] = Amaz.Vector2f(0.5, 0.5),
        ['point78'] = Amaz.Vector2f(0.5, 0.5),
        ['point79'] = Amaz.Vector2f(0.5, 0.5),
        ['point80'] = Amaz.Vector2f(0.5, 0.5),
        ['point81'] = Amaz.Vector2f(0.5, 0.5),
        ['point82'] = Amaz.Vector2f(0.5, 0.5),
        ['point83'] = Amaz.Vector2f(0.5, 0.5),
        ['point84'] = Amaz.Vector2f(0.5, 0.5),
        ['point85'] = Amaz.Vector2f(0.5, 0.5),
        ['point86'] = Amaz.Vector2f(0.5, 0.5),
        ['point87'] = Amaz.Vector2f(0.5, 0.5),
        ['point88'] = Amaz.Vector2f(0.5, 0.5),
        ['point89'] = Amaz.Vector2f(0.5, 0.5),
        ['point90'] = Amaz.Vector2f(0.5, 0.5),
    },
    ['LumiLinearWipe_2701-effect0'] = {
        ['progress'] = 0.53908243534553,
        ['rotation'] = 180,
        ['feather'] = 0.2,
    },
    ['LumiLayer_2701-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_3904-trs#position#vector'] =
{
	{
		{0.5, 0, 0.67, 0.933333, }, 
		{0.266667, 0.766667, }, 
		{{540, 0, 0, }, {540, 1090, 0, }, {540, 0, 0, }, {540, 1090, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_3904-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.733333, 0.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_3902-trs#position#vector'] =
{
	{
		{0.5, 0, 0.67, 0.933333, }, 
		{0.266667, 0.766667, }, 
		{{540, 0, 0, }, {540, 1090, 0, }, {540, 0, 0, }, {540, 1090, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_3902-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.733333, 0.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_3903-trs-matte-blend#scale#vector'] =
{
	{
		{0.31,0.31,0.31, 0.31,0,0.31, 0.37,0.37,0.37, 0.37,0.911111111,0.37, }, 
		{0.5, 0.766667, }, 
		{{100, 100, 100, }, {100, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_3903-trs-matte-blend#opacity#number'] =
{
	{
		{0.6, 0.133333333, 0.56, 0.911111111, }, 
		{0.1, 0.433333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_3901-effect0#blurIntensity#number'] =
{
	{
		{0.42, 0, 0.855814563, 0.785433606, }, 
		{0.266667, 0.433333, }, 
		{{0, }, {60, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.14810687, 0.678986047, 0.60655313, 0.909630663, }, 
		{0.433333, 0.766667, }, 
		{{60, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMeshWarp_2702-effect0#point1#vector'] =
{
	{
		{0.44, 0, 0.44, 1, }, 
		{0, 0.4, }, 
		{{0, 0, }, {0.83333333333333, 0, }, {0, 0, }, {0.83333333333333, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMeshWarp_2702-effect0#point2#vector'] =
{
	{
		{0.44, 0, 0.44, 1, }, 
		{0, 0.4, }, 
		{{0.33299987792963, 0, }, {0.74074074074074, 0, }, {0.33299987792963, 0, }, {0.74074074074074, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMeshWarp_2702-effect0#point3#vector'] =
{
	{
		{0.44, 0, 0.44, 1, }, 
		{0, 0.4, }, 
		{{0, 0.33300003051759, }, {0.82407407407407, 0.33333333333333, }, {0, 0.33300003051759, }, {0.82407407407407, 0.33333333333333, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMeshWarp_2702-effect0#point5#vector'] =
{
	{
		{0.44, 0.44, 0.44, 0.44, }, 
		{0, 0.4, }, 
		{{0, 0.66600006103519, }, {0, 0.66600006103519, }, {0, 0.66600006103519, }, {0, 0.66600006103519, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMeshWarp_2702-effect0#point7#vector'] =
{
	{
		{0.44, 0, 0.44, 1, }, 
		{0, 0.4, }, 
		{{1, 0, }, {0.83333333333333, 0, }, {1, 0, }, {0.83333333333333, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMeshWarp_2702-effect0#point8#vector'] =
{
	{
		{0.44, 0, 0.44, 1, }, 
		{0, 0.4, }, 
		{{1, 0.33300003051759, }, {0.84259259259259, 0.33300003051759, }, {1, 0.33300003051759, }, {0.84259259259259, 0.33300003051759, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMeshWarp_2702-effect0#point9#vector'] =
{
	{
		{0.44, 0, 0.44, 1, }, 
		{0, 0.4, }, 
		{{0.66599990844722, 0, }, {0.92592592592593, 0, }, {0.66599990844722, 0, }, {0.92592592592593, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMeshWarp_2702-effect0#point11#vector'] =
{
	{
		{0.44, 0.44, 0.44, 0.44, }, 
		{0, 0.4, }, 
		{{1, 0.66600006103519, }, {1, 0.66600006103519, }, {1, 0.66600006103519, }, {1, 0.66600006103519, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_2701-effect0#progress#number'] =
{
	{
		{0.116972972, 0, 0.28360978, 0.795568489, }, 
		{0.266667, 0.666667, }, 
		{{0, }, {0.64, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_2701-effect0#feather#number'] =
{
	{
		{0.278984878, 0, 0.66666667, 1, }, 
		{0.266667, 0.5, }, 
		{{0, }, {0.2, }, }, 
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
