local data = {}

local ae_compDurations = {0, 1}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiMotionBlur2D_570-effect0'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiCornerPin_570-effect1'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
    ['LumiGaussianBlur_570-effect2'] = {
        ['nodeDuration'] = {{0, 1}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiMotionBlur2D_570-effect0'] = {
        ['rotate'] = 0,
        ['ae_pre_rotate'] = 0,
        ['anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_anchor'] = Amaz.Vector2f(0.5, 0.5),
        ['position'] = Amaz.Vector2f(0.5, 0.5),
        ['ae_pre_position'] = Amaz.Vector2f(0.5, 0.5),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['vIntensity'] = 0.5,
        ['vCenter'] = -0.25,
        ['minSamples'] = 0.12,
        ['maxSamples'] = 0.24,
        ['mirrorEdge'] = true,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiCornerPin_570-effect1'] = {
        ['leftUpVertex'] = Amaz.Vector2f(0, 1),
        ['rightUpVertex'] = Amaz.Vector2f(1, 1),
        ['leftDownVertex'] = Amaz.Vector2f(0, 0),
        ['rightDownVertex'] = Amaz.Vector2f(1, 0),
        ['motionTileType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
    ['LumiGaussianBlur_570-effect2'] = {
        ['blurIntensity'] = 0,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 0.5,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1280, 720),
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiMotionBlur2D_570-effect0#ae_pre_position#vector'] =
{
	{
		{1, 0, 0, 1, }, 
		{0.03333333333333, 0.53333333333333, }, 
		{{-0.03515625, 0.5, }, {0.5, 0.5, }, {0.05403645634651, 0.5, }, {0.41080729365349, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur2D_570-effect0#position#vector'] =
{
	{
		{1, 0, 0, 1, }, 
		{0, 0.5, }, 
		{{-0.03515625, 0.5, }, {0.5, 0.5, }, {0.05403645634651, 0.5, }, {0.41080729365349, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_570-effect1#leftUpVertex#vector'] =
{
	{
		{1, 0, 0, 1, }, 
		{0, 0.666667, }, 
		{{-0.75, 1, }, {0, 1, }, {-0.625, 1, }, {-0.125, 1, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiCornerPin_570-effect1#leftDownVertex#vector'] =
{
	{
		{1, 0, 0, 1, }, 
		{0, 0.666667, }, 
		{{-0.75, 0, }, {0, 0, }, {-0.625, 0, }, {-0.125, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_570-effect2#blurIntensity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.5, }, 
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
