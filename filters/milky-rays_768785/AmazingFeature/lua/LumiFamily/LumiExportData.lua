local data = {}

local ae_compDurations = {0, 30}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'lvFilter'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLvFilter_14-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLvFilter_14-effect0'] = {
        ['nodeDuration'] = {{0, 30}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 30}, },
            ['lutImage'] = {{0, 30}, },
        },
    },
    ['LumiSoftGlow_14-effect1'] = {
        ['nodeDuration'] = {{0, 30}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 30}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLvFilter_14-effect0'] = {
        ['uniAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiSoftGlow_14-effect1'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0.5,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 1.4,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(0.95294117927551, 0.8834764957428, 0.5593079328537, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
    ['intensity'] = {
        {'LumiLvFilter_14-effect0', 'uniAlpha', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiSoftGlow_14-effect1', 'exposure', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
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
