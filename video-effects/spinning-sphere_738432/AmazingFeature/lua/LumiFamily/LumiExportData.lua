local data = {}

local ae_durations = {
    ["LumiAnimSeqLoadAndCrop_960-effect0"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["seqTex"] = {{0, 6.66667},},
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiLayer_960-trs"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiWarp_544-effect0"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiLightSensation_544-effect1"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiLayer_544-trs-matte-blend"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["maskTex"] = {{0, 6.66667},},
            ["baseTex"] = {{0, 6.66667},},
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiAnimSeqLoadAndCrop_964-effect0"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["seqTex"] = {{0, 0.933333},},
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiAnimSeqLoadAndCrop_962-effect0"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["seqTex"] = {{0, 6.66667},},
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiLayer_962-trs-blend"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 6.66667},},
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiRadialBlur_548-effect0"] = {
        ["nodeDuration"] = {{0, 1.03333},},
        ["texDuration"] = {
            ["InputTex"] = {{0, 6.66667},},
        },
    },
    ["LumiLayer_548-blend"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 6.66667},},
            ["InputTex"] = {{0, 1.03333},},
        },
    },
    ["LumiLayer_964-trs-blend"] = {
        ["nodeDuration"] = {{0, 6.66667},},
        ["texDuration"] = {
            ["baseTex"] = {{0, 6.66667},},
            ["InputTex"] = {{0, 6.66667},},
        },
    },
}
data.ae_durations = ae_durations

local ae_compDurations = {0.000000, 1.033333}
data.ae_compDurations = ae_compDurations

local ae_effectType = "videoAnimation" 
data.ae_effectType = ae_effectType

