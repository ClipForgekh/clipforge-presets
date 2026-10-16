local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiTone_502-effect0', 'InputTex', 0},
    {'LumiTone_48-effect0', 'InputTex', 0},
    {'LumiTone_503-effect0', 'InputTex', 0},
    {'LumiMotionBlur2D_504-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiTone_502-effect0'] = {
        ['nodeDuration'] = {{0.66666666666667, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 1.53333333333333}, },
        },
    },
    ['LumiMotionBlur2D_502-effect1'] = {
        ['nodeDuration'] = {{0.66666666666667, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 1.53333333333333}, },
        },
    },
    ['LumiTone_48-effect0'] = {
        ['nodeDuration'] = {{1, 1.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.83333333333333}, },
        },
    },
    ['LumiMotionBlur2D_48-effect1'] = {
        ['nodeDuration'] = {{1, 1.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.83333333333333}, },
        },
    },
    ['LumiLayer_502-blend'] = {
        ['nodeDuration'] = {{0.66666666666667, 1.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 1.53333333333333}, },
            ['baseTex'] = {{1, 1.83333333333333}, },
        },
    },
    ['LumiTone_503-effect0'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiMotionBlur2D_503-effect1'] = {
        ['nodeDuration'] = {{0, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
        },
    },
    ['LumiLayer_503-blend'] = {
        ['nodeDuration'] = {{0, 1.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.2}, },
            ['baseTex'] = {{0.66666666666667, 1.83333333333333}, },
        },
    },
    ['LumiMotionBlur2D_504-effect0'] = {
        ['nodeDuration'] = {{0, 0.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.7}, },
        },
    },
    ['LumiLayer_504-blend'] = {
        ['nodeDuration'] = {{0, 1.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.7}, },
            ['baseTex'] = {{0, 1.83333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiTone_502-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.05098039284348, 0.3835292160511, 0.88235294818878, 1),
        ['blackColor'] = Amaz.Color(0.16862745583057, 0.04364475607872, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_502-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(-1.00555555555556, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(-1.00555555555556, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 2,
        ['ae_pre_scale_x'] = 2,
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
    ['LumiTone_48-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.88235294117647, 0.83529411764706, 0.05098039215686, 1),
        ['blackColor'] = Amaz.Color(0.33333333333333, 0.07058823529412, 0.36470588235294, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_48-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(2.01111111111111, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(2.01111111111111, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 2,
        ['ae_pre_scale_x'] = 2,
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
    ['LumiLayer_502-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiTone_503-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.88235294818878, 0.05098039284348, 0.05098039284348, 1),
        ['blackColor'] = Amaz.Color(0, 0.16862745583057, 0.00396770844236, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_503-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 2.00277777777778),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 2.00277777777778),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 2,
        ['ae_pre_scale_y'] = 2,
        ['vIntensity'] = 0.2,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_503-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_504-effect0'] = {
        ['rotate'] = -180,
        ['ae_pre_rotate'] = -180,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 0,
        ['ae_pre_scale_x'] = 0,
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
    ['LumiLayer_504-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_502-effect1#ae_pre_position#vector'] =
{
	{
		{0.5, 0, 0.833333, 1, }, 
		{1.03333333333333, 1.53333333333333, }, 
		{{0.5, 0.5, }, {-1.00555555555556, 0.5, }, {0.5, 0.5, }, {-1.00555555555556, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_502-effect1#position#vector'] =
{
	{
		{0.5, 0, 0.833333, 1, }, 
		{1, 1.5, }, 
		{{0.5, 0.5, }, {-1.00555555555556, 0.5, }, {0.5, 0.5, }, {-1.00555555555556, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_502-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_502-effect1#scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1, 1.333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect1#ae_pre_position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.33333333333333, 1.83333333333333, }, 
		{{0.5, 0.5, }, {2.01111111111111, 0.5, }, {0.5, 0.5, }, {2.01111111111111, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect1#position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.3, 1.8, }, 
		{{0.5, 0.5, }, {2.01111111111111, 0.5, }, {0.5, 0.5, }, {2.01111111111111, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.33333333333333, 1.66666633333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect1#scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.3, 1.633333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_503-effect1#ae_pre_position#vector'] =
{
	{
		{0.5, 0, 0.833333, 1, }, 
		{0.70000033333333, 1.20000033333333, }, 
		{{0.5, 0.5, }, {0.5, 2.00277777777778, }, {0.5, 0.5, }, {0.5, 2.00277777777778, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_503-effect1#position#vector'] =
{
	{
		{0.5, 0, 0.833333, 1, }, 
		{0.666667, 1.166667, }, 
		{{0.5, 0.5, }, {0.5, 2.00277777777778, }, {0.5, 0.5, }, {0.5, 2.00277777777778, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_503-effect1#ae_pre_scale_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.70000033333333, 1.03333333333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_503-effect1#scale_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.666667, 1, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_504-effect0#ae_pre_rotate#number'] =
{
	{
		{0.48, 0, 0.52, 1, }, 
		{0.36666633333333, 0.70000033333333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_504-effect0#rotate#number'] =
{
	{
		{0.48, 0, 0.52, 1, }, 
		{0.333333, 0.666667, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_504-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.48, 0, 0.52, 1, }, 
		{0.36666633333333, 0.70000033333333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_504-effect0#scale_x#number'] =
{
	{
		{0.48, 0, 0.52, 1, }, 
		{0.333333, 0.666667, }, 
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
