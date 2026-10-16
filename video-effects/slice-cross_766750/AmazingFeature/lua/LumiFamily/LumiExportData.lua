local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_120-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_120-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSoftGlow_120-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_118-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_118-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_118-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSoftGlow_118-effect3'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSaturation_121-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_121-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_118-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_119-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_119-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLinearWipe_119-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_120-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_119-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_123-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_123-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_120-effect0'] = {
        ['progress'] = 0.4,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_120-effect1'] = {
        ['progress'] = 0.40051987156921,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiSoftGlow_120-effect2'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 1,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_118-effect0'] = {
        ['progress'] = 0,
        ['rotation'] = -136,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_118-effect1'] = {
        ['progress'] = 0.43,
        ['rotation'] = 128,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_118-effect2'] = {
        ['progress'] = 0.36,
        ['rotation'] = -52,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiSoftGlow_118-effect3'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0.73,
        ['thresholdHigh'] = 0.46,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 1,
        ['glowIntensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = 0.5,
        ['displayGlow'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiSaturation_121-effect0'] = {
        ['saturationIntensity'] = 0.36545454545455,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_121-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
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
    },
    ['LumiLayer_118-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
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
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_119-effect0'] = {
        ['progress'] = 0.4,
        ['rotation'] = 44,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_119-effect1'] = {
        ['progress'] = 0.42,
        ['rotation'] = -135,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_119-effect2'] = {
        ['progress'] = 0.01744217783792,
        ['rotation'] = -41,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_120-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
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
        ['blendMode'] = 0,
    },
    ['LumiLayer_119-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
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
        ['blendMode'] = 0,
    },
    ['LumiRadialBlur_123-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 2.10530108387585,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_123-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLinearWipe_120-effect1#progress#number'] =
{
	{
		{0.9, 0, 0.1, 1, }, 
		{0.266667, 1.4, }, 
		{{0.74, }, {0.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLinearWipe_118-effect0#progress#number'] =
{
	{
		{0.9, 0, 0.1, 1, }, 
		{0, 1.3, }, 
		{{0.98, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSaturation_121-effect0#saturationIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1, 1.366667, }, 
		{{-0.98, }, {0.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_121-trs#opacity#number'] =
{
	{
		{0.9, 0, 0.1, 1, }, 
		{0, 0.733333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_118-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.466667, 1.966667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLinearWipe_119-effect2#progress#number'] =
{
	{
		{0.9, 0, 0.1, 1, }, 
		{0.433333, 1.533333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_120-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 1.933333, }, 
		{{100, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_119-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.966667, }, 
		{{100, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRadialBlur_123-effect0#amount#number'] =
{
	{
		{0.001, 0, 0.1, 1, }, 
		{0.4, 1.533333, }, 
		{{152, }, {0, }, }, 
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
