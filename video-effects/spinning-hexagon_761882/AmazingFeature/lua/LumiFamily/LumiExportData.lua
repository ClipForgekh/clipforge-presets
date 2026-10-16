local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiLayer_30-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_29-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_28-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_31-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_32-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_27-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
    ['LumiDirectionalBlurs_55-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_55-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiLayer_30-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(3.06672672336686, 0, 911.124146438334),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 180,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 15000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 360,
        ['p0_rotation'] = 25,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
    },
    ['LumiLayer_29-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(-810.933273276633, 0, 447.124146438334),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 120,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 15000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 360,
        ['p0_rotation'] = 25,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_28-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(-811, 0, -488),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 60,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 15000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 360,
        ['p0_rotation'] = 25,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_31-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(819.066726723367, 0, 442.124146438334),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 240,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 15000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 360,
        ['p0_rotation'] = 25,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_32-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(803.066726723367, 0, -497.875853561666),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 300,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 15000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 360,
        ['p0_rotation'] = 25,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiLayer_27-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(0, 0, -950),
        ['scale'] = Amaz.Vector3f(100, 100, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = 0,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.5977527100237,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 15000),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 360,
        ['p0_rotation'] = 25,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.5977527100237,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiDirectionalBlurs_55-effect0'] = {
        ['blurIntensity'] = 10,
        ['angle'] = 110,
        ['directionNum'] = 1,
        ['exposure'] = 1,
        ['quality'] = 0.5,
        ['spaceDither'] = 0,
        ['borderType'] = 0,
        ['blendMode'] = 2,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_55-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Adjustment',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_30-trs#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 15000, }, {540, 540, 950, }, {540, 540, 12658.3332519531, }, {540, 540, 3291.66674804688, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_30-trs#p0_yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{360, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_30-trs#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 15000, }, {540, 540, 950, }, {540, 540, 12658.3332519531, }, {540, 540, 3291.66674804688, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#p0_yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{360, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_29-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 15000, }, {540, 540, 950, }, {540, 540, 12658.3332519531, }, {540, 540, 3291.66674804688, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#p0_yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{360, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_28-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 15000, }, {540, 540, 950, }, {540, 540, 12658.3332519531, }, {540, 540, 3291.66674804688, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#p0_yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{360, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_31-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 15000, }, {540, 540, 950, }, {540, 540, 12658.3332519531, }, {540, 540, 3291.66674804688, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#p0_yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{360, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_32-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#p0_position#vector'] =
{
	{
		{0.166667, 0.166667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{540, 540, 15000, }, {540, 540, 950, }, {540, 540, 12658.3332519531, }, {540, 540, 3291.66674804688, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#p0_yRotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{360, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs-blend#p0_rotation#number'] =
{
	{
		{0.166666667, 0.166666667, 0.21, 1, }, 
		{0, 1.966667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_55-effect0#blurIntensity#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.666667, }, 
		{{10, }, {25, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.61, 0, 0.51, 1, }, 
		{0.666667, 1.966667, }, 
		{{25, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiDirectionalBlurs_55-effect0#angle#number'] =
{
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0, 0.433333, }, 
		{{110, }, {67, }, }, 
		{6417, }, 
		{1, }, 
	}, 
	{
		{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, 
		{0.433333, 1.333333, }, 
		{{67, }, {90, }, }, 
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
