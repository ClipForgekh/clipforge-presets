local data = {}

local ae_compDurations = {0, 0.03333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'xtEffect'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiGaussianBlur_301-effect0', 'InputTex', 0},
    {'LumiLayer_301-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiGaussianBlur_301-effect0'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
        },
    },
    ['LumiLayer_301-trs-blend'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
            ['baseTex'] = {{0, 5}, },
        },
    },
    ['LumiSGlow_278-effect0'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
        },
    },
    ['LumiSGlow_278-effect1'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
        },
    },
    ['LumiLvFilter_278-effect2'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
            ['lutImage'] = {{0, 5}, },
        },
    },
    ['LumiLayer_278-trs-blend'] = {
        ['nodeDuration'] = {{0, 5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 5}, },
            ['baseTex'] = {{0, 5}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGaussianBlur_301-effect0'] = {
        ['intensity'] = 55,
        ['quality'] = 0.2,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
    },
    ['LumiLayer_301-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(937.5, 1250, 0),
        ['position'] = Amaz.Vector3f(937.5, 1250, 0),
        ['scale'] = Amaz.Vector3f(103, 103, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 17.28,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1875, 2500),
        ['layerSize'] = Amaz.Vector2f(1875, 2500),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Screen',
    },
    ['LumiSGlow_278-effect0'] = {
        ['brightness'] = 0.1296,
        ['glowColor'] = Amaz.Color(1, 0.95, 0.82, 1),
        ['threshold'] = 0,
        ['thresholdAddColor'] = Amaz.Color(0, 0, 0, 1),
        ['glowWidth'] = 0.032,
        ['widthX'] = 0.55,
        ['widthY'] = 0.72,
        ['widthRed'] = 1,
        ['widthGreen'] = 1,
        ['widthBlue'] = 1,
        ['show'] = 0,
        ['combine'] = 0,
        ['edgeMode'] = 1,
        ['glowFromAlpha'] = 0,
        ['glowUnderSource'] = 0,
        ['sourceOpacity'] = 1,
        ['dither'] = 1,
        ['quality'] = 0.2,
    },
    ['LumiSGlow_278-effect1'] = {
        ['brightness'] = 0.0792,
        ['glowColor'] = Amaz.Color(1, 0.82, 0.68, 1),
        ['threshold'] = 0,
        ['thresholdAddColor'] = Amaz.Color(0, 0, 0, 1),
        ['glowWidth'] = 0.16,
        ['widthX'] = 0.92,
        ['widthY'] = 0.82,
        ['widthRed'] = 1,
        ['widthGreen'] = 1.05,
        ['widthBlue'] = 1.12,
        ['show'] = 0,
        ['combine'] = 0,
        ['edgeMode'] = 1,
        ['glowFromAlpha'] = 0,
        ['glowUnderSource'] = 0,
        ['sourceOpacity'] = 1,
        ['dither'] = 1,
        ['quality'] = 0.2,
    },
    ['LumiLvFilter_278-effect2'] = {
        ['uniAlpha'] = 0.6336,
    },
    ['LumiLayer_278-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(937.5, 1250, 0),
        ['position'] = Amaz.Vector3f(937.5, 1250, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1875, 2500),
        ['layerSize'] = Amaz.Vector2f(1875, 2500),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_sliderInfos = {
    -- ['Internal_Glow'] = {
    --     {'LumiSGlow_278-effect0', 'brightness', 'number', {true, }, 1, 2, 0, 1, {0, }, {0, }, },
    -- },
    -- ['Internal_Filter'] = {
    --     {'LumiLvFilter_278-effect2', 'uniAlpha', 'number', {true, }, 1, 1.25, 0, 1, {0, }, {0, }, },
    -- },
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
