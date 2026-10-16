local data = {}

local ae_durations = {
    ["Gaussian_Blur_Root_127-effect1"] = {{0, 1.56667},},
    ["TemperatureTone_127-effect2"] = {{0, 1.56667},},
    ["AE_Transform_127-trs"] = {{0, 1.56667},},
    ["Gaussian_Blur_Root_128-effect1"] = {{0, 1.56667},},
    ["lumi_shadow_highlight_128-effect2"] = {{0, 1.56667},},
    ["TemperatureTone_128-effect3"] = {{0, 1.56667},},
    ["AE_Transform_128-trs"] = {{0, 1.56667},},
    ["LumiLayerBlend_128-blend"] = {{0, 1.56667},},
    ["Gaussian_Blur_Root_129-effect1"] = {{0, 1.56667},},
    ["AE_Transform_129-trs"] = {{0, 1.56667},},
    ["LumiLayerBlend_129-blend"] = {{0, 1.56667},},
    ["StrongSharp_130-effect0"] = {{0, 1.56667},},
    ["Exposure_Root_130-effect1"] = {{0, 1.56667},},
    ["LumiLayerBlend_130-blend"] = {{0, 1.56667},},
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 1.5}
data.ae_compDurations = ae_compDurations

local ae_durationMode = 0 
data.ae_durationMode = ae_durationMode

local ae_disappearTime = 0.000000 
data.ae_disappearTime = ae_disappearTime

local ae_effectType = "videoAnimation" 
data.ae_effectType = ae_effectType

local ae_attribute = {
    ["Gaussian_Blur_Root_127-effect1"] = {
        ["type"] = 2,
        ["intensity"] = 30,
        ["steps"] = 1,
        ["expandFlag"] = false,
    },
    ["TemperatureTone_127-effect2"] = {
        ["ColorTemperature"] = 1,
        ["ColorTones"] = 0,
    },
    ["AE_Transform_127-trs"] = {
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, -711.927, 0),
        ["scale"] = Amaz.Vector3f(100, 100, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 33,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
    },
    ["Gaussian_Blur_Root_128-effect1"] = {
        ["type"] = 2,
        ["intensity"] = 21,
        ["steps"] = 1,
        ["expandFlag"] = false,
    },
    ["lumi_shadow_highlight_128-effect2"] = {
        ["shadow"] = 0,
        ["highlight"] = -0.8,
    },
    ["TemperatureTone_128-effect3"] = {
        ["ColorTemperature"] = 1,
        ["ColorTones"] = 0,
    },
    ["AE_Transform_128-trs"] = {
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, -2174.59, 0),
        ["scale"] = Amaz.Vector3f(180, 270, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
    },
    ["LumiLayerBlend_128-blend"] = {
        ["blendMode"] = "Add",
    },
    ["Gaussian_Blur_Root_129-effect1"] = {
        ["type"] = 2,
        ["intensity"] = 8,
        ["steps"] = 1,
        ["expandFlag"] = false,
    },
    ["AE_Transform_129-trs"] = {
        ["anchorPoint"] = Amaz.Vector3f(540, 1620, 0),
        ["position"] = Amaz.Vector3f(375, -3969.04, 0),
        ["scale"] = Amaz.Vector3f(150, 600, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
    },
    ["LumiLayerBlend_129-blend"] = {
        ["blendMode"] = "Screen",
    },
    ["StrongSharp_130-effect0"] = {
        ["strength"] = 0,
        ["offset_x"] = 0.55,
        ["offset_y"] = 0.4,
    },
    ["Exposure_Root_130-effect1"] = {
        ["exposure"] = 1.0,
        ["offset"] = 0,
        ["grayscale_correct"] = 1.0,
        ["no_use_linear_light"] = false,
    },
    ["LumiLayerBlend_130-blend"] = {
        ["blendMode"] = "Normal",
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ["Gaussian_Blur_Root_127-effect1#intensity#number"] =
{
	{
		{0.28, 0, 0.58, 1, }, 
		{0.733333, 1.5, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["TemperatureTone_127-effect2#ColorTemperature#number"] =
{
	{
		{0.28, 0, 0.58, 1, }, 
		{0.733333, 1.5, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_127-trs#position#vector"] =
{
	{
		{0.17, 0.25, 0.77, 0.86, }, 
		{0, 0.266667, }, 
		{{540, -711.92734751, 0, }, {540, -277.235636972, 0, }, {540, -711.92734751, 0, }, {540, -277.235636972, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.27, 0.23, 0.83, 0.84, }, 
		{0.266667, 0.733333, }, 
		{{540, -277.235636972, 0, }, {540, 323.115352697, 0, }, {540, -277.235636972, 0, }, {540, 323.115352697, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.2, 1, }, 
		{0.733333, 1.5, }, 
		{{540, 323.115352697, 0, }, {540, 540, 0, }, {540, 323.115352697, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_127-trs#opacity#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.733333, 1.5, }, 
		{{33, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_128-trs#position#vector"] =
{
	{
		{0.15, 0.26, 0.77, 0.86, }, 
		{0, 0.266667, }, 
		{{540, -2174.593345644, 0, }, {540, -1149.013427048, 0, }, {540, -2174.593345644, 0, }, {540, -1149.013427048, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.27, 0.23, 0.83, 0.84, }, 
		{0.266667, 0.733333, }, 
		{{540, -1149.013427048, 0, }, {540, 138, 0, }, {540, -1149.013427048, 0, }, {540, 138, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.2, 1, }, 
		{0.733333, 1.5, }, 
		{{540, 138, 0, }, {540, 540, 0, }, {540, 138, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_128-trs#scale#vector"] =
{
	{
		{0.55,0.55,0.55, 0,0,0.55, 0.999,0.999,0.999, 1,1,0.999, }, 
		{0.733333, 1.5, }, 
		{{180, 270, 100, }, {115, 130, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_128-trs#opacity#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.733333, 1.5, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_129-trs#position#vector"] =
{
	{
		{0.3, 0.49, 0.999, 1, }, 
		{0, 0.733333, }, 
		{{375, -3969.042437286, 0, }, {375, -42.799310114, 0, }, {375, -3969.042437286, 0, }, {375, -42.799310114, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.001, 0, 0.2, 1, }, 
		{0.733333, 1.5, }, 
		{{375, -42.799310114, 0, }, {375, 750, 0, }, {375, -42.799310114, 0, }, {375, 750, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["AE_Transform_129-trs#opacity#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.733333, 1.5, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["StrongSharp_130-effect0#offset_x#number"] =
{
	{
		{0.25, 0, 0.62, 1, }, 
		{1.033333, 1.5, }, 
		{{0.55, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["StrongSharp_130-effect0#offset_y#number"] =
{
	{
		{0.25, 0, 0.62, 1, }, 
		{1.033333, 1.5, }, 
		{{0.4, }, {0.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["Exposure_Root_130-effect1#exposure#number"] =
{
	{
		{0.253908427, 0.252030886, 0.581943542, 1, }, 
		{0, 0.233333, }, 
		{{1.0, }, {0.33, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.381685363, 0, 0.710616453, 1, }, 
		{0.233333, 0.633333, }, 
		{{0.33, }, {0.8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.367553464, 0, 0.797677126, 1, }, 
		{0.633333, 1.5, }, 
		{{0.8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_transitionInputIndex = {
    {"Gaussian_Blur_Root_127-effect1", "InputTex", 0},
    {"Gaussian_Blur_Root_128-effect1", "InputTex", 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_sliderInfos = {
}
data.ae_sliderInfos = ae_sliderInfos


return data
