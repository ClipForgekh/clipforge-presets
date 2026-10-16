local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_6302-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_6302-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_6302-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiWarp_6301-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiWarp_6301-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_6301-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_6301-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_6302-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_6302-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 448, 0),
        ['scale'] = Amaz.Vector3f(53.2097750385628, 53.2097750385628, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 30.5772828423382,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
    },
    ['LumiWarp_6301-effect0'] = {
        ['warpStyle'] = 4,
        ['warpAxis'] = 1,
        ['bend'] = -27,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiWarp_6301-effect1'] = {
        ['warpStyle'] = 4,
        ['warpAxis'] = 0,
        ['bend'] = -27,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiRadialBlur_6301-effect2'] = {
        ['blurType'] = 0,
        ['amount'] = 30,
        ['quality'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_6301-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_6302-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 1, }, 
		{0, 0.5, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_6302-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.587476537,0.587476537,0.587476537, 1,1,0.587476537, }, 
		{0, 0.366667, }, 
		{{100, 100, 100, }, {95, 95, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.420461843,0.420461843,0.420461843, 0,0,0.420461843, 0.229604053,0.229604053,0.831668603, 1,1,0.831668603, }, 
		{0.366667, 0.7, }, 
		{{95, 95, 100, }, {110, 110, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.285969733,0.285969733,0.601763439, 0,0,0.601763439, 0,0,0.24, 1,1,0.24, }, 
		{0.7, 1.366667, }, 
		{{110, 110, 100, }, {50, 50, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_6302-trs#opacity#number'] =
{
	{
		{0.112760776, 0.355298103, 0.624453474, 0.866565342, }, 
		{0.7, 1.533333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_6301-effect0#bend#number'] =
{
	{
		{0.7, 0, 0.24, 1, }, 
		{0, 0.366667, }, 
		{{0, }, {-40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.76, 0, 0.24, 1, }, 
		{0.366667, 0.7, }, 
		{{-40, }, {40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.014432061, 0, 0, 1, }, 
		{0.7, 1, }, 
		{{40, }, {-27, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_6301-effect1#bend#number'] =
{
	{
		{0.87, 0, 0.13, 1, }, 
		{0, 0.366667, }, 
		{{0, }, {-10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.87, 0, 0.574532319, 1, }, 
		{0.366667, 0.7, }, 
		{{-10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.014432061, 0, 0, 1, }, 
		{0.7, 1, }, 
		{{0, }, {-27, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_6301-effect2#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.24, 1, }, 
		{0.7, 0.933333, }, 
		{{0, }, {30, }, }, 
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
