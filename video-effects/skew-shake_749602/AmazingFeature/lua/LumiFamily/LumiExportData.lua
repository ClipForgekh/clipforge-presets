local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_27-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiTurbulenceDisplacement_27-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiSShake_27-effect2'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiLayer_172-trs-blend'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
            ['baseTex'] = {{0, 1}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_27-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.91796875, 0.89583333333333),
        ['ae_pre_position'] = Amaz.Vector2f(0.91796875, 0.89583333333333),
        ['unifiedScale'] = false,
        ['scale_x'] = 0.9,
        ['ae_pre_scale_x'] = 0.9,
        ['scale_y'] = 0.75,
        ['ae_pre_scale_y'] = 0.75,
        ['vIntensity'] = 0.25,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
    },
    ['LumiTurbulenceDisplacement_27-effect1'] = {
        ['size'] = 0.03,
        ['quantity'] = 5,
        ['complexity'] = 1,
        ['evolution'] = 0,
        ['cycle'] = 100,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['type'] = 0,
        ['fix_type'] = 1,
        ['picture_scale'] = 1,
        ['motion_tile_type'] = 0,
        ['qualityType'] = 3,
    },
    ['LumiSShake_27-effect2'] = {
        ['ampRatio'] = 0.5,
        ['frqRatio'] = 1,
        ['phase0'] = 0,
        ['scale0'] = 1,
        ['blurEnabled'] = true,
        ['blurIntensity'] = 0.5,
        ['blurQuality'] = 0,
        ['seed'] = 0,
        ['xFill'] = 2,
        ['yFill'] = 2,
        ['xAmpR'] = 192,
        ['xFrqR'] = 1,
        ['xAmp'] = 0,
        ['xFrq'] = 0.5,
        ['xPhase'] = 0,
        ['yAmpR'] = 192,
        ['yFrqR'] = 1,
        ['yAmp'] = 0,
        ['yFrq'] = 0.5,
        ['yPhase'] = 0,
        ['zAmpR'] = 0,
        ['zFrqR'] = 1,
        ['zAmp'] = 0,
        ['zFrq'] = 0.5,
        ['zPhase'] = 0,
        ['wAmpR'] = 0,
        ['wFrqR'] = 1,
        ['wAmp'] = 0,
        ['wFrq'] = 0.5,
        ['wPhase'] = 0,
        ['rAmpRatio'] = 1,
        ['gAmpRatio'] = 1,
        ['bAmpRatio'] = 1,
        ['rPhase'] = 0,
        ['gPhase'] = 0,
        ['bPhase'] = 0,
        ['rgbRnd'] = 0,
        ['rgbFrq'] = 2,
    },
    ['LumiLayer_172-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(640, 360, 0),
        ['position'] = Amaz.Vector3f(640, 360, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1280, 720),
        ['layerSize'] = Amaz.Vector2f(1280, 720),
        ['mirrorEdge'] = false,
        ['blendMode'] = 1,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_27-effect0#ae_pre_position#vector'] =
{
	{
		{0.166667, 0, 0.833333, 1, }, 
		{0.76666633333333, 1.00000033333333, }, 
		{{0.5, 0.5, }, {0.91796875, 0.89583333333333, }, {0.56966145634651, 0.56597222222222, }, {0.84830729365349, 0.82986111111111, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_27-effect0#position#vector'] =
{
	{
		{0.166667, 0, 0.833333, 1, }, 
		{0.733333, 0.966667, }, 
		{{0.5, 0.5, }, {0.91796875, 0.89583333333333, }, {0.56966145634651, 0.56597222222222, }, {0.84830729365349, 0.82986111111111, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_27-effect0#ae_pre_scale_x#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.43333333333333, 0.90000033333333, }, 
		{{1, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_27-effect0#scale_x#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.4, 0.866667, }, 
		{{1, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_27-effect0#ae_pre_scale_y#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.43333333333333, 0.90000033333333, }, 
		{{1, }, {0.75, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_27-effect0#scale_y#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.4, 0.866667, }, 
		{{1, }, {0.75, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiTurbulenceDisplacement_27-effect1#size#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.4, 0.866667, }, 
		{{0, }, {0.03, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiSShake_27-effect2#ampRatio#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0, 0.966667, }, 
		{{0, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_172-trs-blend#opacity#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.766667, 0.966667, }, 
		{{0, }, {100, }, }, 
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
