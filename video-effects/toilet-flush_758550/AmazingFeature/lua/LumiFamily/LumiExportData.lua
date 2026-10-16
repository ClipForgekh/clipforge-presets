local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMercury_122-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_123-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.23333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMercury_122-effect0'] = {
        ['useCustomTime'] = true,
        ['customTime'] = 1,
        ['radiusX'] = 0.05000000074506,
        ['radiusY'] = 0.05000000074506,
        ['producerPosition'] = Amaz.Vector2f(0.5, 0.5),
        ['birthRate'] = 0,
        ['longevity'] = 2,
        ['producerLongevity'] = 600,
        ['blobInfluence'] = 0.62,
        ['blobBirthSize'] = 0.10999999940395,
        ['blobDeathSize'] = 0.29000001192093,
        ['blobRandomSize'] = 1.09,
        ['blobInfluenceInOut'] = true,
        ['velocity'] = 0.30555555555556,
        ['resistance'] = 0.76999999977648,
        ['gravity'] = 0,
        ['extra'] = 1,
        ['animationType'] = 1,
        ['lightType'] = 1,
        ['lightIntensity'] = 1,
        ['lightHeight'] = 0.80000001192093,
        ['lightPosition'] = Amaz.Vector2f(0.3, 0.30000015258789),
        ['lightDirection'] = -45,
        ['strength'] = 0.5,
        ['roughness'] = 0.04,
        ['metal'] = 0,
        ['specular'] = 0.07,
        ['ambient'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_123-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
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
    ['LumiMercury_122-effect0#radiusX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.8, }, 
		{{0.98, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMercury_122-effect0#radiusY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.8, }, 
		{{0.96, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMercury_122-effect0#birthRate#number'] =
{
	{
		{0.166666667, 0, 0.67, 0, }, 
		{0, 1.166667, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33, 0, 0.833333333, 0.833333333, }, 
		{1.166667, 1.8, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMercury_122-effect0#longevity#number'] =
{
	{
		{0.36, 0, 0.833333333, 1, }, 
		{0.266667, 1.8, }, 
		{{0.8, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMercury_122-effect0#blobBirthSize#number'] =
{
	{
		{0.36, 0, 0.833333333, 1, }, 
		{0.633333, 1.8, }, 
		{{1.05, }, {0.11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMercury_122-effect0#blobDeathSize#number'] =
{
	{
		{0.166666667, 0.166666667, 0.63, 1, }, 
		{0, 0.633333, }, 
		{{3.92, }, {0.65, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.633333, 1.8, }, 
		{{0.65, }, {0.29, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMercury_122-effect0#velocity#number'] =
{
	{
		{0.33, 0, 0.833333333, 0.833333333, }, 
		{0.633333, 1.8, }, 
		{{0.405556, }, {0.305556, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_123-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.2, }, 
		{{100, }, {0, }, }, 
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
