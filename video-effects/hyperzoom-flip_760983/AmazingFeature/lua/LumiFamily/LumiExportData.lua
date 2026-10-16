local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRadialBlur_27-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_27-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSShake_27-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRadialBlur_27-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 45.6268221574344,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiMotionBlur3D_27-effect1'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
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
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiSShake_27-effect2'] = {
        ['ampRatio'] = 0,
        ['frqRatio'] = 8,
        ['phase0'] = 0,
        ['scale0'] = 1,
        ['blurEnabled'] = false,
        ['blurIntensity'] = 1,
        ['blurQuality'] = 0,
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
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRadialBlur_27-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.466667, }, 
		{{39.795918, }, {60.204082, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 0.8, }, 
		{{60.204082, }, {41.836735, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 1.1, }, 
		{{41.836735, }, {68.367347, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.1, 1.366667, }, 
		{{68.367347, }, {52.040816, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.366667, 1.5, }, 
		{{52.040816, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect1#ae_pre_direction_y#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.03333333333333, 0.50000033333333, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.50000033333333, 0.83333333333333, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.83333333333333, 1.13333333333333, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.13333333333333, 1.33333333333333, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect1#direction_y#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0, 0.466667, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.466667, 0.8, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.8, 1.1, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{1.1, 1.3, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiSShake_27-effect2#ampRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.266667, 1.433333, }, 
		{{0, }, {0.4, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.533333, }, 
		{{0.4, }, {0, }, }, 
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
