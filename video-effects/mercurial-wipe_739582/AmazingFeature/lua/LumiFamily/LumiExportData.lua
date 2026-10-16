local data = {}

local ae_durations = {
    ["LumiAnimSeqLoadAndCrop_650-effect0"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["seqTex"] = {{0.266667, 1.1},},
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiGaussianBlur_529-effect1"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiGlow_529-effect2"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiLayer_529-trs"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiAnimSeqLoadAndCrop_638-effect0"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["seqTex"] = {{0.266667, 1.1},},
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiExposure_638-effect2"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiLayer_638-blend"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 3},},
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiLayer_650-trs-blend"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 3},},
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiNegative_596-effect1"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiGaussianBlur_596-effect2"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiLayer_596-trs"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiLayer_652-trs-blend"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 3},},
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiMultiFrameDisplacement_533-effect0"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["maskImage"] = {{0, 3},},
            ["InputTex"] = {{0, 3},},
        },
    },
    ["LumiLayer_533-blend"] = {
        ["nodeDuration"] = {{0, 3},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 3},},
            ["InputTex"] = {{0, 3},},
        },
    },
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 1.500000}
data.ae_compDurations = ae_compDurations

local ae_effectType = "videoAnimation" 
data.ae_effectType = ae_effectType

local ae_attribute = {
    ["LumiAnimSeqLoadAndCrop_650-effect0"] = {
        ["cropType"] = 0,
        ["edgeType"] = 0,
        ["enableVideoAlphaBlend"] = false,
        ["opacity"] = 1,
        ["scale"] = 1,
        ["speed"] = 1,
    },
    ["LumiGaussianBlur_529-effect1"] = {
        ["intensity"] = 30,
        ["quality"] = 0.5,
        ["spaceDither"] = 0,
        ["horizontalStrength"] = 1,
        ["verticalStrength"] = 1,
        ["blurDirection"] = 0,
        ["borderType"] = 0,
        ["blurAlpha"] = true,
        ["inverseGammaCorrection"] = true,
    },
    ["LumiGlow_529-effect2"] = {
        ["threshold"] = 0.98,
        ["radius"] = 51,
        ["glowIntensity"] = 0,
        ["blendMode"] = 0,
        ["show"] = 0,
        ["glowColor"] = 1,
        ["colorLooping"] = 0,
        ["colorLoops"] = 1,
        ["colorPhase"] = 0,
        ["midpoint"] = 0.5,
        ["colorA"] = Amaz.Color(1, 1, 1, 1),
        ["colorB"] = Amaz.Color(0.406371, 0.524867, 1, 1),
        ["glowDimensions"] = 0,
        ["quality"] = 0.2,
    },
    ["LumiLayer_529-trs"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, 540, 0),
        ["scale"] = Amaz.Vector3f(200.615, 200.615, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = -14.911,
        ["opacity"] = 0,
        ["active_cam_fovx"] = 39.6,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(1080, 1080),
        ["mirrorEdge"] = true,
    },
    ["LumiAnimSeqLoadAndCrop_638-effect0"] = {
        ["cropType"] = 0,
        ["edgeType"] = 0,
        ["enableVideoAlphaBlend"] = false,
        ["opacity"] = 1,
        ["scale"] = 1,
        ["speed"] = 1,
    },
    ["LumiExposure_638-effect2"] = {
        ["channelType"] = 0,
        ["exposure"] = 0.7,
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
    ["LumiLayer_638-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Solid",
        ["blendMode"] = "Add",
    },
    ["LumiLayer_650-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Solid",
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, 127, 0),
        ["scale"] = Amaz.Vector3f(100, 100, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 180,
        ["opacity"] = 55,
        ["active_cam_fovx"] = 39.6,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(1080, 1080),
        ["mirrorEdge"] = false,
        ["blendMode"] = "Add",
    },
    ["LumiNegative_596-effect1"] = {
        ["negativeAlpha"] = 1,
    },
    ["LumiGaussianBlur_596-effect2"] = {
        ["intensity"] = 181,
        ["quality"] = 1,
        ["spaceDither"] = 0,
        ["horizontalStrength"] = 1,
        ["verticalStrength"] = 1,
        ["blurDirection"] = 0,
        ["borderType"] = 0,
        ["blurAlpha"] = true,
        ["inverseGammaCorrection"] = false,
    },
    ["LumiLayer_596-trs"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Image",
        ["anchorPoint"] = Amaz.Vector3f(360, 360, 0),
        ["position"] = Amaz.Vector3f(540, 540, 0),
        ["scale"] = Amaz.Vector3f(150, 150, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.6,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(720, 720),
        ["mirrorEdge"] = false,
    },
    ["LumiLayer_652-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Solid",
        ["anchorPoint"] = Amaz.Vector3f(540, 540, 0),
        ["position"] = Amaz.Vector3f(540, 540, 0),
        ["scale"] = Amaz.Vector3f(100, 100, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 0,
        ["active_cam_fovx"] = 39.6,
        ["compositeSize"] = Amaz.Vector2f(1080, 1080),
        ["layerSize"] = Amaz.Vector2f(1080, 1080),
        ["mirrorEdge"] = false,
        ["blendMode"] = "Normal",
    },
    ["LumiMultiFrameDisplacement_533-effect0"] = {
        ["frameNums"] = 8.02857,
        ["softEdge"] = true,
    },
    ["LumiLayer_533-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Adjustment",
        ["blendMode"] = "Normal",
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ["LumiAnimSeqLoadAndCrop_650-effect0#seqTime#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.26666666666667, 1.1, }, 
		{{0, }, {0.83333333333333, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ["LumiGaussianBlur_529-effect1#intensity#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.233333, 0.966667, }, 
		{{0, }, {30, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ["LumiGlow_529-effect2#threshold#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.433333, }, 
		{{1, }, {0.54, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.433333, 0.666667, }, 
		{{0.54, }, {0.7, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.666667, 1.033333, }, 
		{{0.7, }, {0.98, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ["LumiGlow_529-effect2#glowIntensity#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.166667, 0.433333, }, 
		{{0, }, {0.64, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.433333, 0.666667, }, 
		{{0.64, }, {0.58, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.666667, 1.033333, }, 
		{{0.58, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ["LumiLayer_529-trs#scale#vector"] =
{
	{
		{0.166666667,0.166666667,0.166666667, 0.024928775,0.024928775,0.166666667, 0.833333333,0.833333333,0.833333333, 1,1,0.833333333, }, 
		{0.2, 1.133333, }, 
		{{100, 100, 100, }, {204, 204, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_529-trs#rotation#number"] =
{
	{
		{0.234268933, 0, 0.270409083, 0.991647665, }, 
		{0.366667, 1.133333, }, 
		{{0, }, {-15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_529-trs#opacity#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.6, 1.033333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiAnimSeqLoadAndCrop_638-effect0#seqTime#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.26666666666667, 1.1, }, 
		{{0, }, {0.83333333333333, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ["LumiLayer_652-trs-blend#opacity#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.2, }, 
		{{55, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ["LumiMultiFrameDisplacement_533-effect0#frameNums#number"] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.466667, 1.166667, }, 
		{{11.8, }, {7.4, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.166667, 1.5, }, 
		{{7.4, }, {1, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_transitionInputIndex = {
    {"LumiGaussianBlur_529-effect1", "InputTex", 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

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
    speedInfo = {1, 0, 1, },
}
data.ae_animationInfos = ae_animationInfos


return data
