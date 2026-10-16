local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_255-effect0', 'InputTex', 1},
    {'LumiRoundCorner_252-effect0', 'InputTex', 1},
    {'LumiRoundCorner_251-effect0', 'InputTex', 1},
    {'LumiRoundCorner_253-effect0', 'InputTex', 1},
    {'LumiRoundCorner_254-effect0', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_255-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_252-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_251-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_251-trs'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_252-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_253-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_253-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRoundCorner_254-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_254-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_255-trs-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiBCC_Prism_258-effect0'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiChromaticAberration_258-effect1'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiRadialBlur_258-effect2'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
        },
    },
    ['LumiLayer_258-blend'] = {
        ['nodeDuration'] = {{0, 3.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3.33333333333333}, },
            ['baseTex'] = {{0, 3.33333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_255-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_252-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRoundCorner_251-effect0'] = {
        ['radius'] = 49.9920907414391,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_251-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 7998.74354495084),
        ['scale'] = Amaz.Vector3f(20.5165634618834, 20.5165634618834, 20.5165634618834),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 84,
        ['yRotation'] = 0,
        ['rotation'] = -715.350928843049,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_252-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(53, 53, 53),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 3342.71921983885),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 89.1655974352427,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 17.9043174491834,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_253-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_253-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(53, 53, 53),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 3342.71921983885),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 89.1655974352427,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 17.9043174491834,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_254-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_254-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(53, 53, 53),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 3342.71921983885),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 89.1655974352427,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 17.9043174491834,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_255-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(53, 53, 53),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['p0_anchorPoint'] = Amaz.Vector3f(50, 50, 0),
        ['p0_position'] = Amaz.Vector3f(960, 540, 3342.71921983885),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 89.1655974352427,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 17.9043174491834,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiBCC_Prism_258-effect0'] = {
        ['globalTransform'] = 5,
        ['smoothness'] = 1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weight'] = 0.07142857142857,
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
    ['LumiChromaticAberration_258-effect1'] = {
        ['offsetX'] = 0.00142857139664,
        ['offsetY'] = 0.00142857139664,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiRadialBlur_258-effect2'] = {
        ['blurType'] = 0,
        ['amount'] = 10,
        ['quality'] = 0.20000000298023,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_258-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_251-effect0#radius#number'] =
{
	{
		{0.813829787, 0, 0.186170213, 1, }, 
		{0, 1.9, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_251-trs#position#vector'] =
{
	{
		{0.81383, 0, 0.18617, 1, }, 
		{0, 1.9, }, 
		{{960, 540, 0, }, {960, 540, 8000, }, {960, 540, 0, }, {960, 540, 8000, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_251-trs#scale#vector'] =
{
	{
		{0.835106383,0.835106383,0.835106383, 0,0,0, 0.872340426,0.872340426,0.872340426, 1,1,1, }, 
		{0, 1.9, }, 
		{{100, 100, 100, }, {20, 20, 20, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_251-trs#xRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.4, 1.9, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_251-trs#rotation#number'] =
{
	{
		{0.835106383, 0, 0.872340426, 1, }, 
		{0, 1.9, }, 
		{{0, }, {-720, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_252-trs-blend#position#vector'] =
{
	{
		{0.829787, 0, 0.87234, 1, }, 
		{0, 1.466667, }, 
		{{-710, 50, 72.637687683, }, {0, 0, 0, }, {-710, 50, 72.637687683, }, {-166.726913452148, 196.723220825195, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_252-trs-blend#orientation#vector'] =
{
	{
		{0.829787, 0.829787, 0.87234, 0.87234, }, 
		{0, 1.466667, }, 
		{{0, 0, 0, }, {0, 0, 0, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_252-trs-blend#yRotation#number'] =
{
	{
		{0.829787234, 0, 0.872340426, 1, }, 
		{0, 1.466667, }, 
		{{-63, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_252-trs-blend#p0_position#vector'] =
{
	{
		{0.835106, 0, 0.87234, 1, }, 
		{0, 1.933333, }, 
		{{960, 540, -2000, }, {960, 540, 3480, }, {960, 540, -2000, }, {960, 540, 3480, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_252-trs-blend#p0_xRotation#number'] =
{
	{
		{0.813829787, 0, 0.186170213, 1, }, 
		{1.4, 1.933333, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_252-trs-blend#p0_rotation#number'] =
{
	{
		{0.829787234, 0, 0.872340426, 1, }, 
		{0, 1.933333, }, 
		{{720, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_253-trs-blend#position#vector'] =
{
	{
		{0.829787, 0, 0.87234, 1, }, 
		{0.133333, 1.6, }, 
		{{810, 50, 72.637687683, }, {0, 0, 0, }, {810, 50, 72.637687683, }, {295.866668701172, -225.803237915039, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_253-trs-blend#orientation#vector'] =
{
	{
		{0.829787, 0.829787, 0.87234, 0.87234, }, 
		{0.133333, 1.6, }, 
		{{0, 0, 0, }, {0, 0, 0, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_253-trs-blend#yRotation#number'] =
{
	{
		{0.829787234, 0, 0.872340426, 1, }, 
		{0.133333, 1.6, }, 
		{{63, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_253-trs-blend#p0_position#vector'] =
{
	{
		{0.835106, 0, 0.87234, 1, }, 
		{0, 1.933333, }, 
		{{960, 540, -2000, }, {960, 540, 3480, }, {960, 540, -2000, }, {960, 540, 3480, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_253-trs-blend#p0_xRotation#number'] =
{
	{
		{0.813829787, 0, 0.186170213, 1, }, 
		{1.4, 1.933333, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_253-trs-blend#p0_rotation#number'] =
{
	{
		{0.829787234, 0, 0.872340426, 1, }, 
		{0, 1.933333, }, 
		{{720, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_254-trs-blend#position#vector'] =
{
	{
		{0.829787, 0, 0.87234, 1, }, 
		{0.266667, 1.733333, }, 
		{{50, 810, 72.637687683, }, {0, 0, 0, }, {50, 810, 72.637687683, }, {339.771392822266, 327.917144775391, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_254-trs-blend#orientation#vector'] =
{
	{
		{0.829787, 0, 0.87234, 1, }, 
		{0.266667, 1.733333, }, 
		{{0, 0, 270, }, {0, 0, 360, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_254-trs-blend#yRotation#number'] =
{
	{
		{0.829787234, 0, 0.872340426, 1, }, 
		{0.266667, 1.733333, }, 
		{{-63, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_254-trs-blend#p0_position#vector'] =
{
	{
		{0.835106, 0, 0.87234, 1, }, 
		{0, 1.933333, }, 
		{{960, 540, -2000, }, {960, 540, 3480, }, {960, 540, -2000, }, {960, 540, 3480, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_254-trs-blend#p0_xRotation#number'] =
{
	{
		{0.813829787, 0, 0.186170213, 1, }, 
		{1.4, 1.933333, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_254-trs-blend#p0_rotation#number'] =
{
	{
		{0.829787234, 0, 0.872340426, 1, }, 
		{0, 1.933333, }, 
		{{720, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_255-trs-blend#position#vector'] =
{
	{
		{0.829787, 0, 0.87234, 1, }, 
		{0.4, 1.866667, }, 
		{{50, -710, 72.637687683, }, {0, 0, 0, }, {50, -710, 72.637687683, }, {-276.651428222656, -246.357147216797, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_255-trs-blend#orientation#vector'] =
{
	{
		{0.829787, 0, 0.87234, 1, }, 
		{0.4, 1.866667, }, 
		{{0, 0, 270, }, {0, 0, 360, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_255-trs-blend#yRotation#number'] =
{
	{
		{0.829787234, 0, 0.872340426, 1, }, 
		{0.4, 1.866667, }, 
		{{63, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_255-trs-blend#p0_position#vector'] =
{
	{
		{0.835106, 0, 0.87234, 1, }, 
		{0, 1.933333, }, 
		{{960, 540, -2000, }, {960, 540, 3480, }, {960, 540, -2000, }, {960, 540, 3480, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_255-trs-blend#p0_xRotation#number'] =
{
	{
		{0.813829787, 0, 0.186170213, 1, }, 
		{1.4, 1.933333, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_255-trs-blend#p0_rotation#number'] =
{
	{
		{0.829787234, 0, 0.872340426, 1, }, 
		{0, 1.933333, }, 
		{{720, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBCC_Prism_258-effect0#globalTransform#number'] =
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
    ['LumiBCC_Prism_258-effect0#weight#number'] =
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
    ['LumiChromaticAberration_258-effect1#offsetX#number'] =
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
    ['LumiChromaticAberration_258-effect1#offsetY#number'] =
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
    ['LumiRadialBlur_258-effect2#amount#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.933333, }, 
		{{0, }, {10, }, }, 
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
