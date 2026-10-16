local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_46-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBoxBlur_57-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_46-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(0, 0, 0),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -90,
        ['yRotation'] = 90,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiBoxBlur_57-effect0'] = {
        ['blurIntensity'] = 10,
        ['iteration'] = 3,
        ['steps'] = 1,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_46-trs#scale#vector'] =
{
	{
		{1,1,1, 1.08e-7,1.08e-7,1.08e-7, 0.833333333,0.833333333,0.833333333, 0.875,0.875,0.875, }, 
		{0, 0.5, }, 
		{{0, 0, 0, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.5, 0.666667, }, 
		{{100, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.666667, 0.833333, }, 
		{{100, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.66666667,0.66666667,0.66666667, 0.66666667,0.66666667,0.66666667, }, 
		{0.833333, 1, }, 
		{{100, 100, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_46-trs#xRotation#number'] =
{
	{
		{1, 1.08e-7, 0.833333333, 0.90625, }, 
		{0, 0.5, }, 
		{{-90, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.125, 0.833333333, 0.983333333, }, 
		{0.5, 0.666667, }, 
		{{10, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.020833333, 0.833333333, 0.9375, }, 
		{0.666667, 0.833333, }, 
		{{-15, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.25, 0.66666667, 1, }, 
		{0.833333, 1, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_46-trs#yRotation#number'] =
{
	{
		{1, -1.11e-7, 0.833333333, 0.884020619, }, 
		{0, 0.5, }, 
		{{90, }, {-7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, -0.535714286, 0.833333333, 0.916666667, }, 
		{0.5, 0.666667, }, 
		{{-7, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.583333333, 0.833333333, 0, }, 
		{0.666667, 0.833333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.66666667, 0, }, 
		{0.833333, 1, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBoxBlur_57-effect0#blurIntensity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.366667, 0.533333, }, 
		{{10, }, {0, }, }, 
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
