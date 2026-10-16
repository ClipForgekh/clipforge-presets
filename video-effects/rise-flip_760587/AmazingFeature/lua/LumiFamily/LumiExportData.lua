local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_562-trs', 'InputTex', 0},
    {'LumiLayer_2048-trs-blend', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_562-trs'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiLayer_2048-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.5, 2}, },
            ['baseTex'] = {{0, 1.53333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_562-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(83.6213176398483, 83.6213176398482, 83.6213176398483),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -90,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 56.7380925879944,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2048-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, -1),
        ['scale'] = Amaz.Vector3f(83.6213176398483, 83.6213176398482, 83.6213176398483),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -150.20408104911,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 56.7380925879944,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_562-trs#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.166667, 1.166667, }, 
		{{540, 721, 0, }, {540, 540, 0, }, {540, 721, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_562-trs#scale#vector'] =
{
	{
		{0.6,0.6,0.6, 0,0,0, 0.4,0.4,0.4, 1,1,1, }, 
		{0, 1, }, 
		{{0, 0, 0, }, {40, 40, 40, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.6,0.6,0.6, 0.6,0.6,0.6, 0.4,0.4,0.4, 0.4,0.4,0.4, }, 
		{1, 1.166667, }, 
		{{40, 40, 40, }, {40, 40, 40, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.6,0.6,0.6, 0,0,0, 0.4,0.4,0.4, 1,1,1, }, 
		{1.166667, 1.833333, }, 
		{{40, 40, 40, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_562-trs#xRotation#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.166667, 1.166667, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_562-trs#yRotation#number'] =
{
	{
		{0.6, 0, 0.833333333, 0.833333333, }, 
		{1.166667, 1.5, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2048-trs-blend#scale#vector'] =
{
	{
		{0.6,0.6,0.6, 0,0,0, 0.4,0.4,0.4, 1,1,1, }, 
		{0, 1, }, 
		{{0, 0, 0, }, {40, 40, 40, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.6,0.6,0.6, 0.6,0.6,0.6, 0.4,0.4,0.4, 0.4,0.4,0.4, }, 
		{1, 1.166667, }, 
		{{40, 40, 40, }, {40, 40, 40, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.6,0.6,0.6, 0,0,0, 0.4,0.4,0.4, 1,1,1, }, 
		{1.166667, 1.833333, }, 
		{{40, 40, 40, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2048-trs-blend#xRotation#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.166667, 1.166667, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2048-trs-blend#yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 1, }, 
		{1.5, 1.833333, }, 
		{{-90, }, {-360, }, }, 
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
