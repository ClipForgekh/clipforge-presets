local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_33-trs'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_32-trs'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_37-trs-matte'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['maskTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_71-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_43-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
            ['maskTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_73-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_34-trs'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_46-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
            ['maskTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_75-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_35-trs'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_49-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
            ['maskTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_77-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_36-trs'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_52-matte-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
            ['maskTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_79-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.8}, },
            ['baseTex'] = {{0, 1.8}, },
        },
    },
    ['LumiLayer_67-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.1}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.66666666666667, 2.1}, },
            ['baseTex'] = {{0, 1.8}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_33-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(20, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(324, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_32-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(20, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(108, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_37-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(972, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(108, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
    },
    ['LumiLayer_71-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(108, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 2,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_43-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(756, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(324, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_73-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(324, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_34-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(20, 100, 100),
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
    ['LumiLayer_46-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_75-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_35-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(20, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(756, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_49-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_77-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(756, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_36-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(20, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['p0_position'] = Amaz.Vector3f(972, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_52-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 0,
        ['blendMode'] = 0,
    },
    ['LumiLayer_79-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(972, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_67-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
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
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_33-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0,0.33333333, 0.66666667,0.66666667,0.66666667, 0.66666667,1,0.66666667, }, 
		{0.24694, 0.956771, }, 
		{{20, 50, 100, }, {20, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_33-trs#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.24694, 0.956771, }, 
		{{1209, 540, 0, }, {324, 540, 0, }, {1209, 540, 0, }, {324, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0,0.33333333, 0.66666667,0.66666667,0.66666667, 0.66666667,1,0.66666667, }, 
		{0, 0.709896, }, 
		{{20, 50, 100, }, {20, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.709896, }, 
		{{1215, 540, 0, }, {108, 540, 0, }, {1215, 540, 0, }, {108, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_37-trs-matte#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.709896, }, 
		{{1215, 540, 0, }, {108, 540, 0, }, {1215, 540, 0, }, {108, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_71-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.709896, }, 
		{{1215, 540, 0, }, {108, 540, 0, }, {1215, 540, 0, }, {108, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_43-trs-matte-blend#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.24694, 0.956771, }, 
		{{1209, 540, 0, }, {324, 540, 0, }, {1209, 540, 0, }, {324, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_73-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.24694, 0.956771, }, 
		{{1209, 540, 0, }, {324, 540, 0, }, {1209, 540, 0, }, {324, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_34-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.493815, 1.203711, }, 
		{{1204, 540, 0, }, {540, 540, 0, }, {1204, 540, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_34-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0,0.33333333, 0.66666667,0.66666667,0.66666667, 0.66666667,1,0.66666667, }, 
		{0.493815, 1.203711, }, 
		{{20, 50, 100, }, {20, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_75-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.493815, 1.203711, }, 
		{{1204, 540, 0, }, {540, 540, 0, }, {1204, 540, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_35-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0,0.33333333, 0.66666667,0.66666667,0.66666667, 0.66666667,1,0.66666667, }, 
		{0.740755, 1.450586, }, 
		{{20, 50, 100, }, {20, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_35-trs#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.740755, 1.450586, }, 
		{{1215, 540, 0, }, {756, 540, 0, }, {1215, 540, 0, }, {756, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_77-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.740755, 1.450586, }, 
		{{1215, 540, 0, }, {756, 540, 0, }, {1215, 540, 0, }, {756, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_36-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0,0.33333333, 0.66666667,0.66666667,0.66666667, 0.66666667,1,0.66666667, }, 
		{0.98763, 1.666667, }, 
		{{20, 50, 100, }, {20, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_36-trs#p0_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.98763, 1.666667, }, 
		{{1224, 540, 0, }, {972, 540, 0, }, {1224, 540, 0, }, {972, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_79-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.98763, 1.666667, }, 
		{{1224, 540, 0, }, {972, 540, 0, }, {1224, 540, 0, }, {972, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_67-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.666667, 1.733333, }, 
		{{0, }, {100, }, }, 
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
