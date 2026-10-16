local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
    {'LumiLayer_41810-trs-blend', 'InputTex', 1},
    {'LumiLayer_41808-trs-blend', 'InputTex', 1},
    {'LumiLayer_41806-trs-blend', 'InputTex', 1},
    {'LumiLayer_41804-trs-blend', 'InputTex', 1},
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_41812-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41811-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.63333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41810-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.63333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41809-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.63333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41808-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.63333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41806-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.6, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41805-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.63333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41804-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.63333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiGaussianBlur_41802-effect0'] = {
        ['nodeDuration'] = {{1.36666666666667, 1.8}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41802-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.36666666666667, 1.8}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_41801-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{1.36666666666667, 1.8}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_41812-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Image',
        ['anchorPoint'] = Amaz.Vector3f(512, 512, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(136, 136, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1024, 1024),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_41811-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 722.31, 0),
        ['scale'] = Amaz.Vector3f(44.4, 44.4, 44.4),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -90,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 483, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_41810-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 722.31, 0),
        ['scale'] = Amaz.Vector3f(44.4, 44.4, 44.4),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -90,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 483, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_41809-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 622.02, 0),
        ['scale'] = Amaz.Vector3f(44.4, 44.4, 44.4),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -90,
        ['yRotation'] = 0,
        ['rotation'] = -7,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_41808-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 610.92, 0),
        ['scale'] = Amaz.Vector3f(44.4, 44.4, 44.4),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -90,
        ['yRotation'] = 0,
        ['rotation'] = -7,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_41806-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 573.461301549192, 0),
        ['scale'] = Amaz.Vector3f(40.5877011221112, 40.5877011221112, 40.5877011221112),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -40,
        ['yRotation'] = -9,
        ['rotation'] = -8,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_41805-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 609.09, 0),
        ['scale'] = Amaz.Vector3f(44.4, 44.4, 44.4),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -90,
        ['yRotation'] = 0,
        ['rotation'] = -7,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 483, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_41804-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 597.99, 0),
        ['scale'] = Amaz.Vector3f(44.4, 44.4, 44.4),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = -90,
        ['yRotation'] = 0,
        ['rotation'] = -7,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 483, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiGaussianBlur_41802-effect0'] = {
        ['blurIntensity'] = 0,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['horizontalStrength'] = 1,
        ['verticalStrength'] = 1,
        ['blurDirection'] = 0,
        ['borderType'] = 0,
        ['blurAlpha'] = true,
        ['inverseGammaCorrection'] = true,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_41802-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
    ['LumiLayer_41801-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 0,
        ['active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_41811-trs-blend#position#vector'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, 722.31, 0, }, {0, 365.17, 0, }, {0, 662.786665496826, 0, }, {0, 424.693334503174, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41811-trs-blend#xRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-90, }, {-71, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41811-trs-blend#yRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, }, {17, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41811-trs-blend#rotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, }, {-1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41811-trs-blend#p0_scale#vector'] =
{
	{
		{0.39,0.39,0.39, 0,0,0.39, 0.61,0.61,0.61, 1,1,0.61, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41810-trs-blend#position#vector'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, 722.31, 0, }, {0, 355.18, 0, }, {0, 661.121668395996, 0, }, {0, 416.368331604004, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41810-trs-blend#xRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-90, }, {-71, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41810-trs-blend#yRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, }, {17, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41810-trs-blend#rotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, }, {-1, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41810-trs-blend#p0_scale#vector'] =
{
	{
		{0.39,0.39,0.39, 0,0,0.39, 0.61,0.61,0.61, 1,1,0.61, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41809-trs-blend#position#vector'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, 622.02, 0, }, {0, -14.01, 0, }, {0, 516.015002746582, 0, }, {0, 91.994997253418, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41809-trs-blend#xRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-90, }, {-66, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.566667, }, 
		{{-66, }, {-40, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_41809-trs-blend#yRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, }, {-9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41809-trs-blend#rotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-7, }, {-8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41809-trs-blend#p0_scale#vector'] =
{
	{
		{0.39,0.39,0.39, 0,0,0.39, 0.61,0.61,0.61, 1,1,0.61, }, 
		{1.366667, 1.933333, }, 
		{{100, 100, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41808-trs-blend#position#vector'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, 610.92, 0, }, {0, -25.11, 0, }, {0, 504.915002746582, 0, }, {0, 80.894997253418, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41808-trs-blend#xRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-90, }, {-66, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{1.433333, 1.566667, }, 
		{{-66, }, {-40, }, }, 
		{6417, }, 
		{1, }, 
	}, 
},
    ['LumiLayer_41808-trs-blend#yRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, }, {-9, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41808-trs-blend#rotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-7, }, {-8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41808-trs-blend#p0_scale#vector'] =
{
	{
		{0.39,0.39,0.39, 0,0,0.39, 0.61,0.61,0.61, 1,1,0.61, }, 
		{1.366667, 1.933333, }, 
		{{100, 100, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41806-trs-blend#position#vector'] =
{
	{
		{0.34, 0, 0.38, 1, }, 
		{1.433333, 1.833333, }, 
		{{540, 573.461301549, 0, }, {540, 540, 0, }, {540, 567.884417756123, 0, }, {540, 545.576883792877, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41806-trs-blend#scale#vector'] =
{
	{
		{0.34,0.34,0.34, 0,0,0, 0.38,0.38,0.38, 1,1,1, }, 
		{1.433333, 1.833333, }, 
		{{40.587701122, 40.587701122, 40.587701122, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41806-trs-blend#xRotation#number'] =
{
	{
		{0.34, 0, 0.38, 1, }, 
		{1.433333, 1.833333, }, 
		{{-40, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41806-trs-blend#yRotation#number'] =
{
	{
		{0.34, 0, 0.38, 1, }, 
		{1.433333, 1.833333, }, 
		{{-9, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41806-trs-blend#rotation#number'] =
{
	{
		{0.34, 0, 0.38, 1, }, 
		{1.433333, 1.833333, }, 
		{{-8, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41805-trs-blend#position#vector'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, 609.09, 0, }, {0, -285.94, 0, }, {0, 459.918338623047, 0, }, {0, -136.768338623047, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41805-trs-blend#xRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-90, }, {-58, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41805-trs-blend#yRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41805-trs-blend#rotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-7, }, {-8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41805-trs-blend#p0_scale#vector'] =
{
	{
		{0.39,0.39,0.39, 0,0,0.39, 0.61,0.61,0.61, 1,1,0.61, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41804-trs-blend#position#vector'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, 597.99, 0, }, {0, -297.04, 0, }, {0, 448.818338623047, 0, }, {0, -147.868338623047, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41804-trs-blend#xRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-90, }, {-58, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41804-trs-blend#yRotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{0, }, {10, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41804-trs-blend#rotation#number'] =
{
	{
		{0.24, 0, 0.76, 1, }, 
		{0, 1.433333, }, 
		{{-7, }, {-8, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41804-trs-blend#p0_scale#vector'] =
{
	{
		{0.39,0.39,0.39, 0,0,0.39, 0.61,0.61,0.61, 1,1,0.61, }, 
		{1.433333, 1.966667, }, 
		{{100, 100, 100, }, {200, 200, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiGaussianBlur_41802-effect0#blurIntensity#number'] =
{
	{
		{0.67, 0, 0.33, 1, }, 
		{1.366667, 1.6, }, 
		{{0, }, {30, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.67, 0, 0.33, 1, }, 
		{1.6, 1.8, }, 
		{{30, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_41801-trs-blend#opacity#number'] =
{
	{
		{0.9, 0, 0.53, 1, }, 
		{1.366667, 1.6, }, 
		{{0, }, {100, }, }, 
		{6417, }, 
		{0, }, 
	}, 
	{
		{0.47, 0, 0.1, 1, }, 
		{1.6, 1.8, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
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
