local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiDirectionalBlurs_136-effect0', 'InputTex', 0},
    {'LumiLayer_136-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiDirectionalBlurs_136-effect0'] = {
        ['nodeDuration'] = {{0.79166666666667, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_136-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiDisplacementMap_137-effect0'] = {
        ['nodeDuration'] = {{0.58333333333333, 0.875}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['horizontalImage'] = {{0.58333333333333, 0.875}, },
            ['verticalImage'] = {{0.58333333333333, 0.875}, },
        },
    },
    ['LumiWaveWarp_137-effect1'] = {
        ['nodeDuration'] = {{0.58333333333333, 0.875}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.58333333333333, 0.875}, },
        },
    },
    ['LumiLayer_137-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.58333333333333, 0.875}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiExposure_138-effect0'] = {
        ['nodeDuration'] = {{0.625, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_138-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.625, 0.66666666666667}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiPixelSort_155-effect0'] = {
        ['nodeDuration'] = {{0.625, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_155-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.625, 0.66666666666667}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_157-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 0.70833333333333}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_139-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.70833333333333, 0.75}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiDirectionalBlurs_136-effect0'] = {
        ['blurIntensity'] = 0,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiLayer_136-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiDisplacementMap_137-effect0'] = {
        ['horizontalType'] = 0,
        ['horizontalIntensity'] = 0,
        ['verticalType'] = 0,
        ['verticalIntensity'] = 0,
        ['edgeType'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiWaveWarp_137-effect1'] = {
        ['type'] = 0,
        ['amplitude'] = 0,
        ['wavelength'] = 9,
        ['direction'] = 0,
        ['speed'] = 1,
        ['fixedType'] = 1,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiLayer_137-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiExposure_138-effect0'] = {
        ['channelType'] = 0,
        ['exposure'] = 1,
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
    ['LumiLayer_138-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiPixelSort_155-effect0'] = {
        ['threshold'] = 0.34,
        ['rotate'] = 90,
        ['randomly'] = 0.33,
        ['reverseSort'] = false,
        ['affectType'] = 0,
        ['triggerType'] = 0,
        ['sortType'] = 0,
        ['featherStart'] = 0.02,
        ['featherEnd'] = 0.03,
        ['length'] = 1,
        ['offset'] = 0,
        ['offsetRandom'] = 1,
        ['randomSeed'] = 0,
        ['cycle'] = 0,
        ['blockSize'] = 0.101,
        ['blurSize'] = 0,
        ['outputType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 1280),
    },
    ['LumiLayer_155-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_157-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 1,
    },
    ['LumiLayer_139-trs-blend'] = {
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
        ['opacity'] = 30,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 1,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiDirectionalBlurs_136-effect0#blurIntensity#number'] =
{
	{
		{0.74, 0, 0.833333333, 0.833333333, }, 
		{0.791667, 0.958333, }, 
		{{0, }, {460, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDisplacementMap_137-effect0#horizontalIntensity#number'] =
{
	{
		{0.74, 0, 0.66666667, 1, }, 
		{0.583333, 0.833333, }, 
		{{0, }, {0.02, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWaveWarp_137-effect1#amplitude#number'] =
{
	{
		{0.74, 0, 0.66666667, 1, }, 
		{0.583333, 0.833333, }, 
		{{0, }, {5, }, }, 
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
