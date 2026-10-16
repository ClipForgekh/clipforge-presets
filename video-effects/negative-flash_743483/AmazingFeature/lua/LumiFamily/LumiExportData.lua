local data = {}

local ae_compDurations = {0, 1.5}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiNegative_34-effect0', 'InputTex', 0},
    {'LumiTone_35-effect0', 'InputTex', 0},
    {'LumiLayer_30-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiNegative_34-effect0'] = {
        ['nodeDuration'] = {{1, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.2}, },
        },
    },
    ['LumiTritone_34-effect1'] = {
        ['nodeDuration'] = {{1, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.2}, },
        },
    },
    ['LumiBrightness_34-effect2'] = {
        ['nodeDuration'] = {{1, 1.2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.2}, },
        },
    },
    ['LumiTone_35-effect0'] = {
        ['nodeDuration'] = {{1.2, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.2, 1.36666666666667}, },
        },
    },
    ['LumiSoftGlow_35-effect1'] = {
        ['nodeDuration'] = {{1.2, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.2, 1.36666666666667}, },
        },
    },
    ['LumiContrast_35-effect2'] = {
        ['nodeDuration'] = {{1.2, 1.36666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.2, 1.36666666666667}, },
        },
    },
    ['LumiLayer_30-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_35-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.2, 1.36666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_34-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1, 1.2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiNegative_34-effect0'] = {
        ['negativeAlpha'] = 1,
    },
    ['LumiTritone_34-effect1'] = {
        ['highlightColor'] = Amaz.Color(1, 1, 1, 1),
        ['middleColor'] = Amaz.Color(0.34379091858864, 0.34379091858864, 0.34379091858864, 1),
        ['shadowColor'] = Amaz.Color(0, 0, 0, 1),
        ['oriAlpha'] = 0,
    },
    ['LumiBrightness_34-effect2'] = {
        ['brightnessIntensity'] = 0.75,
    },
    ['LumiTone_35-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(1, 0.96935552358627, 0.87189555168152, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
    },
    ['LumiSoftGlow_35-effect1'] = {
        ['thresholdType'] = 0,
        ['thresholdLow'] = 0.5,
        ['thresholdHigh'] = 1,
        ['thresholdSmooth'] = 0,
        ['grayScale'] = 0,
        ['exposure'] = 1.3,
        ['intensity'] = 50,
        ['glowColor'] = Amaz.Color(1, 1, 1, 1),
        ['quality'] = NaN,
        ['displayGlow'] = false,
    },
    ['LumiContrast_35-effect2'] = {
        ['contrastIntensity'] = 1.5,
        ['pivot'] = 0.43000000715256,
    },
    ['LumiLayer_30-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 360, 0),
        ['position'] = Amaz.Vector3f(360, 360, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 720),
        ['layerSize'] = Amaz.Vector2f(720, 720),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_35-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_34-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_30-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.366667, }, 
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
