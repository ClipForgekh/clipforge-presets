local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiRoundCorner_1302-effect0', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_1302-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1302-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiPageTurn_1301-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_1301-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_1302-effect0'] = {
        ['radius'] = 0.0756501927299,
        ['fade'] = 5,
        ['fadeType'] = 0,
    },
    ['LumiLayer_1302-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(252, 448, 0),
        ['position'] = Amaz.Vector3f(252, 448, 0),
        ['scale'] = Amaz.Vector3f(99.9645037857407, 99.9645037857407, 100),
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
    ['LumiPageTurn_1301-effect0'] = {
        ['classic_ui'] = 2,
        ['inFoldPosition'] = Amaz.Vector2f(2.9265873015873, 1.23995535714286),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.05,
    },
    ['LumiLayer_1301-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_1302-effect0#radius#number'] =
{
	{
		{0.166666667, 0.166666667, 0.28, 1, }, 
		{1.433333, 1.966667, }, 
		{{35, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_1302-trs#scale#vector'] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 1,1,0.833333333, }, 
		{0, 0.566667, }, 
		{{45, 45, 100, }, {50, 50, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.47,0.47,0.47, 0,0,0.47, 0.53,0.53,0.53, 1,1,0.53, }, 
		{0.566667, 0.9, }, 
		{{50, 50, 100, }, {45, 45, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.47,0.47,0.47, 0,0,0.47, 0.28,0.28,0.28, 1,1,0.28, }, 
		{0.9, 1.966667, }, 
		{{45, 45, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_1301-effect0#inFoldPosition#vector'] =
{
	{
		{0.166667, 0.166667, 0.4, 1, }, 
		{0, 0.833333, }, 
		{{-1.13690476190476, 0.08816964285714, }, {1.01785714285714, 0.76897321428571, }, {-0.77777777777778, 0.20163690192359, }, {0.34060844542488, 0.57700892857143, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.166667, 0.075626, 0.833333, 0.833333, }, 
		{0.833333, 0.866667, }, 
		{{1.01785714285714, 0.76897321428571, }, {2.9265873015873, 1.23995535714286, }, {1.6951058402894, 0.9609375, }, {2.6084656185574, 1.16145833049502, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = true
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
