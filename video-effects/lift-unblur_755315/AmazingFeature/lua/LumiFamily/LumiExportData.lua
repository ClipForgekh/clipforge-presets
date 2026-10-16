local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBokehBlur_26-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiDeepGlow_26-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_26-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiRoundCorner_37-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_37-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBokehBlur_26-effect0'] = {
        ['bokehMode'] = 0,
        ['sample'] = 16.1,
        ['scaleX'] = 1,
        ['scaleY'] = 1,
        ['regionIns'] = 0.5,
        ['lightIns'] = 4,
        ['darkIns'] = 2,
        ['quality'] = 0.69999998807907,
        ['angle'] = 0,
        ['lineNum'] = 5,
        ['starShapeIns'] = 0.60000002384186,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 720),
    },
    ['LumiDeepGlow_26-effect1'] = {
        ['radius'] = 140,
        ['exposure'] = 0.7,
        ['threshold'] = 0,
        ['thresholdSmooth'] = 0,
        ['greyScale'] = 0,
        ['blendMode'] = 1,
        ['view'] = 1,
        ['ratio'] = 1,
        ['rotate'] = 0,
        ['ca'] = false,
        ['redOffset'] = 0.0025,
        ['greenOffset'] = 0,
        ['blueOffset'] = -0.0025,
        ['tint'] = false,
        ['tintMode'] = 1,
        ['tintColor'] = Amaz.Color(1, 0, 0, 1),
        ['tintMix'] = 1,
        ['sourceOpacity'] = 1,
        ['unmult'] = true,
        ['gammaCorrect'] = true,
        ['gammaValue'] = 2,
        ['glowIter'] = 8,
        ['stepsMult'] = 1.5,
        ['downSample'] = 0.80000001192093,
        ['quality'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 720),
    },
    ['LumiLayer_26-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 360, 0),
        ['position'] = Amaz.Vector3f(540, 360, 0),
        ['scale'] = Amaz.Vector3f(166, 166, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 720),
        ['layerSize'] = Amaz.Vector2f(1080, 720),
        ['mirrorEdge'] = false,
    },
    ['LumiRoundCorner_37-effect0'] = {
        ['radius'] = 0,
        ['fade'] = 13,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 720),
    },
    ['LumiLayer_37-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 360, 0),
        ['position'] = Amaz.Vector3f(540, 360, 0),
        ['scale'] = Amaz.Vector3f(99.5073450528682, 99.5073450528681, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 720),
        ['layerSize'] = Amaz.Vector2f(1080, 720),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_26-trs#scale#vector'] =
{
	{
		{0.73864748,0.73864748,0.33333333, 3.1e-8,3.1e-8,0.33333333, 0.206392544,0.206392544,0.66666667, 1.000000307,1.000000307,0.66666667, }, 
		{0.366667, 1.4, }, 
		{{100, 100, 100, }, {166, 166, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiRoundCorner_37-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.166667, 1.566667, }, 
		{{110, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_37-trs-blend#position#vector'] =
{
	{
		{0.801708, 0, 0.9999, 1, }, 
		{0.3, 0.666667, }, 
		{{540, 880, 0, }, {540, 607.625752878, 0, }, {540, 880, 0, }, {540, 607.625752878, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.0001, 0, 0.195851, 1, }, 
		{0.666667, 1.033333, }, 
		{{540, 607.625752878, 0, }, {540, 360, 0, }, {540, 607.625752878, 0, }, {540, 360, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_37-trs-blend#scale#vector'] =
{
	{
		{0.0001,0.0001,0.33333333, 0,0,0.33333333, 0.12873696,0.12873696,0.66666667, 0.999999824,0.999999824,0.66666667, }, 
		{1, 1.733333, }, 
		{{43, 43, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
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
