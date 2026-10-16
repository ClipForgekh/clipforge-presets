local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_37-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_37-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiMotionBlur2D_39-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_39-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_37-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 5,
        ['fadeType'] = 0,
    },
    ['LumiLayer_37-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_39-effect0'] = {
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
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiLayer_39-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_37-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.782227, 1.051107, }, 
		{{95, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur2D_39-effect0#ae_pre_position#vector'] =
{
	{
		{0.837584, 0, 0.9999, 1, }, 
		{0.03333333333333, 0.40000033333333, }, 
		{{0.50740740740741, -0.25, }, {0.50393514602222, 0.13476925979028, }, {0.50740740740741, -0.25, }, {0.50393514602222, 0.13476925979028, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.0001, 0, 0.205685, 1, }, 
		{0.40000033333333, 0.79111333333333, }, 
		{{0.50393514602222, 0.13476925979028, }, {0.5, 0.5, }, {0.50393514602222, 0.13476925979028, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_39-effect0#position#vector'] =
{
	{
		{0.837584, 0, 0.9999, 1, }, 
		{0, 0.366667, }, 
		{{0.50740740740741, -0.25, }, {0.50393514602222, 0.13476925979028, }, {0.50740740740741, -0.25, }, {0.50393514602222, 0.13476925979028, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.0001, 0, 0.205685, 1, }, 
		{0.366667, 0.75778, }, 
		{{0.50393514602222, 0.13476925979028, }, {0.5, 0.5, }, {0.50393514602222, 0.13476925979028, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_39-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.035234872, 2e-9, 0.182885748, 1.000000034, }, 
		{0.74222033333333, 1.13333333333333, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_39-effect0#scale_x#number'] =
{
	{
		{0.035234872, 2e-9, 0.182885748, 1.000000034, }, 
		{0.708887, 1.1, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_39-effect0#ae_pre_scale_y#number'] =
{
	{
		{0.035234872, 2e-9, 0.182885748, 1.000000034, }, 
		{0.74222033333333, 1.13333333333333, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_39-effect0#scale_y#number'] =
{
	{
		{0.035234872, 2e-9, 0.182885748, 1.000000034, }, 
		{0.708887, 1.1, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = true
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
