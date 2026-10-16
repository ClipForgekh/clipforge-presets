local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_140-effect0', 'InputTex', 1},
    {'LumiRoundCorner_139-effect0', 'InputTex', 1},
    {'LumiRoundCorner_141-effect0', 'InputTex', 1},
    {'LumiRoundCorner_54-effect0', 'InputTex', 1},
    {'LumiRoundCorner_134-effect0', 'InputTex', 1},
    {'LumiRoundCorner_136-effect0', 'InputTex', 1},
    {'LumiRoundCorner_137-effect0', 'InputTex', 1},
    {'LumiRoundCorner_138-effect0', 'InputTex', 1},
    {'LumiRoundCorner_135-effect0', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_140-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_139-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_139-trs'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_140-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_141-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_141-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_54-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_54-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_134-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_134-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_136-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_136-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_137-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_137-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_138-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_138-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiHalftone_145-effect0'] = {
        ['nodeDuration'] = {{0, 2.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiTone_145-effect1'] = {
        ['nodeDuration'] = {{0, 2.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.53333333333333}, },
        },
    },
    ['LumiLayer_145-blend'] = {
        ['nodeDuration'] = {{0, 2.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.53333333333333}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_135-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_135-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
            ['baseTex'] = {{0, 2.53333333333333}, },
        },
    },
    ['LumiBCC_Prism_45-effect0'] = {
        ['nodeDuration'] = {{0, 2.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.53333333333333}, },
        },
    },
    ['LumiChromaticAberration_45-effect1'] = {
        ['nodeDuration'] = {{0, 2.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.6}, },
        },
    },
    ['LumiLayer_45-blend'] = {
        ['nodeDuration'] = {{0, 2.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.6}, },
            ['baseTex'] = {{0, 2.53333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_140-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_139-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_139-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(1970, 1130, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_140-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, 1130, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_141-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_141-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1870, 1130, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_54-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_54-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(1970, 50, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_134-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_134-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1870, 50, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_136-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_136-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(1970, -1030, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_137-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_137-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, -1030, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_138-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_138-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1870, -1030, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiHalftone_145-effect0'] = {
        ['colorMode'] = 0,
        ['blackDots'] = true,
        ['dotFreq'] = 140,
        ['rotationAngle'] = -30,
        ['dotsRelativeWidth'] = 1,
        ['dotsSharpen'] = 1,
        ['dotsLighten'] = 0,
        ['color1'] = Amaz.Color(0.52156865596771, 0.52156865596771, 0.52156865596771, 1),
        ['color2'] = Amaz.Color(0, 0, 0, 1),
        ['dotsShift'] = Amaz.Vector2f(0, 0),
        ['alternateShift'] = Amaz.Vector2f(0, 0),
        ['redOffsetX'] = 0,
        ['redOffsetY'] = 0.25,
        ['greenOffsetX'] = 0,
        ['greenOffsetY'] = 0,
        ['blueOffsetX'] = 0,
        ['blueOffsetY'] = -0.25,
        ['smoothFactor'] = 1.3,
        ['useRings'] = false,
        ['ringThickness'] = 0.5,
        ['ringCount'] = 6,
        ['ringPhase'] = 1,
        ['quality'] = 0.5,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTone_145-effect1'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.49019607901573, 0.49019607901573, 0.49019607901573, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_145-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_135-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_135-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, 50, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_45-effect0'] = {
        ['globalTransform'] = 0,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 0,
        ['scaleStart'] = 102,
        ['scaleEnd'] = 98,
        ['angleStart'] = 0,
        ['angleEnd'] = 0,
        ['falloff'] = 0,
        ['offsetStart'] = Amaz.Vector2f(0.5, 0.5),
        ['offsetEnd'] = Amaz.Vector2f(0.5, 0.5),
        ['colorStart'] = Amaz.Color(1, 0, 0, 1),
        ['colorMid'] = Amaz.Color(0, 1, 0, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 1, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiChromaticAberration_45-effect1'] = {
        ['offsetX'] = 0,
        ['offsetY'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_45-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_139-trs#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.533333, 1.2, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_139-trs#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_140-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.466667, 1.133333, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_140-trs-blend#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_141-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.4, 1.066667, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_141-trs-blend#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.333333, 1, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs-blend#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_134-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.2, 0.866667, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_134-trs-blend#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_136-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.133333, 0.8, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_136-trs-blend#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_137-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.066667, 0.733333, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_137-trs-blend#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_138-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0, 0.666667, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_138-trs-blend#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiRoundCorner_135-effect0#radius#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.9, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_135-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.266667, 0.933333, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_135-trs-blend#p0_position#vector'] =
{
	{
		{0.001, 0, 0.18, 1, }, 
		{0, 1.166667, }, 
		{{960, 540, 614, }, {960, 540, 1503, }, {960, 540, 614, }, {960, 540, 1503, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{1.166667, 1.966667, }, 
		{{960, 540, 1503, }, {960, 540, 0, }, {960, 540, 1503, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_45-effect0#globalTransform#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 1.4, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 1.9, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBCC_Prism_45-effect0#weight#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.5, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 1.4, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 1.9, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_45-effect1#offsetX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.466667, }, 
		{{0, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1.4, }, 
		{{0.05, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 1.866667, }, 
		{{0.05, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_45-effect1#offsetY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.466667, }, 
		{{0, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1.4, }, 
		{{0.05, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 1.866667, }, 
		{{0.05, }, {0, }, }, 
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
