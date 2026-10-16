local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiDust_96-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_96-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiDust_96-effect0'] = {
        ['progress'] = 100,
        ['distorIns'] = 15,
        ['dustNum'] = 0.5,
        ['dustSize'] = 1,
        ['brightness'] = 0,
        ['contrast'] = 0,
        ['quantity'] = 1,
        ['complexity'] = 8,
        ['evolution'] = 0,
        ['cycle'] = 100,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['maskType'] = 1,
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_96-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiDust_96-effect0#progress#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 1.666667, }, 
		{{0, }, {100, }, }, 
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
