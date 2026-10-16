local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiMotionBlur2D_48-effect0', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_48-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_48-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_108-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_108-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
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
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_48-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
    },
    ['LumiGaussianBlur_108-effect0'] = {
        ['blurIntensity'] = 0,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_108-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_48-effect0#ae_pre_position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{0.5, 0.5, }, {1.35277777777778, 0.5, }, {0.5, 0.5, }, {1.35277777777778, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.20000033333333, 0.36666633333333, }, 
		{{1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.36666633333333, 0.53333333333333, }, 
		{{-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.53333333333333, 0.70000033333333, }, 
		{{1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.70000033333333, 0.86666633333333, }, 
		{{-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.86666633333333, 1.20000033333333, }, 
		{{1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{1.20000033333333, 1.70000033333333, }, 
		{{-0.17187506246667, 0.5, }, {0.5, 0.5, }, {-0.17187506246667, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_48-effect0#position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0, 0.166667, }, 
		{{0.5, 0.5, }, {1.35277777777778, 0.5, }, {0.5, 0.5, }, {1.35277777777778, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.166667, 0.333333, }, 
		{{1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.333333, 0.5, }, 
		{{-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.5, 0.666667, }, 
		{{1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.666667, 0.833333, }, 
		{{-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.833333, 1.166667, }, 
		{{1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, {1.35277777777778, 0.5, }, {-0.17187506246667, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{1.166667, 1.666667, }, 
		{{-0.17187506246667, 0.5, }, {0.5, 0.5, }, {-0.17187506246667, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_48-trs#opacity#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0, 1.166667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_108-effect0#blurIntensity#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0, 1.166667, }, 
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
