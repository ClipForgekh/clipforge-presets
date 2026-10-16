local data = {}

local ae_compDurations = {0, 1.06666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_67-trs-blend', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_67-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_67-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 1864, 0),
        ['scale'] = Amaz.Vector3f(70, 70, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 10,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_67-trs-blend#position#vector'] =
{
	{
		{0.333333, 0.333333, 0.833333, 0.833333, }, 
		{0.033333, 0.5, }, 
		{{360, 640, 0, }, {360, 640, 0, }, {360, 640, 0, }, {360, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.783951, 0, 0.666667, 1, }, 
		{0.5, 1, }, 
		{{360, 640, 0, }, {360, 1864, 0, }, {360, 844, 0, }, {360, 1660, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#scale#vector'] =
{
	{
		{0.221726324,0.221726324,0.13333332, -4.9e-8,-4.9e-8,0.13333332, 0,0,0, 0.999999962,0.999999962,0, }, 
		{0.033333, 0.5, }, 
		{{100, 100, 100, }, {70, 70, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#rotation#number'] =
{
	{
		{0.221726324, -4.9e-8, 0, 0.999999962, }, 
		{0.033333, 0.5, }, 
		{{0, }, {10, }, }, 
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
