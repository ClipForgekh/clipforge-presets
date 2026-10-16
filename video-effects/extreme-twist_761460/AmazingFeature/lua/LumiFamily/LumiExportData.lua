local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiTwister_68-effect0', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiTwister_68-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiCornerPin_68-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiTwister_68-effect0'] = {
        ['completion'] = 1,
        ['lightIns'] = 0.5,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['axis'] = -201,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiCornerPin_68-effect1'] = {
        ['leftUpVertex'] = Amaz.Vector2f(0, 1),
        ['rightUpVertex'] = Amaz.Vector2f(1, 1),
        ['leftDownVertex'] = Amaz.Vector2f(0, 0),
        ['rightDownVertex'] = Amaz.Vector2f(1, 0),
        ['motionTileType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiTwister_68-effect0#completion#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.533333, 0.966667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiCornerPin_68-effect1#rightUpVertex#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0, 0.833333, }, 
		{{0.0390625, -0.359375, }, {1, 1, }, {0.0390625, -0.359375, }, {1, 1, }, }, 
		{6415, }, 
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
