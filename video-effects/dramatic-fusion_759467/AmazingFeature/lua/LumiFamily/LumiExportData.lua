local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiCCLens_27-effect0'] = {
        ['nodeDuration'] = {{1.43333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.43333333333333, 2}, },
        },
    },
    ['LumiRoundCorner_43-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRoundCorner_46-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_46-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_43-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiRoundCorner_44-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_44-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_27-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.43333333333333, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_39-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiSShake_35-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSoftGlow_35-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_35-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiCCLens_27-effect0'] = {
        ['convergence'] = 100,
        ['radius'] = 100,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiRoundCorner_43-effect0'] = {
        ['radius'] = 58,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiRoundCorner_46-effect0'] = {
        ['radius'] = 58,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiLayer_46-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(501.358251364331, 586.203549896137, 0),
        ['scale'] = Amaz.Vector3f(55, 55, 55),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -77,
        ['yRotation'] = 0,
        ['rotation'] = 137,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_43-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(501.358251364331, 473.203724780744, 0),
        ['scale'] = Amaz.Vector3f(55, 55, 55),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -77,
        ['yRotation'] = 0,
        ['rotation'] = 42,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_44-effect0'] = {
        ['radius'] = 58,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiLayer_44-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(501.358251364331, 371.203857860442, 0),
        ['scale'] = Amaz.Vector3f(55, 55, 55),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -84,
        ['yRotation'] = 0,
        ['rotation'] = 26,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_27-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(500, 500, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 3,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_39-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(500, 500, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiSShake_35-effect0'] = {
        ['ampRatio'] = 0.1,
        ['frqRatio'] = 1.1,
        ['phase0'] = 0,
        ['scale0'] = 1,
        ['blurEnabled'] = false,
        ['blurIntensity'] = 1,
        ['blurQuality'] = 0,
        ['seed'] = 0,
        ['xFill'] = 2,
        ['yFill'] = 2,
        ['xAmpR'] = 192,
        ['xFrqR'] = 1,
        ['xAmp'] = 0,
        ['xFrq'] = 0.5,
        ['xPhase'] = 0,
        ['yAmpR'] = 192,
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
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiSoftGlow_35-effect1'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0.1,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 0.1,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiLayer_35-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiCCLens_27-effect0#convergence#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.5, 1.866667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_46-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.833333, 0.942742, }, 
		{0, 0.3, }, 
		{{501.358251364, 586.203549896, 0, }, {501.358251364, 699.203724781, 0, }, {501.358251364, 633.286942992924, 0, }, {501.358251364, 680.3703679237, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.360289, 0.833333, 0.203272, }, 
		{0.3, 1.366667, }, 
		{{501.358251364, 699.203724781, 0, }, {501.358251364, 743.203724781, 0, }, {501.358251364, 699.203724781, 0, }, {501.358251364, 780.870392719232, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.017664, 0.666667, 1, }, 
		{1.366667, 1.466667, }, 
		{{501.358251364, 743.203724781, 0, }, {501.358251364, 473.203724781, 0, }, {501.358251364, 705.537056842768, 0, }, {501.358251364, 518.203724781, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_46-trs#rotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.945121951, }, 
		{0, 0.3, }, 
		{{137, }, {167, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.390243902, 0.833333333, 0.644444444, }, 
		{0.3, 1.366667, }, 
		{{167, }, {182, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.025, 0.66666667, 1, }, 
		{1.366667, 1.466667, }, 
		{{182, }, {202, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_43-trs-blend#rotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.926829268, }, 
		{0, 0.3, }, 
		{{42, }, {57, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.260162602, 0.833333333, 0.776507937, }, 
		{0.3, 1.366667, }, 
		{{57, }, {72, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.044897959, 0.66666667, 1, }, 
		{1.366667, 1.466667, }, 
		{{72, }, {79, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.833333, 0.948933, }, 
		{0, 0.3, }, 
		{{501.358251364, 371.20385786, 0, }, {501.358251364, 269.2037, 0, }, {501.358251364, 328.703804454238, 0, }, {501.358251364, 286.203720980835, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.45871, 0.833333, 0.013527, }, 
		{0.3, 1.366667, }, 
		{{501.358251364, 269.2037, 0, }, {501.358251364, 252.2037, 0, }, {501.358251364, 269.2037, 0, }, {501.358251364, 218.2037, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.016896, 0.666667, 1, }, 
		{1.366667, 1.466667, }, 
		{{501.358251364, 252.2037, 0, }, {501.358251364, 473.2037, 0, }, {501.358251364, 286.2037, 0, }, {501.358251364, 436.370367938232, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.963414634, }, 
		{0, 0.3, }, 
		{{-84, }, {-91, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.910569106, 0.833333333, -2.133333333, }, 
		{0.3, 1.366667, }, 
		{{-91, }, {-91, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.014285714, 0.66666667, 1, }, 
		{1.366667, 1.466667, }, 
		{{-91, }, {-77, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0, 1.466667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#rotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.908536585, }, 
		{0, 0.3, }, 
		{{26, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.216802168, 0.833333333, 0.828571429, }, 
		{0.3, 1.366667, }, 
		{{10, }, {-14, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.128571429, 0.66666667, 1, }, 
		{1.366667, 1.466667, }, 
		{{-14, }, {-17, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.6, }, 
		{{3, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_39-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.5, 1.6, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSShake_35-effect0#frqRatio#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.333333, 1.4, }, 
		{{1.1, }, {8.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.4, 1.5, }, 
		{{8.1, }, {1.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_35-effect1#exposure#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.333333, 1.433333, }, 
		{{0.1, }, {2.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.433333, 1.566667, }, 
		{{2.3, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.397943842, 0.999999998, }, 
		{1.566667, 1.866667, }, 
		{{10, }, {0, }, }, 
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
