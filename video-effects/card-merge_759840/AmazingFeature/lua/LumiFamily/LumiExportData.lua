local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_29-effect0'] = {
        ['nodeDuration'] = {{0, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.86666666666667}, },
        },
    },
    ['LumiRoundCorner_28-effect0'] = {
        ['nodeDuration'] = {{0, 0.5}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.5}, },
        },
    },
    ['LumiRoundCorner_27-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_28-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.5}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_29-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.86666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiSoftGlow_36-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiChromaticAberration_36-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_36-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_29-effect0'] = {
        ['radius'] = 64,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiRoundCorner_28-effect0'] = {
        ['radius'] = 64,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiRoundCorner_27-effect0'] = {
        ['radius'] = 64,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(500, 500, 0),
        ['scale'] = Amaz.Vector3f(30, 30, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_28-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(182, 500, 0),
        ['scale'] = Amaz.Vector3f(30, 30, 30),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_29-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(818, 500, 0),
        ['scale'] = Amaz.Vector3f(30, 30, 30),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100724,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiSoftGlow_36-effect0'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 1,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 1,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiChromaticAberration_36-effect1'] = {
        ['offsetX'] = 0,
        ['offsetY'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiLayer_36-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_27-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.866667, 1.833333, }, 
		{{64, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_27-trs#scale#vector'] =
{
	{
		{0.231318362,0.231318362,0.231318362, 0,0,0, 0.579381855,0.579381855,0.579381855, 1,1,1, }, 
		{0.5, 0.566667, }, 
		{{30, 30, 100, }, {26.4, 26.4, 88, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.276934284,0.276934284,0.276934284, 0,0,0, 0.695400756,0.695400756,0.695400756, 1,1,1, }, 
		{0.566667, 0.866667, }, 
		{{26.4, 26.4, 88, }, {30, 30, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.145957721,0.145957721,0.145957721, -9e-9,-9e-9,-3e-9, 0.579381855,0.579381855,0.579381855, 1,1,1, }, 
		{0.866667, 1, }, 
		{{30, 30, 100, }, {26.4, 26.4, 88, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.276934284,0.276934284,0.276934284, 0,0,0, 0.020436153,0.020436153,0.020436153, 1.00000001,1.00000001,1.000000062, }, 
		{1, 1.833333, }, 
		{{26.4, 26.4, 88, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#yRotation#number'] =
{
	{
		{0.145957721, -1e-9, 0.020436153, 0.999999998, }, 
		{0.866667, 1.833333, }, 
		{{0, }, {-361, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.5, }, 
		{{182, 500, 0, }, {500, 500, 0, }, {235, 500, 0, }, {447, 500, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0, 0.266667, }, 
		{{30, 30, 30, }, {43, 43, 43, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.266667, 0.5, }, 
		{{43, 43, 43, }, {30, 30, 30, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.5, }, 
		{{0, }, {-361, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.366667, 0.866667, }, 
		{{818, 500, 0, }, {500, 500, 0, }, {765, 500, 0, }, {553, 500, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0.366667, 0.633333, }, 
		{{30, 30, 30, }, {43, 43, 43, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{0.633333, 0.866667, }, 
		{{43, 43, 43, }, {30, 30, 30, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#yRotation#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.366667, 0.866667, }, 
		{{0, }, {361, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSoftGlow_36-effect0#thresholdLow#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.5, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.866667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiSoftGlow_36-effect0#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.866667, }, 
		{{1, }, {6, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0.866667, 1.8, }, 
		{{6, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiChromaticAberration_36-effect1#offsetX#number'] =
{
	{
		{1, 3.2e-8, 0.66666667, 1, }, 
		{0, 0.5, }, 
		{{0, }, {0.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.5, 1.8, }, 
		{{0.2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiChromaticAberration_36-effect1#offsetY#number'] =
{
	{
		{1, 3.2e-8, 0.66666667, 1, }, 
		{0, 0.5, }, 
		{{0, }, {0.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.5, 1.8, }, 
		{{0.2, }, {0, }, }, 
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
