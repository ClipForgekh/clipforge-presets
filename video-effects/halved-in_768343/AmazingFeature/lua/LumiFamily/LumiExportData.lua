local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLinearWipe_153-effect0', 'InputTex', 0},
    {'LumiLinearWipe_142-effect0', 'InputTex', 0},
    {'LumiLinearWipe_167-effect0', 'InputTex', 0},
    {'LumiLinearWipe_168-effect0', 'InputTex', 0},
    {'LumiLinearWipe_169-effect0', 'InputTex', 0},
    {'LumiLinearWipe_170-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLinearWipe_153-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_142-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_142-trs'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_153-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiTone_172-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_172-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_167-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_167-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_168-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_168-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiTone_173-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_173-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_169-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_169-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLinearWipe_170-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_170-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiBCC_Prism_146-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiChromaticAberration_146-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_146-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLinearWipe_153-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = -90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLinearWipe_142-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_142-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_153-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTone_172-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.38431373238564, 0.38431373238564, 0.38431373238564, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_172-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_167-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_167-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(1074.38971547354, 539.268727473354, 143.772171801056),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -5.04658473153943,
        ['rotation'] = -10.2470647830882,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_168-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = -90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_168-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(845.60983541203, 540.731275397761, 143.772736276253),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 5.04658473153943,
        ['rotation'] = -10.2470647830882,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiTone_173-effect0'] = {
        ['amount'] = 1,
        ['whiteColor'] = Amaz.Color(0.40784314274788, 0.40784314274788, 0.40784314274788, 1),
        ['blackColor'] = Amaz.Color(0, 0, 0, 1),
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_173-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_169-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = 90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_169-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(1884.30046014689, 534.091116233018, 1161.7188136356),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = -40.777921984467,
        ['rotation'] = -86.8210154230706,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLinearWipe_170-effect0'] = {
        ['progress'] = 0.499,
        ['rotation'] = -90,
        ['feather'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_170-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(35.6995398531099, 545.908883767055, 1161.7188136356),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 40.777921984467,
        ['rotation'] = -86.8210154230706,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_146-effect0'] = {
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
    ['LumiChromaticAberration_146-effect1'] = {
        ['offsetX'] = 0.01999999975336,
        ['offsetY'] = 0.01999999975336,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_146-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_142-trs#position#vector'] =
{
	{
		{0.121495, 0, 0.102804, 1, }, 
		{0, 1, }, 
		{{3000, 526.958653161, 2564, }, {960, 540, 0, }, {3000, 526.958653161, 2564, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_142-trs#yRotation#number'] =
{
	{
		{0.121495327, 0, 0.102803738, 1, }, 
		{0, 1, }, 
		{{-90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_142-trs#rotation#number'] =
{
	{
		{0.163551402, 0, 0.102803738, 1, }, 
		{0, 1, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_153-trs-blend#position#vector'] =
{
	{
		{0.121495, 0, 0.102804, 1, }, 
		{0, 1, }, 
		{{-1080, 553.04134684, 2564, }, {960, 540, 0, }, {-1080, 553.04134684, 2564, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_153-trs-blend#yRotation#number'] =
{
	{
		{0.121495327, 0, 0.102803738, 1, }, 
		{0, 1, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_153-trs-blend#rotation#number'] =
{
	{
		{0.163551402, 0, 0.102803738, 1, }, 
		{0, 1, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_167-trs-blend#position#vector'] =
{
	{
		{0.121495, 0, 0.102804, 1, }, 
		{0.333333, 1.333333, }, 
		{{3000, 526.958653161, 2564, }, {960, 540, 0, }, {3000, 526.958653161, 2564, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_167-trs-blend#yRotation#number'] =
{
	{
		{0.121495327, 0, 0.102803738, 1, }, 
		{0.333333, 1.333333, }, 
		{{-90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_167-trs-blend#rotation#number'] =
{
	{
		{0.163551402, 0, 0.102803738, 1, }, 
		{0.333333, 1.333333, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_168-trs-blend#position#vector'] =
{
	{
		{0.121495, 0, 0.102804, 1, }, 
		{0.333333, 1.333333, }, 
		{{-1080, 553.04134684, 2564, }, {960, 540, 0, }, {-1080, 553.04134684, 2564, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_168-trs-blend#yRotation#number'] =
{
	{
		{0.121495327, 0, 0.102803738, 1, }, 
		{0.333333, 1.333333, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_168-trs-blend#rotation#number'] =
{
	{
		{0.163551402, 0, 0.102803738, 1, }, 
		{0.333333, 1.333333, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_169-trs-blend#position#vector'] =
{
	{
		{0.121495, 0, 0.102804, 1, }, 
		{0.766667, 1.766667, }, 
		{{3000, 526.958653161, 2564, }, {960, 540, 0, }, {3000, 526.958653161, 2564, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_169-trs-blend#yRotation#number'] =
{
	{
		{0.121495327, 0, 0.102803738, 1, }, 
		{0.766667, 1.766667, }, 
		{{-90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_169-trs-blend#rotation#number'] =
{
	{
		{0.163551402, 0, 0.102803738, 1, }, 
		{0.766667, 1.766667, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_170-trs-blend#position#vector'] =
{
	{
		{0.121495, 0, 0.102804, 1, }, 
		{0.766667, 1.766667, }, 
		{{-1080, 553.04134684, 2564, }, {960, 540, 0, }, {-1080, 553.04134684, 2564, }, {960, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_170-trs-blend#yRotation#number'] =
{
	{
		{0.121495327, 0, 0.102803738, 1, }, 
		{0.766667, 1.766667, }, 
		{{90, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_170-trs-blend#rotation#number'] =
{
	{
		{0.163551402, 0, 0.102803738, 1, }, 
		{0.766667, 1.766667, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_146-effect0#globalTransform#number'] =
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
    ['LumiBCC_Prism_146-effect0#weight#number'] =
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
    ['LumiChromaticAberration_146-effect1#offsetX#number'] =
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
    ['LumiChromaticAberration_146-effect1#offsetY#number'] =
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
