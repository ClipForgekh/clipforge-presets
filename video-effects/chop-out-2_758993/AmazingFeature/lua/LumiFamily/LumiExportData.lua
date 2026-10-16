local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_27-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGrain_27-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_27-effect0'] = {
        ['progress'] = 0.97526501766784,
        ['rotation'] = -175,
        ['feather'] = 0.04240282685512,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiGrain_27-effect1'] = {
        ['grainIntensity'] = 0,
        ['intensityR'] = 10,
        ['intensityG'] = 10,
        ['intensityB'] = 10,
        ['scale'] = 0.3,
        ['scaleR'] = 1,
        ['scaleG'] = 1,
        ['scaleB'] = 1,
        ['brightness'] = 0,
        ['contrast'] = 1,
        ['saturation'] = 0.5,
        ['monochrome'] = false,
        ['combine'] = 4,
        ['speed'] = 1,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLinearWipe_27-effect0#progress#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0, 0.3, }, 
		{{0, }, {0.38162544, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.3, 0.5, }, 
		{{0.38162544, }, {0.58303887, }, }, 
		{6417, }, 
		{2, }, 
	}, 
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.5, 0.833333, }, 
		{{0.58303887, }, {0.97526502, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiLinearWipe_27-effect0#rotation#number'] =
{
	{
		{0.166815951, 6.41462938, 0.81086767, 1, }, 
		{-2.4, 0.4, }, 
		{{-178, }, {-175, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGrain_27-effect1#grainIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 0.833333, }, 
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
