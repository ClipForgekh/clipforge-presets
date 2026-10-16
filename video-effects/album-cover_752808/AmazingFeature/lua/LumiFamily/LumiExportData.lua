local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiGaussianBlur_27-effect0'] = {
        ['nodeDuration'] = {{0, 1.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.43333333333333}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_367-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['seqTex_1_1'] = {{0, 1.43333333333333}, },
            ['seqTex_9_16'] = {{0, 1.43333333333333}, },
            ['seqTex_16_9'] = {{0, 1.43333333333333}, },
            ['seqTex_5.8'] = {{0, 1.43333333333333}, },
            ['seqTex_2_1'] = {{0, 1.43333333333333}, },
            ['seqTex_3_4'] = {{0, 1.43333333333333}, },
            ['seqTex_4_3'] = {{0, 1.43333333333333}, },
            ['seqTex_1.85_1'] = {{0, 1.43333333333333}, },
            ['seqTex_2.35_1'] = {{0, 1.43333333333333}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_246-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['seqTex_1_1'] = {{0, 1.56666666666667}, },
        },
    },
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0, 1.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.43333333333333}, },
        },
    },
    ['LumiLayer_246-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 1.43333333333333}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_349-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['seqTex_1_1'] = {{0, 3}, },
            ['seqTex_9_16'] = {{0, 3}, },
            ['seqTex_16_9'] = {{0, 3}, },
            ['seqTex_5.8'] = {{0, 3}, },
            ['seqTex_2_1'] = {{0, 3}, },
            ['seqTex_3_4'] = {{0, 3}, },
            ['seqTex_4_3'] = {{0, 3}, },
            ['seqTex_1.85_1'] = {{0, 3}, },
            ['seqTex_2.35_1'] = {{0, 3}, },
        },
    },
    ['LumiLayer_349-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_367-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
            ['maskTex'] = {{0, 3}, },
        },
    },
    ['LumiExposure_285-effect1'] = {
        ['nodeDuration'] = {{1.43333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.43333333333333, 3}, },
        },
    },
    ['LumiRadialBlur_285-effect2'] = {
        ['nodeDuration'] = {{1.43333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.43333333333333, 3}, },
        },
    },
    ['LumiLayer_285-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.43333333333333, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGaussianBlur_27-effect0'] = {
        ['blurIntensity'] = 26,
        ['quality'] = 0.4,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiAnimSeqLoadAndCrop_367-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 2,
        ['cropType_1_1'] = 2,
        ['edgeType_1_1'] = 3,
        ['enableVideoAlphaBlend_1_1'] = false,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.5, 0.58703703703704),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.5, 0.58703703703704),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 0.35,
        ['opacity_1_1'] = 1,
        ['speed_1_1'] = 1,
        ['playMode_1_1'] = 0,
        ['specify_9_16'] = true,
        ['animSeqType_9_16'] = 2,
        ['cropType_9_16'] = 2,
        ['edgeType_9_16'] = 3,
        ['enableVideoAlphaBlend_9_16'] = false,
        ['pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['position_9_16'] = Amaz.Vector2f(0.5, 0.5462962962963),
        ['ae_pre_position_9_16'] = Amaz.Vector2f(0.5, 0.5462962962963),
        ['rotation_9_16'] = 0,
        ['scale_9_16'] = 0.34,
        ['opacity_9_16'] = 1,
        ['speed_9_16'] = 1,
        ['playMode_9_16'] = 0,
        ['specify_16_9'] = true,
        ['animSeqType_16_9'] = 2,
        ['cropType_16_9'] = 2,
        ['edgeType_16_9'] = 3,
        ['enableVideoAlphaBlend_16_9'] = false,
        ['pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['position_16_9'] = Amaz.Vector2f(0.5, 0.58994752577949),
        ['ae_pre_position_16_9'] = Amaz.Vector2f(0.5, 0.58994752577949),
        ['rotation_16_9'] = 0,
        ['scale_16_9'] = 0.33,
        ['opacity_16_9'] = 1,
        ['speed_16_9'] = 1,
        ['playMode_16_9'] = 0,
        ['specify_5.8'] = true,
        ['animSeqType_5.8'] = 2,
        ['cropType_5.8'] = 2,
        ['edgeType_5.8'] = 3,
        ['enableVideoAlphaBlend_5.8'] = false,
        ['pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['position_5.8'] = Amaz.Vector2f(0.5, 0.54259259259259),
        ['ae_pre_position_5.8'] = Amaz.Vector2f(0.5, 0.54259259259259),
        ['rotation_5.8'] = 0,
        ['scale_5.8'] = 0.35,
        ['opacity_5.8'] = 1,
        ['speed_5.8'] = 1,
        ['playMode_5.8'] = 0,
        ['specify_2_1'] = true,
        ['animSeqType_2_1'] = 2,
        ['cropType_2_1'] = 2,
        ['edgeType_2_1'] = 3,
        ['enableVideoAlphaBlend_2_1'] = false,
        ['pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2_1'] = Amaz.Vector2f(0.5, 0.59444444444444),
        ['ae_pre_position_2_1'] = Amaz.Vector2f(0.5, 0.59444444444444),
        ['rotation_2_1'] = 0,
        ['scale_2_1'] = 0.35,
        ['opacity_2_1'] = 1,
        ['speed_2_1'] = 1,
        ['playMode_2_1'] = 0,
        ['specify_3_4'] = true,
        ['animSeqType_3_4'] = 2,
        ['cropType_3_4'] = 2,
        ['edgeType_3_4'] = 3,
        ['enableVideoAlphaBlend_3_4'] = false,
        ['pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['position_3_4'] = Amaz.Vector2f(0.5, 0.575),
        ['ae_pre_position_3_4'] = Amaz.Vector2f(0.5, 0.575),
        ['rotation_3_4'] = 0,
        ['scale_3_4'] = 0.36,
        ['opacity_3_4'] = 1,
        ['speed_3_4'] = 1,
        ['playMode_3_4'] = 0,
        ['specify_4_3'] = true,
        ['animSeqType_4_3'] = 2,
        ['cropType_4_3'] = 2,
        ['edgeType_4_3'] = 3,
        ['enableVideoAlphaBlend_4_3'] = false,
        ['pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['position_4_3'] = Amaz.Vector2f(0.5, 0.60555555555556),
        ['ae_pre_position_4_3'] = Amaz.Vector2f(0.5, 0.60555555555556),
        ['rotation_4_3'] = 0,
        ['scale_4_3'] = 0.39,
        ['opacity_4_3'] = 1,
        ['speed_4_3'] = 1,
        ['playMode_4_3'] = 0,
        ['specify_1.85_1'] = true,
        ['animSeqType_1.85_1'] = 2,
        ['cropType_1.85_1'] = 2,
        ['edgeType_1.85_1'] = 3,
        ['enableVideoAlphaBlend_1.85_1'] = false,
        ['pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1.85_1'] = Amaz.Vector2f(0.5, 0.59651192288179),
        ['ae_pre_position_1.85_1'] = Amaz.Vector2f(0.5, 0.59651192288179),
        ['rotation_1.85_1'] = 0,
        ['scale_1.85_1'] = 0.34,
        ['opacity_1.85_1'] = 1,
        ['speed_1.85_1'] = 1,
        ['playMode_1.85_1'] = 0,
        ['specify_2.35_1'] = true,
        ['animSeqType_2.35_1'] = 2,
        ['cropType_2.35_1'] = 2,
        ['edgeType_2.35_1'] = 3,
        ['enableVideoAlphaBlend_2.35_1'] = false,
        ['pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2.35_1'] = Amaz.Vector2f(0.5, 0.6037037037037),
        ['ae_pre_position_2.35_1'] = Amaz.Vector2f(0.5, 0.6037037037037),
        ['rotation_2.35_1'] = 0,
        ['scale_2.35_1'] = 0.34,
        ['opacity_2.35_1'] = 1,
        ['speed_2.35_1'] = 1,
        ['playMode_2.35_1'] = 0,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiAnimSeqLoadAndCrop_246-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 1,
        ['cropType_1_1'] = 2,
        ['edgeType_1_1'] = 3,
        ['enableVideoAlphaBlend_1_1'] = false,
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
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_246-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540.785129573147, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLoadAndCrop_349-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 2,
        ['cropType_1_1'] = 2,
        ['edgeType_1_1'] = 3,
        ['enableVideoAlphaBlend_1_1'] = false,
        ['pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1_1'] = Amaz.Vector2f(0.5, 0.58703703703704),
        ['ae_pre_position_1_1'] = Amaz.Vector2f(0.5, 0.58703703703704),
        ['rotation_1_1'] = 0,
        ['scale_1_1'] = 0.35,
        ['opacity_1_1'] = 1,
        ['speed_1_1'] = 1,
        ['playMode_1_1'] = 0,
        ['specify_9_16'] = true,
        ['animSeqType_9_16'] = 2,
        ['cropType_9_16'] = 2,
        ['edgeType_9_16'] = 3,
        ['enableVideoAlphaBlend_9_16'] = false,
        ['pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_9_16'] = Amaz.Vector2f(0.5, 0.5),
        ['position_9_16'] = Amaz.Vector2f(0.5, 0.5462962962963),
        ['ae_pre_position_9_16'] = Amaz.Vector2f(0.5, 0.5462962962963),
        ['rotation_9_16'] = 0,
        ['scale_9_16'] = 0.34,
        ['opacity_9_16'] = 1,
        ['speed_9_16'] = 1,
        ['playMode_9_16'] = 0,
        ['specify_16_9'] = true,
        ['animSeqType_16_9'] = 2,
        ['cropType_16_9'] = 2,
        ['edgeType_16_9'] = 3,
        ['enableVideoAlphaBlend_16_9'] = false,
        ['pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_16_9'] = Amaz.Vector2f(0.5, 0.5),
        ['position_16_9'] = Amaz.Vector2f(0.5, 0.58994752577949),
        ['ae_pre_position_16_9'] = Amaz.Vector2f(0.5, 0.58994752577949),
        ['rotation_16_9'] = 0,
        ['scale_16_9'] = 0.33,
        ['opacity_16_9'] = 1,
        ['speed_16_9'] = 1,
        ['playMode_16_9'] = 0,
        ['specify_5.8'] = true,
        ['animSeqType_5.8'] = 2,
        ['cropType_5.8'] = 2,
        ['edgeType_5.8'] = 3,
        ['enableVideoAlphaBlend_5.8'] = false,
        ['pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_5.8'] = Amaz.Vector2f(0.5, 0.5),
        ['position_5.8'] = Amaz.Vector2f(0.5, 0.54259259259259),
        ['ae_pre_position_5.8'] = Amaz.Vector2f(0.5, 0.54259259259259),
        ['rotation_5.8'] = 0,
        ['scale_5.8'] = 0.35,
        ['opacity_5.8'] = 1,
        ['speed_5.8'] = 1,
        ['playMode_5.8'] = 0,
        ['specify_2_1'] = true,
        ['animSeqType_2_1'] = 2,
        ['cropType_2_1'] = 2,
        ['edgeType_2_1'] = 3,
        ['enableVideoAlphaBlend_2_1'] = false,
        ['pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2_1'] = Amaz.Vector2f(0.5, 0.59444444444444),
        ['ae_pre_position_2_1'] = Amaz.Vector2f(0.5, 0.59444444444444),
        ['rotation_2_1'] = 0,
        ['scale_2_1'] = 0.35,
        ['opacity_2_1'] = 1,
        ['speed_2_1'] = 1,
        ['playMode_2_1'] = 0,
        ['specify_3_4'] = true,
        ['animSeqType_3_4'] = 2,
        ['cropType_3_4'] = 2,
        ['edgeType_3_4'] = 3,
        ['enableVideoAlphaBlend_3_4'] = false,
        ['pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_3_4'] = Amaz.Vector2f(0.5, 0.5),
        ['position_3_4'] = Amaz.Vector2f(0.5, 0.575),
        ['ae_pre_position_3_4'] = Amaz.Vector2f(0.5, 0.575),
        ['rotation_3_4'] = 0,
        ['scale_3_4'] = 0.36,
        ['opacity_3_4'] = 1,
        ['speed_3_4'] = 1,
        ['playMode_3_4'] = 0,
        ['specify_4_3'] = true,
        ['animSeqType_4_3'] = 2,
        ['cropType_4_3'] = 2,
        ['edgeType_4_3'] = 3,
        ['enableVideoAlphaBlend_4_3'] = false,
        ['pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_4_3'] = Amaz.Vector2f(0.5, 0.5),
        ['position_4_3'] = Amaz.Vector2f(0.5, 0.60555555555556),
        ['ae_pre_position_4_3'] = Amaz.Vector2f(0.5, 0.60555555555556),
        ['rotation_4_3'] = 0,
        ['scale_4_3'] = 0.39,
        ['opacity_4_3'] = 1,
        ['speed_4_3'] = 1,
        ['playMode_4_3'] = 0,
        ['specify_1.85_1'] = true,
        ['animSeqType_1.85_1'] = 2,
        ['cropType_1.85_1'] = 2,
        ['edgeType_1.85_1'] = 3,
        ['enableVideoAlphaBlend_1.85_1'] = false,
        ['pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_1.85_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_1.85_1'] = Amaz.Vector2f(0.5, 0.59651192288179),
        ['ae_pre_position_1.85_1'] = Amaz.Vector2f(0.5, 0.59651192288179),
        ['rotation_1.85_1'] = 0,
        ['scale_1.85_1'] = 0.34,
        ['opacity_1.85_1'] = 1,
        ['speed_1.85_1'] = 1,
        ['playMode_1.85_1'] = 0,
        ['specify_2.35_1'] = true,
        ['animSeqType_2.35_1'] = 2,
        ['cropType_2.35_1'] = 2,
        ['edgeType_2.35_1'] = 3,
        ['enableVideoAlphaBlend_2.35_1'] = false,
        ['pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_pivot_2.35_1'] = Amaz.Vector2f(0.5, 0.5),
        ['position_2.35_1'] = Amaz.Vector2f(0.5, 0.6037037037037),
        ['ae_pre_position_2.35_1'] = Amaz.Vector2f(0.5, 0.6037037037037),
        ['rotation_2.35_1'] = 0,
        ['scale_2.35_1'] = 0.34,
        ['opacity_2.35_1'] = 1,
        ['speed_2.35_1'] = 1,
        ['playMode_2.35_1'] = 0,
        ['globalRotation'] = 0,
        ['globalScale'] = 1,
        ['globalOpacity'] = 1,
        ['globalSpeed'] = 1,
        ['lite_mode'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_349-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540.785129573147, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_367-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540.785129573147, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiExposure_285-effect1'] = {
        ['channelType'] = 0,
        ['exposure'] = 3,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiRadialBlur_285-effect2'] = {
        ['blurType'] = 1,
        ['amount'] = 25,
        ['quality'] = 0.10000000149012,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 1,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_285-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(300, 300, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = true,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_1_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.58703703703704, }, {0.5, 0.5, }, {0.5, 0.57253086390319, }, {0.5, 0.51450617313385, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_1_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.58703703703704, }, {0.5, 0.5, }, {0.5, 0.57253086390319, }, {0.5, 0.51450617313385, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_1_1#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.35, }, {0.58, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_9_16#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.5462962962963, }, {0.5, 0.5, }, {0.5, 0.53858024720793, }, {0.5, 0.50771604908837, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_9_16#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.5462962962963, }, {0.5, 0.5, }, {0.5, 0.53858024720792, }, {0.5, 0.50771604908837, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_9_16#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.34, }, {0.57, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_16_9#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.58994752577963, }, {0.5, 0.5, }, {0.5, 0.5749562706199, }, {0.5, 0.51499125515973, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_16_9#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.58994752577963, }, {0.5, 0.5, }, {0.5, 0.5749562706199, }, {0.5, 0.51499125515973, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_16_9#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.33, }, {0.56, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_5.8#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.54259259259259, }, {0.5, 0.5, }, {0.5, 0.53549382730766, }, {0.5, 0.50709876528493, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_5.8#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.54259259259259, }, {0.5, 0.5, }, {0.5, 0.53549382730767, }, {0.5, 0.50709876528493, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_5.8#number'] =
{
	{
		{0.526424052, 1.95e-7, 0, 1.000000078, }, 
		{0.766667, 1.4, }, 
		{{0.35, }, {0.78, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_2_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.59444444444444, }, {0.5, 0.5, }, {0.5, 0.5787037037037, }, {0.5, 0.51574074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_2_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.59444444444444, }, {0.5, 0.5, }, {0.5, 0.5787037037037, }, {0.5, 0.51574074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_2_1#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.35, }, {0.58, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_3_4#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.575, }, {0.5, 0.5, }, {0.5, 0.5625, }, {0.5, 0.5125, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_3_4#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.575, }, {0.5, 0.5, }, {0.5, 0.5625, }, {0.5, 0.5125, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_3_4#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.36, }, {0.59, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_4_3#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.60555555555556, }, {0.5, 0.5, }, {0.5, 0.58796296296297, }, {0.5, 0.51759259259259, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_4_3#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.60555555555556, }, {0.5, 0.5, }, {0.5, 0.58796296296296, }, {0.5, 0.51759259259259, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_4_3#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.39, }, {0.62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_1.85_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.59651192288148, }, {0.5, 0.5, }, {0.5, 0.58042660194959, }, {0.5, 0.51608532093189, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_1.85_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.59651192288148, }, {0.5, 0.5, }, {0.5, 0.58042660194959, }, {0.5, 0.51608532093189, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_1.85_1#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.34, }, {0.57, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#ae_pre_position_2.35_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.6037037037037, }, {0.5, 0.5, }, {0.5, 0.5864197536751, }, {0.5, 0.5172839500286, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#position_2.35_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.6037037037037, }, {0.5, 0.5, }, {0.5, 0.58641975367511, }, {0.5, 0.5172839500286, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_367-effect0#scale_2.35_1#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.34, }, {0.57, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_246-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 3, }, 
		{{0, }, {3, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_27-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.333333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_246-trs-blend#position#vector'] =
{
	{
		{0.440914, 0, 0.05528, 1, }, 
		{0, 0.766667, }, 
		{{540, 1632, 0, }, {540, 540, 0, }, {540, 1450, 0, }, {540, 722, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_246-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.666667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_1_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.58703703703704, }, {0.5, 0.5, }, {0.5, 0.57253086390319, }, {0.5, 0.51450617313385, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_1_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.58703703703704, }, {0.5, 0.5, }, {0.5, 0.57253086390319, }, {0.5, 0.51450617313385, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_1_1#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.35, }, {0.58, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_9_16#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.5462962962963, }, {0.5, 0.5, }, {0.5, 0.53858024720793, }, {0.5, 0.50771604908837, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_9_16#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.5462962962963, }, {0.5, 0.5, }, {0.5, 0.53858024720792, }, {0.5, 0.50771604908837, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_9_16#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.34, }, {0.57, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_16_9#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.58994752577963, }, {0.5, 0.5, }, {0.5, 0.5749562706199, }, {0.5, 0.51499125515973, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_16_9#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.58994752577963, }, {0.5, 0.5, }, {0.5, 0.5749562706199, }, {0.5, 0.51499125515973, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_16_9#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.33, }, {0.56, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_5.8#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.54259259259259, }, {0.5, 0.5, }, {0.5, 0.53549382730766, }, {0.5, 0.50709876528493, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_5.8#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.54259259259259, }, {0.5, 0.5, }, {0.5, 0.53549382730767, }, {0.5, 0.50709876528493, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_5.8#number'] =
{
	{
		{0.526424052, 1.95e-7, 0, 1.000000078, }, 
		{0.766667, 1.4, }, 
		{{0.35, }, {0.78, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_2_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.59444444444444, }, {0.5, 0.5, }, {0.5, 0.5787037037037, }, {0.5, 0.51574074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_2_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.59444444444444, }, {0.5, 0.5, }, {0.5, 0.5787037037037, }, {0.5, 0.51574074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_2_1#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.35, }, {0.58, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_3_4#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.575, }, {0.5, 0.5, }, {0.5, 0.5625, }, {0.5, 0.5125, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_3_4#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.575, }, {0.5, 0.5, }, {0.5, 0.5625, }, {0.5, 0.5125, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_3_4#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.36, }, {0.59, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_4_3#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.60555555555556, }, {0.5, 0.5, }, {0.5, 0.58796296296297, }, {0.5, 0.51759259259259, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_4_3#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.60555555555556, }, {0.5, 0.5, }, {0.5, 0.58796296296296, }, {0.5, 0.51759259259259, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_4_3#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.39, }, {0.62, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_1.85_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.59651192288148, }, {0.5, 0.5, }, {0.5, 0.58042660194959, }, {0.5, 0.51608532093189, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_1.85_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.59651192288148, }, {0.5, 0.5, }, {0.5, 0.58042660194959, }, {0.5, 0.51608532093189, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_1.85_1#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.34, }, {0.57, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#ae_pre_position_2.35_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.80000033333333, 1.43333333333333, }, 
		{{0.5, 0.6037037037037, }, {0.5, 0.5, }, {0.5, 0.5864197536751, }, {0.5, 0.5172839500286, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#position_2.35_1#vector'] =
{
	{
		{0.526424, 0, 0, 1, }, 
		{0.766667, 1.4, }, 
		{{0.5, 0.6037037037037, }, {0.5, 0.5, }, {0.5, 0.58641975367511, }, {0.5, 0.5172839500286, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_349-effect0#scale_2.35_1#number'] =
{
	{
		{0.526424052, 3.64e-7, 0, 1.000000147, }, 
		{0.766667, 1.4, }, 
		{{0.34, }, {0.57, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_349-trs#position#vector'] =
{
	{
		{0.440914, 0, 0.05528, 1, }, 
		{0, 0.766667, }, 
		{{540, 1632, 0, }, {540, 540, 0, }, {540, 1450, 0, }, {540, 722, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_349-trs#yRotation#number'] =
{
	{
		{0.544072987, -9e-8, 0.091185419, 1.000000267, }, 
		{0.766667, 1.4, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_367-trs-matte-blend#position#vector'] =
{
	{
		{0.440914, 0, 0.05528, 1, }, 
		{0, 0.766667, }, 
		{{540, 1632, 0, }, {540, 540, 0, }, {540, 1450, 0, }, {540, 722, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_367-trs-matte-blend#yRotation#number'] =
{
	{
		{0.544072987, -9e-8, 0.091185419, 1.000000267, }, 
		{0.766667, 1.4, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiExposure_285-effect1#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.833333, }, 
		{{3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRadialBlur_285-effect2#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.666667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_285-trs-blend#position#vector'] =
{
	{
		{0, 0, 0.404297, 0.989797, }, 
		{1.433333, 1.47334, }, 
		{{540, 540, 0, }, {568.875945414, 551.153922042, 0, }, {530.399709701538, 537.04882478714, 0, }, {549.576302851134, 575.906458815682, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.29501, 0.002439, 0.636962, 0.996998, }, 
		{1.47334, 1.513346, }, 
		{{568.875945414, 551.153922042, 0, }, {496.134488824, 501.360877545, 0, }, {583.669756258421, 532.1802892295, 0, }, {526.16399550735, 503.349880011202, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.322729, 0.002303, 0.662107, 0.997589, }, 
		{1.513346, 1.55332, }, 
		{{496.134488824, 501.360877545, 0, }, {563.436212163, 573.865267195, 0, }, {473.163934472193, 499.839424402834, 0, }, {582.368085484533, 597.615133680596, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.341076, 0.003125, 0.680637, 0.997073, }, 
		{1.55332, 1.593327, }, 
		{{563.436212163, 573.865267195, 0, }, {534.161166544, 535.176145252, 0, }, {524.347573857336, 524.828920759453, 0, }, {546.933171625177, 488.38081901909, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.370167, 0.013884, 0.713198, 0.989242, }, 
		{1.593327, 1.666667, }, 
		{{534.161166544, 535.176145252, 0, }, {502.277666047, 537.205510493, 0, }, {529.068943376581, 553.833532031785, 0, }, {537.996286347293, 526.122501726826, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.370166, 0.012179, 0.193778, 1, }, 
		{1.666667, 1.766667, }, 
		{{502.277666047, 537.205510493, 0, }, {540, 540, 0, }, {485.454421952151, 542.42553746291, 0, }, {492.639060974121, 561.126127243042, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_285-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0,0,0.66666667, 0.999999994,0.999999994,0.66666667, }, 
		{1.433333, 1.666667, }, 
		{{300, 300, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_285-trs-blend#rotation#number'] =
{
	{
		{0, 0, 0.41225799, 0.237573903, }, 
		{1.433333, 1.47334, }, 
		{{0, }, {3.800928, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.298423721, -1.085161419, 0.642088297, 0.579065037, }, 
		{1.47334, 1.513346, }, 
		{{3.800928, }, {2.44499, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.329316103, 0.129648006, 0.670683897, 1.044729741, }, 
		{1.513346, 1.55332, }, 
		{{2.44499, }, {-1.602374, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.357911703, 0.438734552, 0.701576279, 4.060754844, }, 
		{1.55332, 1.6, }, 
		{{-1.602374, }, {-1.078677, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.58774201, -4.179766645, 0.201556047, 1.000000577, }, 
		{1.6, 1.666667, }, 
		{{-1.078677, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_285-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.333333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = false
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
