local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_71-effect0'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiLayer_71-trs'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiPageTurn_45-effect0'] = {
        ['nodeDuration'] = {{0, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiTone_85-effect0'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiGaussianBlur_85-effect1'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiLayer_85-trs'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiLayer_45-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.7}, },
            ['baseTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiPageTurn_87-effect0'] = {
        ['nodeDuration'] = {{0, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiLayer_87-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.7}, },
            ['baseTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiPageTurn_86-effect0'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiPageTurn_79-effect0'] = {
        ['nodeDuration'] = {{0, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiLayer_79-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.7}, },
            ['baseTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiLayer_86-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
            ['baseTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiChromaticAberration_83-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.16666666666667}, },
        },
    },
    ['LumiLayer_83-blend'] = {
        ['nodeDuration'] = {{0, 2.16666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.16666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_71-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_71-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
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
    ['LumiPageTurn_45-effect0'] = {
        ['classic_ui'] = 3,
        ['inFoldPosition'] = Amaz.Vector2f(1.51870752175649, 2.29153439557111),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiTone_85-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.34509804844856, 0.34509804844856, 0.34509804844856, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiGaussianBlur_85-effect1'] = {
        ['blurIntensity'] = 50,
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
    ['LumiLayer_85-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_45-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(2604, 50, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(-1590.30254226809, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiPageTurn_87-effect0'] = {
        ['classic_ui'] = 1,
        ['inFoldPosition'] = Amaz.Vector2f(1.31190475622813, -1.18178383156105),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_87-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(1343, 50, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(-1590.30254226809, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiPageTurn_86-effect0'] = {
        ['classic_ui'] = 1,
        ['inFoldPosition'] = Amaz.Vector2f(1.43125, -1.18518518518519),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiPageTurn_79-effect0'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(-0.16330782572428, 2.27845805132831),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_79-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1243, 50, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(-1590.30254226809, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_86-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1243, 50, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(-1590.30254226809, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiChromaticAberration_83-effect0'] = {
        ['offsetX'] = 0,
        ['offsetY'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_83-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_71-effect0#radius#number'] =
{
	{
		{0.79, 0, 0.21, 1, }, 
		{0, 0.433333, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.79, 0, 0.21, 0, }, 
		{0.433333, 1.5, }, 
		{{50, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.524393363, 0, 0.21, 1, }, 
		{1.5, 1.933333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_71-trs#scale#vector'] =
{
	{
		{0.79,0.79,0.79, 0,0,0.79, 0.21,0.21,0.21, 1,1,0.21, }, 
		{0, 0.5, }, 
		{{100, 100, 100, }, {60, 60, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.79,0.79,0.79, 0.79,0.79,0.79, 0.21,0.21,0.21, 0.21,0.21,0.21, }, 
		{0.5, 1.5, }, 
		{{60, 60, 100, }, {60, 60, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.79,0.79,0.79, 0,0,0.79, 0.21,0.21,0.21, 1,1,0.21, }, 
		{1.5, 1.933333, }, 
		{{60, 60, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_45-effect0#inFoldPosition#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.966667, 1.7, }, 
		{{-0.31800811290729, -1.01505987379259, }, {1.51870752175625, 2.2915343955713, }, {-0.31800811290729, -1.01505987379259, }, {1.51870752175625, 2.2915343955713, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_85-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.233333, 1.7, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_45-trs-blend#p0_position#vector'] =
{
	{
		{0.55, 0, 0.45, 1, }, 
		{0.166667, 1.666667, }, 
		{{2253, 540, 0, }, {-1590.302542268, 540, 0, }, {2253, 540, 0, }, {-1590.302542268, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_87-effect0#inFoldPosition#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.7, 1.433333, }, 
		{{0.0088435570401, 1.61776265744815, }, {1.31190475622812, -1.18178383156111, }, {0.0088435570401, 1.61776265744815, }, {1.31190475622812, -1.18178383156111, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_87-trs-blend#p0_position#vector'] =
{
	{
		{0.55, 0, 0.45, 1, }, 
		{0.166667, 1.666667, }, 
		{{2253, 540, 0, }, {-1590.302542268, 540, 0, }, {2253, 540, 0, }, {-1590.302542268, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_86-effect0#inFoldPosition#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.166667, 0.8, }, 
		{{-0.02708332538594, 1.24444444444444, }, {1.43125, -1.18518518518519, }, {-0.02708332538594, 1.24444444444444, }, {1.43125, -1.18518518518519, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiPageTurn_79-effect0#inFoldPosition#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.5, 1.133333, }, 
		{{0.97427721818281, -0.264852608575, }, {-0.16330782572448, 2.2784580513287, }, {0.97427721818281, -0.264852608575, }, {-0.16330782572448, 2.2784580513287, }, }, 
		{6415, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_79-trs-blend#position#vector'] =
{
	{
		{0.79, 0, 0.21, 1, }, 
		{1.5, 1.966667, }, 
		{{50, 50, 0, }, {-1243, 50, 0, }, {50, 50, 0, }, {-1243, 50, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_79-trs-blend#p0_position#vector'] =
{
	{
		{0.55, 0, 0.45, 1, }, 
		{0.166667, 1.666667, }, 
		{{2253, 540, 0, }, {-1590.302542268, 540, 0, }, {2253, 540, 0, }, {-1590.302542268, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_86-trs-blend#p0_position#vector'] =
{
	{
		{0.55, 0, 0.45, 1, }, 
		{0.166667, 1.666667, }, 
		{{2253, 540, 0, }, {-1590.302542268, 540, 0, }, {2253, 540, 0, }, {-1590.302542268, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiChromaticAberration_83-effect0#offsetX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.233333, }, 
		{{0, }, {0.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.233333, 1.666667, }, 
		{{0.1, }, {0.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.666667, 1.9, }, 
		{{0.1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_83-effect0#offsetY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.233333, }, 
		{{0, }, {0.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.233333, 1.666667, }, 
		{{0.1, }, {0.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.666667, 1.9, }, 
		{{0.1, }, {0, }, }, 
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
