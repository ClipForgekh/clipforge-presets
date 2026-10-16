local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiVector_101-effect0'] = {
        ['nodeDuration'] = {{0, 1.96666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.96666666666667}, },
        },
    },
    ['LumiVector_104-effect0'] = {
        ['nodeDuration'] = {{0, 1.96666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.96666666666667}, },
        },
    },
    ['LumiLayer_104-blend'] = {
        ['nodeDuration'] = {{0, 1.96666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.96666666666667}, },
            ['baseTex'] = {{0, 1.96666666666667}, },
        },
    },
    ['LumiLayer_103-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 1.96666666666667}, },
            ['maskTex'] = {{0, 1.96666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiVector_101-effect0'] = {
        ['opacity'] = 1,
        ['scale'] = 1,
        ['radius'] = 0,
        ['maskWidth'] = 100,
        ['maskHeight'] = 100,
        ['isPercentagePos'] = true,
        ['maskPosition'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation'] = 0,
        ['rotationPoint'] = Amaz.Vector2f(0.5, 0.5),
        ['maskType'] = 0,
        ['rotateOnLandscape'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiVector_104-effect0'] = {
        ['opacity'] = 1,
        ['scale'] = 1,
        ['radius'] = 0,
        ['maskWidth'] = 105,
        ['maskHeight'] = 105,
        ['isPercentagePos'] = true,
        ['maskPosition'] = Amaz.Vector2f(0.5, 0.5),
        ['rotation'] = 0,
        ['rotationPoint'] = Amaz.Vector2f(0.5, 0.5),
        ['maskType'] = 0,
        ['rotateOnLandscape'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_104-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
    ['LumiLayer_103-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(256, 256, 0),
        ['position'] = Amaz.Vector3f(256, 256, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(512, 512),
        ['layerSize'] = Amaz.Vector2f(512, 512),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiVector_101-effect0#scale#number'] =
{
	{
		{0.3, 0, 0.1, 1, }, 
		{0.166667, 0.583333, }, 
		{{0.01, }, {0.95, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.3, 0, 0.05, 0, }, 
		{0.583333, 1, }, 
		{{0.95, }, {0.95, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.05, 1, }, 
		{1, 1.833333, }, 
		{{0.95, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiVector_101-effect0#maskPosition#vector'] =
{
	{
		{0.3, 0, 0.1, 1, }, 
		{0.166667, 0.583333, }, 
		{{0.5703125, -0.0859375, }, {0.5703125, 0.025390625, }, {0.5703125, -0.0859375, }, {0.5703125, 0.025390625, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.3, 0.3, 0.05, 0.05, }, 
		{0.583333, 1, }, 
		{{0.5703125, 0.025390625, }, {0.5703125, 0.025390625, }, {0.5703125, 0.025390625, }, {0.5703125, 0.025390625, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.05, 1, }, 
		{1, 1.833333, }, 
		{{0.5703125, 0.025390625, }, {0.5, 0.5, }, {0.5703125, 0.025390625, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiVector_101-effect0#rotation#number'] =
{
	{
		{0.3, 0, 0.05, 0, }, 
		{0.583333, 1, }, 
		{{-15, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.05, 1, }, 
		{1, 1.833333, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiVector_104-effect0#scale#number'] =
{
	{
		{0.3, 0, 0.1, 1, }, 
		{0.166667, 0.583333, }, 
		{{0.01, }, {0.95, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.3, 0, 0.05, 0, }, 
		{0.583333, 1, }, 
		{{0.95, }, {0.95, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.05, 1, }, 
		{1, 1.833333, }, 
		{{0.95, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiVector_104-effect0#maskPosition#vector'] =
{
	{
		{0.3, 0, 0.1, 1, }, 
		{0.166667, 0.583333, }, 
		{{0.5703125, -0.0859375, }, {0.5703125, 0.025390625, }, {0.5703125, -0.0859375, }, {0.5703125, 0.025390625, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.3, 0.3, 0.05, 0.05, }, 
		{0.583333, 1, }, 
		{{0.5703125, 0.025390625, }, {0.5703125, 0.025390625, }, {0.5703125, 0.025390625, }, {0.5703125, 0.025390625, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.05, 1, }, 
		{1, 1.833333, }, 
		{{0.5703125, 0.025390625, }, {0.5, 0.5, }, {0.5703125, 0.025390625, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiVector_104-effect0#rotation#number'] =
{
	{
		{0.3, 0, 0.05, 0, }, 
		{0.583333, 1, }, 
		{{-15, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.05, 1, }, 
		{1, 1.833333, }, 
		{{-15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_103-trs-matte-blend#position#vector'] =
{
	{
		{0.3, 0.3, 0.05, 0.05, }, 
		{0.583333, 1, }, 
		{{292, 499, 0, }, {292, 499, 0, }, {292, 499, 0, }, {292, 499, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.05, 1, }, 
		{1, 1.833333, }, 
		{{292, 499, 0, }, {256, 256, 0, }, {292, 499, 0, }, {256, 256, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_103-trs-matte-blend#scale#vector'] =
{
	{
		{0.3,0.3,0.3, 0,0,0.3, 0.1,0.1,0.1, 1,1,0.1, }, 
		{0.166667, 0.583333, }, 
		{{0, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.3,0.3,0.3, 0.3,0.3,0.3, 0.05,0.05,0.05, 0.05,0.05,0.05, }, 
		{0.583333, 1, }, 
		{{100, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_103-trs-matte-blend#rotation#number'] =
{
	{
		{0.3, 0, 0.05, 0, }, 
		{0.583333, 1, }, 
		{{15, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.5, 0, 0.05, 1, }, 
		{1, 1.833333, }, 
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
