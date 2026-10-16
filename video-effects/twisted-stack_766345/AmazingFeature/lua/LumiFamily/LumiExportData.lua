local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_579-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_596-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_597-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_598-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_599-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_595-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiRadialBlur_584-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiOpticsCompensation_584-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_584-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiWarp_594-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_594-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiSShake_601-effect0'] = {
        ['nodeDuration'] = {{0, 1.9}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_601-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.9}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_579-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_596-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(30, 30, 30),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_597-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(40, 40, 40),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_598-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(50, 50, 50),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_599-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(60, 60, 60),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_595-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(392, 554, 0),
        ['position'] = Amaz.Vector3f(392, 554, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100188,
        ['compositeSize'] = Amaz.Vector2f(784, 1108),
        ['layerSize'] = Amaz.Vector2f(784, 1108),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRadialBlur_584-effect0'] = {
        ['blurType'] = 0,
        ['amount'] = 0,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiOpticsCompensation_584-effect1'] = {
        ['fov'] = 0,
        ['inverseLensDistortion'] = true,
        ['fovOrientation'] = 0,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['antiAliasing'] = true,
        ['fillBorders'] = false,
    },
    ['LumiLayer_584-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiWarp_594-effect0'] = {
        ['warpStyle'] = 13,
        ['warpAxis'] = 0,
        ['bend'] = 0,
    },
    ['LumiLayer_594-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiSShake_601-effect0'] = {
        ['ampRatio'] = 0,
        ['frqRatio'] = 8,
        ['phase0'] = 0,
        ['scale0'] = 1,
        ['blurEnabled'] = false,
        ['blurIntensity'] = 1,
        ['blurQuality'] = 0,
        ['seed'] = 0,
        ['xFill'] = 2,
        ['yFill'] = 2,
        ['xAmpR'] = 192,
        ['xFrqR'] = 1,
        ['xAmp'] = 0,
        ['xFrq'] = 0.5,
        ['xPhase'] = 0,
        ['yAmpR'] = 192,
        ['yFrqR'] = 1,
        ['yAmp'] = 0,
        ['yFrq'] = 0.5,
        ['yPhase'] = 0,
        ['zAmpR'] = 0,
        ['zFrqR'] = 1,
        ['zAmp'] = 0,
        ['zFrq'] = 0.5,
        ['zPhase'] = 0,
        ['wAmpR'] = 0,
        ['wFrqR'] = 1,
        ['wAmp'] = 0,
        ['wFrq'] = 0.5,
        ['wPhase'] = 0,
        ['rAmpRatio'] = 1,
        ['gAmpRatio'] = 1,
        ['bAmpRatio'] = 1,
        ['rPhase'] = 0,
        ['gPhase'] = 0,
        ['bPhase'] = 0,
        ['rgbRnd'] = 0,
        ['rgbFrq'] = 2,
    },
    ['LumiLayer_601-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_579-trs#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.066667, 0.666667, }, 
		{{392, 1878, 0, }, {392, 554, 0, }, {392, 1657.33332824707, 0, }, {392, 774.66667175293, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_596-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.266667, 0.866667, }, 
		{{392, 1878, 0, }, {392, 554, 0, }, {392, 1657.33332824707, 0, }, {392, 774.66667175293, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_597-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.5, 1.1, }, 
		{{392, 1878, 0, }, {392, 554, 0, }, {392, 1657.33332824707, 0, }, {392, 774.66667175293, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_598-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.733333, 1.333333, }, 
		{{392, 1878, 0, }, {392, 554, 0, }, {392, 1657.33332824707, 0, }, {392, 774.66667175293, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_599-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{0.966667, 1.566667, }, 
		{{392, 1878, 0, }, {392, 554, 0, }, {392, 1657.33332824707, 0, }, {392, 774.66667175293, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_595-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0, 1, }, 
		{1.266667, 1.966667, }, 
		{{392, 1878, 0, }, {392, 554, 0, }, {392, 1657.33332824707, 0, }, {392, 774.66667175293, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_595-trs-blend#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0,0,0, 0.66666667,0.66666667,0.66666667, 1,1,1, }, 
		{1.5, 1.933333, }, 
		{{130, 130, 130, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_584-effect0#amount#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.6, 1.933333, }, 
		{{20, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiOpticsCompensation_584-effect1#fov#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.466667, 1.9, }, 
		{{80, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiWarp_594-effect0#bend#number'] =
{
	{
		{0.163354504, 0, 0.593555947, 1.099036483, }, 
		{0.266667, 1, }, 
		{{50, }, {-100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.424986364, 0.056484332, 0.82919313, 1, }, 
		{1, 1.533333, }, 
		{{-100, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.533333, 1.933333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_601-effect0#ampRatio#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.533333, 1.9, }, 
		{{1, }, {0, }, }, 
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
