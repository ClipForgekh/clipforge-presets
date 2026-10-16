local data = {}

local ae_compDurations = {0, 0.4}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'lvFilter'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLvFilter_254-effect0', 'InputTex', 0},
    {'LumiLayer_254-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLvFilter_254-effect0'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
            ['lutImage'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiLayer_254-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiDeepGlow_255-effect0'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiLightSensation_255-effect1'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiLayer_255-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiHsl_309-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiTemperatureTone_309-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_309-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiVignette_307-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiLayer_307-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLvFilter_254-effect0'] = {
        ['uniAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_254-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(1112.5, 825, 0),
        ['position'] = Amaz.Vector3f(1112.5, 825, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(2225, 1650),
        ['layerSize'] = Amaz.Vector2f(2225, 1650),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiDeepGlow_255-effect0'] = {
        ['radius'] = 10,
        ['exposure'] = 0.3,
        ['threshold'] = 1.33,
        ['thresholdSmooth'] = 1,
        ['greyScale'] = 0.47,
        ['blendMode'] = 1,
        ['view'] = 1,
        ['ratio'] = 1,
        ['rotate'] = 0,
        ['ca'] = false,
        ['redOffset'] = -0.4675,
        ['greenOffset'] = 0,
        ['blueOffset'] = -0.0025,
        ['tint'] = true,
        ['tintMode'] = 0,
        ['tintColor'] = Amaz.Color(0.89803928136826, 0.8705883026123, 0.88235300779343, 1),
        ['tintMix'] = 1,
        ['sourceOpacity'] = 1,
        ['unmult'] = true,
        ['gammaCorrect'] = true,
        ['gammaValue'] = 2,
        ['glowIter'] = 8,
        ['stepsMult'] = 1.5,
        ['downSample'] = 0.80000001192093,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLightSensation_255-effect1'] = {
        ['lightIntensity'] = 0.03,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_255-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(1112.5, 825, 0),
        ['position'] = Amaz.Vector3f(1112.5, 825, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(2225, 1650),
        ['layerSize'] = Amaz.Vector2f(2225, 1650),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiHsl_309-effect0'] = {
        ['HSLRed1'] = 0,
        ['HSLRed2'] = 0.32,
        ['HSLRed3'] = 0,
        ['HSLOrange1'] = 0,
        ['HSLOrange2'] = 0,
        ['HSLOrange3'] = 0.16,
        ['HSLYellow1'] = -0.23,
        ['HSLYellow2'] = -0.07,
        ['HSLYellow3'] = 0.44,
        ['HSLGreen1'] = 0,
        ['HSLGreen2'] = 0.43,
        ['HSLGreen3'] = 0,
        ['HSLCyan1'] = 0,
        ['HSLCyan2'] = 0,
        ['HSLCyan3'] = 0,
        ['HSLBlue1'] = 0,
        ['HSLBlue2'] = 0,
        ['HSLBlue3'] = 0,
        ['HSLPurple1'] = 0,
        ['HSLPurple2'] = 0,
        ['HSLPurple3'] = 0,
        ['HSLMagenta1'] = 0,
        ['HSLMagenta2'] = 0,
        ['HSLMagenta3'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiTemperatureTone_309-effect1'] = {
        ['temperatureIntensity'] = -0.06,
        ['toneIntensity'] = 0.1,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_309-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(1112.5, 825, 0),
        ['position'] = Amaz.Vector3f(1112.5, 825, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(2225, 1650),
        ['layerSize'] = Amaz.Vector2f(2225, 1650),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiVignette_307-effect0'] = {
        ['color'] = Amaz.Color(0, 0, 0, 1),
        ['amount'] = 0.37,
        ['midpoint'] = 0.54,
        ['roundness'] = 0.00999999701977,
        ['feather'] = 0.5,
        ['highlight'] = 0,
        ['transparent'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_307-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(1112.5, 825, 0),
        ['position'] = Amaz.Vector3f(1112.5, 825, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(2225, 1650),
        ['layerSize'] = Amaz.Vector2f(2225, 1650),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
    ['intensity'] = {
        {'LumiLayer_307-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiLayer_309-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiLayer_255-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiLayer_254-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
    },
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
