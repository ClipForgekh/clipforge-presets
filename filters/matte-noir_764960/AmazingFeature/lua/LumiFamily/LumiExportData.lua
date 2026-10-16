local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'lvFilter'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLvFilter_32-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLvFilter_32-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['lutImage'] = {{0, 1}, },
        },
    },
    ['LumiGrain_32-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiBrightness_32-effect2'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiContrast_32-effect3'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_32-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLvFilter_32-effect0'] = {
        ['uniAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(2000, 2000),
    },
    ['LumiGrain_32-effect1'] = {
        ['grainIntensity'] = 3.9,
        ['intensityR'] = 10,
        ['intensityG'] = 9.7,
        ['intensityB'] = 10,
        ['scale'] = 0.32,
        ['scaleR'] = 0.6,
        ['scaleG'] = 0.6,
        ['scaleB'] = 0.6,
        ['brightness'] = 0,
        ['contrast'] = 1,
        ['saturation'] = 0,
        ['monochrome'] = true,
        ['combine'] = 2,
        ['speed'] = 1,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(2000, 2000),
    },
    ['LumiBrightness_32-effect2'] = {
        ['brightnessIntensity'] = -0.25,
        ['AEDesignSize'] = Amaz.Vector2f(2000, 2000),
    },
    ['LumiContrast_32-effect3'] = {
        ['contrastIntensity'] = 1.81,
        ['pivot'] = 0.49,
        ['AEDesignSize'] = Amaz.Vector2f(2000, 2000),
    },
    ['LumiLayer_32-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(1000, 1000, 0),
        ['position'] = Amaz.Vector3f(1000, 999.5, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(2000, 2000),
        ['layerSize'] = Amaz.Vector2f(2000, 2000),
        ['mirrorEdge'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
    ['intensity'] = {
        {'LumiLvFilter_32-effect0', 'uniAlpha', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiGrain_32-effect1', 'grainIntensity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiBrightness_32-effect2', 'brightnessIntensity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
        {'LumiContrast_32-effect3', 'contrastIntensity', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
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
