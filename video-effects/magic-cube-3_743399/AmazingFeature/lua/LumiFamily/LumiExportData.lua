local data = {}

local ae_compDurations = {0, 1.1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_87-trs', 'InputTex', 0},
    {'LumiLayer_55-matte', 'InputTex', 0},
    {'LumiLayer_88-trs', 'InputTex', 0},
    {'LumiLayer_67-trs-matte', 'InputTex', 0},
    {'LumiLayer_83-trs', 'InputTex', 0},
    {'LumiLayer_85-trs-matte', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_87-trs'] = {
        ['nodeDuration'] = {{0.1, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 1.1}, },
        },
    },
    ['LumiLayer_55-matte'] = {
        ['nodeDuration'] = {{0.1, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 1.1}, },
            ['maskTex'] = {{0.1, 1.1}, },
        },
    },
    ['Lumi3DShape_79-effect0'] = {
        ['nodeDuration'] = {{0.1, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 1.1}, },
        },
    },
	['Lumi3DShape_79-effect1'] = {
        ['nodeDuration'] = {{0.1, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 1.1}, },
        },
    },
	['Lumi3DShape_79-effect2'] = {
        ['nodeDuration'] = {{0.1, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 1.1}, },
        },
    },
    ['LumiLayer_88-trs'] = {
        ['nodeDuration'] = {{0.2, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2, 1.1}, },
        },
    },
    ['LumiLayer_67-trs-matte'] = {
        ['nodeDuration'] = {{0.2, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2, 1.1}, },
            ['maskTex'] = {{0.2, 1.1}, },
        },
    },
    ['Lumi3DShape_80-effect0'] = {
        ['nodeDuration'] = {{0.2, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2, 1.1}, },
        },
    },
    ['Lumi3DShape_80-effect1'] = {
        ['nodeDuration'] = {{0.2, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2, 1.1}, },
        },
    },
    ['Lumi3DShape_80-effect3'] = {
        ['nodeDuration'] = {{0.2, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2, 1.1}, },
        },
    },
    ['Lumi3DShape_80-effect2'] = {
        ['nodeDuration'] = {{0.2, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2, 1.1}, },
        },
    },
    ['LumiLayer_83-trs'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
        },
    },
    ['LumiLayer_85-trs-matte'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
            ['maskTex'] = {{0, 1.1}, },
        },
    },
    ['Lumi3DShape_81-effect0'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
        },
    },
    ['Lumi3DShape_81-effect1'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
        },
    },
	['Lumi3DShape_81-effect2'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
        },
    },
	['Lumi3DShape_81-effect3'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
        },
    },
    ['LumiLayer_81-blend'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
            ['baseTex'] = {{0.2, 1.1}, },
        },
    },
    ['LumiLayer_79-blend'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.1, 1.1}, },
            ['baseTex'] = {{0, 1.1}, },
        },
    },
    ['LumiDeepGlow_92-effect0'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
        },
    },
    ['LumiLayer_92-blend'] = {
        ['nodeDuration'] = {{0, 1.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.1}, },
            ['baseTex'] = {{0, 1.1}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_87-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 33.5, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
		
    },
    ['LumiLayer_55-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 'Alpha',
    },
    ['Lumi3DShape_79-effect0'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 6,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = -0.0,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -170.056916387833,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
	['Lumi3DShape_79-effect1'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 6,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 0,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -170.056916387833,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
	['Lumi3DShape_79-effect2'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 6,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 0,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -170.056916387833,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
    ['LumiLayer_88-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 33.34, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_67-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 180, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Alpha',
    },
    ['Lumi3DShape_80-effect0'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 5.62590717970855,
        ['meshSize_y'] = 1.82698207061521,
        ['meshSize_z'] = 1.82698207061521,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = -2,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -239.094442187372,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
    ['Lumi3DShape_80-effect1'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 5.62590717970855,
        ['meshSize_y'] = 1.82698207061521,
        ['meshSize_z'] = 1.82698207061521,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = -2,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -239.094442187372,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
    ['Lumi3DShape_80-effect3'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 5.62590717970855,
        ['meshSize_y'] = 1.82698207061521,
        ['meshSize_z'] = 1.82698207061521,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = -2,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -239.094442187372,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
		['cubeTypeNumber'] = 0
    },
    ['Lumi3DShape_80-effect2'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 5.62590717970855,
        ['meshSize_y'] = 1.82698207061521,
        ['meshSize_z'] = 1.82698207061521,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = -2,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -239.094442187372,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
    ['LumiLayer_83-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 33.34, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_85-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 900, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Alpha',
    },
    ['Lumi3DShape_81-effect0'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 6,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 2,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -92.4135956203316,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
    ['Lumi3DShape_81-effect1'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 6,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 2,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -92.4135956203316,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
	['Lumi3DShape_81-effect2'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 6,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 2,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -92.4135956203316,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
	['Lumi3DShape_81-effect3'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 6,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 2,
        ['Position_z'] = -9.29132155497197,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 1,
        ['Rotate_x'] = 0,
        ['Rotate_y'] = -92.4135956203316,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 0,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
		['cubeTypeNumber'] = 0
    },
    ['LumiLayer_81-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_79-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
    ['LumiDeepGlow_92-effect0'] = {
        ['radius'] = 280,
        ['exposure'] = 0.8399909432666,
        ['threshold'] = 0.5,
        ['thresholdSmooth'] = 0.5,
        ['blendMode'] = 1,
        ['view'] = 1,
        ['ratio'] = 1.1,
        ['rotate'] = 0,
        ['ca'] = false,
        ['redOffset'] = 0.0025,
        ['greenOffset'] = 0,
        ['blueOffset'] = -0.0025,
        ['tint'] = false,
        ['tintMode'] = 1,
        ['tintColor'] = Amaz.Color(1, 0, 0, 1),
        ['tintMix'] = 1,
        ['sourceOpacity'] = 1,
        ['unmult'] = true,
        ['gammaCorrect'] = true,
        ['gammaValue'] = 2,
        ['glowIter'] = 7,
        ['stepsMult'] = 1.5,
        ['downSample'] = 0.80000001192093,
        ['quality'] = 0.5,
    },
    ['LumiLayer_92-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
	['Lumi3DShape_79-effect0#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
	['Lumi3DShape_79-effect1#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
	['Lumi3DShape_79-effect2#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},

['Lumi3DShape_80-effect0#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
	['Lumi3DShape_80-effect1#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
	['Lumi3DShape_80-effect2#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
['Lumi3DShape_80-effect3#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},

['Lumi3DShape_81-effect0#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
	['Lumi3DShape_81-effect1#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
	['Lumi3DShape_81-effect2#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
['Lumi3DShape_81-effect3#frame#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.933334, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},


-- ['Lumi3DShape_80-effect0#endCubeType#number'] =
-- {
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.0,0.933334, }, 
-- 		{{-1, }, {-1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.933334, 1.1, }, 
-- 		{{1, }, {1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- },
-- ['Lumi3DShape_81-effect0#endCubeType#number'] =
-- {
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.0,0.933334, }, 
-- 		{{-1, }, {-1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.933334, 1.1, }, 
-- 		{{1, }, {1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- },
-- ['Lumi3DShape_79-effect0#endCubeType#number'] =
-- {
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.0,0.933334, }, 
-- 		{{-1, }, {-1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.933334, 1.1, }, 
-- 		{{1, }, {1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- },




-- ['Lumi3DShape_80-effect3#endCubeType#number'] =
-- {
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.0,0.933334, }, 
-- 		{{-1, }, {-1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.933334, 1.1, }, 
-- 		{{1, }, {1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- },
-- ['Lumi3DShape_81-effect3#endCubeType#number'] =
-- {
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.0,0.933334, }, 
-- 		{{-1, }, {-1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.933334, 1.1, }, 
-- 		{{1, }, {1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- },
-- ['Lumi3DShape_79-effect2#endCubeType#number'] =
-- {
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.0,0.933334, }, 
-- 		{{-1, }, {-1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- 	{
-- 		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
-- 		{0.933334, 1.1, }, 
-- 		{{1, }, {1, }, }, 
-- 		{6417, }, 
-- 		{1, }, 
-- 	}, 
-- },




    ['Lumi3DShape_79-effect0#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_79-effect0#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_79-effect0#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},



    ['Lumi3DShape_79-effect0#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.33, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
    
},
    ['Lumi3DShape_79-effect0#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	
},
    ['Lumi3DShape_79-effect0#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},



    ['Lumi3DShape_79-effect0#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},

    ['Lumi3DShape_79-effect0#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0.1, 1, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
['Lumi3DShape_79-effect1#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_79-effect1#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_79-effect1#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},



    ['Lumi3DShape_79-effect1#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.33, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
    
},
    ['Lumi3DShape_79-effect1#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 

	
},
    ['Lumi3DShape_79-effect1#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
['Lumi3DShape_79-effect2#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_79-effect2#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_79-effect2#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},



    ['Lumi3DShape_79-effect2#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.33, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
    
},
    ['Lumi3DShape_79-effect2#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 

	
},
    ['Lumi3DShape_79-effect2#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.1, 0.366667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},



    ['Lumi3DShape_79-effect2#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},

    ['Lumi3DShape_79-effect2#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0.1, 1, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},


    ['Lumi3DShape_79-effect1#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},

    ['Lumi3DShape_79-effect1#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0.1, 1, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect0#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect0#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect0#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},


    ['Lumi3DShape_80-effect0#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.33, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_80-effect0#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1., }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.0, 1.1, }, 
		{{1, }, {1.0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_80-effect0#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},





    ['Lumi3DShape_80-effect0#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect0#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0.2, 1.1, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},









['Lumi3DShape_80-effect1#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect1#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect1#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},


    ['Lumi3DShape_80-effect1#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.33, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_80-effect1#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_80-effect1#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},





    ['Lumi3DShape_80-effect1#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect1#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0.2, 1.1, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
	['Lumi3DShape_80-effect3#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect3#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect3#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},


    ['Lumi3DShape_80-effect3#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.33, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_80-effect3#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_80-effect3#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},





    ['Lumi3DShape_80-effect3#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect3#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0.2, 1.1, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},



['Lumi3DShape_80-effect2#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect2#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect2#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},


    ['Lumi3DShape_80-effect2#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.33, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_80-effect2#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_80-effect2#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.2, 0.466667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},





    ['Lumi3DShape_80-effect2#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_80-effect2#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0.2, 1.1, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},



['Lumi3DShape_81-effect0#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect0#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect0#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},






    ['Lumi3DShape_81-effect0#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.3333, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_81-effect0#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_81-effect0#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},







    ['Lumi3DShape_81-effect0#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect0#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0, 0.9, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},











['Lumi3DShape_81-effect1#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect1#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect1#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
	['Lumi3DShape_81-effect1#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.3333, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_81-effect1#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_81-effect1#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},







    ['Lumi3DShape_81-effect1#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect1#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0, 0.9, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
['Lumi3DShape_81-effect2#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.3333, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
['Lumi3DShape_81-effect3#Scale_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.3333, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
['Lumi3DShape_81-effect2#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect2#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect2#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
['Lumi3DShape_81-effect2#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_81-effect2#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},







    ['Lumi3DShape_81-effect2#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect2#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0, 0.9, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},

['Lumi3DShape_81-effect3#meshSize_x#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{2, }, {6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect3#meshSize_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect3#meshSize_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.15, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
['Lumi3DShape_81-effect3#Scale_y#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1., 1.1, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['Lumi3DShape_81-effect3#Scale_z#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0, 0.266667, }, 
		{{0.07, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},







    ['Lumi3DShape_81-effect3#Position_z#number'] =
{
	{
		{0.6, 0, 0.35, 1, }, 
		{0, 1.1, }, 
		{{-10.196, }, {-6.196, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_81-effect3#Rotate_y#number'] =
{
	{
		{0.47, 0, 0.2, 1, }, 
		{0, 0.9, }, 
		{{-273, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDeepGlow_92-effect0#quality#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 0.5, }, 
		{{0.5, }, {0.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 1, }, 
		{{0.2, }, {0.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
['LumiDeepGlow_92-effect0#exposure#number'] =
{
	{
		{0.62201602, 0.190441643, 0.901590384, 1, }, 
		{0.266667, 0.5, }, 
		{{0.66, }, {1., }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.152538049, 0, 0.419088566, 1, }, 
		{0.5, 1, }, 
		{{1., }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
['Lumi3DShape_81-effect3#cubeTypeNumber#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333,}, 
		{0.2, 0.268, }, 
		{{3, }, {3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333,}, 
		{0.268, 0.278, }, 
		{{45, }, {50, }, },  
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.278, 0.285, }, 
		{{5, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.285, 0.3, }, 
		{{4, }, {4, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.3, 0.31, }, 
		{{25, }, {30, }, },  
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.31, 0.59, }, 
		{{2, }, {2, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.59, 0.675, }, 
		{{35, }, {40, }, },  
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.675, 0.84, }, 
		{{4.0, }, {4.0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.84, 1.1, }, 
		{{4.5, }, {4.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
['Lumi3DShape_80-effect3#cubeTypeNumber#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333,}, 
		{0.2, 0.466667, }, 
		{{3, }, {3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
    {
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 0.475, }, 
		{{15, }, {20, }, },  
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.475, 0.5, }, 
		{{5, }, {5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 0.512, }, 
		{{25, }, {30, }, },  
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.512, 0.78, }, 
		{{2.5, }, {2.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.78, 0.851, }, 
		{{35, }, {40, }, },  
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.851, 1.1, }, 
		{{4.5, }, {4.5, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
['Lumi3DShape_79-effect2#cubeTypeNumber#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333,}, 
		{0.2, 0.37, }, 
		{{3, }, {3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333,}, 
		{0.37, 0.376, }, 
		{{15, }, {20, }, },  
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.376, 0.39, }, 
		{{4, }, {4, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.39, 0.398, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.398, 0.41, }, 
		{{25, }, {30, }, },  
		{6417, }, 
		{1, }, 
	}, 
	
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.41, 0.69, }, 
		{{2.0, }, {2.0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	-- {
	-- 	{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
	-- 	{0.69, 0.69, }, 
	-- 	{{2.0, }, {2.0, }, }, 
	-- 	{6417, }, 
	-- 	{1, }, 
	-- }, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.69, 0.765, }, 
		{{35.0, }, {40.0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.755, 0.85, }, 
		{{0.0, }, {0.0, }, }, 
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
