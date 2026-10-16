local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_43-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_43-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_61-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_61-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_43-effect0'] = {
        ['progress'] = 0.47895111098276,
        ['rotation'] = 2.34217818536576,
        ['feather'] = 0.25,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_43-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_61-effect0'] = {
        ['progress'] = 0.47070518506753,
        ['rotation'] = -177.657821814634,
        ['feather'] = 0.25,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_61-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLinearWipe_43-effect0#progress#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.333333, 0.833333, }, 
		{{1, }, {0.38, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.833333, 1.333333, }, 
		{{0.38, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.333333, 1.866667, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_43-effect0#rotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.666667, 1.3, }, 
		{{35, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.3, 1.8, }, 
		{{0, }, {-45, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_61-effect0#progress#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.333333, 0.833333, }, 
		{{1, }, {0.38, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.833333, 1.333333, }, 
		{{0.38, }, {0.49, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.333333, 1.866667, }, 
		{{0.49, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_61-effect0#rotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.666667, 1.3, }, 
		{{-145, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.3, 1.8, }, 
		{{-180, }, {-225, }, }, 
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
