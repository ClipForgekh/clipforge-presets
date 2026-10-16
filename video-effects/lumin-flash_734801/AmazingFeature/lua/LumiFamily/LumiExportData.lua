local data = {}

local ae_durations = {
    ["LuaStrongSharpen_18-effect0"] = {{0, 0.4},},
    ["lumi_motion_blur_2d_18-effect1"] = {{0, 0.4},},
    ["S_Glow_47-effect0"] = {{0, 0.4},},
    ["AdjustGlow_47-effect1"] = {{0, 0.4},},
    ["BCCGlow_47-effect2"] = {{0, 0.4},},
    ["LumiDirectionBlur_47-effect3"] = {{0, 0.4},},
    ["LumiLayerBlend_47-blend"] = {{0, 0.4},},
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 0.400000}
data.ae_compDurations = ae_compDurations

local ae_durationMode = 0 
data.ae_durationMode = ae_durationMode

local ae_disappearTime = 0.000000 
data.ae_disappearTime = ae_disappearTime

local ae_effectType = "videoAnimation" 
data.ae_effectType = ae_effectType

local ae_attribute = {
    ["LuaStrongSharpen_18-effect0"] = {
        ["strength"] = 0,
        ["range"] = 0,
        ["steps"] = 1,
        ["offsetX"] = -0.02,
        ["offsetY"] = 0.15,
    },
    ["lumi_motion_blur_2d_18-effect1"] = {
        ["rotate"] = 0,
        ["ae_pre_rotate"] = 0,
        ["anchor"] = Amaz.Vector2f(0.5, 0.5),
        ["ae_pre_anchor"] = Amaz.Vector2f(0.5, 0.5),
        ["position"] = Amaz.Vector2f(0.5, 0.5),
        ["ae_pre_position"] = Amaz.Vector2f(0.5, 0.5),
        ["scale_x"] = 1,
        ["ae_pre_scale_x"] = 1,
        ["scale_y"] = 0.986974,
        ["ae_pre_scale_y"] = 0.986974,
        ["vIntensity"] = 0,
        ["ae_pre_vIntensity"] = 0,
        ["vCenter"] = -0.25,
        ["ae_pre_vCenter"] = -0.25,
        ["minSamples"] = 0.02,
        ["ae_pre_minSamples"] = 0.02,
        ["maxSamples"] = 0.24,
        ["ae_pre_maxSamples"] = 0.24,
        ["mirrorEdge"] = true,
        ["ae_pre_mirrorEdge"] = true,
        ["dither"] = 1,
        ["ae_pre_dither"] = 1,
    },
    ["S_Glow_47-effect0"] = {
        ["brightness"] = 0,
        ["glowColor"] = Amaz.Color(1, 1, 1, 1),
        ["threshold"] = 0.5,
        ["thresholdAddColor"] = Amaz.Color(0, 0, 0, 1),
        ["glowWidth"] = 0.1,
        ["widthX"] = 1,
        ["widthY"] = 1,
        ["widthRed"] = 1,
        ["widthGreen"] = 1.2,
        ["widthBlue"] = 1.4,
        ["show"] = 0,
        ["combine"] = 1,
        ["edgeMode"] = 1,
        ["glowFromAlpha"] = 0,
        ["glowUnderSource"] = 0,
        ["sourceOpacity"] = 1,
        ["quality"] = 0.2,
    },
    ["AdjustGlow_47-effect1"] = {
        ["threshold"] = 1,
        ["radius"] = 100,
        ["glowIntensity"] = 0,
        ["blendMode"] = 0,
        ["show"] = 0,
        ["glowColor"] = 0,
        ["colorLooping"] = 0,
        ["colorLoops"] = 1,
        ["colorPhase"] = 0,
        ["midpoint"] = 0.5,
        ["colorA"] = Amaz.Color(1, 1, 1, 1),
        ["colorB"] = Amaz.Color(0, 0, 0, 1),
        ["glowDimensions"] = 0,
    },
    ["BCCGlow_47-effect2"] = {
        ["show"] = 2,
        ["glowChannels"] = 0,
        ["glowThreshold"] = 0.5,
        ["glowRadius"] = 0,
        ["glowAspectRatio"] = 0,
        ["glowIntensity"] = 0,
        ["combine"] = 1,
        ["colorA"] = Amaz.Color(0, 0, 0, 1),
        ["colorB"] = Amaz.Color(1, 1, 1, 1),
    },
    ["LumiDirectionBlur_47-effect3"] = {
        ["angle"] = 0,
        ["intensity"] = 0,
        ["steps"] = 1,
        ["mirrorEdge"] = false,
        ["expandFlag"] = false,
    },
    ["LumiLayerBlend_47-blend"] = {
        ["blendMode"] = "Normal",
        ["layerType"] = "Adjustment",
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ["LuaStrongSharpen_18-effect0#offsetX#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.066667, }, 
		{{0, }, {-0.02, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.066667, 0.166667, }, 
		{{-0.02, }, {-0.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.166667, 0.5, }, 
		{{-0.1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LuaStrongSharpen_18-effect0#offsetY#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0, 0.066667, }, 
		{{0, }, {0.15, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.066667, 0.166667, }, 
		{{0.15, }, {0.25, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.243809522, 0.995117731, }, 
		{0.166667, 0.5, }, 
		{{0.25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["lumi_motion_blur_2d_18-effect1#ae_pre_position#vector"] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.20000033333333, 0.26666633333333, }, 
		{{0.5, 0.5, }, {0.5, 2.171875, }, {0.5, 0.5, }, {0.5, 2.171875, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 0.907021, }, 
		{0.26666633333333, 0.36666633333333, }, 
		{{0.5, 2.171875, }, {0.5, -0.09375, }, {0.5, 2.171875, }, {0.5, -0.09375, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.827842, 0.666667, 1, }, 
		{0.36666633333333, 0.60000033333333, }, 
		{{0.5, -0.09375, }, {0.5, 0.5, }, {0.5, -0.09375, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ["lumi_motion_blur_2d_18-effect1#position#vector"] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.166667, 0.233333, }, 
		{{0.5, 0.5, }, {0.5, 2.171875, }, {0.5, 0.5, }, {0.5, 2.171875, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0, 0.666667, 0.907021, }, 
		{0.233333, 0.333333, }, 
		{{0.5, 2.171875, }, {0.5, -0.09375, }, {0.5, 2.171875, }, {0.5, -0.09375, }, }, 
		{6415, }, 
		{0, }, 
	}, 
	{
		{0.333333, 0.827842, 0.666667, 1, }, 
		{0.333333, 0.566667, }, 
		{{0.5, -0.09375, }, {0.5, 0.5, }, {0.5, -0.09375, }, {0.5, 0.5, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ["lumi_motion_blur_2d_18-effect1#ae_pre_scale_x#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.20000033333333, 0.30000033333333, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.30000033333333, 0.53333333333333, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["lumi_motion_blur_2d_18-effect1#scale_x#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.166667, 0.266667, }, 
		{{1, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.266667, 0.5, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["lumi_motion_blur_2d_18-effect1#ae_pre_scale_y#number"] =
{
	{
		{1, 0.083054764, 0.833333333, 1, }, 
		{0.06666633333333, 0.20000033333333, }, 
		{{1, }, {0.7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.20000033333333, 0.30000033333333, }, 
		{{0.7, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.161226673, 0, 0.60318898, 0.670181914, }, 
		{0.30000033333333, 0.53333333333333, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.430283294, -10.2182655, 0.825173343, 0, }, 
		{0.53333333333333, 0.66666633333333, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["lumi_motion_blur_2d_18-effect1#scale_y#number"] =
{
	{
		{1, 0.083054764, 0.833333333, 1, }, 
		{0.033333, 0.166667, }, 
		{{1, }, {0.7, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0, 0.833333333, 1, }, 
		{0.166667, 0.266667, }, 
		{{0.7, }, {1.5, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.161226673, 0, 0.60318898, 0.670181914, }, 
		{0.266667, 0.5, }, 
		{{1.5, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.430283294, -10.2182655, 0.825173343, 0, }, 
		{0.5, 0.633333, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["S_Glow_47-effect0#brightness#number"] =
{
	{
		{1, -0.109458514, 0.66666667, 1, }, 
		{0, 0.333333, }, 
		{{0, }, {4.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.198095484, 1.002438202, }, 
		{0.333333, 0.5, }, 
		{{4.3, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["AdjustGlow_47-effect1#threshold#number"] =
{
	{
		{1, 0.007967969, 0.66666667, 1, }, 
		{0.1, 0.333333, }, 
		{{1, }, {0.21, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.927379843, 0, 0.66666667, 1, }, 
		{0.333333, 0.5, }, 
		{{0.21, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["AdjustGlow_47-effect1#glowIntensity#number"] =
{
	{
		{1, -0.038515336, 0.66666667, 1, }, 
		{0.1, 0.333333, }, 
		{{0, }, {0.35, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{1, -0.013755477, 0.66666667, 1, }, 
		{0.333333, 0.5, }, 
		{{0.35, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["BCCGlow_47-effect2#glowRadius#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.133333, 0.333333, }, 
		{{0, }, {21.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.253333466, 0.002862248, 0.42, 0.993446962, }, 
		{0.333333, 0.5, }, 
		{{21.3, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["BCCGlow_47-effect2#glowIntensity#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.133333, 0.333333, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.246666686, 0.059361494, 0.66666667, 1, }, 
		{0.333333, 0.5, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiDirectionBlur_47-effect3#intensity#number"] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.1, 0.266667, }, 
		{{0, }, {83, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.266667, 0.7, }, 
		{{83, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_transitionInputIndex = {
    {"LuaStrongSharpen_18-effect0", "InputTex", 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_sliderInfos = {
}
data.ae_sliderInfos = ae_sliderInfos


return data
