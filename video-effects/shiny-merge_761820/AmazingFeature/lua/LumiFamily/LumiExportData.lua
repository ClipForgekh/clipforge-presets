local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_55-trs'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16666666666667, 1.03333333333333}, },
        },
    },
    ['LumiLayer_56-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 1.03333333333333}, },
            ['baseTex'] = {{0.16666666666667, 1.03333333333333}, },
        },
    },
    ['LumiLayer_57-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 1.03333333333333}, },
            ['baseTex'] = {{0.16666666666667, 1.03333333333333}, },
        },
    },
    ['LumiLayer_58-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.46666666666667, 1.16666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.03333333333333}, },
        },
    },
    ['LumiLayer_59-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.56666666666667, 1.26666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.16666666666667}, },
        },
    },
    ['LumiLayer_60-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 1.36666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.26666666666667}, },
        },
    },
    ['LumiLayer_61-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.83333333333333, 1.36666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.36666666666667}, },
        },
    },
    ['LumiLayer_62-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 1.36666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.36666666666667}, },
        },
    },
    ['LumiLayer_63-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.6, 1.36666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.36666666666667}, },
        },
    },
    ['LumiLayer_64-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.7, 1.36666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.36666666666667}, },
        },
    },
    ['LumiLayer_65-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.8, 1.36666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.36666666666667}, },
        },
    },
    ['LumiLayer_66-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.9, 1.36666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.36666666666667}, },
        },
    },
    ['LumiLayer_67-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.36666666666667}, },
            ['baseTex'] = {{0.16666666666667, 1.36666666666667}, },
        },
    },
    ['LumiLayer_80-trs-blend'] = {
        ['nodeDuration'] = {{0.16666666666667, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.33333333333333, 2.03333333333333}, },
            ['baseTex'] = {{0.16666666666667, 1.36666666666667}, },
        },
    },
    ['LumiDeepGlow_78-effect0'] = {
        ['nodeDuration'] = {{0.16666666666667, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16666666666667, 2.03333333333333}, },
        },
    },
    ['LumiSShake_78-effect1'] = {
        ['nodeDuration'] = {{0.16666666666667, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16666666666667, 2.03333333333333}, },
        },
    },
    ['LumiBCC_Prism_78-effect2'] = {
        ['nodeDuration'] = {{0.16666666666667, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16666666666667, 2.03333333333333}, },
        },
    },
    ['LumiLayer_78-trs'] = {
        ['nodeDuration'] = {{0.16666666666667, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16666666666667, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_55-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(30.0528772217491, 30.0528772217491, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_56-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(30.0528772217491, 30.0528772217491, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_57-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(458.41288455924, 458.41288455924, 0),
        ['scale'] = Amaz.Vector3f(28.2271649101287, 28.2271649101287, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_58-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(784.758743874434, 785.776798874145, 0),
        ['scale'] = Amaz.Vector3f(23.5614557101943, 23.5614557101943, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_59-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(172.861507164611, 172.861507164611, 0),
        ['scale'] = Amaz.Vector3f(17.2728911723521, 17.2728911723521, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_60-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(878.431773553199, 879.839454250007, 0),
        ['scale'] = Amaz.Vector3f(10.5786128030565, 10.5786128030565, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_61-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(30.0528772217491, 30.0528772217491, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_62-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(30.0528772217491, 30.0528772217491, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_63-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(30.0528772217491, 30.0528772217491, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_64-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(458.41288455924, 458.41288455924, 0),
        ['scale'] = Amaz.Vector3f(28.2271649101287, 28.2271649101287, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_65-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(784.758743874434, 785.776798874145, 0),
        ['scale'] = Amaz.Vector3f(23.5614557101943, 23.5614557101943, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_66-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(172.861507164611, 172.861507164611, 0),
        ['scale'] = Amaz.Vector3f(17.2728911723521, 17.2728911723521, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_67-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(878.431773553199, 879.839454250007, 0),
        ['scale'] = Amaz.Vector3f(10.5786128030565, 10.5786128030565, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_80-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(30.0528772217491, 30.0528772217491, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiDeepGlow_78-effect0'] = {
        ['radius'] = 500,
        ['exposure'] = 0,
        ['threshold'] = 0,
        ['thresholdSmooth'] = 0,
        ['greyScale'] = 0,
        ['blendMode'] = 1,
        ['view'] = 1,
        ['ratio'] = 1,
        ['rotate'] = 0,
        ['ca'] = false,
        ['redOffset'] = 0.0025,
        ['greenOffset'] = 0,
        ['blueOffset'] = -0.0025,
        ['tint'] = false,
        ['tintMode'] = 1,
        ['tintColor'] = Amaz.Color(1, 0, 0, 1),
        ['tintMix'] = 1,
        ['sourceOpacity'] = 1,
        ['unmult'] = true,
        ['gammaCorrect'] = true,
        ['gammaValue'] = 2,
        ['glowIter'] = 8,
        ['stepsMult'] = 1.5,
        ['downSample'] = 0.80000001192093,
        ['quality'] = 0.4,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiSShake_78-effect1'] = {
        ['ampRatio'] = 0,
        ['frqRatio'] = 8,
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
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiBCC_Prism_78-effect2'] = {
        ['globalTransform'] = 200,
        ['smoothness'] = 0.8,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 1,
        ['scaleStart'] = 102,
        ['scaleEnd'] = 98,
        ['angleStart'] = 0,
        ['angleEnd'] = 0,
        ['falloff'] = 0,
        ['offsetStart'] = Amaz.Vector2f(0.5, 0.5),
        ['offsetEnd'] = Amaz.Vector2f(0.5, 0.5),
        ['colorStart'] = Amaz.Color(1, 0, 0, 1),
        ['colorMid'] = Amaz.Color(0, 1, 0, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 1, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_78-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(89.1999999473312, 89.1999999473312, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_55-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.166667, 0.5, }, 
		{{540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.5, 0.833333, }, 
		{{162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_55-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.166667, 0.833333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_56-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.266667, 0.6, }, 
		{{540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.6, 0.933333, }, 
		{{917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_56-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.266667, 0.933333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_57-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.366667, 0.7, }, 
		{{540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.7, 1.033333, }, 
		{{162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_57-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.366667, 1.033333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.466667, 0.8, }, 
		{{540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.8, 1.133333, }, 
		{{917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.466667, 1.133333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.566667, 0.9, }, 
		{{540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.9, 1.233333, }, 
		{{162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.566667, 1.233333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1, }, 
		{{540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.333333, }, 
		{{917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.666667, 1.333333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_62-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.166667, 0.5, }, 
		{{540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.5, 0.833333, }, 
		{{162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_62-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.166667, 0.833333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_63-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.266667, 0.6, }, 
		{{540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.6, 0.933333, }, 
		{{917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_63-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.266667, 0.933333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.366667, 0.7, }, 
		{{540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.7, 1.033333, }, 
		{{162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.366667, 1.033333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_65-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.466667, 0.8, }, 
		{{540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.8, 1.133333, }, 
		{{917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_65-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.466667, 1.133333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.566667, 0.9, }, 
		{{540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.9, 1.233333, }, 
		{{162.285536997, 162.285536997, 0, }, {540, 540, 0, }, {162.285536997, 162.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.566667, 1.233333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1, }, 
		{{540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.333333, }, 
		{{917.714463003, 919.285536997, 0, }, {540, 540, 0, }, {917.714463003, 919.285536997, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.666667, 1.333333, }, 
		{{0, 0, 100, }, {30.052877222, 30.052877222, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_80-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{1.333333, 1.833333, }, 
		{{30.052877222, 30.052877222, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiDeepGlow_78-effect0#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.433333, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.766667, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSShake_78-effect1#ampRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.433333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.766667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBCC_Prism_78-effect2#globalTransform#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.333333, 1.666667, }, 
		{{200, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_78-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 1.333333, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
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
