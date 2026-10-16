local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_95-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiSaturation_101-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiExtractFrame_101-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGrain_101-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_101-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiExposure_105-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_105-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiFlicker_107-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiSShake_107-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGlow_107-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_107-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_95-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 17.6477476707615,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
    },
    ['LumiSaturation_101-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiExtractFrame_101-effect1'] = {
        ['fps'] = 15,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiGrain_101-effect2'] = {
        ['grainIntensity'] = 1,
        ['intensityR'] = 10,
        ['intensityG'] = 10,
        ['intensityB'] = 10,
        ['scale'] = 0.25,
        ['scaleR'] = 1,
        ['scaleG'] = 1,
        ['scaleB'] = 1,
        ['brightness'] = 0,
        ['contrast'] = 1,
        ['saturation'] = 0.5,
        ['monochrome'] = false,
        ['combine'] = 4,
        ['speed'] = 1,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_101-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiExposure_105-effect0'] = {
        ['channelType'] = 0,
        ['exposure'] = 0,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_105-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiFlicker_107-effect0'] = {
        ['amp0'] = 0.20000000298023,
        ['ampRL'] = 1,
        ['ampRC'] = 0,
        ['frqR'] = 30,
        ['ampW'] = 0,
        ['frqW'] = 5,
        ['phaseWR'] = 0,
        ['phaseWG'] = 0,
        ['phaseWB'] = 0,
        ['ampR'] = 1,
        ['ampG'] = 1,
        ['ampB'] = 1,
        ['brightness'] = 1,
        ['seed'] = 0.12300000339746,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiSShake_107-effect1'] = {
        ['ampRatio'] = 1,
        ['frqRatio'] = 15,
        ['phase0'] = 0,
        ['scale0'] = 1,
        ['blurEnabled'] = false,
        ['blurIntensity'] = 1,
        ['blurQuality'] = 0,
        ['seed'] = 0,
        ['xFill'] = 2,
        ['yFill'] = 2,
        ['xAmpR'] = 100,
        ['xFrqR'] = 3,
        ['xAmp'] = 0,
        ['xFrq'] = 0.5,
        ['xPhase'] = 0,
        ['yAmpR'] = 0,
        ['yFrqR'] = 1,
        ['yAmp'] = 0,
        ['yFrq'] = 0.5,
        ['yPhase'] = 0,
        ['zAmpR'] = 0,
        ['zFrqR'] = 1,
        ['zAmp'] = 0,
        ['zFrq'] = 0.5,
        ['zPhase'] = 0,
        ['wAmpR'] = 0,
        ['wFrqR'] = 1,
        ['wAmp'] = 0,
        ['wFrq'] = 0.5,
        ['wPhase'] = 0,
        ['rAmpRatio'] = 1,
        ['gAmpRatio'] = 1,
        ['bAmpRatio'] = 1,
        ['rPhase'] = 0,
        ['gPhase'] = 0,
        ['bPhase'] = 0,
        ['rgbRnd'] = 0,
        ['rgbFrq'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiGlow_107-effect2'] = {
        ['threshold'] = 0.6,
        ['radius'] = 50,
        ['glowIntensity'] = 1,
        ['blendMode'] = 0,
        ['show'] = 0,
        ['glowColor'] = 0,
        ['colorLooping'] = 0,
        ['colorLoops'] = 1,
        ['colorPhase'] = 0,
        ['midpoint'] = 0.5,
        ['colorA'] = Amaz.Color(1, 1, 1, 1),
        ['colorB'] = Amaz.Color(0, 0, 0, 1),
        ['glowDimensions'] = 0,
        ['quality'] = 0.2,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_107-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_95-trs#opacity#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{0, 1, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_101-trs-blend#opacity#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0, 1, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiExposure_105-effect0#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1, }, 
		{{0, }, {3, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1, 1.033333, }, 
		{{3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSShake_107-effect1#ampRatio#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{1, 1.333333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33, 0, 0.67, 1, }, 
		{1.333333, 1.666667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_107-effect1#frqRatio#number'] =
{
	{
		{0.33, 0, 0.67, 1, }, 
		{1, 1.333333, }, 
		{{15, }, {0.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33, 0, 0.67, 1, }, 
		{1.333333, 1.666667, }, 
		{{0.1, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_107-trs-blend#opacity#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0, 1, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{2, }, 
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
