local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLinearWipe_31-effect0', 'InputTex', 0},
    {'LumiLinearWipe_33-effect0', 'InputTex', 0},
    {'LumiLinearWipe_36-effect0', 'InputTex', 0},
    {'LumiLinearWipe_39-effect0', 'InputTex', 0},
    {'LumiLinearWipe_34-effect0', 'InputTex', 0},
    {'LumiLinearWipe_37-effect0', 'InputTex', 0},
    {'LumiLinearWipe_27-effect0', 'InputTex', 0},
    {'LumiLinearWipe_38-effect0', 'InputTex', 0},
    {'LumiLinearWipe_28-effect0', 'InputTex', 0},
    {'LumiLinearWipe_32-effect0', 'InputTex', 0},
    {'LumiFill_40-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_31-effect0'] = {
        ['nodeDuration'] = {{1.16666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.16666666666667, 3}, },
        },
    },
    ['LumiLinearWipe_31-effect1'] = {
        ['nodeDuration'] = {{1.16666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.16666666666667, 3}, },
        },
    },
    ['LumiFill_31-effect2'] = {
        ['nodeDuration'] = {{1.16666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.16666666666667, 3}, },
        },
    },
    ['LumiLinearWipe_33-effect0'] = {
        ['nodeDuration'] = {{1.3, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.3, 3}, },
        },
    },
    ['LumiLinearWipe_33-effect1'] = {
        ['nodeDuration'] = {{1.3, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.3, 3}, },
        },
    },
    ['LumiLinearWipe_33-effect2'] = {
        ['nodeDuration'] = {{1.3, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.3, 3}, },
        },
    },
    ['LumiLinearWipe_33-effect3'] = {
        ['nodeDuration'] = {{1.3, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.3, 3}, },
        },
    },
    ['LumiFill_33-effect4'] = {
        ['nodeDuration'] = {{1.3, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.3, 3}, },
        },
    },
    ['LumiLayer_31-blend'] = {
        ['nodeDuration'] = {{1.16666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.16666666666667, 3}, },
            ['baseTex'] = {{1.3, 3}, },
        },
    },
    ['LumiLinearWipe_36-effect0'] = {
        ['nodeDuration'] = {{1.03333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.03333333333333, 3}, },
        },
    },
    ['LumiLinearWipe_36-effect1'] = {
        ['nodeDuration'] = {{1.03333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.03333333333333, 3}, },
        },
    },
    ['LumiLinearWipe_36-effect2'] = {
        ['nodeDuration'] = {{1.03333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.03333333333333, 3}, },
        },
    },
    ['LumiFill_36-effect3'] = {
        ['nodeDuration'] = {{1.03333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.03333333333333, 3}, },
        },
    },
    ['LumiLayer_36-blend'] = {
        ['nodeDuration'] = {{1.03333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.03333333333333, 3}, },
            ['baseTex'] = {{1.16666666666667, 3}, },
        },
    },
    ['LumiLinearWipe_39-effect0'] = {
        ['nodeDuration'] = {{0.9, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.9, 3}, },
        },
    },
    ['LumiLinearWipe_39-effect1'] = {
        ['nodeDuration'] = {{0.9, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.9, 3}, },
        },
    },
    ['LumiLinearWipe_39-effect2'] = {
        ['nodeDuration'] = {{0.9, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.9, 3}, },
        },
    },
    ['LumiFill_39-effect3'] = {
        ['nodeDuration'] = {{0.9, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.9, 3}, },
        },
    },
    ['LumiLayer_39-blend'] = {
        ['nodeDuration'] = {{0.9, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.9, 3}, },
            ['baseTex'] = {{1.03333333333333, 3}, },
        },
    },
    ['LumiLinearWipe_34-effect0'] = {
        ['nodeDuration'] = {{0.76666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 3}, },
        },
    },
    ['LumiLinearWipe_34-effect1'] = {
        ['nodeDuration'] = {{0.76666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 3}, },
        },
    },
    ['LumiLinearWipe_34-effect2'] = {
        ['nodeDuration'] = {{0.76666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 3}, },
        },
    },
    ['LumiFill_34-effect3'] = {
        ['nodeDuration'] = {{0.76666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 3}, },
        },
    },
    ['LumiLayer_34-blend'] = {
        ['nodeDuration'] = {{0.76666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 3}, },
            ['baseTex'] = {{0.9, 3}, },
        },
    },
    ['LumiLinearWipe_37-effect0'] = {
        ['nodeDuration'] = {{0.63333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.63333333333333, 3}, },
        },
    },
    ['LumiLinearWipe_37-effect1'] = {
        ['nodeDuration'] = {{0.63333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.63333333333333, 3}, },
        },
    },
    ['LumiLinearWipe_37-effect2'] = {
        ['nodeDuration'] = {{0.63333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.63333333333333, 3}, },
        },
    },
    ['LumiFill_37-effect3'] = {
        ['nodeDuration'] = {{0.63333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.63333333333333, 3}, },
        },
    },
    ['LumiLayer_37-blend'] = {
        ['nodeDuration'] = {{0.63333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.63333333333333, 3}, },
            ['baseTex'] = {{0.76666666666667, 3}, },
        },
    },
    ['LumiLinearWipe_27-effect0'] = {
        ['nodeDuration'] = {{0.5, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 3}, },
        },
    },
    ['LumiLinearWipe_27-effect1'] = {
        ['nodeDuration'] = {{0.5, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 3}, },
        },
    },
    ['LumiFill_27-effect2'] = {
        ['nodeDuration'] = {{0.5, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 3}, },
        },
    },
    ['LumiLayer_27-blend'] = {
        ['nodeDuration'] = {{0.5, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5, 3}, },
            ['baseTex'] = {{0.63333333333333, 3}, },
        },
    },
    ['LumiLinearWipe_38-effect0'] = {
        ['nodeDuration'] = {{0.36666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 3}, },
        },
    },
    ['LumiLinearWipe_38-effect1'] = {
        ['nodeDuration'] = {{0.36666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 3}, },
        },
    },
    ['LumiFill_38-effect2'] = {
        ['nodeDuration'] = {{0.36666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 3}, },
        },
    },
    ['LumiLayer_38-blend'] = {
        ['nodeDuration'] = {{0.36666666666667, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.36666666666667, 3}, },
            ['baseTex'] = {{0.5, 3}, },
        },
    },
    ['LumiLinearWipe_28-effect0'] = {
        ['nodeDuration'] = {{0.23333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.23333333333333, 3}, },
        },
    },
    ['LumiLinearWipe_28-effect1'] = {
        ['nodeDuration'] = {{0.23333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.23333333333333, 3}, },
        },
    },
    ['LumiLinearWipe_28-effect2'] = {
        ['nodeDuration'] = {{0.23333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.23333333333333, 3}, },
        },
    },
    ['LumiFill_28-effect3'] = {
        ['nodeDuration'] = {{0.23333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.23333333333333, 3}, },
        },
    },
    ['LumiLayer_28-blend'] = {
        ['nodeDuration'] = {{0.23333333333333, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.23333333333333, 3}, },
            ['baseTex'] = {{0.36666666666667, 3}, },
        },
    },
    ['LumiLinearWipe_32-effect0'] = {
        ['nodeDuration'] = {{0.1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 3}, },
        },
    },
    ['LumiLinearWipe_32-effect1'] = {
        ['nodeDuration'] = {{0.1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 3}, },
        },
    },
    ['LumiLinearWipe_32-effect2'] = {
        ['nodeDuration'] = {{0.1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 3}, },
        },
    },
    ['LumiLinearWipe_32-effect3'] = {
        ['nodeDuration'] = {{0.1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 3}, },
        },
    },
    ['LumiFill_32-effect4'] = {
        ['nodeDuration'] = {{0.1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 3}, },
        },
    },
    ['LumiLayer_32-blend'] = {
        ['nodeDuration'] = {{0.1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 3}, },
            ['baseTex'] = {{0.23333333333333, 3}, },
        },
    },
    ['LumiFill_40-effect0'] = {
        ['nodeDuration'] = {{1.5, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.5, 3}, },
        },
    },
    ['LumiLayer_40-blend'] = {
        ['nodeDuration'] = {{0.1, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.5, 3}, },
            ['baseTex'] = {{0.1, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_31-effect0'] = {
        ['progress'] = 0.465,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_31-effect1'] = {
        ['progress'] = 0.6,
        ['rotation'] = 234,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_31-effect2'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_33-effect0'] = {
        ['progress'] = 0.585,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_33-effect1'] = {
        ['progress'] = 0.31,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_33-effect2'] = {
        ['progress'] = 0.43,
        ['rotation'] = 236,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_33-effect3'] = {
        ['progress'] = 0.402,
        ['rotation'] = 54,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_33-effect4'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_31-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_36-effect0'] = {
        ['progress'] = 0.44,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_36-effect1'] = {
        ['progress'] = 0.57,
        ['rotation'] = 58,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_36-effect2'] = {
        ['progress'] = 0.442,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_36-effect3'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_36-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_39-effect0'] = {
        ['progress'] = 0.6,
        ['rotation'] = -126,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_39-effect1'] = {
        ['progress'] = 0,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_39-effect2'] = {
        ['progress'] = 0.67,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_39-effect3'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_39-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_34-effect0'] = {
        ['progress'] = 0.562,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_34-effect1'] = {
        ['progress'] = 0.572,
        ['rotation'] = 56,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_34-effect2'] = {
        ['progress'] = 0.41,
        ['rotation'] = 140,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_34-effect3'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_34-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_37-effect0'] = {
        ['progress'] = 0.537,
        ['rotation'] = -180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_37-effect1'] = {
        ['progress'] = 0.6,
        ['rotation'] = -126,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_37-effect2'] = {
        ['progress'] = 0.332,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_37-effect3'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_37-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_27-effect0'] = {
        ['progress'] = 0.596,
        ['rotation'] = -39,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_27-effect1'] = {
        ['progress'] = 0.692,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_27-effect2'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_27-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_38-effect0'] = {
        ['progress'] = 0.56,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_38-effect1'] = {
        ['progress'] = 0.402,
        ['rotation'] = 54,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_38-effect2'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_38-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_28-effect0'] = {
        ['progress'] = 0.572,
        ['rotation'] = 56,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_28-effect1'] = {
        ['progress'] = 0.31,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_28-effect2'] = {
        ['progress'] = 0.592,
        ['rotation'] = -40,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_28-effect3'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_28-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_32-effect0'] = {
        ['progress'] = 0.442,
        ['rotation'] = 0,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_32-effect1'] = {
        ['progress'] = 0.417,
        ['rotation'] = 180,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_32-effect2'] = {
        ['progress'] = 0.402,
        ['rotation'] = 54,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLinearWipe_32-effect3'] = {
        ['progress'] = 0.432,
        ['rotation'] = -122,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiFill_32-effect4'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_32-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
    ['LumiFill_40-effect0'] = {
        ['color'] = Amaz.Color(1, 1, 1, 1),
        ['opacity'] = 0,
        ['alpha'] = 1,
        ['reverse'] = false,
        ['blendMode'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(512, 512),
    },
    ['LumiLayer_40-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiFill_31-effect2#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.1, 1.166667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.166667, 1.233333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_33-effect4#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.233333, 1.3, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.3, 1.366667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_36-effect3#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.966667, 1.033333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.033333, 1.1, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_39-effect3#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.833333, 0.9, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.9, 0.966667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_34-effect3#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.7, 0.766667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.766667, 0.833333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_37-effect3#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.633333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.633333, 0.7, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_27-effect2#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.433333, 0.5, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.566667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_38-effect2#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.3, 0.366667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 0.433333, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_28-effect3#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.233333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.233333, 0.3, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_32-effect4#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.033333, 0.1, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.166667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiFill_40-effect0#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.5, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.5, 1.566667, }, 
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
