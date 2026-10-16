local data = {}

local ae_compDurations = {0, 1.2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_125-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.56666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.46666666666667, 0.56666666666667}, },
            ['baseTex'] = {{0, 0.56666666666667}, },
        },
    },
    ['LumiLayer_144-trs'] = {
        ['nodeDuration'] = {{0.56666666666667, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.56666666666667, 0.66666666666667}, },
        },
    },
    ['LumiLayer_138-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.56666666666667, 0.66666666666667}, },
            ['baseTex'] = {{0, 0.56666666666667}, },
            ['maskTex'] = {{0.56666666666667, 0.66666666666667}, },
        },
    },
    ['LumiLayer_145-trs'] = {
        ['nodeDuration'] = {{0.56666666666667, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.56666666666667, 0.66666666666667}, },
        },
    },
    ['LumiLayer_146-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.56666666666667, 0.66666666666667}, },
            ['baseTex'] = {{0, 0.66666666666667}, },
            ['maskTex'] = {{0.56666666666667, 0.66666666666667}, },
        },
    },
    ['LumiFill_148-effect0'] = {
        ['nodeDuration'] = {{0.56666666666667, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.56666666666667, 0.66666666666667}, },
        },
    },
    ['LumiLayer_148-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.56666666666667, 0.66666666666667}, },
            ['baseTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiLayer_159-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.56666666666667, 0.66666666666667}, },
            ['baseTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiLayer_151-trs'] = {
        ['nodeDuration'] = {{0.66666666666667, 0.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 0.76666666666667}, },
        },
    },
    ['LumiLayer_149-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 0.76666666666667}, },
            ['baseTex'] = {{0, 0.66666666666667}, },
            ['maskTex'] = {{0.66666666666667, 0.76666666666667}, },
        },
    },
    ['LumiLayer_153-trs'] = {
        ['nodeDuration'] = {{0.66666666666667, 0.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 0.76666666666667}, },
        },
    },
    ['LumiLayer_154-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 0.76666666666667}, },
            ['baseTex'] = {{0, 0.76666666666667}, },
            ['maskTex'] = {{0.66666666666667, 0.76666666666667}, },
        },
    },
    ['LumiFill_132-effect0'] = {
        ['nodeDuration'] = {{0.66666666666667, 0.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 0.76666666666667}, },
        },
    },
    ['LumiLayer_132-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 0.76666666666667}, },
            ['baseTex'] = {{0, 0.76666666666667}, },
        },
    },
    ['LumiLayer_158-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 0.76666666666667}, },
            ['baseTex'] = {{0, 0.76666666666667}, },
        },
    },
    ['LumiFill_157-effect0'] = {
        ['nodeDuration'] = {{0.76666666666667, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 0.86666666666667}, },
        },
    },
    ['LumiLayer_157-trs'] = {
        ['nodeDuration'] = {{0.76666666666667, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 0.86666666666667}, },
        },
    },
    ['LumiLayer_155-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 0.86666666666667}, },
            ['baseTex'] = {{0, 0.76666666666667}, },
            ['maskTex'] = {{0.76666666666667, 0.86666666666667}, },
        },
    },
    ['LumiLayer_157-blend'] = {
        ['nodeDuration'] = {{0, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 0.86666666666667}, },
            ['baseTex'] = {{0, 0.86666666666667}, },
        },
    },
    ['LumiLayer_134-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 0.86666666666667}, },
            ['baseTex'] = {{0, 0.86666666666667}, },
        },
    },
    ['LumiLayer_137-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.86666666666667, 2}, },
            ['baseTex'] = {{0, 0.86666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_125-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_144-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_138-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 2,
        ['blendMode'] = 0,
    },
    ['LumiLayer_145-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_146-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(686, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 2,
        ['blendMode'] = 0,
    },
    ['LumiFill_148-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_148-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_159-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_151-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_149-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(401, 333, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 2,
        ['blendMode'] = 0,
    },
    ['LumiLayer_153-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_154-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 720, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 2,
        ['blendMode'] = 0,
    },
    ['LumiFill_132-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_132-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_158-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiFill_157-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_157-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_155-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 888, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 2,
        ['blendMode'] = 0,
    },
    ['LumiLayer_157-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Image',
        ['blendMode'] = 0,
    },
    ['LumiLayer_134-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_137-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

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
