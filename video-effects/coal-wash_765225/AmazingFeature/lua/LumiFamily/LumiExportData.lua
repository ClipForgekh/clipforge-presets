local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBlobbylize_31-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['layerTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_31-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBlobbylize_31-effect0'] = {
        ['maskProperty'] = 4,
        ['maskEdgeMode'] = 2,
        ['blurSteps'] = 1,
        ['blurStride'] = 1,
        ['cutAway'] = 24.1664001026896,
        ['cutAwayFade'] = 1.5,
        ['height'] = 15,
        ['displacement'] = 300,
        ['lightIntensity'] = 1,
        ['lightColor'] = Amaz.Color(1, 1, 1, 1),
        ['lightMode'] = 0,
        ['lightHeight'] = 65,
        ['lightPosition'] = Amaz.Vector2f(0.5, 0.5),
        ['lightAngle'] = -45,
        ['ambient'] = 0.75,
        ['diffuse'] = 0.25,
        ['specular'] = 1,
        ['roughness'] = 0.02500000037253,
        ['metallic'] = 1,
        ['quality'] = 0.5,
        ['AEDesignSize'] = Amaz.Vector2f(1000, 1000),
    },
    ['LumiLayer_31-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(500, 500, 0),
        ['position'] = Amaz.Vector3f(500, 500, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 80.2,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1000, 1000),
        ['layerSize'] = Amaz.Vector2f(1000, 1000),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiBlobbylize_31-effect0#cutAway#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 1.666667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1, 1.666667, }, 
		{{100, }, {1, }, }, 
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
