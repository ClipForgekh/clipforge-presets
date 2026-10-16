local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRoundCorner_70-effect0'] = {
        ['nodeDuration'] = {{0, 1.33466800133467}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_70-effect1'] = {
        ['nodeDuration'] = {{0, 1.33466800133467}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.33466800133467}, },
        },
    },
    ['LumiGaussianBlur_70-effect2'] = {
        ['nodeDuration'] = {{0, 1.33466800133467}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.33466800133467}, },
        },
    },
    ['LumiLayer_70-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.33466800133467}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 542.349322174566, 0),
        ['scale'] = Amaz.Vector3f(101.301353784431, 101.301353784431, 100.117634774012),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiRoundCorner_70-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 0,
        ['fadeType'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRadialBlur_70-effect1'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiGaussianBlur_70-effect2'] = {
        ['blurIntensity'] = 2.71739837398374,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_70-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_27-trs#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0, 0.56722, }, 
		{{960, -68, 0, }, {960, 646, 0, }, {960, -68, 0, }, {960, 646, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.56722, 1.334668, }, 
		{{960, 646, 0, }, {960, 540, 0, }, {960, 646, 0, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0,0,0, 0.999999919,0.999999919,0.999999838, }, 
		{0, 0.56722, }, 
		{{355, 355, 202.857142857, }, {158.719290833, 158.719290833, 105.307880601, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.56722, 1.334668, }, 
		{{158.719290833, 158.719290833, 105.307880601, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#xRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.334668, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_27-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.166829, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRoundCorner_70-effect0#radius#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.56722, 1.167839, }, 
		{{256, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRoundCorner_70-effect0#fade#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.56722, 1.167839, }, 
		{{96, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRadialBlur_70-effect1#amount#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 1.23457, }, 
		{{-73, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_70-effect2#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.83418, 1.334668, }, 
		{{20, }, {0, }, }, 
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
