local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiFlicker_124-effect0'] = {
        ['nodeDuration'] = {{0, 0.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.4}, },
        },
    },
    ['LumiMotionBlur3D_27-effect0'] = {
        ['nodeDuration'] = {{0.4, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.4, 1}, },
        },
    },
    ['LumiLayer_124-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.4}, },
            ['baseTex'] = {{0.4, 1}, },
        },
    },
    ['LumiSShake_127-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_127-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiFlicker_124-effect0'] = {
        ['amp0'] = 0.3,
        ['ampRL'] = 1,
        ['ampRC'] = 0,
        ['frqR'] = 30.5,
        ['ampW'] = 0,
        ['frqW'] = 5,
        ['phaseWR'] = 0,
        ['phaseWG'] = 0,
        ['phaseWB'] = 0,
        ['ampR'] = 1,
        ['ampG'] = 1,
        ['ampB'] = 1,
        ['brightness'] = 1,
        ['seed'] = 0.12300000339746,
    },
    ['LumiMotionBlur3D_27-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.36,
        ['ae_pre_scale_x'] = 0.36,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 0,
        ['ae_pre_direction_y'] = 0,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiLayer_124-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiSShake_127-effect0'] = {
        ['ampRatio'] = 0,
        ['frqRatio'] = 3,
        ['phase0'] = 0,
        ['scale0'] = 1,
        ['blurEnabled'] = true,
        ['blurIntensity'] = 1,
        ['blurQuality'] = 1,
        ['seed'] = 0,
        ['xFill'] = 2,
        ['yFill'] = 2,
        ['xAmpR'] = 192,
        ['xFrqR'] = 1,
        ['xAmp'] = 0,
        ['xFrq'] = 0.5,
        ['xPhase'] = 0,
        ['yAmpR'] = 192,
        ['yFrqR'] = 1,
        ['yAmp'] = 0,
        ['yFrq'] = 0.5,
        ['yPhase'] = 0,
        ['zAmpR'] = 100,
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
    },
    ['LumiLayer_127-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_27-effect0#ae_pre_rotation_x#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.43333333333333, 1.03333333333333, }, 
		{{0, }, {-48, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#rotation_x#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.4, 1, }, 
		{{0, }, {-48, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#ae_pre_rotation_y#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.43333333333333, 1.03333333333333, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#rotation_y#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.4, 1, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#ae_pre_rotation_z#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.43333333333333, 1.03333333333333, }, 
		{{0, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#rotation_z#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.4, 1, }, 
		{{0, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_127-effect0#ampRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.5, }, 
		{{1, }, {0, }, }, 
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
