local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiBokehBlur_27-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiBokehBlur_27-effect0'] = {
        ['bokehMode'] = 2,
        ['sample'] = 14.9639650139083,
        ['scaleX'] = 1,
        ['scaleY'] = 1,
        ['regionIns'] = 0.5,
        ['lightIns'] = 0.1,
        ['darkIns'] = 2,
        ['quality'] = 0.1,
        ['angle'] = 0,
        ['lineNum'] = 3,
        ['starShapeIns'] = 0.11000000149012,
        ['AEDesignSize'] = Amaz.Vector2f(720, 1280),
    },
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(360, 640, 0),
        ['position'] = Amaz.Vector3f(313.365018001808, 417.763964322463, 0),
        ['scale'] = Amaz.Vector3f(180, 180, 100),
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
    ['LumiBokehBlur_27-effect0#sample#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.666667, 1.833333, }, 
		{{15, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.5, }, 
		{{539, 242, 0, }, {209, 318, 0, }, {484, 254.666666984558, 0, }, {393, 261, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.5, 1, }, 
		{{209, 318, 0, }, {553.773187166, 531.523791766, 0, }, {325, 475, 0, }, {544.443146234298, 518.292978739572, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.5, }, 
		{{553.773187166, 531.523791766, 0, }, {360, 637.596346154, 0, }, {539.425542360092, 538.452644324136, 0, }, {360, 637.596346154, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0,0,0.166666667, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
		{0.833333, 1.666667, }, 
		{{180, 180, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.333333, }, 
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
