local data = {}

local ae_compDurations = {0, 1.2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiGaussianBlur_103-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_103-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiPixelSort_102-effect0'] = {
        ['nodeDuration'] = {{0, 0.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_102-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.83333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiGlitchSignal_101-effect0'] = {
        ['nodeDuration'] = {{0, 0.86666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_101-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.86666666666667}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiGaussianBlur_103-effect0'] = {
        ['blurIntensity'] = 50,
        ['quality'] = 0.1,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 0.99,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_103-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 960, 0),
        ['position'] = Amaz.Vector3f(-545.714836117028, 960, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1920),
        ['layerSize'] = Amaz.Vector2f(1080, 1920),
        ['mirrorEdge'] = false,
    },
    ['LumiPixelSort_102-effect0'] = {
        ['threshold'] = 0.56,
        ['rotate'] = -90,
        ['randomly'] = 0.46,
        ['reverseSort'] = false,
        ['affectType'] = 0,
        ['triggerType'] = 0,
        ['sortType'] = 0,
        ['featherStart'] = 0,
        ['featherEnd'] = 1,
        ['length'] = 0,
        ['offset'] = 1,
        ['offsetRandom'] = 0.63,
        ['randomSeed'] = 1,
        ['cycle'] = 0.2,
        ['blockSize'] = 0.1,
        ['blurSize'] = 0.66,
        ['outputType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_102-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(540, 960, 0),
        ['position'] = Amaz.Vector3f(540, 960, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1920),
        ['layerSize'] = Amaz.Vector2f(1080, 1920),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGlitchSignal_101-effect0'] = {
        ['lowQuality'] = 0.61,
        ['filterIntensity'] = 4.5,
        ['sharpen'] = 0.01,
        ['sharpenSize'] = 15.7,
        ['chromaNoise'] = 0,
        ['hueNoise'] = 0.5,
        ['chromaloss'] = 0.08,
        ['moireNoise'] = 0.36,
        ['moireSize'] = 0.03,
        ['moireSpeed'] = 0,
        ['randomSeed'] = 50,
        ['destruction'] = false,
        ['signalStrength'] = 1,
        ['d2dIntensity'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1920),
    },
    ['LumiLayer_101-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Adjustment',
        ['anchorPoint'] = Amaz.Vector3f(540, 960, 0),
        ['position'] = Amaz.Vector3f(540, 960, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1920),
        ['layerSize'] = Amaz.Vector2f(1080, 1920),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiGaussianBlur_103-effect0#blurIntensity#number'] =
{
	{
		{0.365535823, 0, 0.697861692, 0.992125235, }, 
		{0.233333, 0.3, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.798546125, -0.020812863, 0.66666667, 1, }, 
		{0.3, 0.366667, }, 
		{{0, }, {50, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.365535823, 0, 0.964479812, 0.604256299, }, 
		{0.366667, 0.633333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_103-trs#position#vector'] =
{
	{
		{0.86, 0, 0.666667, 1, }, 
		{-0.033333, 0.466667, }, 
		{{-548, 960, 0, }, {540, 960, 0, }, {-548, 960, 0, }, {540, 960, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiPixelSort_102-effect0#threshold#number'] =
{
	{
		{0.470403273, -0.015686995, 0.833333333, 1, }, 
		{0.3, 0.366667, }, 
		{{0.56, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.316207503, -0.000080257, 0.651895891, -0.011741631, }, 
		{0.366667, 0.4, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.379669177, 0.089644296, 0.862724506, 0.524090759, }, 
		{0.4, 0.633333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiPixelSort_102-effect0#featherStart#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 0.3, }, 
		{{0, }, {0.53, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.3, 0.333333, }, 
		{{0.53, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.333333, 0.433333, }, 
		{{0, }, {0.13, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.433333, 0.766667, }, 
		{{0.13, }, {0.85, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiPixelSort_102-effect0#featherEnd#number'] =
{
	{
		{0.383652586, 0, 0.711105618, 1, }, 
		{0.333333, 0.366667, }, 
		{{1, }, {0.31, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.247214367, 0, 0.212076622, 1, }, 
		{0.366667, 0.8, }, 
		{{0.31, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiPixelSort_102-effect0#length#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 0.3, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.3, 0.4, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.4, 0.633333, }, 
		{{1, }, {0.46, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiPixelSort_102-effect0#offset#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.3, 0.4, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiPixelSort_102-effect0#blockSize#number'] =
{
	{
		{0.33333333, 0, 0.2, 1, }, 
		{0.366667, 0.8, }, 
		{{0.1, }, {0.01, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_102-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.266667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.266667, 0.366667, }, 
		{{100, }, {100, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 0.7, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_101-effect0#lowQuality#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 0.566667, }, 
		{{0.61, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_101-effect0#filterIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.366667, 0.566667, }, 
		{{4.5, }, {3.4, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.8, }, 
		{{3.4, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_101-effect0#sharpen#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.8, }, 
		{{0.01, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_101-effect0#sharpenSize#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.8, }, 
		{{15.7, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_101-effect0#hueNoise#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.8, }, 
		{{0.5, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_101-effect0#chromaloss#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.8, }, 
		{{0.08, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_101-effect0#moireNoise#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.8, }, 
		{{0.36, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiGlitchSignal_101-effect0#moireSize#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.566667, 0.8, }, 
		{{0.03, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_101-trs-blend#opacity#number'] =
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
		{0.366667, 0.8, }, 
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
