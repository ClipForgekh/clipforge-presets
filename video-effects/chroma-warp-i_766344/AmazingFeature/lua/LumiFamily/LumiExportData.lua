local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_141-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_141-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiCCLens_157-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBCC_Prism_157-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_157-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiTwirl_216-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_216-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiPixelSprint_159-effect0'] = {
        ['nodeDuration'] = {{-0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiCCLens_159-effect3'] = {
        ['nodeDuration'] = {{-0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.03333333333333, 2}, },
        },
    },
    ['LumiLayer_159-blend'] = {
        ['nodeDuration'] = {{-0.03333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{-0.03333333333333, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_141-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['p0_position'] = Amaz.Vector3f(392, 554, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
    },
    ['LumiCCLens_157-effect1'] = {
        ['convergence'] = 0,
        ['radius'] = 100,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
    },
    ['LumiBCC_Prism_157-effect2'] = {
        ['globalTransform'] = 0,
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
    },
    ['LumiLayer_157-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiTwirl_216-effect0'] = {
        ['angle'] = 0,
        ['radius'] = 54,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
    },
    ['LumiLayer_216-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiPixelSprint_159-effect0'] = {
        ['pixelSprintIntensity'] = 0,
        ['centerX'] = 0.5,
        ['centerY'] = 0.5,
    },
    ['LumiCCLens_159-effect3'] = {
        ['convergence'] = 0,
        ['radius'] = 112,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
    },
    ['LumiLayer_159-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiCCLens_157-effect1#convergence#number'] =
{
	{
		{0.17833405, 0, 0.840088134, 1, }, 
		{0.633333, 1.733333, }, 
		{{-100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCCLens_157-effect1#radius#number'] =
{
	{
		{0.157545233, 0, 0.62124687, 0.632836226, }, 
		{0.066667, 0.633333, }, 
		{{0, }, {40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.44453941, 0.574582771, 0.830568318, 1, }, 
		{0.633333, 1.766667, }, 
		{{40, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_157-effect2#globalTransform#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.166667, 1.766667, }, 
		{{311, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTwirl_216-effect0#angle#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.2, 1.566667, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiPixelSprint_159-effect0#pixelSprintIntensity#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.1, 1.933333, }, 
		{{0.8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCCLens_159-effect3#convergence#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.066667, 0.933333, }, 
		{{78.545455, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.933333, 1.933333, }, 
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
