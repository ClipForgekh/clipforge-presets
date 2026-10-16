local data = {}

local ae_durations = {
    ["LumiLayer_8602-trs"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiPageTurn_8601-effect0"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiLayer_8601-blend"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
            ["baseTex"] = {{0, 0.9},},
        },
    },
    ["LumiLayer_1603-trs"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiFill_1602-effect0"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiBoxBlur_1602-effect1"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiLayer_1602-blend"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
            ["baseTex"] = {{0, 0.9},},
        },
    },
    ["LumiLayer_6502-trs"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiPageTurn_6501-effect0"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiLayer_6501-blend"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
            ["baseTex"] = {{0, 0.9},},
        },
    },
    ["LumiLayer_1601-blend"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
            ["baseTex"] = {{0, 0.9},},
        },
    },
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 0.900000}
data.ae_compDurations = ae_compDurations

local ae_durationMode = 2 
data.ae_durationMode = ae_durationMode

local ae_disappearTime = 0.000000 
data.ae_disappearTime = ae_disappearTime

local ae_effectType = "videoAnimation" 
data.ae_effectType = ae_effectType

local ae_attribute = {
    ["LumiLayer_8602-trs"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, 540, 0),
        ["scale"] = Amaz.Vector3f(99.8883, 99.8883, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(1080, 1080),
        ["mirrorEdge"] = false,
    },
    ["LumiPageTurn_8601-effect0"] = {
        ["classic_ui"] = 0,
        ["inFoldPosition"] = Amaz.Vector2f(1, 0.75),
        ["inFoldDirection"] = -77,
        ["foldRadius"] = 5,
    },
    ["LumiLayer_8601-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Adjustment",
        ["blendMode"] = "Normal",
    },
    ["LumiLayer_1603-trs"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, 540, 0),
        ["scale"] = Amaz.Vector3f(100, 100, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 23,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(1080, 1080),
        ["mirrorEdge"] = false,
    },
    ["LumiFill_1602-effect0"] = {
        ["color"] = Amaz.Color(0, 0, 0, 1),
        ["alpha"] = 1,
        ["reverse"] = false,
    },
    ["LumiBoxBlur_1602-effect1"] = {
        ["intensity"] = 0,
        ["iteration"] = 3,
        ["steps"] = 1,
        ["horizontalStrength"] = 1,
        ["verticalStrength"] = 1,
        ["blurDirection"] = 0,
        ["borderType"] = 0,
    },
    ["LumiLayer_1602-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Adjustment",
        ["blendMode"] = "Normal",
    },
    ["LumiLayer_6502-trs"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, 540, 0),
        ["scale"] = Amaz.Vector3f(99.8883, 99.8883, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(1080, 1080),
        ["mirrorEdge"] = false,
    },
    ["LumiPageTurn_6501-effect0"] = {
        ["classic_ui"] = 0,
        ["inFoldPosition"] = Amaz.Vector2f(1, 0.75),
        ["inFoldDirection"] = -30,
        ["foldRadius"] = 5,
    },
    ["LumiLayer_6501-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Adjustment",
        ["blendMode"] = "Normal",
    },
    ["LumiLayer_1601-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Precomp",
        ["blendMode"] = "Normal",
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ["LumiLayer_8602-trs#scale#vector"] =
{
	{
		{0.87,0.87,0.87, 0,0,0.87, 0.39,0.39,0.39, 1,1,0.39, }, 
		{0, 0.9, }, 
		{{80, 80, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ["LumiPageTurn_8601-effect0#inFoldPosition#vector"] =
{
	{
		{0.13, 0, 0.32, 0.82, }, 
		{0, 0.333333, }, 
		{{-0.13888888888889, 0.75, }, {0.6574361878537, 0.75, }, {-0.13888888888889, 0.75, }, {0.6574361878537, 0.75, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.11, 0.174577, 0.81, 0.243501, }, 
		{0.333333, 0.833333, }, 
		{{0.6574361878537, 0.75, }, {1, 0.75, }, {0.6574361878537, 0.75, }, {1, 0.75, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.27, 0, 0.35, 1, }, 
		{0.833333, 0.9, }, 
		{{1, 0.75, }, {1, 0, }, {1, 0.75, }, {1, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ["LumiPageTurn_8601-effect0#inFoldDirection#number"] =
{
	{
		{0.473349013, 0, 0.884151699, 0.768199675, }, 
		{0, 0.233333, }, 
		{{-90, }, {-80.054316, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.217730074, 0.264189274, 0.566780535, 1, }, 
		{0.233333, 0.466667, }, 
		{{-80.054316, }, {-63.653621, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.662055354, 0, 0.63032515, 1, }, 
		{0.466667, 0.833333, }, 
		{{-63.653621, }, {-77, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiPageTurn_8601-effect0#foldRadius#number"] =
{
	{
		{1, 0, 0.97017926, 0.243906104, }, 
		{0, 0.833333, }, 
		{{0.2, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_1603-trs#position#vector"] =
{
	{
		{0.29, 0, 0.37, 1, }, 
		{0, 0.333333, }, 
		{{540, 540, 0, }, {550, 550, 0, }, {540, 540, 0, }, {550, 550, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.25, 0, 0.5, 1, }, 
		{0.333333, 0.8, }, 
		{{550, 550, 0, }, {540, 540, 0, }, {550, 550, 0, }, {540, 540, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["LumiBoxBlur_1602-effect1#intensity#number"] =
{
	{
		{0.22, 0, 0.79, 1, }, 
		{0.333333, 0.833333, }, 
		{{20, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_6502-trs#scale#vector"] =
{
	{
		{0.87,0.87,0.87, 0,0,0.87, 0.39,0.39,0.39, 1,1,0.39, }, 
		{0, 0.9, }, 
		{{80, 80, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ["LumiPageTurn_6501-effect0#inFoldPosition#vector"] =
{
	{
		{0.001, 0, 0.06, 0.53, }, 
		{0, 0.833333, }, 
		{{-0.13888888888889, 0.75, }, {1, 0.75, }, {-0.13888888888889, 0.75, }, {1, 0.75, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.27, 0, 0.35, 1, }, 
		{0.833333, 0.9, }, 
		{{1, 0.75, }, {1, 0, }, {1, 0.75, }, {1, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ["LumiPageTurn_6501-effect0#inFoldDirection#number"] =
{
	{
		{0.335462359, 0.03593997, 0.138082771, 1, }, 
		{0, 0.833333, }, 
		{{-90, }, {-30, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiPageTurn_6501-effect0#foldRadius#number"] =
{
	{
		{1, 0, 0.985195268, 0.119973392, }, 
		{0, 0.833333, }, 
		{{0.2, }, {5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_transitionInputIndex = {
    {"LumiLayer_8602-trs", "InputTex", 0},
    {"LumiLayer_6502-trs", "InputTex", 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_sliderInfos = {
}
data.ae_sliderInfos = ae_sliderInfos


return data
