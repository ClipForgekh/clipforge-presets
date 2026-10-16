local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_1257-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_1621-effect0'] = {
        ['nodeDuration'] = {{0, 1.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_1621-effect1'] = {
        ['nodeDuration'] = {{0, 1.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.06666666666667}, },
        },
    },
    ['LumiDirectionalBlurs_1621-effect2'] = {
        ['nodeDuration'] = {{0, 1.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.06666666666667}, },
        },
    },
    ['LumiExposure_1621-effect3'] = {
        ['nodeDuration'] = {{0, 1.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.06666666666667}, },
        },
    },
    ['LumiLayer_1621-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.06666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_1257-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiMotionBlur2D_1621-effect0'] = {
        ['rotate'] = -0.10645957507489,
        ['ae_pre_rotate'] = -0.10645957507489,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.49753958108502, 0.49882014999399),
        ['ae_pre_position'] = Amaz.Vector2f(0.49753958108502, 0.49882014999399),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.01233165969723,
        ['ae_pre_scale_x'] = 1.01233165969723,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiMotionBlur2D_1621-effect1'] = {
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
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiDirectionalBlurs_1621-effect2'] = {
        ['blurIntensity'] = 0,
        ['angle'] = 90,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiExposure_1621-effect3'] = {
        ['channelType'] = 0,
        ['exposure'] = 0,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_1621-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_1257-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.266667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur2D_1621-effect0#ae_pre_rotate#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0.03333333333333, 0.56666633333333, }, 
		{{0, }, {-11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.411735319, 1.000000049, }, 
		{0.56666633333333, 1.04667933333333, }, 
		{{-11, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1621-effect0#rotate#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0, 0.533333, }, 
		{{0, }, {-11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.411735319, 1.000000049, }, 
		{0.533333, 1.013346, }, 
		{{-11, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1621-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.666667, 1, }, 
		{0.03333333333333, 0.56666633333333, }, 
		{{0.5, 0.5, }, {0.18333333333333, 0.34814814814815, }, {0.5, 0.5, }, {0.18333333333333, 0.34814814814815, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.341292, 1, }, 
		{0.56666633333333, 1.04667933333333, }, 
		{{0.18333333333333, 0.34814814814815, }, {0.5, 0.5, }, {0.18333333333333, 0.34814814814815, }, {0.44722222089767, 0.474691357436, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1621-effect0#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.666667, 1, }, 
		{0, 0.533333, }, 
		{{0.5, 0.5, }, {0.18333333333333, 0.34814814814815, }, {0.5, 0.5, }, {0.18333333333333, 0.34814814814815, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.341292, 1, }, 
		{0.533333, 1.013346, }, 
		{{0.18333333333333, 0.34814814814815, }, {0.5, 0.5, }, {0.18333333333333, 0.34814814814815, }, {0.44722222089767, 0.474691357436, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1621-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0.03333333333333, 0.56666633333333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.482179075, 1.000000013, }, 
		{0.56666633333333, 1.04667933333333, }, 
		{{2, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1621-effect0#scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0, 0.533333, }, 
		{{1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.482179075, 1.000000013, }, 
		{0.533333, 1.013346, }, 
		{{2, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1621-effect1#ae_pre_position#vector'] =
{
	{
		{0.315471, 0, 0.666667, 1, }, 
		{0.03333333333333, 0.70000033333333, }, 
		{{-3.75104166666667, 0.5, }, {0.5, 0.5, }, {-3.75104166666667, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1621-effect1#position#vector'] =
{
	{
		{0.315471, 0, 0.666667, 1, }, 
		{0, 0.666667, }, 
		{{-3.75104166666667, 0.5, }, {0.5, 0.5, }, {-3.75104166666667, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_1621-effect2#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.533333, }, 
		{{50, }, {52, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.533333, 0.7, }, 
		{{52, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExposure_1621-effect3#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.133333, 0.85332, }, 
		{{5, }, {0, }, }, 
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
