local data = {}

local ae_durations = {
    ["LumiLayer_25-matte"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["maskTex"] = {{0, 1.4},},
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiExposure_113-effect0"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiLayer_104-trs"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiLayer_105-trs-blend"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 1.4},},
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiLayer_117-trs-blend"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 1.4},},
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiLayer_118-trs-blend"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 1.4},},
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiLayer_112-trs-blend"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 1.4},},
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiLayer_113-trs-blend"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 1.4},},
            ["InputTex"] = {{0.766667, 1.4},},
        },
    },
    ["LumiWarp_124-effect0"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiDirectionalBlurs_124-effect1"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 1.4},},
        },
    },
    ["LumiLayer_124-blend"] = {
        ["nodeDuration"] = {{0, 1.4},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 1.4},},
            ["InputTex"] = {{0, 1.4},},
        },
    },
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 1.400000}
data.ae_compDurations = ae_compDurations

local ae_effectType = "videoAnimation" 
data.ae_effectType = ae_effectType

local ae_attribute = {
    ["LumiLayer_25-matte"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = true,
        ["hasTransform"] = false,
        ["layerType"] = "Precomp",
        ["matteMode"] = "Alpha",
    },
    ["LumiExposure_113-effect0"] = {
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
    ["LumiLayer_104-trs"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 720, 0),
        ["position"] = Amaz.Vector3f(984, 0, 0),
        ["scale"] = Amaz.Vector3f(40, 40, 40),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 111.767,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.5978,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(-952.878, 638.378, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.5978,
        ["p1_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p1_position"] = Amaz.Vector3f(540, 720, 0),
        ["p1_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p1_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p1_xRotation"] = 0,
        ["p1_yRotation"] = 0,
        ["p1_rotation"] = -18,
        ["p1_opacity"] = 100,
        ["p1_active_cam_fovx"] = 39.5978,
        ["compositeSize"] = Amaz.Vector2f(1080, 1440),
        ["layerSize"] = Amaz.Vector2f(1080, 1440),
        ["mirrorEdge"] = false,
    },
    ["LumiLayer_105-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 720, 0),
        ["position"] = Amaz.Vector3f(492, 0, 0),
        ["scale"] = Amaz.Vector3f(40, 40, 40),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.5978,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(-952.878, 638.378, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.5978,
        ["p1_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p1_position"] = Amaz.Vector3f(540, 720, 0),
        ["p1_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p1_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p1_xRotation"] = 0,
        ["p1_yRotation"] = 0,
        ["p1_rotation"] = -18,
        ["p1_opacity"] = 100,
        ["p1_active_cam_fovx"] = 39.5978,
        ["compositeSize"] = Amaz.Vector2f(1080, 1440),
        ["layerSize"] = Amaz.Vector2f(1080, 1440),
        ["mirrorEdge"] = true,
        ["blendMode"] = "Normal",
    },
    ["LumiLayer_117-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 720, 0),
        ["position"] = Amaz.Vector3f(984, 0, 0),
        ["scale"] = Amaz.Vector3f(40, 40, 40),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.5978,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(-1285.17, -634.289, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.5978,
        ["p1_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p1_position"] = Amaz.Vector3f(540, 720, 0),
        ["p1_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p1_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p1_xRotation"] = 0,
        ["p1_yRotation"] = 0,
        ["p1_rotation"] = -18,
        ["p1_opacity"] = 100,
        ["p1_active_cam_fovx"] = 39.5978,
        ["compositeSize"] = Amaz.Vector2f(1080, 1440),
        ["layerSize"] = Amaz.Vector2f(1080, 1440),
        ["mirrorEdge"] = true,
        ["blendMode"] = "Normal",
    },
    ["LumiLayer_118-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 720, 0),
        ["position"] = Amaz.Vector3f(492, 0, 0),
        ["scale"] = Amaz.Vector3f(40, 40, 40),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.5978,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(-1285.17, -634.289, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.5978,
        ["p1_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p1_position"] = Amaz.Vector3f(540, 720, 0),
        ["p1_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p1_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p1_xRotation"] = 0,
        ["p1_yRotation"] = 0,
        ["p1_rotation"] = -18,
        ["p1_opacity"] = 100,
        ["p1_active_cam_fovx"] = 39.5978,
        ["compositeSize"] = Amaz.Vector2f(1080, 1440),
        ["layerSize"] = Amaz.Vector2f(1080, 1440),
        ["mirrorEdge"] = false,
        ["blendMode"] = "Normal",
    },
    ["LumiLayer_112-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 720, 0),
        ["position"] = Amaz.Vector3f(0, 0, 0),
        ["scale"] = Amaz.Vector3f(40, 40, 40),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = -180,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.5978,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(989.239, -5.7094e-14, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.5978,
        ["p1_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p1_position"] = Amaz.Vector3f(540, 720, 0),
        ["p1_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p1_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p1_xRotation"] = 0,
        ["p1_yRotation"] = 0,
        ["p1_rotation"] = -18,
        ["p1_opacity"] = 100,
        ["p1_active_cam_fovx"] = 39.5978,
        ["compositeSize"] = Amaz.Vector2f(1080, 1440),
        ["layerSize"] = Amaz.Vector2f(1080, 1440),
        ["mirrorEdge"] = true,
        ["blendMode"] = "Normal",
    },
    ["LumiLayer_113-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(540, 720, 0),
        ["position"] = Amaz.Vector3f(913.992, 598.483, 0),
        ["scale"] = Amaz.Vector3f(40, 40, 40),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = -180,
        ["rotation"] = 18,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.5978,
        ["compositeSize"] = Amaz.Vector2f(1080, 1440),
        ["layerSize"] = Amaz.Vector2f(1080, 1440),
        ["mirrorEdge"] = false,
        ["blendMode"] = "Normal",
    },
    ["LumiWarp_124-effect0"] = {
        ["warpStyle"] = 12,
        ["warpAxis"] = 0,
        ["bend"] = 26.9571,
    },
    ["LumiDirectionalBlurs_124-effect1"] = {
        ["intensity"] = 63.0706,
        ["angle"] = 72,
        ["directionNum"] = 1,
        ["exposure"] = 1,
        ["quality"] = 0.33,
        ["spaceDither"] = 0,
        ["borderType"] = 0,
        ["blendMode"] = 2,
    },
    ["LumiLayer_124-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Adjustment",
        ["blendMode"] = "Normal",
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ["LumiExposure_113-effect0#exposure#number"] =
{
	{
		{0.661128802, 0.027488766, 0.823431926, 1, }, 
		{0.766667, 1, }, 
		{{0, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.124426825, 0, 0.245854275, 0.88754721, }, 
		{1, 1.4, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiExposure_113-effect0#filetInt#number"] =
{
	{
		{0.661128802, 0.027488766, 0.823431926, 1, }, 
		{1.2, 1.4, }, 
		{{0.09, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_104-trs#yRotation#number"] =
{
	{
		{0.3, 0, 0.47, 0.968421053, }, 
		{0.066667, 0.733333, }, 
		{{180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_104-trs#p0_position#vector"] =
{
	{
		{0.001, 0.420978, 0.27, 0.812899, }, 
		{0, 1.4, }, 
		{{-2000.240055332, 638.378134567, 0, }, {-175.240055332, 638.378134567, 0, }, {-2000.240055332, 638.378134567, 0, }, {-175.240055332, 638.378134567, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_105-trs-blend#p0_position#vector"] =
{
	{
		{0.001, 0.420978, 0.27, 0.812899, }, 
		{0, 1.4, }, 
		{{-2000.240055332, 638.378134567, 0, }, {-175.240055332, 638.378134567, 0, }, {-2000.240055332, 638.378134567, 0, }, {-175.240055332, 638.378134567, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_117-trs-blend#p0_position#vector"] =
{
	{
		{0.001, 0.389473, 0.27, 0.826901, }, 
		{0.2, 1.4, }, 
		{{-1857.093755341, -634.288897041, 0, }, {-292.093755341, -634.288897041, 0, }, {-1857.093755341, -634.288897041, 0, }, {-292.093755341, -634.288897041, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_118-trs-blend#yRotation#number"] =
{
	{
		{0.3, 0, 0.47, 0.966842105, }, 
		{0.433333, 1.133333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_118-trs-blend#p0_position#vector"] =
{
	{
		{0.001, 0.389473, 0.27, 0.826901, }, 
		{0.2, 1.4, }, 
		{{-1857.093755341, -634.288897041, 0, }, {-292.093755341, -634.288897041, 0, }, {-1857.093755341, -634.288897041, 0, }, {-292.093755341, -634.288897041, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_112-trs-blend#p0_position#vector"] =
{
	{
		{0.001, 0.43875, 0.27, 0.805, }, 
		{0.1, 1.4, }, 
		{{1960, 0, 0, }, {27, 0, 0, }, {1960, 0, 0, }, {27, 0, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
["LumiLayer_112-trs-blend#bool_poker#number"] =
{
    {
		{0.3, 0, 0.47, 0.968421053, }, 
		{0.0, 0.766667, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.001, 0.389473, 0.27, 0.826901, }, 
		{0.766667, 0.766667, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
["LumiLayer_112-trs-blend#number_poker#number"] =
{
    {
		{0.3, 0, 0.47, 0.968421053, }, 
		{0.0, 0.7333334, }, 
		{{1, }, {1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.001, 0.389473, 0.27, 0.826901, }, 
		{0.7, 0.766667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_113-trs-blend#position#vector"] =
{
	{
		{0.001, 0, 0.7, 1, }, 
		{0.766667, 1.4, }, 
		{{913.992268314, 598.482545786, 0, }, {540, 720, 0, }, {913.992268314, 598.482545786, 0, }, {540, 720, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
["LumiLayer_113-trs-blend#position2#vector"] =
{
    {{0.003137, 0, 0.367732, 0.423513, }, {0.766667, 0.8, }, {{913.992268314, 598.482545786, 0, }, {885.850903662, 616.412260123, 0, }, }, }, 
    {{0.254658, 0.255179, 0.596162, 0.627635, }, {0.8, 0.866667, }, {{885.850903662, 616.412260123, 0, }, {832.383803113, 645.198752893, 0, }, }, }, 
    {{0.283272, 0.307975, 0.627885, 0.644193, }, {0.866667, 1, }, {{832.383803113, 645.198752893, 0, }, {735.601545086, 680.445205388, 0, }, }, }, 
    {{0.342629, 0.507278, 0.755207, 1, }, {1, 1.4, }, {{735.601545086, 680.445205388, 0, }, {540, 720, 0, }, }, }, 



},
    ["LumiLayer_113-trs-blend#scale#vector"] =
{
	{
		{0.69,0.69,0.69, 0,0,0, 0.09,0.09,0.09, 0.91,0.91,0.91, }, 
		{0.766667, 1.4, }, 
		{{40, 40, 40, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_113-trs-blend#yRotation#number"] =
{
	{
		{0.29, 0, 0.34, 1, }, 
		{0.766667, 1.4, }, 
		{{-180, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_113-trs-blend#rotation#number"] =
{
	{
		{0.4, 0, 0.41, 1, }, 
		{0.766667, 1.4, }, 
		{{18, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiLayer_113-trs-blend#number_poker2#number"] =
{
	{
		{0.4, 0, 0.41, 1, }, 
		{0.8, 1.4, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiWarp_124-effect0#bend#number"] =
{
	{
		{0.234707483, 0, 0.758131415, 1, }, 
		{0, 0.866667, }, 
		{{30, }, {20, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33, 0, 0.58, 1, }, 
		{0.866667, 1.4, }, 
		{{20, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ["LumiDirectionalBlurs_124-effect1#intensity#number"] =
{
	{
		{0.28, 0, 0.58, 1, }, 
		{0.1, 0.5, }, 
		{{150, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_transitionInputIndex = {
    {"LumiLayer_25-matte", "InputTex", 0},
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
