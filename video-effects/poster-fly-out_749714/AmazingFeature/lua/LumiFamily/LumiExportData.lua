local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiBrightness_2703-effect0', 'InputTex', 0},
    {'LumiPageTurn_6701-effect0', 'InputTex', 0},
    {'LumiLayer_6701-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBrightness_2703-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_2703-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiOpticsCompensation_2703-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_2703-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiPageTurn_6701-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_6701-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_8702-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiPageTurn_8701-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_8701-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_4601-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_2702-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_2701-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBrightness_2703-effect0'] = {
        ['brightnessIntensity'] = -1,
    },
    ['LumiGaussianBlur_2703-effect1'] = {
        ['blurIntensity'] = 80,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
    },
    ['LumiOpticsCompensation_2703-effect2'] = {
        ['fov'] = 70,
        ['inverseLensDistortion'] = true,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
    },
    ['LumiLayer_2703-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(252, 336, 0),
        ['scale'] = Amaz.Vector3f(195.475693143582, 195.475693143582, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
    },
    ['LumiPageTurn_6701-effect0'] = {
        ['classic_ui'] = 2,
        ['inFoldPosition'] = Amaz.Vector2f(0.70240638252767, 0.67998743716527),
        ['inFoldDirection'] = 130,
        ['foldRadius'] = 0.2,
    },
    ['LumiLayer_6701-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_8702-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(254, 336, 162),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 360,
        ['rotation'] = 367.646795325836,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
    },
    ['LumiPageTurn_8701-effect0'] = {
        ['classic_ui'] = 3,
        ['inFoldPosition'] = Amaz.Vector2f(-0.25396825396825, -0.04761904761905),
        ['inFoldDirection'] = 130,
        ['foldRadius'] = 0.3,
    },
    ['LumiLayer_8701-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_4601-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(252, 336, -213.95301891919),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2702-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLayer_2701-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(252, 336, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiBrightness_2703-effect0#brightnessIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 1.433333, }, 
		{{-1, }, {-1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.42, 1, }, 
		{1.433333, 1.966667, }, 
		{{-1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_2703-effect1#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 1.433333, }, 
		{{80, }, {80, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.833333, }, 
		{{80, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiOpticsCompensation_2703-effect2#fov#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 1.433333, }, 
		{{70, }, {70, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.42, 1, }, 
		{1.433333, 1.966667, }, 
		{{70, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2703-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.033333, 1.066667, }, 
		{{200, 200, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.42,0.42,0.42, 1,1,0.42, }, 
		{1.066667, 1.966667, }, 
		{{200, 200, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2703-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.933333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.933333, 1.066667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiPageTurn_6701-effect0#inFoldPosition#vector'] =
{
	{
		{0.166667, 0.166665, 0.666667, 1, }, 
		{0, 0.833333, }, 
		{{1, 0.98809523809524, }, {0.63492063492063, 0.58928571428571, }, {0.99933862431891, 0.98561507942421, }, {0.72089946837652, 0.56547619047619, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.833333, 0.833335, }, 
		{0.833333, 1.6, }, 
		{{0.63492063492063, 0.58928571428571, }, {1.02777777777778, 1.02380952380952, }, {0.60873539485629, 0.59653701171989, }, {0.96230158730159, 0.95138888699668, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.6, 1.966667, }, 
		{{1.02777777777778, 1.02380952380952, }, {1.02777777777778, 1.02380952380952, }, {1.02777777777778, 1.02380952380952, }, {1.02777777777778, 1.02380952380952, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiPageTurn_6701-effect0#inFoldDirection#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.633333, }, 
		{{130, }, {130, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.633333, 1.966667, }, 
		{{130, }, {130, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_8702-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.033333, 0.833333, }, 
		{{252, 336, 424, }, {254, 336, 162, }, {252.333333343267, 336, 380.333332061768, }, {253.666666656733, 336, 205.666667938232, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.833333, 1.966667, }, 
		{{254, 336, 162, }, {254, 336, 162, }, {254, 336, 162, }, {254, 336, 162, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_8702-trs#xRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.48, 1, }, 
		{0.033333, 0.833333, }, 
		{{38, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.833333, 1.966667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_8702-trs#yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.48, 1, }, 
		{0.033333, 0.833333, }, 
		{{291, }, {360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.833333, 1.966667, }, 
		{{360, }, {360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_8702-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.48, 1, }, 
		{0.033333, 1.333333, }, 
		{{329, }, {369, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{1.333333, 1.966667, }, 
		{{369, }, {369, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_8701-effect0#inFoldPosition#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.033333, 1.4, }, 
		{{-0.25396825396825, -0.04761904761905, }, {-0.25396825396825, -0.04761904761905, }, {-0.25396825396825, -0.04761904761905, }, {-0.25396825396825, -0.04761904761905, }, }, 
		{6415, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.4, 1.666667, }, 
		{{-0.25396825396825, -0.04761904761905, }, {2.14285714285714, 1.62202380952381, }, {0.14550263541085, 0.23065476190476, }, {1.74338625347804, 1.34375, }, }, 
		{6415, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.666667, 1.966667, }, 
		{{2.14285714285714, 1.62202380952381, }, {2.14285714285714, 1.62202380952381, }, {2.14285714285714, 1.62202380952381, }, {2.14285714285714, 1.62202380952381, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_4601-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.17, 1, }, 
		{0.033333, 1.5, }, 
		{{252, 336, 0, }, {252, 336, -224, }, {252, 336, -37.3333320617676, }, {252, 336, -186.666667938232, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.17, 0.17, }, 
		{1.5, 1.966667, }, 
		{{252, 336, -224, }, {252, 336, -224, }, {252, 336, -224, }, {252, 336, -224, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2701-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.266667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1.966667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = true
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
