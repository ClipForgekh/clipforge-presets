local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_1502-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_1502-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_1501-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBrightness_1501-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1501-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_1502-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(336, 252, 0),
        ['position'] = Amaz.Vector3f(336, 627, 0),
        ['scale'] = Amaz.Vector3f(49, 49, 49),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 180,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(672, 504),
        ['layerSize'] = Amaz.Vector2f(672, 504),
        ['mirrorEdge'] = false,
    },
    ['LumiRadialBlur_1501-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(672, 504),
    },
    ['LumiBrightness_1501-effect1'] = {
        ['brightnessIntensity'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(672, 504),
    },
    ['LumiLayer_1501-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_1502-trs#position#vector'] =
{
	{
		{0.45, 0, 0, 1, }, 
		{0.033333, 1.966667, }, 
		{{336, 627, 0, }, {336, 252, 0, }, {336, 564.5, 0, }, {336, 314.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1502-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0,0,0, 1,1,1, }, 
		{0.033333, 1.966667, }, 
		{{49, 49, 49, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1502-trs#xRotation#number'] =
{
	{
		{0.166666667, 0, 0, 0, }, 
		{0.033333, 1.966667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1502-trs#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.036600872, 1, }, 
		{0.033333, 1.966667, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1502-trs#rotation#number'] =
{
	{
		{0.166666667, 0, 0, 0, }, 
		{0.033333, 1.966667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_1501-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.865805416, }, 
		{0.033333, 0.171029, }, 
		{{0, }, {39, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.415561892, 0, 0.392191793, 1, }, 
		{0.171029, 0.566667, }, 
		{{39, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.565731317, 0, 0.39, 1, }, 
		{0.566667, 1.033333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{1.033333, 1.966667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBrightness_1501-effect1#brightnessIntensity#number'] =
{
	{
		{0.76, 0, 0.833333333, 0.833333333, }, 
		{0.342025, 0.733333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.733333, 1.233333, }, 
		{{1, }, {0.35, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.233333, 1.966667, }, 
		{{0.35, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = true
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
