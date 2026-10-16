local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_107-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_107-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_108-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_108-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_107-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_107-trs'] = {
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
        ['active_cam_fovx'] = 24.1172665738697,
        ['compositeSize'] = Amaz.Vector2f(1080, 1920),
        ['layerSize'] = Amaz.Vector2f(1080, 1920),
        ['mirrorEdge'] = false,
    },
    ['LumiRadialBlur_108-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiLayer_108-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_107-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.133333, 0.533333, }, 
		{{0, }, {36, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_107-trs#position#vector'] =
{
	{
		{0.665479, 0, 0.666667, 1, }, 
		{0.8, 1.833333, }, 
		{{540, 960, 0, }, {540, 2009.951259601, -1343.876328937, }, {540, 1134.99188232422, -223.979385375977, }, {540, 1834.95937727678, -1119.89694356102, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_107-trs#scale#vector'] =
{
	{
		{0.854051601,0.854051601,0.854051601, -5.33e-7,-5.33e-7,-5.33e-7, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.033333, 0.8, }, 
		{{100, 100, 100, }, {62, 62, 62, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.665478504,0.665478504,0.665478504, 0.00000408,0.00000408,0.00000408, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.8, 1.833333, }, 
		{{62, 62, 62, }, {67, 67, 67, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_107-trs#xRotation#number'] =
{
	{
		{0.665478504, -2.4e-7, 0.66666667, 1, }, 
		{0.8, 1.433333, }, 
		{{0, }, {-52, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_108-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.133333, 0.433333, }, 
		{{0, }, {14, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.433333, 0.8, }, 
		{{14, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 1.2, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.2, 1.833333, }, 
		{{0, }, {14, }, }, 
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
