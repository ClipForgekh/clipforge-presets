local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur3D_27-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiWarp_27-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_33-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiDeepGlow_36-effect0'] = {
        ['nodeDuration'] = {{0.06666666666667, 0.56666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_36-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.06666666666667, 0.56666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur3D_27-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(-2.36174767619548, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(-2.36174767619548, 0.5, 0),
        ['position'] = Amaz.Vector3f(2.11728026319259, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(2.11728026319259, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.55130624951197,
        ['ae_pre_scale_x'] = 1.55130624951197,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = -32.1595312215318,
        ['ae_pre_direction_x'] = -32.1595312215318,
        ['direction_y'] = 0,
        ['ae_pre_direction_y'] = 0,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiWarp_27-effect1'] = {
        ['warpStyle'] = 11,
        ['warpAxis'] = 0,
        ['bend'] = 46.415567780807,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 99.9999999999999, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_33-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiDeepGlow_36-effect0'] = {
        ['radius'] = 500,
        ['exposure'] = 0.95454541119662,
        ['threshold'] = 0,
        ['thresholdSmooth'] = 0,
        ['greyScale'] = 0,
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
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_36-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_27-effect0#ae_pre_pivot#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.03333333333333, 0.63333333333333, }, 
		{{-2.52135416666667, 0.5, 0, }, {-2.1109375, 0.5, 0, }, {-2.52135416666667, 0.5, 0, }, {-2.1109375, 0.5, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.666667, 1, }, 
		{0.63333333333333, 0.90000033333333, }, 
		{{-2.1109375, 0.5, 0, }, {0.65885416666667, 0.5, 0, }, {-2.1109375, 0.5, 0, }, {0.65885416666667, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.90000033333333, 1.03333333333333, }, 
		{{0.65885416666667, 0.5, 0, }, {0.46614583333333, 0.5, 0, }, {0.65885416666667, 0.5, 0, }, {0.46614583333333, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{0.46614583333333, 0.5, 0, }, {0.5, 0.5, 0, }, {0.46614583333333, 0.5, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#pivot#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0, 0.6, }, 
		{{-2.52135416666667, 0.5, 0, }, {-2.1109375, 0.5, 0, }, {-2.52135416666667, 0.5, 0, }, {-2.1109375, 0.5, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.666667, 1, }, 
		{0.6, 0.866667, }, 
		{{-2.1109375, 0.5, 0, }, {0.65885416666667, 0.5, 0, }, {-2.1109375, 0.5, 0, }, {0.65885416666667, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.866667, 1, }, 
		{{0.65885416666667, 0.5, 0, }, {0.46614583333333, 0.5, 0, }, {0.65885416666667, 0.5, 0, }, {0.46614583333333, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.333333, }, 
		{{0.46614583333333, 0.5, 0, }, {0.5, 0.5, 0, }, {0.46614583333333, 0.5, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#ae_pre_position#vector'] =
{
	{
		{1, 0, 0.666667, 1, }, 
		{0.03333333333333, 0.83333333333333, }, 
		{{2.17708333333333, 0.5, 0, }, {0.5, 0.5, 0, }, {2.17708333333333, 0.5, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#position#vector'] =
{
	{
		{1, 0, 0.666667, 1, }, 
		{0, 0.8, }, 
		{{2.17708333333333, 0.5, 0, }, {0.5, 0.5, 0, }, {2.17708333333333, 0.5, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.03333333333333, 1.36666633333333, }, 
		{{1.6, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 1.333333, }, 
		{{1.6, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#ae_pre_direction_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.03333333333333, 1.36666633333333, }, 
		{{-35, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect0#direction_x#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 1.333333, }, 
		{{-35, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_27-effect1#bend#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0, 1.333333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.066667, }, 
		{{5, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_33-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.066667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.066667, 0.2, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiDeepGlow_36-effect0#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.2, 0.566667, }, 
		{{1.05, }, {0, }, }, 
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
