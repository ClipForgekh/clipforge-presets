local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_2702-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_2702-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiBevelEmboss_2702-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiMotionBlur3D_2702-effect2'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_2702-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiDeepGlow_2701-effect0'] = {
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
    ['LumiRoundCorner_2702-effect0'] = {
        ['radius'] = 36.4736816224128,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiBevelEmboss_2702-effect1'] = {
        ['depth'] = 66,
        ['width'] = 18,
        ['soft'] = 12,
        ['lightYaw'] = 28,
        ['lightPitch'] = 90,
        ['upperBlendMode'] = 10,
        ['upperColor'] = Amaz.Color(1, 0.94875484704971, 0.78375363349915, 1),
        ['upperAlpha'] = 0.88,
        ['lowerBlendMode'] = 3,
        ['lowerColor'] = Amaz.Color(0.00798472296447, 0.02507806010544, 0.13837531208992, 1),
        ['lowerAlpha'] = 0.88,
        ['quality'] = NaN,
    },
    ['LumiMotionBlur3D_2702-effect2'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0.98061324432864),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0.98061324432864),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 0,
        ['ae_pre_direction_y'] = 0,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = -19,
        ['ae_pre_rotation_x'] = -19,
        ['rotation_y'] = 176.852736849448,
        ['ae_pre_rotation_y'] = 176.852736849448,
        ['rotation_z'] = 4.22649035281536,
        ['ae_pre_rotation_z'] = 4.22649035281536,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 12,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiLayer_2702-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 458.214052031946, 0),
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
    },
    ['LumiDeepGlow_2701-effect0'] = {
        ['radius'] = 360,
        ['exposure'] = 0.5,
        ['threshold'] = 0.35,
        ['thresholdSmooth'] = 0.75,
        ['blendMode'] = 1,
        ['view'] = 1,
        ['ratio'] = 1,
        ['rotate'] = 0,
        ['ca'] = false,
        ['redOffset'] = 0.0025,
        ['greenOffset'] = 0,
        ['blueOffset'] = -0.0025,
        ['tint'] = false,
        ['tintMode'] = 1,
        ['tintColor'] = Amaz.Color(1, 0, 0, 1),
        ['tintMix'] = 1,
        ['sourceOpacity'] = 1,
        ['unmult'] = true,
        ['gammaCorrect'] = true,
        ['gammaValue'] = 2,
        ['glowIter'] = 8,
        ['stepsMult'] = 1.5,
        ['downSample'] = 0.80000001192093,
        ['quality'] = NaN,
    },
    ['LumiLayer_2701-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_2702-effect0#radius#number'] =
{
	{
		{0.166666667, 0, 0.66666667, 1, }, 
		{0.433333, 0.666667, }, 
		{{35, }, {40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.666667, 0.966667, }, 
		{{40, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBevelEmboss_2702-effect1#depth#number'] =
{
	{
		{0.21, 0, 0.616230685, 1, }, 
		{0.7, 0.966667, }, 
		{{66, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#ae_pre_position#vector'] =
{
	{
		{0.001, 0, 0.13, 0.95, }, 
		{0.03333333333333, 0.43333333333333, }, 
		{{0.5, 0.5, 9.25925925925926, }, {0.5, 0.5, 1.11111111111111, }, {0.5, 0.5, 9.25925925925926, }, {0.5, 0.5, 1.11111111111111, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.452722, 0.214987, 0.751252, 0.588665, }, 
		{0.43333333333333, 0.63333333333333, }, 
		{{0.5, 0.5, 1.11111111111111, }, {0.5, 0.5, 0.73739488394074, }, {0.5, 0.5, 1.11111111111111, }, {0.5, 0.5, 0.73739488394074, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.355966, 0.328738, 0.643969, 0.701872, }, 
		{0.63333333333333, 0.76666633333333, }, 
		{{0.5, 0.5, 0.73739488394074, }, {0.5, 0.4212962962963, 0.29827908111852, }, {0.5, 0.5, 0.73739488394074, }, {0.5, 0.4212962962963, 0.29827908111852, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.228904, 0.554377, 0.514049, 1, }, 
		{0.76666633333333, 1.03333333333333, }, 
		{{0.5, 0.4212962962963, 0.29827908111852, }, {0.5, 0.5, 0, }, {0.5, 0.4212962962963, 0.29827908111852, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#position#vector'] =
{
	{
		{0.001, 0, 0.13, 0.95, }, 
		{0, 0.4, }, 
		{{0.5, 0.5, 9.25925925925926, }, {0.5, 0.5, 1.11111111111111, }, {0.5, 0.5, 9.25925925925926, }, {0.5, 0.5, 1.11111111111111, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.452722, 0.214987, 0.751252, 0.588665, }, 
		{0.4, 0.6, }, 
		{{0.5, 0.5, 1.11111111111111, }, {0.5, 0.5, 0.73739488394074, }, {0.5, 0.5, 1.11111111111111, }, {0.5, 0.5, 0.73739488394074, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.355966, 0.328738, 0.643969, 0.701872, }, 
		{0.6, 0.733333, }, 
		{{0.5, 0.5, 0.73739488394074, }, {0.5, 0.4212962962963, 0.29827908111852, }, {0.5, 0.5, 0.73739488394074, }, {0.5, 0.4212962962963, 0.29827908111852, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.228904, 0.554377, 0.514049, 1, }, 
		{0.733333, 1, }, 
		{{0.5, 0.4212962962963, 0.29827908111852, }, {0.5, 0.5, 0, }, {0.5, 0.4212962962963, 0.29827908111852, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#ae_pre_rotation_x#number'] =
{
	{
		{0.361993651, 0.138087255, 0.822723067, 0.680143611, }, 
		{0.03333333333333, 0.53333333333333, }, 
		{{-55, }, {-19, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.184205815, 0.613899243, 0.56071681, 0.889102181, }, 
		{0.53333333333333, 1.03333333333333, }, 
		{{-19, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#rotation_x#number'] =
{
	{
		{0.361993651, 0.138087255, 0.822723067, 0.680143611, }, 
		{0, 0.5, }, 
		{{-55, }, {-19, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.184205815, 0.613899243, 0.56071681, 0.889102181, }, 
		{0.5, 1, }, 
		{{-19, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#ae_pre_rotation_y#number'] =
{
	{
		{0.242071067, 0.030981218, 0.023803925, 0.833934695, }, 
		{0.03333333333333, 0.50000033333333, }, 
		{{450, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.712824236, 0.169601884, 0.243868299, 1, }, 
		{0.50000033333333, 1.03333333333333, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#rotation_y#number'] =
{
	{
		{0.242071067, 0.030981218, 0.023803925, 0.833934695, }, 
		{0, 0.466667, }, 
		{{450, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.712824236, 0.169601884, 0.243868299, 1, }, 
		{0.466667, 1, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#ae_pre_rotation_z#number'] =
{
	{
		{0.239697257, 0, 0.820059164, 1, }, 
		{0.03333333333333, 1.03333333333333, }, 
		{{8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#rotation_z#number'] =
{
	{
		{0.239697257, 0, 0.820059164, 1, }, 
		{0, 1, }, 
		{{8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_2702-effect2#vIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.5, }, 
		{{0.88, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.7, }, 
		{{0.5, }, {0.65, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_2702-trs#position#vector'] =
{
	{
		{0.001, 0, 0.69, 1, }, 
		{0, 0.233333, }, 
		{{540, 400, 0, }, {540, 635, 0, }, {540, 400, 0, }, {540, 635, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.3, 0, 0.42, 1, }, 
		{0.233333, 0.466667, }, 
		{{540, 635, 0, }, {540, 453, 0, }, {540, 635, 0, }, {540, 453, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.33, 0, 0.58, 1, }, 
		{0.466667, 0.7, }, 
		{{540, 453, 0, }, {540, 540, 0, }, {540, 453, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiDeepGlow_2701-effect0#exposure#number'] =
{
	{
		{0.166666667, 0, 0.730398147, 1, }, 
		{0, 0.133333, }, 
		{{0.33, }, {1.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.155695121, 0, 0.227436288, 1, }, 
		{0.133333, 0.4, }, 
		{{1.2, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.4, 0.6, }, 
		{{0.5, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.846395765, 0.851601207, }, 
		{0.6, 0.7, }, 
		{{0.5, }, {1.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.3, 0.579666801, 0.581337285, 1, }, 
		{0.7, 0.733333, }, 
		{{1.1, }, {1.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.149908654, 0, 0.571025057, 1, }, 
		{0.733333, 1, }, 
		{{1.2, }, {0, }, }, 
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
