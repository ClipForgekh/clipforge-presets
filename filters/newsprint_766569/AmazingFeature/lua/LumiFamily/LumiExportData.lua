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
    ['LumiAnimSeqLayout_14-effect1'] = {
        ['nodeDuration'] = {{0, 30}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 30}, },
            ['seqTex'] = {{0, 30}, },
        },
    },
    ['LumiGrain_14-effect2'] = {
        ['nodeDuration'] = {{0, 30}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 30}, },
        },
    },
    ['LumiVignette_14-effect3'] = {
        ['nodeDuration'] = {{0, 30}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 30}, },
        },
    },
    ['LumiLayer_14-trs'] = {
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
        ['AEDesignSize'] = Amaz.Vector2f(735, 1105),
    },
    ['LumiAnimSeqLayout_14-effect1'] = {
        ['animSeqType'] = 2,
        ['alignmentType'] = 4,
        ['edgeType'] = 2,
        ['enableVideoAlphaBlend'] = false,
        ['offsetGlobalX'] = 0,
        ['offsetGlobalY'] = 0,
        ['offsetLocalX'] = 0,
        ['offsetLocalY'] = 0,
        ['rotation'] = 0,
        ['scale'] = 1,
        ['opacity'] = 1,
        ['enableInputBlend'] = true,
        ['speed'] = 1,
        ['playMode'] = 0,
        ['enableAdaptiveScale'] = true,
        ['designRatio'] = 3,
        ['AEDesignSize'] = Amaz.Vector2f(735, 1105),
    },
    ['LumiGrain_14-effect2'] = {
        ['grainIntensity'] = 1.40468227424749,
        ['intensityR'] = 10,
        ['intensityG'] = 10,
        ['intensityB'] = 10,
        ['scale'] = 0.2133779264214,
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
        ['AEDesignSize'] = Amaz.Vector2f(735, 1105),
    },
    ['LumiVignette_14-effect3'] = {
        ['color'] = Amaz.Color(0, 0, 0, 1),
        ['amount'] = 0.5,
        ['midpoint'] = 0.5,
        ['roundness'] = -0.20000000298023,
        ['feather'] = 0.5,
        ['highlight'] = 0,
        ['transparent'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(735, 1105),
    },
    ['LumiLayer_14-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(367.5, 552.5, 0),
        ['position'] = Amaz.Vector3f(368, 553, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(736, 1106),
        ['layerSize'] = Amaz.Vector2f(735, 1105),
        ['mirrorEdge'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
    ['intensity'] = {
        {'LumiLvFilter_14-effect0', 'uniAlpha', 'number', {true, }, 1, 1, 0, 1, {0, }, {0, }, },
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
