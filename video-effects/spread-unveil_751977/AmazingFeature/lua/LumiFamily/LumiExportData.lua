local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_114-trs-matte', 'InputTex', 0},
    {'LumiLayer_112-trs-matte-blend', 'InputTex', 0},
    {'LumiLayer_110-trs-matte-blend', 'InputTex', 0},
    {'LumiLayer_108-trs-matte-blend', 'InputTex', 0},
    {'LumiLayer_106-trs-matte-blend', 'InputTex', 0},
    {'LumiLayer_104-trs-matte-blend', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_113-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_114-trs-matte'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_111-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_112-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_109-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_110-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_107-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_108-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_105-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_106-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_103-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_104-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_102-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_102-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_102-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_113-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['position'] = Amaz.Vector3f(-247.757013969928, -375.538326542862, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 6,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p0_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(168, 448),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_114-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 448, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['p0_position'] = Amaz.Vector3f(-247.757013969928, -375.538326542862, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 6,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p1_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
    },
    ['LumiLayer_111-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['position'] = Amaz.Vector3f(-1.99392534924819, -395.477580035344, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -7,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p0_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(168, 448),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_112-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(84, 448, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 31.25,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['p0_position'] = Amaz.Vector3f(-1.99392534924819, -395.477580035344, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -7,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p1_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_109-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['position'] = Amaz.Vector3f(237.790629253611, -343.641078720475, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -14,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p0_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(168, 448),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_110-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(-84, 448, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 31.25,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['p0_position'] = Amaz.Vector3f(237.790629253611, -343.641078720475, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -14,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p1_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_107-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['position'] = Amaz.Vector3f(251.744864668424, 459.283191211286, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 7,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p0_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(168, 448),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_108-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(-84, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 31.25,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['p0_position'] = Amaz.Vector3f(251.744864668424, 459.283191211286, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 7,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p1_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_105-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['position'] = Amaz.Vector3f(7.97570139699275, 507.137399593243, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -3,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p0_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(168, 448),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_106-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(84, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 31.25,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['p0_position'] = Amaz.Vector3f(7.97570139699275, 507.137399593243, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -3,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p1_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_103-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['position'] = Amaz.Vector3f(-235.793461874438, 479.222444703768, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -15,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p0_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(168, 448),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_104-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 31.25,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(84, 224, 0),
        ['p0_position'] = Amaz.Vector3f(-235.793461874438, 479.222444703768, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -15,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(252, 344.825682470512, 0),
        ['p1_scale'] = Amaz.Vector3f(208.055541873389, 208.055541873389, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiRadialBlur_102-effect0'] = {
        ['blurType'] = 1,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiGaussianBlur_102-effect1'] = {
        ['blurIntensity'] = 150,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_102-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_113-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{-168, -224, 0, }, {-248, -376, 0, }, {-181.333333015442, -249.333333969116, 0, }, {-234.666666984558, -350.666666030884, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_113-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_113-trs#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_113-trs#p0_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_114-trs-matte#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{-168, -224, 0, }, {-248, -376, 0, }, {-181.333333015442, -249.333333969116, 0, }, {-234.666666984558, -350.666666030884, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_114-trs-matte#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_114-trs-matte#p1_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_114-trs-matte#p1_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_111-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{0, -224, 0, }, {-2, -396, 0, }, {-0.33333334326744, -252.666666030884, 0, }, {-1.66666665673256, -367.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_111-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {-7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_111-trs#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_111-trs#p0_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_112-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_112-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{0, -224, 0, }, {-2, -396, 0, }, {-0.33333334326744, -252.666666030884, 0, }, {-1.66666665673256, -367.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_112-trs-matte-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {-7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_112-trs-matte-blend#p1_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_112-trs-matte-blend#p1_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_109-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{168, -224, 0, }, {238, -344, 0, }, {179.666666984558, -244, 0, }, {226.333333015442, -324, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_109-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {-14, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_109-trs#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_109-trs#p0_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_110-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_110-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{168, -224, 0, }, {238, -344, 0, }, {179.666666984558, -244, 0, }, {226.333333015442, -324, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_110-trs-matte-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {-14, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_110-trs-matte-blend#p1_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_110-trs-matte-blend#p1_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_107-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{168, 224, 0, }, {252, 460, 0, }, {182, 263.333332061768, 0, }, {238, 420.666667938232, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_107-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_107-trs#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_107-trs#p0_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_108-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_108-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{168, 224, 0, }, {252, 460, 0, }, {182, 263.333332061768, 0, }, {238, 420.666667938232, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_108-trs-matte-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_108-trs-matte-blend#p1_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_108-trs-matte-blend#p1_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{0, 224, 0, }, {8, 508, 0, }, {1.33333337306976, 271.333332061768, 0, }, {6.66666662693024, 460.666667938232, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {-3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs#p0_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_106-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{0, 224, 0, }, {8, 508, 0, }, {1.33333337306976, 271.333332061768, 0, }, {6.66666662693024, 460.666667938232, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs-matte-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {-3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs-matte-blend#p1_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs-matte-blend#p1_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_103-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{-168, 224, 0, }, {-236, 480, 0, }, {-179.333333015442, 266.666667938232, 0, }, {-224.666666984558, 437.333332061768, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_103-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_103-trs#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_103-trs#p0_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_104-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.17, 1, }, 
		{0, 1.966667, }, 
		{{-168, 224, 0, }, {-236, 480, 0, }, {-179.333333015442, 266.666667938232, 0, }, {-224.666666984558, 437.333332061768, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-matte-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 1.7, }, 
		{{0, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-matte-blend#p1_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.5, 1, }, 
		{0, 1.966667, }, 
		{{252, 448, 0, }, {252, 344, 0, }, {252, 430.666666030884, 0, }, {252, 361.333333969116, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-matte-blend#p1_scale#vector'] =
{
	{
		{0.05,0.05,0.379109239, 0.468376177,0.468376177,0.379109239, 0.761114624,0.761114624,0.672276509, 0.862858354,0.862858354,0.672276509, }, 
		{0, 0.2, }, 
		{{100, 100, 100, }, {203.73872545, 203.73872545, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.020532805,0.020532805,0.123285833, 3.20925062,3.20925062,0.123285833, 0.289769511,0.289769511,0.289769511, 1,1,0.289769511, }, 
		{0.2, 1.966667, }, 
		{{203.73872545, 203.73872545, 100, }, {208, 208, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_102-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.033333, }, 
		{{0, }, {91, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0.033333, 0.2, }, 
		{{91, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_102-effect1#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0.066667, 1.466667, }, 
		{{0, }, {150, }, }, 
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
