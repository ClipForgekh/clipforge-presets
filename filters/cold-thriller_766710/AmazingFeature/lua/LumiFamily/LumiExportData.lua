local data = {}

local ae_compDurations = {0, 2.3125}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'lvFilter'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLvFilter_1956-effect0', 'InputTex', 0},
    {'LumiLayer_1956-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLvFilter_1956-effect0'] = {
        ['nodeDuration'] = {{0, 2.3125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 6}, },
        },
    },
    ['LumiHsl_1956-effect1'] = {
        ['nodeDuration'] = {{0, 2.3125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.3125}, },
        },
    },
    ['LumiVignette_1956-effect2'] = {
        ['nodeDuration'] = {{0, 2.3125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.3125}, },
        },
    },
    ['LumiSoftGlow_1956-effect3'] = {
        ['nodeDuration'] = {{0, 2.3125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.3125}, },
        },
    },
    ['LumiAdjust_1956-effect4'] = {
        ['nodeDuration'] = {{0, 2.3125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.3125}, },
        },
    },
    ['LumiLayer_1956-trs-blend'] = {
        ['nodeDuration'] = {{0, 6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.3125}, },
            ['baseTex'] = {{0, 6}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLvFilter_1956-effect0'] = {
        ['uniAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiHsl_1956-effect1'] = {
        ['HSLRed1'] = 0.12,
        ['HSLRed2'] = -0.01,
        ['HSLRed3'] = -0.13,
        ['HSLOrange1'] = 0,
        ['HSLOrange2'] = 0.18,
        ['HSLOrange3'] = -0.06,
        ['HSLYellow1'] = 0,
        ['HSLYellow2'] = -0.16,
        ['HSLYellow3'] = 0,
        ['HSLGreen1'] = 1,
        ['HSLGreen2'] = -0.67,
        ['HSLGreen3'] = -0.99,
        ['HSLCyan1'] = 0,
        ['HSLCyan2'] = 0,
        ['HSLCyan3'] = 0,
        ['HSLBlue1'] = 0,
        ['HSLBlue2'] = 0,
        ['HSLBlue3'] = 0,
        ['HSLPurple1'] = 0,
        ['HSLPurple2'] = 0,
        ['HSLPurple3'] = 0,
        ['HSLMagenta1'] = 0.59,
        ['HSLMagenta2'] = 0,
        ['HSLMagenta3'] = -0.29,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiVignette_1956-effect2'] = {
        ['color'] = Amaz.Color(0, 0.08011373877525, 0.10729166865349, 1),
        ['amount'] = 0.76,
        ['midpoint'] = 0.5,
        ['roundness'] = -0.44000000298023,
        ['feather'] = 0.7,
        ['highlight'] = 0,
        ['transparent'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiSoftGlow_1956-effect3'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0.87,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 1,
        ['glowIntensity'] = 26,
        ['glowColor'] = Amaz.Color(0.63733148574829, 1, 0.80336564779282, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiAdjust_1956-effect4'] = {
        ['brilliance'] = 0,
        ['brightness'] = 0,
        ['contrast'] = 0,
        ['exposure'] = 0,
        ['fade'] = 0,
        ['highlight'] = 0.34,
        ['lightSensation'] = 0,
        ['saturation'] = 0,
        ['shadow'] = -0.24,
        ['temperature'] = -0.11,
        ['tone'] = -0.19,
        ['vibrance'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiLayer_1956-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(600, 600, 0),
        ['position'] = Amaz.Vector3f(600, 600, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1200, 1200),
        ['layerSize'] = Amaz.Vector2f(1200, 1200),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
    ['intensity'] = {
        {'LumiLayer_1956-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
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
    animationMode = 1,
    loopStart = 0,
    speedInfo = {1, 0, 1, },
}
data.ae_animationInfos = ae_animationInfos

return data
