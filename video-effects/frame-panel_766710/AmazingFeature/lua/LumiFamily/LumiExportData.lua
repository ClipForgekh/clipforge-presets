local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLinearWipe_28-effect0', 'InputTex', 0},
    {'LumiLayer_105-trs', 'InputTex', 0},
    {'LumiLinearWipe_104-effect0', 'InputTex', 0},
    {'LumiLinearWipe_30-effect0', 'InputTex', 0},
    {'LumiLinearWipe_32-effect0', 'InputTex', 0},
    {'LumiLinearWipe_34-effect0', 'InputTex', 0},
    {'LumiLinearWipe_31-effect0', 'InputTex', 0},
    {'LumiLinearWipe_33-effect0', 'InputTex', 0},
    {'LumiLinearWipe_29-effect0', 'InputTex', 0},
    {'LumiLinearWipe_35-effect0', 'InputTex', 0},
    {'LumiFill_27-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_28-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_28-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_28-effect2'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_28-effect3'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_105-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_28-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_104-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_104-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_104-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_30-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_30-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_30-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_32-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_32-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_32-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_34-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_34-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_34-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_31-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_31-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_31-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_33-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_33-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_33-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_29-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_29-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_29-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_35-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_35-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_35-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiFill_27-effect0'] = {
        ['nodeDuration'] = {{1.8, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.8, 3}, },
        },
    },
    ['LumiLayer_27-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.8, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_28-effect0'] = {
        ['progress'] = 0.327,
        ['rotation'] = -225,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_28-effect1'] = {
        ['progress'] = 0.327,
        ['rotation'] = 45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_28-effect2'] = {
        ['progress'] = 0.327,
        ['rotation'] = -135,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_28-effect3'] = {
        ['progress'] = 0.327,
        ['rotation'] = -45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_105-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_28-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(0, 0, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_104-effect0'] = {
        ['progress'] = 0.501,
        ['rotation'] = 45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_104-effect1'] = {
        ['progress'] = 0.676,
        ['rotation'] = -45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_104-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(-289.081798503307, -286.819066131603, 0),
        ['scale'] = Amaz.Vector3f(69, 69, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(256, 256, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 45,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_30-effect0'] = {
        ['progress'] = 0.501,
        ['rotation'] = 225,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_30-effect1'] = {
        ['progress'] = 0.676,
        ['rotation'] = -45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_30-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(-290.475393951421, -286.615256571414, 0),
        ['scale'] = Amaz.Vector3f(69, 69, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(256, 256, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 45,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_32-effect0'] = {
        ['progress'] = 0.676,
        ['rotation'] = 135,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_32-effect1'] = {
        ['progress'] = 0.501,
        ['rotation'] = -135,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_32-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(286.931167288111, 283.861069965968, 0),
        ['scale'] = Amaz.Vector3f(69, 69, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(256, 256, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 45,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_34-effect0'] = {
        ['progress'] = 0.501,
        ['rotation'] = 45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_34-effect1'] = {
        ['progress'] = 0.676,
        ['rotation'] = -225,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_34-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(286.931167288111, 283.861069965968, 0),
        ['scale'] = Amaz.Vector3f(69, 69, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(256, 256, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 45,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_31-effect0'] = {
        ['progress'] = 0.676,
        ['rotation'] = 225,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_31-effect1'] = {
        ['progress'] = 0.5,
        ['rotation'] = -45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_31-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(-363.073566590689, 363.81159634604, 0),
        ['scale'] = Amaz.Vector3f(69, 69, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(256, 256, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 45,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_33-effect0'] = {
        ['progress'] = 0.501,
        ['rotation'] = 135,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_33-effect1'] = {
        ['progress'] = 0.676,
        ['rotation'] = -135,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_33-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(-363.073566590689, 363.81159634604, 0),
        ['scale'] = Amaz.Vector3f(69, 69, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(256, 256, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 45,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_29-effect0'] = {
        ['progress'] = 0.676,
        ['rotation'] = 45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_29-effect1'] = {
        ['progress'] = 0.5,
        ['rotation'] = -45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_29-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(361.806749661277, -358.095906444726, 0),
        ['scale'] = Amaz.Vector3f(69, 69, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(256, 256, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 45,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_35-effect0'] = {
        ['progress'] = 0.676,
        ['rotation'] = 45,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_35-effect1'] = {
        ['progress'] = 0.501,
        ['rotation'] = -225,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_35-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(361.806749661277, -358.095906444726, 0),
        ['scale'] = Amaz.Vector3f(69, 69, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(256, 256, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 45,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiFill_27-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_27-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_105-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.433333, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.433333, 0.766667, }, 
		{{0, 0, 100, }, {99.076923077, 99.076923077, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.766667, 0.966667, }, 
		{{99.076923077, 99.076923077, 100, }, {69, 69, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.966667, 1.533333, }, 
		{{69, 69, 100, }, {69, 69, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.533333, 1.733333, }, 
		{{69, 69, 100, }, {93, 93, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.1, 0.433333, }, 
		{{-361.3537378, -358.525310676, 0, }, {0, 0, 0, }, {-361.3537378, -358.525310676, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.3, 1.633333, }, 
		{{100, 100, 100, }, {143, 143, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.3, }, 
		{{45, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_30-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.1, 0.433333, }, 
		{{-363.094174714, -358.269003889, 0, }, {0, 0, 0, }, {-363.094174714, -358.269003889, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_30-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.3, 1.633333, }, 
		{{100, 100, 100, }, {143, 143, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_30-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.3, }, 
		{{45, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.1, 0.433333, }, 
		{{358.663892211, 354.826271274, 0, }, {0, 0, 0, }, {358.663892211, 354.826271274, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.3, 1.633333, }, 
		{{100, 100, 100, }, {143, 143, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.3, }, 
		{{45, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_34-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.1, 0.433333, }, 
		{{358.663892211, 354.826271274, 0, }, {0, 0, 0, }, {358.663892211, 354.826271274, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_34-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.3, 1.633333, }, 
		{{100, 100, 100, }, {143, 143, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_34-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.3, }, 
		{{45, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.433333, 0.766667, }, 
		{{-363.073566591, 363.811596346, 0, }, {0, 0, 0, }, {-363.073566591, 363.811596346, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.3, 1.633333, }, 
		{{100, 100, 100, }, {143, 143, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.3, }, 
		{{45, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_33-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.433333, 0.766667, }, 
		{{-363.073566591, 363.811596346, 0, }, {0, 0, 0, }, {-363.073566591, 363.811596346, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_33-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.3, 1.633333, }, 
		{{100, 100, 100, }, {143, 143, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_33-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.3, }, 
		{{45, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.433333, 0.766667, }, 
		{{361.806749661, -358.095906445, 0, }, {0, 0, 0, }, {361.806749661, -358.095906445, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.3, 1.633333, }, 
		{{100, 100, 100, }, {143, 143, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.3, }, 
		{{45, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_35-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.433333, 0.766667, }, 
		{{361.806749661, -358.095906445, 0, }, {0, 0, 0, }, {361.806749661, -358.095906445, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_35-trs-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.3, 1.633333, }, 
		{{100, 100, 100, }, {143, 143, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_35-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.3, }, 
		{{45, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_27-effect0#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.733333, 1.8, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.8, 1.866667, }, 
		{{1, }, {0, }, }, 
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
