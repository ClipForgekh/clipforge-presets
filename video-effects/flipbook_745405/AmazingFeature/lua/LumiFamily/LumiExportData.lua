local data = {}

local ae_compDurations = {0, 1.6}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_155-trs-blend', 'baseTex', 0},
    {'LumiLayer_154-trs-blend', 'baseTex', 0},
    {'LumiLayer_153-trs-blend', 'baseTex', 0},
    {'LumiLayer_152-trs-blend', 'baseTex', 0},
    {'LumiLayer_149-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_155-trs-blend'] = {
        ['nodeDuration'] = {{0.5333333333334, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5333333333334, 1.6}, },
            ['baseTex'] = {{0.5333333333334, 1.6}, },
        },
    },
    ['LumiRoundCorner_47-effect0'] = {
        ['nodeDuration'] = {{0.5333333333334, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5333333333334, 1.6}, },
        },
    },
	--5
    ['LumiLayer_47-trs'] = {
        ['nodeDuration'] = {{0.5333333333334, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5333333333334, 1.6}, },
        },
    },
	['Lumi3DShape_5'] = {
        ['nodeDuration'] = {{0.5333333333334, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.5333333333334, 1.6}, },
        },
    },
	
    ['LumiLayer_154-trs-blend'] = {
        ['nodeDuration'] = {{0.4, 1.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.4, 1.33333333333333}, },
            ['baseTex'] = {{0.4, 1.33333333333333}, },
        },
    },
    ['LumiRoundCorner_48-effect0'] = {
        ['nodeDuration'] = {{0.4, 1.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.4, 1.33333333333333}, },
        },
    },
	--4
    ['LumiLayer_48-trs-blend'] = {
        ['nodeDuration'] = {{0.4, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.4, 1.33333333333333}, },
            ['baseTex'] = {{0.5333333333334, 1.6}, },
        },
    },
	['Lumi3DShape_4'] = {
        ['nodeDuration'] = {{0.4, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.4, 1.33333333333333}, },
        },
    },
    ['LumiLayer_153-trs-blend'] = {
        ['nodeDuration'] = {{0.2666666667, 1.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2666666667, 1.33333333333333}, },
            ['baseTex'] = {{0.2666666667, 1.33333333333333}, },
        },
    },
    ['LumiRoundCorner_49-effect0'] = {
        ['nodeDuration'] = {{0.2666666667, 1.33333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2666666667, 1.33333333333333}, },
        },
    },
	--3
    ['LumiLayer_49-trs-blend'] = {
        ['nodeDuration'] = {{0.2666666667, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2666666667, 1.33333333333333}, },
            ['baseTex'] = {{0.4, 1.6}, },
        },
    },
	['Lumi3DShape_3'] = {
        ['nodeDuration'] = {{0.2666666667, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2666666667, 1.6}, },
        },
    },
    ['LumiLayer_152-trs-blend'] = {
        ['nodeDuration'] = {{0.133333333334, 1.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.133333333334, 1.26666666666667}, },
            ['baseTex'] = {{0.133333333334, 1.26666666666667}, },
        },
    },
    ['LumiRoundCorner_50-effect0'] = {
        ['nodeDuration'] = {{0.133333333334, 1.26666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.133333333334, 1.26666666666667}, },
        },
    },
	--2
    ['LumiLayer_50-trs-blend'] = {
        ['nodeDuration'] = {{0.133333333334, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.133333333334, 1.26666666666667}, },
            ['baseTex'] = {{0.2666666667, 1.6}, },
        },
    },
	['Lumi3DShape_2'] = {
		['nodeDuration'] = {{0.133333333334, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.133333333334, 1.26666666666667}, },
        },
    },
    ['LumiLayer_149-trs-blend'] = {
        ['nodeDuration'] = {{0.02, 1.13333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.02, 1.13333333333333}, },
            ['baseTex'] = {{0.02, 1.13333333333333}, },
        },
    },
    ['LumiRoundCorner_51-effect0'] = {
        ['nodeDuration'] = {{0.02, 1.13333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.02, 1.13333333333333}, },
        },
    },
	--1
    ['LumiLayer_51-trs-blend'] = {
        ['nodeDuration'] = {{0.02, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.02, 1.13333333333333}, },
            ['baseTex'] = {{0.1, 1.6}, },
        },
    },
	['Lumi3DShape_1'] = {
		['nodeDuration'] = {{0.02, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.02, 1.13333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_155-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(463, 150, 0),
        ['position'] = Amaz.Vector3f(52.9545936938101, 540, 0),
        ['scale'] = Amaz.Vector3f(371, 371, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(926, 300),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'SoftLight',
    },
    ['LumiRoundCorner_47-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 3,
        ['fadeType'] = 0,
    },
    ['LumiLayer_47-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 226.787434034004,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(470.926345267332, 646.906101245584, 1963.85541928698),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -39.5779537512259,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 32.7329970639877,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_154-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(463, 150, 0),
        ['position'] = Amaz.Vector3f(348.925591499896, 540, 0),
        ['scale'] = Amaz.Vector3f(371, 371, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(926, 300),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'SoftLight',
    },
    ['LumiRoundCorner_48-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 3,
        ['fadeType'] = 0,
    },
    ['LumiLayer_48-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 184.242009102179,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(470.926345267332, 646.906101245584, 1963.85541928698),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -39.5779537512259,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 32.7329970639877,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_153-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(463, 150, 0),
        ['position'] = Amaz.Vector3f(772.217579751831, 540, 0),
        ['scale'] = Amaz.Vector3f(371, 371, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(926, 300),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'SoftLight',
    },
    ['LumiRoundCorner_49-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 3,
        ['fadeType'] = 0,
    },
    ['LumiLayer_49-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 132.539617070293,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(470.926345267332, 646.906101245584, 1963.85541928698),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -39.5779537512259,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 32.7329970639877,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_152-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(463, 150, 0),
        ['position'] = Amaz.Vector3f(-4, 540, 0),
        ['scale'] = Amaz.Vector3f(371, 371, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 50,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(926, 300),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'SoftLight',
    },
    ['LumiRoundCorner_50-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 3,
        ['fadeType'] = 0,
    },
    ['LumiLayer_50-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 81.5800658001364,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(470.926345267332, 646.906101245584, 1963.85541928698),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -39.5779537512259,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 32.7329970639877,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_149-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(463, 150, 0),
        ['position'] = Amaz.Vector3f(307.052417369826, 540, 0),
        ['scale'] = Amaz.Vector3f(371, 371, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(926, 300),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'SoftLight',
    },
    ['LumiRoundCorner_51-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 3,
        ['fadeType'] = 0,
    },
    ['LumiLayer_51-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(0, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 42.1026168625334,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(470.926345267332, 646.906101245584, 1963.85541928698),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = -39.5779537512259,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 32.7329970639877,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
	
	['Lumi3DShape_1'] = {
        ['position'] = Amaz.Vector3f(0, 0, 6.912),
		['xposition'] = 0,
		['yposition'] = 0,
        ['scale'] = Amaz.Vector3f(1, 1, 0),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] =0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {

	['Lumi3DShape_1#shapeint#number'] =
	{
		{{0.281638634, 0, 0.62820393, 1, }, {0.0333334, 0.433334, }, {{0.68, }, {3.5, }, }, {6417, }, {0, }, }, 
		{{0.299111249, 0, 0.568160024, 1, }, {0.433334, 1, }, {{3.5, }, {0, }, }, {6417, }, {0, }, }, 
	},
	['Lumi3DShape_2#shapeint#number'] =
	{
		{{0.281638634, 0, 0.62820393, 1, }, {0.166667, 0.5666667, }, {{0.68, }, {3.5, }, }, {6417, }, {0, }, }, 
		{{0.299111249, 0, 0.568160024, 1, }, {0.5666667, 1.1333334, }, {{3.5, }, {0, }, }, {6417, }, {0, }, }, 
	},
	['Lumi3DShape_3#shapeint#number'] =
	{
		{{0.281638634, 0, 0.62820393, 1, }, {0.3, 0.7, }, {{0.68, }, {3.5, }, }, {6417, }, {0, }, }, 
		{{0.299111249, 0, 0.568160024, 1, }, {0.7, 1.266667, }, {{3.5, }, {0, }, }, {6417, }, {0, }, }, 
	},
	['Lumi3DShape_4#shapeint#number'] =
	{
		{{0.281638634, 0, 0.62820393, 1, }, {0.4333334, 0.8333334, }, {{0.68, }, {3.5, }, }, {6417, }, {0, }, }, 
		{{0.299111249, 0, 0.568160024, 1, }, {0.8333334, 1.4, }, {{3.5, }, {0, }, }, {6417, }, {0, }, }, 
	},
	['Lumi3DShape_5#shapeint#number'] =
	{
		{{0.281638634, 0, 0.62820393, 1, }, {0.566667, 0.966667, }, {{0.68, }, {3.5, }, }, {6417, }, {0, }, }, 
		{{0.299111249, 0, 0.568160024, 1, }, {0.966667, 1.6, }, {{3.5, }, {0, }, }, {6417, }, {0, }, }, 
	},




	['LumiLayer_51-trs-blend#arrange#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.555, 0.556, }, 
			{{0, }, {1, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
	['LumiLayer_48-trs-blend#arrange#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.93, 0.931, }, 
			{{0, }, {1, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
	['LumiLayer_49-trs-blend#arrange#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.807, 0.808, }, 
			{{0, }, {1, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
	['LumiLayer_50-trs-blend#arrange#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.683, 0.684, }, 
			{{0, }, {1, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
	['LumiLayer_155-trs-blend#position#vector'] =
	{
		{
			{0.41, 0.064286, 0.77, 0.957143, }, 
			{0.566667, 1.066667, }, 
			{{0, 540, 0, }, {1080, 540, 0, }, {0, 540, 0, }, {1080, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
		{
			{0.166667, 0.166667, 0.833333, 0.833333, }, 
			{1.066667, 1.1, }, 
			{{1080, 540, 0, }, {86, 540, 0, }, {1080, 540, 0, }, {86, 540, 0, }, }, 
			{6413, }, 
			{1, }, 
		}, 
		{
			{0.001, 0, 0.58, 1, }, 
			{1.1, 1.566667, }, 
			{{86, 540, 0, }, {680, 540, 0, }, {86, 540, 0, }, {680, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_155-trs-blend#opacity#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.566667, 0.633333, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.633333, 1, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{1, 1.066667, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{1.066667, 1.133333, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{1.133333, 1.3, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{1.3, 1.566667, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
		['LumiRoundCorner_47-effect0#radius#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{1.3, 1.6, }, 
			{{50, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
		['LumiLayer_47-trs#yRotation#number'] =
	{
		{
			{0.34, 0.29, 0.43, 1, }, 
			{0.566667, 1.6, }, 
			{{242, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_47-trs#p0_xPosition#number'] =
	{
		{
			{0.4, 0, 0.47, 1, }, 
			{0, 1.3, }, 
			{{1085.446378, }, {0.00003, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_47-trs#p0_yPosition#number'] =
	{
		{
			{0.45, 0, 0.4, 1, }, 
			{0, 1.3, }, 
			{{800, }, {540, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_47-trs#p0_zPosition#number'] =
	{
		{
			{0.55, 0, 0.65, 0.97, }, 
			{0, 1.6, }, 
			{{2500, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_47-trs#p0_xRotation#number'] =
	{
		{
			{0.29326255, 0, 0.56274707, 1, }, 
			{0.433333, 1.6, }, 
			{{-44, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_47-trs#p0_rotation#number'] =
	{
		{
			{0.42, 0, 0.58, 1, }, 
			{0.566667, 1.6, }, 
			{{33, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_154-trs-blend#position#vector'] =
	{
		{
			{0.41, 0.06, 0.77, 0.96, }, 
			{0.433333, 0.9, }, 
			{{0, 540, 0, }, {1080, 540, 0, }, {0, 540, 0, }, {1080, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
		{
			{0.166667, 0.166667, 0.833333, 0.833333, }, 
			{0.9, 0.933333, }, 
			{{1080, 540, 0, }, {-4, 540, 0, }, {1080, 540, 0, }, {-4, 540, 0, }, }, 
			{6413, }, 
			{1, }, 
		}, 
		{
			{0.001, 0, 0.58, 1, }, 
			{0.933333, 1.366667, }, 
			{{-4, 540, 0, }, {680, 540, 0, }, {-4, 540, 0, }, {680, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_154-trs-blend#opacity#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.433333, 0.5, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.5, 0.833333, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.833333, 0.9, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.9, 0.966667, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.966667, 1.133333, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{1.133333, 1.366667, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
		['LumiLayer_48-trs-blend#yRotation#number'] =
	{
		{
			{0.34, 0.29, 0.5, 1, }, 
			{0.433333, 1.4, }, 
			{{244, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_48-trs-blend#p0_xPosition#number'] =
	{
		{
			{0.4, 0, 0.47, 1, }, 
			{0, 1.3, }, 
			{{1085.446378, }, {0.00003, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_48-trs-blend#p0_yPosition#number'] =
	{
		{
			{0.45, 0, 0.4, 1, }, 
			{0, 1.3, }, 
			{{800, }, {540, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_48-trs-blend#p0_zPosition#number'] =
	{
		{
			{0.55, 0, 0.65, 0.97, }, 
			{0, 1.6, }, 
			{{2500, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_48-trs-blend#p0_xRotation#number'] =
	{
		{
			{0.29326255, 0, 0.56274707, 1, }, 
			{0.433333, 1.6, }, 
			{{-44, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_48-trs-blend#p0_rotation#number'] =
	{
		{
			{0.42, 0, 0.58, 1, }, 
			{0.566667, 1.6, }, 
			{{33, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_153-trs-blend#position#vector'] =
	{
		{
			{0.41, 0.06, 0.77, 0.96, }, 
			{0.3, 0.766667, }, 
			{{0, 540, 0, }, {1080, 540, 0, }, {0, 540, 0, }, {1080, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
		{
			{0.166667, 0.166667, 0.833333, 0.833333, }, 
			{0.766667, 0.8, }, 
			{{1080, 540, 0, }, {-4, 540, 0, }, {1080, 540, 0, }, {-4, 540, 0, }, }, 
			{6413, }, 
			{1, }, 
		}, 
		{
			{0.001, 0, 0.58, 1, }, 
			{0.8, 1.233333, }, 
			{{-4, 540, 0, }, {680, 540, 0, }, {-4, 540, 0, }, {680, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_153-trs-blend#opacity#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.3, 0.366667, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.366667, 0.7, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.7, 0.766667, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.766667, 0.833333, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.833333, 1, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{1, 1.233333, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
		['LumiLayer_49-trs-blend#yRotation#number'] =
	{
		{
			{0.34, 0.29, 0.5, 1, }, 
			{0.3, 1.266667, }, 
			{{246, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_49-trs-blend#p0_xPosition#number'] =
	{
		{
			{0.4, 0, 0.47, 1, }, 
			{0, 1.3, }, 
			{{1085.446378, }, {0.00003, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_49-trs-blend#p0_yPosition#number'] =
	{
		{
			{0.45, 0, 0.4, 1, }, 
			{0, 1.3, }, 
			{{800, }, {540, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_49-trs-blend#p0_zPosition#number'] =
	{
		{
			{0.55, 0, 0.65, 0.97, }, 
			{0, 1.6, }, 
			{{2500, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_49-trs-blend#p0_xRotation#number'] =
	{
		{
			{0.29326255, 0, 0.56274707, 1, }, 
			{0.433333, 1.6, }, 
			{{-44, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_49-trs-blend#p0_rotation#number'] =
	{
		{
			{0.42, 0, 0.58, 1, }, 
			{0.566667, 1.6, }, 
			{{33, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_152-trs-blend#position#vector'] =
	{
		{
			{0.41, 0.06, 0.77, 0.96, }, 
			{0.133333, 0.6, }, 
			{{0, 540, 0, }, {1080, 540, 0, }, {0, 540, 0, }, {1080, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
		{
			{0.166667, 0.166667, 0.833333, 0.833333, }, 
			{0.6, 0.633333, }, 
			{{1080, 540, 0, }, {-4, 540, 0, }, {1080, 540, 0, }, {-4, 540, 0, }, }, 
			{6413, }, 
			{1, }, 
		}, 
		{
			{0.001, 0, 0.58, 1, }, 
			{0.633333, 1.066667, }, 
			{{-4, 540, 0, }, {680, 540, 0, }, {-4, 540, 0, }, {680, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_152-trs-blend#opacity#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.133333, 0.2, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.2, 0.533333, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.533333, 0.6, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.6, 0.666667, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.666667, 0.833333, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.833333, 1.066667, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
		['LumiLayer_50-trs-blend#yRotation#number'] =
	{
		{
			{0.34, 0.29, 0.5, 1, }, 
			{0.166667, 1.133333, }, 
			{{247, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_50-trs-blend#p0_xPosition#number'] =
	{
		{
			{0.4, 0, 0.47, 1, }, 
			{0, 1.3, }, 
			{{1085.446378, }, {0.00003, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_50-trs-blend#p0_yPosition#number'] =
	{
		{
			{0.45, 0, 0.4, 1, }, 
			{0, 1.3, }, 
			{{800, }, {540, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_50-trs-blend#p0_zPosition#number'] =
	{
		{
			{0.55, 0, 0.65, 0.97, }, 
			{0, 1.6, }, 
			{{2500, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_50-trs-blend#p0_xRotation#number'] =
	{
		{
			{0.29326255, 0, 0.56274707, 1, }, 
			{0.433333, 1.6, }, 
			{{-44, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_50-trs-blend#p0_rotation#number'] =
	{
		{
			{0.42, 0, 0.58, 1, }, 
			{0.566667, 1.6, }, 
			{{33, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_149-trs-blend#position#vector'] =
	{
		{
			{0.41, 0.06, 0.77, 0.96, }, 
			{0, 0.466667, }, 
			{{0, 540, 0, }, {1080, 540, 0, }, {0, 540, 0, }, {1080, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
		{
			{0.166667, 0.166667, 0.833333, 0.833333, }, 
			{0.466667, 0.5, }, 
			{{1080, 540, 0, }, {-4, 540, 0, }, {1080, 540, 0, }, {-4, 540, 0, }, }, 
			{6413, }, 
			{1, }, 
		}, 
		{
			{0.001, 0, 0.58, 1, }, 
			{0.5, 0.933333, }, 
			{{-4, 540, 0, }, {680, 540, 0, }, {-4, 540, 0, }, {680, 540, 0, }, }, 
			{6413, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_149-trs-blend#opacity#number'] =
	{
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0, 0.066667, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.066667, 0.4, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.4, 0.466667, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.466667, 0.533333, }, 
			{{0, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.533333, 0.7, }, 
			{{100, }, {100, }, }, 
			{6417, }, 
			{1, }, 
		}, 
		{
			{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
			{0.7, 0.933333, }, 
			{{100, }, {0, }, }, 
			{6417, }, 
			{1, }, 
		}, 
	},
		['LumiLayer_51-trs-blend#yRotation#number'] =
	{
		{
			{0.34, 0.28768, 0.5, 1, }, 
			{0.033333, 1, }, 
			{{250, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_51-trs-blend#p0_xPosition#number'] =
	{
		{
			{0.4, 0, 0.47, 1, }, 
			{0, 1.3, }, 
			{{1085.446378, }, {0.00003, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_51-trs-blend#p0_yPosition#number'] =
	{
		{
			{0.45, 0, 0.4, 1, }, 
			{0, 1.3, }, 
			{{800, }, {540, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_51-trs-blend#p0_zPosition#number'] =
	{
		{
			{0.55, 0, 0.65, 0.97, }, 
			{0, 1.6, }, 
			{{2500, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_51-trs-blend#p0_xRotation#number'] =
	{
		{
			{0.29326255, 0, 0.56274707, 1, }, 
			{0.433333, 1.6, }, 
			{{-44, }, {0, }, }, 
			{6417, }, 
			{0, }, 
		}, 
	},
		['LumiLayer_51-trs-blend#p0_rotation#number'] =
	{
		{
			{0.42, 0, 0.58, 1, }, 
			{0.566667, 1.6, }, 
			{{33, }, {0, }, }, 
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
