local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiChromaticAberration_42-effect0'] = {
        ['nodeDuration'] = {{0, 1.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.83333333333333}, },
        },
    },
    ['LumiMotionBlur2D_42-effect1'] = {
        ['nodeDuration'] = {{0, 1.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.83333333333333}, },
        },
    },
    ['LumiLayer_42-trs'] = {
        ['nodeDuration'] = {{0, 1.83333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.83333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiChromaticAberration_42-effect0'] = {
        ['offsetX'] = 0,
        ['offsetY'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiMotionBlur2D_42-effect1'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = true,
        ['scale_x'] = 1.44897766778854,
        ['ae_pre_scale_x'] = 1.44897766778854,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_42-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(360, 640, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(720, 1280),
        ['layerSize'] = Amaz.Vector2f(720, 1280),
        ['mirrorEdge'] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiChromaticAberration_42-effect0#offsetX#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.833333, 1.666667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.666667, 1.8, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiChromaticAberration_42-effect0#offsetY#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.833333, 1.666667, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{1.666667, 1.8, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_42-effect1#ae_pre_rotate#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.86666633333333, 1.70000033333333, }, 
		{{0, }, {405, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_42-effect1#rotate#number'] =
{
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.833333, 1.666667, }, 
		{{0, }, {405, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_42-effect1#ae_pre_scale_x#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.20000033333333, 0.86666633333333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.86666633333333, 1.70000033333333, }, 
		{{1.5, }, {0.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_42-effect1#scale_x#number'] =
{
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.166667, 0.833333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.833333333, 1, }, 
		{0.833333, 1.666667, }, 
		{{1.5, }, {0.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_42-trs#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.5, 1.666667, }, 
		{{100, }, {0, }, }, 
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
