local data = {}

local ae_compDurations = {0, 1.13333333333333}
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
        ['nodeDuration'] = {{0.16666666666667, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_101-effect1'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16666666666667, 1.16666666666667}, },
        },
    },
    ['LumiLayer_101-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16666666666667, 1.16666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_115-effect0'] = {
        ['nodeDuration'] = {{0.53333333333333, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_115-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.53333333333333, 1.16666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_110-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16666666666667, 2.06666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGeometry_101-effect0'] = {
        ['rotation'] = 42.6999969482422,
        ['rotationAxis'] = 270,
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
        ['scale_x'] = 3,
        ['ae_pre_scale_x'] = 3,
        ['scale_y'] = 1.8,
        ['ae_pre_scale_y'] = 1.8,
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
        ['blurIntensity'] = 24,
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
        ['opacity'] = 100,
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
		{0.704, 0, 0.922, 0.046147187, }, 
		{0.166667, 1.066667, }, 
		{{0, }, {42.699997, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGeometry_101-effect0#rotationAxis#number'] =
{
	{
		{0.181, 0.008148978, 0.77961203, 0.315403197, }, 
		{0.166667, 1.033333, }, 
		{{0, }, {279.246368, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.470696321, -1.698364012, 0.817340394, 2.507860763, }, 
		{1.033333, 1.066667, }, 
		{{279.246368, }, {270, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.47715613, 0, 0.824, 0.018994035, }, 
		{0.20000033333333, 1.03333333333333, }, 
		{{1, }, {1.0171064, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.389083386, 5.342818024, 0.722826191, -9.670358773, }, 
		{1.03333333333333, 1.06666633333333, }, 
		{{1.0171064, }, {1.04793518, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.639304913, 0.388684295, 0.977662724, -0.484263936, }, 
		{1.06666633333333, 1.10000033333333, }, 
		{{1.04793518, }, {3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#scale_x#number'] =
{
	{
		{0.47715613, 0, 0.824, 0.018994035, }, 
		{0.166667, 1, }, 
		{{1, }, {1.0171064, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.389083386, 5.342818024, 0.722826191, -9.670358773, }, 
		{1, 1.033333, }, 
		{{1.0171064, }, {1.04793518, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.639304913, 0.388684295, 0.977662724, -0.484263936, }, 
		{1.033333, 1.066667, }, 
		{{1.04793518, }, {3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#ae_pre_scale_y#number'] =
{
	{
		{0.588709374, 0, 0.859, -0.075132144, }, 
		{0.20000033333333, 1.06666633333333, }, 
		{{1, }, {1.20677849, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.512862783, 0.151139774, 0.829601353, 0.823023772, }, 
		{1.06666633333333, 1.10000033333333, }, 
		{{1.20677849, }, {1.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#scale_y#number'] =
{
	{
		{0.588709374, 0, 0.859, -0.075132144, }, 
		{0.166667, 1.033333, }, 
		{{1, }, {1.20677849, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.512862783, 0.151139774, 0.829601353, 0.823023772, }, 
		{1.033333, 1.066667, }, 
		{{1.20677849, }, {1.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_115-effect0#blurIntensity#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.533333, 1.066667, }, 
		{{0, }, {24, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_110-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.933333, 1.066667, }, 
		{{0, }, {100, }, }, 
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
