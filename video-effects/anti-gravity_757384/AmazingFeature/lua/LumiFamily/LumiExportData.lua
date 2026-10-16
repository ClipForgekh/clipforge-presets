local data = {}

local ae_compDurations = {0, 1.33333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiMotionBlur2D_114-effect0', 'InputTex', 0},
    {'LumiRoundCorner_74-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_114-effect0'] = {
        ['nodeDuration'] = {{1, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.36666666666667}, },
        },
    },
    ['LumiRoundCorner_74-effect0'] = {
        ['nodeDuration'] = {{0, 1.13333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.13333333333333}, },
        },
    },
    ['LumiMotionBlur3D_74-effect1'] = {
        ['nodeDuration'] = {{0, 1.13333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.13333333333333}, },
        },
    },
    ['LumiCCLens_74-effect2'] = {
        ['nodeDuration'] = {{0, 1.13333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.13333333333333}, },
        },
    },
    ['LumiLayer_74-trs'] = {
        ['nodeDuration'] = {{0, 1.13333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.13333333333333}, },
        },
    },
    ['LumiLayer_114-blend'] = {
        ['nodeDuration'] = {{0, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.36666666666667}, },
            ['baseTex'] = {{0, 1.13333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_114-effect0'] = {
        ['rotate'] = -16,
        ['ae_pre_rotate'] = -16,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 4.6,
        ['ae_pre_scale_x'] = 4.6,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.6,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiRoundCorner_74-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiMotionBlur3D_74-effect1'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.66,
        ['ae_pre_scale_x'] = 0.66,
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
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 540,
        ['ae_pre_rotation_y'] = 540,
        ['rotation_z'] = 9,
        ['ae_pre_rotation_z'] = 9,
        ['vIntensity'] = 1,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiCCLens_74-effect2'] = {
        ['convergence'] = -11.1682525733691,
        ['radius'] = 117,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['AEDesignSize'] = Amaz.Vector2f(720, 720),
    },
    ['LumiLayer_74-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 360, 3.5527136788005e-15),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -180,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527101455,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_114-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_114-effect0#ae_pre_rotate#number'] =
{
	{
		{0.166, 0.658605664, 0.704, 0.955450139, }, 
		{1.00000033333333, 1.13333333333333, }, 
		{{-16, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_114-effect0#rotate#number'] =
{
	{
		{0.166, 0.658605664, 0.704, 0.955450139, }, 
		{0.966667, 1.1, }, 
		{{-16, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_114-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.153, 0.745345623, 0.629, 1, }, 
		{1.00000033333333, 1.13333333333333, }, 
		{{4.6, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_114-effect0#scale_x#number'] =
{
	{
		{0.153, 0.745345623, 0.629, 1, }, 
		{0.966667, 1.1, }, 
		{{4.6, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRoundCorner_74-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{60, }, {256, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.124, 0.797422173, 0.755, 1, }, 
		{0.166667, 0.7, }, 
		{{256, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.73333333333333, }, 
		{{0.28, }, {0.66, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.73333333333333, 0.83333333333333, }, 
		{{0.66, }, {0.68, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.83333333333333, 1.06666633333333, }, 
		{{0.68, }, {0.001, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect1#scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.7, }, 
		{{0.28, }, {0.66, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.7, 0.8, }, 
		{{0.66, }, {0.68, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 1.033333, }, 
		{{0.68, }, {0.001, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect1#ae_pre_rotation_y#number'] =
{
	{
		{0.262, 0.619190228, 0.655, 0.952480188, }, 
		{0.03333333333333, 0.73333333333333, }, 
		{{90, }, {540, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.73333333333333, 0.83333333333333, }, 
		{{540, }, {540, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect1#rotation_y#number'] =
{
	{
		{0.262, 0.619190228, 0.655, 0.952480188, }, 
		{0, 0.7, }, 
		{{90, }, {540, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.7, 0.8, }, 
		{{540, }, {540, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect1#ae_pre_rotation_z#number'] =
{
	{
		{0.443081108, 2.28e-7, 0.338332199, 0.999999927, }, 
		{0.03333333333333, 0.73333333333333, }, 
		{{120, }, {9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.73333333333333, 0.83333333333333, }, 
		{{9, }, {9, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.969324792, 0.000002729, 0.833333333, 0.833333333, }, 
		{0.83333333333333, 1.06666633333333, }, 
		{{9, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect1#rotation_z#number'] =
{
	{
		{0.443081108, 2.28e-7, 0.338332199, 0.999999927, }, 
		{0, 0.7, }, 
		{{120, }, {9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.7, 0.8, }, 
		{{9, }, {9, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.969324792, 0.000002729, 0.833333333, 0.833333333, }, 
		{0.8, 1.033333, }, 
		{{9, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiCCLens_74-effect2#convergence#number'] =
{
	{
		{0.277798326, 0.970011573, 0.606703612, 0.341939726, }, 
		{0.466667, 0.8, }, 
		{{-49, }, {5.528128, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.194, 0.640020848, 0.603830008, 0.962641987, }, 
		{0.8, 1.1, }, 
		{{5.528128, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_74-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0, 0.7, }, 
		{{60, 60, 60, }, {100, 100, 100, }, }, 
		{6414, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_74-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {100, }, }, 
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
