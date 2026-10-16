local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_113-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_130-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_129-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_132-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_128-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiCircleWipe_134-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_134-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_113-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(590, 600, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1180, 1380),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_130-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(590, 690, 0),
        ['position'] = Amaz.Vector3f(540, 1474.97992483248, 0),
        ['scale'] = Amaz.Vector3f(70, 70, 70),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 25,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1180, 1380),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_129-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(590, 690, 0),
        ['position'] = Amaz.Vector3f(50, 1166.92317967592, -520.829832253712),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(335, 0, 0),
        ['xRotation'] = 25,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(540, 836, 0),
        ['p0_scale'] = Amaz.Vector3f(70, 70, 70),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 25,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1180, 1380),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_132-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(590, 690, 0),
        ['position'] = Amaz.Vector3f(50, 1168.64275428524, -521.631683062806),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(335, 0, 0),
        ['xRotation'] = 25,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(540, 1076, 0),
        ['p0_scale'] = Amaz.Vector3f(70, 70, 70),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 25,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1180, 1380),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_128-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(590, 690, 0),
        ['position'] = Amaz.Vector3f(50, 1168.64275428524, -521.631683062806),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(335, 0, 0),
        ['xRotation'] = 25,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(540, 1276, 0),
        ['p0_scale'] = Amaz.Vector3f(70, 70, 70),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 25,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1180, 1380),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiCircleWipe_134-effect0'] = {
        ['radiusMode'] = 0,
        ['progress'] = 0.5,
        ['radius'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['feather'] = 0,
        ['reverse'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_134-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(1303.77068796908, 865.623143481446, 0),
        ['scale'] = Amaz.Vector3f(20, 20, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_130-trs#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0, 0.833333, }, 
		{{540, 1500, 0, }, {540, 636, 0, }, {540, 1356, 0, }, {540, 780, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.833333, 1, }, 
		{{540, 636, 0, }, {540, 636, 0, }, {540, 636, 0, }, {540, 636, 0, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.6, 0, 0.4, 1, }, 
		{1, 1.6, }, 
		{{540, 636, 0, }, {540, 630, 0, }, {540, 635, 0, }, {540, 631, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_130-trs#scale#vector'] =
{
	{
		{0.6,0.6,0.6, 0,0,0, 0.4,0.4,0.4, 1,1,1, }, 
		{1.333333, 1.866667, }, 
		{{70, 70, 70, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_130-trs#xRotation#number'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1, 1.6, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_129-trs-blend#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.1, 0.933333, }, 
		{{50, 1168.642754285, -521.631683063, }, {50, 50, 0, }, {50, 982.202294079922, -434.693069171398, }, {50, 236.440460205078, -86.9386138916016, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_129-trs-blend#p0_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.133333, 1.733333, }, 
		{{540, 836, 0, }, {540, 1916, 0, }, {540, 1016, 0, }, {540, 1736, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_132-trs-blend#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.2, 1.033333, }, 
		{{50, 1168.642754285, -521.631683063, }, {50, 50, 0, }, {50, 982.202294079922, -434.693069171398, }, {50, 236.440460205078, -86.9386138916016, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_132-trs-blend#p0_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{1.033333, 1.666667, }, 
		{{540, 1076, 0, }, {540, 2156, 0, }, {540, 1256, 0, }, {540, 1976, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_128-trs-blend#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.3, 1.133333, }, 
		{{50, 1168.642754285, -521.631683063, }, {50, 50, 0, }, {50, 982.202294079922, -434.693069171398, }, {50, 236.440460205078, -86.9386138916016, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_128-trs-blend#p0_position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0.933333, 1.6, }, 
		{{540, 1276, 0, }, {540, 2356, 0, }, {540, 1456, 0, }, {540, 2176, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_134-trs-blend#position#vector'] =
{
	{
		{0.6, 0, 0.4, 1, }, 
		{0, 1.1, }, 
		{{1316, 875, 0, }, {540, 280, 0, }, {1186.66667175293, 775.833335876465, 0, }, {669.33332824707, 379.166664123535, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_134-trs-blend#scale#vector'] =
{
	{
		{0.6,0.6,0.6, 0,0,0.6, 0.4,0.4,0.4, 1,1,0.4, }, 
		{0.933333, 1.1, }, 
		{{20, 20, 100, }, {10, 10, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.6,0.6,0.6, 0,0,0.6, 0.4,0.4,0.4, 1,1,0.4, }, 
		{1.1, 1.266667, }, 
		{{10, 10, 100, }, {20, 20, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_134-trs-blend#opacity#number'] =
{
	{
		{0.45, 0, 0.55, 1, }, 
		{1.1, 1.666667, }, 
		{{100, }, {0, }, }, 
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
