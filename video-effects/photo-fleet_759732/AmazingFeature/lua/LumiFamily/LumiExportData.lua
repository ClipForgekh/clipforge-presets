local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_49-trs'] = {
        ['nodeDuration'] = {{0.2, 0.76666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.2, 0.76666666666667}, },
        },
    },
    ['LumiLayer_75-trs-blend'] = {
        ['nodeDuration'] = {{0.2, 0.76666666666667}, {0.93333333333333, 1.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.93333333333333, 1.46666666666667}, },
            ['baseTex'] = {{0.2, 0.76666666666667}, },
        },
    },
    ['LumiLayer_69-trs-blend'] = {
        ['nodeDuration'] = {{0.2, 1.46666666666667}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.63333333333333, 1.3}, },
            ['baseTex'] = {{0.2, 0.76666666666667}, {0.93333333333333, 1.46666666666667}, },
        },
    },
    ['LumiLayer_50-trs-blend'] = {
        ['nodeDuration'] = {{0.2, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.76666666666667, 1.53333333333333}, },
            ['baseTex'] = {{0.2, 1.46666666666667}, },
        },
    },
    ['LumiLayer_51-trs-blend'] = {
        ['nodeDuration'] = {{0.2, 1.53333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.43333333333333, 1.3}, },
            ['baseTex'] = {{0.2, 1.53333333333333}, },
        },
    },
    ['LumiLayer_74-trs-blend'] = {
        ['nodeDuration'] = {{0.2, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.03333333333333, 1.7}, },
            ['baseTex'] = {{0.2, 1.53333333333333}, },
        },
    },
    ['LumiLayer_48-trs-blend'] = {
        ['nodeDuration'] = {{0.2, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.33333333333333, 1.1}, },
            ['baseTex'] = {{0.2, 1.7}, },
        },
    },
    ['LumiLayer_77-trs-blend'] = {
        ['nodeDuration'] = {{0.06666666666667, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.06666666666667, 1.03333333333333}, },
            ['baseTex'] = {{0.2, 1.7}, },
        },
    },
    ['LumiMotionBlur3D_39-effect0'] = {
        ['nodeDuration'] = {{0, 0.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.6}, },
        },
    },
    ['LumiLayer_39-trs-blend'] = {
        ['nodeDuration'] = {{0, 1.7}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 0.6}, },
            ['baseTex'] = {{0.06666666666667, 1.7}, },
        },
    },
    ['LumiDirectionalBlurs_93-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.7}, },
        },
    },
    ['LumiLayer_93-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 1.7}, },
        },
    },
    ['LumiLayer_46-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0.33333333333333, 2}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiDirectionalBlurs_95-effect0'] = {
        ['nodeDuration'] = {{1.1, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_95-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.1, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_49-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 1730, -1500),
        ['position'] = Amaz.Vector3f(-7365.1872232658, 1689.40381142641, 11721.1815726966),
        ['scale'] = Amaz.Vector3f(100, 100, 163.934426229508),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_75-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(1780, -2376, 0),
        ['position'] = Amaz.Vector3f(-8657.30208192071, -52.0673682435134, 6979.21603473652),
        ['scale'] = Amaz.Vector3f(69, 69, 113.114754098361),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_69-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(1780, -688, 0),
        ['position'] = Amaz.Vector3f(-8657.30208192071, -52.0673682435134, 6979.21603473652),
        ['scale'] = Amaz.Vector3f(100, 100, 163.934426229508),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_50-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 1170, 0),
        ['position'] = Amaz.Vector3f(-3795.24485802342, -34.415410784567, 7065.10735343606),
        ['scale'] = Amaz.Vector3f(100, 100, 163.934426229508),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_51-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, -2, 0),
        ['position'] = Amaz.Vector3f(-4935.62196350917, 948.262653097231, 5891.1952606723),
        ['scale'] = Amaz.Vector3f(100, 100, 163.934426229508),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_74-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(550, 168, 0),
        ['position'] = Amaz.Vector3f(-4935.62196350917, 948.262653097231, 5891.1952606723),
        ['scale'] = Amaz.Vector3f(143, 143, 234.426229508197),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_48-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 1170, 0),
        ['position'] = Amaz.Vector3f(-8657.30208192071, -52.0673682435134, 6979.21603473652),
        ['scale'] = Amaz.Vector3f(100, 100, 163.934426229508),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_77-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(1440, 540, 0),
        ['position'] = Amaz.Vector3f(-7746.93754568189, 1684.47954322447, 5958.65038428681),
        ['scale'] = Amaz.Vector3f(100, 100, 163.934426229508),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiMotionBlur3D_39-effect0'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['unifiedScale'] = false,
        ['scale_x'] = 1,
        ['ae_pre_scale_x'] = 1,
        ['scale_y'] = 1,
        ['ae_pre_scale_y'] = 1,
        ['scale_z'] = 1,
        ['ae_pre_scale_z'] = 1,
        ['direction_x'] = 0,
        ['ae_pre_direction_x'] = 0,
        ['direction_y'] = 0,
        ['ae_pre_direction_y'] = 0,
        ['direction_z'] = 0,
        ['ae_pre_direction_z'] = 0,
        ['rotation_x'] = 0,
        ['ae_pre_rotation_x'] = 0,
        ['rotation_y'] = 0,
        ['ae_pre_rotation_y'] = 0,
        ['rotation_z'] = 0,
        ['ae_pre_rotation_z'] = 0,
        ['vIntensity'] = 1.1,
        ['vCenter'] = -0.25,
        ['samples'] = 24,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_39-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 416),
        ['position'] = Amaz.Vector3f(-10226.8348172133, 599.183460965287, 3406.76337548968),
        ['scale'] = Amaz.Vector3f(100, 100, 163.934426229508),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiDirectionalBlurs_93-effect0'] = {
        ['blurIntensity'] = 80,
        ['angle'] = 90,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_93-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_46-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(960, 540, 0),
        ['position'] = Amaz.Vector3f(960, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527099629,
        ['compositeSize'] = Amaz.Vector2f(1920, 1080),
        ['layerSize'] = Amaz.Vector2f(1920, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiDirectionalBlurs_95-effect0'] = {
        ['blurIntensity'] = 0,
        ['angle'] = 90,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1920, 1080),
    },
    ['LumiLayer_95-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_49-trs#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.2, 0.9, }, 
		{{8113.800189586, 1689.403811511, 9475.181571674, }, {-7365.187223266, 1689.403811426, 11721.181572697, }, {8113.800189586, 1689.403811511, 9475.181571674, }, {-7365.187223266, 1689.403811426, 11721.181572697, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_75-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.933333, 1.8, }, 
		{{5747.136049883, -52.067368244, 6979.216033321, }, {-8657.302081921, -52.067368244, 6979.216034737, }, {5747.136049883, -52.067368244, 6979.216033321, }, {-8657.302081921, -52.067368244, 6979.216034737, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_69-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.633333, 1.7, }, 
		{{7787.136049883, -52.067368244, 10849.216033321, }, {-8657.302081921, -52.067368244, 6979.216034737, }, {7787.136049883, -52.067368244, 10849.216033321, }, {-8657.302081921, -52.067368244, 6979.216034737, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_50-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.766667, 1.533333, }, 
		{{6123.913803523, -34.415408117, 8715.107342869, }, {-3795.244858023, -34.415410785, 7065.107353436, }, {6123.913803523, -34.415408117, 8715.107342869, }, {-3795.244858023, -34.415410785, 7065.107353436, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_51-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.433333, 1.633333, }, 
		{{6391.857168229, 948.262653097, 821.195257925, }, {-4935.621963509, 948.262653097, 5891.195260672, }, {6391.857168229, 948.262653097, 821.195257925, }, {-4935.621963509, 948.262653097, 5891.195260672, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_74-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1.033333, 1.733333, }, 
		{{5021.857168229, 948.262653097, 5891.195257925, }, {-4935.621963509, 948.262653097, 5891.195260672, }, {5021.857168229, 948.262653097, 5891.195257925, }, {-4935.621963509, 948.262653097, 5891.195260672, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_48-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.333333, 1.6, }, 
		{{5475.723470466, -52.067368244, 4539.216035277, }, {-8657.302081921, -52.067368244, 6979.216034737, }, {5475.723470466, -52.067368244, 4539.216035277, }, {-8657.302081921, -52.067368244, 6979.216034737, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_77-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.066667, 1.4, }, 
		{{6733.460234902, 1684.479543224, 8828.650384287, }, {-7746.937545682, 1684.479543224, 5958.650384287, }, {6733.460234902, 1684.479543224, 8828.650384287, }, {-7746.937545682, 1684.479543224, 5958.650384287, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_39-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 1.333333, }, 
		{{3934.390635672, 599.18346261, 3516.76338365, }, {-10226.834817213, 599.183460965, 3406.76337549, }, {3934.390635672, 599.18346261, 3516.76338365, }, {-10226.834817213, 599.183460965, 3406.76337549, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_93-effect0#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 1.333333, }, 
		{{0, }, {80, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_46-trs-blend#position#vector'] =
{
	{
		{0.448155, 0, 0, 1, }, 
		{0.633333, 1.733333, }, 
		{{20369.614715993, 539.999998957, 15800, }, {960, 540, 0, }, {20369.614715993, 539.999998957, 15800, }, {1032.01114654541, 554.023633956909, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_95-effect0#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.1, 1.366667, }, 
		{{0, }, {40, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.366667, 1.733333, }, 
		{{40, }, {0, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
}
data.ae_keyframes = ae_keyframes

local ae_reverseKeyframes = false
data.ae_reverseKeyframes = ae_reverseKeyframes

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
