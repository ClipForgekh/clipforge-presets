local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLinearWipe_27-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_27-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_27-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiSoftGlow_27-effect2'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_27-effect0'] = {
        ['progress'] = 0.12934900415181,
        ['rotation'] = 130,
        ['feather'] = 0.04,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_27-effect1'] = {
        ['progress'] = 0.74608573687812,
        ['rotation'] = -50,
        ['feather'] = 0.04,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiSoftGlow_27-effect2'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0.5,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 1,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLinearWipe_27-effect0#progress#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0, 0.866667, }, 
		{{0, }, {0.85, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.866667, 1.3, }, 
		{{0.85, }, {0.44, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{1.3, 1.4, }, 
		{{0.44, }, {0.44, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.4, 1.666667, }, 
		{{0.44, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_27-effect1#progress#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0, 0.866667, }, 
		{{0.88, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.66666667, 1, }, 
		{0.866667, 1.3, }, 
		{{0, }, {0.44, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{1.3, 1.4, }, 
		{{0.44, }, {0.44, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.4, 1.666667, }, 
		{{0.44, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_27-effect2#exposure#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{1.466667, 1.666667, }, 
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
