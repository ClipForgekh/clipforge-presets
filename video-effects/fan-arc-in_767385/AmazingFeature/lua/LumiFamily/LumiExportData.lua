local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_136-effect0', 'InputTex', 1},
    {'LumiRoundCorner_54-effect0', 'InputTex', 1},
    {'LumiRoundCorner_137-effect0', 'InputTex', 1},
    {'LumiRoundCorner_138-effect0', 'InputTex', 1},
    {'LumiRoundCorner_139-effect0', 'InputTex', 1},
    {'LumiRoundCorner_150-effect0', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_136-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_54-effect0'] = {
        ['nodeDuration'] = {{0, 2.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_54-trs'] = {
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
    ['LumiTone_152-effect0'] = {
        ['nodeDuration'] = {{0, 2.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiLayer_152-blend'] = {
        ['nodeDuration'] = {{0, 2.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.5}, },
            ['baseTex'] = {{0, 2.33333333333333}, },
        },
    },
    ['LumiRoundCorner_139-effect0'] = {
        ['nodeDuration'] = {{0, 1.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
        },
    },
    ['LumiLayer_139-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.16666666666667}, },
            ['baseTex'] = {{0, 2.5}, },
        },
    },
    ['LumiRoundCorner_150-effect0'] = {
        ['nodeDuration'] = {{1.16666666666667, 2.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.16666666666667, 2.26666666666667}, },
        },
    },
    ['LumiLayer_150-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.16666666666667, 2.26666666666667}, },
            ['baseTex'] = {{0, 2.5}, },
        },
    },
    ['LumiBCC_Prism_45-effect0'] = {
        ['nodeDuration'] = {{0, 2.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.5}, },
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
            ['baseTex'] = {{0, 2.5}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_136-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_54-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_54-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, -1410, 0),
        ['scale'] = Amaz.Vector3f(45, 45, 45),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(49.9999999999999, 49.9999999999995, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 40,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['p1_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p1_position'] = Amaz.Vector3f(960, 2000, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_136-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, -1410, 0),
        ['scale'] = Amaz.Vector3f(45, 45, 45),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(49.9999999999999, 49.9999999999995, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -40,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['p1_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p1_position'] = Amaz.Vector3f(960, 2000, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.5977527099629,
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
        ['position'] = Amaz.Vector3f(50, -1410, 0),
        ['scale'] = Amaz.Vector3f(45, 45, 45),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(49.9999999999999, 49.9999999999995, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -20,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['p1_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p1_position'] = Amaz.Vector3f(960, 2000, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.5977527099629,
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
        ['position'] = Amaz.Vector3f(50, -1410, 0),
        ['scale'] = Amaz.Vector3f(45, 45, 45),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(49.9999999999999, 49.9999999999995, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 20,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['p1_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p1_position'] = Amaz.Vector3f(960, 2000, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 0,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTone_152-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.45882353186607, 0.45882353186607, 0.45882353186607, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_152-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_139-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_139-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, 50, 0),
        ['scale'] = Amaz.Vector3f(45, 45, 45),
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
    ['LumiRoundCorner_150-effect0'] = {
        ['radius'] = 0.69545007948639,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_150-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(50, 50, 0),
        ['scale'] = Amaz.Vector3f(99.235004912565, 99.235004912565, 99.235004912565),
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
        ['globalTransform'] = 26.6666666666667,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 0.26666666666667,
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
        ['offsetX'] = 0.01071428587394,
        ['offsetY'] = 0.01071428587394,
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
    ['LumiLayer_54-trs#p0_rotation#number'] =
{
	{
		{0.64, 0, 0.36, 1, }, 
		{0.2, 1.033333, }, 
		{{0, }, {40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_54-trs#p1_position#vector'] =
{
	{
		{0.77, 0, 0.23, 1, }, 
		{0, 1.166667, }, 
		{{960, 2803, 0, }, {960, 2000, 0, }, {960, 2803, 0, }, {960, 2000, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_136-trs-blend#p0_rotation#number'] =
{
	{
		{0.64, 0, 0.36, 1, }, 
		{0.2, 1.033333, }, 
		{{0, }, {-40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_136-trs-blend#p1_position#vector'] =
{
	{
		{0.77, 0, 0.23, 1, }, 
		{0, 1.166667, }, 
		{{960, 2803, 0, }, {960, 2000, 0, }, {960, 2803, 0, }, {960, 2000, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_137-trs-blend#p0_rotation#number'] =
{
	{
		{0.64, 0, 0.36, 1, }, 
		{0.2, 1.033333, }, 
		{{0, }, {-20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_137-trs-blend#p1_position#vector'] =
{
	{
		{0.77, 0, 0.23, 1, }, 
		{0, 1.166667, }, 
		{{960, 2803, 0, }, {960, 2000, 0, }, {960, 2803, 0, }, {960, 2000, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_138-trs-blend#p0_rotation#number'] =
{
	{
		{0.64, 0, 0.36, 1, }, 
		{0.2, 1.033333, }, 
		{{0, }, {20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_138-trs-blend#p1_position#vector'] =
{
	{
		{0.77, 0, 0.23, 1, }, 
		{0, 1.166667, }, 
		{{960, 2803, 0, }, {960, 2000, 0, }, {960, 2803, 0, }, {960, 2000, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_139-trs-blend#position#vector'] =
{
	{
		{0.64, 0, 0.36, 1, }, 
		{0, 1.166667, }, 
		{{50, 852, 0, }, {50, 50, 0, }, {50, 852, 0, }, {50, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiRoundCorner_150-effect0#radius#number'] =
{
	{
		{0.77, 0, 0.23, 1, }, 
		{1.166667, 1.866667, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_150-trs-blend#position#vector'] =
{
	{
		{0.64, 0, 0.36, 1, }, 
		{0, 1.166667, }, 
		{{50, 852, 0, }, {50, 50, 0, }, {50, 852, 0, }, {50, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_150-trs-blend#scale#vector'] =
{
	{
		{0.77,0.77,0.77, 0,0,0, 0.23,0.23,0.23, 1,1,1, }, 
		{1.166667, 1.866667, }, 
		{{45, 45, 45, }, {100, 100, 100, }, }, 
		{6414, }, 
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
