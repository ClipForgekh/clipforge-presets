local data = {}

local ae_compDurations = {0, 2.45833333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_85-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_27-trs-matte'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_93-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_100-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['baseTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_86-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_99-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['baseTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_87-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_98-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['baseTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_88-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_97-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['baseTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_89-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_101-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['baseTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_90-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_96-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['baseTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_91-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_95-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['baseTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_92-trs'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
        },
    },
    ['LumiLayer_94-trs-matte-blend'] = {
        ['nodeDuration'] = {{0, 2.45833333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.45833333333333}, },
            ['baseTex'] = {{0, 2.45833333333333}, },
            ['maskTex'] = {{0, 2.45833333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_85-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(919.5, 270, 0),
        ['scale'] = Amaz.Vector3f(101, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_27-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
    },
    ['LumiLayer_93-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(812.175, 270, 0),
        ['scale'] = Amaz.Vector3f(101, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_100-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_86-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(696.25, 270, 0),
        ['scale'] = Amaz.Vector3f(118, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_99-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_87-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(580.125, 270, 0),
        ['scale'] = Amaz.Vector3f(101, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_98-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_88-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(474, 270, 0),
        ['scale'] = Amaz.Vector3f(101, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_97-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_89-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(368.375, 270, 0),
        ['scale'] = Amaz.Vector3f(101, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_101-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_90-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(254.75, 270, 0),
        ['scale'] = Amaz.Vector3f(118, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_96-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_91-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(140.125, 270, 0),
        ['scale'] = Amaz.Vector3f(101, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_95-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_92-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(53.5, 270, 0),
        ['position'] = Amaz.Vector3f(35.5, 270, 0),
        ['scale'] = Amaz.Vector3f(101, 101, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(107, 540),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_94-trs-matte-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(480, 270, 0),
        ['position'] = Amaz.Vector3f(480, 270, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(960, 540),
        ['layerSize'] = Amaz.Vector2f(960, 540),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_27-trs-matte#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{2.083333, 2.106771, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_100-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.583333, 0.606771, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_99-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.5, 1.523438, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_98-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.023438, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_97-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.216146, 1.239583, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_101-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.291667, 0.315104, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_96-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.791667, 1.815104, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_95-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.875, 0.898438, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_94-trs-matte-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{2.375, 2.398438, }, 
		{{100, }, {0, }, }, 
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
