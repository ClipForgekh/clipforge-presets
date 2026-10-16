local data = {}

local ae_compDurations = {0, 30}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'lvFilter'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiSkinFilter_14-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiSkinFilter_14-effect0'] = {
        ['nodeDuration'] = {{0, 30}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 30}, },
            ['bgLut'] = {{0, 30}, },
            ['skinLut'] = {{0, 30}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiSkinFilter_14-effect0'] = {
        ['skinFilterIntensity'] = 1,
        ['bgFilterIntensity'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1440),
    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
    ['intensity'] = {
        {'LumiSkinFilter_14-effect0', 'skinFilterIntensity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiSkinFilter_14-effect0', 'bgFilterIntensity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
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
