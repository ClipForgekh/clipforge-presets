local data = {}

local ae_compDurations = {0, 6}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'lvFilter'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLvFilter_2887-effect0', 'InputTex', 0},
    {'LumiLayer_2887-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLvFilter_2887-effect0'] = {
        ['nodeDuration'] = {{0, 6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 6}, },
            ['lutImage'] = {{0, 6}, },
        },
    },
    ['LumiHsl_2887-effect1'] = {
        ['nodeDuration'] = {{0, 6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 6}, },
        },
    },
    ['LumiStrongSharpen_2887-effect2'] = {
        ['nodeDuration'] = {{0, 6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 6}, },
        },
    },
    ['LumiLayer_2887-trs-blend'] = {
        ['nodeDuration'] = {{0, 6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 6}, },
            ['baseTex'] = {{0, 6}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLvFilter_2887-effect0'] = {
        ['uniAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiHsl_2887-effect1'] = {
        ['HSLRed1'] = 0,
        ['HSLRed2'] = 0,
        ['HSLRed3'] = 0,
        ['HSLOrange1'] = 0,
        ['HSLOrange2'] = 0,
        ['HSLOrange3'] = 0,
        ['HSLYellow1'] = 0,
        ['HSLYellow2'] = 0.01,
        ['HSLYellow3'] = 0,
        ['HSLGreen1'] = 0,
        ['HSLGreen2'] = 0.07,
        ['HSLGreen3'] = -0.12,
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
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiStrongSharpen_2887-effect2'] = {
        ['strength'] = 0.01,
        ['range'] = 0.1,
        ['quality'] = 0.20000000298023,
        ['AEDesignSize'] = Amaz.Vector2f(1200, 1200),
    },
    ['LumiLayer_2887-trs-blend'] = {
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
        {'LumiLayer_2887-trs-blend', 'opacity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
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
