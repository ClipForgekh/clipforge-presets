local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiMotionBlur2D_2335-effect0', 'InputTex', 0},
    {'LumiMotionBlur2D_2338-effect0', 'InputTex', 0},
    {'LumiLayer_2338-matte-blend', 'baseTex', 0},
    {'LumiMotionBlur2D_2337-effect0', 'InputTex', 0},
    {'LumiMotionBlur2D_2336-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_2335-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiMotionBlur2D_2338-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_2285-trs'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_2338-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{0, 0.03333333333333}, },
            ['maskTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_2287-trs'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_2335-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{0, 1.9}, },
            ['maskTex'] = {{0, 1.9}, },
        },
    },
    ['LumiMotionBlur2D_2337-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_2284-trs'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_2337-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{0, 1.9}, },
            ['maskTex'] = {{0, 1.9}, },
        },
    },
    ['LumiMotionBlur2D_2336-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_2286-trs'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_2336-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{0, 1.9}, },
            ['maskTex'] = {{0, 1.9}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_2335-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(1.34990805147554, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(1.34990805147554, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1.37747752206063,
        ['ae_pre_scale_x'] = 1.37747752206063,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_2338-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.39299191832211, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.39299191832211, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1.34716230403401,
        ['ae_pre_scale_x'] = 1.34716230403401,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_2285-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 270, 0),
        ['position'] = Amaz.Vector3f(540, 1080, 0),
        ['scale'] = Amaz.Vector3f(100, 104.444444444444, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 270),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2338-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_2287-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 135, 0),
        ['position'] = Amaz.Vector3f(540, 675, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 270),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2335-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_2337-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(1.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(1.5, 0.5),
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
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_2284-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 0, 0),
        ['position'] = Amaz.Vector3f(540, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 104.444444444444, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 270),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2337-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_2336-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(-0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(-0.5, 0.5),
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
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_2286-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 135, 0),
        ['position'] = Amaz.Vector3f(540, 405, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 270),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_2336-matte-blend'] = {
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
    ['LumiMotionBlur2D_2335-effect0#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.73333333333333, 1.56666633333333, }, 
		{{0.5, 0.5, }, {1.5, 0.5, }, {0.5, 0.5, }, {1.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2335-effect0#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.7, 1.533333, }, 
		{{0.5, 0.5, }, {1.5, 0.5, }, {0.5, 0.5, }, {1.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2335-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.73333333333333, 1.13333333333333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{1.13333333333333, 1.56666633333333, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2335-effect0#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.7, 1.1, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{1.1, 1.533333, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2338-effect0#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.06666633333333, 1.90000033333333, }, 
		{{0.5, 0.5, }, {-0.5, 0.5, }, {0.5, 0.5, }, {-0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2338-effect0#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.033333, 1.866667, }, 
		{{0.5, 0.5, }, {-0.5, 0.5, }, {0.5, 0.5, }, {-0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2338-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.06666633333333, 1.46666633333333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{1.46666633333333, 1.90000033333333, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2338-effect0#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.033333, 1.433333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{1.433333, 1.866667, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2337-effect0#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.06666633333333, 0.90000033333333, }, 
		{{0.5, 0.5, }, {1.5, 0.5, }, {0.5, 0.5, }, {1.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2337-effect0#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.033333, 0.866667, }, 
		{{0.5, 0.5, }, {1.5, 0.5, }, {0.5, 0.5, }, {1.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2337-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.06666633333333, 0.46666633333333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{0.46666633333333, 0.90000033333333, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2337-effect0#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.033333, 0.433333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{0.433333, 0.866667, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2336-effect0#ae_pre_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.40000033333333, 1.23333333333333, }, 
		{{0.5, 0.5, }, {-0.5, 0.5, }, {0.5, 0.5, }, {-0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2336-effect0#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.366667, 1.2, }, 
		{{0.5, 0.5, }, {-0.5, 0.5, }, {0.5, 0.5, }, {-0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2336-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.40000033333333, 0.80000033333333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{0.80000033333333, 1.23333333333333, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_2336-effect0#scale_x#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.366667, 0.766667, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{0.766667, 1.2, }, 
		{{1.5, }, {1, }, }, 
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
