local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiGlitchSignal_146-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiOpticsCompensation_146-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiOpticsCompensation_146-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGlitchSignal_146-effect0'] = {
        ['lowQuality'] = 0.8,
        ['filterIntensity'] = 1.2,
        ['sharpen'] = 0,
        ['sharpenSize'] = 5,
        ['chromaNoise'] = 1,
        ['hueNoise'] = 0,
        ['chromaloss'] = 0,
        ['moireNoise'] = 0,
        ['moireSize'] = 0.5,
        ['moireSpeed'] = 0.3,
        ['randomSeed'] = 18,
        ['destruction'] = false,
        ['signalStrength'] = 1,
        ['d2dIntensity'] = 10,
    },
    ['LumiOpticsCompensation_146-effect1'] = {
        ['fov'] = 0,
        ['inverseLensDistortion'] = false,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
    },
    ['LumiOpticsCompensation_146-effect2'] = {
        ['fov'] = 180,
        ['inverseLensDistortion'] = false,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiGlitchSignal_146-effect0#sharpen#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 0.92, }, 
		{{0, }, {0.21, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.92, 1, }, 
		{{0.21, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#chromaNoise#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.64, 0.8, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{0.8, 1, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0.001223545, }, 
		{1, 1.12, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.346631936, -0.076341534, 0.833333333, 1, }, 
		{1.12, 1.48, }, 
		{{0, }, {0.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.167609744, -0.003103884, 0.833333333, 0.833333333, }, 
		{1.48, 1.6, }, 
		{{0.1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#chromaloss#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 1, }, 
		{0.64, 0.8, }, 
		{{0, }, {0.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.8, 1, }, 
		{{0.3, }, {0.68, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1.038427548, }, 
		{1, 1.12, }, 
		{{0.68, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.352301662, 0.165706209, 0.833333333, 0, }, 
		{1.12, 1.48, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.48, 1.6, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#moireSpeed#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.64, 0.8, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{0.8, 1, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{1, 1.12, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.346631936, 0, 0.833333333, 0, }, 
		{1.12, 1.48, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.167609744, 0, 0.833333333, 0.833333333, }, 
		{1.48, 1.6, }, 
		{{0, }, {1.61, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.6, 1.8, }, 
		{{1.61, }, {0.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#randomSeed#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.64, 0.8, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{0.8, 1, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{1, 1.12, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.346631936, 0, 0.833333333, 0, }, 
		{1.12, 1.48, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.167609744, 0, 0.833333333, 0.833333333, }, 
		{1.48, 1.6, }, 
		{{0, }, {88, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.6, 1.8, }, 
		{{88, }, {18, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#signalStrength#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 1, }, 
		{0.64, 0.8, }, 
		{{1, }, {0.35, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.8, 1, }, 
		{{0.35, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{1, 1.12, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#d2dIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 1, }, 
		{0.64, 0.8, }, 
		{{0, }, {1.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{0.8, 1, }, 
		{{1.2, }, {1.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1.005098103, }, 
		{1, 1.12, }, 
		{{1.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.346631936, 0.038170767, 0.833333333, 0, }, 
		{1.12, 1.48, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.167609744, 0.001396748, 0.833333333, 0.833333333, }, 
		{1.48, 1.6, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiOpticsCompensation_146-effect2#fov#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 1, }, 
		{1.8, 1.96, }, 
		{{0, }, {180, }, }, 
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
