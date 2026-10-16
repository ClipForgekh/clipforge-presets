local data = {}

local ae_compDurations = {0, 0.5}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_389-trs', 'InputTex', 0},
    {'LumiLayer_390-trs-blend', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_481-trs'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiGaussianBlur_482-effect0'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiLayer_482-blend'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiLayer_389-trs'] = {
        ['nodeDuration'] = {{0, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.5}, },
        },
    },
    ['LumiLayer_390-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0, 0.5}, },
        },
    },
    ['LumiSaturation_391-effect0'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.5}, },
        },
    },
    ['LumiLayer_391-blend'] = {
        ['nodeDuration'] = {{0, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0, 0.5}, },
        },
    },
    ['LumiLayer_439-trs'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiGaussianBlur_440-effect0'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiLayer_440-blend'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiLayer_392-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0, 0.5}, },
            ['maskTex'] = {{0.26666666666667, 0.5}, },
        },
    },
    ['LumiLayer_394-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0, 0.5}, },
            ['maskTex'] = {{0.26666666666667, 0.5}, },
        },
    },
    ['LumiTurbulentNoise_531-effect0'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
        },
    },
    ['LumiUnmult_531-effect1'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
        },
    },
    ['LumiFill_531-effect2'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
        },
    },
    ['LumiLayer_529-trs'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiGaussianBlur_530-effect0'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiLayer_530-blend'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiLayer_532-trs'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiLayer_531-matte-blend'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0.26666666666667, 0.5}, },
            ['maskTex'] = {{0.26666666666667, 0.46666666666667}, },
        },
    },
    ['LumiContrast_396-effect0'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.5}, },
        },
    },
    ['LumiDirectionalBlurs_533-effect0'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
        },
    },
    ['LumiLayer_533-blend'] = {
        ['nodeDuration'] = {{0.26666666666667, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0.26666666666667, 0.5}, },
        },
    },
    ['LumiLayer_396-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.26666666666667, 0.5}, },
            ['baseTex'] = {{0, 0.5}, },
            ['maskTex'] = {{0.26666666666667, 0.5}, },
        },
    },
    ['LumiLayer_398-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.46666666666667, 0.5}, },
            ['baseTex'] = {{0, 0.5}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_481-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(50, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
    },
    ['LumiGaussianBlur_482-effect0'] = {
        ['blurIntensity'] = 130,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_482-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_389-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = true,
    },
    ['LumiLayer_390-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(150, 150, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiSaturation_391-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_391-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_439-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(70, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
    },
    ['LumiGaussianBlur_440-effect0'] = {
        ['blurIntensity'] = 130,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_440-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_392-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 50,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
        ['matteMode'] = 2,
        ['blendMode'] = 0,
    },
    ['LumiLayer_394-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['matteMode'] = 2,
        ['blendMode'] = 4,
    },
    ['LumiTurbulentNoise_531-effect0'] = {
        ['fractalType'] = 0,
        ['noiseType'] = 1,
        ['brightness'] = -0.03,
        ['contrast'] = 0.98,
        ['complexity'] = 7,
        ['evolution'] = 0,
        ['cycle'] = 100,
        ['rotate'] = 0,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['scale_x'] = 1,
        ['scale_y'] = 0.00009999999776,
        ['sub_impact'] = 0.7,
        ['sub_rotate'] = 0,
        ['sub_scale'] = 0.56,
        ['sub_offset_x'] = 0,
        ['sub_offset_y'] = 0,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiUnmult_531-effect1'] = {
        ['unmult'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiFill_531-effect2'] = {
        ['color'] = Amaz.Color(0, 0, 0, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_529-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(50, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
    },
    ['LumiGaussianBlur_530-effect0'] = {
        ['blurIntensity'] = 130,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_530-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_532-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(50, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_531-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiContrast_396-effect0'] = {
        ['contrastIntensity'] = 1.75,
        ['pivot'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiDirectionalBlurs_533-effect0'] = {
        ['blurIntensity'] = 20,
        ['angle'] = 90,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_533-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_396-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_398-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_481-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.333333, 0.366667, }, 
		{{448, 252, 0, }, {149, 252, 0, }, {448, 252, 0, }, {149, 252, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_481-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.466667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_389-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0,0,0.166666667, 0.833333333,0.833333333,0.833333333, 1,1,0.833333333, }, 
		{0, 0.466667, }, 
		{{100, 100, 100, }, {90, 90, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_439-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.333333, 0.366667, }, 
		{{448, 252, 0, }, {149, 252, 0, }, {448, 252, 0, }, {149, 252, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_439-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.466667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_529-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.333333, 0.366667, }, 
		{{448, 252, 0, }, {149, 252, 0, }, {448, 252, 0, }, {149, 252, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_529-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.466667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_532-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.333333, 0.366667, }, 
		{{448, 252, 0, }, {149, 252, 0, }, {448, 252, 0, }, {149, 252, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_532-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.466667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_398-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.533333, }, 
		{{100, }, {0, }, }, 
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
