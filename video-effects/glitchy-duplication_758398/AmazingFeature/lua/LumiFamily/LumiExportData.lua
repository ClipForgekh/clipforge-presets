local data = {}

local ae_compDurations = {0, 1.86666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_53-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiDirectionalBlurs_28-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_27-effect0'] = {
        ['nodeDuration'] = {{0.83333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0.83333333333333, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.83333333333333, 2}, },
        },
    },
    ['LumiLayer_28-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0.83333333333333, 2}, },
        },
    },
    ['LumiWaveWarp_58-effect0'] = {
        ['nodeDuration'] = {{0.7, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_58-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.7, 1.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiWaveWarp_59-effect0'] = {
        ['nodeDuration'] = {{0.7, 1.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_59-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.7, 1.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_37-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 0.8}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_38-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.86666666666667, 0.9}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_53-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(565, 565, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1130, 1130),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiDirectionalBlurs_28-effect0'] = {
        ['blurIntensity'] = 0,
        ['angle'] = 0,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1130, 1130),
    },
    ['LumiRadialBlur_27-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1130, 1130),
    },
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(565, 565, 0),
        ['position'] = Amaz.Vector3f(-1180, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 180,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(0, 0, 0),
        ['p0_scale'] = Amaz.Vector3f(50, 50, 50),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(327.565642341459, 540, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 69.5238317784777,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1130, 1130),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_28-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(565, 565, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(0, 0, 0),
        ['p0_scale'] = Amaz.Vector3f(50, 50, 50),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['p1_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p1_position'] = Amaz.Vector3f(327.565642341459, 540, 0),
        ['p1_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p1_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p1_xRotation'] = 0,
        ['p1_yRotation'] = 69.5238317784777,
        ['p1_rotation'] = 0,
        ['p1_opacity'] = 100,
        ['p1_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1130, 1130),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiWaveWarp_58-effect0'] = {
        ['type'] = 1,
        ['amplitude'] = 4.51408382273073,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 0,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_58-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiWaveWarp_59-effect0'] = {
        ['type'] = 8,
        ['amplitude'] = 1.04983523028295,
        ['wavelength'] = 40,
        ['direction'] = 0,
        ['speed'] = 0,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_59-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_37-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 21,
    },
    ['LumiLayer_38-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 21,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiDirectionalBlurs_28-effect0#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.266667, }, 
		{{0, }, {140, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 0.466667, }, 
		{{140, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRadialBlur_27-effect0#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.166667, 1.533333, }, 
		{{0, }, {25, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.533333, 1.766667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_27-trs#p0_position#vector'] =
{
	{
		{0.59, 0, 0.42, 1, }, 
		{0, 0.466667, }, 
		{{0, -865, 0, }, {0, 0, 0, }, {0, -720.83332824707, 0, }, {0, -144.16667175293, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.466667, 1.166667, }, 
		{{0, 0, 0, }, {0, 0, 0, }, {0, 0, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.57, 0, 0.58, 1, }, 
		{1.166667, 1.8, }, 
		{{0, 0, 0, }, {630, 0, 0, }, {105, 0, 0, }, {525, 0, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#p0_scale#vector'] =
{
	{
		{0.57,0.57,0.57, 0,0,0, 0.58,0.58,0.58, 1,1,1, }, 
		{1.166667, 1.8, }, 
		{{50, 50, 50, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#p1_position#vector'] =
{
	{
		{0.61, 0, 0.39, 1, }, 
		{0.3, 1.4, }, 
		{{540, 540, 0, }, {-10, 540, 0, }, {448.333335876465, 540, 0, }, {81.6666641235352, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#p1_yRotation#number'] =
{
	{
		{0.61, 0, 0.39, 1, }, 
		{0.3, 1.4, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#p0_position#vector'] =
{
	{
		{0.59, 0, 0.42, 1, }, 
		{0, 0.466667, }, 
		{{0, -865, 0, }, {0, 0, 0, }, {0, -720.83332824707, 0, }, {0, -144.16667175293, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.466667, 1.166667, }, 
		{{0, 0, 0, }, {0, 0, 0, }, {0, 0, 0, }, {0, 0, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.57, 0, 0.58, 1, }, 
		{1.166667, 1.8, }, 
		{{0, 0, 0, }, {630, 0, 0, }, {105, 0, 0, }, {525, 0, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#p0_scale#vector'] =
{
	{
		{0.57,0.57,0.57, 0,0,0, 0.58,0.58,0.58, 1,1,1, }, 
		{1.166667, 1.8, }, 
		{{50, 50, 50, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#p1_position#vector'] =
{
	{
		{0.61, 0, 0.39, 1, }, 
		{0.3, 1.4, }, 
		{{540, 540, 0, }, {-10, 540, 0, }, {448.333335876465, 540, 0, }, {81.6666641235352, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#p1_yRotation#number'] =
{
	{
		{0.61, 0, 0.39, 1, }, 
		{0.3, 1.4, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWaveWarp_58-effect0#amplitude#number'] =
{
	{
		{0.598961429, 0, 0.743452592, 1, }, 
		{0.7, 0.866667, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.392650829, 0, 0.436536713, 1, }, 
		{0.866667, 1, }, 
		{{10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWaveWarp_59-effect0#amplitude#number'] =
{
	{
		{0.635535469, 0, 0.599344201, 1, }, 
		{0.7, 0.866667, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.665378736, 0, 0.436536713, 1, }, 
		{0.866667, 1, }, 
		{{2, }, {0, }, }, 
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
