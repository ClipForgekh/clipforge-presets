local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBCC_Prism_28-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_28-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiCircleWipe_27-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_27-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_27-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBCC_Prism_28-effect0'] = {
        ['globalTransform'] = 100,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 1,
        ['scaleStart'] = 102,
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
    ['LumiLayer_28-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100.315950446771, 100.315950446771, 100),
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
    ['LumiCircleWipe_27-effect0'] = {
        ['radiusMode'] = 0,
        ['progress'] = 0.57418725761929,
        ['radius'] = 0,
        ['center'] = Amaz.Vector2f(0.49976091384888, 0.50281533135308),
        ['feather'] = 1,
        ['reverse'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiGaussianBlur_27-effect1'] = {
        ['blurIntensity'] = 352.727272727273,
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
    ['LumiLayer_27-trs-blend'] = {
        ['hasBlend'] = true,
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
        ['p0_anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100.315950446771, 100.315950446771, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiBCC_Prism_28-effect0#globalTransform#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 2, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_28-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0,0,0.66666667, 1.00000159,1.00000159,0.66666667, }, 
		{0, 1.833333, }, 
		{{106.8, 106.8, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiCircleWipe_27-effect0#progress#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.533333, 1.666667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_27-effect1#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.833333, }, 
		{{50, }, {500, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.1, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0,0,0.66666667, 1.00000159,1.00000159,0.66666667, }, 
		{0, 1.833333, }, 
		{{106.8, 106.8, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#p0_opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.5, }, 
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