local ae_attribute = {
    ["LumiAnimSeqLoadAndCrop_960-effect0"] = {
        ["cropType"] = 2,
        ["edgeType"] = 3,
        ["enableVideoAlphaBlend"] = false,
        ["opacity"] = 1,
        ["scale"] = 1,
        ["speed"] = 1,
    },
    ["LumiLayer_960-trs"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Solid",
        ["anchorPoint"] = Amaz.Vector3f(638.5, 640, 0),
        ["position"] = Amaz.Vector3f(-1.5, 0, 0),
        ["scale"] = Amaz.Vector3f(165.157, 165, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.6,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(641.5, 640, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.6,
        ["compositeSize"] = Amaz.Vector2f(1280, 1280),
        ["layerSize"] = Amaz.Vector2f(1277, 1280),
        ["mirrorEdge"] = false,
    },
    ["LumiWarp_544-effect0"] = {
        ["warpStyle"] = 11,
        ["warpAxis"] = 0,
        ["bend"] = 0,
    },
    ["LumiLightSensation_544-effect1"] = {
        ["intensity"] = 0,
    },
    ["LumiLayer_544-trs-matte-blend"] = {
        ["hasBlend"] = false,
        ["hasMatte"] = true,
        ["hasTransform"] = true,
        ["layerType"] = "Precomp",
        ["anchorPoint"] = Amaz.Vector3f(640, 640, 0),
        ["position"] = Amaz.Vector3f(-1.13687e-13, -1.13687e-13, 0),
        ["scale"] = Amaz.Vector3f(100, 100, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.6,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(641.5, 640, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.6,
        ["compositeSize"] = Amaz.Vector2f(1280, 1280),
        ["layerSize"] = Amaz.Vector2f(1280, 1280),
        ["mirrorEdge"] = true,
        ["matteMode"] = "Alpha",
        ["blendMode"] = "Normal",
    },
    ["LumiAnimSeqLoadAndCrop_964-effect0"] = {
        ["cropType"] = 2,
        ["edgeType"] = 3,
        ["enableVideoAlphaBlend"] = false,
        ["opacity"] = 1,
        ["scale"] = 1,
        ["speed"] = 1,
    },
    ["LumiAnimSeqLoadAndCrop_962-effect0"] = {
        ["cropType"] = 2,
        ["edgeType"] = 3,
        ["enableVideoAlphaBlend"] = false,
        ["opacity"] = 1,
        ["scale"] = 1,
        ["speed"] = 1,
    },
    ["LumiLayer_962-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Solid",
        ["anchorPoint"] = Amaz.Vector3f(638.5, 640, 0),
        ["position"] = Amaz.Vector3f(-1.5, 0, 0),
        ["scale"] = Amaz.Vector3f(165, 165, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 100,
        ["active_cam_fovx"] = 39.6,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(641.5, 640, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.6,
        ["compositeSize"] = Amaz.Vector2f(1280, 1280),
        ["layerSize"] = Amaz.Vector2f(1277, 1280),
        ["mirrorEdge"] = false,
        ["blendMode"] = "HardLight",
    },
    ["LumiRadialBlur_548-effect0"] = {
        ["blurType"] = 4,
        ["amount"] = 0,
        ["quality"] = 0.1,
        ["center"] = Amaz.Vector2f(0.5, 0.5),
        ["weightDecay"] = 0.965,
        ["dither"] = 1,
        ["blurAlpha"] = true,
        ["inverseGammaCorrection"] = false,
        ["borderType"] = 0,
    },
    ["LumiLayer_548-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = false,
        ["layerType"] = "Adjustment",
        ["blendMode"] = "Normal",
    },
    ["LumiLayer_964-trs-blend"] = {
        ["hasBlend"] = true,
        ["hasMatte"] = false,
        ["hasTransform"] = true,
        ["layerType"] = "Solid",
        ["anchorPoint"] = Amaz.Vector3f(638.5, 640, 0),
        ["position"] = Amaz.Vector3f(-1.5, 0, 0),
        ["scale"] = Amaz.Vector3f(100, 100, 100),
        ["orientation"] = Amaz.Vector3f(0, 0, 0),
        ["xRotation"] = 0,
        ["yRotation"] = 0,
        ["rotation"] = 0,
        ["opacity"] = 0,
        ["active_cam_fovx"] = 39.6,
        ["p0_anchorPoint"] = Amaz.Vector3f(0, 0, 0),
        ["p0_position"] = Amaz.Vector3f(641.5, 640, 0),
        ["p0_scale"] = Amaz.Vector3f(100, 100, 100),
        ["p0_orientation"] = Amaz.Vector3f(0, 0, 0),
        ["p0_xRotation"] = 0,
        ["p0_yRotation"] = 0,
        ["p0_rotation"] = 0,
        ["p0_opacity"] = 100,
        ["p0_active_cam_fovx"] = 39.6,
        ["compositeSize"] = Amaz.Vector2f(1280, 1280),
        ["layerSize"] = Amaz.Vector2f(1277, 1280),
        ["mirrorEdge"] = false,
        ["blendMode"] = "Normal",
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ["LumiLayer_960-trs#scale#vector"] =
    {
        {
            {0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
            {0, 0.3, }, 
            {{165.156617071, 165, 100, }, {115, 115, 100, }, }, 
            {6414, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_960-trs#p0_position#vector"] =
    {
        {
            {0.913674, 0, 0.778001, 1, }, 
            {0, 1.033333, }, 
            {{640, 640, 0, }, {87.029008784, -816.554028411, 0, }, {-408, 260, 0, }, {-4.99999817400781, -641.99999703893, 0, }, }, 
            {6413, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_960-trs#p0_scale#vector"] =
    {
        {
            {0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.580873936,0.580873936,0.66666667, 0.883920197,0.883920197,0.66666667, }, 
            {0, 1.033333, }, 
            {{100, 100, 100, }, {48, 48, 100, }, }, 
            {6414, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_960-trs#p0_rotation#number"] =
    {
        {
            {0.729020363, 0.007053564, 0.580873936, 1.011835588, }, 
            {0, 1.033333, }, 
            {{0, }, {510, }, }, 
            {6417, }, 
            {0, }, 
        }, 
    },
        ["LumiWarp_544-effect0#bend#number"] =
    {
        {
            {0.38958385, -0.27331326, 0.622796138, 0.999199772, }, 
            {0, 0.766667, }, 
            {{0, }, {67, }, }, 
            {6417, }, 
            {0, }, 
        }, 
    },
        ["LumiLightSensation_544-effect1#intensity#number"] =
    {
        {
            {0.33333333, 0, 0.66666667, 1, }, 
            {0, 0.766667, }, 
            {{0, }, {0.5, }, }, 
            {6417, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_544-trs-matte-blend#p0_position#vector"] =
    {
        {
            {0.913674, 0, 0.778001, 1, }, 
            {0, 1.033333, }, 
            {{640, 640, 0, }, {87.029008784, -816.554028411, 0, }, {-408, 260, 0, }, {-4.99999817400781, -641.99999703893, 0, }, }, 
            {6413, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_544-trs-matte-blend#p0_scale#vector"] =
    {
        {
            {0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.580873936,0.580873936,0.66666667, 0.883920197,0.883920197,0.66666667, }, 
            {0, 1.033333, }, 
            {{100, 100, 100, }, {48, 48, 100, }, }, 
            {6414, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_544-trs-matte-blend#ninSixteen#number"] =
    {
        {
            {0.166666667,0.166666667,0.166666667, 0.166666667,}, 
            {0.0, 0.2, }, 
            {{1,  }, {1.8, }, }, 
            {6414, }, 
            {0, }, 
        }, 
        {
            {0.166666667,0.166666667,0.166666667, 0.166666667,}, 
            {0.2, 0.4, }, 
            {{1.8,  }, {1.8, }, }, 
            {6414, }, 
            {0, }, 
        }, 
    },
    --     ["LumiLayer_544-trs-matte-blend#ninSixteenPosX#number"] =
    -- {
    -- 	{
    -- 		{0.33333333,0.33333333,0.33333333, 0,}, 
    -- 		{0.1, 0.4, }, 
    -- 		{{0,  }, {-50, }, }, 
    -- 		{6414, }, 
    -- 		{0, }, 
    -- 	}, 
    -- },
    --     ["LumiLayer_544-trs-matte-blend#ninSixteenPosY#number"] =
    -- {
    -- 	{
    -- 		{0.33333333,0.33333333,0.33333333, 0,}, 
    -- 		{0.1, 0.4, }, 
    -- 		{{0,  }, {100, }, }, 
    -- 		{6414, }, 
    -- 		{0, }, 
    -- 	}, 
    -- },
        ["LumiLayer_544-trs-matte-blend#p0_rotation#number"] =
    {
        {
            {0.729020363, 0.007053564, 0.580873936, 1.011835588, }, 
            {0, 1.033333, }, 
            {{0, }, {510, }, }, 
            {6417, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_962-trs-blend#scale#vector"] =
    {
        {
            {0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.66666667,0.66666667,0.66666667, 1,1,0.66666667, }, 
            {0, 0.3, }, 
            {{166.5, 166.5, 100, }, {116.5, 116.5, 100, }, }, 
            {6414, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_962-trs-blend#p0_position#vector"] =
    {
        {
            {0.913674, 0, 0.778001, 1, }, 
            {0, 1.033333, }, 
            {{640, 640, 0, }, {87.029008784, -816.554028411, 0, }, {-408, 260, 0, }, {-4.99999817400781, -641.99999703893, 0, }, }, 
            {6413, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_962-trs-blend#p0_scale#vector"] =
    {
        {
            {0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.580873936,0.580873936,0.66666667, 0.883920197,0.883920197,0.66666667, }, 
            {0, 1.033333, }, 
            {{100, 100, 100, }, {48, 48, 100, }, }, 
            {6414, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_962-trs-blend#p0_rotation#number"] =
    {
        {
            {0.729020363, 0.007053564, 0.580873936, 1.011835588, }, 
            {0, 1.033333, }, 
            {{0, }, {510, }, }, 
            {6417, }, 
            {0, }, 
        }, 
    },
        ["LumiRadialBlur_548-effect0#amount#number"] =
    {
        {
            {0.33333333, 0, 0.666666667, 0.692567568, }, 
            {0, 0.433333, }, 
            {{0, }, {7.784992, }, }, 
            {6417, }, 
            {0, }, 
        }, 
        {
            {0.166666667, -0.115426236, 0.666666666, 1.229299852, }, 
            {0.433333, 0.633333, }, 
            {{7.784992, }, {3, }, }, 
            {6417, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_964-trs-blend#scale#vector"] =
    {
        {
            {0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
            {0, 0.233333, }, 
            {{100, 100, 100, }, {110, 110, 100, }, }, 
            {6414, }, 
            {1, }, 
        }, 
        {
            {0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, 
            {0.233333, 0.566667, }, 
            {{110, 110, 100, }, {120, 120, 100, }, }, 
            {6414, }, 
            {1, }, 
        }, 
    },
        ["LumiLayer_964-trs-blend#opacity#number"] =
    {
        {
            {0.408435283, 0.000581007, 0.699011181, 0.645867725, }, 
            {0, 0.566667, }, 
            {{0, }, {17.125575, }, }, 
            {6417, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_964-trs-blend#p0_position#vector"] =
    {
        {
            {0.913674, 0, 0.778001, 1, }, 
            {0, 1.033333, }, 
            {{640, 640, 0, }, {87.029008784, -816.554028411, 0, }, {-408, 260, 0, }, {-4.99999817400781, -641.99999703893, 0, }, }, 
            {6413, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_964-trs-blend#p0_scale#vector"] =
    {
        {
            {0.33333333,0.33333333,0.33333333, 0,0,0.33333333, 0.580873936,0.580873936,0.66666667, 0.883920197,0.883920197,0.66666667, }, 
            {0, 1.033333, }, 
            {{100, 100, 100, }, {48, 48, 100, }, }, 
            {6414, }, 
            {0, }, 
        }, 
    },
        ["LumiLayer_964-trs-blend#p0_rotation#number"] =
    {
        {
            {0.729020363, 0.007053564, 0.580873936, 1.011835588, }, 
            {0, 1.033333, }, 
            {{0, }, {510, }, }, 
            {6417, }, 
            {0, }, 
        }, 
    },
}
data.ae_keyframes = ae_keyframes

local ae_transitionInputIndex = {
    {"LumiWarp_544-effect0", "InputTex", 0},
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
