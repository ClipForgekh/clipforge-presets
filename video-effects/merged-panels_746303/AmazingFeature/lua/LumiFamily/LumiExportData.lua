local data = {}

local ae_compDurations = {0, 0.66666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLinearWipe_127-effect0', 'InputTex', 0},
    {'LumiLinearWipe_126-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_127-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiMotionBlur3D_127-effect1'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiBrightness_127-effect2'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiRadialBlur_127-effect3'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiExposure_127-effect4'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiLinearWipe_126-effect0'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiMotionBlur3D_126-effect1'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiBrightness_126-effect2'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiRadialBlur_126-effect3'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiExposure_126-effect4'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
    ['LumiLayer_127-blend'] = {
        ['nodeDuration'] = {{0.03333333333333, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.03333333333333, 0.66666666666667}, },
            ['baseTex'] = {{0.03333333333333, 0.66666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_127-effect0'] = {
        ['progress'] = 0.5,
        ['rotation'] = 90,
        ['feather'] = 0,
    },
    ['LumiMotionBlur3D_127-effect1'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.75, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.75, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.75, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.75, 0.5, 0),
        ['unifiedScale'] = true,
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
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 16,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiBrightness_127-effect2'] = {
        ['brightnessIntensity'] = 0,
    },
    ['LumiRadialBlur_127-effect3'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = NaN,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiExposure_127-effect4'] = {
        ['channelType'] = 0,
        ['exposure'] = 0,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
    },
    ['LumiLinearWipe_126-effect0'] = {
        ['progress'] = 0.5,
        ['rotation'] = -90,
        ['feather'] = 0,
    },
    ['LumiMotionBlur3D_126-effect1'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.25, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.25, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.25, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.25, 0.5, 0),
        ['unifiedScale'] = true,
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
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 16,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiBrightness_126-effect2'] = {
        ['brightnessIntensity'] = 0,
    },
    ['LumiRadialBlur_126-effect3'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = NaN,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiExposure_126-effect4'] = {
        ['channelType'] = 0,
        ['exposure'] = 0,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
    },
    ['LumiLayer_127-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_127-effect1#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.3, 1, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{0.64827586206897, 0.5, 0, }, {0.75, 0.5, 0, }, {0.66522988450939, 0.5, 0, }, {0.73304597755958, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.3, 1, }, 
		{0.033333, 0.533333, }, 
		{{0.64827586206897, 0.5, 0, }, {0.75, 0.5, 0, }, {0.66522988450938, 0.5, 0, }, {0.73304597755958, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{0.6, }, {0.9, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.56666633333333, 0.66666633333333, }, 
		{{0.9, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{0.6, }, {0.9, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.533333, 0.633333, }, 
		{{0.9, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#ae_pre_rotation_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{91, }, {-5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.56666633333333, 0.66666633333333, }, 
		{{-5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#rotation_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{91, }, {-5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.533333, 0.633333, }, 
		{{-5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#ae_pre_rotation_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{18, }, {-5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.56666633333333, 0.66666633333333, }, 
		{{-5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#rotation_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{18, }, {-5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.533333, 0.633333, }, 
		{{-5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#ae_pre_rotation_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{-67, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.56666633333333, 0.66666633333333, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#rotation_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{-67, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.533333, 0.633333, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBrightness_127-effect2#brightnessIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.3, 1, }, 
		{0.066667, 0.533333, }, 
		{{-1, }, {0.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.533333, 0.633333, }, 
		{{0.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_127-effect3#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.2, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExposure_127-effect4#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{-2.1, }, {1.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.533333, 0.633333, }, 
		{{1.1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.3, 1, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{0.32758620689655, 0.5, 0, }, {0.25, 0.5, 0, }, {0.31465517241379, 0.5, 0, }, {0.26293103448276, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.3, 1, }, 
		{0.033333, 0.533333, }, 
		{{0.32758620689655, 0.5, 0, }, {0.25, 0.5, 0, }, {0.31465517241379, 0.5, 0, }, {0.26293103448276, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{0.6, }, {0.9, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.56666633333333, 0.66666633333333, }, 
		{{0.9, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#scale_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{0.6, }, {0.9, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.533333, 0.633333, }, 
		{{0.9, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_rotation_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{91, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.56666633333333, 0.66666633333333, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#rotation_x#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{91, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.533333, 0.633333, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_rotation_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{-19, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.56666633333333, 0.66666633333333, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#rotation_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{-19, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.533333, 0.633333, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_rotation_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.06666633333333, 0.56666633333333, }, 
		{{60, }, {-2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.56666633333333, 0.66666633333333, }, 
		{{-2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#rotation_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{60, }, {-2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.16, 1, }, 
		{0.533333, 0.633333, }, 
		{{-2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBrightness_126-effect2#brightnessIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.3, 1, }, 
		{0.066667, 0.533333, }, 
		{{-1, }, {0.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.533333, 0.633333, }, 
		{{0.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_126-effect3#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.2, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExposure_126-effect4#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.533333, }, 
		{{-2.1, }, {1.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.533333, 0.633333, }, 
		{{1.1, }, {0, }, }, 
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
