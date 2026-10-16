local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_706-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_715-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_715-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiDistortBlur_735-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGlitchSignal_735-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_735-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_706-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
    },
    ['LumiRadialBlur_715-effect0'] = {
        ['blurType'] = 1,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 1,
    },
    ['LumiLayer_715-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiDistortBlur_735-effect0'] = {
        ['blurAmount'] = 0,
        ['blurInterval'] = 0.20000000298023,
        ['warpAmount'] = 0,
        ['rotateWarpDir'] = 360,
        ['blurLens'] = 1000,
        ['stride'] = 0.06,
        ['amountRelX'] = 10,
        ['amountRelY'] = 10,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['quality'] = 1,
    },
    ['LumiGlitchSignal_735-effect1'] = {
        ['lowQuality'] = 0.8,
        ['filterIntensity'] = 1.2,
        ['sharpen'] = 0.01,
        ['sharpenSize'] = 5,
        ['chromaNoise'] = 0,
        ['hueNoise'] = 0,
        ['chromaloss'] = 0,
        ['moireNoise'] = 0,
        ['moireSize'] = 0.5,
        ['moireSpeed'] = 0,
        ['randomSeed'] = 0,
        ['destruction'] = true,
        ['signalStrength'] = 1,
        ['d2dIntensity'] = 3,
    },
    ['LumiLayer_735-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_706-trs#scale#vector'] =
{
	{
		{1,1,1, -1.96e-7,-1.96e-7,1, 0.387646068,0.387646068,0.387646068, 0.711996744,0.711996744,0.387646068, }, 
		{0.1, 1.1, }, 
		{{0, 0, 100, }, {110, 110, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.240713298,0.240713298,0.240713298, -1.03778266,-1.03778266,0.240713298, 0.563356869,0.563356869,0.563356869, 0.999999503,0.999999503,0.563356869, }, 
		{1.1, 1.933333, }, 
		{{110, 110, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_715-effect0#amount#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.233333, 1.7, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDistortBlur_735-effect0#blurAmount#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.1, 1.866667, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDistortBlur_735-effect0#rotateWarpDir#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.7, 1.866667, }, 
		{{0, }, {360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_735-trs-blend#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.5, 1.9, }, 
		{{100, }, {0, }, }, 
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
