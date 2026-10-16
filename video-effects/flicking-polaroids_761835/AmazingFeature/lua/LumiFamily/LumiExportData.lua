local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_30-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_27-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiPageTurn_44-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiPageTurn_43-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_43-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_44-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_30-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(590, 690, 0),
        ['position'] = Amaz.Vector3f(1620, 1620, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(3240, 3240),
        ['layerSize'] = Amaz.Vector2f(1180, 1380),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_27-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(1620, 1530, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(3240, 3240),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiPageTurn_44-effect0'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(0.73030993544, 0.26969006456),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.05,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(3240, 3240),
    },
    ['LumiPageTurn_43-effect0'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(0.79445126977304, 0.20554873022696),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.05,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(3240, 3240),
    },
    ['LumiLayer_43-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(1620, 1620, 0),
        ['position'] = Amaz.Vector3f(877.936422533487, 271.844895802161, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 30,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(535.546610492878, 627.327966295727, 0),
        ['p0_scale'] = Amaz.Vector3f(98.0706302235753, 98.0706302235753, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -0.44523917917493,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(3240, 3240),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_44-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(1620, 1620, 0),
        ['position'] = Amaz.Vector3f(50.0000000000002, 50.0000000000002, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(535.546610492878, 627.327966295727, 0),
        ['p0_scale'] = Amaz.Vector3f(98.0706302235753, 98.0706302235753, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = -0.44523917917493,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(3240, 3240),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiPageTurn_44-effect0#inFoldPosition#vector'] =
{
	{
		{0.38, 0, 0.62, 1, }, 
		{0, 0.666667, }, 
		{{-0.66666666666667, 1.66666666666667, }, {0.33333333333333, 0.66666666666667, }, {-0.5, 1.5, }, {0.33333333333333, 0.66666666666667, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 0.950749, }, 
		{{0.33333333333333, 0.66666666666667, }, {0.16666666666667, 0.83333333333333, }, {0.33333333333333, 0.66666666666667, }, {0.16666666666667, 0.83333333333333, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.950749, 1.234863, }, 
		{{0.16666666666667, 0.83333333333333, }, {0.25925925925926, 0.74074074074074, }, {0.16666666666667, 0.83333333333333, }, {0.25925925925926, 0.74074074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.234863, 1.5, }, 
		{{0.25925925925926, 0.74074074074074, }, {0.16666666666667, 0.83333333333333, }, {0.25925925925926, 0.74074074074074, }, {0.16666666666667, 0.83333333333333, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.57, 0, 0.9, 1, }, 
		{1.5, 1.966667, }, 
		{{0.16666666666667, 0.83333333333333, }, {1, 0, }, {0.16666666666667, 0.83333333333333, }, {0.86111111111111, 0.13888888888889, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_43-effect0#inFoldPosition#vector'] =
{
	{
		{0.05, 0, 0.27, 1, }, 
		{0, 0.6, }, 
		{{-0.66666666666667, 1.66666666666667, }, {0.33333333333333, 0.66666666666667, }, {-0.5, 1.5, }, {0.33333333333333, 0.66666666666667, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.6, 0.866667, }, 
		{{0.33333333333333, 0.66666666666667, }, {0.29012345679012, 0.70987654320988, }, {0.33333333333333, 0.66666666666667, }, {0.29012345679012, 0.70987654320988, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.866667, 1.166667, }, 
		{{0.29012345679012, 0.70987654320988, }, {0.33333333333333, 0.66666666666667, }, {0.29012345679012, 0.70987654320988, }, {0.33333333333333, 0.66666666666667, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.166667, 1.433333, }, 
		{{0.33333333333333, 0.66666666666667, }, {0.25925925925926, 0.74074074074074, }, {0.33333333333333, 0.66666666666667, }, {0.25925925925926, 0.74074074074074, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.57, 0, 0.9, 1, }, 
		{1.433333, 1.966667, }, 
		{{0.25925925925926, 0.74074074074074, }, {1, 0, }, {0.25925925925926, 0.74074074074074, }, {0.87654320987654, 0.12345679012346, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_43-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 0.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_43-trs#p0_position#vector'] =
{
	{
		{1, 0, 0.8, 1, }, 
		{0, 1.966667, }, 
		{{390, 540, 0, }, {540, 630, 0, }, {415, 555, 0, }, {515, 615, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_43-trs#p0_scale#vector'] =
{
	{
		{1,1,1, 0,0,1, 0.8,0.8,0.8, 1,1,0.8, }, 
		{0, 1.966667, }, 
		{{35, 35, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_43-trs#p0_rotation#number'] =
{
	{
		{1, 0, 0.8, 1, }, 
		{0, 1.966667, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0, 1, }, 
		{0, 0.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#p0_position#vector'] =
{
	{
		{1, 0, 0.8, 1, }, 
		{0, 1.966667, }, 
		{{390, 540, 0, }, {540, 630, 0, }, {415, 555, 0, }, {515, 615, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#p0_scale#vector'] =
{
	{
		{1,1,1, 0,0,1, 0.8,0.8,0.8, 1,1,0.8, }, 
		{0, 1.966667, }, 
		{{35, 35, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#p0_rotation#number'] =
{
	{
		{1, 0, 0.8, 1, }, 
		{0, 1.966667, }, 
		{{-15, }, {0, }, }, 
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
