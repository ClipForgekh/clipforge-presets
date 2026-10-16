local data = {}

local ae_compDurations = {0, 1.13333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiExposure_32-effect2'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiBokehBlur_32-effect3'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_32-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(1729, 540, 0),
        ['scale'] = Amaz.Vector3f(60, 60, 60),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 180,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiExposure_32-effect2'] = {
        ['channelType'] = 0,
        ['exposure'] = 1,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiBokehBlur_32-effect3'] = {
        ['bokehMode'] = 0,
        ['sample'] = 5,
        ['scaleX'] = 1,
        ['scaleY'] = 1,
        ['regionIns'] = 0.5,
        ['lightIns'] = 4,
        ['darkIns'] = 2,
        ['quality'] = 0.2,
        ['angle'] = 0,
        ['lineNum'] = 5,
        ['starShapeIns'] = 0.60000002384186,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_32-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_27-trs#position#vector'] =
{
	{
		{0.363124, 0, 0.695501, 1, }, 
		{0.033333, 0.086654, }, 
		{{540, 540, 0, }, {559.573809015, 528.505966369, -24.513229774, }, {544.63499879837, 536.369060277939, -21.4766387939453, }, {557.212439405167, 551.59855860838, -38.6410106883066, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.436887, 0, 0.758903, 1, }, 
		{0.086654, 0.12666, }, 
		{{559.573809015, 528.505966369, -24.513229774, }, {550.920285653, 550.662404248, 16.080965606, }, {561.935178624833, 505.41337412962, -10.3854488596934, }, {575.171056221848, 544.68916911769, 31.4096504128237, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.831657, 0, 0.70047, 1, }, 
		{0.12666, 0.166667, }, 
		{{550.920285653, 550.662404248, 16.080965606, }, {540, 540, 0, }, {526.669515084152, 556.63563937831, 0.75228079917627, }, {556.549425125122, 558.133335113525, 16.2045650482178, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{1, 0, 0.833333, 1, }, 
		{0.166667, 0.4, }, 
		{{540, 540, 0, }, {540, 540, 0, }, {523.450574874878, 521.866664886475, -16.2045650482178, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.549069, 0, 0.272822, 1, }, 
		{0.4, 1.066667, }, 
		{{540, 540, 0, }, {1729, 540, 0, }, {738.16667175293, 540, 0, }, {1530.83332824707, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0,0,0, 1.00000007,1.00000007,1.00000007, }, 
		{0.033333, 0.3, }, 
		{{100, 100, 100, }, {60, 60, 60, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#xRotation#number'] =
{
	{
		{0.700742231, -8.1e-8, 0.306031281, 1.000000223, }, 
		{0.033333, 1.066667, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiExposure_32-effect2#exposure#number'] =
{
	{
		{0.33333333, 0, 0, 1.000000118, }, 
		{0.033333, 0.133333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{1, 1.48e-7, 0.66666667, 1, }, 
		{0.133333, 0.266667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{0.266667, 0.5, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.633333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBokehBlur_32-effect3#sample#number'] =
{
	{
		{0.33333333, 0, 0, 1.000000189, }, 
		{0.033333, 0.133333, }, 
		{{0, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{1, 7e-8, 0.66666667, 1, }, 
		{0.133333, 0.266667, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{0.266667, 0.5, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.633333, }, 
		{{0, }, {5, }, }, 
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
