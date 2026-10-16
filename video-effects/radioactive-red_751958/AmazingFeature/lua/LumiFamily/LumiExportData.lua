local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_25-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiFindEdge_38-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiTritone_38-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur2D_38-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBCCGlowOBS_38-effect3'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_38-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_25-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
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
    },
    ['LumiFindEdge_38-effect0'] = {
        ['brightness'] = 5,
        ['grayColor'] = false,
        ['upperLimit'] = 1,
        ['lowerLimit'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiTritone_38-effect1'] = {
        ['highlightColor'] = Amaz.Color(1, 0, 0, 1),
        ['middleColor'] = Amaz.Color(1, 0, 0, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur2D_38-effect2'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1.47550686266844,
        ['ae_pre_scale_x'] = 1.47550686266844,
        ['scale_y'] = 1.47550686266844,
        ['ae_pre_scale_y'] = 1.47550686266844,
        ['vIntensity'] = 1,
        ['vCenter'] = -1,
        ['minSamples'] = 0.2,
        ['maxSamples'] = 1,
        ['mirrorEdge'] = true,
        ['dither'] = 0.5,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiBCCGlowOBS_38-effect3'] = {
        ['show'] = 2,
        ['glowChannels'] = 0,
        ['glowThreshold'] = 0.1,
        ['glowRadius'] = 50,
        ['glowAspectRatio'] = 0.95,
        ['glowIntensity'] = 1,
        ['combine'] = 1,
        ['colorA'] = Amaz.Color(1, 0, 0, 1),
        ['colorB'] = Amaz.Color(1, 0, 0, 1),
        ['quality'] = 0.5,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_38-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
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
    ['LumiLayer_25-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.833333, 1, }, 
		{0.366667, 0.433333, }, 
		{{540, 540, 0, }, {552, 538, 0, }, {542, 539.666666656733, 0, }, {554.66666674614, 539, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.433333, 0.5, }, 
		{{552, 538, 0, }, {524, 534, 0, }, {549.33333325386, 537, 0, }, {522.33333337307, 533, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.73232, 0, }, 
		{0.5, 0.566667, }, 
		{{524, 534, 0, }, {542.741809546, 545.293839571, 0, }, {524.88400810957, 534.530404865742, 0, }, {529.677624403483, 542.155432340623, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.309447, 1, 0.666667, 1, }, 
		{0.566667, 0.633333, }, 
		{{542.741809546, 545.293839571, 0, }, {536, 526, 0, }, {554.308215796, 548.072435495377, 0, }, {532.086707115173, 526.469595134258, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.633333, 0.7, }, 
		{{536, 526, 0, }, {534, 538, 0, }, {544.333333015442, 525, 0, }, {533.333333313465, 535.66666674614, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.7, 0.766667, }, 
		{{534, 538, 0, }, {540, 540, 0, }, {534.666666686535, 540.33333325386, 0, }, {539, 539.666666656733, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.333333, 0.833333, 0.833333, }, 
		{0.766667, 1.566667, }, 
		{{540, 540, 0, }, {540, 540, 0, }, {540, 540, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.833333, 1, }, 
		{1.566667, 1.633333, }, 
		{{540, 540, 0, }, {546, 554, 0, }, {541, 542.33333325386, 0, }, {544, 554, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.833333, 1, }, 
		{1.633333, 1.7, }, 
		{{546, 554, 0, }, {552, 540, 0, }, {548, 554, 0, }, {554, 542, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.7, 1.766667, }, 
		{{552, 540, 0, }, {534, 542, 0, }, {550, 538, 0, }, {536, 543, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.766667, 1.833333, }, 
		{{534, 542, 0, }, {540, 534, 0, }, {532, 541, 0, }, {542.66666674614, 531.66666674614, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.833333, 1.9, }, 
		{{540, 534, 0, }, {540, 540, 0, }, {538.04154753685, 535.713645935059, 0, }, {540, 539, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_38-effect2#ae_pre_scale_x#number'] =
{
	{
		{0.616694272, -0.513041063, 0.797771604, -1.241879663, }, 
		{0.06666633333333, 0.60000033333333, }, 
		{{1.8, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.50357916, 0, 0.833333333, 1, }, 
		{0.60000033333333, 1.60000033333333, }, 
		{{1.5, }, {1.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.740494311, -0.302062835, 0.877499781, 0.435099722, }, 
		{1.60000033333333, 1.86666633333333, }, 
		{{1.4, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_38-effect2#scale_x#number'] =
{
	{
		{0.616694272, -0.513041063, 0.797771604, -1.241879663, }, 
		{0.033333, 0.566667, }, 
		{{1.8, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.50357916, 0, 0.833333333, 1, }, 
		{0.566667, 1.566667, }, 
		{{1.5, }, {1.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.740494311, -0.302062835, 0.877499781, 0.435099722, }, 
		{1.566667, 1.833333, }, 
		{{1.4, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_38-effect2#ae_pre_scale_y#number'] =
{
	{
		{0.616694272, -0.513041063, 0.797771604, -1.241879663, }, 
		{0.06666633333333, 0.60000033333333, }, 
		{{1.8, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.50357916, 0, 0.833333333, 1, }, 
		{0.60000033333333, 1.60000033333333, }, 
		{{1.5, }, {1.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.740494311, -0.302062835, 0.877499781, 0.435099722, }, 
		{1.60000033333333, 1.86666633333333, }, 
		{{1.4, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_38-effect2#scale_y#number'] =
{
	{
		{0.616694272, -0.513041063, 0.797771604, -1.241879663, }, 
		{0.033333, 0.566667, }, 
		{{1.8, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.50357916, 0, 0.833333333, 1, }, 
		{0.566667, 1.566667, }, 
		{{1.5, }, {1.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.740494311, -0.302062835, 0.877499781, 0.435099722, }, 
		{1.566667, 1.833333, }, 
		{{1.4, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCCGlowOBS_38-effect3#glowThreshold#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.533333, 0.566667, }, 
		{{1, }, {0.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 0, }, 
		{0.566667, 1.833333, }, 
		{{0.1, }, {0.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.833333, 1.9, }, 
		{{0.1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_38-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.833333, 1.9, }, 
		{{100, }, {0, }, }, 
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
