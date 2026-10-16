local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiDust_46-effect0', 'InputTex', 0},
    {'LumiDust_46-effect0', 'mask_image', 0},
    {'LumiDust_46-effect0', 'endImg', 0},
    {'LumiLayer_46-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiDust_46-effect0'] = {
        ['nodeDuration'] = {{0, 2.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['mask_image'] = {{0, 2}, },
            ['endImg'] = {{0, 2}, },
        },
    },
    ['LumiLayer_46-blend'] = {
        ['nodeDuration'] = {{0, 2.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.06666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiDust_46-effect0'] = {
        ['progress'] = 100,
        ['distorIns'] = 12,
        ['dustNum'] = 0.66,
        ['dustSize'] = 1.3,
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
        ['maskFeather'] = 0,
        ['startRotX'] = 0,
        ['startRotY'] = 0,
        ['startRotZ'] = 0,
        ['startMoveX'] = 0,
        ['startMoveY'] = 0,
        ['startMoveZ'] = 0,
        ['startSize'] = 1.2,
        ['endRotX'] = 0,
        ['endRotY'] = 0,
        ['endRotZ'] = 0,
        ['endMoveX'] = -10,
        ['endMoveY'] = 0,
        ['endMoveZ'] = 20,
        ['endSize'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_46-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiDust_46-effect0#progress#number'] =
{
	{
		{0.166666667, 0, 0.906, 0.457067097, }, 
		{0.033333, 1.666667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDust_46-effect0#maskFeather#number'] =
{
	{
		{0.166666667, 0, 0.895, 0.589535454, }, 
		{0.033333, 1.666667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDust_46-effect0#startSize#number'] =
{
	{
		{0.496, 0, 0.909, 0.314691623, }, 
		{0.033333, 1.666667, }, 
		{{1, }, {1.2, }, }, 
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
