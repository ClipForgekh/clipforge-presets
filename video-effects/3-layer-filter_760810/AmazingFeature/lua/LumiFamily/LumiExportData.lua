local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiPageTurn_28-effect0', 'InputTex', 0},
    {'LumiPageTurn_28-effect0', 'frontTex', 0},
    {'LumiPageTurn_30-effect0', 'InputTex', 0},
    {'LumiPageTurn_29-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiPageTurn_28-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['frontTex'] = {{0, 3}, },
        },
    },
    ['LumiSaturation_28-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiPageTurn_30-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['frontTex'] = {{0, 3}, },
        },
    },
    ['LumiNegative_30-effect1'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_30-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiPageTurn_29-effect0'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['frontTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_29-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiPageTurn_28-effect0'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(0.91019803988336, 0.04236365788798),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.3,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiSaturation_28-effect1'] = {
        ['saturationIntensity'] = -1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiPageTurn_30-effect0'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(-0.13967653418635, 0.89413877528888),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.3,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiNegative_30-effect1'] = {
        ['negativeAlpha'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiLayer_30-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiPageTurn_29-effect0'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(-0.92638888888889, 1.53240740740741),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.3,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1080),
    },
    ['LumiLayer_29-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiPageTurn_28-effect0#inFoldPosition#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.666667, }, 
		{{-0.92638888888889, 1.53240740740741, }, {0.92361111111111, 0.03148148148148, }, {-0.92638888888889, 1.53240740740741, }, {0.92361111111111, 0.03148148148148, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_30-effect0#inFoldPosition#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.333333, 1, }, 
		{{-0.92638888888889, 1.53240740740741, }, {0.92361111111111, 0.03148148148148, }, {-0.92638888888889, 1.53240740740741, }, {0.92361111111111, 0.03148148148148, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_29-effect0#inFoldPosition#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1.333333, }, 
		{{-0.92638888888889, 1.53240740740741, }, {0.92361111111111, 0.03148148148148, }, {-0.92638888888889, 1.53240740740741, }, {0.92361111111111, 0.03148148148148, }, }, 
		{6415, }, 
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
