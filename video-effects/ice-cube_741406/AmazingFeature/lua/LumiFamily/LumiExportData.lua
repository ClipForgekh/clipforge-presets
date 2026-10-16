local data = {}

local ae_compDurations = {0, 1.4}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_171-trs', 'InputTex', 0},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['Lumi3DShape_158-effect0'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['Lumi3DShape_158-effect1'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['LumiSaturation_158-effect1'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['LumiDeepGlow_158-effect2'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['LumiLayer_171-trs'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['Lumi3DShape_157-effect0'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['LumiLayer_158-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
            ['baseTex'] = {{0, 1.4}, },
        },
    },
    ['TurbulenceDisplacement_159-effect0'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['LumiRadialBlur_159-effect1'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
        },
    },
    ['LumiLayer_159-blend'] = {
        ['nodeDuration'] = {{0, 1.4}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.4}, },
            ['baseTex'] = {{0, 1.4}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['Lumi3DShape_158-effect0'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 2,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = true,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 0,
        ['Position_z'] = -5.2,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 0.55,
        ['Rotate_x'] = -360,
        ['Rotate_y'] = 175.293874762066,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 2,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
    ['Lumi3DShape_158-effect1'] = {
        ['fov'] = 60,
        ['meshType'] = 3,
        ['meshSize_x'] = 2,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 2,
        ['meshResY'] = 2,
        ['meshResZ'] = 2,
        ['reverseUV'] = false,
        ['cullBack'] = true,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 0,
        ['Position_z'] = -5.2,
        ['Scale_x'] = 1,
        ['Scale_y'] = 1,
        ['Scale_z'] = 0.55,
        ['Rotate_x'] = -360,
        ['Rotate_y'] = 175.293874762066,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 1,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 2,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
    ['LumiSaturation_158-effect1'] = {
        ['saturationIntensity'] = 0.8,
    },
    ['LumiDeepGlow_158-effect2'] = {
        ['radius'] = 400,
        ['exposure'] = 1.1,
        ['threshold'] = 0.98,
        ['thresholdSmooth'] = 0.5,
        ['blendMode'] = 0,
        ['view'] = 1,
        ['ratio'] = 0.75,
        ['rotate'] = 30,
        ['ca'] = false,
        ['redOffset'] = 0.0025,
        ['greenOffset'] = 0,
        ['blueOffset'] = -0.005,
        ['tint'] = false,
        ['tintMode'] = 2,
        ['tintColor'] = Amaz.Color(1, 0, 0, 1),
        ['tintMix'] = 1,
        ['sourceOpacity'] = 1,
        ['unmult'] = true,
        ['gammaCorrect'] = true,
        ['gammaValue'] = 2,
        ['glowIter'] = 8,
        ['stepsMult'] = 1.5,
        ['downSample'] = 0.80000001192093,
        ['quality'] = 0.5,
    },
    ['LumiLayer_171-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(-100, -100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['Lumi3DShape_157-effect0'] = {
        ['fov'] = 60,
        ['meshType'] = 0,
        ['meshSize_x'] = 2,
        ['meshSize_y'] = 2,
        ['meshSize_z'] = 2,
        ['meshResX'] = 50,
        ['meshResY'] = 50,
        ['meshResZ'] = 50,
        ['reverseUV'] = false,
        ['cullBack'] = false,
        ['translucency'] = true,
        ['twoSide'] = false,
        ['Position_x'] = 0,
        ['Position_y'] = 0,
        ['Position_z'] = -5.2,
        ['Scale_x'] = 0.71,
        ['Scale_y'] = 0.71,
        ['Scale_z'] = 0.71,
        ['Rotate_x'] = -180,
        ['Rotate_y'] = -175.293874762066,
        ['Rotate_z'] = 0,
        ['texFillMode'] = 2,
        ['uvScaleX'] = 1,
        ['uvScaleY'] = 1,
        ['uvWrapMode'] = 3,
        ['enableMask'] = false,
        ['maskChannel'] = 3,
    },
    ['LumiLayer_158-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 'Screen',
    },
    ['TurbulenceDisplacement_159-effect0'] = {
        ['size'] = 0.00943751781596,
        ['quantity'] = 1.09179744778862,
        ['complexity'] = 1,
        ['evolution'] = 72.1878742584857,
        ['cycle'] = 100,
        ['offset_x'] = 0,
        ['offset_y'] = 0,
        ['type'] = 0,
        ['fix_type'] = 1,
        ['picture_scale'] = 1,
        ['motion_tile_type'] = 0,
        ['qualityType'] = 3,
    },
    ['LumiRadialBlur_159-effect1'] = {
        ['blurType'] = 1,
        ['amount'] = 20.6383886622326,
        ['quality'] = 0.1,
        ['center'] = Amaz.Vector2f(0.5, 0.5),
        ['weightDecay'] = 0.965,
        ['dither'] = 1,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = false,
        ['borderType'] = 0,
    },
    ['LumiLayer_159-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 'Normal',
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['Lumi3DShape_158-effect0#Position_z#number'] =
{
	{
		{0.458222388, 0, 0.630096399, 0.67862918, }, 
		{0, 0.6, }, 
		{{-1.23, }, {-3.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.253267956, 0.199771544, 0.711469713, 0.549680517, }, 
		{0.6, 1.1, }, 
		{{-3.3, }, {-5.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.909244456, 0.015168896, 0.930245967, 0.448091677, }, 
		{1.1, 1.366667, }, 
		{{-5.2, }, {-100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect0#Scale_x#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect0#Scale_y#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect0#Scale_z#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{0.55, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect0#Rotate_x#number'] =
{
	{
		{0.64, 0, 0.35, 1, }, 
		{0, 0.733333, }, 
		{{-180, }, {-360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect0#Rotate_y#number'] =
{
	{
		{0.7, 0, 0.3, 1, }, 
		{0.466667, 1.233333, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},


['Lumi3DShape_158-effect1#Position_z#number'] =
{
	{
		{0.458222388, 0, 0.630096399, 0.67862918, }, 
		{0, 0.6, }, 
		{{-1.23, }, {-3.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.253267956, 0.199771544, 0.711469713, 0.549680517, }, 
		{0.6, 1.1, }, 
		{{-3.3, }, {-5.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.909244456, 0.015168896, 0.930245967, 0.448091677, }, 
		{1.1, 1.366667, }, 
		{{-5.2, }, {-100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect1#Scale_x#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect1#Scale_y#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{1, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect1#Scale_z#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{0.55, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect1#Rotate_x#number'] =
{
	{
		{0.64, 0, 0.35, 1, }, 
		{0, 0.733333, }, 
		{{-180, }, {-360, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_158-effect1#Rotate_y#number'] =
{
	{
		{0.7, 0, 0.3, 1, }, 
		{0.466667, 1.233333, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDeepGlow_158-effect2#exposure#number'] =
{
	{
		{0.180931187, 0.610322436, 0.66666667, 1, }, 
		{0.333333, 0.466667, }, 
		{{2.2, }, {1.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.66666667, 0, }, 
		{0.466667, 0.633333, }, 
		{{1.1, }, {1.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.594215529, 0.078735494, 0.801562214, 0.396082988, }, 
		{0.633333, 0.8, }, 
		{{1.1, }, {2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.288580051, 0.087113016, 0.473260105, 0.930886899, }, 
		{0.8, 1.033333, }, 
		{{2, }, {1.1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_171-trs#scale#vector'] =
{
	{
		{0.1667, 0.1667, 0.8333, 0.8333, }, 
		{0, 0.366667, }, 
		{{100, 100, 100, }, {-100, -100, 100, }, }, 
		{6414, }, 
		{2, }, 
	}, 
},
-- ["frameFX/size_0_7"]={
--     {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {11, 13, }, {{6, }, {10, }, }, }, 
--     {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {13, 33, }, {{10, }, {7, }, }, }, 
--     {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {33, 41, }, {{7, }, {1, }, }, }, 
-- }, 
-- ["frameFX/opacity_0_8"]={
--     {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {11, 12, }, {{0, }, {100, }, }, }, 
-- }, 
    ['LumiLayer_171-trs#style_float#number'] =
{
    {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0.366667, 0.433334, }, {{6, }, {10, }, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0.433334, 1.1, }, {{10, }, {7, }, }, }, 
        {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {1.1, 1.3, }, {{7, }, {1, }, }, }, 
},
    ['LumiLayer_171-trs#style_float2#number'] =
{
	{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0.366667, 0.4, }, {{0, }, {100, }, }, }, 
},
    ['LumiLayer_171-trs#xRotation#number'] =
{
	{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0., 0.4, }, {{0, }, {-4, }, }, }, 
},
    ['Lumi3DShape_157-effect0#Position_z#number'] =
{
	{
		{0.458222388, 0, 0.630096399, 0.67862918, }, 
		{0, 0.6, }, 
		{{-1.23, }, {-3.3, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.253267956, 0.199771544, 0.711469713, 0.549680517, }, 
		{0.6, 1.1, }, 
		{{-3.3, }, {-5.2, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.909244456, 0.015168896, 0.930245967, 0.448091677, }, 
		{1.1, 1.366667, }, 
		{{-5.2, }, {-100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_157-effect0#Scale_x#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{0.71, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_157-effect0#Scale_y#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{0.71, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_157-effect0#Scale_z#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{1.1, 1.366667, }, 
		{{0.71, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
['Lumi3DShape_157-effect0#scale2#number'] =
{
	{
		{0.001, 0, 0.58, 1, }, 
		{0.266667, 0.4, }, 
		{{0, }, {1.0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_157-effect0#Rotate_x#number'] =
{
	{
		{0.65, 0, 0.36, 1, }, 
		{0, 0.733333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['Lumi3DShape_157-effect0#Rotate_y#number'] =
{
	{
		{0.7, 0, 0.3, 1, }, 
		{0.466667, 1.233333, }, 
		{{0, }, {-180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_158-trs-blend#opacity#number'] =
{
	{
		{0.19, 0, 0.39, 1, }, 
		{0, 0.366667, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['TurbulenceDisplacement_159-effect0#size#number'] =
{
	{
		{0.305608947, 0, 0.614718982, 1, }, 
		{0, 0.366667, }, 
		{{0, }, {0.015, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.236519602, 0, 0.455013792, 0.675509545, }, 
		{0.366667, 1.366667, }, 
		{{0.015, }, {0.008, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['TurbulenceDisplacement_159-effect0#quantity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.366667, }, 
		{{1.718452, }, {0.939881, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['TurbulenceDisplacement_159-effect0#evolution#number'] =
{
	{
		{0.42, 0, 0.999, 1, }, 
		{0, 1.366667, }, 
		{{240, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiRadialBlur_159-effect1#amount#number'] =
{
	{
		{0.356333968, 0, 0.679614786, 1, }, 
		{0, 0.3, }, 
		{{0, }, {37, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.354080157, 0, 0.660457535, 1, }, 
		{0.3, 0.466667, }, 
		{{37, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.33333333, 0, 0.999, 0, }, 
		{0.466667, 1.033333, }, 
		{{0, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.327175541, 0, 0.999, 1, }, 
		{1.033333, 1.366667, }, 
		{{0, }, {250, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
}


data.ae_keyframes = ae_keyframes

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
