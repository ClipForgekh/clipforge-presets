local data = {}

local ae_compDurations = {0, 1.96666666666667}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiWaveWarp_82-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_92-trs'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_63-matte'] = {
        ['nodeDuration'] = {{0, 1.6}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 1.6}, },
            ['maskTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_82-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 1.6}, },
        },
    },
    ['LumiWaveWarp_84-effect0'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
        },
    },
    ['LumiLayer_84-trs-blend'] = {
        ['nodeDuration'] = {{0, 2}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2}, },
            ['baseTex'] = {{0, 2}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiWaveWarp_82-effect0'] = {
        ['type'] = 0,
        ['amplitude'] = 20,
        ['wavelength'] = 75,
        ['direction'] = 90,
        ['speed'] = 2,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_92-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(540, 540, 0),
        ['scale'] = Amaz.Vector3f(100, 0, 100),
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
    ['LumiLayer_63-matte'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = true,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['matteMode'] = 2,
    },
    ['LumiLayer_82-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 540, 0),
        ['position'] = Amaz.Vector3f(804, 738, 0),
        ['scale'] = Amaz.Vector3f(207.44, 22, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -62,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
    ['LumiWaveWarp_84-effect0'] = {
        ['type'] = 0,
        ['amplitude'] = 20,
        ['wavelength'] = 75,
        ['direction'] = 90,
        ['speed'] = 2,
        ['fixedType'] = 0,
        ['phase'] = 0,
        ['antiAliasing'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_84-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Solid',
        ['anchorPoint'] = Amaz.Vector3f(540, 1080, 0),
        ['position'] = Amaz.Vector3f(-820, -636, 0),
        ['scale'] = Amaz.Vector3f(207.44, 22, 100),
        ['orientation'] = Amaz.Vector3f(0, 0, 0),
        ['xRotation'] = 0,
        ['yRotation'] = 0,
        ['rotation'] = -62,
        ['opacity'] = 100,
        ['active_cam_fovx'] = 39.6,
        ['p0_anchorPoint'] = Amaz.Vector3f(0, 0, 0),
        ['p0_position'] = Amaz.Vector3f(540, 540, 0),
        ['p0_scale'] = Amaz.Vector3f(100, 100, 100),
        ['p0_orientation'] = Amaz.Vector3f(0, 0, 0),
        ['p0_xRotation'] = 0,
        ['p0_yRotation'] = 0,
        ['p0_rotation'] = 0,
        ['p0_opacity'] = 100,
        ['p0_active_cam_fovx'] = 39.6,
        ['compositeSize'] = Amaz.Vector2f(1080, 1080),
        ['layerSize'] = Amaz.Vector2f(1080, 1080),
        ['mirrorEdge'] = false,
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiLayer_92-trs#scale#vector'] =
{
	{
		{0.33333333,0.33333333,0.33333333, 0.33333333,0,0.33333333, 0.5,0.5,0.5, 0.5,1,0.5, }, 
		{1.166667, 1.766667, }, 
		{{100, 0, 100, }, {100, 100, 100, }, }, 
		{6414, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_82-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.34, 1, }, 
		{0, 0.9, }, 
		{{804, 738, 0, }, {0, 110, 0, }, {670, 633.333335876465, 0, }, {134, 214.666664123535, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.66, 0.66, 0.34, 0.34, }, 
		{0.9, 1.166667, }, 
		{{0, 110, 0, }, {0, 110, 0, }, {0, 110, 0, }, {0, 110, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.66, 0, 0.34, 1, }, 
		{1.166667, 1.9, }, 
		{{0, 110, 0, }, {0, 738.1, 0, }, {1.89478068516246e-14, 214.683334350586, 0, }, {-1.89478068516246e-14, 633.416665649414, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_82-trs-blend#rotation#number'] =
{
	{
		{0.33333333, 0, 0.34, 1, }, 
		{0, 0.9, }, 
		{{-62, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_82-trs-blend#p0_rotation#number'] =
{
	{
		{0.64, 0, 0.36, 1, }, 
		{0.5, 1.333333, }, 
		{{0, }, {180, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_84-trs-blend#position#vector'] =
{
	{
		{0.333333, 0, 0.34, 1, }, 
		{0, 0.9, }, 
		{{-820, -636, 0, }, {0, 13.8, 0, }, {-683.33332824707, -527.699996948242, 0, }, {-136.66667175293, -94.5000030517578, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.66, 0.66, 0.34, 0.34, }, 
		{0.9, 1.166667, }, 
		{{0, 13.8, 0, }, {0, 13.8, 0, }, {0, 13.8, 0, }, {0, 13.8, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.66, 0, 0.34, 1, }, 
		{1.166667, 1.9, }, 
		{{0, 13.8, 0, }, {0, -628.2, 0, }, {0, -93.2, 0, }, {0, -521.2, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_84-trs-blend#rotation#number'] =
{
	{
		{0.33333333, 0, 0.34, 1, }, 
		{0, 0.9, }, 
		{{-62, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_84-trs-blend#p0_rotation#number'] =
{
	{
		{0.64, 0, 0.36, 1, }, 
		{0.5, 1.333333, }, 
		{{0, }, {180, }, }, 
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
