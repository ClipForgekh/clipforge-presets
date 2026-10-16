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
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiMotionBlur3D_127-effect1'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiBrightness_127-effect2'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiRadialBlur_127-effect3'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiExposure_127-effect4'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiLinearWipe_126-effect0'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiMotionBlur3D_126-effect1'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiBrightness_126-effect2'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiRadialBlur_126-effect3'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiExposure_126-effect4'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiLayer_126-trs'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
        },
    },
    ['LumiLayer_127-trs-blend'] = {
        ['nodeDuration'] = {{0, 0.66666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.66666666666667}, },
            ['baseTex'] = {{0, 0.66666666666667}, },
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
        ['position'] = Amaz.Vector3f(0.64827586206897, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.64827586206897, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.6,
        ['ae_pre_scale_x'] = 0.6,
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
        ['rotation_x'] = 91,
        ['ae_pre_rotation_x'] = 91,
        ['rotation_y'] = 18,
        ['ae_pre_rotation_y'] = 18,
        ['rotation_z'] = -67,
        ['ae_pre_rotation_z'] = -67,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 16,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiBrightness_127-effect2'] = {
        ['brightnessIntensity'] = -1,
    },
    ['LumiRadialBlur_127-effect3'] = {
        ['blurType'] = 0,
        ['amount'] = 30,
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
        ['exposure'] = -2.1,
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
        ['position'] = Amaz.Vector3f(0.32758620689655, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.32758620689655, 0.5, 0),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.6,
        ['ae_pre_scale_x'] = 0.6,
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
        ['rotation_x'] = 91,
        ['ae_pre_rotation_x'] = 91,
        ['rotation_y'] = -19,
        ['ae_pre_rotation_y'] = -19,
        ['rotation_z'] = 60,
        ['ae_pre_rotation_z'] = 60,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['samples'] = 16,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
    },
    ['LumiBrightness_126-effect2'] = {
        ['brightnessIntensity'] = -1,
    },
    ['LumiRadialBlur_126-effect3'] = {
        ['blurType'] = 0,
        ['amount'] = 30,
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
        ['exposure'] = -2.1,
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
    ['LumiLayer_126-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(290, 290, 0),
        ['position'] = Amaz.Vector3f(290, 290, 0),
        ['scale'] = Amaz.Vector3f(2.1337014194337, 2.1337014194337, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(580, 580),
        ['layerSize'] = Amaz.Vector2f(580, 580),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_127-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(290, 290, 0),
        ['position'] = Amaz.Vector3f(290, 290, 0),
        ['scale'] = Amaz.Vector3f(2.1337014194337, 2.1337014194337, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(580, 580),
        ['layerSize'] = Amaz.Vector2f(580, 580),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur3D_127-effect1#ae_pre_position#vector'] =
{
	{
		{0.7, 0, 0.833333, 0.833333, }, 
		{0.03333333333333, 0.30000033333333, }, 
		{{0.75, 0.5, 0, }, {0.64827586206897, 0.5, 0, }, {0.73304597755958, 0.5, 0, }, {0.66522988450939, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#position#vector'] =
{
	{
		{0.7, 0, 0.833333, 0.833333, }, 
		{0, 0.266667, }, 
		{{0.75, 0.5, 0, }, {0.64827586206897, 0.5, 0, }, {0.73304597755958, 0.5, 0, }, {0.66522988450938, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{1, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.20000033333333, 0.56666633333333, }, 
		{{0.9, }, {0.6, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#scale_x#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{1, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{0.9, }, {0.6, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#ae_pre_rotation_x#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{0, }, {-5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.20000033333333, 0.56666633333333, }, 
		{{-5, }, {91, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#rotation_x#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {-5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{-5, }, {91, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#ae_pre_rotation_y#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{0, }, {-5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.20000033333333, 0.56666633333333, }, 
		{{-5, }, {18, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#rotation_y#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {-5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{-5, }, {18, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#ae_pre_rotation_z#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.20000033333333, 0.56666633333333, }, 
		{{2, }, {-67, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_127-effect1#rotation_z#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{2, }, {-67, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBrightness_127-effect2#brightnessIntensity#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.066667, 0.266667, }, 
		{{0, }, {0.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.833333333, 0.833333333, }, 
		{0.266667, 0.533333, }, 
		{{0.2, }, {-1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_127-effect3#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.4, 0.533333, }, 
		{{0, }, {30, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExposure_127-effect4#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {1.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{1.1, }, {-2.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_position#vector'] =
{
	{
		{0.7, 0, 0.833333, 0.833333, }, 
		{0.03333333333333, 0.30000033333333, }, 
		{{0.25, 0.5, 0, }, {0.32758620689655, 0.5, 0, }, {0.26293103448276, 0.5, 0, }, {0.31465517241379, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#position#vector'] =
{
	{
		{0.7, 0, 0.833333, 0.833333, }, 
		{0, 0.266667, }, 
		{{0.25, 0.5, 0, }, {0.32758620689655, 0.5, 0, }, {0.26293103448276, 0.5, 0, }, {0.31465517241379, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{1, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.20000033333333, 0.56666633333333, }, 
		{{0.9, }, {0.6, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#scale_x#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{1, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{0.9, }, {0.6, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_rotation_x#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{0, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.20000033333333, 0.56666633333333, }, 
		{{5, }, {91, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#rotation_x#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{5, }, {91, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_rotation_y#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{0, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.20000033333333, 0.56666633333333, }, 
		{{5, }, {-19, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#rotation_y#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{5, }, {-19, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#ae_pre_rotation_z#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0.03333333333333, 0.20000033333333, }, 
		{{0, }, {-2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.20000033333333, 0.56666633333333, }, 
		{{-2, }, {60, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_126-effect1#rotation_z#number'] =
{
	{
		{0.84, 0, 0.833333333, 0.833333333, }, 
		{0, 0.166667, }, 
		{{0, }, {-2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.533333, }, 
		{{-2, }, {60, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBrightness_126-effect2#brightnessIntensity#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.066667, 0.266667, }, 
		{{0, }, {0.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.7, 0, 0.833333333, 0.833333333, }, 
		{0.266667, 0.533333, }, 
		{{0.2, }, {-1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_126-effect3#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.4, 0.533333, }, 
		{{0, }, {30, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiExposure_126-effect4#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.2, }, 
		{{0, }, {1.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.2, 0.533333, }, 
		{{1.1, }, {-2.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_126-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.48,0.48,0.48, 1,1,0.48, }, 
		{0.433333, 0.666667, }, 
		{{100, 100, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_127-trs-blend#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.48,0.48,0.48, 1,1,0.48, }, 
		{0.433333, 0.666667, }, 
		{{100, 100, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
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
