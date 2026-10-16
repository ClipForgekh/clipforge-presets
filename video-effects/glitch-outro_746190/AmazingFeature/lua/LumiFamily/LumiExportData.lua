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
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGlitchSignal_146-effect0'] = {
        ['lowQuality'] = 0.8,
        ['filterIntensity'] = 1.2,
        ['sharpen'] = 0,
        ['sharpenSize'] = 5,
        ['chromaNoise'] = 0.00507026799663,
        ['hueNoise'] = 0,
        ['chromaloss'] = 0,
        ['moireNoise'] = 0,
        ['moireSize'] = 0.5,
        ['moireSpeed'] = 0,
        ['randomSeed'] = 0,
        ['destruction'] = false,
        ['signalStrength'] = 1,
        ['d2dIntensity'] = 0,
    },
    ['LumiOpticsCompensation_146-effect1'] = {
        ['fov'] = 0,
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
		{1.04, 1.16, }, 
		{{0, }, {0.21, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.16, 1.24, }, 
		{{0.21, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#chromaNoise#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.44, 0.6, }, 
		{{1, }, {0.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.167609744, 0.07449322, 0.634878439, 0.928521198, }, 
		{0.6, 0.92, }, 
		{{0.1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.346631936, -0.002544718, 0.68175591, 0, }, 
		{0.92, 1.04, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.68175591, 0, }, 
		{1.04, 1.24, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{1.24, 1.36, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#chromaloss#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.44, 0.6, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.600178695, -0.167161977, }, 
		{0.6, 0.92, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.352301662, 0.081228534, 0.695959534, 1, }, 
		{0.92, 1.04, }, 
		{{0, }, {0.68, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.695959534, 1, }, 
		{1.04, 1.24, }, 
		{{0.68, }, {0.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{1.24, 1.36, }, 
		{{0.3, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#moireSpeed#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.16, 0.44, }, 
		{{0.3, }, {1.61, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.44, 0.6, }, 
		{{1.61, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.167609744, 0, 0.634878439, 0, }, 
		{0.6, 0.92, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.346631936, 0, 0.68175591, 0, }, 
		{0.92, 1.04, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.68175591, 0, }, 
		{1.04, 1.24, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{1.24, 1.36, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#randomSeed#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.16, 0.44, }, 
		{{18, }, {88, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.44, 0.6, }, 
		{{88, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.167609744, 0, 0.634878439, 0, }, 
		{0.6, 0.92, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.346631936, 0, 0.68175591, 0, }, 
		{0.92, 1.04, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.68175591, 0, }, 
		{1.04, 1.24, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{1.24, 1.36, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#signalStrength#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.92, 1.04, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.04, 1.24, }, 
		{{1, }, {0.35, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{1.24, 1.36, }, 
		{{0.35, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlitchSignal_146-effect0#d2dIntensity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.44, 0.6, }, 
		{{10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.167609744, 0.03724661, 0.634878439, -0.035739401, }, 
		{0.6, 0.92, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.346631936, 0.010602991, 0.68175591, 1, }, 
		{0.92, 1.04, }, 
		{{0, }, {1.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.68175591, 0, }, 
		{1.04, 1.24, }, 
		{{1.2, }, {1.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{1.24, 1.36, }, 
		{{1.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiOpticsCompensation_146-effect1#fov#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0, 0.16, }, 
		{{180, }, {0, }, }, 
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
