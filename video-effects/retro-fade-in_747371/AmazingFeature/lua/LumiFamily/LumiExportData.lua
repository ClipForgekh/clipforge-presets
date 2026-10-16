local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiExposure_1503-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiExposure_1503-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiBokehBlur_1503-effect1'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiGrain_1503-effect2'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1501-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.29166666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiExposure_1503-effect0'] = {
        ['channelType'] = 0,
        ['exposure'] = 0,
        ['offset'] = 0,
        ['grayscaleCorrection'] = 1,
        ['redExposure'] = 0,
        ['redOffset'] = 0,
        ['redGrayscaleCorrection'] = 1,
        ['greenExposure'] = 0,
        ['greenOffset'] = 0,
        ['greenGrayscaleCorrection'] = 1,
        ['blueExposure'] = 0,
        ['blueOffset'] = 0,
        ['blueGrayscaleCorrection'] = 1,
        ['noUseLinearLight'] = false,
    },
    ['LumiBokehBlur_1503-effect1'] = {
        ['bokehMode'] = 0,
        ['sample'] = 0,
        ['scaleX'] = 1,
        ['scaleY'] = 1,
        ['regionIns'] = 0.5,
        ['lightIns'] = 1,
        ['quality'] = 1,
        ['angle'] = 0,
        ['lineNum'] = 5,
    },
    ['LumiGrain_1503-effect2'] = {
        ['grainIntensity'] = 0,
        ['intensityR'] = 10,
        ['intensityG'] = 10,
        ['intensityB'] = 10,
        ['scale'] = 0.2,
        ['scaleR'] = 0.3,
        ['scaleG'] = 0.3,
        ['scaleB'] = 0.3,
        ['brightness'] = 0,
        ['contrast'] = 0.1,
        ['saturation'] = 0.5,
        ['monochrome'] = false,
        ['combine'] = 4,
        ['speed'] = 1,
        ['quality'] = 1,
    },
    ['LumiLayer_1501-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(336, 252, 0),
        ['position'] = Amaz.Vector3f(336, 252, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 3,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(672, 504),
        ['layerSize'] = Amaz.Vector2f(672, 504),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Color',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiExposure_1503-effect0#exposure#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0, 0.833333, }, 
		{{-10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBokehBlur_1503-effect1#sample#number'] =
{
	{
		{0.166666667, 0.166666667, 0.66666667, 1, }, 
		{0.333333, 1.333333, }, 
		{{20, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiGrain_1503-effect2#grainIntensity#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 0.833333333, }, 
		{1.125, 1.958333, }, 
		{{5, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1501-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.041667, 0.291667, }, 
		{{100, }, {3, }, }, 
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
