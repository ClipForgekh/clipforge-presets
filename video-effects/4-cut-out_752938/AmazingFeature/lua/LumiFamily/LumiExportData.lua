local data = {}

local ae_compDurations = {0, 1.12}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiSaturation_104-effect0'] = {
        ['nodeDuration'] = {{0.04, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.04, 2}, },
        },
    },
    ['LumiFill_104-effect1'] = {
        ['nodeDuration'] = {{0.04, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.04, 2}, },
        },
    },
    ['LumiLayer_104-trs'] = {
        ['nodeDuration'] = {{0.04, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.04, 2}, },
        },
    },
    ['LumiMotionBlur3D_25-effect0'] = {
        ['nodeDuration'] = {{0.04, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.04, 2}, },
        },
    },
    ['LumiBoxBlur_25-effect1'] = {
        ['nodeDuration'] = {{0.04, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.04, 2}, },
        },
    },
    ['LumiSaturation_120-effect0'] = {
        ['nodeDuration'] = {{0.08, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.08, 2}, },
        },
    },
    ['LumiFill_120-effect1'] = {
        ['nodeDuration'] = {{0.08, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.08, 2}, },
        },
    },
    ['LumiLayer_120-trs'] = {
        ['nodeDuration'] = {{0.08, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.08, 2}, },
        },
    },
    ['LumiMotionBlur3D_145-effect0'] = {
        ['nodeDuration'] = {{0.08, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.08, 2}, },
        },
    },
    ['LumiBoxBlur_145-effect1'] = {
        ['nodeDuration'] = {{0.08, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.08, 2}, },
        },
    },
    ['LumiLayer_145-blend'] = {
        ['nodeDuration'] = {{0.04, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.08, 2}, },
            ['baseTex'] = {{0.04, 2}, },
        },
    },
    ['LumiSaturation_133-effect0'] = {
        ['nodeDuration'] = {{0.16, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16, 2}, },
        },
    },
    ['LumiFill_133-effect1'] = {
        ['nodeDuration'] = {{0.16, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16, 2}, },
        },
    },
    ['LumiLayer_133-trs'] = {
        ['nodeDuration'] = {{0.16, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16, 2}, },
        },
    },
    ['LumiMotionBlur3D_146-effect0'] = {
        ['nodeDuration'] = {{0.16, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16, 2}, },
        },
    },
    ['LumiBoxBlur_146-effect1'] = {
        ['nodeDuration'] = {{0.16, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16, 2}, },
        },
    },
    ['LumiSaturation_107-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiFill_107-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_107-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_144-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_146-blend'] = {
        ['nodeDuration'] = {{0.04, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.16, 2}, },
            ['baseTex'] = {{0.04, 2}, },
        },
    },
    ['LumiLayer_144-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0.04, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiSaturation_104-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiFill_104-effect1'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLayer_104-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(400, 400, 0),
        ['position'] = Amaz.Vector3f(400, 400, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(800, 800),
        ['layerSize'] = Amaz.Vector2f(800, 800),
        ['mirrorEdge'] = false,
    },
    ['LumiMotionBlur3D_25-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(-0.14625, 0.5, -0.2075),
        ['ae_pre_position'] = Amaz.Vector3f(-0.14625, 0.5, -0.2075),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.35,
        ['ae_pre_scale_x'] = 0.35,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = -55,
        ['ae_pre_direction_y'] = -55,
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
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiBoxBlur_25-effect1'] = {
        ['blurIntensity'] = 1.5,
        ['iteration'] = 3,
        ['steps'] = 1,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiSaturation_120-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiFill_120-effect1'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLayer_120-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(400, 400, 0),
        ['position'] = Amaz.Vector3f(400, 400, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(800, 800),
        ['layerSize'] = Amaz.Vector2f(800, 800),
        ['mirrorEdge'] = false,
    },
    ['LumiMotionBlur3D_145-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(1.5075, 0.5, 0.3725),
        ['ae_pre_position'] = Amaz.Vector3f(1.5075, 0.5, 0.3725),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.35,
        ['ae_pre_scale_x'] = 0.35,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = -12,
        ['ae_pre_direction_y'] = -12,
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
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiBoxBlur_145-effect1'] = {
        ['blurIntensity'] = 2,
        ['iteration'] = 3,
        ['steps'] = 1,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLayer_145-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiSaturation_133-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiFill_133-effect1'] = {
        ['color'] = Amaz.Color(0.53725492954254, 0.53725492954254, 0.53725492954254, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLayer_133-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(400, 400, 0),
        ['position'] = Amaz.Vector3f(400, 400, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(800, 800),
        ['layerSize'] = Amaz.Vector2f(800, 800),
        ['mirrorEdge'] = false,
    },
    ['LumiMotionBlur3D_146-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(1.43125, 0.5, 0.035),
        ['ae_pre_position'] = Amaz.Vector3f(1.43125, 0.5, 0.035),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.6,
        ['ae_pre_scale_x'] = 0.6,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 36,
        ['ae_pre_direction_y'] = 36,
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
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiBoxBlur_146-effect1'] = {
        ['blurIntensity'] = 1,
        ['iteration'] = 3,
        ['steps'] = 1,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiSaturation_107-effect0'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiFill_107-effect1'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLayer_107-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(400, 400, 0),
        ['position'] = Amaz.Vector3f(400, 400, 0),
        ['scale'] = Amaz.Vector3f(130, 130, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(800, 800),
        ['layerSize'] = Amaz.Vector2f(800, 800),
        ['mirrorEdge'] = false,
    },
    ['LumiMotionBlur3D_144-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(-0.1975, 0.5, -0.155),
        ['ae_pre_position'] = Amaz.Vector3f(-0.1975, 0.5, -0.155),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.63,
        ['ae_pre_scale_x'] = 0.63,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 33,
        ['ae_pre_direction_y'] = 33,
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
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(800, 800),
    },
    ['LumiLayer_146-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLayer_144-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiSaturation_104-effect0#saturationIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.84, }, 
		{{0, }, {-1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_104-effect1#opacity#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.68, 0.84, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiLayer_104-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0,0,0, 1,1,0, }, 
		{0.08, 0.84, }, 
		{{150, 150, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0.08, 0.84, }, 
		{{-20, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0.08, 0.44, }, 
		{{0.41375, 0.5, -0.2075, }, {0.07875, 0.5, -0.2075, }, {0.35791666507721, 0.5, -0.2075, }, {0.13458333492279, 0.5, -0.2075, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.44, 0.88, }, 
		{{0.07875, 0.5, -0.2075, }, {0.07875, 0.5, -0.2075, }, {0.07875, 0.5, -0.2075, }, {0.07875, 0.5, -0.2075, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0, 1, }, 
		{0.88, 1.12, }, 
		{{0.07875, 0.5, -0.2075, }, {-0.14625, 0.5, -0.2075, }, {0.04125, 0.5, -0.2075, }, {-0.10875, 0.5, -0.2075, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect0#position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0.04, 0.4, }, 
		{{0.41375, 0.5, -0.2075, }, {0.07875, 0.5, -0.2075, }, {0.35791666507721, 0.5, -0.2075, }, {0.13458333492279, 0.5, -0.2075, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.4, 0.84, }, 
		{{0.07875, 0.5, -0.2075, }, {0.07875, 0.5, -0.2075, }, {0.07875, 0.5, -0.2075, }, {0.07875, 0.5, -0.2075, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0, 1, }, 
		{0.84, 1.08, }, 
		{{0.07875, 0.5, -0.2075, }, {-0.14625, 0.5, -0.2075, }, {0.04125, 0.5, -0.2075, }, {-0.10875, 0.5, -0.2075, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.37, 1, }, 
		{0.08, 0.24, }, 
		{{47, }, {-41, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.63, 0, 0.833333333, 0.833333333, }, 
		{0.24, 0.72, }, 
		{{-41, }, {-55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect0#direction_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.37, 1, }, 
		{0.04, 0.2, }, 
		{{47, }, {-41, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.63, 0, 0.833333333, 0.833333333, }, 
		{0.2, 0.68, }, 
		{{-41, }, {-55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect0#ae_pre_direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.04, 0.08, }, 
		{{89, }, {9.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.08, 0.12, }, 
		{{9.5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_25-effect0#direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.04, }, 
		{{89, }, {9.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.04, 0.08, }, 
		{{9.5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSaturation_120-effect0#saturationIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.64, 0.92, }, 
		{{0, }, {-1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_120-effect1#opacity#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.8, 0.92, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiLayer_120-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.09, 1, }, 
		{0.16, 0.92, }, 
		{{210, 353, 0, }, {400, 400, 0, }, {241.666666030884, 360.833333492279, 0, }, {368.333333969116, 392.166666507721, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_120-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.09,0.09,0.09, 1,1,0.09, }, 
		{0.16, 0.92, }, 
		{{150, 150, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_145-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0.12, 0.52, }, 
		{{0.82375, 0.5, 0.3725, }, {0.7025, 0.5, 0.3725, }, {0.8035416674614, 0.5, 0.3725, }, {0.7227083325386, 0.5, 0.3725, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.52, 0.88, }, 
		{{0.7025, 0.5, 0.3725, }, {0.7025, 0.5, 0.3725, }, {0.7025, 0.5, 0.3725, }, {0.7025, 0.5, 0.3725, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0, 1, }, 
		{0.88, 1.12, }, 
		{{0.7025, 0.5, 0.3725, }, {1.5075, 0.5, 0.3725, }, {0.83666666984558, 0.5, 0.3725, }, {1.37333333015442, 0.5, 0.3725, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_145-effect0#position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0.08, 0.48, }, 
		{{0.82375, 0.5, 0.3725, }, {0.7025, 0.5, 0.3725, }, {0.8035416674614, 0.5, 0.3725, }, {0.7227083325386, 0.5, 0.3725, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.48, 0.84, }, 
		{{0.7025, 0.5, 0.3725, }, {0.7025, 0.5, 0.3725, }, {0.7025, 0.5, 0.3725, }, {0.7025, 0.5, 0.3725, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0, 1, }, 
		{0.84, 1.08, }, 
		{{0.7025, 0.5, 0.3725, }, {1.5075, 0.5, 0.3725, }, {0.83666666984558, 0.5, 0.3725, }, {1.37333333015442, 0.5, 0.3725, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_145-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.17, 1, }, 
		{0.12, 0.72, }, 
		{{27, }, {-12, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_145-effect0#direction_y#number'] =
{
	{
		{0.166666667, 0.166666667, 0.17, 1, }, 
		{0.08, 0.68, }, 
		{{27, }, {-12, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_145-effect0#ae_pre_direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.08, 0.12, }, 
		{{-45, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.12, 0.16, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur3D_145-effect0#direction_z#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.04, 0.08, }, 
		{{-45, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.08, 0.12, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSaturation_133-effect0#saturationIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.68, 0.92, }, 
		{{0, }, {-1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_133-effect1#opacity#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.8, 0.88, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiLayer_133-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0.16, 0.92, }, 
		{{400, 554, 0, }, {400, 400, 0, }, {400, 528.333333969116, 0, }, {400, 425.666666030884, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_133-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0,0,0, 1,1,0, }, 
		{0.16, 0.92, }, 
		{{150, 150, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_133-trs#rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0.16, 0.92, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_146-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0.2, 0.56, }, 
		{{1.17375, 0.5, 0.035, }, {1.09375, 0.5, 0.035, }, {1.1604166662693, 0.5, 0.035, }, {1.1070833337307, 0.5, 0.035, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.56, 0.88, }, 
		{{1.09375, 0.5, 0.035, }, {1.09375, 0.5, 0.035, }, {1.09375, 0.5, 0.035, }, {1.09375, 0.5, 0.035, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0, 1, }, 
		{0.88, 1.08, }, 
		{{1.09375, 0.5, 0.035, }, {1.43125, 0.5, 0.035, }, {1.15, 0.5, 0.035, }, {1.375, 0.5, 0.035, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_146-effect0#position#vector'] =
{
	{
		{0.166667, 0.166667, 0, 1, }, 
		{0.16, 0.52, }, 
		{{1.17375, 0.5, 0.035, }, {1.09375, 0.5, 0.035, }, {1.1604166662693, 0.5, 0.035, }, {1.1070833337307, 0.5, 0.035, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.52, 0.84, }, 
		{{1.09375, 0.5, 0.035, }, {1.09375, 0.5, 0.035, }, {1.09375, 0.5, 0.035, }, {1.09375, 0.5, 0.035, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0, 1, }, 
		{0.84, 1.04, }, 
		{{1.09375, 0.5, 0.035, }, {1.43125, 0.5, 0.035, }, {1.15, 0.5, 0.035, }, {1.375, 0.5, 0.035, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_146-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.340714126, 0.058969753, 0.523908322, 0.836591071, }, 
		{0.2, 0.28, }, 
		{{-18, }, {30, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.159928353, 2.41525691, 0.430026904, 1, }, 
		{0.28, 0.72, }, 
		{{30, }, {36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_146-effect0#direction_y#number'] =
{
	{
		{0.340714126, 0.058969753, 0.523908322, 0.836591071, }, 
		{0.16, 0.24, }, 
		{{-18, }, {30, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.159928353, 2.41525691, 0.430026904, 1, }, 
		{0.24, 0.68, }, 
		{{30, }, {36, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSaturation_107-effect0#saturationIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.76, 1, }, 
		{{0, }, {-1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_107-effect1#opacity#number'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0.84, 1, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{2, }, 
	}, 
},
    ['LumiLayer_107-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.3,0.3,0.3, 1,1,0.3, }, 
		{0.2, 1, }, 
		{{100, 100, 100, }, {130, 130, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_144-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0, 0, 1, }, 
		{0.04, 0.36, }, 
		{{0.5, 0.5, 0, }, {0.3975, 0.5, -0.155, }, {0.4829166662693, 0.5, -0.0258333325386, }, {0.4145833337307, 0.5, -0.1291666674614, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.36, 0.56, }, 
		{{0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.56, 0.88, }, 
		{{0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0, 1, }, 
		{0.88, 1.08, }, 
		{{0.3975, 0.5, -0.155, }, {-0.1975, 0.5, -0.155, }, {0.29833333015442, 0.5, -0.155, }, {-0.09833333015442, 0.5, -0.155, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_144-effect0#position#vector'] =
{
	{
		{0.166667, 0, 0, 1, }, 
		{0, 0.32, }, 
		{{0.5, 0.5, 0, }, {0.3975, 0.5, -0.155, }, {0.4829166662693, 0.5, -0.0258333325386, }, {0.4145833337307, 0.5, -0.1291666674614, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.32, 0.52, }, 
		{{0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0, 0, }, 
		{0.52, 0.84, }, 
		{{0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, {0.3975, 0.5, -0.155, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0, 1, }, 
		{0.84, 1.04, }, 
		{{0.3975, 0.5, -0.155, }, {-0.1975, 0.5, -0.155, }, {0.29833333015442, 0.5, -0.155, }, {-0.09833333015442, 0.5, -0.155, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_144-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.04, 0.36, }, 
		{{1, }, {0.63, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_144-effect0#scale_x#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0, 0.32, }, 
		{{1, }, {0.63, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_144-effect0#ae_pre_direction_y#number'] =
{
	{
		{0.166666667, 0, 0, 1, }, 
		{0.04, 0.36, }, 
		{{0, }, {40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0.833333333, }, 
		{0.36, 0.56, }, 
		{{40, }, {38, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.286962333, 0.833333333, 0.833333333, }, 
		{0.56, 0.88, }, 
		{{38, }, {33, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_144-effect0#direction_y#number'] =
{
	{
		{0.166666667, 0, 0, 1, }, 
		{0, 0.32, }, 
		{{0, }, {40, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0.833333333, }, 
		{0.32, 0.52, }, 
		{{40, }, {38, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.286962333, 0.833333333, 0.833333333, }, 
		{0.52, 0.84, }, 
		{{38, }, {33, }, }, 
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
