local data = {}

local ae_compDurations = {0, 1.83333333333333}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_69-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_166-trs-matte'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['maskTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_86-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_182-trs-matte'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['maskTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_103-trs'] = {
        ['nodeDuration'] = {{0.83333333333333, 2.375}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_104-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0.83333333333333, 2.375}, },
        },
    },
    ['LumiLayer_51-trs'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_196-trs-matte'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['maskTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_105-trs-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_27-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.83333333333333}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
    ['LumiGlow_201-effect0'] = {
        ['nodeDuration'] = {{0.625, 1.125}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 3}, },
        },
    },
    ['LumiLayer_201-blend'] = {
        ['nodeDuration'] = {{0, 3}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.625, 1.125}, },
            ['baseTex'] = {{0, 3}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_69-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(270, 160, 0),
        ['position'] = Amaz.Vector3f(270, 488, 0),
        ['scale'] = Amaz.Vector3f(100, 115, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 320),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_166-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(270, 480, 0),
        ['position'] = Amaz.Vector3f(102, -84, 0),
        ['scale'] = Amaz.Vector3f(243, 243, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 960),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
    },
    ['LumiLayer_86-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(270, 160, 0),
        ['position'] = Amaz.Vector3f(270, 800, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 320),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_182-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(270, 480, 0),
        ['position'] = Amaz.Vector3f(400, 652, 0),
        ['scale'] = Amaz.Vector3f(233, 233, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 960),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
    },
    ['LumiLayer_103-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(270, 480, 0),
        ['position'] = Amaz.Vector3f(270, 480, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 960),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_104-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(270, 480, 0),
        ['position'] = Amaz.Vector3f(270, 480, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_51-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(270, 160, 0),
        ['position'] = Amaz.Vector3f(270, 149, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 320),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_196-trs-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(270, 480, 0),
        ['position'] = Amaz.Vector3f(170, 392, 0),
        ['scale'] = Amaz.Vector3f(200, 200, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 960),
        ['mirrorEdge'] = false,
        ['matteMode'] = 'Luma',
    },
    ['LumiLayer_105-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(270, 480, 0),
        ['position'] = Amaz.Vector3f(270, 480, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(540, 960),
        ['layerSize'] = Amaz.Vector2f(540, 960),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Normal',
    },
    ['LumiLayer_27-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 'Normal',
    },
    ['LumiGlow_201-effect0'] = {
        ['threshold'] = 0.45,
        ['radius'] = 50,
        ['glowIntensity'] = 0,
        ['blendMode'] = 0,
        ['show'] = 0,
        ['glowColor'] = 0,
        ['colorLooping'] = 0,
        ['colorLoops'] = 1,
        ['colorPhase'] = 0,
        ['midpoint'] = 0.5,
        ['colorA'] = Amaz.Color(1, 1, 1, 1),
        ['colorB'] = Amaz.Color(0, 0, 0, 1),
        ['glowDimensions'] = 0,
        ['quality'] = NaN,
    },
    ['LumiLayer_201-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_103-trs#position#vector'] =
{
	{
		{0.859375, 0.013021, 0.666667, 1, }, 
		{1.416667, 1.708333, }, 
		{{270, 480, 0, }, {270, -1652, 0, }, {270, 124.666656494141, 0, }, {270, -1296.66665649414, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_104-trs-blend#position#vector'] =
{
	{
		{0.859375, 0.013021, 0.666667, 1, }, 
		{1.416667, 1.708333, }, 
		{{270, 480, 0, }, {270, -354, 0, }, {270, 341, 0, }, {270, -215, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs-blend#position#vector'] =
{
	{
		{0.859375, 0.013021, 0.666667, 1, }, 
		{1.416667, 1.708333, }, 
		{{270, 480, 0, }, {270, 150, 0, }, {270, 425, 0, }, {270, 205, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiGlow_201-effect0#threshold#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.625, 0.833333, }, 
		{{0.45, }, {0.11, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.833333, 1.125, }, 
		{{0.11, }, {0.55, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGlow_201-effect0#glowIntensity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.625, 0.833333, }, 
		{{0, }, {0.68, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.833333, 1.125, }, 
		{{0.68, }, {0, }, }, 
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
