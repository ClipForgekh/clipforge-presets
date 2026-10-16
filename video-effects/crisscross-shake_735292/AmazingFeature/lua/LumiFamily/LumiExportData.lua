local data = {}

local ae_durations = {
    ["LumiDirectionBlur_4701-effect1"] = {{0, 0.8},},
    ["LuaExposure_4701-effect2"] = {{0, 0.8},},
    ["AE_Transform_4701-trs"] = {{0, 0.8},},
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 0.800000}
data.ae_compDurations = ae_compDurations

local ae_durationMode = 2 
data.ae_durationMode = ae_durationMode

local ae_disappearTime = 0.000000 
data.ae_disappearTime = ae_disappearTime

local ae_effectType = "videoAnimation" 
data.ae_effectType = ae_effectType

local ae_attribute = {
    ["LumiDirectionBlur_4701-effect1"] = {
        ["angle"] = 90,
        ["intensity"] = 0,
        ["steps"] = 4,
        ["mirrorEdge"] = true,
        ["expandFlag"] = true,
    },
    ["LuaExposure_4701-effect2"] = {
        ["channelType"] = 0,
        ["exposure"] = 0.017913,
        ["offset"] = -0.000198861,
        ["grayscaleCorrection"] = 1,
        ["redExposure"] = 0,
        ["redOffset"] = 0,
        ["redGrayscaleCorrection"] = 1,
        ["greenExposure"] = 0,
        ["greenOffset"] = 0,
        ["greenGrayscaleCorrection"] = 1,
        ["blueExposure"] = 0,
        ["blueOffset"] = 0,
        ["blueGrayscaleCorrection"] = 1,
        ["noUseLinearLight"] = false,
    },
    ["AE_Transform_4701-trs"] = {
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, 540, 0),
        ["scale"] = Amaz.Vector3f(100.373, 100.249, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(1080, 1080),
        ["mirrorEdge"] = true,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ["LumiDirectionBlur_4701-effect1#angle#number"] =
{
	{
		{0.001, 0, 0.11, 0.88, }, 
		{0.266667, 0.3, }, 
		{{0, }, {90, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiDirectionBlur_4701-effect1#intensity#number"] =
{
	{
		{0.001, 0, 0.167513742, 0.673328579, }, 
		{0, 0.266667, }, 
		{{90, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.8, 0.152941176, }, 
		{0.266667, 0.3, }, 
		{{15, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.531567101, 1, }, 
		{0.3, 0.733333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LuaExposure_4701-effect2#exposure#number"] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{0, 0.266667, }, 
		{{1.6, }, {0.44, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.8, 0.304945055, }, 
		{0.266667, 0.3, }, 
		{{0.44, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.258637137, 0, 0.597337847, 1, }, 
		{0.3, 0.8, }, 
		{{2, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LuaExposure_4701-effect2#offset#number"] =
{
	{
		{0.410680954, 0, 0.999, 1, }, 
		{0, 0.266667, }, 
		{{-0.03, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.7, 0.024847276, }, 
		{0.266667, 0.3, }, 
		{{0, }, {-0.04, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.231920044, 0, 0.448009235, 1, }, 
		{0.3, 0.8, }, 
		{{-0.04, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_4701-trs#position#vector"] =
{
	{
		{0.001, 0, 0.38, 1, }, 
		{0, 0.133333, }, 
		{{540, -20, 0, }, {540, 620, 0, }, {540, -20, 0, }, {540, 620, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.41, 0, 0.999, 1, }, 
		{0.133333, 0.266667, }, 
		{{540, 620, 0, }, {540, 480, 0, }, {540, 620, 0, }, {540, 480, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.8, 0.31081, }, 
		{0.266667, 0.3, }, 
		{{540, 480, 0, }, {-111, 540, 0, }, {540, 480, 0, }, {-111, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.29, 1, }, 
		{0.3, 0.466667, }, 
		{{-111, 540, 0, }, {650, 540, 0, }, {-111, 540, 0, }, {650, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.3, 0, 0.5, 1, }, 
		{0.466667, 0.733333, }, 
		{{650, 540, 0, }, {540, 540, 0, }, {650, 540, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_4701-trs#scale#vector"] =
{
	{
		{0.46933023,0.46933023,0.001, 0.161190837,0.236413228,0.001, 0.648756068,0.648756068,0.11, 1,1,0.11, }, 
		{0, 0.233333, }, 
		{{80, 87, 100, }, {102, 102, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.667889601,0.667889601,0.35, 0,0,0.35, 0.999,0.999,0.999, 1,1,0.999, }, 
		{0.233333, 0.3, }, 
		{{102, 102, 100, }, {85, 75, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.64980915,0.64980915,0.001, 0.354619244,0.256793245,0.001, 0.699377768,0.699377768,0.11, 1,1,0.11, }, 
		{0.3, 0.566667, }, 
		{{85, 75, 100, }, {106, 104, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.3,0.3,0.3, 0,0,0.3, 0.7,0.7,0.7, 1,1,0.7, }, 
		{0.566667, 0.8, }, 
		{{106, 104, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_transitionInputIndex = {
    {"LumiDirectionBlur_4701-effect1", "InputTex", 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_sliderInfos = {
}
data.ae_sliderInfos = ae_sliderInfos


return data
