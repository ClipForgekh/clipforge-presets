local data = {}

local ae_compDurations = {0, 1.6}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiVAT_55-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['model'] = {{0, 30}, },
            ['posTex'] = {{0, 3}, },
            ['normTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiVAT_55-effect0'] = {
        ['reverseAnim'] = false,
        ['speed'] = 1.5,
        ['duration'] = 3.6,
        ['frameCount'] = 49,
        ['startFrame'] = 0,
        ['endFrame'] = 49,
        ['boundMinX'] = -8.7,
        ['boundMinY'] = -10,
        ['boundMinZ'] = -2.2,
        ['boundMaxX'] = 2.3,
        ['boundMaxY'] = 0,
        ['boundMaxZ'] = 1.3,
        ['camType'] = 0,
        ['camOrthoScale'] = 1,
        ['camFOV'] = 90,
        ['positionX'] = -0.008,
        ['positionY'] = -0.999,
        ['positionZ'] = -1,
        ['rotationX'] = -90,
        ['rotationZ'] = 180,
        ['rotationY'] = 0,
        ['meshIndex'] = 10,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiVAT_55-effect0#positionX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.533333, }, 
		{{-0.008, }, {2, }, }, 
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
