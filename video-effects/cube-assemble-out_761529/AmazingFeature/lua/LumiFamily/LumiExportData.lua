local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiTone_67-effect0'] = {
        ['nodeDuration'] = {{0, 3.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.16666666666667}, },
        },
    },
    ['LumiRoundCorner_67-effect1'] = {
        ['nodeDuration'] = {{0, 3.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.16666666666667}, },
        },
    },
    ['LumiTone_64-effect0'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiRoundCorner_64-effect1'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiRoundCorner_31-effect0'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiLayer_31-trs'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiLayer_64-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
            ['baseTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiTone_65-effect0'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiRoundCorner_65-effect1'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiLayer_65-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
            ['baseTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiTone_66-effect0'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiRoundCorner_66-effect1'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiLayer_66-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.53333333333333}, },
            ['baseTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiLayer_67-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.16666666666667}, },
            ['baseTex'] = {{0, 1.53333333333333}, },
        },
    },
    ['LumiChromaticAberration_38-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.16666666666667}, },
        },
    },
    ['LumiRadialBlur_38-effect1'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_38-blend'] = {
        ['nodeDuration'] = {{0, 3.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 3.16666666666667}, },
        },
    },
    ['LumiRadialBlur_70-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.16666666666667}, },
        },
    },
    ['LumiLayer_70-blend'] = {
        ['nodeDuration'] = {{0, 3.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 3.16666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiTone_67-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.61960786581039, 0.61960786581039, 0.61960786581039, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_67-effect1'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTone_64-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.61960786581039, 0.61960786581039, 0.61960786581039, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_64-effect1'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_31-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_31-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, 50, 63.1328201646922),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 100),
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
    ['LumiLayer_64-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, 336.883968769441, -100),
        ['scale'] = Amaz.Vector3f(57.1720984339592, 57.1720984339592, 57.1720984339592),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 64.5488859056327,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 100),
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
    ['LumiTone_65-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.61960786581039, 0.61960786581039, 0.61960786581039, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_65-effect1'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_65-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(552.044833393128, 50, -100),
        ['scale'] = Amaz.Vector3f(57.1720984339592, 57.1720984339592, 57.1720984339592),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 64.5488859056327,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 100),
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
    ['LumiTone_66-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.61960786581039, 0.61960786581039, 0.61960786581039, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_66-effect1'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_66-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-452.046945346522, 50, -100),
        ['scale'] = Amaz.Vector3f(57.1720984339592, 57.1720984339592, 57.1720984339592),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -64.5488859056327,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 100),
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
    ['LumiLayer_67-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, -236.883968769441, -100),
        ['scale'] = Amaz.Vector3f(57.1720984339592, 57.1720984339592, 57.1720984339592),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 64.5488859056327,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 100),
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
    ['LumiChromaticAberration_38-effect0'] = {
        ['offsetX'] = 0.05,
        ['offsetY'] = 0.05,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRadialBlur_38-effect1'] = {
        ['blurType'] = 0,
        ['amount'] = 7,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_38-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiRadialBlur_70-effect0'] = {
        ['blurType'] = 3,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_70-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_31-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.3, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.3, 1.666667, }, 
		{{50, }, {50, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.666667, 1.966667, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_31-trs#position#vector'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0, 0.666667, }, 
		{{50, 50, -100, }, {50, 50, -110, }, {50, 50, -100, }, {50, 50, -110, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.166667, }, 
		{{50, 50, -110, }, {50, 50, 100, }, {50, 50, -110, }, {50, 50, 100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs#scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{0, 0.666667, }, 
		{{100, 100, 100, }, {50, 50, 50, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.633333, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_31-trs#p0_scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {751, 751, 751, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs#p0_rotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{1.433333, 1.966667, }, 
		{{0, }, {293, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#position#vector'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0, 0.666667, }, 
		{{2457, 450, -100, }, {50, 450, -100, }, {2457, 450, -100, }, {50, 450, -100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.333333, }, 
		{{50, 450, -100, }, {50, 50, -100, }, {50, 450, -100, }, {50, 50, -100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{0.666667, 1.333333, }, 
		{{60, 60, 60, }, {50, 50, 50, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#xRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.333333, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.633333, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#p0_scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {751, 751, 751, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_64-trs-blend#p0_rotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{1.433333, 1.966667, }, 
		{{0, }, {293, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_65-trs-blend#position#vector'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0, 0.666667, }, 
		{{750, -1305, -100, }, {750, 50, -100, }, {750, -1305, -100, }, {750, 50, -100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.333333, }, 
		{{750, 50, -100, }, {50, 50, -100, }, {750, 50, -100, }, {50, 50, -100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_65-trs-blend#scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{0.666667, 1.333333, }, 
		{{60, 60, 60, }, {50, 50, 50, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_65-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.333333, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_65-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.633333, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_65-trs-blend#p0_scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {751, 751, 751, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_65-trs-blend#p0_rotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{1.433333, 1.966667, }, 
		{{0, }, {293, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#position#vector'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0, 0.666667, }, 
		{{-650, 1474, -100, }, {-650, 50, -100, }, {-650, 1474, -100, }, {-650, 50, -100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.333333, }, 
		{{-650, 50, -100, }, {50, 50, -100, }, {-650, 50, -100, }, {50, 50, -100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{0.666667, 1.333333, }, 
		{{60, 60, 60, }, {50, 50, 50, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#yRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.333333, }, 
		{{-90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.633333, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#p0_scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {751, 751, 751, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_66-trs-blend#p0_rotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{1.433333, 1.966667, }, 
		{{0, }, {293, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#position#vector'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0, 0.666667, }, 
		{{-2054, -350, -100, }, {50, -350, -100, }, {-2054, -350, -100, }, {50, -350, -100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.333333, }, 
		{{50, -350, -100, }, {50, 50, -100, }, {50, -350, -100, }, {50, 50, -100, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{0.666667, 1.333333, }, 
		{{60, 60, 60, }, {50, 50, 50, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#xRotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{0.666667, 1.333333, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.633333, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#p0_scale#vector'] =
{
	{
		{0.82,0.82,0.82, 0,0,0, 0.18,0.18,0.18, 1,1,1, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {751, 751, 751, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#p0_rotation#number'] =
{
	{
		{0.82, 0, 0.18, 1, }, 
		{1.433333, 1.966667, }, 
		{{0, }, {293, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiChromaticAberration_38-effect0#offsetX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.266667, }, 
		{{0, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_38-effect0#offsetY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.266667, }, 
		{{0, }, {0.05, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRadialBlur_38-effect1#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.266667, }, 
		{{0, }, {7, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRadialBlur_70-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.966667, }, 
		{{0, }, {10, }, }, 
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
