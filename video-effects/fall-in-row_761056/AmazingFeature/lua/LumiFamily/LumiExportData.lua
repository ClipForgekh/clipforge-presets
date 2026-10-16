local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_41-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_58-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_59-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_57-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
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
    ['LumiLayer_58-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(590, 690, 0),
        ['position'] = Amaz.Vector3f(1295.70169528867, -2195.91668928638, 10.7048265839131),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 4),
        ['xRotation'] = 0,
        ['yRotation'] = 15,
        ['rotation'] = 4,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 36.4732271676358,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(527.652827660163, 525.183393192196, 2000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -4,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 36.4732271676358,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1180, 1380),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_59-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(590, 690, 0),
        ['position'] = Amaz.Vector3f(-650.472487717553, -2505.08655312316, -2.27373675443232e-13),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 4),
        ['xRotation'] = 0,
        ['yRotation'] = -15,
        ['rotation'] = -4,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 36.4732271676358,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(527.652827660163, 525.183393192196, 2000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -4,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 36.4732271676358,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1180, 1380),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_57-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(590, 690, 0),
        ['position'] = Amaz.Vector3f(188.402144435628, -1929.24287678715, -2.27373675443232e-13),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 4),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -4,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 36.4732271676358,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(527.652827660163, 525.183393192196, 2000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -4,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 36.4732271676358,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1180, 1380),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_58-trs#position#vector'] =
{
	{
		{0.16, 0, 0.42, 1, }, 
		{0.1, 1.266667, }, 
		{{1307.745742942, -2368.154595163, 0, }, {1133.354558582, 125.755530486, 155, }, {1278.68054595103, -1952.50292279972, 25.8333339691162, }, {1162.41975557297, -289.896141877281, 129.166666030884, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs#p0_position#vector'] =
{
	{
		{0.63, 0, 0.78, 1, }, 
		{0.666667, 1.9, }, 
		{{527.65282766, 525.183393192, 2000, }, {540, 630, 0, }, {529.710689703381, 542.652827930159, 1666.66665649414, }, {537.942137956619, 612.530565261841, 333.333343505859, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_58-trs#p0_rotation#number'] =
{
	{
		{0.63, 0, 0.78, 1, }, 
		{0.666667, 1.9, }, 
		{{-4, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#position#vector'] =
{
	{
		{0.16, 0, 0.42, 1, }, 
		{0.2, 1.366667, }, 
		{{-650.472487718, -2505.086553123, 0, }, {-824.863672078, -11.176427474, 216, }, {-679.537684708967, -2089.43488075972, 36, }, {-795.798475087033, -426.828099837281, 180, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#p0_position#vector'] =
{
	{
		{0.63, 0, 0.78, 1, }, 
		{0.666667, 1.9, }, 
		{{527.65282766, 525.183393192, 2000, }, {540, 630, 0, }, {529.710689703381, 542.652827930159, 1666.66665649414, }, {537.942137956619, 612.530565261841, 333.333343505859, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_59-trs-blend#p0_rotation#number'] =
{
	{
		{0.63, 0, 0.78, 1, }, 
		{0.666667, 1.9, }, 
		{{-4, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_57-trs-blend#position#vector'] =
{
	{
		{0.16, 0, 0.42, 1, }, 
		{0, 1.166667, }, 
		{{224.39118436, -2443.91012565, 0, }, {50, 50, 0, }, {195.325987369033, -2028.25845328672, 0, }, {79.0651969909668, -365.651672363281, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_57-trs-blend#p0_position#vector'] =
{
	{
		{0.63, 0, 0.78, 1, }, 
		{0.666667, 1.9, }, 
		{{527.65282766, 525.183393192, 2000, }, {540, 630, 0, }, {529.710689703381, 542.652827930159, 1666.66665649414, }, {537.942137956619, 612.530565261841, 333.333343505859, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_57-trs-blend#p0_rotation#number'] =
{
	{
		{0.63, 0, 0.78, 1, }, 
		{0.666667, 1.9, }, 
		{{-4, }, {0, }, }, 
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
