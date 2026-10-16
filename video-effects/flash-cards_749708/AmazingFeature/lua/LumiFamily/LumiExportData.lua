local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_6701-trs', 'InputTex', 0},
    {'LumiGaussianBlur_2709-effect0', 'InputTex', 0},
    {'LumiLayer_4701-trs', 'InputTex', 0},
    {'LumiLayer_2704-trs-blend', 'InputTex', 0},
    {'LumiLayer_2703-trs-blend', 'InputTex', 0},
    {'LumiLayer_2702-trs-blend', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_6701-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiGaussianBlur_2709-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2709-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2707-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2708-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
            ['maskTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_4701-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2705-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2706-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
            ['maskTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2704-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2703-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2702-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
    ['LumiRadialBlur_2701-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiGlow_2701-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2701-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_6701-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(624, 828, 0),
        ['scale'] = Amaz.Vector3f(250, 250, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
    },
    ['LumiGaussianBlur_2709-effect0'] = {
        ['blurIntensity'] = 100,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
    },
    ['LumiLayer_2709-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(252, 336, 0),
        ['scale'] = Amaz.Vector3f(109.270883631096, 109.270883631096, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2707-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(418.826029577426, 320, 0),
        ['scale'] = Amaz.Vector3f(81.4477852145944, 81.4477852145944, 95.5025366847047),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2708-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(252, 336, 65),
        ['scale'] = Amaz.Vector3f(130, 130, 130),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['p0_anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['p0_position'] = Amaz.Vector3f(418.826029577426, 320, 0),
        ['p0_scale'] = Amaz.Vector3f(81.4477852145944, 81.4477852145944, 95.5025366847047),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_4701-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(-108, -134, 0),
        ['scale'] = Amaz.Vector3f(242.857142857143, 242.857142857143, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2705-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(151.794311137738, 310.161706658679, 0),
        ['scale'] = Amaz.Vector3f(79.2815945062955, 79.2815945062955, 158.563189012591),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2706-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(252, 336, 40),
        ['scale'] = Amaz.Vector3f(167, 167, 167),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['p0_anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['p0_position'] = Amaz.Vector3f(151.794311137738, 310.161706658679, 0),
        ['p0_scale'] = Amaz.Vector3f(79.2815945062955, 79.2815945062955, 158.563189012591),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2704-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(238.13394811006, 458.928415119517, 20.1034698276857),
        ['scale'] = Amaz.Vector3f(32.3551883279887, 32.3551883279887, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2703-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(353.196311339637, 320, 0),
        ['scale'] = Amaz.Vector3f(29.7003039143811, 29.7003039143811, 99.4970044467456),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 17,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2702-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 336, 0),
        ['position'] = Amaz.Vector3f(166.98955613708, 279.309162118387, 0),
        ['scale'] = Amaz.Vector3f(36.1450672865501, 36.1450672865501, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100933,
        ['compositeSize'] = Amaz.Vector2f(504, 672),
        ['layerSize'] = Amaz.Vector2f(504, 672),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRadialBlur_2701-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 10.0180484280365,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiGlow_2701-effect1'] = {
        ['threshold'] = 0.6,
        ['radius'] = 100,
        ['glowIntensity'] = 0,
        ['blendMode'] = 0,
        ['show'] = 0,
        ['glowColor'] = 0,
        ['colorLooping'] = 0,
        ['colorLoops'] = 1,
        ['colorPhase'] = 0,
        ['midpoint'] = 0.5,
        ['colorA'] = Amaz.Color(1, 1, 1, 1),
        ['colorB'] = Amaz.Color(0, 0, 0, 1),
        ['glowDimensions'] = 0,
        ['quality'] = 0.2,
    },
    ['LumiLayer_2701-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiGaussianBlur_2709-effect0#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.730339, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.730339, 0.842708, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.842708, 0.898861, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2709-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0, 0.730339, }, 
		{{137, 137, 100, }, {115, 115, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.730339, 1, }, 
		{{115, 115, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2707-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0, 0.6, }, 
		{{252, 336, 0, }, {550, 320, 0, }, {252, 336, 0, }, {550, 320, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.76, 0, 0.833333, 0.833333, }, 
		{0.6, 0.898861, }, 
		{{550, 320, 0, }, {310, 320, 0, }, {550, 320, 0, }, {310, 320, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2707-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0,0,0, 1,1,1, }, 
		{0, 0.6, }, 
		{{100, 100, 100, }, {107.301587302, 107.301587302, 107.301587302, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.76,0.76,0.76, 0,0,0, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.6, 0.898861, }, 
		{{107.301587302, 107.301587302, 107.301587302, }, {60, 60, 85.714285714, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2707-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.853939, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.853939, 0.898861, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2708-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0, 0.6, }, 
		{{252, 336, 0, }, {550, 320, 0, }, {252, 336, 0, }, {550, 320, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.76, 0, 0.833333, 0.833333, }, 
		{0.6, 0.898861, }, 
		{{550, 320, 0, }, {310, 320, 0, }, {550, 320, 0, }, {310, 320, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2708-trs-matte-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0,0,0, 1,1,1, }, 
		{0, 0.6, }, 
		{{100, 100, 100, }, {107.301587302, 107.301587302, 107.301587302, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.76,0.76,0.76, 0,0,0, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.6, 0.898861, }, 
		{{107.301587302, 107.301587302, 107.301587302, }, {60, 60, 85.714285714, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2708-trs-matte-blend#p0_opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.853939, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.853939, 0.898861, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2705-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0, 0.6, }, 
		{{252, 336, 0, }, {119, 320, 0, }, {252, 336, 0, }, {119, 320, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.76, 0, 0.833333, 0.833333, }, 
		{0.6, 0.898861, }, 
		{{119, 320, 0, }, {179, 302, 0, }, {119, 320, 0, }, {179, 302, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2705-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.16025641,0.166666667, 0,0,0, 0,1,1, }, 
		{0, 0.6, }, 
		{{108, 108, 108, }, {108, 108, 216, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.51,0.51,0.51, 0,0,0, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.6, 0.898861, }, 
		{{108, 108, 216, }, {65, 65, 130, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2705-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.853939, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.853939, 0.898861, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2706-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0, 0.6, }, 
		{{252, 336, 0, }, {119, 320, 0, }, {252, 336, 0, }, {119, 320, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.76, 0, 0.833333, 0.833333, }, 
		{0.6, 0.898861, }, 
		{{119, 320, 0, }, {179, 302, 0, }, {119, 320, 0, }, {179, 302, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2706-trs-matte-blend#p0_scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.16025641,0.166666667, 0,0,0, 0,1,1, }, 
		{0, 0.6, }, 
		{{108, 108, 108, }, {108, 108, 216, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.51,0.51,0.51, 0,0,0, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.6, 0.898861, }, 
		{{108, 108, 216, }, {65, 65, 130, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2706-trs-matte-blend#p0_opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.853939, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.853939, 0.898861, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2704-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.46, 1, }, 
		{0, 0.6, }, 
		{{168, 380, 0, }, {232, 508, 52, }, {168, 380, 0, }, {232, 508, 52, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.64, 0, 0.833333, 0.833333, }, 
		{0.6, 0.898861, }, 
		{{232, 508, 52, }, {242, 428, 0, }, {232, 508, 52, }, {242, 428, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2704-trs-blend#scale#vector'] =
{
	{
		{0.56,0.56,0.56, 0,0,0.56, 0.837165576,0.837165576,0.837165576, 1,1,0.837165576, }, 
		{0, 0.6, }, 
		{{60, 60, 100, }, {42, 42, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.44698298,0.44698298,0.44698298, 0,0,0.44698298, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.6, 0.898861, }, 
		{{42, 42, 100, }, {28, 28, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2704-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.853939, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.853939, 0.898861, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2703-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.46, 1, }, 
		{0, 0.6, }, 
		{{328, 240, 0, }, {390, 320, 0, }, {328, 240, 0, }, {390, 320, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.64, 0, 0.833333, 0.833333, }, 
		{0.6, 0.898861, }, 
		{{390, 320, 0, }, {330, 320, 0, }, {390, 320, 0, }, {330, 320, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2703-trs-blend#scale#vector'] =
{
	{
		{0.556032814,0.556032814,0.556032814, 0,0,0.556032814, 0.824465001,0.824465001,0.824465001, 1,1,0.824465001, }, 
		{0, 0.6, }, 
		{{60, 60, 100, }, {42, 42, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.430572711,0.430572711,0.430572711, 0.146738819,0.146738819,0.430572711, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.6, 0.898861, }, 
		{{42, 42, 100, }, {25, 25, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2703-trs-blend#yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.33, 1, }, 
		{0, 0.6, }, 
		{{0, }, {17, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2703-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.853939, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.853939, 0.898861, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2702-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0, 0.6, }, 
		{{-174, 236, 0, }, {140, 256, 0, }, {-174, 236, 0, }, {140, 256, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.64, 0, 0.833333, 0.833333, }, 
		{0.6, 0.898861, }, 
		{{140, 256, 0, }, {184, 294, 0, }, {140, 256, 0, }, {184, 294, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2702-trs-blend#scale#vector'] =
{
	{
		{0.56,0.56,0.56, 0,0,0, 0.830753755,0.830753755,0.830753755, 1,1,1, }, 
		{0, 0.6, }, 
		{{65, 65, 130, }, {50, 50, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.434482923,0.434482923,0.434482923, 0,0,0.434482923, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.6, 0.898861, }, 
		{{50, 50, 100, }, {30, 30, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_2702-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.853939, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.853939, 0.898861, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRadialBlur_2701-effect0#amount#number'] =
{
	{
		{0.166666667, 0, 0.66666667, 0, }, 
		{0, 0.6, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.51, 0, 0.833333333, 0.833333333, }, 
		{0.6, 0.898861, }, 
		{{0, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0.898861, 1, }, 
		{{15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlow_2701-effect1#glowIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.033724, }, 
		{{0, }, {0.15, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033724, 0.078646, }, 
		{{0.15, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.078646, 0.146061, }, 
		{{0, }, {0.3, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.146061, 0.460677, }, 
		{{0.3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.460677, 0.865169, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.865169, 0.898861, }, 
		{{0, }, {0.3, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.898861, 1, }, 
		{{0.3, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = true
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
