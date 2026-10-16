local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_1037-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_1037-trs'] = {
        ['nodeDuration'] = {{0, 3.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.6}, },
        },
    },
    ['LumiTurbulenceDisplacement_1038-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.6}, },
        },
    },
    ['LumiLayer_1038-blend'] = {
        ['nodeDuration'] = {{0, 3.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3.6}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_1037-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 960, 0),
        ['position'] = Amaz.Vector3f(540, 960, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1920),
        ['layerSize'] = Amaz.Vector2f(1080, 1920),
        ['mirrorEdge'] = false,
    },
    ['LumiTurbulenceDisplacement_1038-effect0'] = {
        ['size'] = -0.03352941176471,
        ['quantity'] = 1.2877358490566,
        ['complexity'] = 1,
        ['evolution'] = -59,
        ['cycle'] = 100,
        ['offset_x'] = 0.39583333333333,
        ['offset_y'] = 0,
        ['type'] = 0,
        ['fix_type'] = 1,
        ['picture_scale'] = 1,
        ['motion_tile_type'] = 0,
        ['qualityType'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_1038-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_1037-trs#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.866667, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_1038-effect0#size#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.7, }, 
		{{0, }, {-0.09, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.7, 1.966667, }, 
		{{-0.09, }, {-0.11, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_1038-effect0#quantity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.766667, }, 
		{{1.32, }, {1.23, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.766667, 1.966667, }, 
		{{1.23, }, {1.23, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_1038-effect0#offset_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.6, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.6, 1.966667, }, 
		{{1, }, {1.1, }, }, 
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
