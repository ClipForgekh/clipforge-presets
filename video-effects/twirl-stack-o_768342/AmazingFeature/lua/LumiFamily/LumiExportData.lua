local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_245-effect0', 'InputTex', 0},
    {'LumiRoundCorner_244-effect0', 'InputTex', 0},
    {'LumiRoundCorner_246-effect0', 'InputTex', 0},
    {'LumiRoundCorner_247-effect0', 'InputTex', 0},
    {'LumiRoundCorner_248-effect0', 'InputTex', 0},
    {'LumiRoundCorner_249-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_245-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_244-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_244-trs'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_245-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_246-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_246-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_247-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_247-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_248-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_248-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_249-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_249-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiBCC_Prism_253-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiChromaticAberration_253-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_253-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_245-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_244-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_244-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(50, 50, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_245-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(49.8156233074289, 49.8156233074289, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_246-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_246-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(48.5637336041776, 48.5637336041776, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -1.55657780453058,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_247-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_247-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(45.7828860901707, 45.7828860901707, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -8.78817940325445,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_248-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_248-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(40.8153325996886, 40.8153325996886, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -24.2529419799852,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_249-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_249-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(64.7801522486809, 64.7801522486809, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -52.77480568804,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_253-effect0'] = {
        ['globalTransform'] = 70,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 1,
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
    ['LumiChromaticAberration_253-effect1'] = {
        ['offsetX'] = 0.01999999986127,
        ['offsetY'] = 0.01999999986127,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_253-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_244-trs#scale#vector'] =
{
	{
		{0.859813084,0.859813084,0.859813084, 0,0,0.859813084, 0.836448598,0.836448598,0.836448598, 1,1,0.836448598, }, 
		{0.833333, 1.966667, }, 
		{{50, 50, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_244-trs#rotation#number'] =
{
	{
		{0.859813084, 0, 0.836448598, 1, }, 
		{0.966667, 1.966667, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_245-trs-blend#scale#vector'] =
{
	{
		{0.859813084,0.859813084,0.859813084, 0,0,0.859813084, 0.836448598,0.836448598,0.836448598, 1,1,0.836448598, }, 
		{0.666667, 1.8, }, 
		{{50, 50, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_245-trs-blend#rotation#number'] =
{
	{
		{0.859813084, 0, 0.836448598, 1, }, 
		{0.8, 1.8, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_246-trs-blend#scale#vector'] =
{
	{
		{0.859813084,0.859813084,0.859813084, 0,0,0.859813084, 0.836448598,0.836448598,0.836448598, 1,1,0.836448598, }, 
		{0.5, 1.633333, }, 
		{{50, 50, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_246-trs-blend#rotation#number'] =
{
	{
		{0.859813084, 0, 0.836448598, 1, }, 
		{0.633333, 1.633333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_247-trs-blend#scale#vector'] =
{
	{
		{0.859813084,0.859813084,0.859813084, 0,0,0.859813084, 0.836448598,0.836448598,0.836448598, 1,1,0.836448598, }, 
		{0.333333, 1.466667, }, 
		{{50, 50, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_247-trs-blend#rotation#number'] =
{
	{
		{0.859813084, 0, 0.836448598, 1, }, 
		{0.466667, 1.466667, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_248-trs-blend#scale#vector'] =
{
	{
		{0.859813084,0.859813084,0.859813084, 0,0,0.859813084, 0.836448598,0.836448598,0.836448598, 1,1,0.836448598, }, 
		{0.166667, 1.3, }, 
		{{50, 50, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_248-trs-blend#rotation#number'] =
{
	{
		{0.859813084, 0, 0.836448598, 1, }, 
		{0.3, 1.3, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRoundCorner_249-effect0#radius#number'] =
{
	{
		{0.859813084, 0, 0.836448598, 1, }, 
		{0, 0.566667, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_249-trs-blend#scale#vector'] =
{
	{
		{0.859813084,0.859813084,0.859813084, 0,0,0.859813084, 0.836448598,0.836448598,0.836448598, 1,1,0.836448598, }, 
		{0, 1.133333, }, 
		{{100, 100, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_249-trs-blend#rotation#number'] =
{
	{
		{0.859813084, 0, 0.836448598, 1, }, 
		{0.133333, 1.133333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_253-effect0#globalTransform#number'] =
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
    ['LumiBCC_Prism_253-effect0#weight#number'] =
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
    ['LumiChromaticAberration_253-effect1#offsetX#number'] =
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
    ['LumiChromaticAberration_253-effect1#offsetY#number'] =
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
