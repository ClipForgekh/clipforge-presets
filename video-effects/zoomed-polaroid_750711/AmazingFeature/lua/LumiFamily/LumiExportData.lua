local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_187-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSShake_187-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiFlicker_187-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_187-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 2,
        ['ae_pre_scale_x'] = 2,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiSShake_187-effect1'] = {
        ['ampRatio'] = 0.41947813501209,
        ['frqRatio'] = 6,
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
    },
    ['LumiFlicker_187-effect2'] = {
        ['amp0'] = 0.83895627002418,
        ['ampRL'] = 1,
        ['ampRC'] = 0,
        ['frqR'] = 32,
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
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_187-effect0#ae_pre_scale_x#number'] =
{
	{
		{1, -1.5e-8, 0.66666667, 1, }, 
		{0.03333333333333, 0.53333333333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{1, 6.98e-7, 0.66666667, 1, }, 
		{0.53333333333333, 1.53333333333333, }, 
		{{2, }, {2.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{1, -5.4e-8, 0.66666667, 1, }, 
		{1.53333333333333, 2.00000033333333, }, 
		{{2.2, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_187-effect0#scale_x#number'] =
{
	{
		{1, -1.5e-8, 0.66666667, 1, }, 
		{0, 0.5, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{1, 6.98e-7, 0.66666667, 1, }, 
		{0.5, 1.5, }, 
		{{2, }, {2.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{1, -5.4e-8, 0.66666667, 1, }, 
		{1.5, 1.966667, }, 
		{{2.2, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_187-effect1#ampRatio#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 1.966667, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiFlicker_187-effect2#amp0#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 1.966667, }, 
		{{1, }, {0, }, }, 
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
