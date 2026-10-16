local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_373-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_376-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_377-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_378-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_379-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_411-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiDistort_411-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_411-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_373-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(392, -10, 0),
        ['p0_position'] = Amaz.Vector3f(392, -10, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['p1_position'] = Amaz.Vector3f(392, 554, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_376-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(392, -10, 0),
        ['p0_position'] = Amaz.Vector3f(392, -10, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['p1_position'] = Amaz.Vector3f(392, 554, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_377-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(392, -10, 0),
        ['p0_position'] = Amaz.Vector3f(392, -10, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['p1_position'] = Amaz.Vector3f(392, 554, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_378-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(392, -10, 0),
        ['p0_position'] = Amaz.Vector3f(392, -10, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['p1_position'] = Amaz.Vector3f(392, 554, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_379-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(392, -10, 0),
        ['p0_position'] = Amaz.Vector3f(392, -10, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['p1_anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['p1_position'] = Amaz.Vector3f(392, 554, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRadialBlur_411-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 1,
    },
    ['LumiDistort_411-effect1'] = {
        ['amount'] = 0,
        ['rotateWarpDir'] = 0,
        ['blurLens'] = 96,
        ['stride'] = 0.30000001192093,
        ['amountRelX'] = 1,
        ['amountRelY'] = 1,
        ['wrapModeX'] = 2,
        ['wrapModeY'] = 2,
        ['fine'] = false,
        ['quality'] = 0.25,
    },
    ['LumiLayer_411-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_373-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.266667, 0.833333, }, 
		{{0, 0, 100, }, {14, 14, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.833333, 1.866667, }, 
		{{14, 14, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_373-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.6, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_373-trs#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.066667, 1.2, }, 
		{{1201, -10, 0, }, {392, -10, 0, }, {1066.16667175293, -10, 0, }, {526.83332824707, -10, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_373-trs#p1_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.633333, 1.166667, }, 
		{{392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, {36, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.166667, 1.866667, }, 
		{{36, 554, 0, }, {392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_373-trs#p1_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.633333, 1.166667, }, 
		{{100, 100, 100, }, {150, 150, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{1.166667, 1.866667, }, 
		{{150, 150, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_376-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.266667, 0.833333, }, 
		{{0, 0, 100, }, {31, 31, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.833333, 1.866667, }, 
		{{31, 31, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_376-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.6, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_376-trs-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.2, 1.3, }, 
		{{1201, -10, 0, }, {392, -10, 0, }, {1066.16667175293, -10, 0, }, {526.83332824707, -10, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_376-trs-blend#p1_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.633333, 1.166667, }, 
		{{392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, {36, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.166667, 1.866667, }, 
		{{36, 554, 0, }, {392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_376-trs-blend#p1_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.633333, 1.166667, }, 
		{{100, 100, 100, }, {150, 150, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{1.166667, 1.866667, }, 
		{{150, 150, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_377-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.266667, 0.833333, }, 
		{{0, 0, 100, }, {50, 50, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.833333, 1.866667, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_377-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.6, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_377-trs-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.333333, 1.466667, }, 
		{{1201, -10, 0, }, {392, -10, 0, }, {1135.76951599121, -10, 0, }, {461.602851867676, -10, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_377-trs-blend#p1_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.633333, 1.166667, }, 
		{{392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, {36, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.166667, 1.866667, }, 
		{{36, 554, 0, }, {392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_377-trs-blend#p1_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.633333, 1.166667, }, 
		{{100, 100, 100, }, {150, 150, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{1.166667, 1.866667, }, 
		{{150, 150, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_378-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.266667, 0.833333, }, 
		{{0, 0, 100, }, {60, 60, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.833333, 1.866667, }, 
		{{60, 60, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_378-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.6, 1.766667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_378-trs-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.466667, 1.6, }, 
		{{1201, -10, 0, }, {392, -10, 0, }, {1153.20399856567, -10, 0, }, {479.037330627441, -10, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_378-trs-blend#p1_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.633333, 1.166667, }, 
		{{392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, {36, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.166667, 1.866667, }, 
		{{36, 554, 0, }, {392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_378-trs-blend#p1_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.633333, 1.166667, }, 
		{{100, 100, 100, }, {150, 150, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{1.166667, 1.866667, }, 
		{{150, 150, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_379-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.266667, 0.833333, }, 
		{{0, 0, 100, }, {80, 80, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.833333, 1.633333, }, 
		{{80, 80, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_379-trs-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.6, 1.866667, }, 
		{{1201, -10, 0, }, {392, -10, 0, }, {1104.73900604248, -10, 0, }, {430.572341918945, -10, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_379-trs-blend#p1_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.633333, 1.166667, }, 
		{{392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, {36, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.166667, 1.866667, }, 
		{{36, 554, 0, }, {392, 554, 0, }, {36, 554, 0, }, {332.666667938232, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_379-trs-blend#p1_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.633333, 1.166667, }, 
		{{100, 100, 100, }, {150, 150, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{1.166667, 1.866667, }, 
		{{150, 150, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_411-effect0#amount#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.766667, }, 
		{{40, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDistort_411-effect1#amount#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.566667, 1, }, 
		{{0, }, {0.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.566667, }, 
		{{0.3, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDistort_411-effect1#rotateWarpDir#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.566667, 1.1, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.1, 1.566667, }, 
		{{50, }, {0, }, }, 
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
