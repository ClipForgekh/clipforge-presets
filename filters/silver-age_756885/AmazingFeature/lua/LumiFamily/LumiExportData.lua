local data = {}

local ae_compDurations = {0, 0.03333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'lvFilter'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLvFilter_72-effect0'] = {
        ['nodeDuration'] = {{0, 2.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.66666666666667}, },
            ['lutImage'] = {{0, 1}, },
        },
    },
    ['LumiAdjust_72-effect1'] = {
        ['nodeDuration'] = {{0, 2.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.66666666666667}, },
        },
    },
    ['LumiGrain_177-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.66666666666667}, },
        },
    },
    ['LumiLayer_177-blend'] = {
        ['nodeDuration'] = {{0, 2.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 2.66666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLvFilter_72-effect0'] = {
        ['uniAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(3240, 4050),
    },
    ['LumiAdjust_72-effect1'] = {
        ['brilliance'] = 0,
        ['brightness'] = 0,
        ['contrast'] = 0,
        ['exposure'] = 0,
        ['fade'] = 0,
        ['highlight'] = 0.1,
        ['lightSensation'] = 0.05,
        ['saturation'] = 0.1,
        ['shadow'] = 0.03,
        ['temperature'] = 0,
        ['tone'] = 0,
        ['vibrance'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(3240, 4050),
    },
    ['LumiGrain_177-effect0'] = {
        ['grainIntensity'] = 0.5,
        ['intensityR'] = 10,
        ['intensityG'] = 10,
        ['intensityB'] = 10,
        ['scale'] = 0.202,
        ['scaleR'] = 1,
        ['scaleG'] = 1,
        ['scaleB'] = 1,
        ['brightness'] = 0,
        ['contrast'] = 1,
        ['saturation'] = 0.5,
        ['monochrome'] = true,
        ['combine'] = 4,
        ['speed'] = 1,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(3240, 4050),
    },
    ['LumiLayer_177-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
    ['intensity'] = {
        {'LumiGrain_177-effect0', 'grainIntensity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiLvFilter_72-effect0', 'uniAlpha', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiAdjust_72-effect1', 'highlight', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiAdjust_72-effect1', 'lightSensation', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiAdjust_72-effect1', 'saturation', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiAdjust_72-effect1', 'shadow', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
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
