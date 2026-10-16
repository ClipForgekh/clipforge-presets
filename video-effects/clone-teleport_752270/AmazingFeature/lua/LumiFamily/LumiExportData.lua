local data = {}

local ae_compDurations = {0, 1.66666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiVignette_73-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_73-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiSGlow_137-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_137-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiTritone_92-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_91-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_92-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_89-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiTritone_90-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_90-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_87-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiTritone_88-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_88-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_85-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiTritone_86-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_86-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_27-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiAnimSeqLoadAndCrop_134-effect0'] = {
        ['nodeDuration'] = {{1.06666666666667, 4.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.06666666666667, 4.06666666666667}, },
            ['seqTex_1_1'] = {{1.06666666666667, 1.6}, },
        },
    },
    ['LumiLayer_84-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_134-blend'] = {
        ['nodeDuration'] = {{0, 4.06666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.06666666666667, 4.06666666666667}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiVignette_73-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['amount'] = 1,
        ['midpoint'] = 0,
        ['roundness'] = -1,
        ['feather'] = 0,
        ['highlight'] = 0,
        ['transparent'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_73-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 0),
        ['scale'] = Amaz.Vector3f(80, 80, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
    },
    ['LumiSGlow_137-effect1'] = {
        ['brightness'] = 3,
        ['glowColor'] = Amaz.Color(1, 0, 0.8376470208168, 1),
        ['threshold'] = 0.5,
        ['thresholdAddColor'] = Amaz.Color(0, 0, 0, 1),
        ['glowWidth'] = 0.1,
        ['widthX'] = 1,
        ['widthY'] = 1,
        ['widthRed'] = 1,
        ['widthGreen'] = 1.20000004768372,
        ['widthBlue'] = 1.39999997615814,
        ['show'] = 0,
        ['combine'] = 0,
        ['edgeMode'] = 1,
        ['glowFromAlpha'] = 0,
        ['glowUnderSource'] = 0,
        ['sourceOpacity'] = 1,
        ['dither'] = 0,
        ['quality'] = 0.1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_137-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiTritone_92-effect0'] = {
        ['highlightColor'] = Amaz.Color(1, 1, 1, 1),
        ['middleColor'] = Amaz.Color(0.07058766484261, 0, 1, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_91-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(-528.144497392303, -540.204684965249, 2889.40849216568),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_92-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 0),
        ['scale'] = Amaz.Vector3f(125, 125, 125),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['p0_anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['p0_position'] = Amaz.Vector3f(-528.144497392303, -540.204684965249, 2889.40849216568),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 12,
    },
    ['LumiLayer_89-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(1070.41382286285, 2095.15090144374, 2971.39297097245),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTritone_90-effect0'] = {
        ['highlightColor'] = Amaz.Color(1, 1, 1, 1),
        ['middleColor'] = Amaz.Color(0.16941197216511, 1, 0, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_90-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 0),
        ['scale'] = Amaz.Vector3f(125, 125, 125),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['p0_anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['p0_position'] = Amaz.Vector3f(1070.41382286285, 2095.15090144374, 2971.39297097245),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 12,
    },
    ['LumiLayer_87-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(1048.61536165233, -107.966141825668, -310.960034149834),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTritone_88-effect0'] = {
        ['highlightColor'] = Amaz.Color(1, 1, 1, 1),
        ['middleColor'] = Amaz.Color(1, 0.7011775970459, 0, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_88-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 0),
        ['scale'] = Amaz.Vector3f(125, 125, 125),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['p0_anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['p0_position'] = Amaz.Vector3f(1048.61536165233, -107.966141825668, -310.960034149834),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 12,
    },
    ['LumiLayer_85-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(-343.948062978905, 893.8551754075, -311.409516368586),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTritone_86-effect0'] = {
        ['highlightColor'] = Amaz.Color(1, 1, 1, 1),
        ['middleColor'] = Amaz.Color(0, 0.79529368877411, 1, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_86-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 0),
        ['scale'] = Amaz.Vector3f(125, 125, 125),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['p0_anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['p0_position'] = Amaz.Vector3f(-343.948062978905, 893.8551754075, -311.409516368586),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 12,
    },
    ['LumiLayer_27-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 704.646957045014),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiAnimSeqLoadAndCrop_134-effect0'] = {
        ['specify_1_1'] = true,
        ['animSeqType_1_1'] = 0,
        ['cropType_1_1'] = 1,
        ['edgeType_1_1'] = 0,
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
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_84-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 0),
        ['scale'] = Amaz.Vector3f(125, 125, 125),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['p0_anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['p0_position'] = Amaz.Vector3f(360, 640, 704.646957045014),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 12,
    },
    ['LumiLayer_134-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 12,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_91-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.833333, }, 
		{{-476.012486905, -449.182984285, 2304.329721657, }, {-664.73168811, -778.683851105, 4422.329721657, }, {-507.465686291597, -504.099797181728, 2657.329721657, }, {-664.73168811, -778.683851105, 4422.329721657, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.833333, 1.066667, }, 
		{{-664.73168811, -778.683851105, 4422.329721657, }, {-130.285117271, -2629.829608649, 4851.114440453, }, {-664.73168811, -778.683851105, 4422.329721657, }, {-301.382590415531, -2865.55711719392, 4672.94776870007, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.066667, 1.333333, }, 
		{{-130.285117271, -2629.829608649, 4851.114440453, }, {361.853162195, 635.681184853, 5491.329725575, }, {40.8123558735313, -2394.10210010408, 5029.28111220593, }, {279.830113794121, 91.4294148334687, 5384.62718040898, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_91-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.833333, 1.333333, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_91-trs#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.833333, 1.333333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_92-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.833333, }, 
		{{-476.012486905, -449.182984285, 2304.329721657, }, {-664.73168811, -778.683851105, 4422.329721657, }, {-507.465686291597, -504.099797181728, 2657.329721657, }, {-664.73168811, -778.683851105, 4422.329721657, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.833333, 1.066667, }, 
		{{-664.73168811, -778.683851105, 4422.329721657, }, {-130.285117271, -2629.829608649, 4851.114440453, }, {-664.73168811, -778.683851105, 4422.329721657, }, {-301.382590415531, -2865.55711719392, 4672.94776870007, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.066667, 1.333333, }, 
		{{-130.285117271, -2629.829608649, 4851.114440453, }, {361.853162195, 635.681184853, 5491.329725575, }, {40.8123558735313, -2394.10210010408, 5029.28111220593, }, {279.830113794121, 91.4294148334687, 5384.62718040898, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_92-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.833333, 1.333333, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_92-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.833333, 1.333333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_89-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.733333, }, 
		{{1070.413822863, 2095.150901444, 2304.329721657, }, {1070.413822863, 2095.150901444, 4422.329721657, }, {1070.413822863, 2095.150901444, 2657.329721657, }, {1070.413822863, 2095.150901444, 4422.329721657, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.733333, 0.966667, }, 
		{{1070.413822863, 2095.150901444, 4422.329721657, }, {621.873167681, 244.005143899, 4851.114440453, }, {1070.413822863, 2095.150901444, 4422.329721657, }, {740.721754717133, 486.47226120857, 4672.94776870007, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.966667, 1.233333, }, 
		{{621.873167681, 244.005143899, 4851.114440453, }, {357.322307264, 640.348199376, 5491.32972409, }, {503.024580644867, 1.53802658942968, 5029.28111220593, }, {401.414115583092, 574.291024693383, 5384.62717892398, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_89-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.733333, 1.233333, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_89-trs-blend#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.733333, 1.233333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_90-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.733333, }, 
		{{1070.413822863, 2095.150901444, 2304.329721657, }, {1070.413822863, 2095.150901444, 4422.329721657, }, {1070.413822863, 2095.150901444, 2657.329721657, }, {1070.413822863, 2095.150901444, 4422.329721657, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.733333, 0.966667, }, 
		{{1070.413822863, 2095.150901444, 4422.329721657, }, {621.873167681, 244.005143899, 4851.114440453, }, {1070.413822863, 2095.150901444, 4422.329721657, }, {740.721754717133, 486.47226120857, 4672.94776870007, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.966667, 1.233333, }, 
		{{621.873167681, 244.005143899, 4851.114440453, }, {357.322307264, 640.348199376, 5491.32972409, }, {503.024580644867, 1.53802658942968, 5029.28111220593, }, {401.414115583092, 574.291024693383, 5384.62717892398, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_90-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.733333, 1.233333, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_90-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.733333, 1.233333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_87-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.9, }, 
		{{1048.615361652, -107.966141826, -851.4359339, }, {1048.615361652, -107.966141826, 1266.5640661, }, {1048.615361652, -107.966141826, -498.4359339, }, {1048.615361652, -107.966141826, 1266.5640661, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.9, 1.133333, }, 
		{{1048.615361652, -107.966141826, 1266.5640661, }, {600.07470647, -882.600576906, 1865.594636893, }, {1048.615361652, -107.966141826, 1266.5640661, }, {714.595740710723, -1007.07338574389, 1687.42796514007, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.133333, 1.4, }, 
		{{600.07470647, -882.600576906, 1865.594636893, }, {361.489164951, 638.870721646, 2335.564066617, }, {485.553672229277, -758.127768068109, 2043.76130864593, }, {401.253420474682, 385.292169399906, 2257.23582717608, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_87-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.9, 1.4, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_87-trs-blend#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.9, 1.4, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_88-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.9, }, 
		{{1048.615361652, -107.966141826, -851.4359339, }, {1048.615361652, -107.966141826, 1266.5640661, }, {1048.615361652, -107.966141826, -498.4359339, }, {1048.615361652, -107.966141826, 1266.5640661, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.9, 1.133333, }, 
		{{1048.615361652, -107.966141826, 1266.5640661, }, {600.07470647, -882.600576906, 1865.594636893, }, {1048.615361652, -107.966141826, 1266.5640661, }, {714.595740710723, -1007.07338574389, 1687.42796514007, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.133333, 1.4, }, 
		{{600.07470647, -882.600576906, 1865.594636893, }, {361.489164951, 638.870721646, 2335.564066617, }, {485.553672229277, -758.127768068109, 2043.76130864593, }, {401.253420474682, 385.292169399906, 2257.23582717608, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_88-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.9, 1.4, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_88-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.9, 1.4, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_85-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.8, }, 
		{{-379.320000015, 893.855175407, -763.4359339, }, {-256.53443245, 893.855175407, 805.670111227, }, {-358.855738006333, 893.855175407, -501.918264222266, }, {-256.53443245, 893.855175407, 805.670111227, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.8, 1.033333, }, 
		{{-256.53443245, 893.855175407, 805.670111227, }, {70.350846047, -233.759779739, 1348.878258971, }, {-256.53443245, 893.855175407, 805.670111227, }, {-32.827262168332, -191.260256576158, 1170.71158721807, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.033333, 1.3, }, 
		{{70.350846047, -233.759779739, 1348.878258971, }, {362.534236113, 638.858030998, 1874.670110737, }, {173.528954262332, -276.259302901842, 1527.04493072393, }, {313.837004820275, 493.421736442336, 1787.0381374704, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_85-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.8, 1.3, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_85-trs-blend#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.8, 1.3, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_86-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.8, }, 
		{{-379.320000015, 893.855175407, -763.4359339, }, {-256.53443245, 893.855175407, 805.670111227, }, {-358.855738006333, 893.855175407, -501.918264222266, }, {-256.53443245, 893.855175407, 805.670111227, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.8, 1.033333, }, 
		{{-256.53443245, 893.855175407, 805.670111227, }, {70.350846047, -233.759779739, 1348.878258971, }, {-256.53443245, 893.855175407, 805.670111227, }, {-32.827262168332, -191.260256576158, 1170.71158721807, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.033333, 1.3, }, 
		{{70.350846047, -233.759779739, 1348.878258971, }, {362.534236113, 638.858030998, 1874.670110737, }, {173.528954262332, -276.259302901842, 1527.04493072393, }, {313.837004820275, 493.421736442336, 1787.0381374704, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_86-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.8, 1.3, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_86-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.8, 1.3, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.666667, }, 
		{{360, 640, 0, }, {360, 640, 2030, }, {360, 640, 338.333343505859, }, {360, 640, 2030, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.666667, 0.9, }, 
		{{360, 640, 2030, }, {360, -487.614955147, 2573.208147918, }, {360, 640, 2030, }, {360, -483.112621982785, 2395.04147616507, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.9, 1.166667, }, 
		{{360, -487.614955147, 2573.208147918, }, {360, 612.986, 3099, }, {360, -492.117288311215, 2751.37481967093, }, {360, 429.552513061523, 3011.3680267334, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.666667, 1.166667, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.666667, 1.166667, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiAnimSeqLoadAndCrop_134-effect0#seqTime#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.06666666666667, 4.06666666666667, }, 
		{{0, }, {3, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_84-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_84-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.797367, 1, }, 
		{0, 0.666667, }, 
		{{360, 640, 0, }, {360, 640, 2030, }, {360, 640, 338.333343505859, }, {360, 640, 2030, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.666667, 0.9, }, 
		{{360, 640, 2030, }, {360, -487.614955147, 2573.208147918, }, {360, 640, 2030, }, {360, -483.112621982785, 2395.04147616507, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.9, 1.166667, }, 
		{{360, -487.614955147, 2573.208147918, }, {360, 612.986, 3099, }, {360, -492.117288311215, 2751.37481967093, }, {360, 429.552513061523, 3011.3680267334, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_84-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.666667, 1.166667, }, 
		{{100, 100, 100, }, {0, 0, 0, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_84-trs-blend#p0_xRotation#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{0.666667, 1.166667, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
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
