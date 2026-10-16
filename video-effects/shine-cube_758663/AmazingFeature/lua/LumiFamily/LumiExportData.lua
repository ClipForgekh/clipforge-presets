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
    ['Lumi3DShape_30-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSShake_30-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGodRay_30-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGlow_30-effect3'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_30-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
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
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 360, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
    },
    ['Lumi3DShape_30-effect0'] = {
        ['fov'] = 22.6,
        ['meshType'] = 3,
        ['meshSize_x'] = 2,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 30,
        ['meshResY'] = 30,
        ['meshResZ'] = 30,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = false,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 0,
        ['Position_z'] = -6,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 45,
        ['Rotate_y'] = 1080,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 2,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 2,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
        ['bendZbyX'] = 0,
        ['bendZbyY'] = 0,
        ['bendYbyX'] = 0,
        ['bendYbyZ'] = 0,
        ['bendXbyY'] = 0,
        ['bendXbyZ'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiSShake_30-effect1'] = {
        ['ampRatio'] = 0.5,
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiGodRay_30-effect2'] = {
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['range'] = 0.5,
        ['smoothness'] = 0,
        ['weightDecay'] = 1,
        ['colorDecay'] = 1,
        ['borderType'] = 0,
        ['lightSource'] = 0,
        ['brightness'] = 0.1,
        ['grayscaleCorrection'] = 0,
        ['useAngle'] = false,
        ['angleRange'] = 360,
        ['angleType'] = 0,
        ['angle'] = 0,
        ['directionPoint'] = Amaz.Vector2f(0.5, 0.5),
        ['scaleType'] = 4,
        ['quality'] = 10,
        ['colorType'] = 0,
        ['lightColor'] = Amaz.Color(1, 1, 1, 1),
        ['blendMode'] = 0,
        ['displayRayOnly'] = false,
        ['dither'] = 0,
        ['noiseIntensity'] = 0,
        ['inverseGammaCorrection'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiGlow_30-effect3'] = {
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiLayer_30-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_27-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.92, 1.96, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_30-effect0#fov#number'] =
{
	{
		{0.33333333, 0, 0.217118212, 0.999999434, }, 
		{0, 0.6, }, 
		{{22.6, }, {60, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.217118212, -0.0000381, }, 
		{0.6, 1.68, }, 
		{{60, }, {60, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.68, 1.96, }, 
		{{60, }, {22.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_30-effect0#Rotate_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.6, }, 
		{{90, }, {45, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_30-effect0#Rotate_y#number'] =
{
	{
		{0.33333333, 0, 0.239999963, 0.999999838, }, 
		{0, 0.6, }, 
		{{0, }, {127, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.6, 1.12, }, 
		{{127, }, {127, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.793987175, 3.2e-8, 0.833333333, 1, }, 
		{1.12, 1.96, }, 
		{{127, }, {1080, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_30-effect1#ampRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 1.12, }, 
		{{0, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGodRay_30-effect2#range#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.08, 1.28, }, 
		{{0, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlow_30-effect3#threshold#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.08, 1.28, }, 
		{{1, }, {0.6, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlow_30-effect3#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.08, 1.28, }, 
		{{0, }, {50, }, }, 
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
