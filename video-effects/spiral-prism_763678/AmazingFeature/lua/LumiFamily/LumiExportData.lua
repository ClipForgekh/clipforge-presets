local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBCC_Prism_8189-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_8189-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBCC_Prism_8189-effect1'] = {
        ['globalTransform'] = 196,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.45185185185185),
        ['weight'] = 1,
        ['scaleStart'] = 68,
        ['scaleEnd'] = 98,
        ['angleStart'] = 19,
        ['angleEnd'] = 0,
        ['falloff'] = 0,
        ['offsetStart'] = Amaz.Vector2f(0.65462962962963, 0.5),
        ['offsetEnd'] = Amaz.Vector2f(0.5, 0.5),
        ['colorStart'] = Amaz.Color(1, 0, 0, 1),
        ['colorMid'] = Amaz.Color(0, 1, 0, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 1, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_8189-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 45,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = true,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiBCC_Prism_8189-effect1#globalTransform#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.466667, 1, }, 
		{{196, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_8189-effect1#scaleStart#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.966667, }, 
		{{68, }, {102, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_8189-effect1#angleStart#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.966667, }, 
		{{19, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_8189-effect1#offsetStart#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.966667, }, 
		{{0.65462962962963, 0.5, }, {0.5, 0.5, }, {0.65462962962963, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_8189-trs#rotation#number'] =
{
	{
		{0.940708771, 5.8e-8, 0.54837158, 0.999999981, }, 
		{0, 0.966667, }, 
		{{45, }, {0, }, }, 
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
