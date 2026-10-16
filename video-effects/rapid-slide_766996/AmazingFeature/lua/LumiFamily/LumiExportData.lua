local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_132-effect0', 'InputTex', 1},
    {'LumiRoundCorner_54-effect0', 'InputTex', 1},
    {'LumiTone_131-effect0', 'InputTex', 1},
    {'LumiRoundCorner_135-effect0', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_132-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiTone_132-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_54-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiTone_54-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_54-trs'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_132-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiTone_131-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_131-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_131-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_135-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiTone_135-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_135-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiBCC_Prism_45-effect0'] = {
        ['nodeDuration'] = {{0, 2.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiChromaticAberration_45-effect1'] = {
        ['nodeDuration'] = {{0, 2.43333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.43333333333333}, },
        },
    },
    ['LumiLayer_45-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.43333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_132-effect0'] = {
        ['radius'] = 20.5494676619298,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTone_132-effect1'] = {
        ['amount'] = 0,
        ['whiteColor'] = Amaz.Color(0.41568627953529, 0.41568627953529, 0.41568627953529, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_54-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTone_54-effect1'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.41568627953529, 0.41568627953529, 0.41568627953529, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_54-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(1590, 50, 0),
        ['scale'] = Amaz.Vector3f(72.9, 72.9, 72.9),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(2500, 540, 0),
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
    ['LumiLayer_132-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1490, 50, 0),
        ['scale'] = Amaz.Vector3f(88.8621891543541, 88.8621891543541, 88.8621891543541),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(2500, 540, 0),
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
    ['LumiTone_131-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.41568627953529, 0.41568627953529, 0.41568627953529, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_131-effect1'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_131-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(560.997533002705, 50, 0),
        ['scale'] = Amaz.Vector3f(72.9, 72.9, 72.9),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(2500, 540, 0),
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
    ['LumiRoundCorner_135-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTone_135-effect1'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.41568627953529, 0.41568627953529, 0.41568627953529, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_135-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-3570.31705953306, 50, 0),
        ['scale'] = Amaz.Vector3f(72.9, 72.9, 72.9),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(2500, 540, 0),
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
        ['globalTransform'] = 85.4045954045954,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 0.85404595404595,
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
        ['offsetX'] = 0.0225968746677,
        ['offsetY'] = 0.0225968746677,
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
    ['LumiRoundCorner_132-effect0#radius#number'] =
{
	{
		{0.74, 0, 0.26, 0, }, 
		{0.651693, 1.303385, }, 
		{{50, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.74, 0, 0.26, 1, }, 
		{1.303385, 1.933333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTone_132-effect1#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.651693, 1.303385, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_54-trs#xRotation#number'] =
{
	{
		{0.74, 0, 0.26, 1, }, 
		{0.266667, 0.766667, }, 
		{{-90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs#p0_position#vector'] =
{
	{
		{0.74, 0, 0.26, 1, }, 
		{0, 1.520605, }, 
		{{-2451, 540, 0, }, {2500, 540, 0, }, {-2451, 540, 0, }, {2500, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_132-trs-blend#position#vector'] =
{
	{
		{0.74, 0.74, 0.26, 0.26, }, 
		{0.651693, 1.303385, }, 
		{{-1490, 50, 0, }, {-1490, 50, 0, }, {-1490, 50, 0, }, {-1490, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.74, 0.74, 0.26, 0.26, }, 
		{1.303385, 1.933333, }, 
		{{-1490, 50, 0, }, {-1490, 50, 0, }, {-1490, 50, 0, }, {-1490, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_132-trs-blend#scale#vector'] =
{
	{
		{0.74,0.74,0.74, 0,0,0, 0.26,0.26,0.26, 1,1,1, }, 
		{0.651693, 1.303385, }, 
		{{72.9, 72.9, 72.9, }, {72.900001526, 72.900001526, 72.900001526, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.74,0.74,0.74, 0,0,0, 0.26,0.26,0.26, 1,1,1, }, 
		{1.303385, 1.933333, }, 
		{{72.900001526, 72.900001526, 72.900001526, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_132-trs-blend#xRotation#number'] =
{
	{
		{0.74, 0, 0.26, 1, }, 
		{0.666667, 1.166667, }, 
		{{-90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_132-trs-blend#p0_position#vector'] =
{
	{
		{0.74, 0, 0.26, 1, }, 
		{0, 1.520605, }, 
		{{-2451, 540, 0, }, {2500, 540, 0, }, {-2451, 540, 0, }, {2500, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiRoundCorner_131-effect1#radius#number'] =
{
	{
		{0.74, 0, 0.833333333, 0, }, 
		{0.651693, 1.303385, }, 
		{{50, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_131-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.26, 0.26, }, 
		{0.651693, 1.303385, }, 
		{{50, 50, 0, }, {50, 50, 0, }, {50, 50, 0, }, {50, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.74, 0, 0.26, 1, }, 
		{1.303385, 1.933333, }, 
		{{50, 50, 0, }, {917.555557251, 50, 0, }, {50, 50, 0, }, {917.555557251, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_131-trs-blend#scale#vector'] =
{
	{
		{0.74,0.74,0.74, 0.74,0.74,0.74, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.651693, 1.303385, }, 
		{{72.9, 72.9, 72.9, }, {72.9, 72.9, 72.9, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_131-trs-blend#xRotation#number'] =
{
	{
		{0.74, 0, 0.26, 1, }, 
		{0.533333, 1.033333, }, 
		{{-90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_131-trs-blend#p0_position#vector'] =
{
	{
		{0.74, 0, 0.26, 1, }, 
		{0, 1.520605, }, 
		{{-2451, 540, 0, }, {2500, 540, 0, }, {-2451, 540, 0, }, {2500, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiRoundCorner_135-effect0#radius#number'] =
{
	{
		{0.74, 0, 0.833333333, 0, }, 
		{0.651693, 1.303385, }, 
		{{50, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTone_135-effect1#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.651693, 1.303385, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_135-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.26, 0.26, }, 
		{0.651693, 1.303385, }, 
		{{-3030, 50, 0, }, {-3030, 50, 0, }, {-3030, 50, 0, }, {-3030, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.74, 0, 0.26, 1, }, 
		{1.303385, 1.933333, }, 
		{{-3030, 50, 0, }, {-3947.333328247, 50, 0, }, {-3030, 50, 0, }, {-3947.333328247, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_135-trs-blend#scale#vector'] =
{
	{
		{0.74,0.74,0.74, 0.74,0.74,0.74, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.651693, 1.303385, }, 
		{{72.9, 72.9, 72.9, }, {72.9, 72.9, 72.9, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_135-trs-blend#xRotation#number'] =
{
	{
		{0.74, 0, 0.26, 1, }, 
		{0.766667, 1.266667, }, 
		{{-90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_135-trs-blend#p0_position#vector'] =
{
	{
		{0.74, 0, 0.26, 1, }, 
		{0, 1.520605, }, 
		{{-2451, 540, 0, }, {2500, 540, 0, }, {-2451, 540, 0, }, {2500, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_45-effect0#globalTransform#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.585775, 1.911621, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBCC_Prism_45-effect0#weight#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.585775, 1.911621, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_45-effect1#offsetX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.466667, 1.770768, }, 
		{{0.05, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_45-effect1#offsetY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.466667, 1.770768, }, 
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
