local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiCornerPin_102-effect0', 'InputTex', 0},
    {'LumiMotionBlur2D_104-effect0', 'InputTex', 0},
    {'LumiCornerPin_103-effect0', 'InputTex', 0},
    {'LumiCornerPin_101-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiCornerPin_102-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_102-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_104-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiCornerPin_103-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_103-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_103-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_104-matte'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiCornerPin_101-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_101-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_102-matte-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiCornerPin_102-effect0'] = {
        ['leftUpVertex'] = Amaz.Vector2f(0, 1),
        ['rightUpVertex'] = Amaz.Vector2f(1, 1),
        ['leftDownVertex'] = Amaz.Vector2f(0, 0),
        ['rightDownVertex'] = Amaz.Vector2f(1, 0),
        ['motionTileType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiMotionBlur2D_102-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiMotionBlur2D_104-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiCornerPin_103-effect0'] = {
        ['leftUpVertex'] = Amaz.Vector2f(0.5, 1),
        ['rightUpVertex'] = Amaz.Vector2f(1, 1),
        ['leftDownVertex'] = Amaz.Vector2f(0.5, 0),
        ['rightDownVertex'] = Amaz.Vector2f(1, 0),
        ['motionTileType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiMotionBlur2D_103-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_103-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 1280, 0),
        ['position'] = Amaz.Vector3f(360, 1280, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_104-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
    },
    ['LumiCornerPin_101-effect0'] = {
        ['leftUpVertex'] = Amaz.Vector2f(0, 1),
        ['rightUpVertex'] = Amaz.Vector2f(0.5, 1),
        ['leftDownVertex'] = Amaz.Vector2f(0, 0),
        ['rightDownVertex'] = Amaz.Vector2f(0.5, 0),
        ['motionTileType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiMotionBlur2D_101-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_102-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_102-effect1#ae_pre_rotate#number'] =
{
	{
		{0.606105324, -0.000004134, 0.393894503, 0.999999397, }, 
		{1.03333333333333, 2.00000033333333, }, 
		{{0, }, {-22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_102-effect1#rotate#number'] =
{
	{
		{0.606105324, -0.000004134, 0.393894503, 0.999999397, }, 
		{1, 1.966667, }, 
		{{0, }, {-22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_102-effect1#ae_pre_position#vector'] =
{
	{
		{0.669443, 0, 0.557454, 1, }, 
		{1.10000033333333, 2.00000033333333, }, 
		{{0.5, 0.5, }, {0.36111111111111, -0.5390625, }, {0.5, 0.41202619671822, }, {0.36111111111111, -0.52195817828178, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_102-effect1#position#vector'] =
{
	{
		{0.669443, 0, 0.557454, 1, }, 
		{1.066667, 1.966667, }, 
		{{0.5, 0.5, }, {0.36111111111111, -0.5390625, }, {0.5, 0.41202619671822, }, {0.36111111111111, -0.52195817828178, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_102-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_102-effect1#scale_x#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1, 1.333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_102-effect1#ae_pre_scale_y#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_102-effect1#scale_y#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1, 1.333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_104-effect0#ae_pre_rotate#number'] =
{
	{
		{0.606105324, 0.000002994, 0.393894503, 1.000000437, }, 
		{1.20000033333333, 1.90000033333333, }, 
		{{0, }, {22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_104-effect0#rotate#number'] =
{
	{
		{0.606105324, 0.000002994, 0.393894503, 1.000000437, }, 
		{1.166667, 1.866667, }, 
		{{0, }, {22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_104-effect0#ae_pre_position#vector'] =
{
	{
		{0.669443, 0, 0.557454, 1, }, 
		{1.10000033333333, 2.00000033333333, }, 
		{{0.5, 0.5, }, {0.64583333333333, -0.5625, }, {0.5, 0.41202619671822, }, {0.64583333333333, -0.54539567828178, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_104-effect0#position#vector'] =
{
	{
		{0.669443, 0, 0.557454, 1, }, 
		{1.066667, 1.966667, }, 
		{{0.5, 0.5, }, {0.64583333333333, -0.5625, }, {0.5, 0.41202619671822, }, {0.64583333333333, -0.54539567828178, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_104-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_104-effect0#scale_x#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1, 1.333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_104-effect0#ae_pre_scale_y#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_104-effect0#scale_y#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1, 1.333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_103-effect1#ae_pre_rotate#number'] =
{
	{
		{0.606105324, 0.000002994, 0.393894503, 1.000000437, }, 
		{1.20000033333333, 1.90000033333333, }, 
		{{0, }, {22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_103-effect1#rotate#number'] =
{
	{
		{0.606105324, 0.000002994, 0.393894503, 1.000000437, }, 
		{1.166667, 1.866667, }, 
		{{0, }, {22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_103-effect1#ae_pre_position#vector'] =
{
	{
		{0.669443, 0, 0.557454, 1, }, 
		{1.10000033333333, 2.00000033333333, }, 
		{{0.5, 0.5, }, {0.64583333333333, -0.5625, }, {0.5, 0.41202619671822, }, {0.64583333333333, -0.54539567828178, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_103-effect1#position#vector'] =
{
	{
		{0.669443, 0, 0.557454, 1, }, 
		{1.066667, 1.966667, }, 
		{{0.5, 0.5, }, {0.64583333333333, -0.5625, }, {0.5, 0.41202619671822, }, {0.64583333333333, -0.54539567828178, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_103-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_103-effect1#scale_x#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1, 1.333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_103-effect1#ae_pre_scale_y#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_103-effect1#scale_y#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1, 1.333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#ae_pre_rotate#number'] =
{
	{
		{0.606105324, -0.000004134, 0.393894503, 0.999999397, }, 
		{1.03333333333333, 2.00000033333333, }, 
		{{0, }, {-22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#rotate#number'] =
{
	{
		{0.606105324, -0.000004134, 0.393894503, 0.999999397, }, 
		{1, 1.966667, }, 
		{{0, }, {-22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#ae_pre_position#vector'] =
{
	{
		{0.669443, 0, 0.557454, 1, }, 
		{1.10000033333333, 2.00000033333333, }, 
		{{0.5, 0.5, }, {0.36111111111111, -0.5390625, }, {0.5, 0.41202619671822, }, {0.36111111111111, -0.52195817828178, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#position#vector'] =
{
	{
		{0.669443, 0, 0.557454, 1, }, 
		{1.066667, 1.966667, }, 
		{{0.5, 0.5, }, {0.36111111111111, -0.5390625, }, {0.5, 0.41202619671822, }, {0.36111111111111, -0.52195817828178, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#scale_x#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1, 1.333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#ae_pre_scale_y#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{1, }, {1.09, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_101-effect1#scale_y#number'] =
{
	{
		{0.603254551, -0.000004138, 0.396893746, 0.999998691, }, 
		{1, 1.333333, }, 
		{{1, }, {1.09, }, }, 
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
