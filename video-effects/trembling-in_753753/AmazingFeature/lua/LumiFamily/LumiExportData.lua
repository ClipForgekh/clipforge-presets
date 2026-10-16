local data = {}

local ae_compDurations = {0, 0.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiGeometry_101-effect0', 'InputTex', 0},
    {'LumiLayer_101-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiGeometry_101-effect0'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_101-effect1'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.83333333333333}, },
        },
    },
    ['LumiLayer_101-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.83333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_115-effect0'] = {
        ['nodeDuration'] = {{0, 0.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_115-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.53333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_110-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.83333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGeometry_101-effect0'] = {
        ['rotation'] = 0,
        ['rotationAxis'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_101-effect1'] = {
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
        ['vIntensity'] = 0,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_101-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiGaussianBlur_115-effect0'] = {
        ['blurIntensity'] = 0,
        ['quality'] = 1,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_115-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_110-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiGeometry_101-effect0#rotation#number'] =
{
	{
		{0.078, 0.883197049, 0.296, 1, }, 
		{0, 0.833333, }, 
		{{42.699997, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGeometry_101-effect0#rotationAxis#number'] =
{
	{
		{0.182659606, -1.507861574, 0.529303679, 2.698364926, }, 
		{0, 0.033333, }, 
		{{270, }, {279.246363, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.22038797, 0.631935522, 0.819, 0.992477867, }, 
		{0.033333, 0.833333, }, 
		{{279.246363, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.022337276, 1.484263908, 0.360695087, 0.611315712, }, 
		{0.03333333333333, 0.06666633333333, }, 
		{{3, }, {1.04793514, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.277173809, 10.670361473, 0.610916614, -4.342819376, }, 
		{0.06666633333333, 0.10000033333333, }, 
		{{1.04793514, }, {1.01710637, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.176, 0.902526992, 0.52284387, 1, }, 
		{0.10000033333333, 0.86666633333333, }, 
		{{1.01710637, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#scale_x#number'] =
{
	{
		{0.022337276, 1.484263908, 0.360695087, 0.611315712, }, 
		{0, 0.033333, }, 
		{{3, }, {1.04793514, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.277173809, 10.670361473, 0.610916614, -4.342819376, }, 
		{0.033333, 0.066667, }, 
		{{1.04793514, }, {1.01710637, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.176, 0.902526992, 0.52284387, 1, }, 
		{0.066667, 0.833333, }, 
		{{1.01710637, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#ae_pre_scale_y#number'] =
{
	{
		{0.170398647, 0.176976236, 0.487137217, 0.848860219, }, 
		{0.03333333333333, 0.06666633333333, }, 
		{{1.8, }, {1.20677852, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.141, 0.992429541, 0.411290626, 1, }, 
		{0.06666633333333, 0.86666633333333, }, 
		{{1.20677852, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#scale_y#number'] =
{
	{
		{0.170398647, 0.176976236, 0.487137217, 0.848860219, }, 
		{0, 0.033333, }, 
		{{1.8, }, {1.20677852, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.141, 0.992429541, 0.411290626, 1, }, 
		{0.033333, 0.833333, }, 
		{{1.20677852, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_115-effect0#blurIntensity#number'] =
{
	{
		{0.036, 1.200034522, 0.25, 0.894435631, }, 
		{0, 0.533333, }, 
		{{24, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_110-trs-blend#opacity#number'] =
{
	{
		{0.464, 0.064400219, 0.38, 1, }, 
		{0, 0.233333, }, 
		{{100, }, {0, }, }, 
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
