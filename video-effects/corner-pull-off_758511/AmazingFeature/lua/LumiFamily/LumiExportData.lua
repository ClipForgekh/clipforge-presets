local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_120-trs'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_121-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_135-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_73-trs'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
        },
    },
    ['LumiLayer_74-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{0, 1.9}, },
        },
    },
    ['LumiPageTurn_85-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['frontTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_107-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 1.9}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_120-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(64, 66, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_121-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(54.9999999999999, 55, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_135-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(54.9999999999999, 55, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 60,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_73-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 558, 0),
        ['scale'] = Amaz.Vector3f(64, 66, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_74-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(54.9999999999999, 55, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiPageTurn_85-effect0'] = {
        ['classic_ui'] = 1,
        ['inFoldPosition'] = Amaz.Vector2f(1.83518518518519, -0.82962962962963),
        ['inFoldDirection'] = -60,
        ['foldRadius'] = 0,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_107-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(1212, 1172, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_120-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.333333, }, 
		{{100, 100, 100, }, {64, 66, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_121-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.333333, }, 
		{{100, 100, 100, }, {55, 55, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_135-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.333333, }, 
		{{100, 100, 100, }, {55, 55, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_73-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.333333, }, 
		{{100, 100, 100, }, {64, 66, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_74-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0, 0.333333, }, 
		{{100, 100, 100, }, {55, 55, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_85-effect0#inFoldPosition#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.333333, }, 
		{{-0.02407407407407, 1.08888888888889, }, {0.18148148148148, 0.8037037037037, }, {-0.02407407407407, 1.08888888888889, }, {0.18148148148148, 0.8037037037037, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.333333, 1.333333, }, 
		{{0.18148148148148, 0.8037037037037, }, {1.83518518518519, -0.82962962962963, }, {0.18148148148148, 0.8037037037037, }, {1.83518518518519, -0.82962962962963, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_85-effect0#foldRadius#number'] =
{
	{
		{0.33333333, 0, 0.388235456, 0.99999998, }, 
		{0.333333, 0.666667, }, 
		{{0.5, }, {0.05, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.800000006, 6.11e-7, 0.66666667, 1, }, 
		{0.666667, 1.333333, }, 
		{{0.05, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_107-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.333333, }, 
		{{1212, 1172, 0, }, {280, 288, 0, }, {1212, 1172, 0, }, {280, 288, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.683473, 0, 0.535014, 1, }, 
		{0.333333, 1.033333, }, 
		{{280, 288, 0, }, {1212, 1172, 0, }, {280, 288, 0, }, {1212, 1172, 0, }, }, 
		{6413, }, 
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
