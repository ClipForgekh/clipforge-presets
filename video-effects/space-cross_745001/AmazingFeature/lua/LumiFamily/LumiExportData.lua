local data = {}

local ae_compDurations = {0, 1.375}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_86-effect0'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_85-effect0'] = {
        ['nodeDuration'] = {{0, 0.95833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.95833333333333}, },
        },
    },
    ['LumiLayer_85-trs'] = {
        ['nodeDuration'] = {{0, 0.95833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.95833333333333}, },
        },
    },
    ['LumiLayer_86-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.375}, },
            ['baseTex'] = {{0, 0.95833333333333}, },
        },
    },
    ['LumiRoundCorner_89-effect0'] = {
        ['nodeDuration'] = {{0, 1.25}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.25}, },
        },
    },
    ['LumiLayer_89-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.25}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_90-effect0'] = {
        ['nodeDuration'] = {{0, 1.20833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.20833333333333}, },
        },
    },
    ['LumiLayer_90-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.20833333333333}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_93-effect0'] = {
        ['nodeDuration'] = {{0, 1.25}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.25}, },
        },
    },
    ['LumiLayer_93-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.25}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_217-effect0'] = {
        ['nodeDuration'] = {{0, 1.20833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.20833333333333}, },
        },
    },
    ['LumiLayer_217-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.20833333333333}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_95-effect0'] = {
        ['nodeDuration'] = {{0, 0.95833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.95833333333333}, },
        },
    },
    ['LumiLayer_95-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.95833333333333}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_106-effect0'] = {
        ['nodeDuration'] = {{0, 1.20833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.20833333333333}, },
        },
    },
    ['LumiLayer_106-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.20833333333333}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_108-effect0'] = {
        ['nodeDuration'] = {{0, 0.91666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.91666666666667}, },
        },
    },
    ['LumiLayer_108-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.91666666666667}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_111-effect0'] = {
        ['nodeDuration'] = {{0, 1.125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.125}, },
        },
    },
    ['LumiLayer_111-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.125}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
    ['LumiRoundCorner_221-effect0'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.375}, },
        },
    },
    ['LumiLayer_221-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.375}, },
            ['baseTex'] = {{0, 1.375}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_86-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiRoundCorner_85-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_85-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(789, 711, 1383),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_86-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(606, 711, 1428),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_89-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_89-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(57, 711, 1921),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_90-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_90-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(972, 562, 866),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_93-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_93-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(675, 340, 802),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_217-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_217-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(423, 562, 802),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_95-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_95-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(57, 562, 1698),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_106-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_106-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(240, 264, 1699),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_108-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_108-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(972, 115, 1320),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_111-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_111-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(423, 115, 1803),
        ['scale'] = Amaz.Vector3f(20, 20, 20),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiRoundCorner_221-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 0,
        ['fadeType'] = 0,
    },
    ['LumiLayer_221-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 480, 0),
        ['position'] = Amaz.Vector3f(480, 480, -1038.58751649396),
        ['scale'] = Amaz.Vector3f(7, 7, 7),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(960, 960),
        ['layerSize'] = Amaz.Vector2f(960, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_85-trs#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.083333, 1.291667, }, 
		{{789, 711, 1383, }, {789, 711, -1381, }, {789, 711, 922.333343505859, }, {789, 711, -1381, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.291667, 1.458333, }, 
		{{789, 711, -1381, }, {789, 711, 1383, }, {789, 711, -1381, }, {789, 711, 1383, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.458333, 2.666667, }, 
		{{789, 711, 1383, }, {789, 711, -1381, }, {789, 711, 1383, }, {789, 711, -920.333343505859, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_85-trs#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.083333, 0.416667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.416667, 1.291667, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.291667, 1.333333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.333333, 1.458333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.458333, 1.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_86-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.416667, 1.291667, }, 
		{{606, 711, 1428, }, {606, 711, -1312, }, {606, 711, 971.333343505859, }, {606, 711, -855.333343505859, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_86-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.416667, 0.75, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.75, 1.291667, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.291667, 1.333333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_89-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.291667, 1.291667, }, 
		{{57, 711, 1921, }, {57, 711, -527.822201719, }, {57, 711, 1536.55520629883, }, {57, 711, 253.036379823969, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.291667, 3.083333, }, 
		{{57, 711, -527.822201719, }, {57, 711, -527.822201719, }, {57, 711, -748.650830259039, }, {57, 711, 253.036379823969, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_89-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.291667, 0.625, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_90-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.583333, 1.25, }, 
		{{972, 562, 866, }, {972, 562, -351.648878408, }, {972, 562, 666.842544555664, }, {972, 562, 144.193284677938, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_90-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.583333, 0.916667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.916667, 1.25, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.25, 1.291667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_93-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.291667, 1.5, }, 
		{{675, 340, 802, }, {675, 340, -1225, }, {675, 340, 464.166656494141, }, {675, 340, -887.166656494141, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_93-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.291667, 0.625, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_217-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.166667, 1.25, }, 
		{{423, 562, 802, }, {423, 562, -1225, }, {423, 562, 464.166656494141, }, {423, 562, -887.166656494141, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_217-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.5, 1.041667, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.041667, 1.125, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_95-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0, 0.916667, }, 
		{{57, 562, 1698, }, {57, 562, -457.235673699, }, {57, 562, 1359.52969360352, }, {57, 562, 295.216901984594, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_95-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.333333, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.916667, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.916667, 0.958333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_106-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.541667, 1.208333, }, 
		{{240, 264, 1699, }, {240, 264, -569, }, {240, 264, 1569.75132751465, }, {240, 264, -569, }, }, 
		{6413, }, 
		{1, }, 
	}, 
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{1.208333, 3.041667, }, 
		{{240, 264, -569, }, {240, 264, -569, }, {240, 264, -569, }, {240, 264, -569, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_106-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.541667, 0.875, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.875, 1.208333, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_108-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.333333, 1.541667, }, 
		{{972, 115, 1320, }, {972, 115, -1048, }, {972, 115, 925.333343505859, }, {972, 115, -653.333343505859, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_108-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.666667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_111-trs-blend#position#vector'] =
{
	{
		{0.166667, 0.166667, 0.833333, 0.833333, }, 
		{0.208333, 1.416667, }, 
		{{423, 115, 1803, }, {423, 115, -1376, }, {423, 115, 1273.16668701172, }, {423, 115, -846.166687011719, }, }, 
		{6413, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_111-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.208333, 0.541667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiRoundCorner_221-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.166667, 1.208333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_221-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.495239, }, 
		{{480, 480, -1038.587516494, }, {480, 480, -1094.587516494, }, {480, 480, -1047.92084950944, }, {480, 480, -1094.587516494, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0, 0.833333, 1, }, 
		{0.495239, 0.914266, }, 
		{{480, 480, -1094.587516494, }, {480, 480, -1038.587516494, }, {480, 480, -1094.587516494, }, {480, 480, -1014.337516494, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.833333, 1, }, 
		{0.914266, 1.208333, }, 
		{{480, 480, -1038.587516494, }, {480, 480, -1240.087516494, }, {480, 480, -1062.837516494, }, {480, 480, -1206.50418443223, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_221-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.133341, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.133341, 1.125, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.125, 1.175008, }, 
		{{100, }, {100, }, }, 
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
