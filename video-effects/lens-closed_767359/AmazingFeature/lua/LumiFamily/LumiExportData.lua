local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiTone_54-effect0', 'InputTex', 0},
    {'LumiRoundCorner_139-effect0', 'InputTex', 0},
    {'LumiTone_133-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiTone_54-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLinearWipe_54-effect1'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_54-effect2'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_139-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiCCLens_139-effect1'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_139-trs'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_54-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiTone_133-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLinearWipe_133-effect1'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_133-effect2'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_133-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiBCC_Prism_45-effect0'] = {
        ['nodeDuration'] = {{0, 2.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiChromaticAberration_45-effect1'] = {
        ['nodeDuration'] = {{0, 2.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.6}, },
        },
    },
    ['LumiLayer_45-blend'] = {
        ['nodeDuration'] = {{0, 2.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.6}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiTone_54-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.22408963952746, 0.22408963952746, 0.22408963952746, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLinearWipe_54-effect1'] = {
        ['progress'] = 0.499,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_54-effect2'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_139-effect0'] = {
        ['radius'] = 256,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiCCLens_139-effect1'] = {
        ['convergence'] = -41.4000015258789,
        ['radius'] = 115.300003051758,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_139-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 2471.39568967631),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_54-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(1920, 540, 0),
        ['position'] = Amaz.Vector3f(50, 50, -1043.06188964844),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(1920, 540, 1043.06188964844),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTone_133-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.22408963952746, 0.22408963952746, 0.22408963952746, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLinearWipe_133-effect1'] = {
        ['progress'] = 0.499,
        ['rotation'] = 270,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_133-effect2'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_133-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 540, 0),
        ['position'] = Amaz.Vector3f(50, 50, -1043.06188964844),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(0, 540, 1043.06188964844),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_45-effect0'] = {
        ['globalTransform'] = 100,
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
        ['colorStart'] = Amaz.Color(1, 0, 0, 1),
        ['colorMid'] = Amaz.Color(0, 1, 0, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 1, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiChromaticAberration_45-effect1'] = {
        ['offsetX'] = 0.05000000074506,
        ['offsetY'] = 0.05000000074506,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_45-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiTone_54-effect0#whiteColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.666667, }, 
		{{0.392157, 0.392157, 0.392157, 1, }, {0, 0, 0, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiRoundCorner_139-effect0#radius#number'] =
{
	{
		{0.83, 0, 0.89, 1, }, 
		{0, 0.6, }, 
		{{0, }, {256, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCCLens_139-effect1#convergence#number'] =
{
	{
		{0.82, 0, 0.89, 1, }, 
		{0, 0.6, }, 
		{{0, }, {-41.400002, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCCLens_139-effect1#radius#number'] =
{
	{
		{0.82, 0, 0.89, 1, }, 
		{0, 0.6, }, 
		{{500, }, {115.300003, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_139-trs#position#vector'] =
{
	{
		{0.78, 0, 0.22, 1, }, 
		{0, 1.333333, }, 
		{{960, 540, 0, }, {960, 540, 2475, }, {960, 540, 0, }, {960, 540, 2475, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs-blend#position#vector'] =
{
	{
		{0.135409, 0.438888, 0.149214, 1, }, 
		{0.6, 1.266667, }, 
		{{50, 50, 0.000015975, }, {50, 50, -1043.061889648, }, {50, 50, 0.000015975, }, {50, 50, -1043.061889648, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs-blend#yRotation#number'] =
{
	{
		{0.78, 0, 0.22, 1, }, 
		{0.333333, 1, }, 
		{{-120, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs-blend#p0_position#vector'] =
{
	{
		{0.78, 0, 0.22, 1, }, 
		{0.133333, 0.866667, }, 
		{{2396, 540, 1043.061889648, }, {1920, 540, 1043.061889648, }, {2396, 540, 1043.061889648, }, {1920, 540, 1043.061889648, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiTone_133-effect0#whiteColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.666667, }, 
		{{0.392157, 0.392157, 0.392157, 1, }, {0, 0, 0, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_133-trs-blend#position#vector'] =
{
	{
		{0.135409, 0.438888, 0.149214, 1, }, 
		{0.6, 1.266667, }, 
		{{50, 50, 0.000015975, }, {50, 50, -1043.061889648, }, {50, 50, 0.000015975, }, {50, 50, -1043.061889648, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_133-trs-blend#yRotation#number'] =
{
	{
		{0.78, 0, 0.22, 1, }, 
		{0.333333, 1, }, 
		{{120, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_133-trs-blend#p0_position#vector'] =
{
	{
		{0.78, 0, 0.22, 1, }, 
		{0.133333, 0.866667, }, 
		{{-516, 540, 1043.061889648, }, {0, 540, 1043.061889648, }, {-516, 540, 1043.061889648, }, {0, 540, 1043.061889648, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_45-effect0#globalTransform#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBCC_Prism_45-effect0#weight#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.5, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_45-effect1#offsetX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.5, }, 
		{{0, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_45-effect1#offsetY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.5, }, 
		{{0, }, {0.05, }, }, 
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
