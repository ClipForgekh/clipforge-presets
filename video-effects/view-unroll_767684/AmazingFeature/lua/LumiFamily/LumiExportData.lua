local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiFill_162-effect0', 'InputTex', 1},
    {'LumiFill_137-effect0', 'InputTex', 1},
    {'LumiTone_131-effect0', 'InputTex', 1},
    {'LumiMotionBlur2D_154-effect0', 'InputTex', 1},
    {'LumiMotionBlur2D_159-effect0', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiFill_162-effect0'] = {
        ['nodeDuration'] = {{1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3}, },
        },
    },
    ['LumiLayer_162-trs'] = {
        ['nodeDuration'] = {{1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3}, },
        },
    },
    ['LumiFill_137-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_137-trs'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiTone_131-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiExtractFrame_131-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_131-trs'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiHalftone_156-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_156-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiDropShadow_153-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_153-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiDropShadow_157-effect0'] = {
        ['nodeDuration'] = {{1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3}, },
        },
    },
    ['LumiLayer_157-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiMotionBlur2D_154-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_154-matte-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
            ['maskTex'] = {{0, 1}, },
        },
    },
    ['LumiMotionBlur2D_159-effect0'] = {
        ['nodeDuration'] = {{1, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3.33333333333333}, },
        },
    },
    ['LumiLayer_159-matte-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
            ['maskTex'] = {{1, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiFill_162-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_162-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 540, 0),
        ['position'] = Amaz.Vector3f(902.400024414062, -348.888885498047, 0),
        ['scale'] = Amaz.Vector3f(6, 51, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 132.7,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiFill_137-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_137-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 540, 0),
        ['position'] = Amaz.Vector3f(-56.6399993896484, 540, 0),
        ['scale'] = Amaz.Vector3f(105.900001525879, 51, 100),
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
    ['LumiTone_131-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0, 0, 0, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiExtractFrame_131-effect1'] = {
        ['fps'] = 12,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_131-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(133.3, 133.3, 100),
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
    ['LumiHalftone_156-effect0'] = {
        ['colorMode'] = 2,
        ['blackDots'] = true,
        ['dotFreq'] = 174,
        ['rotationAngle'] = -30,
        ['dotsRelativeWidth'] = 1,
        ['dotsSharpen'] = 1,
        ['dotsLighten'] = 0,
        ['color1'] = Amaz.Color(0.51764708757401, 0.51764708757401, 0.51764708757401, 1),
        ['color2'] = Amaz.Color(0, 0, 0, 1),
        ['dotsShift'] = Amaz.Vector2f(0, 0),
        ['alternateShift'] = Amaz.Vector2f(0, 0),
        ['redOffsetX'] = 0,
        ['redOffsetY'] = 0.25,
        ['greenOffsetX'] = 0,
        ['greenOffsetY'] = 0,
        ['blueOffsetX'] = 0,
        ['blueOffsetY'] = -0.25,
        ['smoothFactor'] = 0,
        ['useRings'] = false,
        ['ringThickness'] = 0.5,
        ['ringCount'] = 6,
        ['ringPhase'] = 1,
        ['quality'] = 0.5,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_156-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 2,
    },
    ['LumiDropShadow_153-effect0'] = {
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['shadowOpacity'] = 1,
        ['shadowAngle'] = 135,
        ['shadowDistance'] = 0,
        ['width'] = 75.1999999999999,
        ['onlyShadow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_153-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiDropShadow_157-effect0'] = {
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['shadowOpacity'] = 1,
        ['shadowAngle'] = 135,
        ['shadowDistance'] = 0,
        ['width'] = 75.1999999999999,
        ['onlyShadow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_157-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_154-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.98703703703704),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.98703703703704),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.75,
        ['ae_pre_scale_x'] = 0.75,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_154-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_159-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.98703703703704),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.98703703703704),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.75,
        ['ae_pre_scale_x'] = 0.75,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_159-matte-blend'] = {
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
    ['LumiLayer_162-trs#position#vector'] =
{
	{
		{0.77, 0, 0.330435, 1, }, 
		{1.033333, 1.548275, }, 
		{{-56.63999939, 540, 0, }, {902.400024414, 540, 0, }, {-56.63999939, 540, 0, }, {902.400024414, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.86, 0, 0.89, 1, }, 
		{1.548275, 1.773568, }, 
		{{902.400024414, 540, 0, }, {902.400024414, -348.888885498, 0, }, {902.400024414, 540, 0, }, {902.400024414, -348.888885498, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_162-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{1.194238, 1.483919, }, 
		{{105.900001526, 51, 100, }, {6, 51, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_162-trs#rotation#number'] =
{
	{
		{0.86, 0, 0.89, 1, }, 
		{1.27474, 1.966667, }, 
		{{0, }, {132.7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_137-trs#position#vector'] =
{
	{
		{0.11, 0, 0.14, 1, }, 
		{0.193099, 0.418392, }, 
		{{902.400024414, -348.888885498, 0, }, {902.400024414, 540, 0, }, {902.400024414, -348.888885498, 0, }, {902.400024414, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.669565, 0, 0.23, 1, }, 
		{0.418392, 0.933333, }, 
		{{902.400024414, 540, 0, }, {-56.63999939, 540, 0, }, {902.400024414, 540, 0, }, {-56.63999939, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_137-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 1,0.833333333,0.833333333, }, 
		{0.482747, 0.772428, }, 
		{{6, 51, 100, }, {105.900001526, 51, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_137-trs#rotation#number'] =
{
	{
		{0.11, 0, 0.14, 1, }, 
		{0, 0.691927, }, 
		{{132.699997, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTone_131-effect0#whiteColor#color'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.533333, }, 
		{{0, 0, 0, 1, }, {0.898039, 0.898039, 0.898039, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.533333, 1.433333, }, 
		{{0.898039, 0.898039, 0.898039, 1, }, {0.898039, 0.898039, 0.898039, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.966667, }, 
		{{0.898039, 0.898039, 0.898039, 1, }, {0, 0, 0, 1, }, }, 
		{6418, }, 
		{1, }, 
	}, 
},
    ['LumiMotionBlur2D_154-effect0#ae_pre_position#vector'] =
{
	{
		{0.11, 0, 0.27, 1, }, 
		{0.03333333333333, 0.61813133333333, }, 
		{{0.5, 0.98703703703704, }, {0.5, 0.5, }, {0.5, 0.98703703703704, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.779651, 0.779651, }, 
		{0.61813133333333, 1.41520133333333, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.73, 0, 0.89, 1, }, 
		{1.41520133333333, 2.00000033333333, }, 
		{{0.5, 0.5, }, {0.5, 0.98703703703704, }, {0.5, 0.5, }, {0.5, 0.98703703703704, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_154-effect0#position#vector'] =
{
	{
		{0.11, 0, 0.27, 1, }, 
		{0, 0.584798, }, 
		{{0.5, 0.98703703703704, }, {0.5, 0.5, }, {0.5, 0.98703703703704, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.779651, 0.779651, }, 
		{0.584798, 1.381868, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.73, 0, 0.89, 1, }, 
		{1.381868, 1.966667, }, 
		{{0.5, 0.5, }, {0.5, 0.98703703703704, }, {0.5, 0.5, }, {0.5, 0.98703703703704, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_159-effect0#ae_pre_position#vector'] =
{
	{
		{0.11, 0, 0.27, 1, }, 
		{0.03333333333333, 0.61813133333333, }, 
		{{0.5, 0.98703703703704, }, {0.5, 0.5, }, {0.5, 0.98703703703704, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.779651, 0.779651, }, 
		{0.61813133333333, 1.41520133333333, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.73, 0, 0.89, 1, }, 
		{1.41520133333333, 2.00000033333333, }, 
		{{0.5, 0.5, }, {0.5, 0.98703703703704, }, {0.5, 0.5, }, {0.5, 0.98703703703704, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_159-effect0#position#vector'] =
{
	{
		{0.11, 0, 0.27, 1, }, 
		{0, 0.584798, }, 
		{{0.5, 0.98703703703704, }, {0.5, 0.5, }, {0.5, 0.98703703703704, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.779651, 0.779651, }, 
		{0.584798, 1.381868, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.73, 0, 0.89, 1, }, 
		{1.381868, 1.966667, }, 
		{{0.5, 0.5, }, {0.5, 0.98703703703704, }, {0.5, 0.5, }, {0.5, 0.98703703703704, }, }, 
		{6415, }, 
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
