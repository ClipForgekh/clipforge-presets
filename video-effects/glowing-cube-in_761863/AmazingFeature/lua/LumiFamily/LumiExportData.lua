local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiCube_204-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['imageFDefault'] = {{0, 2}, },
            ['imageFFront'] = {{0, 2}, },
            ['imageFBack'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_204-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{1.83333333333333, 2}, },
        },
    },
    ['LumiMotionBlur2D_1715-effect0'] = {
        ['nodeDuration'] = {{1.4, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiDirectionalBlurs_1715-effect1'] = {
        ['nodeDuration'] = {{1.4, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.4, 2.03333333333333}, },
        },
    },
    ['LumiExposure_1715-effect2'] = {
        ['nodeDuration'] = {{1.4, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.4, 2.03333333333333}, },
        },
    },
    ['LumiLayer_1715-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.4, 2.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiDeepGlow_1717-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_1717-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiCube_204-effect0'] = {
        ['twoSide'] = true,
        ['cullBack'] = false,
        ['translucency'] = false,
        ['separateSurface'] = true,
        ['multiRatio'] = 0,
        ['fov'] = 60,
        ['position'] = Amaz.Vector3f(0.5, 0.5, -0.77890625),
        ['scale'] = Amaz.Vector3f(0.078125, 0.921875, 0.078125),
        ['rotateX'] = -180,
        ['rotateY'] = 0,
        ['rotateZ'] = 0,
        ['meshSize'] = Amaz.Vector3f(0.78125, 0.21875, 0.78125),
        ['meshRound'] = 0.11,
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
    ['LumiLayer_204-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(640, 640, 0),
        ['scale'] = Amaz.Vector3f(0, 0, 100),
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
    ['LumiMotionBlur2D_1715-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiDirectionalBlurs_1715-effect1'] = {
        ['blurIntensity'] = 370,
        ['angle'] = 90,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiExposure_1715-effect2'] = {
        ['channelType'] = 0,
        ['exposure'] = 3,
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
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiLayer_1715-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiDeepGlow_1717-effect0'] = {
        ['radius'] = 100,
        ['exposure'] = 1.04999995231628,
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
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiLayer_1717-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiCube_204-effect0#position#vector'] =
{
	{
		{0.28098, 0, 0.151907, 1, }, 
		{0.066667, 1.866667, }, 
		{{0.5, 0.5, -0.77890625, }, {0.5, 0.5, 0.2984375, }, {0.5, 0.5, -0.77890625, }, {0.5, 0.5, 0.2984375, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiCube_204-effect0#rotateX#number'] =
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
    ['LumiCube_204-effect0#meshRound#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.233333, 1.5, }, 
		{{0.11, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_204-trs-blend#scale#vector'] =
{
	{
		{0.593984948,0.593984948,0.33333333, 4.1e-8,4.1e-8,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.5, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1715-effect0#ae_pre_position#vector'] =
{
	{
		{0.333333, 0.304747, 0.666667, 0.649392, }, 
		{1.46666633333333, 1.52158233333333, }, 
		{{0.5, 0.5, }, {0.4258210361, 0.46727091073984, }, {0.48763683959842, 0.49454515166581, }, {0.42176290340683, 0.45594160780305, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.310374, 0.666667, 0.706904, }, 
		{1.52158233333333, 1.60390633333333, }, 
		{{0.4258210361, 0.46727091073984, }, {0.52434879541406, 0.56797581911094, }, {0.42987916879317, 0.47860021367663, }, {0.5083993718029, 0.56864718594595, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.3862, 0.666667, 0.739232, }, 
		{1.60390633333333, 1.68626333333333, }, 
		{{0.52434879541406, 0.56797581911094, }, {0.5215175747875, 0.46324270963672, }, {0.54029821902522, 0.56730445227593, }, {0.52434882521665, 0.47113125994805, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.4619, 0.666667, 0.734701, }, 
		{1.68626333333333, 1.76861933333333, }, 
		{{0.5215175747875, 0.46324270963672, }, {0.50736129283906, 0.52064451575312, }, {0.51868632435835, 0.45535415932539, }, {0.51245755963028, 0.51611279435489, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.448341, 0.666667, 0.729697, }, 
		{1.76861933333333, 1.85097633333333, }, 
		{{0.50736129283906, 0.52064451575312, }, {0.49093997478516, 0.49043303728125, }, {0.50226502604784, 0.52517623715135, }, {0.49173282580481, 0.49233058095, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.434699, 0.666667, 0.725645, }, 
		{1.85097633333333, 1.93333333333333, }, 
		{{0.49093997478516, 0.49043303728125, }, {0.50260418653516, 0.50925925374062, }, {0.49014712376551, 0.4885354936125, }, {0.50109418230159, 0.50843636198, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.322175, 1, 0.666667, 0.545234, }, 
		{1.93333333333333, 2.13401733333333, }, 
		{{0.50260418653516, 0.50925925374062, }, {0.5, 0.49537038803125, }, {0.50411419076873, 0.51008214550124, }, {0.50043403110467, 0.49691359698797, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.628348, 0.666667, 1, }, 
		{2.13401733333333, 2.23411433333333, }, 
		{{0.5, 0.49537038803125, }, {0.5, 0.5, }, {0.49956596889533, 0.49382717907453, }, {0.5, 0.49922839798965, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_1715-effect0#position#vector'] =
{
	{
		{0.333333, 0.304747, 0.666667, 0.649392, }, 
		{1.433333, 1.488249, }, 
		{{0.5, 0.5, }, {0.4258210361, 0.46727091073984, }, {0.48763683959842, 0.49454515166581, }, {0.42176290340683, 0.45594160780305, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.310374, 0.666667, 0.706904, }, 
		{1.488249, 1.570573, }, 
		{{0.4258210361, 0.46727091073984, }, {0.52434879541406, 0.56797581911094, }, {0.42987916879317, 0.47860021367664, }, {0.5083993718029, 0.56864718594595, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.3862, 0.666667, 0.739232, }, 
		{1.570573, 1.65293, }, 
		{{0.52434879541406, 0.56797581911094, }, {0.5215175747875, 0.46324270963672, }, {0.54029821902523, 0.56730445227592, }, {0.52434882521665, 0.47113125994805, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.4619, 0.666667, 0.734701, }, 
		{1.65293, 1.735286, }, 
		{{0.5215175747875, 0.46324270963672, }, {0.50736129283906, 0.52064451575312, }, {0.51868632435835, 0.45535415932539, }, {0.51245755963029, 0.51611279435489, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.448341, 0.666667, 0.729697, }, 
		{1.735286, 1.817643, }, 
		{{0.50736129283906, 0.52064451575312, }, {0.49093997478516, 0.49043303728125, }, {0.50226502604784, 0.52517623715136, }, {0.49173282580481, 0.49233058095, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.434699, 0.666667, 0.725645, }, 
		{1.817643, 1.9, }, 
		{{0.49093997478516, 0.49043303728125, }, {0.50260418653516, 0.50925925374062, }, {0.49014712376551, 0.4885354936125, }, {0.50109418230159, 0.50843636198001, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.322175, 1, 0.666667, 0.545234, }, 
		{1.9, 2.100684, }, 
		{{0.50260418653516, 0.50925925374062, }, {0.5, 0.49537038803125, }, {0.50411419076873, 0.51008214550124, }, {0.50043403110467, 0.49691359698797, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.628348, 0.666667, 1, }, 
		{2.100684, 2.200781, }, 
		{{0.5, 0.49537038803125, }, {0.5, 0.5, }, {0.49956596889533, 0.49382717907453, }, {0.5, 0.49922839798965, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_1715-effect1#blurIntensity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.4, 1.570443, }, 
		{{370, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiExposure_1715-effect2#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 1.734993, }, 
		{{3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDeepGlow_1717-effect0#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.3, 1.466667, }, 
		{{1.05, }, {0, }, }, 
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
