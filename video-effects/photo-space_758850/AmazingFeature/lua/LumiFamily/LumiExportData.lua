local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiCube_49-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_49-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiBCC_Prism_52-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiCCLens_52-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_52-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_50-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.92, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiCube_49-effect0'] = {
        ['twoSide'] = false,
        ['cullBack'] = false,
        ['translucency'] = false,
        ['separateSurface'] = false,
        ['multiRatio'] = 0,
        ['fov'] = 60,
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0.52361111111111),
        ['scale'] = Amaz.Vector3f(0.1, 0.9, 0.1),
        ['rotateX'] = 0,
        ['rotateY'] = 0,
        ['rotateZ'] = 15.5283791676829,
        ['meshSize'] = Amaz.Vector3f(1, 0, 1),
        ['meshRound'] = 0,
        ['meshCount'] = 2,
        ['fillModeFDefault'] = 0,
        ['wrapModeFDefault'] = 2,
        ['uvCenterFDefault'] = Amaz.Vector2f(0, 1),
        ['uvScaleFDefault'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateFDefault'] = 0,
        ['fillModeBDefault'] = 0,
        ['wrapModeBDefault'] = 2,
        ['uvCenterBDefault'] = Amaz.Vector2f(0, 1),
        ['uvScaleBDefault'] = Amaz.Vector2f(0.1, 0.9),
        ['uvRotateBDefault'] = 0,
        ['translateFront'] = Amaz.Vector3f(0, 1, -1.49444444444444),
        ['scaleFront'] = Amaz.Vector3f(0.1, 0.9, 0.1),
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
        ['translateBack'] = Amaz.Vector3f(0, 1, 1.37916666666667),
        ['scaleBack'] = Amaz.Vector3f(0.1, 0.9, 0.1),
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
        ['translateTop'] = Amaz.Vector3f(0, 0.96404718474527, 0),
        ['scaleTop'] = Amaz.Vector3f(0.1, 0.9, 0.1),
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
        ['scaleBottom'] = Amaz.Vector3f(0.1, 0.9, 0.1),
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
        ['translateLeft'] = Amaz.Vector3f(0.00527059270811, 1, 0),
        ['scaleLeft'] = Amaz.Vector3f(0.1, 0.9, 0.1),
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
        ['translateRight'] = Amaz.Vector3f(-0.05403080451283, 1, 0),
        ['scaleRight'] = Amaz.Vector3f(0.1, 0.9, 0.1),
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiLayer_49-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_52-effect0'] = {
        ['globalTransform'] = 100,
        ['smoothness'] = 1,
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiCCLens_52-effect1'] = {
        ['convergence'] = -73,
        ['radius'] = 500,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiLayer_52-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_50-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiCube_49-effect0#rotateZ#number'] =
{
	{
		{0.219473265, -4e-9, 0, 1.000000018, }, 
		{0, 1.12, }, 
		{{45, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{1, -2.6e-8, 0.758659179, 1.000000006, }, 
		{1.12, 1.92, }, 
		{{15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCube_49-effect0#translateFront#vector'] =
{
	{
		{0.156425, 0, 0, 1, }, 
		{0, 0.8, }, 
		{{0, 1, 1.45138888888889, }, {0, 1, -1.49444444444444, }, {0, 1, 1.45138888888889, }, {0, 1, -1.49444444444444, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0.666667, 0.666667, }, 
		{0.8, 0.92, }, 
		{{0, 1, -1.49444444444444, }, {0, 1, -1.49444444444444, }, {0, 1, -1.49444444444444, }, {0, 1, -1.49444444444444, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0, 0.844972, 1, }, 
		{0.92, 1.88, }, 
		{{0, 1, -1.49444444444444, }, {0, 1, 0.15416666666667, }, {0, 1, -1.49444444444444, }, {0, 1, 0.15416666666667, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_49-effect0#translateBack#vector'] =
{
	{
		{0.156425, 0, 0, 1, }, 
		{0, 0.8, }, 
		{{0, 1, -2.4375, }, {0, 1, 1.37916666666667, }, {0, 1, -2.4375, }, {0, 1, 1.37916666666667, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0.666667, 0.666667, }, 
		{0.8, 0.92, }, 
		{{0, 1, 1.37916666666667, }, {0, 1, 1.37916666666667, }, {0, 1, 1.37916666666667, }, {0, 1, 1.37916666666667, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0, 0.844972, 1, }, 
		{0.92, 1.88, }, 
		{{0, 1, 1.37916666666667, }, {0, 1, -0.00277777777778, }, {0, 1, 1.37916666666667, }, {0, 1, -0.00277777777778, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_49-effect0#translateTop#vector'] =
{
	{
		{0.143017, 0, 0.159776, 1, }, 
		{0.24, 1.04, }, 
		{{0, -0.70277777777778, 0, }, {0, 1, 0, }, {0, -0.70277777777778, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.0001, 0.0001, 0.666667, 0.666667, }, 
		{1.04, 1.16, }, 
		{{0, 1, 0, }, {0, 1, 0, }, {0, 1, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0, 0.824333, 1, }, 
		{1.16, 1.88, }, 
		{{0, 1, 0, }, {0, -0.70277777777778, 0, }, {0, 1, 0, }, {0, -0.70277777777778, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_49-effect0#translateBottom#vector'] =
{
	{
		{0.135754, 0, 0, 1, }, 
		{0.08, 0.88, }, 
		{{0, 2.70277777777778, 0, }, {0, 1, 0, }, {0, 2.70277777777778, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0.666667, 0.666667, }, 
		{0.88, 1, }, 
		{{0, 1, 0, }, {0, 1, 0, }, {0, 1, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0, 0.899441, 1, }, 
		{1, 1.88, }, 
		{{0, 1, 0, }, {0, 2.70277777777778, 0, }, {0, 1, 0, }, {0, 2.70277777777778, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_49-effect0#translateLeft#vector'] =
{
	{
		{0.144134, 0, 0, 1, }, 
		{0.16, 0.96, }, 
		{{1.49444444444444, 1, 0, }, {0, 1, 0, }, {1.49444444444444, 1, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0.9999, 0.9999, }, 
		{0.96, 1.08, }, 
		{{0, 1, 0, }, {0, 1, 0, }, {0, 1, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0, 0.797207, 1, }, 
		{1.08, 1.88, }, 
		{{0, 1, 0, }, {1.49444444444444, 1, 0, }, {0, 1, 0, }, {1.49444444444444, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_49-effect0#translateRight#vector'] =
{
	{
		{0.144134, 0, 0, 1, }, 
		{0.32, 1.12, }, 
		{{-1.49444444444444, 1, 0, }, {0, 1, 0, }, {-1.49444444444444, 1, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0.9999, 0.9999, }, 
		{1.12, 1.24, }, 
		{{0, 1, 0, }, {0, 1, 0, }, {0, 1, 0, }, {0, 1, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0, 0.829842, 1, }, 
		{1.24, 1.88, }, 
		{{0, 1, 0, }, {-1.49444444444444, 1, 0, }, {0, 1, 0, }, {-1.49444444444444, 1, 0, }, }, 
		{6413, }, 
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
