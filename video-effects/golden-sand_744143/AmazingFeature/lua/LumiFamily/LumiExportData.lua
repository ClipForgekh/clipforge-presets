local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiExposure_7802-effect0', 'InputTex', 0},
    {'LumiExtract_14404-effect0', 'InputTex', 0},
    {'LumiLayer_14403-trs', 'InputTex', 0},
    {'LumiExtract_6104-effect0', 'InputTex', 0},
    {'LumiLayer_6103-trs', 'InputTex', 0},
    {'LumiLinearWipe_10604-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiExposure_7802-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiGrain_7802-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_7801-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiExtract_14404-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_14403-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_14404-matte'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiDisplacementMap_14402-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['horizontalImage'] = {{0, 3}, },
            ['verticalImage'] = {{0, 3}, },
        },
    },
    ['TurbulenceDisplacement_14402-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiDeepGlow_14402-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_14402-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiBrightness_10602-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiExtract_6104-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_6103-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_6104-trs-matte'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiDisplacementMap_6102-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['horizontalImage'] = {{0, 3}, },
            ['verticalImage'] = {{0, 3}, },
        },
    },
    ['TurbulenceDisplacement_6102-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiDeepGlow_6102-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_6102-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiTemperatureTone_10603-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_10604-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_10604-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBrightness_10604-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_10603-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_10602-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiTemperatureTone_10601-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_10601-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiExposure_7802-effect0'] = {
        ['channelType'] = 0,
        ['exposure'] = -3.93333333333333,
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
    },
    ['LumiGrain_7802-effect1'] = {
        ['grainIntensity'] = 10,
        ['intensityR'] = 10,
        ['intensityG'] = 10,
        ['intensityB'] = 10,
        ['scale'] = 0.21,
        ['scaleR'] = 1,
        ['scaleG'] = 1,
        ['scaleB'] = 1,
        ['brightness'] = 0,
        ['contrast'] = 0.3,
        ['saturation'] = 0.3,
        ['monochrome'] = false,
        ['combine'] = 3,
        ['speed'] = 0,
    },
    ['LumiLayer_7801-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(200, 200, 0),
        ['position'] = Amaz.Vector3f(405, 540, 0),
        ['scale'] = Amaz.Vector3f(204, 272, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 73.6,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(810, 1080),
        ['layerSize'] = Amaz.Vector2f(400, 400),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Overlay',
    },
    ['LumiExtract_14404-effect0'] = {
        ['blackField'] = 186.379129680717,
        ['blackSoft'] = 0,
        ['whiteField'] = 255,
        ['whiteSoft'] = 0,
        ['reverse'] = false,
    },
    ['LumiLayer_14403-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(405, 540, 0),
        ['position'] = Amaz.Vector3f(405, 274.670535798472, 0),
        ['scale'] = Amaz.Vector3f(100, 27, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(810, 1080),
        ['layerSize'] = Amaz.Vector2f(810, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_14404-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 'Alpha',
    },
    ['LumiDisplacementMap_14402-effect0'] = {
        ['horizontalType'] = 0,
        ['horizontalIntensity'] = 0,
        ['verticalType'] = 0,
        ['verticalIntensity'] = -0.46666666666667,
        ['edgeType'] = 0,
    },
    ['TurbulenceDisplacement_14402-effect1'] = {
        ['size'] = 0.27,
        ['quantity'] = 3.5,
        ['complexity'] = 10,
        ['evolution'] = 168,
        ['cycle'] = 100,
        ['offset_x'] = 0,
        ['offset_y'] = 0.02,
        ['type'] = 0,
        ['fix_type'] = 0,
        ['picture_scale'] = 1,
        ['motion_tile_type'] = 2,
        ['qualityType'] = 3,
    },
    ['LumiDeepGlow_14402-effect2'] = {
        ['radius'] = 360,
        ['exposure'] = 0.9,
        ['threshold'] = 0.22,
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
        ['quality'] = 0.10255638684725,
    },
    ['LumiLayer_14402-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 'Normal',
    },
    ['LumiBrightness_10602-effect0'] = {
        ['brightnessIntensity'] = 0.55,
    },
    ['LumiExtract_6104-effect0'] = {
        ['blackField'] = 0,
        ['blackSoft'] = 0,
        ['whiteField'] = 200.374183939593,
        ['whiteSoft'] = 0,
        ['reverse'] = false,
    },
    ['LumiLayer_6103-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(405, 540, 0),
        ['position'] = Amaz.Vector3f(405, 269.638060107506, 0),
        ['scale'] = Amaz.Vector3f(100, 37.6150876318628, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(810, 1080),
        ['layerSize'] = Amaz.Vector2f(810, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_6104-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(405, 540, 0),
        ['position'] = Amaz.Vector3f(405, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(810, 1080),
        ['layerSize'] = Amaz.Vector2f(810, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Alpha',
    },
    ['LumiDisplacementMap_6102-effect0'] = {
        ['horizontalType'] = 0,
        ['horizontalIntensity'] = 0,
        ['verticalType'] = 0,
        ['verticalIntensity'] = -0.37035532241728,
        ['edgeType'] = 0,
    },
    ['TurbulenceDisplacement_6102-effect1'] = {
        ['size'] = 0.16,
        ['quantity'] = 3.5,
        ['complexity'] = 10,
        ['evolution'] = 168,
        ['cycle'] = 100,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['type'] = 0,
        ['fix_type'] = 0,
        ['picture_scale'] = 1,
        ['motion_tile_type'] = 2,
        ['qualityType'] = 3,
    },
    ['LumiDeepGlow_6102-effect2'] = {
        ['radius'] = 360,
        ['exposure'] = 0.8,
        ['threshold'] = 0.22,
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
        ['quality'] = 0.51278193423623,
    },
    ['LumiLayer_6102-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 'Normal',
    },
    ['LumiTemperatureTone_10603-effect0'] = {
        ['temperatureIntensity'] = 0.66,
        ['toneIntensity'] = 0,
    },
    ['LumiLinearWipe_10604-effect0'] = {
        ['progress'] = 0.52464107939473,
        ['rotation'] = 180,
        ['feather'] = 0.12652769120665,
    },
    ['LumiGaussianBlur_10604-effect1'] = {
        ['blurIntensity'] = 9.00750230607859,
        ['quality'] = 0.15383458027087,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
    },
    ['LumiBrightness_10604-effect2'] = {
        ['brightnessIntensity'] = -0.50146975779799,
    },
    ['LumiLayer_10603-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_10602-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
    ['LumiTemperatureTone_10601-effect0'] = {
        ['temperatureIntensity'] = 0.17,
        ['toneIntensity'] = 0,
    },
    ['LumiLayer_10601-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiExposure_7802-effect0#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.333333, }, 
		{{-3, }, {-4.333333, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.25, 0.09, 0.75, 0.96, }, 
		{1.333333, 2, }, 
		{{-4.333333, }, {-5.833333, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_7801-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.333333, }, 
		{{40, }, {88, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExtract_14404-effect0#blackField#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.833333, }, 
		{{210, }, {185, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.748105075, 0.982463581, }, 
		{0.833333, 2, }, 
		{{185, }, {255, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_14403-trs#position#vector'] =
{
	{
		{0.25, 0, 0.71, 0.5, }, 
		{0, 1.233333, }, 
		{{405, 145.8, 0, }, {405, 349.36390544, 0, }, {405, 145.8, 0, }, {405, 349.36390544, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.384707, 0.337013, 0.833333, 0.741397, }, 
		{1.233333, 1.633333, }, 
		{{405, 349.36390544, 0, }, {405, 481.21498032, 0, }, {405, 349.36390544, 0, }, {405, 481.21498032, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.52, 0.28, 0.999, 1, }, 
		{1.633333, 2, }, 
		{{405, 481.21498032, 0, }, {405, 741.480209095, 0, }, {405, 481.21498032, 0, }, {405, 741.480209095, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_14403-trs#scale#vector'] =
{
	{
		{0.33333333,0.241879488,0.33333333, 0.33333333,0,0.33333333, 0.66666667,0.78438688,0.66666667, 0.66666667,1,0.66666667, }, 
		{1.233333, 2, }, 
		{{100, 27, 100, }, {100, 12, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiDisplacementMap_14402-effect0#verticalIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {-1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['TurbulenceDisplacement_14402-effect1#size#number'] =
{
	{
		{0.343434785, 0, 0.696602775, 1, }, 
		{0, 0.833333, }, 
		{{0, }, {0.27, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['TurbulenceDisplacement_14402-effect1#evolution#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {360, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDeepGlow_14402-effect2#exposure#number'] =
{
	{
		{0.2, 0, 0.8, 1, }, 
		{0, 0.666667, }, 
		{{0, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.2, 0, 0.8, 0, }, 
		{0.666667, 1.133333, }, 
		{{0.9, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.422435456, 0, 0.772559154, 1, }, 
		{1.133333, 2, }, 
		{{0.9, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBrightness_10602-effect0#brightnessIntensity#number'] =
{
	{
		{0.2, 0, 0.8, 1, }, 
		{0.1, 0.666667, }, 
		{{0, }, {0.55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiExtract_6104-effect0#whiteField#number'] =
{
	{
		{0.338146615, 0, 0.716451799, 1, }, 
		{0.366667, 0.866667, }, 
		{{238, }, {198, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.290506429, 0, 0.648484387, 1, }, 
		{0.866667, 1.366667, }, 
		{{198, }, {238, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.264792255, 0, 0.47718752, 1, }, 
		{1.366667, 2, }, 
		{{238, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_6103-trs#position#vector'] =
{
	{
		{0.357287, 0, 0.714254, 0.500082, }, 
		{0, 1.233333, }, 
		{{405, 145.8, 0, }, {405, 349.36390544, 0, }, {405, 145.8, 0, }, {405, 349.36390544, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.384707, 0.337013, 0.724899, 0.739747, }, 
		{1.233333, 1.633333, }, 
		{{405, 349.36390544, 0, }, {405, 481.21498032, 0, }, {405, 349.36390544, 0, }, {405, 481.21498032, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.46, 0.161333, 0.999, 1, }, 
		{1.633333, 2, }, 
		{{405, 481.21498032, 0, }, {405, 950, 0, }, {405, 481.21498032, 0, }, {405, 950, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_6103-trs#scale#vector'] =
{
	{
		{0.15821557,0.567807394,0.15821557, 0.15821557,0,0.15821557, 0.627175279,0.73311887,0.627175279, 0.627175279,1,0.627175279, }, 
		{0, 0.833333, }, 
		{{100, 27, 100, }, {100, 38, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.436993536,0.443945027,0.436993536, 0.436993536,0,0.436993536, 0.833333333,0.794737269,0.833333333, 0.833333333,0.333830574,0.833333333, }, 
		{0.833333, 1.233333, }, 
		{{100, 38, 100, }, {100, 28, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.162282146,0.166666667, 0.166666667,0.721047526,0.166666667, 0.8,0.620184469,0.8, 0.8,1,0.8, }, 
		{1.233333, 2, }, 
		{{100, 28, 100, }, {100, 14, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_6104-trs-matte#opacity#number'] =
{
	{
		{0.415623395, 0, 0.638001156, 1, }, 
		{1.533333, 2, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDisplacementMap_6102-effect0#verticalIntensity#number'] =
{
	{
		{0.370249165, 0, 0.794032611, 1, }, 
		{0, 2, }, 
		{{0, }, {-1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['TurbulenceDisplacement_6102-effect1#size#number'] =
{
	{
		{0.343434785, 0, 0.696602775, 1, }, 
		{0, 0.6, }, 
		{{0, }, {0.16, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['TurbulenceDisplacement_6102-effect1#evolution#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 2, }, 
		{{0, }, {360, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDeepGlow_6102-effect2#exposure#number'] =
{
	{
		{0.2, 0, 0.8, 1, }, 
		{0, 0.666667, }, 
		{{0, }, {0.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.2, 0, 0.8, 0, }, 
		{0.666667, 1.133333, }, 
		{{0.8, }, {0.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.511348209, 0, 0.988461538, 1, }, 
		{1.133333, 2, }, 
		{{0.8, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTemperatureTone_10603-effect0#temperatureIntensity#number'] =
{
	{
		{0.2, 0, 0.8, 1, }, 
		{0.1, 0.666667, }, 
		{{0, }, {0.66, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_10604-effect0#progress#number'] =
{
	{
		{0.02103609, 0.795327616, 0.341175318, 0.662657141, }, 
		{0, 0.766667, }, 
		{{0, }, {0.47, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.444730852, 0.358012482, 0.961444549, 0.55636347, }, 
		{0.766667, 2, }, 
		{{0.47, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_10604-effect0#feather#number'] =
{
	{
		{0.5, 0, 0.82, 1, }, 
		{0, 1.666667, }, 
		{{0.04, }, {0.25, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_10604-effect1#blurIntensity#number'] =
{
	{
		{0.2, 0, 0.8, 1, }, 
		{0.333333, 1.366667, }, 
		{{0, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBrightness_10604-effect2#brightnessIntensity#number'] =
{
	{
		{0.254178136, 0, 0.728720077, 1, }, 
		{0, 1.366667, }, 
		{{0, }, {-0.67, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTemperatureTone_10601-effect0#temperatureIntensity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.666667, }, 
		{{0, }, {0.17, }, }, 
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
