local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur3D_122-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiTwirl_122-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiWarp_122-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBCC_Prism_157-effect0'] = {
        ['nodeDuration'] = {{0, 1.93333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_157-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.93333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur3D_122-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 0,
        ['ae_pre_direction_y'] = 0,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTwirl_122-effect1'] = {
        ['angle'] = 0,
        ['radius'] = 30,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiWarp_122-effect2'] = {
        ['warpStyle'] = 11,
        ['warpAxis'] = 0,
        ['bend'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiBCC_Prism_157-effect0'] = {
        ['globalTransform'] = 100,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 1,
        ['scaleStart'] = 100,
        ['scaleEnd'] = 98,
        ['angleStart'] = 0,
        ['angleEnd'] = 0,
        ['falloff'] = 0,
        ['offsetStart'] = Amaz.Vector2f(0.5, 0.5),
        ['offsetEnd'] = Amaz.Vector2f(0.5, 0.5),
        ['colorStart'] = Amaz.Color(1, 0, 0, 1),
        ['colorMid'] = Amaz.Color(0, 1, 0, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 1, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_157-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_122-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.502230352, 0, 0.214854457, 1.386399087, }, 
		{0.03333333333333, 0.83333333333333, }, 
		{{1, }, {3.0531779, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.233062565, 0.162489805, 0.66666667, 1, }, 
		{0.83333333333333, 1.96666633333333, }, 
		{{3.0531779, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_122-effect0#scale_x#number'] =
{
	{
		{0.502230352, 0, 0.214854457, 1.386399087, }, 
		{0, 0.8, }, 
		{{1, }, {3.0531779, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.233062565, 0.162489805, 0.66666667, 1, }, 
		{0.8, 1.933333, }, 
		{{3.0531779, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_122-effect0#ae_pre_rotation_z#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.03333333333333, 0.43333333333333, }, 
		{{0, }, {29.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.43333333333333, 0.83333333333333, }, 
		{{29.2, }, {-127.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.16998585, 0, 0.576386886, 0.807322948, }, 
		{0.83333333333333, 1.16666633333333, }, 
		{{-127.8, }, {25.134023, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.40844857, -0.777686561, 0.66666667, 1, }, 
		{1.16666633333333, 1.50000033333333, }, 
		{{25.134023, }, {-11.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.50000033333333, 1.73333333333333, }, 
		{{-11.4, }, {5.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.73333333333333, 1.96666633333333, }, 
		{{5.1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_122-effect0#rotation_z#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.4, }, 
		{{0, }, {29.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.4, 0.8, }, 
		{{29.2, }, {-127.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.16998585, 0, 0.576386886, 0.807322948, }, 
		{0.8, 1.133333, }, 
		{{-127.8, }, {25.134023, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.40844857, -0.777686561, 0.66666667, 1, }, 
		{1.133333, 1.466667, }, 
		{{25.134023, }, {-11.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.466667, 1.7, }, 
		{{-11.4, }, {5.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.7, 1.933333, }, 
		{{5.1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTwirl_122-effect1#angle#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.166667, }, 
		{{0, }, {24.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.166667, 0.566667, }, 
		{{24.8, }, {-153.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.566667, 1, }, 
		{{-153.2, }, {136.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.583333333, 0.721316819, }, 
		{1, 1.333333, }, 
		{{136.8, }, {-16.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.416666667, -1.395918367, 0.66666667, 1, }, 
		{1.333333, 1.6, }, 
		{{-16.6, }, {7.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.6, 1.8, }, 
		{{7.9, }, {-12.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.8, 1.933333, }, 
		{{-12.9, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_122-effect2#bend#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0, 1, }, 
		{{0, }, {-55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.966667, }, 
		{{-55, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_157-effect0#scaleStart#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.8, }, 
		{{100, }, {124, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 1.933333, }, 
		{{124, }, {100, }, }, 
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
