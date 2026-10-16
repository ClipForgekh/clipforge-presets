local data = {}

local ae_compDurations = {0, 0.83333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiContrast_356-effect0', 'InputTex', 0},
    {'LumiSaturation_358-effect0', 'InputTex', 0},
    {'LumiSaturation_359-effect0', 'InputTex', 0},
    {'LumiSaturation_361-effect0', 'InputTex', 0},
    {'LumiSaturation_363-effect0', 'InputTex', 0},
    {'LumiSaturation_365-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiAnimSeqLoadAndCrop_381-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.83333333333333}, },
            ['seqTex_1_1'] = {{0, 1}, },
        },
    },
    ['LumiContrast_356-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.83333333333333}, },
        },
    },
    ['LumiLayer_356-trs'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.83333333333333}, },
        },
    },
    ['LumiSaturation_357-effect0'] = {
        ['nodeDuration'] = {{0, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.83333333333333}, },
        },
    },
    ['LumiLayer_357-blend'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.6}, },
            ['baseTex'] = {{0.03333333333333, 0.83333333333333}, },
        },
    },
    ['LumiSaturation_358-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.16666666666667}, },
        },
    },
    ['LumiWaveWarp_358-effect1'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.16666666666667}, },
        },
    },
    ['LumiDistort_358-effect2'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.16666666666667}, },
        },
    },
    ['LumiWaveWarp_358-effect3'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.16666666666667}, },
        },
    },
    ['LumiLayer_358-blend'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.16666666666667}, },
            ['baseTex'] = {{0, 0.83333333333333}, },
        },
    },
    ['LumiSaturation_359-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiContrast_359-effect1'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiTritone_359-effect2'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiUnmult_359-effect3'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiWaveWarp_359-effect4'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiWaveWarp_359-effect5'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiLayer_359-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
            ['baseTex'] = {{0, 0.83333333333333}, },
            ['maskTex'] = {{0.03333333333333, 0.83333333333333}, },
        },
    },
    ['LumiSaturation_361-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiContrast_361-effect1'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiTritone_361-effect2'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiUnmult_361-effect3'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiWaveWarp_361-effect4'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiWaveWarp_361-effect5'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiLayer_361-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
            ['baseTex'] = {{0, 0.83333333333333}, },
            ['maskTex'] = {{0.03333333333333, 0.83333333333333}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_422-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.83333333333333}, },
            ['seqTex_1_1'] = {{0, 1}, },
        },
    },
    ['LumiSaturation_363-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiContrast_363-effect1'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiDistort_363-effect2'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiWaveWarp_363-effect3'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiUnmult_363-effect4'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiLayer_363-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
            ['baseTex'] = {{0, 0.83333333333333}, },
            ['maskTex'] = {{0.03333333333333, 0.83333333333333}, },
        },
    },
    ['LumiSaturation_365-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiContrast_365-effect1'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiDistort_365-effect2'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiWaveWarp_365-effect3'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiUnmult_365-effect4'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
        },
    },
    ['LumiLayer_365-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.6}, },
            ['baseTex'] = {{0, 0.83333333333333}, },
            ['maskTex'] = {{0.03333333333333, 0.83333333333333}, },
        },
    },
    ['LumiDistort_367-effect0'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.83333333333333}, },
        },
    },
    ['LumiLayer_367-blend'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.83333333333333}, },
            ['baseTex'] = {{0, 0.83333333333333}, },
        },
    },
    ['LumiLayer_368-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.7}, },
            ['baseTex'] = {{0, 0.83333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiAnimSeqLoadAndCrop_381-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 0,
        ['cropType_1_1'] = 1,
        ['edgeType_1_1'] = 0,
        ['enableVideoAlphaBlend_1_1'] = true,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 1,
        ['opacity_1_1'] = 1,
        ['speed_1_1'] = 1,
        ['playMode_1_1'] = 0,
        ['specify_9_16'] = false,
        ['animSeqType_9_16'] = 2,
        ['cropType_9_16'] = 1,
        ['edgeType_9_16'] = 0,
        ['enableVideoAlphaBlend_9_16'] = false,
        ['pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_9_16'] = 0,
        ['scale_9_16'] = 1,
        ['opacity_9_16'] = 1,
        ['speed_9_16'] = 1,
        ['playMode_9_16'] = 1,
        ['specify_16_9'] = false,
        ['animSeqType_16_9'] = 2,
        ['cropType_16_9'] = 1,
        ['edgeType_16_9'] = 0,
        ['enableVideoAlphaBlend_16_9'] = false,
        ['pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_16_9'] = 0,
        ['scale_16_9'] = 1,
        ['opacity_16_9'] = 1,
        ['speed_16_9'] = 1,
        ['playMode_16_9'] = 1,
        ['specify_5.8'] = false,
        ['animSeqType_5.8'] = 2,
        ['cropType_5.8'] = 1,
        ['edgeType_5.8'] = 0,
        ['enableVideoAlphaBlend_5.8'] = false,
        ['pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['position_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_5.8'] = 0,
        ['scale_5.8'] = 1,
        ['opacity_5.8'] = 1,
        ['speed_5.8'] = 1,
        ['playMode_5.8'] = 1,
        ['specify_2_1'] = false,
        ['animSeqType_2_1'] = 2,
        ['cropType_2_1'] = 1,
        ['edgeType_2_1'] = 0,
        ['enableVideoAlphaBlend_2_1'] = false,
        ['pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_2_1'] = 0,
        ['scale_2_1'] = 1,
        ['opacity_2_1'] = 1,
        ['speed_2_1'] = 1,
        ['playMode_2_1'] = 1,
        ['specify_3_4'] = false,
        ['animSeqType_3_4'] = 2,
        ['cropType_3_4'] = 1,
        ['edgeType_3_4'] = 0,
        ['enableVideoAlphaBlend_3_4'] = false,
        ['pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['position_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_3_4'] = 0,
        ['scale_3_4'] = 1,
        ['opacity_3_4'] = 1,
        ['speed_3_4'] = 1,
        ['playMode_3_4'] = 1,
        ['specify_4_3'] = false,
        ['animSeqType_4_3'] = 2,
        ['cropType_4_3'] = 1,
        ['edgeType_4_3'] = 0,
        ['enableVideoAlphaBlend_4_3'] = false,
        ['pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['position_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_4_3'] = 0,
        ['scale_4_3'] = 1,
        ['opacity_4_3'] = 1,
        ['speed_4_3'] = 1,
        ['playMode_4_3'] = 1,
        ['specify_1.85_1'] = false,
        ['animSeqType_1.85_1'] = 2,
        ['cropType_1.85_1'] = 1,
        ['edgeType_1.85_1'] = 0,
        ['enableVideoAlphaBlend_1.85_1'] = false,
        ['pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1.85_1'] = 0,
        ['scale_1.85_1'] = 1,
        ['opacity_1.85_1'] = 1,
        ['speed_1.85_1'] = 1,
        ['playMode_1.85_1'] = 1,
        ['specify_2.35_1'] = false,
        ['animSeqType_2.35_1'] = 2,
        ['cropType_2.35_1'] = 1,
        ['edgeType_2.35_1'] = 0,
        ['enableVideoAlphaBlend_2.35_1'] = false,
        ['pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_2.35_1'] = 0,
        ['scale_2.35_1'] = 1,
        ['opacity_2.35_1'] = 1,
        ['speed_2.35_1'] = 1,
        ['playMode_2.35_1'] = 1,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiContrast_356-effect0'] = {
        ['contrastIntensity'] = 1.2,
        ['pivot'] = 0.2,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_356-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(102.061158208069, 102.061158208069, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
    },
    ['LumiSaturation_357-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_357-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiSaturation_358-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiWaveWarp_358-effect1'] = {
        ['type'] = 0,
        ['amplitude'] = 0,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 0,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiDistort_358-effect2'] = {
        ['amount'] = 0.5,
        ['rotateWarpDir'] = 92,
        ['blurLens'] = 96,
        ['stride'] = 0.30000001192093,
        ['amountRelX'] = 1,
        ['amountRelY'] = 1,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['fine'] = false,
        ['quality'] = 0.25,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiWaveWarp_358-effect3'] = {
        ['type'] = 0,
        ['amplitude'] = 0,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 0,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_358-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiSaturation_359-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiContrast_359-effect1'] = {
        ['contrastIntensity'] = 2,
        ['pivot'] = 0.17,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiTritone_359-effect2'] = {
        ['highlightColor'] = Amaz.Color(0, 0, 0, 1),
        ['middleColor'] = Amaz.Color(0, 0, 0, 1),
        ['shadowColor'] = Amaz.Color(0.67058825492859, 0.67058825492859, 0.67058825492859, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiUnmult_359-effect3'] = {
        ['unmult'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiWaveWarp_359-effect4'] = {
        ['type'] = 0,
        ['amplitude'] = 0,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 0,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiWaveWarp_359-effect5'] = {
        ['type'] = 0,
        ['amplitude'] = 0,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 0,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_359-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 1,
        ['blendMode'] = 0,
    },
    ['LumiSaturation_361-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiContrast_361-effect1'] = {
        ['contrastIntensity'] = 2,
        ['pivot'] = 0.32,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiTritone_361-effect2'] = {
        ['highlightColor'] = Amaz.Color(0.83529412746429, 0.83529412746429, 0.83529412746429, 1),
        ['middleColor'] = Amaz.Color(0.90196079015732, 0.90196079015732, 0.90196079015732, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiUnmult_361-effect3'] = {
        ['unmult'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiWaveWarp_361-effect4'] = {
        ['type'] = 0,
        ['amplitude'] = 0,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 0,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiWaveWarp_361-effect5'] = {
        ['type'] = 0,
        ['amplitude'] = 0,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 0,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_361-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 1,
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLoadAndCrop_422-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 0,
        ['cropType_1_1'] = 1,
        ['edgeType_1_1'] = 0,
        ['enableVideoAlphaBlend_1_1'] = true,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 1,
        ['opacity_1_1'] = 1,
        ['speed_1_1'] = 1,
        ['playMode_1_1'] = 0,
        ['specify_9_16'] = false,
        ['animSeqType_9_16'] = 2,
        ['cropType_9_16'] = 1,
        ['edgeType_9_16'] = 0,
        ['enableVideoAlphaBlend_9_16'] = false,
        ['pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_9_16'] = 0,
        ['scale_9_16'] = 1,
        ['opacity_9_16'] = 1,
        ['speed_9_16'] = 1,
        ['playMode_9_16'] = 1,
        ['specify_16_9'] = false,
        ['animSeqType_16_9'] = 2,
        ['cropType_16_9'] = 1,
        ['edgeType_16_9'] = 0,
        ['enableVideoAlphaBlend_16_9'] = false,
        ['pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_16_9'] = 0,
        ['scale_16_9'] = 1,
        ['opacity_16_9'] = 1,
        ['speed_16_9'] = 1,
        ['playMode_16_9'] = 1,
        ['specify_5.8'] = false,
        ['animSeqType_5.8'] = 2,
        ['cropType_5.8'] = 1,
        ['edgeType_5.8'] = 0,
        ['enableVideoAlphaBlend_5.8'] = false,
        ['pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['position_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_5.8'] = 0,
        ['scale_5.8'] = 1,
        ['opacity_5.8'] = 1,
        ['speed_5.8'] = 1,
        ['playMode_5.8'] = 1,
        ['specify_2_1'] = false,
        ['animSeqType_2_1'] = 2,
        ['cropType_2_1'] = 1,
        ['edgeType_2_1'] = 0,
        ['enableVideoAlphaBlend_2_1'] = false,
        ['pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_2_1'] = 0,
        ['scale_2_1'] = 1,
        ['opacity_2_1'] = 1,
        ['speed_2_1'] = 1,
        ['playMode_2_1'] = 1,
        ['specify_3_4'] = false,
        ['animSeqType_3_4'] = 2,
        ['cropType_3_4'] = 1,
        ['edgeType_3_4'] = 0,
        ['enableVideoAlphaBlend_3_4'] = false,
        ['pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['position_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_3_4'] = 0,
        ['scale_3_4'] = 1,
        ['opacity_3_4'] = 1,
        ['speed_3_4'] = 1,
        ['playMode_3_4'] = 1,
        ['specify_4_3'] = false,
        ['animSeqType_4_3'] = 2,
        ['cropType_4_3'] = 1,
        ['edgeType_4_3'] = 0,
        ['enableVideoAlphaBlend_4_3'] = false,
        ['pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['position_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_4_3'] = 0,
        ['scale_4_3'] = 1,
        ['opacity_4_3'] = 1,
        ['speed_4_3'] = 1,
        ['playMode_4_3'] = 1,
        ['specify_1.85_1'] = false,
        ['animSeqType_1.85_1'] = 2,
        ['cropType_1.85_1'] = 1,
        ['edgeType_1.85_1'] = 0,
        ['enableVideoAlphaBlend_1.85_1'] = false,
        ['pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_1.85_1'] = 0,
        ['scale_1.85_1'] = 1,
        ['opacity_1.85_1'] = 1,
        ['speed_1.85_1'] = 1,
        ['playMode_1.85_1'] = 1,
        ['specify_2.35_1'] = false,
        ['animSeqType_2.35_1'] = 2,
        ['cropType_2.35_1'] = 1,
        ['edgeType_2.35_1'] = 0,
        ['enableVideoAlphaBlend_2.35_1'] = false,
        ['pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation_2.35_1'] = 0,
        ['scale_2.35_1'] = 1,
        ['opacity_2.35_1'] = 1,
        ['speed_2.35_1'] = 1,
        ['playMode_2.35_1'] = 1,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiSaturation_363-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiContrast_363-effect1'] = {
        ['contrastIntensity'] = 2,
        ['pivot'] = 0.54,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiDistort_363-effect2'] = {
        ['amount'] = 1,
        ['rotateWarpDir'] = 92,
        ['blurLens'] = 96,
        ['stride'] = 0.30000001192093,
        ['amountRelX'] = 1,
        ['amountRelY'] = 1,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['fine'] = false,
        ['quality'] = 0.25,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiWaveWarp_363-effect3'] = {
        ['type'] = 0,
        ['amplitude'] = -60,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 1,
        ['fixedType'] = 0,
        ['phase'] = 158,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiUnmult_363-effect4'] = {
        ['unmult'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_363-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiSaturation_365-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiContrast_365-effect1'] = {
        ['contrastIntensity'] = 2,
        ['pivot'] = 0.32,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiDistort_365-effect2'] = {
        ['amount'] = 1,
        ['rotateWarpDir'] = 92,
        ['blurLens'] = 96,
        ['stride'] = 0.30000001192093,
        ['amountRelX'] = 1,
        ['amountRelY'] = 1,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['fine'] = false,
        ['quality'] = 0.25,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiWaveWarp_365-effect3'] = {
        ['type'] = 0,
        ['amplitude'] = -60,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 10,
        ['fixedType'] = 0,
        ['phase'] = 159,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiUnmult_365-effect4'] = {
        ['unmult'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_365-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiDistort_367-effect0'] = {
        ['amount'] = 0,
        ['rotateWarpDir'] = -60,
        ['blurLens'] = 210,
        ['stride'] = 0.30000001192093,
        ['amountRelX'] = 1,
        ['amountRelY'] = 1,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['fine'] = false,
        ['quality'] = 0.25,
        ['AEDesignSize'] = Amaz.Vector2f(896, 504),
    },
    ['LumiLayer_367-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_368-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(448, 252, 0),
        ['position'] = Amaz.Vector3f(448, 252, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(896, 504),
        ['layerSize'] = Amaz.Vector2f(896, 504),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiAnimSeqLoadAndCrop_381-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.83333333333333, }, 
		{{0, }, {0.8, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiContrast_356-effect0#contrastIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.5, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiContrast_356-effect0#pivot#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.5, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_356-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.8, }, 
		{{105, 105, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiWaveWarp_358-effect1#amplitude#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.166667, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiWaveWarp_358-effect3#amplitude#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.166667, }, 
		{{20, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiWaveWarp_359-effect4#amplitude#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.166667, }, 
		{{-30, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiWaveWarp_359-effect5#amplitude#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.166667, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiWaveWarp_361-effect4#amplitude#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.166667, }, 
		{{-30, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiWaveWarp_361-effect5#amplitude#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.166667, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_422-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.83333333333333, }, 
		{{0, }, {0.8, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDistort_367-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.166667, }, 
		{{-0.3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_368-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.033333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.166667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.533333, 0.566667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.6, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = true
data.ae_reverseKeyframes = ae_reverseKeyframes

local ae_sliderInfos = {
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
