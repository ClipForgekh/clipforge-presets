local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiFill_184-effect0', 'InputTex', 1},
    {'LumiFill_137-effect0', 'InputTex', 1},
    {'LumiTone_54-effect0', 'InputTex', 1},
    {'LumiMotionBlur2D_153-effect0', 'InputTex', 1},
    {'LumiMotionBlur2D_196-effect0', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiFill_184-effect0'] = {
        ['nodeDuration'] = {{1, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3.33333333333333}, },
        },
    },
    ['LumiCornerPin_184-effect1'] = {
        ['nodeDuration'] = {{1, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3.33333333333333}, },
        },
    },
    ['LumiFill_137-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiCornerPin_137-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiTone_54-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiGaussianBlur_54-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiDropShadow_154-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_154-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiDropShadow_197-effect0'] = {
        ['nodeDuration'] = {{1, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3.33333333333333}, },
        },
    },
    ['LumiLayer_197-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiMotionBlur2D_153-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_153-matte-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
            ['maskTex'] = {{0, 1}, },
        },
    },
    ['LumiMotionBlur2D_196-effect0'] = {
        ['nodeDuration'] = {{1, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3.33333333333333}, },
        },
    },
    ['LumiLayer_196-matte-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
            ['maskTex'] = {{1, 3.33333333333333}, },
        },
    },
    ['LumiBCC_Prism_45-effect0'] = {
        ['nodeDuration'] = {{0, 3.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiChromaticAberration_45-effect1'] = {
        ['nodeDuration'] = {{0, 3.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.9}, },
        },
    },
    ['LumiLayer_45-blend'] = {
        ['nodeDuration'] = {{0, 3.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.9}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiFill_184-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiCornerPin_184-effect1'] = {
        ['leftUpVertex'] = Amaz.Vector2f(0.4418981552124, 1.09382714165582),
        ['rightUpVertex'] = Amaz.Vector2f(0.77361106872559, 1.13786010742188),
        ['leftDownVertex'] = Amaz.Vector2f(0.17615741093953, -0.06831280743634),
        ['rightDownVertex'] = Amaz.Vector2f(0.52106482187907, -0.4876543963397),
        ['motionTileType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiFill_137-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 1,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiCornerPin_137-effect1'] = {
        ['leftUpVertex'] = Amaz.Vector2f(0.24444444179535, -0.05679011874729),
        ['rightUpVertex'] = Amaz.Vector2f(0.46111110846202, -0.09958847893609),
        ['leftDownVertex'] = Amaz.Vector2f(0.10740741093953, -0.37201645462601),
        ['rightDownVertex'] = Amaz.Vector2f(0.43148148059845, -0.48395062199345),
        ['motionTileType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTone_54-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.3137255012989, 0.3137255012989, 0.3137255012989, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiGaussianBlur_54-effect1'] = {
        ['blurIntensity'] = 20,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiDropShadow_154-effect0'] = {
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['shadowOpacity'] = 1,
        ['shadowAngle'] = 135,
        ['shadowDistance'] = 0,
        ['width'] = 53,
        ['onlyShadow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_154-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiDropShadow_197-effect0'] = {
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['shadowOpacity'] = 1,
        ['shadowAngle'] = 135,
        ['shadowDistance'] = 0,
        ['width'] = 53,
        ['onlyShadow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_197-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_153-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.43020833333333, -0.26574074074074),
        ['ae_pre_position'] = Amaz.Vector2f(0.43020833333333, -0.26574074074074),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.7,
        ['ae_pre_scale_x'] = 0.7,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_153-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur2D_196-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.43020833333333, -0.26574074074074),
        ['ae_pre_position'] = Amaz.Vector2f(0.43020833333333, -0.26574074074074),
        ['unifiedScale'] = true,
        ['scale_x'] = 0.7,
        ['ae_pre_scale_x'] = 0.7,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_196-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_45-effect0'] = {
        ['globalTransform'] = 100,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 1,
        ['scaleStart'] = 102,
        ['scaleEnd'] = 98,
        ['angleStart'] = 0,
        ['angleEnd'] = 0,
        ['falloff'] = 0,
        ['offsetStart'] = Amaz.Vector2f(0.5, 0.5),
        ['offsetEnd'] = Amaz.Vector2f(0.5, 0.5),
        ['colorStart'] = Amaz.Color(1, 0, 0, 1),
        ['colorMid'] = Amaz.Color(0, 1, 0, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 1, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiChromaticAberration_45-effect1'] = {
        ['offsetX'] = 0.05000000031931,
        ['offsetY'] = 0.05000000031931,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_45-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiCornerPin_184-effect1#leftUpVertex#vector'] =
{
	{
		{1, 0, 0.838204, 1, }, 
		{1.333333, 2, }, 
		{{0.4418981552125, 1.09382714165556, }, {0.24444443384792, -0.05679016113241, }, {0.4418981552125, 1.09382714165556, }, {0.24444443384792, -0.05679016113241, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_184-effect1#rightUpVertex#vector'] =
{
	{
		{1, 0, 0.838204, 1, }, 
		{1.333333, 2, }, 
		{{0.77361106872552, 1.13786010742222, }, {0.46111110051458, -0.09958846480741, }, {0.77361106872552, 1.13786010742222, }, {0.46111110051458, -0.09958846480741, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_184-effect1#leftDownVertex#vector'] =
{
	{
		{1, 0, 0.838204, 1, }, 
		{1.333333, 2, }, 
		{{0.17615741093958, -0.06831280743611, }, {0.10740741093958, -0.37201651113981, }, {0.17615741093958, -0.06831280743611, }, {0.10740741093958, -0.37201651113981, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_184-effect1#rightDownVertex#vector'] =
{
	{
		{1, 0.000001, 0.838204, 1, }, 
		{1.333333, 2, }, 
		{{0.52106482187917, -0.48765439633981, }, {0.43148148854583, -0.48395057960833, }, {0.52106482187917, -0.48765439633981, }, {0.43148148854583, -0.48395057960833, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_137-effect1#leftUpVertex#vector'] =
{
	{
		{0.161796, 0, 0, 1, }, 
		{0, 0.666667, }, 
		{{0.24444444179531, -0.05679011874722, }, {0.4418981552125, 1.09382714165556, }, {0.24444444179531, -0.05679011874722, }, {0.4418981552125, 1.09382714165556, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_137-effect1#rightUpVertex#vector'] =
{
	{
		{0.161796, 0, 0, 1, }, 
		{0, 0.666667, }, 
		{{0.46111110846198, -0.09958847893611, }, {0.77361110051458, 1.13786010742222, }, {0.46111110846198, -0.09958847893611, }, {0.77361110051458, 1.13786010742222, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_137-effect1#leftDownVertex#vector'] =
{
	{
		{0.161796, 0, 0, 1, }, 
		{0, 0.666667, }, 
		{{0.10740741093958, -0.37201645462593, }, {0.17615741093958, -0.06831275092222, }, {0.10740741093958, -0.37201645462593, }, {0.17615741093958, -0.06831275092222, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_137-effect1#rightDownVertex#vector'] =
{
	{
		{0.161796, 0, 0, 1, }, 
		{0, 0.666667, }, 
		{{0.43148148059844, -0.48395062199352, }, {0.52106482187917, -0.48765433982593, }, {0.43148148059844, -0.48395062199352, }, {0.52106482187917, -0.48765433982593, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_153-effect0#ae_pre_position#vector'] =
{
	{
		{0.11, 0, 0.14, 1, }, 
		{0.03333333333333, 0.53333333333333, }, 
		{{0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.53333333333333, 1.53333333333333, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.86, 0, 0.89, 1, }, 
		{1.53333333333333, 2.03333333333333, }, 
		{{0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_153-effect0#position#vector'] =
{
	{
		{0.11, 0, 0.14, 1, }, 
		{0, 0.5, }, 
		{{0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.5, 1.5, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.86, 0, 0.89, 1, }, 
		{1.5, 2, }, 
		{{0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_196-effect0#ae_pre_position#vector'] =
{
	{
		{0.11, 0, 0.14, 1, }, 
		{0.03333333333333, 0.53333333333333, }, 
		{{0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.53333333333333, 1.53333333333333, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.86, 0, 0.89, 1, }, 
		{1.53333333333333, 2.03333333333333, }, 
		{{0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_196-effect0#position#vector'] =
{
	{
		{0.11, 0, 0.14, 1, }, 
		{0, 0.5, }, 
		{{0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.5, 1.5, }, 
		{{0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.86, 0, 0.89, 1, }, 
		{1.5, 2, }, 
		{{0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, {0.5, 0.5, }, {0.43020833333333, -0.26574074074074, }, }, 
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
