local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiChromaticAberration_506-effect0', 'InputTex', 0},
    {'LumiSaturation_505-effect0', 'InputTex', 0},
    {'LumiMotionBlur2D_48-effect0', 'InputTex', 0},
    {'LumiMotionBlur2D_507-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiChromaticAberration_506-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_506-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSaturation_505-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiChromaticAberration_505-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_505-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_48-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSaturation_48-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_505-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_506-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_507-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_507-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiChromaticAberration_506-effect0'] = {
        ['offsetX'] = 0.01,
        ['offsetY'] = 0.31,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_506-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.2,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiSaturation_505-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiChromaticAberration_505-effect1'] = {
        ['offsetX'] = 0.01,
        ['offsetY'] = 0.31,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_505-effect2'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.2,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_48-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.2,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiSaturation_48-effect1'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_505-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLayer_506-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_507-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(-0.129987578324, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(-0.129987578324, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1.41767087660796,
        ['ae_pre_scale_x'] = 1.41767087660796,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.2,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_507-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_506-effect1#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.83333333333333, 1.33333333333333, }, 
		{{0.5, 0.5, }, {-1.00833333333333, 0.5, }, {0.5, 0.5, }, {-1.00833333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_506-effect1#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.8, 1.3, }, 
		{{0.5, 0.5, }, {-1.00833333333333, 0.5, }, {0.5, 0.5, }, {-1.00833333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_506-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.83333333333333, 1.33333333333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_506-effect1#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.8, 1.3, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_505-effect2#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.16666633333333, 1.66666633333333, }, 
		{{0.5, 0.5, }, {-1.00833333333333, 0.5, }, {0.5, 0.5, }, {-1.00833333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_505-effect2#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.133333, 1.633333, }, 
		{{0.5, 0.5, }, {-1.00833333333333, 0.5, }, {0.5, 0.5, }, {-1.00833333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_505-effect2#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.16666633333333, 1.66666633333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_505-effect2#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.133333, 1.633333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.50000033333333, 2.00000033333333, }, 
		{{0.5, 0.5, }, {-1.00833333333333, 0.5, }, {0.5, 0.5, }, {-1.00833333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.466667, 1.966667, }, 
		{{0.5, 0.5, }, {-1.00833333333333, 0.5, }, {0.5, 0.5, }, {-1.00833333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.50000033333333, 2.00000033333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.466667, 1.966667, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_507-effect0#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.50000033333333, 1.00000033333333, }, 
		{{0.5, 0.5, }, {-1.00833333333333, 0.5, }, {0.5, 0.5, }, {-1.00833333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_507-effect0#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.466667, 0.966667, }, 
		{{0.5, 0.5, }, {-1.00833333333333, 0.5, }, {0.5, 0.5, }, {-1.00833333333333, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_507-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.50000033333333, 1.00000033333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_507-effect0#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.466667, 0.966667, }, 
		{{1, }, {2, }, }, 
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
