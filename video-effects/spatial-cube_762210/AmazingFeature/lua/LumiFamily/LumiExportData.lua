local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiCube_77-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiDeepGlow_77-effect1'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiSShake_77-effect2'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_77-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiCube_77-effect0'] = {
        ['twoSide'] = false,
        ['cullBack'] = false,
        ['translucency'] = false,
        ['separateSurface'] = false,
        ['multiRatio'] = 0,
        ['fov'] = 30,
        ['position'] = Amaz.Vector3f(0.5, 0.5, -0.24863668696943),
        ['scale'] = Amaz.Vector3f(0.08874070296003, 0.91125929703997, 0.08874070296003),
        ['rotateX'] = 81.2071505850045,
        ['rotateY'] = 3.69414896274209,
        ['rotateZ'] = 0,
        ['meshSize'] = Amaz.Vector3f(1, 0, 1),
        ['meshRound'] = 0,
        ['meshCount'] = 2,
        ['fillModeFDefault'] = 0,
        ['wrapModeFDefault'] = 2,
        ['uvCenterFDefault'] = Amaz.Vector2f(0, 1),
        ['uvScaleFDefault'] = Amaz.Vector2f(0.09355556500073, 0.90644443499927),
        ['uvRotateFDefault'] = 0,
        ['fillModeBDefault'] = 0,
        ['wrapModeBDefault'] = 2,
        ['uvCenterBDefault'] = Amaz.Vector2f(0, 1),
        ['uvScaleBDefault'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateBDefault'] = 0,
        ['translateFront'] = Amaz.Vector3f(0, 1, 0),
        ['scaleFront'] = Amaz.Vector3f(0.09259259259259, 0.90740740740741, 0.09259259259259),
        ['rotateFront'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFFront'] = 0,
        ['wrapModeFFront'] = 2,
        ['uvCenterFFront'] = Amaz.Vector2f(0, 1),
        ['uvScaleFFront'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateFFront'] = 0,
        ['fillModeBFront'] = 0,
        ['wrapModeBFront'] = 2,
        ['uvCenterBFront'] = Amaz.Vector2f(0, 1),
        ['uvScaleBFront'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateBFront'] = 0,
        ['translateBack'] = Amaz.Vector3f(0, 1, 0),
        ['scaleBack'] = Amaz.Vector3f(0.09259259259259, 0.90740740740741, 0.09259259259259),
        ['rotateBack'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFBack'] = 0,
        ['wrapModeFBack'] = 2,
        ['uvCenterFBack'] = Amaz.Vector2f(0, 1),
        ['uvScaleFBack'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateFBack'] = 0,
        ['fillModeBBack'] = 0,
        ['wrapModeBBack'] = 2,
        ['uvCenterBBack'] = Amaz.Vector2f(0, 1),
        ['uvScaleBBack'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateBBack'] = 0,
        ['translateTop'] = Amaz.Vector3f(0, 1, 0),
        ['scaleTop'] = Amaz.Vector3f(0.09259259259259, 0.90740740740741, 0.09259259259259),
        ['rotateTop'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFTop'] = 0,
        ['wrapModeFTop'] = 2,
        ['uvCenterFTop'] = Amaz.Vector2f(0, 1),
        ['uvScaleFTop'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateFTop'] = 0,
        ['fillModeBTop'] = 0,
        ['wrapModeBTop'] = 2,
        ['uvCenterBTop'] = Amaz.Vector2f(0, 1),
        ['uvScaleBTop'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateBTop'] = 0,
        ['translateBottom'] = Amaz.Vector3f(0, 1, 0),
        ['scaleBottom'] = Amaz.Vector3f(0.09259259259259, 0.90740740740741, 0.09259259259259),
        ['rotateBottom'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFBottom'] = 0,
        ['wrapModeFBottom'] = 2,
        ['uvCenterFBottom'] = Amaz.Vector2f(0, 1),
        ['uvScaleFBottom'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateFBottom'] = 0,
        ['fillModeBBottom'] = 0,
        ['wrapModeBBottom'] = 2,
        ['uvCenterBBottom'] = Amaz.Vector2f(0, 1),
        ['uvScaleBBottom'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateBBottom'] = 0,
        ['translateLeft'] = Amaz.Vector3f(0, 1, 0),
        ['scaleLeft'] = Amaz.Vector3f(0.09259259259259, 0.90740740740741, 0.09259259259259),
        ['rotateLeft'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFLeft'] = 0,
        ['wrapModeFLeft'] = 2,
        ['uvCenterFLeft'] = Amaz.Vector2f(0, 1),
        ['uvScaleFLeft'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateFLeft'] = 0,
        ['fillModeBLeft'] = 0,
        ['wrapModeBLeft'] = 2,
        ['uvCenterBLeft'] = Amaz.Vector2f(0, 1),
        ['uvScaleBLeft'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateBLeft'] = 0,
        ['translateRight'] = Amaz.Vector3f(0, 1, 0),
        ['scaleRight'] = Amaz.Vector3f(0.09259259259259, 0.90740740740741, 0.09259259259259),
        ['rotateRight'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFRight'] = 0,
        ['wrapModeFRight'] = 2,
        ['uvCenterFRight'] = Amaz.Vector2f(0, 1),
        ['uvScaleFRight'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateFRight'] = 0,
        ['fillModeBRight'] = 0,
        ['wrapModeBRight'] = 2,
        ['uvCenterBRight'] = Amaz.Vector2f(0, 1),
        ['uvScaleBRight'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateBRight'] = 0,
        ['maskChannel'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiDeepGlow_77-effect1'] = {
        ['radius'] = 300,
        ['exposure'] = 0.72873799674893,
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
    ['LumiSShake_77-effect2'] = {
        ['ampRatio'] = 0,
        ['frqRatio'] = 10,
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
    ['LumiLayer_77-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiCube_77-effect0#position#vector'] =
{
	{
		{0.306242, 0, 0.647653, 1, }, 
		{0.066667, 0.4, }, 
		{{0.5, 0.5, -2.39074074074074, }, {0.5, 0.5, -0.96481481481481, }, {0.5, 0.5, -2.39074074074074, }, {0.5, 0.5, -0.96481481481481, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.330378, 0, 0.67037, 0.867992, }, 
		{0.4, 0.733333, }, 
		{{0.5, 0.5, -0.96481481481481, }, {0.5, 0.5, -2.18129795124259, }, {0.5, 0.5, -0.96481481481481, }, {0.5, 0.5, -2.18129795124259, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.210933, 0.094557, 0.60727, 0.975467, }, 
		{0.733333, 1.066667, }, 
		{{0.5, 0.5, -2.18129795124259, }, {0.5, 0.5, -1.09454318655741, }, {0.5, 0.5, -2.18129795124259, }, {0.5, 0.5, -1.09454318655741, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.407719, 0.021354, 0.81155, 1, }, 
		{1.066667, 1.4, }, 
		{{0.5, 0.5, -1.09454318655741, }, {0.5, 0.5, -2.39074074074074, }, {0.5, 0.5, -1.09454318655741, }, {0.5, 0.5, -2.39074074074074, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.4, 1.9, }, 
		{{0.5, 0.5, -2.39074074074074, }, {0.5, 0.5, 0, }, {0.5, 0.5, -2.39074074074074, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#scale#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.4, 1.9, }, 
		{{0.05555555555556, 0.94444444444444, 0.05555555555556, }, {0.09259259259259, 0.90740740740741, 0.09259259259259, }, {0.05555555555556, 0.94444444444444, 0.05555555555556, }, {0.09259259259259, 0.90740740740741, 0.09259259259259, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#rotateX#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.4, 0.733333, }, 
		{{12, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.733333, 1.066667, }, 
		{{1, }, {35.453372, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.666666665, 1, }, 
		{1.066667, 1.4, }, 
		{{35.453372, }, {5.453372, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.333333335, 0, 0.66666667, 1, }, 
		{1.4, 1.9, }, 
		{{5.453372, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#rotateY#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.4, 0.733333, }, 
		{{10, }, {-18, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.733333, 1.066667, }, 
		{{-18, }, {-10.013115, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.066667, 1.4, }, 
		{{-10.013115, }, {35.520663, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.4, 1.9, }, 
		{{35.520663, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#uvScaleFDefault#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.4, 1.9, }, 
		{{0.10185185185185, 0.89814814814815, }, {0.09259259259259, 0.90740740740741, }, {0.10185185185185, 0.89814814814815, }, {0.09259259259259, 0.90740740740741, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#translateFront#vector'] =
{
	{
		{0.333333, 0, 0.833333, 1, }, 
		{0.733333, 1.066667, }, 
		{{3.86851851851852, 1, 0, }, {1.96388888888889, 1, 0, }, {3.86851851851852, 1, 0, }, {1.96388888888889, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.066667, 1.4, }, 
		{{1.96388888888889, 1, 0, }, {0, 1, 0, }, {1.96388888888889, 1, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#translateBack#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.066667, 0.4, }, 
		{{0, -3.97222222222222, 0, }, {0, 1, 0, }, {0, -3.97222222222222, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#translateTop#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.733333, 1.066667, }, 
		{{0, 1, 1.63703703703704, }, {0, 1, 0, }, {0, 1, 1.63703703703704, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#translateBottom#vector'] =
{
	{
		{0.333333, 0, 0.833333, 1, }, 
		{0.4, 0.733333, }, 
		{{0, 1, 2.71851851851852, }, {0, 1, 1.91851851851852, }, {0, 1, 2.71851851851852, }, {0, 1, 1.91851851851852, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.733333, 1.066667, }, 
		{{0, 1, 1.91851851851852, }, {0, 1, 0, }, {0, 1, 1.91851851851852, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#translateLeft#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.4, 0.733333, }, 
		{{0, -2.76851851851852, 0, }, {0, 1, 0, }, {0, -2.76851851851852, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_77-effect0#translateRight#vector'] =
{
	{
		{0.333333, 0, 0.833333, 1, }, 
		{0.066667, 0.4, }, 
		{{0, 3.72222222222222, 0, }, {0, 3.46018518518519, 0, }, {0, 3.72222222222222, 0, }, {0, 3.46018518518519, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.4, 0.733333, }, 
		{{0, 3.46018518518519, 0, }, {0, 1, 0, }, {0, 3.46018518518519, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiDeepGlow_77-effect1#exposure#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.066667, 0.4, }, 
		{{0, }, {0.85, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.4, 1.3, }, 
		{{0.85, }, {0.85, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.666666669, 1, }, 
		{1.3, 1.4, }, 
		{{0.85, }, {1.25, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.666666669, 0, }, 
		{1.4, 1.666667, }, 
		{{1.25, }, {1.25, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.666667, 1.966667, }, 
		{{1.25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_77-effect2#ampRatio#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.366667, 0.4, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.4, 0.5, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.5, 0.7, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.7, 0.733333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.733333, 0.833333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.833333, 1.033333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.033333, 1.066667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.066667, 1.166667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{1.166667, 1.366667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.366667, 1.4, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.4, 1.666667, }, 
		{{1, }, {0, }, }, 
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
