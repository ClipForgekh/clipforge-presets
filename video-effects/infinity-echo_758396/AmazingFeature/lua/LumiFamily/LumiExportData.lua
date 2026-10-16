local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiClone_47-effect0', 'InputTex', 0},
    {'LumiClone_47-effect0', 'mainImage', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiClone_47-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['mainImage'] = {{0, 2}, },
        },
    },
    ['LumiPageTurn_47-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiClone_47-effect0'] = {
        ['type'] = 0,
        ['count'] = 3,
        ['distance'] = 0,
        ['angle'] = 0,
        ['scale'] = 1,
        ['rotation'] = 0,
        ['center'] = Amaz.Vector2f(0, 1),
        ['distribution'] = 0,
        ['initialScale'] = 1,
        ['startAlpha'] = 1,
        ['endAlpha'] = 1,
        ['reverseLayer'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(576, 1024),
    },
    ['LumiPageTurn_47-effect1'] = {
        ['classic_ui'] = 1,
        ['inFoldPosition'] = Amaz.Vector2f(-0.66111111111111, 1.0875),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 1.31,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(576, 1024),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiClone_47-effect0#scale#number'] =
{
	{
		{0.166666667, 0, 0.66666667, 1, }, 
		{0.3, 1.733333, }, 
		{{0.34, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_47-effect1#inFoldPosition#vector'] =
{
	{
		{0.166667, 0, 0.833333, 1, }, 
		{0.066667, 1.933333, }, 
		{{2.06666666666667, -1, }, {-0.66111111111111, 1.0875, }, {2.06666666666667, -1, }, {-0.66111111111111, 1.0875, }, }, 
		{6415, }, 
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
