local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_41-trs-blend', 'InputTex', 1},
    {'LumiLayer_57-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_41-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_57-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_60-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_61-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_62-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_63-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_59-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_41-trs-blend'] = {
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
    ['LumiLayer_57-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(200, 200, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -15,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(50, 50, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 15,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_60-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(565, 565, 0),
        ['position'] = Amaz.Vector3f(1343.96200912027, 872.551818388401, 0),
        ['scale'] = Amaz.Vector3f(110, 110, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -25.2152656138473,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(50, 50, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 15,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1130, 1130),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_61-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(565, 565, 0),
        ['position'] = Amaz.Vector3f(715.922892839467, -1238.64678509846, 0),
        ['scale'] = Amaz.Vector3f(110, 110, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -11.6226340107367,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(50, 50, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 15,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1130, 1130),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_62-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(565, 565, 0),
        ['position'] = Amaz.Vector3f(-1042.28478923862, -608.325800776471, 0),
        ['scale'] = Amaz.Vector3f(110, 110, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -22.8064230592114,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(50, 50, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 15,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1130, 1130),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_63-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(565, 565, 0),
        ['position'] = Amaz.Vector3f(-514.552690386298, 907.771936899402, 0),
        ['scale'] = Amaz.Vector3f(110, 110, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -19.2190371267955,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(50, 50, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 15,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1130, 1130),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_59-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(565, 565, 0),
        ['position'] = Amaz.Vector3f(-49.5318945646467, -184.855547110406, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -1.32895109862381,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(50, 50, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 15,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1130, 1130),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_57-trs#p0_scale#vector'] =
{
	{
		{0.8,0.8,0.8, 0,0,0.8, 0.45,0.45,0.45, 1,1,0.45, }, 
		{0.966667, 1.966667, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_57-trs#p0_rotation#number'] =
{
	{
		{0.8, 0, 0.45, 1, }, 
		{0.966667, 1.966667, }, 
		{{15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#position#vector'] =
{
	{
		{0.32, 0, 0.09, 1, }, 
		{0.4, 1.9, }, 
		{{2494.368307706, 1774.887812092, 0, }, {758.925718138, 413.671070234, 0, }, {2205.12789022553, 1548.01835103243, 0, }, {1048.16613561847, 640.54053129357, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#rotation#number'] =
{
	{
		{0.32, 0, 0.09, 1, }, 
		{0.4, 1.9, }, 
		{{-63, }, {-6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#p0_scale#vector'] =
{
	{
		{0.8,0.8,0.8, 0,0,0.8, 0.45,0.45,0.45, 1,1,0.45, }, 
		{0.966667, 1.966667, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_60-trs-blend#p0_rotation#number'] =
{
	{
		{0.8, 0, 0.45, 1, }, 
		{0.966667, 1.966667, }, 
		{{15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_61-trs-blend#position#vector'] =
{
	{
		{0.32, 0, 0.09, 1, }, 
		{0.3, 1.8, }, 
		{{1422.547516468, -3021.124718278, 0, }, {492.230607454, -674.377512292, 0, }, {1267.49470579905, -2630.00017604167, 0, }, {647.283418122945, -1065.50205452833, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_61-trs-blend#rotation#number'] =
{
	{
		{0.32, 0, 0.09, 1, }, 
		{0.3, 1.8, }, 
		{{18, }, {-21, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_61-trs-blend#p0_scale#vector'] =
{
	{
		{0.8,0.8,0.8, 0,0,0.8, 0.45,0.45,0.45, 1,1,0.45, }, 
		{0.966667, 1.966667, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_61-trs-blend#p0_rotation#number'] =
{
	{
		{0.8, 0, 0.45, 1, }, 
		{0.966667, 1.966667, }, 
		{{15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_62-trs-blend#position#vector'] =
{
	{
		{0.32, 0, 0.09, 1, }, 
		{0.2, 1.7, }, 
		{{-2709.48738642, -1642.706943685, 0, }, {-700.415365728, -396.220034138, 0, }, {-2374.64204950594, -1434.95912569184, 0, }, {-1035.26070264206, -603.967852131164, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_62-trs-blend#rotation#number'] =
{
	{
		{0.32, 0, 0.09, 1, }, 
		{0.2, 1.7, }, 
		{{-56, }, {-16, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_62-trs-blend#p0_scale#vector'] =
{
	{
		{0.8,0.8,0.8, 0,0,0.8, 0.45,0.45,0.45, 1,1,0.45, }, 
		{0.966667, 1.966667, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_62-trs-blend#p0_rotation#number'] =
{
	{
		{0.8, 0, 0.45, 1, }, 
		{0.966667, 1.966667, }, 
		{{15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_63-trs-blend#position#vector'] =
{
	{
		{0.32, 0, 0.09, 1, }, 
		{0.1, 1.6, }, 
		{{-1689.388617814, 2241.627555594, 0, }, {-357.407135636, 729.355975774, 0, }, {-1467.39170008939, 1989.58229802564, 0, }, {-579.404053360609, 981.401233342359, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_63-trs-blend#rotation#number'] =
{
	{
		{0.32, 0, 0.09, 1, }, 
		{0.1, 1.6, }, 
		{{24, }, {-25, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_63-trs-blend#p0_scale#vector'] =
{
	{
		{0.8,0.8,0.8, 0,0,0.8, 0.45,0.45,0.45, 1,1,0.45, }, 
		{0.966667, 1.966667, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_63-trs-blend#p0_rotation#number'] =
{
	{
		{0.8, 0, 0.45, 1, }, 
		{0.966667, 1.966667, }, 
		{{15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#position#vector'] =
{
	{
		{0.32, 0, 0.14, 1, }, 
		{0, 1.5, }, 
		{{-559.049137421, -2086.399784784, 0, }, {0, 0, 0, }, {-465.874279327738, -1738.66647789923, 0, }, {-93.1748580932617, -347.733306884766, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#rotation#number'] =
{
	{
		{0.32, 0, 0.14, 1, }, 
		{0, 1.5, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#p0_scale#vector'] =
{
	{
		{0.8,0.8,0.8, 0,0,0.8, 0.45,0.45,0.45, 1,1,0.45, }, 
		{0.966667, 1.966667, }, 
		{{50, 50, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#p0_rotation#number'] =
{
	{
		{0.8, 0, 0.45, 1, }, 
		{0.966667, 1.966667, }, 
		{{15, }, {0, }, }, 
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
