local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_106-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_105-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_104-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_103-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_103-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiOpticsCompensation_102-effect0'] = {
        ['nodeDuration'] = {{0.66666666666667, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 2}, },
        },
    },
    ['LumiLayer_102-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.66666666666667, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_106-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(0, 0, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 26,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 580, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_105-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(0, 0, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -14,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 580, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_104-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(0, 0, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -24,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 580, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGaussianBlur_103-effect0'] = {
        ['blurIntensity'] = 0,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_103-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiOpticsCompensation_102-effect0'] = {
        ['fov'] = 180,
        ['inverseLensDistortion'] = true,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_102-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, -40, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 580, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_106-trs#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0, 0.666667, }, 
		{{0, 0, 0, }, {-175.882352944, -215.882352944, 0, }, {-29.3137264251709, -35.9803924560547, 0, }, {-149.215686913116, -182.549020882232, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0,0,0.66666667, 1.000000061,1.000000061,0.66666667, }, 
		{0, 0.666667, }, 
		{{0, 0, 100, }, {35, 35, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs#rotation#number'] =
{
	{
		{0.33333333, 0, 0, 0.999999956, }, 
		{0.033333, 0.7, }, 
		{{26, }, {-22, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.666667, }, 
		{{540, 580, 0, }, {597, 525, 0, }, {540, 580, 0, }, {597, 525, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 0.833333, }, 
		{{597, 525, 0, }, {507, 610, 0, }, {597, 525, 0, }, {507, 610, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.833333, 1, }, 
		{{507, 610, 0, }, {570, 546, 0, }, {507, 610, 0, }, {570, 546, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.166667, }, 
		{{570, 546, 0, }, {540, 580, 0, }, {570, 546, 0, }, {540, 580, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_106-trs#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.666667, }, 
		{{100, 100, 100, }, {120, 120, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.666667, 1.166667, }, 
		{{120, 120, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.333333, 1, }, 
		{{0, 0, 0, }, {212.266099086, -68.491078707, 0, }, {35.3776817321777, -11.4151802062988, 0, }, {182.266099086, -58.491078707, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0,0,0.66666667, 1.000000061,1.000000061,0.66666667, }, 
		{0.333333, 1, }, 
		{{0, 0, 100, }, {35, 35, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs-blend#rotation#number'] =
{
	{
		{0.33333333, 0, 0, 1.000000066, }, 
		{0.366667, 1.033333, }, 
		{{-14, }, {18, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.666667, }, 
		{{540, 580, 0, }, {597, 525, 0, }, {540, 580, 0, }, {597, 525, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 0.833333, }, 
		{{597, 525, 0, }, {507, 610, 0, }, {597, 525, 0, }, {507, 610, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.833333, 1, }, 
		{{507, 610, 0, }, {570, 546, 0, }, {507, 610, 0, }, {570, 546, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.166667, }, 
		{{570, 546, 0, }, {540, 580, 0, }, {570, 546, 0, }, {540, 580, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs-blend#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.666667, }, 
		{{100, 100, 100, }, {120, 120, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.666667, 1.166667, }, 
		{{120, 120, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.166667, 0.833333, }, 
		{{0, 0, 0, }, {-152.055662719, 137.222375312, 0, }, {-25.3426113128662, 22.8703956604004, 0, }, {-128.722328749884, 117.222375312, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0,0,0.66666667, 1.000000057,1.000000057,0.66666667, }, 
		{0.166667, 0.833333, }, 
		{{0, 0, 100, }, {37, 37, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#rotation#number'] =
{
	{
		{0.33333333, 0, 0, 1.000000043, }, 
		{0.2, 0.866667, }, 
		{{-24, }, {26, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.666667, }, 
		{{540, 580, 0, }, {597, 525, 0, }, {540, 580, 0, }, {597, 525, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 0.833333, }, 
		{{597, 525, 0, }, {507, 610, 0, }, {597, 525, 0, }, {507, 610, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.833333, 1, }, 
		{{507, 610, 0, }, {570, 546, 0, }, {507, 610, 0, }, {570, 546, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.166667, }, 
		{{570, 546, 0, }, {540, 580, 0, }, {570, 546, 0, }, {540, 580, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.666667, }, 
		{{100, 100, 100, }, {120, 120, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.666667, 1.166667, }, 
		{{120, 120, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_103-effect0#blurIntensity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.666667, 1, }, 
		{{0, }, {990, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiOpticsCompensation_102-effect0#fov#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.666667, 1.333333, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_102-trs-blend#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.666667, 1, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_102-trs-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.666667, }, 
		{{540, 580, 0, }, {597, 525, 0, }, {540, 580, 0, }, {597, 525, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 0.833333, }, 
		{{597, 525, 0, }, {507, 610, 0, }, {597, 525, 0, }, {507, 610, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.833333, 1, }, 
		{{507, 610, 0, }, {570, 546, 0, }, {507, 610, 0, }, {570, 546, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.166667, }, 
		{{570, 546, 0, }, {540, 580, 0, }, {570, 546, 0, }, {540, 580, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_102-trs-blend#p0_scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.666667, }, 
		{{100, 100, 100, }, {120, 120, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.666667, 1.166667, }, 
		{{120, 120, 100, }, {100, 100, 100, }, }, 
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
