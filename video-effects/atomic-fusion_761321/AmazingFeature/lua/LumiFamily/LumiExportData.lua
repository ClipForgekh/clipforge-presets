local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_31-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiClone_30-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['mainImage'] = {{0, 2}, },
        },
    },
    ['LumiLayer_30-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_31-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_31-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiClone_30-effect0'] = {
        ['type'] = 1,
        ['count'] = 4,
        ['distance'] = 100,
        ['angle'] = -360,
        ['scale'] = 0.5,
        ['rotation'] = 0,
        ['center'] = Amaz.Vector2f(0, 1),
        ['distribution'] = 0,
        ['initialScale'] = 0.01,
        ['startAlpha'] = 0,
        ['endAlpha'] = 1,
        ['reverseLayer'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_30-trs'] = {
        ['hasBlend'] = false,
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
    },
    ['LumiLayer_31-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 2.27373675443232e-13, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_31-effect0#radius#number'] =
{
	{
		{0.69, 0, 0.83, 1, }, 
		{0.766667, 1.7, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiClone_30-effect0#angle#number'] =
{
	{
		{0.27544614, 0.783391671, 0.61670199, 0.336775497, }, 
		{0, 1.7, }, 
		{{0, }, {-360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiClone_30-effect0#initialScale#number'] =
{
	{
		{0.64, 0, 0.69, 1, }, 
		{0, 0.9, }, 
		{{0.01, }, {0.38, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.31, 0, 0.36, 1, }, 
		{0.9, 1.7, }, 
		{{0.38, }, {0.01, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_30-trs#opacity#number'] =
{
	{
		{0.2, 0, 0.35, 1, }, 
		{0, 0.333333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 1.366667, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.65, 0, 0.8, 1, }, 
		{1.366667, 1.7, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#scale#vector'] =
{
	{
		{0.48,0.48,0.48, 0,0,0.48, 0.52,0.52,0.52, 1,1,0.52, }, 
		{0, 1.066667, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#p0_scale#vector'] =
{
	{
		{0.5,0.5,0.5, 0,0,0.5, 0.5,0.5,0.5, 1,1,0.5, }, 
		{0.766667, 1.7, }, 
		{{40, 40, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
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
