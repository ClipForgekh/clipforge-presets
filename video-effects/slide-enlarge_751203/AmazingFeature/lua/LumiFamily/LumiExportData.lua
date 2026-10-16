local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_73-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_73-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_106-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_106-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_73-effect0'] = {
        ['radius'] = 36,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_73-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 960, 0),
        ['position'] = Amaz.Vector3f(540, 2009.95125960117, -1343.8763289371),
        ['scale'] = Amaz.Vector3f(67, 67, 67),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -52,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 24.1172665738697,
        ['compositeSize'] = Amaz.Vector2f(1080, 1920),
        ['layerSize'] = Amaz.Vector2f(1080, 1920),
        ['mirrorEdge'] = false,
    },
    ['LumiRadialBlur_106-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 14,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiLayer_106-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_73-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.266667, 1.666667, }, 
		{{36, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_73-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.334521, 1, }, 
		{0, 1.033333, }, 
		{{540, 2009.951259601, -1343.876328937, }, {540, 960, 0, }, {540, 1834.95937727678, -1119.89694356102, }, {540, 1134.99188232422, -223.979385375977, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_73-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.334521496,0.334521496,0.334521496, 0.99999592,0.99999592,0.99999592, }, 
		{0, 1.033333, }, 
		{{67, 67, 67, }, {62, 62, 62, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.145948399,0.145948399,0.145948399, 1.000000556,1.000000556,1.000000556, }, 
		{1.033333, 1.833333, }, 
		{{62, 62, 62, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_73-trs#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.334521496, 1.00000024, }, 
		{0.4, 1.033333, }, 
		{{-52, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_106-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.633333, }, 
		{{14, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.633333, 1.033333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.033333, 1.366667, }, 
		{{0, }, {14, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.366667, 1.666667, }, 
		{{14, }, {0, }, }, 
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
