local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiCube_800-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['imageFDefault'] = {{0, 2}, },
            ['imageFFront'] = {{0, 2}, },
            ['imageFBack'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_800-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{1.83333333333333, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiCube_800-effect0'] = {
        ['twoSide'] = true,
        ['cullBack'] = false,
        ['translucency'] = false,
        ['separateSurface'] = true,
        ['multiRatio'] = 0,
        ['fov'] = 60,
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0.27448198637215),
        ['scale'] = Amaz.Vector3f(0.078125, 0.921875, 0.078125),
        ['rotateX'] = 83.4980191578932,
        ['rotateY'] = 0,
        ['rotateZ'] = 0,
        ['meshSize'] = Amaz.Vector3f(0.78125, 0.21875, 0.78125),
        ['meshRound'] = 0,
        ['meshCount'] = 2,
        ['fillModeFDefault'] = 0,
        ['wrapModeFDefault'] = 2,
        ['uvCenterFDefault'] = Amaz.Vector2f(0, 1),
        ['uvScaleFDefault'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateFDefault'] = 0,
        ['fillModeBDefault'] = 0,
        ['wrapModeBDefault'] = 2,
        ['uvCenterBDefault'] = Amaz.Vector2f(0, 1),
        ['uvScaleBDefault'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateBDefault'] = 0,
        ['translateFront'] = Amaz.Vector3f(0, 1, 0),
        ['scaleFront'] = Amaz.Vector3f(0.078125, 0.921875, 0.078125),
        ['rotateFront'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFFront'] = 0,
        ['wrapModeFFront'] = 2,
        ['uvCenterFFront'] = Amaz.Vector2f(0, 1),
        ['uvScaleFFront'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateFFront'] = -29.8695483087881,
        ['fillModeBFront'] = 0,
        ['wrapModeBFront'] = 2,
        ['uvCenterBFront'] = Amaz.Vector2f(0, 1),
        ['uvScaleBFront'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateBFront'] = 0,
        ['translateBack'] = Amaz.Vector3f(0, 1, 0),
        ['scaleBack'] = Amaz.Vector3f(0.078125, 0.921875, 0.078125),
        ['rotateBack'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFBack'] = 0,
        ['wrapModeFBack'] = 2,
        ['uvCenterFBack'] = Amaz.Vector2f(0, 1),
        ['uvScaleFBack'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateFBack'] = 29.8695483087881,
        ['fillModeBBack'] = 0,
        ['wrapModeBBack'] = 2,
        ['uvCenterBBack'] = Amaz.Vector2f(0, 1),
        ['uvScaleBBack'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateBBack'] = 0,
        ['translateTop'] = Amaz.Vector3f(0, 1, 0),
        ['scaleTop'] = Amaz.Vector3f(0.078125, 0.921875, 0.078125),
        ['rotateTop'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFTop'] = 0,
        ['wrapModeFTop'] = 2,
        ['uvCenterFTop'] = Amaz.Vector2f(0, 1),
        ['uvScaleFTop'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateFTop'] = 0,
        ['fillModeBTop'] = 0,
        ['wrapModeBTop'] = 2,
        ['uvCenterBTop'] = Amaz.Vector2f(0, 1),
        ['uvScaleBTop'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateBTop'] = 0,
        ['translateBottom'] = Amaz.Vector3f(0, 1, 0),
        ['scaleBottom'] = Amaz.Vector3f(0.078125, 0.921875, 0.078125),
        ['rotateBottom'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFBottom'] = 0,
        ['wrapModeFBottom'] = 2,
        ['uvCenterFBottom'] = Amaz.Vector2f(0, 1),
        ['uvScaleFBottom'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateFBottom'] = 0,
        ['fillModeBBottom'] = 0,
        ['wrapModeBBottom'] = 2,
        ['uvCenterBBottom'] = Amaz.Vector2f(0, 1),
        ['uvScaleBBottom'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateBBottom'] = 0,
        ['translateLeft'] = Amaz.Vector3f(0, 1, 0),
        ['scaleLeft'] = Amaz.Vector3f(0.078125, 0.921875, 0.078125),
        ['rotateLeft'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFLeft'] = 0,
        ['wrapModeFLeft'] = 2,
        ['uvCenterFLeft'] = Amaz.Vector2f(0, 1),
        ['uvScaleFLeft'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateFLeft'] = 0,
        ['fillModeBLeft'] = 0,
        ['wrapModeBLeft'] = 2,
        ['uvCenterBLeft'] = Amaz.Vector2f(0, 1),
        ['uvScaleBLeft'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateBLeft'] = 0,
        ['translateRight'] = Amaz.Vector3f(0, 1, 0),
        ['scaleRight'] = Amaz.Vector3f(0.078125, 0.921875, 0.078125),
        ['rotateRight'] = Amaz.Vector3f(0, 1, 0),
        ['fillModeFRight'] = 0,
        ['wrapModeFRight'] = 2,
        ['uvCenterFRight'] = Amaz.Vector2f(0, 1),
        ['uvScaleFRight'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateFRight'] = 0,
        ['fillModeBRight'] = 0,
        ['wrapModeBRight'] = 2,
        ['uvCenterBRight'] = Amaz.Vector2f(0, 1),
        ['uvScaleBRight'] = Amaz.Vector2f(0.078125, 0.921875),
        ['uvRotateBRight'] = 0,
        ['maskChannel'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiLayer_800-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(640, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiCube_800-effect0#position#vector'] =
{
	{
		{0.28098, 0, 0.151907, 1, }, 
		{0.066667, 1.866667, }, 
		{{0.5, 0.5, -0.77890625, }, {0.5, 0.5, 0.2984375, }, {0.5, 0.5, -0.77890625, }, {0.5, 0.5, 0.2984375, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_800-effect0#rotateX#number'] =
{
	{
		{0.17864106, -1e-8, 0.195767236, 0.999999969, }, 
		{0.066667, 1.866667, }, 
		{{-180, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.0001, 0, 0.58, 0, }, 
		{1.866667, 2.1, }, 
		{{90, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCube_800-effect0#meshRound#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.233333, 1.5, }, 
		{{0.11, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_800-trs-blend#scale#vector'] =
{
	{
		{0.593984948,0.593984948,0.33333333, 4.1e-8,4.1e-8,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.5, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
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
