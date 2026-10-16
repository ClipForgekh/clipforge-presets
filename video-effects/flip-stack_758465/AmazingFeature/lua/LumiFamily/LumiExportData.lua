local data = {}

local ae_compDurations = {0, 2}
data.ae_compDurations = ae_compDurations

local ae_effectType = 'videoAnimation'
data.ae_effectType = ae_effectType

local ae_transitionInputIndex = {
}
data.ae_transitionInputIndex = ae_transitionInputIndex

local ae_durations = {
    ['LumiRoundCorner_74-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiPageTurn_74-effect1'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['frontTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_74-effect2'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiRoundCorner_43-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiPageTurn_43-effect1'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['frontTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_43-effect2'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiRoundCorner_27-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiPageTurn_27-effect1'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['frontTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_27-effect2'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_27-trs'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_43-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiRoundCorner_44-effect0'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiPageTurn_44-effect1'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['frontTex'] = {{0, 2}, },
        },
    },
    ['LumiMotionBlur3D_44-effect2'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_44-trs-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
    ['LumiLayer_74-blend'] = {
        ['nodeDuration'] = {{0, 2.03333333333333}, },
        ['texDuration'] = {
            ['InputTex'] = {{0, 2.03333333333333}, },
            ['baseTex'] = {{0, 2.03333333333333}, },
        },
    },
}
data.ae_durations = ae_durations

local ae_attribute = {
    ['LumiRoundCorner_74-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiPageTurn_74-effect1'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(-0.46111111111111, 1.39444444444444),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.2,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur3D_74-effect2'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, -0.64074074074074),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, -0.64074074074074),
        ['unifiedScale'] = true,
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
        ['vIntensity'] = 0,
        ['vCenter'] = -0.25,
        ['samples'] = 6,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiRoundCorner_43-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiPageTurn_43-effect1'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(-0.46111111111111, 1.39444444444444),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.2,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur3D_43-effect2'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, -0.64074074074074),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, -0.64074074074074),
        ['unifiedScale'] = true,
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
        ['vIntensity'] = 0,
        ['vCenter'] = -0.25,
        ['samples'] = 6,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiRoundCorner_27-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiPageTurn_27-effect1'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(-0.46111111111111, 1.39444444444444),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.2,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur3D_27-effect2'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, -0.64074074074074),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, -0.64074074074074),
        ['unifiedScale'] = true,
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
        ['vIntensity'] = 0,
        ['vCenter'] = -0.25,
        ['samples'] = 6,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_27-trs'] = {
        ['hasBlend'] = false,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
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
    },
    ['LumiLayer_43-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
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
        ['blendMode'] = 0,
    },
    ['LumiRoundCorner_44-effect0'] = {
        ['radius'] = 50,
        ['fade'] = 5,
        ['fadeType'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiPageTurn_44-effect1'] = {
        ['classic_ui'] = 4,
        ['inFoldPosition'] = Amaz.Vector2f(-0.46111111111111, 1.39444444444444),
        ['inFoldDirection'] = 0,
        ['foldRadius'] = 0.2,
        ['renderFace'] = 0,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiMotionBlur3D_44-effect2'] = {
        ['active_cam_fovx'] = 39.5999984741211,
        ['pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['ae_pre_pivot'] = Amaz.Vector3f(0.5, 0.5, 0),
        ['position'] = Amaz.Vector3f(0.5, 0.5, -0.64074074074074),
        ['ae_pre_position'] = Amaz.Vector3f(0.5, 0.5, -0.64074074074074),
        ['unifiedScale'] = true,
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
        ['vIntensity'] = 0,
        ['vCenter'] = -0.25,
        ['samples'] = 6,
        ['alpha'] = 1,
        ['mirrorEdge'] = false,
        ['dither'] = 1,
        ['AEDesignSize'] = Amaz.Vector2f(1080, 1080),
    },
    ['LumiLayer_44-trs-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = true,
        ['layerType'] = 'Precomp',
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
        ['blendMode'] = 0,
    },
    ['LumiLayer_74-blend'] = {
        ['hasBlend'] = true,
        ['hasMatte'] = false,
        ['hasTransform'] = false,
        ['layerType'] = 'Precomp',
        ['blendMode'] = 0,
    },
}
data.ae_attribute = ae_attribute

local ae_keyframes = {
    ['LumiRoundCorner_74-effect0#radius#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.333333, 1.833333, }, 
		{{50, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_74-effect1#inFoldPosition#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{1, 1.666667, }, 
		{{-0.46111111111111, 1.39444444444444, }, {1, 0, }, {-0.46111111111111, 1.39444444444444, }, {1, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect2#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.454547, }, 
		{1.03333333333333, 1.36666633333333, }, 
		{{0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 0.39961690431759, }, {0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 0.39961690431759, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.156492, 1, 0.666667, 1, }, 
		{1.36666633333333, 1.86666633333333, }, 
		{{0.5, 0.5, 0.39961690431759, }, {0.5, 0.5, 0, }, {0.5, 0.5, 0.39961690431759, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_74-effect2#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 0.454547, }, 
		{1, 1.333333, }, 
		{{0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 0.39961690431759, }, {0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 0.39961690431759, }, }, 
		{6413, }, 
		{0, }, 
	}, 
	{
		{0.156492, 1, 0.666667, 1, }, 
		{1.333333, 1.833333, }, 
		{{0.5, 0.5, 0.39961690431759, }, {0.5, 0.5, 0, }, {0.5, 0.5, 0.39961690431759, }, {0.5, 0.5, 0, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_43-effect1#inFoldPosition#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.333333, 1, }, 
		{{-0.46111111111111, 1.39444444444444, }, {1, 0, }, {-0.46111111111111, 1.39444444444444, }, {1, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_43-effect2#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.36666633333333, 1.20000033333333, }, 
		{{0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, {0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_43-effect2#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.333333, 1.166667, }, 
		{{0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, {0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_27-effect1#inFoldPosition#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.666667, }, 
		{{-0.46111111111111, 1.39444444444444, }, {1, 0, }, {-0.46111111111111, 1.39444444444444, }, {1, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect2#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.03333333333333, 0.86666633333333, }, 
		{{0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, {0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_27-effect2#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0, 0.833333, }, 
		{{0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, {0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_27-trs#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{0.666667, 0.833333, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_43-trs-blend#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1, 1.166667, }, 
		{{100, }, {0, }, }, 
		{6417, }, 
		{0, }, 
	}, 
},
    ['LumiPageTurn_44-effect1#inFoldPosition#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1.333333, }, 
		{{-0.46111111111111, 1.39444444444444, }, {1, 0, }, {-0.46111111111111, 1.39444444444444, }, {1, 0, }, }, 
		{6415, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_44-effect2#ae_pre_position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.70000033333333, 1.53333333333333, }, 
		{{0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, {0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiMotionBlur3D_44-effect2#position#vector'] =
{
	{
		{0.333333, 0, 0.666667, 1, }, 
		{0.666667, 1.5, }, 
		{{0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, {0.5, 0.5, -0.64074074074074, }, {0.5, 0.5, 2.31481481481481, }, }, 
		{6413, }, 
		{0, }, 
	}, 
},
    ['LumiLayer_44-trs-blend#opacity#number'] =
{
	{
		{0.33333333, 0, 0.66666667, 1, }, 
		{1.333333, 1.5, }, 
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
