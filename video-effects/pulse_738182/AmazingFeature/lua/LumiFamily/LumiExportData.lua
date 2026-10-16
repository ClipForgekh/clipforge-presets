local data = {}

local ae_durations = {
    ["LumiLayer_53-trs"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiOpticsCompensation_67-effect0"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiLayer_67-blend"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 0.9},},
            ["InputTex"] = {{0, 0.5},},
        },
    },
    ["LumiBlit_103-effect0"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiRadialBlur_103-effect1"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiExposure_103-effect2"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiBlit_103-effect3"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
    ["LumiLayer_103-trs"] = {
        ["nodeDuration"] = {{0, 0.9},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.9},},
        },
    },
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 0.933333}
data.ae_compDurations = ae_compDurations

local ae_durationMode = 0 
data.ae_durationMode = ae_durationMode

local ae_effectType = "videoAnimation" 
data.ae_effectType = ae_effectType

local ae_attribute = {
    ["LumiLayer_53-trs"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(810, 810, 0),
        ["scale"] = Amaz.Vector3f(0, 0, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["compositeSize"] = Amaz.Vector2f(1620, 1620),
        ["layerSize"] = Amaz.Vector2f(1080, 1080),
        ["mirrorEdge"] = true,
    },
    ["LumiOpticsCompensation_67-effect0"] = {
        ["fov"] = 166.6,
        ["inverseLensDistortion"] = true,
        ["fovOrientation"] = 0,
        ["center"] = Amaz.Vector2f(0.5, 0.5),
        ["antiAliasing"] = true,
        ["fillBorders"] = false,
    },
    ["LumiLayer_67-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Adjustment",
        ["blendMode"] = "Normal",
    },
    ["LumiBlit_103-effect0"] = {

    },
    ["LumiRadialBlur_103-effect1"] = {
        ["blurType"] = 2,
        ["amount"] = 250,
        ["quality"] = 0.05,
        ["center"] = Amaz.Vector2f(0.5, 0.5),
        ["weightDecay"] = 0.965,
        ["dither"] = 1,
        ["blurAlpha"] = true,
        ["inverseGammaCorrection"] = false,
        ["borderType"] = 0,
    },
    ["LumiExposure_103-effect2"] = {
        ["channelType"] = 0,
        ["exposure"] = 0,
        ["offset"] = 0,
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
    ["LumiBlit_103-effect3"] = {

    },
    ["LumiLayer_103-trs"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(810, 810, 0),
        ["position"] = Amaz.Vector3f(540, 540, 0),
        ["scale"] = Amaz.Vector3f(100, 100, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(1620, 1620),
        ["mirrorEdge"] = false,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ["LumiLayer_53-trs#scale#vector"] =
{
	{
		{0.7246089,0.7246089,0.6, 0.12885163,0.12885163,0.6, 0.218768858,0.218768858,0.66, 0.721068726,0.721068726,0.66, }, 
		{0, 0.466667, }, 
		{{0, 0, 100, }, {90, 90, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.297020374,0.297020374,0.166666667, 0.922230558,0.922230558,0.166666667, 0.622672912,0.622672912,0.833333333, 1,1,0.833333333, }, 
		{0.466667, 0.9, }, 
		{{90, 90, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.297020374,0.297020374,0.166666667, 0.922230558,0.922230558,0.166666667, 0.622672912,0.622672912,0.833333333, 1,1,0.833333333, }, 
		{0.9, 0.933333, }, 
		{{150, 150, 150, }, {150, 150, 150, }, }, 
		{6414, }, 
		{2, }, 
	}, 
},
	["LumiLayer_53-trs#endScale#number"] =
{
	{
		{0.7246089,0.7246089,0.6, 0.12885163,0.12885163,0.6, 0.218768858,0.218768858,0.66, 0.721068726,0.721068726,0.66, }, 
		{0, 0.8, }, 
		{{1, }, {1, }, }, 
		{6414, }, 
		{2, }, 
	}, 
	{
		{0.297020374,0.297020374,0.166666667, 0.922230558,0.922230558,0.166666667, 0.622672912,0.622672912,0.833333333, 1,1,0.833333333, }, 
		{0.8, 0.9, }, 
		{{1.5,  }, {1.5,  }, }, 
		{6414, }, 
		{2, }, 
	}, 
},
    ["LumiOpticsCompensation_67-effect0#fov#number"] =
{
	{
		{0.58878821, 0, 0.833333333, 0.833333333, }, 
		{0, 0.1, }, 
		{{166.6, }, {164.4, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.1, 0.133333, }, 
		{{164.4, }, {161, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.755555556, }, 
		{0.133333, 0.166667, }, 
		{{161, }, {153.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.126436782, 0.629553862, 0.511536832, }, 
		{0.166667, 0.2, }, 
		{{153.5, }, {139, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.170358085, 0.24113578, 0.436658224, 0.859725865, }, 
		{0.2, 0.466667, }, 
		{{139, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.731711696, 0, }, 
		{0.466667, 1.666667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.563341776, 0.128567006, 0.829641915, 0.778989154, }, 
		{1.666667, 1.9, }, 
		{{0, }, {132.7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.370446138, 0.387033657, 0.833333333, 0.869763206, }, 
		{1.9, 1.933333, }, 
		{{132.7, }, {151, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.231391586, 0.833333333, 0.833333333, }, 
		{1.933333, 1.966667, }, 
		{{151, }, {161.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.966667, 2, }, 
		{{161.3, }, {167.096116, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.494894104, 1, }, 
		{2, 2.1, }, 
		{{167.096116, }, {170.544044, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiBlit_103-effect0#twist#number"] =
{
	{
		{0.301500724, 0, 0.448856894, 1, }, 
		{0, 0.3, }, 
		{{0, }, {250, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.409108996, 0, 0.517491842, 0.84550068, }, 
		{0.3, 0.466667, }, 
		{{250, }, {43.403069, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.251294656, 0.817419025, 0.530866276, 1, }, 
		{0.466667, 0.9, }, 
		{{43.403069, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiBlit_103-effect0#speed#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.0, 0.4, }, 
		{{0, }, {108, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.4, 0.633333, }, 
		{{108, }, {154.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.633333, 0.8, }, 
		{{154.2, }, {179.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiRadialBlur_103-effect1#amount#number"] =
{
	{
		{0.466595883, 0, 0.812744305, 0.898444515, }, 
		{0, 0.233333, }, 
		{{250, }, {60, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.234866086, 0.988710205, 0.794646046, 1, }, 
		{0.233333, 0.9, }, 
		{{60, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiExposure_103-effect2#exposure#number"] =
{
	{
		{0.382943766, 0, 0.771714343, 1, }, 
		{0, 0.3, }, 
		{{0, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.096289582, 0, 0.386818094, 1, }, 
		{0.3, 0.9, }, 
		{{0.9, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiBlit_103-effect3#scaleEnd#number"] =
{
	{
		{0.39, 0, 0.33, 1, }, 
		{0, 0.3, }, 
		{{1, }, {1.28, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.27, 0, 0.54, 0.97, }, 
		{0.3, 0.9, }, 
		{{1.28, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiBlit_103-effect3#scaleStart#number"] =
{
	{
		{0.39, 0, 0.33, 1, }, 
		{0, 0.3, }, 
		{{1, }, {0.88, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.27, 0, 0.54, 0.97, }, 
		{0.3, 0.9, }, 
		{{0.88, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
["LumiBlit_103-effect3#falloff#number"] =
{
	{
		{0.39, 0, 0.33, 1, }, 
		{0, 0.7, }, 
		{{10, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.27, 0, 0.54, 0.97, }, 
		{0.7, 0.9, }, 
		{{10, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
["LumiLayer_103-trs#endScale#number"] =
{
	{
		{0.7246089,0.7246089,0.6, 0.12885163,0.12885163,0.6, 0.218768858,0.218768858,0.66, 0.721068726,0.721068726,0.66, }, 
		{0, 0.8, }, 
		{{1, }, {1, }, }, 
		{6414, }, 
		{2, }, 
	}, 
	{
		{0.297020374,0.297020374,0.166666667, 0.922230558,0.922230558,0.166666667, 0.622672912,0.622672912,0.833333333, 1,1,0.833333333, }, 
		{0.8, 0.9, }, 
		{{0.666666,  }, {0.666666,  }, }, 
		{6414, }, 
		{2, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_transitionInputIndex = {
    {"LumiLayer_53-trs", "InputTex", 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_sliderInfos = {
}
data.ae_sliderInfos = ae_sliderInfos

local ae_fadeoutInfos = {
    time = 0,
    infos = {
    }
}
data.ae_fadeoutInfos = ae_fadeoutInfos


return data
