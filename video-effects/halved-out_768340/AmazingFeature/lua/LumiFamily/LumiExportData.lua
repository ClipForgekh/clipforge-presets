local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLinearWipe_264-effect0', 'InputTex', 0},
    {'LumiLinearWipe_263-effect0', 'InputTex', 0},
    {'LumiLinearWipe_266-effect0', 'InputTex', 0},
    {'LumiLinearWipe_267-effect0', 'InputTex', 0},
    {'LumiLinearWipe_269-effect0', 'InputTex', 0},
    {'LumiLinearWipe_270-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_264-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_263-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_263-trs'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_264-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiTone_265-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_265-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_266-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_266-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_267-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_267-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiTone_268-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_268-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_269-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_269-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_270-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_270-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiBCC_Prism_274-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiChromaticAberration_274-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_274-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_264-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = -90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLinearWipe_263-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_263-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(3000, 526.958679199219, 2564),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -90,
        ['rotation'] = -180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_264-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1080, 553.041320800781, 2564),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 90,
        ['rotation'] = -180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTone_265-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.38431373238564, 0.38431373238564, 0.38431373238564, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_265-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_266-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_266-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(3000, 526.958679199219, 2564),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -90,
        ['rotation'] = -180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_267-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = -90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_267-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1080, 553.041320800781, 2564),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 90,
        ['rotation'] = -180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTone_268-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.40784314274788, 0.40784314274788, 0.40784314274788, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_268-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_269-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_269-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(3000, 526.958679199219, 2564),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -90,
        ['rotation'] = -180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_270-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = -90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_270-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(-1080, 553.041320800781, 2564),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 90,
        ['rotation'] = -180,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_274-effect0'] = {
        ['globalTransform'] = 25,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 0.35714285714286,
        ['scaleStart'] = 102,
        ['scaleEnd'] = 98,
        ['angleStart'] = 0,
        ['angleEnd'] = 0,
        ['falloff'] = 0,
        ['offsetStart'] = Amaz.Vector2f(0.5, 0.5),
        ['offsetEnd'] = Amaz.Vector2f(0.5, 0.5),
        ['colorStart'] = Amaz.Color(1, 0, 0, 1),
        ['colorMid'] = Amaz.Color(0, 1, 0, 1),
        ['colorEnd'] = Amaz.Color(0, 0, 1, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiChromaticAberration_274-effect1'] = {
        ['offsetX'] = 0.0071428569832,
        ['offsetY'] = 0.0071428569832,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_274-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_263-trs#position#vector'] =
{
	{
		{0.897196, 0, 0.878505, 1, }, 
		{0.733333, 1.733333, }, 
		{{960, 540, 0, }, {3000, 526.958679199, 2564, }, {960, 540, 0, }, {3000, 526.958679199, 2564, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_263-trs#yRotation#number'] =
{
	{
		{0.897196262, 0, 0.878504673, 1, }, 
		{0.733333, 1.733333, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_263-trs#rotation#number'] =
{
	{
		{0.897196262, 0, 0.836448598, 1, }, 
		{0.733333, 1.733333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_264-trs-blend#position#vector'] =
{
	{
		{0.897196, 0, 0.878505, 1, }, 
		{0.733333, 1.733333, }, 
		{{960, 540, 0, }, {-1080, 553.041320801, 2564, }, {960, 540, 0, }, {-1080, 553.041320801, 2564, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_264-trs-blend#yRotation#number'] =
{
	{
		{0.897196262, 0, 0.878504673, 1, }, 
		{0.733333, 1.733333, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_264-trs-blend#rotation#number'] =
{
	{
		{0.897196262, 0, 0.836448598, 1, }, 
		{0.733333, 1.733333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_266-trs-blend#position#vector'] =
{
	{
		{0.897196, 0, 0.878505, 1, }, 
		{0.366667, 1.366667, }, 
		{{960, 540, 0, }, {3000, 526.958679199, 2564, }, {960, 540, 0, }, {3000, 526.958679199, 2564, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_266-trs-blend#yRotation#number'] =
{
	{
		{0.897196262, 0, 0.878504673, 1, }, 
		{0.366667, 1.366667, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_266-trs-blend#rotation#number'] =
{
	{
		{0.897196262, 0, 0.836448598, 1, }, 
		{0.366667, 1.366667, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_267-trs-blend#position#vector'] =
{
	{
		{0.897196, 0, 0.878505, 1, }, 
		{0.366667, 1.366667, }, 
		{{960, 540, 0, }, {-1080, 553.041320801, 2564, }, {960, 540, 0, }, {-1080, 553.041320801, 2564, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_267-trs-blend#yRotation#number'] =
{
	{
		{0.897196262, 0, 0.878504673, 1, }, 
		{0.366667, 1.366667, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_267-trs-blend#rotation#number'] =
{
	{
		{0.897196262, 0, 0.836448598, 1, }, 
		{0.366667, 1.366667, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_269-trs-blend#position#vector'] =
{
	{
		{0.897196, 0, 0.878505, 1, }, 
		{0, 1, }, 
		{{960, 540, 0, }, {3000, 526.958679199, 2564, }, {960, 540, 0, }, {3000, 526.958679199, 2564, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_269-trs-blend#yRotation#number'] =
{
	{
		{0.897196262, 0, 0.878504673, 1, }, 
		{0, 1, }, 
		{{0, }, {-90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_269-trs-blend#rotation#number'] =
{
	{
		{0.897196262, 0, 0.836448598, 1, }, 
		{0, 1, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_270-trs-blend#position#vector'] =
{
	{
		{0.897196, 0, 0.878505, 1, }, 
		{0, 1, }, 
		{{960, 540, 0, }, {-1080, 553.041320801, 2564, }, {960, 540, 0, }, {-1080, 553.041320801, 2564, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_270-trs-blend#yRotation#number'] =
{
	{
		{0.897196262, 0, 0.878504673, 1, }, 
		{0, 1, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_270-trs-blend#rotation#number'] =
{
	{
		{0.897196262, 0, 0.836448598, 1, }, 
		{0, 1, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_274-effect0#globalTransform#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.466667, }, 
		{{0, }, {70, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1.433333, }, 
		{{70, }, {70, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.9, }, 
		{{70, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBCC_Prism_274-effect0#weight#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.466667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1.433333, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.9, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_274-effect1#offsetX#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.466667, }, 
		{{0, }, {0.02, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1.433333, }, 
		{{0.02, }, {0.02, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.9, }, 
		{{0.02, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiChromaticAberration_274-effect1#offsetY#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.466667, }, 
		{{0, }, {0.02, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1.433333, }, 
		{{0.02, }, {0.02, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.9, }, 
		{{0.02, }, {0, }, }, 
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
