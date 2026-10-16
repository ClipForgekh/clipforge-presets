local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiDust_49-effect0', 'InputTex', 0},
    {'LumiLayer_49-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiDust_49-effect0'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
        },
    },
    ['LumiLayer_49-blend'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
            ['baseTex'] = {{0, 5}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiDust_49-effect0'] = {
        ['progress'] = 92.2329142130349,
        ['distorIns'] = 1,
        ['dustNum'] = 2,
        ['dustSize'] = 1.7,
        ['brightness'] = 0,
        ['contrast'] = -0.31,
        ['quantity'] = 1,
        ['complexity'] = 10,
        ['evolution'] = 1,
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
        ['maskFeather'] = 0.30000001192093,
        ['startRotX'] = 0,
        ['startRotY'] = 0,
        ['startRotZ'] = 0,
        ['startMoveX'] = 0,
        ['startMoveY'] = 0,
        ['startMoveZ'] = 0,
        ['startSize'] = 1,
        ['endRotX'] = 361,
        ['endRotY'] = 361,
        ['endRotZ'] = 0,
        ['endMoveX'] = 0,
        ['endMoveY'] = 0,
        ['endMoveZ'] = 0,
        ['endSize'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1920),
    },
    ['LumiLayer_49-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiDust_49-effect0#progress#number'] =
{
	{
		{0.094161957, -4e-9, 0.191148718, 0.999999978, }, 
		{0, 1.966667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDust_49-effect0#endRotX#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.003353, 1.2, }, 
		{{0, }, {361, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDust_49-effect0#endRotY#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.003353, 1.2, }, 
		{{0, }, {361, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDust_49-effect0#endSize#number'] =
{
	{
		{0.989583375, 3e-9, 0.66666667, 1, }, 
		{0, 0.3, }, 
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
