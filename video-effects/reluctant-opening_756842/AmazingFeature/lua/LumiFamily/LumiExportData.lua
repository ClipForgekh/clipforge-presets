local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_2902-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_2902-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_2901-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_2902-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(252, 896, 0),
        ['position'] = Amaz.Vector3f(252, 896, 0),
        ['scale'] = Amaz.Vector3f(100, 22.900729163649, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2901-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(252, 0, 0),
        ['position'] = Amaz.Vector3f(252, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 22.900729163649, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_2902-trs-blend#scale#vector'] =
{
	{
		{0.51,0.51,0.51, 0.51,0,0.51, 0.75,0.75,0.75, 0.75,1,0.75, }, 
		{0, 0.633333, }, 
		{{100, 50.5, 100, }, {100, 22.5, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.43,0.43,0.43, 0.43,0,0.43, 0.833333333,0.833333333,0.833333333, 0.833333333,1,0.833333333, }, 
		{0.633333, 1.333333, }, 
		{{100, 22.5, 100, }, {100, 48, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.52,0.52,0.52, 0.52,0,0.52, 0.3,0.3,0.3, 0.3,1,0.3, }, 
		{1.333333, 1.966667, }, 
		{{100, 48, 100, }, {100, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2901-trs-blend#scale#vector'] =
{
	{
		{0.51,0.51,0.51, 0.51,0,0.51, 0.75,0.75,0.75, 0.75,1,0.75, }, 
		{0, 0.633333, }, 
		{{100, 50.5, 100, }, {100, 22.5, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.43,0.43,0.43, 0.43,0,0.43, 0.833333333,0.833333333,0.833333333, 0.833333333,1,0.833333333, }, 
		{0.633333, 1.333333, }, 
		{{100, 22.5, 100, }, {100, 48, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.52,0.52,0.52, 0.52,0,0.52, 0.3,0.3,0.3, 0.3,1,0.3, }, 
		{1.333333, 1.966667, }, 
		{{100, 48, 100, }, {100, 0, 100, }, }, 
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
