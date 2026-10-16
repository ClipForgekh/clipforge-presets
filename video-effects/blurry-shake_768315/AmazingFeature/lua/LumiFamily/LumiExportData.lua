local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_41-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_41-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_41-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
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
    ['LumiGaussianBlur_41-effect1'] = {
        ['blurIntensity'] = 0,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_41-trs'] = {
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
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_41-effect0#ae_pre_rotate#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.03333333333333, 0.66666633333333, }, 
		{{28, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.666666666, 1.302439024, }, 
		{0.66666633333333, 0.86666633333333, }, 
		{{0, }, {-18.222222, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333335, 0.124723396, 0.666666669, 1, }, 
		{0.86666633333333, 1.03333333333333, }, 
		{{-18.222222, }, {18.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.03333333333333, 1.23333333333333, }, 
		{{18.6, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.23333333333333, 1.63333333333333, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#rotate#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0, 0.633333, }, 
		{{28, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.666666666, 1.302439024, }, 
		{0.633333, 0.833333, }, 
		{{0, }, {-18.222222, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333335, 0.124723396, 0.666666669, 1, }, 
		{0.833333, 1, }, 
		{{-18.222222, }, {18.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.2, }, 
		{{18.6, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.2, 1.6, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0, 0, 1, }, 
		{0.03333333333333, 0.60000033333333, }, 
		{{0.39947916666667, 0.5, }, {0.44924029015625, 0.5, }, {0.39947916666667, 0.5, }, {0.44924029015625, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.447965, 0, 0.576305, 1, }, 
		{0.60000033333333, 0.96666633333333, }, 
		{{0.44924029015625, 0.5, }, {0.39947916666667, 0.5, }, {0.44924029015625, 0.5, }, {0.39947916666667, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.576305, 1, }, 
		{0.96666633333333, 1.36666633333333, }, 
		{{0.39947916666667, 0.5, }, {0.5, 0.5, }, {0.39947916666667, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#position#vector'] =
{
	{
		{0.166667, 0, 0, 1, }, 
		{0, 0.566667, }, 
		{{0.39947916666667, 0.5, }, {0.44924029015625, 0.5, }, {0.39947916666667, 0.5, }, {0.44924029015625, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.447965, 0, 0.576305, 1, }, 
		{0.566667, 0.933333, }, 
		{{0.44924029015625, 0.5, }, {0.39947916666667, 0.5, }, {0.44924029015625, 0.5, }, {0.39947916666667, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.576305, 1, }, 
		{0.933333, 1.333333, }, 
		{{0.39947916666667, 0.5, }, {0.5, 0.5, }, {0.39947916666667, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.367943268, 0, 0.036411579, 0.943043878, }, 
		{0.03333333333333, 0.50000033333333, }, 
		{{4.4, }, {2.10301283, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.321542597, -0.134768101, 0.654715262, 2.33166252, }, 
		{0.50000033333333, 0.93333333333333, }, 
		{{2.10301283, }, {2.40381027, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.322627595, 0.266614659, 0.655829858, 0.999999512, }, 
		{0.93333333333333, 1.36666633333333, }, 
		{{2.40381027, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_41-effect0#scale_x#number'] =
{
	{
		{0.367943268, 0, 0.036411579, 0.943043878, }, 
		{0, 0.466667, }, 
		{{4.4, }, {2.10301283, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.321542597, -0.134768101, 0.654715262, 2.33166252, }, 
		{0.466667, 0.9, }, 
		{{2.10301283, }, {2.40381027, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.322627595, 0.266614659, 0.655829858, 0.999999512, }, 
		{0.9, 1.333333, }, 
		{{2.40381027, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_41-effect1#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.7, 1.033333, }, 
		{{70, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.033333, 1.2, }, 
		{{0, }, {42, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.2, 1.4, }, 
		{{42, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_41-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.333333, }, 
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
