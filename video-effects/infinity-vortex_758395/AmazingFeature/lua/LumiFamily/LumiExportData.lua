local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiClone_27-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['mainImage'] = {{0, 3}, },
        },
    },
    ['LumiChromaticAberration_27-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_27-blend'] = {
        ['nodeDuration'] = {{0, 3.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiClone_27-effect0'] = {
        ['type'] = 0,
        ['count'] = 18.9,
        ['distance'] = 0,
        ['angle'] = 0,
        ['scale'] = 2.69,
        ['rotation'] = 18.7323841828866,
        ['center'] = Amaz.Vector2f(0, 1),
        ['distribution'] = 0,
        ['initialScale'] = 0.92558367927346,
        ['startAlpha'] = 0.9144639991649,
        ['endAlpha'] = 0,
        ['reverseLayer'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 720),
    },
    ['LumiChromaticAberration_27-effect1'] = {
        ['offsetX'] = 0.07910156270655,
        ['offsetY'] = 0.07910156270655,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 720),
    },
    ['LumiLayer_27-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiClone_27-effect0#rotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.133333, 1.8, }, 
		{{219, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiClone_27-effect0#initialScale#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.133333, 1.8, }, 
		{{0.13, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiClone_27-effect0#startAlpha#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.133333, 1.8, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiClone_27-effect0#endAlpha#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.133333, 1.8, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiChromaticAberration_27-effect1#offsetX#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.133333, 1, }, 
		{{0, }, {0.25, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.8, }, 
		{{0.25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiChromaticAberration_27-effect1#offsetY#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.133333, 1, }, 
		{{0, }, {0.25, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.8, }, 
		{{0.25, }, {0, }, }, 
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
