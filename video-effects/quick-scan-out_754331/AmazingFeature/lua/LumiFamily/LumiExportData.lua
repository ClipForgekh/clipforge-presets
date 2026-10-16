local data = {}

local ae_compDurations = {0, 0.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiGodRay_48-effect0', 'InputTex', 0},
    {'LumiLayer_48-trs-blend', 'baseTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiGodRay_48-effect0'] = {
        ['nodeDuration'] = {{0.13333333333333, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiLayer_48-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.13333333333333, 0.86666666666667}, },
            ['baseTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiMotionBlur2D_65-effect0'] = {
        ['nodeDuration'] = {{0.13333333333333, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiLayer_65-blend'] = {
        ['nodeDuration'] = {{0, 2.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.13333333333333, 0.86666666666667}, },
            ['baseTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiBrightness_63-effect0'] = {
        ['nodeDuration'] = {{0.13333333333333, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiLayer_63-blend'] = {
        ['nodeDuration'] = {{0, 2.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.13333333333333, 0.86666666666667}, },
            ['baseTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiDirectionalBlurs_61-effect0'] = {
        ['nodeDuration'] = {{0.13333333333333, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiLayer_61-blend'] = {
        ['nodeDuration'] = {{0, 2.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.13333333333333, 0.86666666666667}, },
            ['baseTex'] = {{0, 2.86666666666667}, },
        },
    },
    ['LumiLayer_67-blend'] = {
        ['nodeDuration'] = {{0, 2.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.83333333333333, 1}, },
            ['baseTex'] = {{0, 2.86666666666667}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGodRay_48-effect0'] = {
        ['center'] = Amaz.Vector2f(-0.03209030716508, 0.5),
        ['range'] = 0.71,
        ['smoothness'] = 0,
        ['weightDecay'] = 1,
        ['colorDecay'] = 1,
        ['borderType'] = 0,
        ['lightSource'] = 0,
        ['brightness'] = 0.1,
        ['grayscaleCorrection'] = 0,
        ['useAngle'] = false,
        ['angleRange'] = 150,
        ['angleType'] = 1,
        ['angle'] = 0,
        ['directionPoint'] = Amaz.Vector2f(0.5, 0.5),
        ['scaleType'] = 4,
        ['quality'] = 10,
        ['colorType'] = 0,
        ['lightColor'] = Amaz.Color(1, 1, 1, 1),
        ['blendMode'] = 0,
        ['displayRayOnly'] = false,
        ['dither'] = 0,
        ['noiseIntensity'] = 0,
        ['inverseGammaCorrection'] = false,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_48-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
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
    ['LumiMotionBlur2D_65-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.79351851851852, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.79351851851852, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.15,
        ['ae_pre_scale_x'] = 1.15,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_65-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiBrightness_63-effect0'] = {
        ['brightnessIntensity'] = -0.4,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_63-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiDirectionalBlurs_61-effect0'] = {
        ['blurIntensity'] = 80,
        ['angle'] = 90,
        ['directionNum'] = 1,
        ['exposure'] = 0,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_61-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_67-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Solid',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiGodRay_48-effect0#center#vector'] =
{
	{
		{0.166667, 0, 0.833333, 1, }, 
		{0.133333, 0.8, }, 
		{{1.59611872920278, 0.5, }, {-0.03209030716481, 0.5, }, {1.59611872920278, 0.5, }, {-0.03209030716481, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_48-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.362, 0.916842227, }, 
		{0.133333, 0.5, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.576, 2.53e-7, 0.833333333, 1, }, 
		{0.5, 0.8, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_65-effect0#ae_pre_position#vector'] =
{
	{
		{0.899, 0, 0.979, 0.196017, }, 
		{0.16666633333333, 0.83333333333333, }, 
		{{0.5, 0.5, }, {0.79351851851852, 0.5, }, {0.5, 0.5, }, {0.79351851851852, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_65-effect0#position#vector'] =
{
	{
		{0.899, 0, 0.979, 0.196017, }, 
		{0.133333, 0.8, }, 
		{{0.5, 0.5, }, {0.79351851851852, 0.5, }, {0.5, 0.5, }, {0.79351851851852, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_65-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.16666633333333, 0.83333333333333, }, 
		{{1, }, {1.15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_65-effect0#scale_x#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.133333, 0.8, }, 
		{{1, }, {1.15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiBrightness_63-effect0#brightnessIntensity#number'] =
{
	{
		{0.787, 0.233145076, 0.939, 0.583857401, }, 
		{0.133333, 0.8, }, 
		{{0, }, {-0.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_61-effect0#blurIntensity#number'] =
{
	{
		{0.656, 0, 0.832, 0.617138395, }, 
		{0.133333, 0.8, }, 
		{{0, }, {80, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_61-effect0#exposure#number'] =
{
	{
		{0.756, 0, 0.787, 0.48951778, }, 
		{0.133333, 0.8, }, 
		{{1, }, {0, }, }, 
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
