local data = {}

local ae_compDurations = {0, 3}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_118-trs'] = {
        ['nodeDuration'] = {{0, 0.79166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.79166666666667}, },
        },
    },
    ['LumiLayer_327-matte'] = {
        ['nodeDuration'] = {{0, 0.79166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.79166666666667}, },
            ['maskTex'] = {{0, 0.79166666666667}, },
        },
    },
    ['LumiLayer_44-trs'] = {
        ['nodeDuration'] = {{0.79166666666667, 3.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
        },
    },
    ['LumiLayer_326-matte'] = {
        ['nodeDuration'] = {{0.79166666666667, 3.04166666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['maskTex'] = {{0.79166666666667, 3.04166666666667}, },
        },
    },
    ['LumiLayer_30-trs'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_159-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_163-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_161-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_157-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_153-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_151-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_149-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_147-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_145-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_49-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_52-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_54-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_56-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_64-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_63-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_62-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_61-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_66-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_68-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.79166666666667, 3.04166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_129-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.79166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_132-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.79166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_139-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.79166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_141-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.79166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_143-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.79166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
    ['LumiLayer_154-trs-blend'] = {
        ['nodeDuration'] = {{0, 4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.54166666666667, 0.79166666666667}, },
            ['baseTex'] = {{0, 4}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_118-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(138.5, 464, 0),
        ['position'] = Amaz.Vector3f(640, 640, 0),
        ['scale'] = Amaz.Vector3f(77, 77, 77),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 120.194721031221,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(277, 928),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_327-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
    },
    ['LumiLayer_44-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(138.5, 464, 0),
        ['position'] = Amaz.Vector3f(640, 640, 0),
        ['scale'] = Amaz.Vector3f(77, 77, 77),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 120.194721031221,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(277, 928),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_326-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
    },
    ['LumiLayer_30-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(634, 640, 0),
        ['scale'] = Amaz.Vector3f(986.25, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_159-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-2423, 640, -500),
        ['scale'] = Amaz.Vector3f(75, 75, 75),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_163-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-2205, 640, -500),
        ['scale'] = Amaz.Vector3f(75, 75, 75),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_161-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-1980, 640, -500),
        ['scale'] = Amaz.Vector3f(75, 75, 75),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_157-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-1761, 640, -500),
        ['scale'] = Amaz.Vector3f(75, 75, 75),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_153-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-2117, 640, 0),
        ['scale'] = Amaz.Vector3f(90, 90, 90),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_151-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-1917, 640, 0),
        ['scale'] = Amaz.Vector3f(90, 90, 90),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_149-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-1717, 640, 0),
        ['scale'] = Amaz.Vector3f(90, 90, 90),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_147-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-1517, 640, 0),
        ['scale'] = Amaz.Vector3f(90, 90, 90),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_145-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-1317, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_49-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-1111.86724646952, 640, -1.16062554392838),
        ['scale'] = Amaz.Vector3f(100.060105185099, 100.060105185099, 100.060105185099),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -0.30052592549449,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_52-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-849.766988304075, 640, -3.97632748812659),
        ['scale'] = Amaz.Vector3f(100.106846389327, 100.106846389327, 100.106846389327),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -1.13257172686276,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_54-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-600.853358814678, 640, -3.86556591470953),
        ['scale'] = Amaz.Vector3f(99.8931536106733, 99.8931536106733, 99.8931536106733),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -35.1068463893267,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_56-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-351.326447769452, 640, -3.31744491003395),
        ['scale'] = Amaz.Vector3f(99.7863072213466, 99.7863072213466, 99.7863072213466),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -0.53423194663338,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_64-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(-101.681367399675, 640, -1.84704263774694),
        ['scale'] = Amaz.Vector3f(99.8725839524086, 99.8725839524086, 99.8725839524086),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -0.99384517121312,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_63-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(156.395171692224, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_62-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(402.00918850192, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_61-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(651.088250001676, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_66-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(901.162588977052, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_68-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(1151.22317155915, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_129-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(140, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_132-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(390, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_139-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(641, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_141-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(890, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_143-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(640, 640, 0),
        ['position'] = Amaz.Vector3f(1140, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1280, 1280),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_154-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(750, 750, 0),
        ['position'] = Amaz.Vector3f(720, 694, 0),
        ['scale'] = Amaz.Vector3f(4, 4, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 28.7186730892601,
        ['compositeSize'] = Amaz.Vector2f(1280, 1280),
        ['layerSize'] = Amaz.Vector2f(1500, 1500),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_118-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.541667, }, 
		{{463, 138, 77, }, {77, 77, 77, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_159-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.798554, }, 
		{1.166667, 2.708333, }, 
		{{-2423, 640, -500, }, {1238, 640, -500, }, {-2423, 640, -500, }, {1238, 640, -500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_163-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.797558, }, 
		{1.166667, 2.708333, }, 
		{{-2205, 640, -500, }, {1438, 640, -500, }, {-2205, 640, -500, }, {1438, 640, -500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_161-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.79616, }, 
		{1.166667, 2.708333, }, 
		{{-1980, 640, -500, }, {1638, 640, -500, }, {-1980, 640, -500, }, {1638, 640, -500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_157-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.795083, }, 
		{1.166667, 2.708333, }, 
		{{-1761, 640, -500, }, {1838, 640, -500, }, {-1761, 640, -500, }, {1838, 640, -500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_153-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.810252, }, 
		{1.041667, 2.708333, }, 
		{{-2117, 640, 0, }, {2055, 640, -500, }, {-2117, 640, 0, }, {2055, 640, -500, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_153-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.041667, 1.875, }, 
		{{90, 90, 90, }, {85, 85, 85, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.833333333,0.833333333,0.833333333, 1,1,1, }, 
		{1.875, 2.708333, }, 
		{{85, 85, 85, }, {90, 90, 90, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_153-trs-blend#yRotation#number'] =
{
	{
		{0.166666667, 0, 0.66666667, 1, }, 
		{1.041667, 1.875, }, 
		{{0, }, {60, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.875, 2.708333, }, 
		{{60, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_151-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.802059, }, 
		{1.041667, 2.708333, }, 
		{{-1917, 640, 0, }, {2255, 640, -550, }, {-1917, 640, 0, }, {2255, 640, -550, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_151-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.041667, 1.833333, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.833333, 2.708333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_149-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.773209, }, 
		{0.875, 2.708333, }, 
		{{-1717, 640, 0, }, {2266, 640, -800, }, {-1717, 640, 0, }, {2266, 640, -800, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_149-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0.33333333,0.33333333, 0.66666667,0.66666667,0.66666667, 0.66666667,0.66666667,0.66666667, }, 
		{1.791667, 2.708333, }, 
		{{90, 90, 90, }, {90, 90, 90, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_149-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.875, 1.791667, }, 
		{{0, }, {40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.791667, 2.708333, }, 
		{{40, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_147-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.776062, }, 
		{0.875, 2.708333, }, 
		{{-1517, 640, 0, }, {2503, 640, -800, }, {-1517, 640, 0, }, {2503, 640, -800, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_147-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.875, 1.791667, }, 
		{{90, 90, 90, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0,0, 0.66666667,0.66666667,0.66666667, 0.66666667,1,1, }, 
		{1.791667, 2.708333, }, 
		{{100, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_147-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.875, 1.791667, }, 
		{{0, }, {30, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.791667, 2.708333, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_145-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.470601, }, 
		{0.875, 1.75, }, 
		{{-1317, 640, 0, }, {294.201705418, 640, -309.152877508, }, {-1317, 640, 0, }, {294.201705418, 640, -309.152877508, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.37924, 0.666667, 0.807592, }, 
		{1.75, 2.708333, }, 
		{{294.201705418, 640, -309.152877508, }, {2754, 640, -800, }, {294.201705418, 640, -309.152877508, }, {2754, 640, -800, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_145-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.875, 1.75, }, 
		{{100, 100, 100, }, {115, 115, 115, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.75, 2.708333, }, 
		{{115, 115, 115, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_145-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.875, 1.75, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{1.75, 2.708333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_49-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.497737, }, 
		{0.833333, 1.75, }, 
		{{-1117, 640, 0, }, {572.022345041, 640, -381.924139992, }, {-1117, 640, 0, }, {572.022345041, 640, -381.924139992, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.368482, 0.666667, 0.804423, }, 
		{1.75, 2.708333, }, 
		{{572.022345041, 640, -381.924139992, }, {3004, 640, -800, }, {572.022345041, 640, -381.924139992, }, {3004, 640, -800, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_49-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.833333, 1.75, }, 
		{{100, 100, 100, }, {110, 110, 110, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.75, 2.708333, }, 
		{{110, 110, 110, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_49-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.833333, 1.75, }, 
		{{0, }, {-50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.75, 2.708333, }, 
		{{-50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_52-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.471684, }, 
		{0.791667, 1.75, }, 
		{{-867, 640, 0, }, {785.486353697, 640, -381.293010641, }, {-867, 640, 0, }, {785.486353697, 640, -381.293010641, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.358414, 0.666667, 0.808066, }, 
		{1.75, 2.708333, }, 
		{{785.486353697, 640, -381.293010641, }, {3250, 640, -800, }, {785.486353697, 640, -381.293010641, }, {3250, 640, -800, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_52-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.791667, 1.75, }, 
		{{100, 100, 100, }, {105, 105, 105, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.75, 2.708333, }, 
		{{105, 105, 105, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_52-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.791667, 1.75, }, 
		{{0, }, {-53, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.75, 2.708333, }, 
		{{-53, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.459561, }, 
		{0.791667, 1.75, }, 
		{{-617, 640, 0, }, {969.762935611, 640, -379.876944575, }, {-617, 640, 0, }, {969.762935611, 640, -379.876944575, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.344188, 0.666667, 0.81201, }, 
		{1.75, 2.708333, }, 
		{{969.762935611, 640, -379.876944575, }, {3497, 640, -800, }, {969.762935611, 640, -379.876944575, }, {3497, 640, -800, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.791667, 1.75, }, 
		{{100, 100, 100, }, {95, 95, 95, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.75, 2.708333, }, 
		{{95, 95, 95, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.791667, 1.75, }, 
		{{-35, }, {-40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.75, 2.708333, }, 
		{{-40, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_56-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.459633, }, 
		{0.791667, 1.75, }, 
		{{-367, 640, 0, }, {1173.045901957, 640, -325.964233475, }, {-367, 640, 0, }, {1173.045901957, 640, -325.964233475, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.325253, 0.666667, 0.816864, }, 
		{1.75, 2.708333, }, 
		{{1173.045901957, 640, -325.964233475, }, {3745, 640, -800, }, {1173.045901957, 640, -325.964233475, }, {3745, 640, -800, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_56-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.791667, 1.75, }, 
		{{100, 100, 100, }, {90, 90, 90, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.75, 2.708333, }, 
		{{90, 90, 90, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_56-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.791667, 1.75, }, 
		{{0, }, {-25, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.75, 2.708333, }, 
		{{-25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.445224, }, 
		{0.791667, 1.666667, }, 
		{{-117, 640, 0, }, {1178.473846109, 640, -156.201633153, }, {-117, 640, 0, }, {1178.473846109, 640, -156.201633153, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.281791, 0.666667, 0.837062, }, 
		{1.666667, 2.708333, }, 
		{{1178.473846109, 640, -156.201633153, }, {4188, 640, -700, }, {1178.473846109, 640, -156.201633153, }, {4188, 640, -700, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.791667, 1.666667, }, 
		{{100, 100, 100, }, {95, 95, 95, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{1.666667, 2.708333, }, 
		{{95, 95, 95, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.791667, 1.666667, }, 
		{{0, }, {-39, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{1.666667, 2.708333, }, 
		{{-39, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_63-trs-blend#position#vector'] =
{
	{
		{0.487936, 0.007948, 0.848064, 0.827625, }, 
		{0.791667, 2.708333, }, 
		{{140, 640, 0, }, {5878, 640, 0, }, {140, 640, 0, }, {5878, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_62-trs-blend#position#vector'] =
{
	{
		{0.419229, 0, 0.677259, 0.571975, }, 
		{0.791667, 2.708333, }, 
		{{390, 640, 0, }, {6178, 640, 0, }, {390, 640, 0, }, {6178, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_61-trs-blend#position#vector'] =
{
	{
		{0.44468, 0, 0.639159, 0.582827, }, 
		{0.791667, 2.708333, }, 
		{{640, 640, 0, }, {6478, 640, 0, }, {640, 640, 0, }, {6478, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#position#vector'] =
{
	{
		{0.44468, 0, 0.63916, 0.581732, }, 
		{0.791667, 2.708333, }, 
		{{890, 640, 0, }, {6778, 640, 0, }, {890, 640, 0, }, {6778, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_68-trs-blend#position#vector'] =
{
	{
		{0.44468, 0, 0.656082, 0.581418, }, 
		{0.791667, 2.708333, }, 
		{{1140, 640, 0, }, {7078, 640, 0, }, {1140, 640, 0, }, {7078, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_129-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.541667, }, 
		{{-2113, 640, 0, }, {140, 640, 0, }, {-2113, 640, 0, }, {140, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_132-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.541667, }, 
		{{-719, 640, 0, }, {390, 640, 0, }, {-719, 640, 0, }, {390, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_139-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.541667, 0.666667, }, 
		{{100, 100, 100, }, {90, 90, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.666667, 0.791667, }, 
		{{90, 90, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_141-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.541667, }, 
		{{2004, 640, 0, }, {890, 640, 0, }, {2004, 640, 0, }, {890, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_143-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.541667, }, 
		{{3378, 640, 0, }, {1140, 640, 0, }, {3378, 640, 0, }, {1140, 640, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_154-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.541667, 0.666667, }, 
		{{4, 4, 100, }, {2, 2, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.666667, 0.791667, }, 
		{{2, 2, 100, }, {4, 4, 100, }, }, 
		{6414, }, 
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
