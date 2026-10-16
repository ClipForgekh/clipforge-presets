local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiFill_7853-effect0', 'InputTex', 0},
    {'LumiFill_7852-effect0', 'InputTex', 0},
    {'LumiMotionBlur3D_7837-effect0', 'InputTex', 0},
    {'LumiMotionBlur3D_7838-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiFill_7853-effect0'] = {
        ['nodeDuration'] = {{1.26666666666667, 1.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.26666666666667, 1.5}, },
        },
    },
    ['LumiFill_7852-effect0'] = {
        ['nodeDuration'] = {{1.43333333333333, 1.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.43333333333333, 1.66666666666667}, },
        },
    },
    ['LumiLayer_7852-trs'] = {
        ['nodeDuration'] = {{1.43333333333333, 1.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.43333333333333, 1.66666666666667}, },
        },
    },
    ['LumiLayer_7853-trs-blend'] = {
        ['nodeDuration'] = {{1.26666666666667, 1.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.26666666666667, 1.5}, },
            ['baseTex'] = {{1.43333333333333, 1.66666666666667}, },
        },
    },
    ['LumiMotionBlur3D_7854-effect0'] = {
        ['nodeDuration'] = {{1.26666666666667, 1.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.26666666666667, 1.66666666666667}, },
        },
    },
    ['LumiMotionBlur3D_7837-effect0'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiNegative_7837-effect1'] = {
        ['nodeDuration'] = {{0, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiMotionBlur3D_7838-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_7838-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 1.03333333333333}, },
        },
    },
    ['LumiLayer_7854-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.26666666666667, 1.66666666666667}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiFill_7853-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiFill_7852-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_7852-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 50, 100),
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
    ['LumiLayer_7853-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 810, 0),
        ['scale'] = Amaz.Vector3f(100, 50, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur3D_7854-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.69523999278306,
        ['ae_pre_scale_x'] = 0.69523999278306,
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
        ['rotation_x'] = -21.9427205196194,
        ['ae_pre_rotation_x'] = -21.9427205196194,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur3D_7837-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.69523999278306,
        ['ae_pre_scale_x'] = 0.69523999278306,
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
        ['rotation_x'] = -36,
        ['ae_pre_rotation_x'] = -36,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiNegative_7837-effect1'] = {
        ['negativeAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur3D_7838-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.69523999278306,
        ['ae_pre_scale_x'] = 0.69523999278306,
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
        ['rotation_x'] = -21.9427205196194,
        ['ae_pre_rotation_x'] = -21.9427205196194,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_7838-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLayer_7854-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 4,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_7852-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.5, 1.566667, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.566667, 1.633333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_7853-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.266667, 1.333333, }, 
		{{2, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.4, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 1.466667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_7854-effect0#ae_pre_position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.53333333333333, 1.03333333333333, }, 
		{{1.5, 1, 0, }, {0.5, 0.5, 0, }, {1.5, 1, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7854-effect0#position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.5, 1, }, 
		{{1.5, 1, 0, }, {0.5, 0.5, 0, }, {1.5, 1, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7854-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.26666633333333, 1.86666633333333, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7854-effect0#scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.233333, 1.833333, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7854-effect0#ae_pre_rotation_x#number'] =
{
	{
		{0.5, 0, 0.5, 0, }, 
		{0.86666633333333, 1.26666633333333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{1.26666633333333, 1.86666633333333, }, 
		{{-36, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7854-effect0#rotation_x#number'] =
{
	{
		{0.5, 0, 0.5, 0, }, 
		{0.833333, 1.233333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{1.233333, 1.833333, }, 
		{{-36, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7854-effect0#ae_pre_rotation_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.86666633333333, 1.26666633333333, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7854-effect0#rotation_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.833333, 1.233333, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7837-effect0#ae_pre_position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.03333333333333, 0.53333333333333, }, 
		{{-0.5, 1, 0, }, {0.5, 0.5, 0, }, {-0.5, 1, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7837-effect0#position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0, 0.5, }, 
		{{-0.5, 1, 0, }, {0.5, 0.5, 0, }, {-0.5, 1, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7837-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.26666633333333, 1.86666633333333, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7837-effect0#scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.233333, 1.833333, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7837-effect0#ae_pre_rotation_x#number'] =
{
	{
		{0.5, 0, 0.5, 0, }, 
		{0.53333333333333, 0.86666633333333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 0, }, 
		{0.86666633333333, 1.26666633333333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 0, }, 
		{1.26666633333333, 1.53333333333333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{1.53333333333333, 1.86666633333333, }, 
		{{-36, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7837-effect0#rotation_x#number'] =
{
	{
		{0.5, 0, 0.5, 0, }, 
		{0.5, 0.833333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 0, }, 
		{0.833333, 1.233333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 0, }, 
		{1.233333, 1.5, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{1.5, 1.833333, }, 
		{{-36, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7837-effect0#ae_pre_rotation_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.53333333333333, 0.86666633333333, }, 
		{{15, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.86666633333333, 1.26666633333333, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7837-effect0#rotation_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.5, 0.833333, }, 
		{{15, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{0.833333, 1.233333, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7838-effect0#ae_pre_position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.53333333333333, 1.03333333333333, }, 
		{{1.5, 1, 0, }, {0.5, 0.5, 0, }, {1.5, 1, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7838-effect0#position#vector'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.5, 1, }, 
		{{1.5, 1, 0, }, {0.5, 0.5, 0, }, {1.5, 1, 0, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7838-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.26666633333333, 1.86666633333333, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7838-effect0#scale_x#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{1.233333, 1.833333, }, 
		{{0.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7838-effect0#ae_pre_rotation_x#number'] =
{
	{
		{0.5, 0, 0.5, 0, }, 
		{0.86666633333333, 1.26666633333333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{1.26666633333333, 1.86666633333333, }, 
		{{-36, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7838-effect0#rotation_x#number'] =
{
	{
		{0.5, 0, 0.5, 0, }, 
		{0.833333, 1.233333, }, 
		{{-36, }, {-36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.5, 1, }, 
		{1.233333, 1.833333, }, 
		{{-36, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7838-effect0#ae_pre_rotation_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.86666633333333, 1.26666633333333, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_7838-effect0#rotation_y#number'] =
{
	{
		{0.5, 0, 0.5, 1, }, 
		{0.833333, 1.233333, }, 
		{{-15, }, {0, }, }, 
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
