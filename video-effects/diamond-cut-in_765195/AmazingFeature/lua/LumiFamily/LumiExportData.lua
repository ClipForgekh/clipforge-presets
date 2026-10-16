local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLinearWipe_44-effect0', 'InputTex', 0},
    {'LumiLinearWipe_42-effect0', 'InputTex', 0},
    {'LumiLinearWipe_45-effect0', 'InputTex', 0},
    {'LumiLinearWipe_46-effect0', 'InputTex', 0},
    {'LumiLayer_53-trs-blend', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_44-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_44-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiPageTurn_44-effect2'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_42-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_42-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiPageTurn_42-effect2'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_44-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_45-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_45-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiPageTurn_45-effect2'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_45-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_46-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLinearWipe_46-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiPageTurn_46-effect2'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_46-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiHalftone_49-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_49-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_53-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.83333333333333, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_44-effect0'] = {
        ['progress'] = 0.5,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_44-effect1'] = {
        ['progress'] = 0.5,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiPageTurn_44-effect2'] = {
        ['classic_ui'] = 3,
        ['inFoldPosition'] = Amaz.Vector2f(1.46164982416646, 1.49930842608448),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_42-effect0'] = {
        ['progress'] = 0.5,
        ['rotation'] = -90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_42-effect1'] = {
        ['progress'] = 0.5,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiPageTurn_42-effect2'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(-0.45896094229873, 1.39112510974517),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_44-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_45-effect0'] = {
        ['progress'] = 0.5,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_45-effect1'] = {
        ['progress'] = 0.5,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiPageTurn_45-effect2'] = {
        ['classic_ui'] = 1,
        ['inFoldPosition'] = Amaz.Vector2f(1.51422249700687, -0.39335374426048),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_45-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_46-effect0'] = {
        ['progress'] = 0.5,
        ['rotation'] = -90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_46-effect1'] = {
        ['progress'] = 0.5,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiPageTurn_46-effect2'] = {
        ['classic_ui'] = 2,
        ['inFoldPosition'] = Amaz.Vector2f(-0.48808953329705, -0.50065631826658),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_46-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiHalftone_49-effect0'] = {
        ['colorMode'] = 2,
        ['blackDots'] = true,
        ['dotFreq'] = 240,
        ['rotationAngle'] = -30,
        ['dotsRelativeWidth'] = 1,
        ['dotsSharpen'] = 0.73,
        ['dotsLighten'] = -0.31,
        ['color1'] = Amaz.Color(1, 1, 1, 1),
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
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_49-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 50,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_53-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiPageTurn_44-effect2#inFoldPosition#vector'] =
{
	{
		{0.166667, 0, 0.584647, 0, }, 
		{0.333333, 0.833333, }, 
		{{2.09091746807031, 1.91451871395117, }, {1.64779800176563, 1.63954854011523, }, {2.09091746807031, 1.91451871395117, }, {1.64779800176563, 1.63954854011523, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.343708, 0.568133, 0.666667, 1, }, 
		{0.833333, 1.166667, }, 
		{{1.64779800176563, 1.63954854011523, }, {1.24334096908594, 1.3348391354082, }, {1.64779800176563, 1.63954854011523, }, {1.24334096908594, 1.3348391354082, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.182464, 0.182464, 0.666667, 0.666667, }, 
		{1.166667, 1.333333, }, 
		{{1.24334096908594, 1.3348391354082, }, {1.24334096908594, 1.3348391354082, }, {1.24334096908594, 1.3348391354082, }, {1.24334096908594, 1.3348391354082, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.833333, 1, }, 
		{1.333333, 1.5, }, 
		{{1.24334096908594, 1.3348391354082, }, {1.00312370061914, 0.99963784217773, }, {1.24334096908594, 1.3348391354082, }, {1.00312370061914, 0.99963784217773, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_42-effect2#inFoldPosition#vector'] =
{
	{
		{0.166667, 0, 0.578003, 0.0394, }, 
		{0.333333, 0.8, }, 
		{{-1.10048881173047, 1.8991727530957, }, {-0.71238818764648, 1.54191610217188, }, {-1.10048881173047, 1.8991727530957, }, {-0.71238818764648, 1.54191610217188, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.343708, 0.609645, 0.666667, 1, }, 
		{0.8, 1.133333, }, 
		{{-0.71238818764648, 1.54191610217188, }, {-0.29683762788867, 1.29466059803906, }, {-0.71238818764648, 1.54191610217188, }, {-0.29683762788867, 1.29466059803906, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.833333, 1, }, 
		{1.133333, 1.333333, }, 
		{{-0.29683762788867, 1.29466059803906, }, {0.00541201233789, 0.99506118893555, }, {-0.29683762788867, 1.29466059803906, }, {0.00541201233789, 0.99506118893555, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_45-effect2#inFoldPosition#vector'] =
{
	{
		{0.166667, 0, 0.578003, 0.351843, }, 
		{0.5, 0.833333, }, 
		{{2.05687728524219, -0.93090540170703, }, {1.68351233005469, -0.53392082452734, }, {2.05687728524219, -0.93090540170703, }, {1.68351233005469, -0.53392082452734, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.343708, 0.64728, 0.666667, 1, }, 
		{0.833333, 1.166667, }, 
		{{1.68351233005469, -0.53392082452734, }, {1.34155526757227, -0.24998229741992, }, {1.68351233005469, -0.53392082452734, }, {1.34155526757227, -0.24998229741992, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.666667, 1, }, 
		{1.166667, 1.5, }, 
		{{1.34155526757227, -0.24998229741992, }, {1.33262667059961, -0.2745358645918, }, {1.34155526757227, -0.24998229741992, }, {1.33262667059961, -0.2745358645918, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.833333, 1, }, 
		{1.5, 1.666667, }, 
		{{1.33262667059961, -0.2745358645918, }, {1.00312370061914, -0.00036218762305, }, {1.33262667059961, -0.2745358645918, }, {1.00312370061914, -0.00036218762305, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_46-effect2#inFoldPosition#vector'] =
{
	{
		{0.166667, 0, 0.578003, 0.666669, }, 
		{0.666667, 0.833333, }, 
		{{-0.86611381173047, -1.15942102670703, }, {-0.6200590729707, -0.69017082452734, }, {-0.86611381173047, -1.15942102670703, }, {-0.6200590729707, -0.69017082452734, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.343708, 0.579709, 0.666667, 1, }, 
		{0.833333, 1.166667, }, 
		{{-0.6200590729707, -0.69017082452734, }, {-0.3364580869668, -0.28290638327539, }, {-0.6200590729707, -0.69017082452734, }, {-0.3364580869668, -0.28290638327539, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.666667, 0.666667, }, 
		{1.166667, 1.666667, }, 
		{{-0.3364580869668, -0.28290638327539, }, {-0.3364580869668, -0.28290638327539, }, {-0.3364580869668, -0.28290638327539, }, {-0.3364580869668, -0.28290638327539, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.833333, 1, }, 
		{1.666667, 1.833333, }, 
		{{-0.3364580869668, -0.28290638327539, }, {0.00312370061914, -0.00426846742578, }, {-0.3364580869668, -0.28290638327539, }, {0.00312370061914, -0.00426846742578, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_49-trs-blend#opacity#number'] =
{
	{
		{0.220313292, 0, 0.573759238, 1, }, 
		{0.233333, 0.5, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.291697806, 0, 0.573759238, 0, }, 
		{0.5, 1.566667, }, 
		{{50, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.291697806, 0, 0.66666667, 1, }, 
		{1.566667, 1.833333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_53-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.833333, 1.933333, }, 
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
