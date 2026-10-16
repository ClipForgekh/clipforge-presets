local data = {}

local ae_compDurations = { 0, 3 }
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {

}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBlit'] = {
        ['nodeDuration'] = { { 0, 3 }, },
        ['texDuration'] = {
            ['InputTex'] = { { 0, 3 }, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBlit'] = {

    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
}
data.ae_sliderInfos = ae_sliderInfos

local ae_fadeinInfos = {
    time = 0,
    infos = {
    }
}
data.ae_fadeinInfos = ae_fadeinInfos

local ae_keyframes = {
    ['LumiBlit#u_time#number'] =
    {
        {
            { 0.166666667, 0.166666667, 0.833333333, 0.833333333, },
            { 0,           3, },
            { { 0, },      { 1, }, },
            { 6417, },
            { 1, },
        },
    },
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = false
data.ae_reverseKeyframes = ae_reverseKeyframes


local ae_fadeoutInfos = {
    time = 0,
    infos = {
    }
}
data.ae_fadeoutInfos = ae_fadeoutInfos

local ae_animationInfos = {
    animationMode = 0,
    loopStart = 0,
    speedInfo = { 1, 0, 1, },
}
data.ae_animationInfos = ae_animationInfos

return data
