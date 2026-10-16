local data = {}

local ae_compDurations = {0, 0.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'lvFilter'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiHsl_362-effect0', 'InputTex', 0},
    {'LumiLayer_362-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiHsl_362-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiTritone_362-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_362-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiGaussianBlur_363-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiLayer_363-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiGlow_364-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiDeepGlow_364-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_364-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiContrast_365-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiLayer_365-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiVignette_366-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiLayer_366-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiHsl_362-effect0'] = {
        ['HSLRed1'] = 0,
        ['HSLRed2'] = 0,
        ['HSLRed3'] = 0.3,
        ['HSLOrange1'] = 0,
        ['HSLOrange2'] = 0,
        ['HSLOrange3'] = 0.75,
        ['HSLYellow1'] = 0,
        ['HSLYellow2'] = 0,
        ['HSLYellow3'] = 0,
        ['HSLGreen1'] = 0,
        ['HSLGreen2'] = 0,
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
    ['LumiTritone_362-effect1'] = {
        ['highlightColor'] = Amaz.Color(0.99607849121094, 0.99607849121094, 0.99607849121094, 1),
        ['middleColor'] = Amaz.Color(0.38691788911819, 0.38691788911819, 0.38691788911819, 1),
        ['shadowColor'] = Amaz.Color(0.04878982901573, 0.04379873722792, 0.04379873722792, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_362-trs-blend'] = {
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
    ['LumiGaussianBlur_363-effect0'] = {
        ['blurIntensity'] = 30,
        ['quality'] = 1,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_363-trs-blend'] = {
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
        ['opacity'] = 70,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(2225, 1650),
        ['layerSize'] = Amaz.Vector2f(2225, 1650),
        ['mirrorEdge'] = false,
        ['blendMode'] = 7,
    },
    ['LumiGlow_364-effect0'] = {
        ['threshold'] = 0.8,
        ['radius'] = 50,
        ['glowIntensity'] = 0.2,
        ['blendMode'] = 4,
        ['show'] = 0,
        ['glowColor'] = 0,
        ['colorLooping'] = 0,
        ['colorLoops'] = 1,
        ['colorPhase'] = 0,
        ['midpoint'] = 0.5,
        ['colorA'] = Amaz.Color(1, 1, 1, 1),
        ['colorB'] = Amaz.Color(0, 0, 0, 1),
        ['glowDimensions'] = 0,
        ['quality'] = 0.2,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiDeepGlow_364-effect1'] = {
        ['radius'] = 80,
        ['exposure'] = 0.55,
        ['threshold'] = 0,
        ['thresholdSmooth'] = 1,
        ['greyScale'] = 0.75,
        ['blendMode'] = 1,
        ['view'] = 1,
        ['ratio'] = 1,
        ['rotate'] = 16,
        ['ca'] = false,
        ['redOffset'] = 0,
        ['greenOffset'] = 0,
        ['blueOffset'] = 0,
        ['tint'] = true,
        ['tintMode'] = 1,
        ['tintColor'] = Amaz.Color(0.05647609755397, 0.23800174891949, 0.74751836061478, 1),
        ['tintMix'] = 0.8,
        ['sourceOpacity'] = 1,
        ['unmult'] = true,
        ['gammaCorrect'] = true,
        ['gammaValue'] = 3.5,
        ['glowIter'] = 8,
        ['stepsMult'] = 1.5,
        ['downSample'] = 0.80000001192093,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_364-trs-blend'] = {
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
    ['LumiContrast_365-effect0'] = {
        ['contrastIntensity'] = 1.02,
        ['pivot'] = 0.43000000715256,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_365-trs-blend'] = {
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
    ['LumiVignette_366-effect0'] = {
        ['color'] = Amaz.Color(0, 0, 0, 1),
        ['amount'] = 0.36,
        ['midpoint'] = 0.55,
        ['roundness'] = -0.20000000298023,
        ['feather'] = 0.5,
        ['highlight'] = 0,
        ['transparent'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(2225, 1650),
    },
    ['LumiLayer_366-trs-blend'] = {
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
        {'LumiLayer_366-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiLayer_365-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiLayer_364-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiLayer_363-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiLayer_362-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
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
