local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiGeometry_105-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiGeometry_105-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_105-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBokehBlur_104-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiSaturation_104-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBrightness_104-effect3'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_104-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_103-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.03333333333333, 1.2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_102-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.4, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_101-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.4, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGeometry_105-effect0'] = {
        ['rotation'] = 0,
        ['rotationAxis'] = 8,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_105-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 448, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
    },
    ['LumiBokehBlur_104-effect0'] = {
        ['bokehMode'] = 0,
        ['sample'] = 0,
        ['scaleX'] = 1,
        ['scaleY'] = 1,
        ['regionIns'] = 0.5,
        ['lightIns'] = 0,
        ['darkIns'] = 2,
        ['quality'] = 0.69999998807907,
        ['angle'] = 0,
        ['lineNum'] = 5,
        ['starShapeIns'] = 0.60000002384186,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiSaturation_104-effect1'] = {
        ['saturationIntensity'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiBrightness_104-effect3'] = {
        ['brightnessIntensity'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(504, 896),
    },
    ['LumiLayer_104-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_103-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 448, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_102-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 1345, 0),
        ['scale'] = Amaz.Vector3f(263.492063492064, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_101-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, -451, 0),
        ['scale'] = Amaz.Vector3f(263.492063492064, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(504, 896),
        ['layerSize'] = Amaz.Vector2f(504, 896),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiGeometry_105-effect0#rotation#number'] =
{
	{
		{0.83, 0, 0.833333333, 0.833333333, }, 
		{0, 1.133333, }, 
		{{0, }, {8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.35, 1, }, 
		{1.133333, 1.633333, }, 
		{{8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGeometry_105-effect0#rotationAxis#number'] =
{
	{
		{0.83, 0, 0.833333333, 0.833333333, }, 
		{0, 1.133333, }, 
		{{0, }, {8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs#scale#vector'] =
{
	{
		{0.69,0.69,0.69, 0,0,0.69, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
		{0, 1.133333, }, 
		{{100, 100, 100, }, {130, 130, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.36,0.36,0.36, 1,1,0.36, }, 
		{1.133333, 1.633333, }, 
		{{130, 130, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_105-trs#rotation#number'] =
{
	{
		{0.59, 0, 0.833333333, 0.833333333, }, 
		{0.866667, 1.133333, }, 
		{{0, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.41, 1, }, 
		{1.133333, 1.333333, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBokehBlur_104-effect0#sample#number'] =
{
	{
		{0.166666667, 0.166666667, 0.28, 1, }, 
		{0, 0.4, }, 
		{{24.5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 0, }, 
		{0.4, 1.1, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.1, 1.133333, }, 
		{{0, }, {17.1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.35, 1, }, 
		{1.133333, 1.633333, }, 
		{{17.1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSaturation_104-effect1#saturationIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.1, 1.133333, }, 
		{{-1, }, {-0.7, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.133333, 1.633333, }, 
		{{-0.7, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiBrightness_104-effect3#brightnessIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.8, 1.1, }, 
		{{0, }, {-0.65, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.1, 1.133333, }, 
		{{-0.65, }, {-0.66, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.133333, 1.633333, }, 
		{{-0.66, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_103-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1, 1.1, }, 
		{{0, }, {59, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.1, 1.2, }, 
		{{59, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_102-trs-blend#position#vector'] =
{
	{
		{0.65, 0, 0.833333, 0.833333, }, 
		{0.4, 1.3, }, 
		{{252, 1345, 0, }, {252, 1235, 0, }, {252, 1326.66666603088, 0, }, {252, 1235, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.35, 1, }, 
		{1.3, 1.966667, }, 
		{{252, 1235, 0, }, {252, 1345, 0, }, {252, 1235, 0, }, {252, 1326.66666603088, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_101-trs-blend#position#vector'] =
{
	{
		{0.65, 0, 0.833333, 0.833333, }, 
		{0.4, 1.3, }, 
		{{252, -451, 0, }, {252, -341, 0, }, {252, -432.666666030884, 0, }, {252, -341, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.166667, 0.35, 1, }, 
		{1.3, 1.966667, }, 
		{{252, -341, 0, }, {252, -451, 0, }, {252, -341, 0, }, {252, -432.666666030884, 0, }, }, 
		{6413, }, 
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
