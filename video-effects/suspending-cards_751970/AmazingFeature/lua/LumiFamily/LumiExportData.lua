local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_227-trs', 'InputTex', 0},
    {'LumiLayer_228-trs-blend', 'InputTex', 0},
    {'LumiLayer_229-trs-blend', 'InputTex', 0},
    {'LumiLayer_230-trs-blend', 'InputTex', 0},
    {'LumiLayer_232-trs-blend', 'InputTex', 0},
    {'LumiLayer_233-trs-blend', 'InputTex', 0},
    {'LumiLayer_235-trs-blend', 'InputTex', 0},
    {'LumiLayer_236-trs-blend', 'InputTex', 0},
    {'LumiLayer_238-trs-blend', 'InputTex', 0},
    {'LumiRoundCorner_240-effect0', 'InputTex', 0},
    {'LumiRoundCorner_241-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_227-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_228-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_229-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_230-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiGaussianBlur_231-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_231-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_232-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_233-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiGaussianBlur_234-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_234-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_235-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_236-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiGaussianBlur_237-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_237-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_238-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiGaussianBlur_239-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_239-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiRoundCorner_240-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiBevelEmboss_240-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_240-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiRoundCorner_241-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiBevelEmboss_241-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_241-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiDirectionalBlurs_242-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_242-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_227-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(411.514487549512, 2393.93503331332, 1674.98852263519),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 107,
        ['yRotation'] = -13,
        ['rotation'] = 23,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_228-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(869.547988352671, 3038.90045036188, 1424.98852263519),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 232,
        ['yRotation'] = -42,
        ['rotation'] = -112,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_229-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(-639.302889537087, 3286.56439183443, 1549.82654150402),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 91,
        ['yRotation'] = -51,
        ['rotation'] = 116,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_230-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(-639.302889537087, 2346.56439183443, 1549.82654150402),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 63,
        ['yRotation'] = 45,
        ['rotation'] = -2,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGaussianBlur_231-effect0'] = {
        ['blurIntensity'] = 20,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_231-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_232-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(850.628346962823, 2261.78840504645, 1079.98852263519),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 52,
        ['yRotation'] = 39,
        ['rotation'] = 15,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_233-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(95.5144875495124, 1977.93503331332, 1079.98852263519),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 74,
        ['yRotation'] = 45,
        ['rotation'] = -31,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGaussianBlur_234-effect0'] = {
        ['blurIntensity'] = 20,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_234-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_235-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(873.312134280899, 2412.19571544664, 1071),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -55,
        ['yRotation'] = 20,
        ['rotation'] = -53,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_236-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(-134.914285717083, 1910.31428571958, 761),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 48,
        ['yRotation'] = -62,
        ['rotation'] = -91,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGaussianBlur_237-effect0'] = {
        ['blurIntensity'] = 20,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_237-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_238-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(370.141288189417, 1673.29488616691, 371.988522635189),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -94,
        ['yRotation'] = 91,
        ['rotation'] = 105,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGaussianBlur_239-effect0'] = {
        ['blurIntensity'] = 10,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_239-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_240-effect0'] = {
        ['radius'] = 30,
        ['fade'] = 2,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiBevelEmboss_240-effect1'] = {
        ['depth'] = 100,
        ['width'] = 0,
        ['soft'] = 0,
        ['lightYaw'] = -33,
        ['lightPitch'] = 90,
        ['upperBlendMode'] = 0,
        ['upperColor'] = Amaz.Color(1, 1, 1, 1),
        ['upperAlpha'] = 0.65,
        ['lowerBlendMode'] = 0,
        ['lowerColor'] = Amaz.Color(0, 0, 0, 1),
        ['lowerAlpha'] = 0.75,
        ['quality'] = 0.5,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_240-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 1679, 0),
        ['scale'] = Amaz.Vector3f(90, 90, 90),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 16,
        ['yRotation'] = -12,
        ['rotation'] = 26,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_241-effect0'] = {
        ['radius'] = 30,
        ['fade'] = 2,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiBevelEmboss_241-effect1'] = {
        ['depth'] = 100,
        ['width'] = 0,
        ['soft'] = 0,
        ['lightYaw'] = -39,
        ['lightPitch'] = 90,
        ['upperBlendMode'] = 0,
        ['upperColor'] = Amaz.Color(1, 1, 1, 1),
        ['upperAlpha'] = 0.65,
        ['lowerBlendMode'] = 8,
        ['lowerColor'] = Amaz.Color(0, 0, 0, 1),
        ['lowerAlpha'] = 0.75,
        ['quality'] = 0.6,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_241-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(224, 1081.37714286647, -262),
        ['scale'] = Amaz.Vector3f(60, 60, 60),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 27,
        ['yRotation'] = 14,
        ['rotation'] = 89,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiDirectionalBlurs_242-effect0'] = {
        ['blurIntensity'] = 50,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_242-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_227-trs#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.066667, 0.9, }, 
		{{411.51448755, -517.064966687, 1674.988522635, }, {411.51448755, 2393.935033313, 1674.988522635, }, {411.51448755, -517.064966687, 1674.988522635, }, {411.51448755, 2393.935033313, 1674.988522635, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_227-trs#xRotation#number'] =
{
	{
		{1, -9.13e-7, 0.9999, 1, }, 
		{0.066667, 0.9, }, 
		{{-27, }, {107, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_227-trs#yRotation#number'] =
{
	{
		{1, -0.000003398, 0.9999, 1, }, 
		{0.066667, 0.9, }, 
		{{-49, }, {-13, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_227-trs#rotation#number'] =
{
	{
		{1, 0.000002719, 0.9999, 1, }, 
		{0.066667, 0.9, }, 
		{{68, }, {23, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_227-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.9, 0.933333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_228-trs-blend#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.066667, 0.833333, }, 
		{{869.547988353, -859.099549638, 1424.988522635, }, {869.547988353, 3038.900450362, 1424.988522635, }, {869.547988353, -859.099549638, 1424.988522635, }, {869.547988353, 3038.900450362, 1424.988522635, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_228-trs-blend#xRotation#number'] =
{
	{
		{1, -0.000001732, 0.9999, 1, }, 
		{0.066667, 0.833333, }, 
		{{167, }, {232, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_228-trs-blend#yRotation#number'] =
{
	{
		{1, 0.000002251, 0.9999, 1, }, 
		{0.066667, 0.833333, }, 
		{{8, }, {-42, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_228-trs-blend#rotation#number'] =
{
	{
		{1, -0.000002345, 0.9999, 1, }, 
		{0.066667, 0.833333, }, 
		{{-160, }, {-112, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_228-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.833333, 0.866667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_229-trs-blend#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.033333, 0.933333, }, 
		{{-639.302889537, -339.435608166, 1549.826541504, }, {-639.302889537, 3286.564391834, 1549.826541504, }, {-639.302889537, -339.435608166, 1549.826541504, }, {-639.302889537, 3286.564391834, 1549.826541504, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_229-trs-blend#xRotation#number'] =
{
	{
		{1, -0.000001452, 0.9999, 1, }, 
		{0.033333, 0.933333, }, 
		{{0, }, {91, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_229-trs-blend#yRotation#number'] =
{
	{
		{1, 0.000002591, 0.9999, 1, }, 
		{0.033333, 0.933333, }, 
		{{0, }, {-51, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_229-trs-blend#rotation#number'] =
{
	{
		{1, -0.000001739, 0.9999, 1, }, 
		{0.033333, 0.933333, }, 
		{{40, }, {116, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_229-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.933333, 0.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_230-trs-blend#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.066667, 0.9, }, 
		{{-639.302889537, -339.435608166, 1549.826541504, }, {-639.302889537, 2346.564391834, 1549.826541504, }, {-639.302889537, -339.435608166, 1549.826541504, }, {-639.302889537, 2346.564391834, 1549.826541504, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_230-trs-blend#xRotation#number'] =
{
	{
		{1, -0.000001942, 0.9999, 1, }, 
		{0.066667, 0.9, }, 
		{{0, }, {63, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_230-trs-blend#yRotation#number'] =
{
	{
		{1, -0.000002719, 0.9999, 1, }, 
		{0.066667, 0.9, }, 
		{{0, }, {45, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_230-trs-blend#rotation#number'] =
{
	{
		{1, 0.000002913, 0.9999, 1, }, 
		{0.066667, 0.9, }, 
		{{40, }, {-2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_230-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.9, 0.933333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_232-trs-blend#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.066667, 0.866667, }, 
		{{850.628346963, -8.211594954, 1079.988522635, }, {850.628346963, 2261.788405046, 1079.988522635, }, {850.628346963, -8.211594954, 1079.988522635, }, {850.628346963, 2261.788405046, 1079.988522635, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_232-trs-blend#xRotation#number'] =
{
	{
		{1, -8.26e-7, 0.9999, 1, }, 
		{0.066667, 0.866667, }, 
		{{0, }, {52, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_232-trs-blend#yRotation#number'] =
{
	{
		{1, 0.000001719, 0.9999, 1, }, 
		{0.066667, 0.866667, }, 
		{{64, }, {39, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_232-trs-blend#rotation#number'] =
{
	{
		{1, -6.41e-7, 0.9999, 1, }, 
		{0.066667, 0.866667, }, 
		{{-52, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_232-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.866667, 0.9, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_233-trs-blend#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.033333, 0.933333, }, 
		{{95.51448755, -724.064966687, 1079.988522635, }, {95.51448755, 1977.935033313, 1079.988522635, }, {95.51448755, -724.064966687, 1079.988522635, }, {95.51448755, 1977.935033313, 1079.988522635, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_233-trs-blend#xRotation#number'] =
{
	{
		{1, -6.41e-7, 0.9999, 1, }, 
		{0.033333, 0.933333, }, 
		{{0, }, {74, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_233-trs-blend#yRotation#number'] =
{
	{
		{1, -6.24e-7, 0.9999, 1, }, 
		{0.033333, 0.933333, }, 
		{{-31, }, {45, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_233-trs-blend#rotation#number'] =
{
	{
		{1, 7.08e-7, 0.9999, 1, }, 
		{0.033333, 0.933333, }, 
		{{36, }, {-31, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_233-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.933333, 0.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_235-trs-blend#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.066667, 0.933333, }, 
		{{873.312134281, 617.195715447, 1071, }, {873.312134281, 2412.195715447, 1071, }, {873.312134281, 617.195715447, 1071, }, {873.312134281, 2412.195715447, 1071, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_235-trs-blend#xRotation#number'] =
{
	{
		{1, 0.000001389, 0.9999, 1, }, 
		{0.066667, 0.933333, }, 
		{{8, }, {-55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_235-trs-blend#yRotation#number'] =
{
	{
		{1, -0.000002651, 0.9999, 1, }, 
		{0.066667, 0.933333, }, 
		{{-13, }, {20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_235-trs-blend#rotation#number'] =
{
	{
		{1, 0.00000108, 0.9999, 1, }, 
		{0.066667, 0.933333, }, 
		{{28, }, {-53, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_235-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.933333, 0.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_236-trs-blend#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.066667, 0.866667, }, 
		{{-134.914285717, 441.31428572, 761, }, {-134.914285717, 1910.31428572, 761, }, {-134.914285717, 441.31428572, 761, }, {-134.914285717, 1910.31428572, 761, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_236-trs-blend#xRotation#number'] =
{
	{
		{1, -2.28e-7, 0.9999, 1, }, 
		{0.066667, 0.866667, }, 
		{{-21, }, {48, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_236-trs-blend#yRotation#number'] =
{
	{
		{1, 4.03e-7, 0.9999, 1, }, 
		{0.066667, 0.866667, }, 
		{{-23, }, {-62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_236-trs-blend#rotation#number'] =
{
	{
		{1, -3.28e-7, 0.9999, 1, }, 
		{0.066667, 0.866667, }, 
		{{-139, }, {-91, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_236-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.866667, 0.9, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_238-trs-blend#position#vector'] =
{
	{
		{1, 0, 0.9999, 1, }, 
		{0.066667, 0.8, }, 
		{{370.141288189, 176.294886167, 371.988522635, }, {370.141288189, 1673.294886167, 371.988522635, }, {370.141288189, 176.294886167, 371.988522635, }, {370.141288189, 1673.294886167, 371.988522635, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_238-trs-blend#xRotation#number'] =
{
	{
		{1, -0.000001565, 0.9999, 0.999834191, }, 
		{0.066667, 0.8, }, 
		{{-26, }, {-94, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_238-trs-blend#yRotation#number'] =
{
	{
		{1, 0.000001054, 0.9999, 1.000111634, }, 
		{0.066667, 0.8, }, 
		{{-10, }, {91, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_238-trs-blend#rotation#number'] =
{
	{
		{1, 7.14e-7, 0.9999, 1.000075671, }, 
		{0.066667, 0.8, }, 
		{{-44, }, {105, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_238-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 0.833333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRoundCorner_240-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.066667, 0.333333, }, 
		{{0, }, {30, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBevelEmboss_240-effect1#upperAlpha#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.066667, 0.333333, }, 
		{{0, }, {0.65, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBevelEmboss_240-effect1#lowerAlpha#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.066667, 0.333333, }, 
		{{0, }, {0.75, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_240-trs-blend#position#vector'] =
{
	{
		{1, 0.000001, 0.9999, 1, }, 
		{0.066667, 0.733333, }, 
		{{252, 448, 0, }, {252, 1679, 0, }, {252, 448, 0, }, {252, 1679, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_240-trs-blend#scale#vector'] =
{
	{
		{1,1,1, -0.000063438,-0.000063438,-0.000063438, 0.9999,0.9999,0.9999, 1,1,1, }, 
		{0.066667, 0.733333, }, 
		{{100, 100, 100, }, {90, 90, 90, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_240-trs-blend#xRotation#number'] =
{
	{
		{1, -3e-9, 0.9999, 1, }, 
		{0.066667, 0.733333, }, 
		{{0, }, {16, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_240-trs-blend#yRotation#number'] =
{
	{
		{1, 4e-9, 0.9999, 1, }, 
		{0.066667, 0.733333, }, 
		{{0, }, {-12, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_240-trs-blend#rotation#number'] =
{
	{
		{1, -2e-9, 0.9999, 1, }, 
		{0.066667, 0.733333, }, 
		{{0, }, {26, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_240-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.733333, 0.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_241-trs-blend#position#vector'] =
{
	{
		{0.933396, 0, 0.9999, 1, }, 
		{0.433333, 0.9, }, 
		{{224, -272.622857134, -262, }, {224, 1081.377142866, -262, }, {224, -272.622857134, -262, }, {224, 1081.377142866, -262, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_241-trs-blend#xRotation#number'] =
{
	{
		{0.93339625, -0.00001348, 0.9999, 1, }, 
		{0.433333, 0.9, }, 
		{{-24, }, {27, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_241-trs-blend#yRotation#number'] =
{
	{
		{0.93339625, -0.000049105, 0.9999, 1.000000001, }, 
		{0.433333, 0.9, }, 
		{{0, }, {14, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_241-trs-blend#rotation#number'] =
{
	{
		{0.93339625, -0.000021483, 0.9999, 1.000000001, }, 
		{0.433333, 0.9, }, 
		{{57, }, {89, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_242-effect0#blurIntensity#number'] =
{
	{
		{0.958904082, -6.8e-8, 0.9999, 1, }, 
		{0.333333, 0.6, }, 
		{{0, }, {50, }, }, 
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
