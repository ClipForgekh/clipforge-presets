local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_110-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_110-trs'] = {
        ['nodeDuration'] = {{0, 3.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.06666666666667}, },
        },
    },
    ['LumiTurbulenceDisplacement_111-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.06666666666667}, },
        },
    },
    ['LumiLayer_111-blend'] = {
        ['nodeDuration'] = {{0, 3.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3.06666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_110-trs'] = {
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
    ['LumiTurbulenceDisplacement_111-effect0'] = {
        ['size'] = -0.03676470588235,
        ['quantity'] = 4.42622950819672,
        ['complexity'] = 2.03,
        ['evolution'] = 224,
        ['cycle'] = 100,
        ['offset_x'] = -3.2,
        ['offset_y'] = 0,
        ['type'] = 0,
        ['fix_type'] = 1,
        ['picture_scale'] = 1,
        ['motion_tile_type'] = 0,
        ['qualityType'] = 3,
    },
    ['LumiLayer_111-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_110-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1, 1.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_111-effect0#size#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.133333, }, 
		{{0, }, {-0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.133333, 2.033333, }, 
		{{-0.05, }, {-0.03, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_111-effect0#quantity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2.033333, }, 
		{{5, }, {3.6, }, }, 
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
