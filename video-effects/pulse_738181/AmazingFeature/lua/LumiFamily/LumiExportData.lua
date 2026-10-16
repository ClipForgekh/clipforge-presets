local data = {}

local ae_durations = {
    ["LumiLayer_53-trs"] = {
        ["nodeDuration"] = {{0, 0.8},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.8},},
        },
    },
    ["LumiOpticsCompensation_67-effect0"] = {
        ["nodeDuration"] = {{0, 0.8},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.8},},
        },
    },
    ["LumiLayer_67-blend"] = {
        ["nodeDuration"] = {{0, 0.8},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 0.8},},
            ["InputTex"] = {{0.1, 0.8},},
        },
    },
    ["LumiBlit_115-effect0"] = {
        ["nodeDuration"] = {{0, 0.8},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.8},},
        },
    },
    ["LumiRadialBlur_115-effect1"] = {
        ["nodeDuration"] = {{0, 0.8},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.8},},
        },
    },
    ["LumiExposure_115-effect2"] = {
        ["nodeDuration"] = {{0, 0.8},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.8},},
        },
    },
    ["LumiBlit_115-effect3"] = {
        ["nodeDuration"] = {{0, 0.8},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.8},},
        },
    },
    ["LumiLayer_115-trs"] = {
        ["nodeDuration"] = {{0, 0.8},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 0.8},},
        },
    },
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 0.800000}
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
        ["fov"] = 0.0,
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
    ["LumiBlit_115-effect0"] = {

    },
    ["LumiRadialBlur_115-effect1"] = {
        ["blurType"] = 2,
        ["amount"] = 0,
        ["quality"] = 0.05,
        ["center"] = Amaz.Vector2f(0.5, 0.5),
        ["weightDecay"] = 0.965,
        ["dither"] = 1,
        ["blurAlpha"] = true,
        ["inverseGammaCorrection"] = false,
        ["borderType"] = 0,
    },
    ["LumiExposure_115-effect2"] = {
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
    ["LumiBlit_115-effect3"] = {

    },
    ["LumiLayer_115-trs"] = {
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
		{0.395418011,0.395418011,0.166666667, 0,0,0.166666667, 0.718276562,0.718276562,0.833333333, 0.180432345,0.180432345,0.833333333, }, 
		{0.0, 0.333333, }, 
		{{100, 100, 100, }, {90, 90, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
	{
		{0.774419609,0.774419609,0.34, 0.334788364,0.334788364,0.34, 0.2753911,0.2753911,0.4, 0.880352058,0.880352058,0.4, }, 
		{0.333333, 0.7666667, }, 
		{{90, 90, 100, }, {0, 0, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
	["LumiLayer_53-trs#endScale#number"] =
{
	{
		{0.7246089,0.7246089,0.6, 0.12885163,0.12885163,0.6, 0.218768858,0.218768858,0.66, 0.721068726,0.721068726,0.66, }, 
		{0, 0.066666, }, 
		{{1.5, }, {1.5, }, }, 
		{6414, }, 
		{2, }, 
	}, 
	{
		{0.297020374,0.297020374,0.166666667, 0.922230558,0.922230558,0.166666667, 0.622672912,0.622672912,0.833333333, 1,1,0.833333333, }, 
		{0.066666, 0.2, }, 
		{{1.,  }, {1.,  }, }, 
		{6414, }, 
		{2, }, 
	}, 
},
    ["LumiOpticsCompensation_67-effect0#fov#number"] =
{
	{
		{0.166666667, 0, 0.731711696, 0, }, 
		{0.0, 0.333334, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.563341776, 0.128567006, 0.829641915, 0.778989154, }, 
		{0.333334, 0.5666667, }, 
		{{0, }, {132.7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.370446138, 0.387033657, 0.833333333, 0.869763206, }, 
		{0.5666667, 0.6, }, 
		{{132.7, }, {151, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.231391586, 0.833333333, 0.833333333, }, 
		{0.6, 0.633333, }, 
		{{151, }, {161.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.6, 0.6666667, }, 
		{{161.3, }, {167.096116, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.494894104, 1, }, 
		{0.6666667, 0.76666667, }, 
		{{167.096116, }, {170.544044, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiBlit_115-effect0#twist#number"] =
{
	{
		{0.884393324, 0, 0.784521716, 1, }, 
		{0, 0.466667, }, 
		{{0, }, {250, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.422766861, 0, 0.498538805, 0.955877206, }, 
		{0.466667, 0.8, }, 
		{{250, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiBlit_115-effect0#speed#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333,}, 
		{0, 0.166667, }, 
		{{0, }, {15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333,}, 
		{0.166667, 0.3, }, 
		{{15, }, {32.6, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.3, 0.8, }, 
		{{32.6, }, {135.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},

    ["LumiRadialBlur_115-effect1#amount#number"] =
{
	{
		{0.205353954, 0, 0.765133914, 0.209031836, }, 
		{0, 0.533333, }, 
		{{0, }, {60, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.155528739, 0.09197173, 0.474146968, 1, }, 
		{0.533333, 0.8, }, 
		{{60, }, {250, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiExposure_115-effect2#exposure#number"] =
{
	{
		{0.537194924, 0, 0.868031929, 1, }, 
		{0, 0.466667, }, 
		{{0, }, {0.9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.210194535, 0, 0.532185419, 1, }, 
		{0.466667, 0.8, }, 
		{{0.9, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiBlit_115-effect3#scaleEnd#number"] =
{
	{
		{0.54, 0, 0.67, 1, }, 
		{0, 0.466667, }, 
		{{1, }, {1.28, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.67, 0, 0.64, 1, }, 
		{0.466667, 0.8, }, 
		{{1.28, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
["LumiBlit_115-effect3#falloff#number"] =
{
	{
		{0.54, 0, 0.67, 1, }, 
		{0, 0.2, }, 
		{{0, }, {10., }, }, 
		{6417, }, 
		{0, }, 
	}, 

},
-- 	["LumiBlit_115-effect3#falloff#numbe"] =
-- {
-- 	{
-- 		{0.39, 0, 0.33, 1, }, 
-- 		{0, 0.2, }, 
-- 		{{0, }, {10, }, }, 
-- 		{6417, }, 
-- 		{0, }, 
-- 	}, 
-- },
    ["LumiBlit_115-effect3#scaleStart#number"] =
{
	{
		{0.54, 0, 0.67, 1, }, 
		{0, 0.466667, }, 
		{{1, }, {0.88, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.67, 0, 0.64, 1, }, 
		{0.466667, 0.8, }, 
		{{0.88, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
["LumiLayer_115-trs#endScale#number"] =
{
	{
		{0.7246089,0.7246089,0.6, 0.12885163,0.12885163,0.6, 0.218768858,0.218768858,0.66, 0.721068726,0.721068726,0.66, }, 
		{0, 0.066666, }, 
		{{0.66666, }, {0.666666, }, }, 
		{6414, }, 
		{2, }, 
	}, 
	{
		{0.297020374,0.297020374,0.166666667, 0.922230558,0.922230558,0.166666667, 0.622672912,0.622672912,0.833333333, 1,1,0.833333333, }, 
		{0.066666, 0.2, }, 
		{{1.,  }, {1.,  }, }, 
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
