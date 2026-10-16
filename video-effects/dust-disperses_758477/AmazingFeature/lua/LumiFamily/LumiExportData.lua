local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiDust_2392-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiDust_2392-effect0'] = {
        ['progress'] = 0,
        ['distorIns'] = 2.40000009536743,
        ['dustNum'] = 0.69999998807907,
        ['dustSize'] = 1,
        ['brightness'] = 0,
        ['contrast'] = 0,
        ['quantity'] = 1,
        ['complexity'] = 8,
        ['evolution'] = 0,
        ['cycle'] = 100,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['maskType'] = 0,
        ['mask_noise_brightness'] = 0,
        ['mask_noise_contrast'] = 0.18000000715256,
        ['mask_noise_quantity'] = 1,
        ['mask_noise_complexity'] = 8,
        ['mask_noise_evolution'] = 0,
        ['mask_noise_cycle'] = 100,
        ['mask_noise_offset_x'] = 0,
        ['mask_noise_offset_y'] = 0,
        ['mask_line_rot'] = 0,
        ['maskFeather'] = 1,
        ['startRotX'] = 0,
        ['startRotY'] = 0,
        ['startRotZ'] = 0,
        ['startMoveX'] = 0,
        ['startMoveY'] = 0,
        ['startMoveZ'] = 0,
        ['startSize'] = 1,
        ['endRotX'] = 0,
        ['endRotY'] = 0,
        ['endRotZ'] = 0,
        ['endMoveX'] = 0,
        ['endMoveY'] = 0,
        ['endMoveZ'] = 0,
        ['endSize'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(784, 1108),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiDust_2392-effect0#progress#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 1.96, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDust_2392-effect0#mask_line_rot#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 1.28, }, 
		{{0, }, {42, }, }, 
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
