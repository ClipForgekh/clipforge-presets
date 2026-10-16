




---------- src/Utils.lua ----------
local Utils = {}


function Utils.log (fmt, ...)
    ---#ifdef DEV
--//    Amaz.LOGW("jorgen", string.format(fmt, ...))
    ---#endif
end

function Utils.clamp (value, min, max)
    return math.min(math.max(min, value), max)
end

function Utils.mix (x, y, a)
    return x + (y - x) * a
end

function Utils.step (edge0, edge1, value)
    return math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
end

function Utils.smoothstep (edge0, edge1, value)
    local t = math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
    return t * t * (3 - t - t)
end

function Utils.mirror (range, value)
    local round = value / range
    local roundF = 1 - math.abs(round % 2 - 1)
    local roundI = math.floor(round)
    return roundF, roundI
end

function Utils.bezier4 (q, x1, x2, x3, x4, y1, y2, y3, y4)
    local p = 1 - q
    local p2 = p * p
    local p3 = p2 * p
    local q2 = q * q
    local q3 = q2 * q
    local x = x1*p3 + 3*x2*p2*q + 3*x3*p*q2 + x4*q3
    local y = y4 and y1*p3 + 3*y2*p2*q + 3*y3*p*q2 + y4*q3
    return x, y
end


function Utils.initPipeline (scene, rootName)
    local order = 0
    local layer = 1
    local function setLayerRecursion (node)
        node.entity.layer = order
        for i = 0, node.children:size() - 1 do
            setLayerRecursion(node.children:get(i))
        end
    end
    local root = scene:findEntityBy(rootName)
    if not root then
        return
    end
    local nodes = root:getComponent("Transform").children
    for i = 0, nodes:size() - 1 do
        local node = nodes:get(i)
        local entity = node.entity
        local camera = entity:getComponent("Camera")
        if camera then
            order = order + 1
            layer = layer * 2
            entity.layer = 0
            camera.renderOrder = order
            camera.layerVisibleMask = Amaz.DynamicBitset.new(64, string.format("%#x", layer))
        end
        setLayerRecursion(node)
    end
end







---------- src/AEAdapter.lua ----------

-- GrabKeyFrameInfo.jsx: KeyFrame path: TRACK_GROUP_NAME/TRACK_NAME
--  AttributeReader.jsx: PerFrame path: TRACK_GROUP_NAME.TRACK_NAME

---@class AEAdapter
local AEAdapter = {}
AEAdapter.__index = AEAdapter
AEAdapter.EPSILON = 0.001


function AEAdapter:new ()
    local self = setmetatable({}, AEAdapter)
    self._tracks = {}
    return self
end


---@param layerName string
---@param layerData table<string, table>
function AEAdapter:addKeyframes (layerName, layerData)
    for trackName, trackData in pairs(layerData) do
        local trackPath = layerName.."/"..trackName
        trackData.keyframe = true
        self._tracks[trackPath] = trackData
    end
end


---@param layerName string
---@param layerData table
function AEAdapter:addFrames (layerName, layerData)
    layerData = layerData.layer0
    self:_addFramesVec2(layerName, layerData, "position")
    self:_addFramesVec2(layerName, layerData, "anchor")
    self:_addFramesVec2(layerName, layerData, "scale")
    self._tracks[layerName..".rotate"] = layerData.rotate
    self._tracks[layerName..".opacity"] = layerData.opacity
end


---@param track string
---@param frame number
---@return number|number[]
function AEAdapter:get (track, frame)
    track = self._tracks[track]
    if not track then
        return
    end
    if not track.keyframe then
        frame = Utils.clamp(frame, 0, #track - 1)
        local f0 = math.floor(frame)
        local f1 = math.ceil(frame)
        local t = frame - f0
        return self._interpolateFrame(track[f0+1], track[f1+1], t)
    end

    if frame <= track[1][3] then
        return track[1][4]
    end
    for i = 2, #track do
        local keyframe1 = track[i]
        if frame < keyframe1[3] then
            local keyframe0 = track[i - 1]
            local x = Utils.step(keyframe0[3], keyframe1[3], frame)
            return self._interpolateKeyframe(keyframe0, keyframe1, x)
        end
    end
    return track[#track][4]
end




function AEAdapter:_addFramesVec2 (name, data, attr)
    data = data[attr]
    if not data then
        return
    end
    local path = name.."."..attr

    if data[1] then
        self._tracks[path] = data
        return
    end

    if data.x then
        self._tracks[path..".x"] = data.x
    end
    if data.y then
        self._tracks[path..".y"] = data.y
    end
end

function AEAdapter._interpolateKeyframe (k0, k1, x)
    local x1 = k0[2][1]
    local x2 = 1 - k1[1][1]
    local t_ = 0
    local _t = 1
    local bezier4 = Utils.bezier4
    repeat
        local _t_ = (t_ + _t) * 0.5
        local _x_ = bezier4(_t_, 0, x1, x2, 1)
        if _x_ > x then
            _t = _t_
        else
            t_ = _t_
        end
    until _t - t_ < AEAdapter.EPSILON

    local t = (t_ + _t) * 0.5
    local y0 = k0[4]
    local y1 = y0 + k0[2][2]
    local y3 = k1[4]
    local y2 = y3 - k1[1][2]
    return bezier4(t, y0, y1, y2, y3)
end

function AEAdapter._interpolateFrame (f0, f1, t)
    local mix = Utils.mix
    if type(f0) == "number" then
        return mix(f0, f1, t)
    end

    local v = {}
    for i = 1, #f0 do
        v[i] = mix(f0[i], f1[i], t)
    end
    return v
end







---------- src/AE.lua ----------

local Motion1 = {
	["0/ADBE Scale/x"]={
		[1]={{0, 0, }, {0.001, 21.4360182876623, }, 0, 50.0173760045453, },
		[2]={{1, 0, }, {0.001, 0, }, 5, 100.034752009091, },
		[3]={{0.16666666667, 0, }, {1, 0, }, 14, 100.034752009091, },
		[4]={{0.001, 14.1279634246754, }, {0.16666666667, 0, }, 19, 133, },
		[5]={{1, 0, }, {0, 0, }, 20, 50.0173759460449, },
	},
	["0/ADBE Scale/y"]={
		[1]={{0, 0, }, {0.001, 21.4285714285714, }, 0, 50, },
		[2]={{1, 0, }, {0.001, 0, }, 5, 100, },
		[3]={{0.16666666667, 0, }, {1, 0, }, 14, 100, },
		[4]={{0.001, 14.1428571428571, }, {0.16666666667, 0, }, 19, 133, },
		[5]={{1, 0, }, {0, 0, }, 20, 50, },
	},
	["0/ADBE Scale/z"]={
		[1]={{0, 0, }, {0.001, 0, }, 0, 100, },
		[2]={{1, 0, }, {0.001, 0, }, 5, 100, },
		[3]={{0.16666666667, 0, }, {1, 0, }, 14, 100, },
		[4]={{0.001, 0, }, {0.16666666667, 0, }, 19, 100, },
		[5]={{1, 0, }, {0, 0, }, 20, 100, },
	},
	["0/ADBE Rotate Z"]={
		[1]={{0, 0, }, {0.21, -4.58235294117647, }, 0, 5, },
		[2]={{0.21, -4.58235294117647, }, {0, 0, }, 19, -4.2, },
		[3]={{0, 0, }, {0, 0, }, 20, 5, },
	},
}

local Motion2 = {
	["0/ADBE Scale/x"]={
		[1]={{0, 0, }, {0.3, 0, }, 0, 103, },
		[2]={{0.73, 0, }, {0.25, 0, }, 5, 98, },
		[3]={{0.65, 0, }, {0, 0, }, 12, 102, },
		[4]={{0, 0, }, {0, 0, }, 19, 104, },
		[5]={{0.16666666667, 0, }, {0, 0, }, 20, 101, },
	},
	["0/ADBE Scale/y"]={
		[1]={{0, 0, }, {0.3, 0, }, 0, 92, },
		[2]={{0.73, 0, }, {0.25, 0, }, 5, 103.3, },
		[3]={{0.65, 0, }, {0, 0, }, 12, 100.5, },
		[4]={{0, 0, }, {0, 0, }, 19, 104, },
		[5]={{0.16666666667, 0, }, {0, 0, }, 20, 90, },
	},
	["0/ADBE Scale/z"]={
		[1]={{0, 0, }, {0.3, 0, }, 0, 100, },
		[2]={{0.73, 0, }, {0.25, 0, }, 5, 100, },
		[3]={{0.65, 0, }, {0, 0, }, 12, 100, },
		[4]={{0, 0, }, {0, 0, }, 19, 100, },
		[5]={{0.16666666667, 0, }, {0, 0, }, 20, 100, },
	},
}

local Effect = {
	["0/ADBE Gaussian Blur 2-0001"]={
		[1]={{0, 0, }, {0.001, 0, }, 0, 22, },
		[2]={{0.6, 0, }, {0.001, 0, }, 5, 0, },
		[3]={{0.16666666667, 0, }, {0.6, 0, }, 14, 0, },
		[4]={{0.001, 0, }, {0.64192164145037, 4.0070767409408, }, 19, 15, },
		[5]={{0.6, 0, }, {0, 0, }, 20, 22, },
	},
	["0/ADBE Radial Blur-0001"]={
		[1]={{0, 0, }, {0.001, 0, }, 0, 122, },
		[2]={{1, 0, }, {0.001, 0, }, 5, 0, },
		[3]={{0.16666666667, 0, }, {1, 0, }, 14, 0, },
		[4]={{0.001, 0, }, {0.16666666667, 0, }, 19, 100, },
		[5]={{1, 0, }, {0, 0, }, 20, 122, },
	},
}

local AE = {
    motion1 = Motion1,
	motion2 = Motion2,
	effect = Effect,
}






---------- src/Main.lua ----------

local RENDER_RATIO = 1.5
local FRAMES = 19
local DESIGN = 1080

local function tr (x)
    return ((RENDER_RATIO - 1) * 0.5 + x) / RENDER_RATIO
end

local Main = {}

function Main:create (scene, node, data, w, h)
    Utils.initPipeline(scene, "@Pipeline")
    node.motion1 = scene:findEntityBy("motion1"):getComponent("MeshRenderer").material
    node.motion2 = scene:findEntityBy("motion2"):getComponent("MeshRenderer").material

	node.blur1r = scene:findEntityBy("blur1r"):getComponent("MeshRenderer").material
	node.blur2r = scene:findEntityBy("blur2r"):getComponent("MeshRenderer").material
	node.blur3r = scene:findEntityBy("blur3r"):getComponent("MeshRenderer").material
	node.blur4r = scene:findEntityBy("blur4r"):getComponent("MeshRenderer").material

    u_step = 0
    node.blur1r:setFloat("u_step", u_step)
    node.blur2r:setFloat("u_step", u_step)
    node.blur3r:setFloat("u_step", u_step)
    node.blur4r:setFloat("u_step", u_step)

    u_spos = 1.0
    node.blur1r:setFloat("u_spos", u_spos)
    node.blur2r:setFloat("u_spos", u_spos)
    node.blur3r:setFloat("u_spos", u_spos)
    node.blur4r:setFloat("u_spos", u_spos)
    
    u_sneg = 1.0
    node.blur1r:setFloat("u_sneg", u_sneg)
    node.blur2r:setFloat("u_sneg", u_sneg)
    node.blur3r:setFloat("u_sneg", u_sneg)
    node.blur4r:setFloat("u_sneg", u_sneg)

    node.blur1x = scene:findEntityBy("blur1x"):getComponent("MeshRenderer").material
    node.blur1y = scene:findEntityBy("blur1y"):getComponent("MeshRenderer").material
    node.blur2x = scene:findEntityBy("blur2x"):getComponent("MeshRenderer").material
    node.blur2y = scene:findEntityBy("blur2y"):getComponent("MeshRenderer").material

    node.crop = scene:findEntityBy("crop"):getComponent("MeshRenderer").material

    node.rt0 = scene:findEntityBy("motion1_camera"):getComponent("Camera").renderTexture
    node.rt1 = scene:findEntityBy("motion2_camera"):getComponent("Camera").renderTexture
    node.rt2 = scene:findEntityBy("crop_camera"):getComponent("Camera").renderTexture

    data.ae = AEAdapter:new()
    data.ae:addKeyframes("motion1", AE.motion1)
    data.ae:addKeyframes("motion2", AE.motion2)
    data.ae:addKeyframes("effect", AE.effect)
end

function Main:layout (node, data, w, h)
    local xw = w * RENDER_RATIO
    local xh = h * RENDER_RATIO
	node.rt0.width = xw
    node.rt0.height = xh
    node.rt1.width = xw
    node.rt1.height = xh
    node.rt2.width = w
    node.rt2.height = h

    local screenSize = Amaz.Vector2f(xw, xh)
    node.motion1:setVec2("u_screen_size", screenSize)
    node.motion2:setVec2("u_screen_size", screenSize)

    local inputSize = Amaz.Vector2f(w, h)
    node.motion1:setVec2("u_size", inputSize)

    node.blur1r:setVec2("u_screen_size", screenSize)
    node.blur2r:setVec2("u_screen_size", screenSize)
    node.blur3r:setVec2("u_screen_size", screenSize)
    node.blur4r:setVec2("u_screen_size", screenSize)

    local center = Amaz.Vector2f(xw * 0.5, xh * 0.5)
    node.blur1r:setVec2("u_center", center)
    node.blur2r:setVec2("u_center", center)
    node.blur3r:setVec2("u_center", center)
    node.blur4r:setVec2("u_center", center)

    local ds = math.min(w, h) / DESIGN
    node.blur1x:setFloat("u_step_x", ds / xw)
    node.blur1y:setFloat("u_step_y", ds / xh)
    node.blur2x:setFloat("u_step_x", ds / xw)
    node.blur2y:setFloat("u_step_y", ds / xh)

    data.ds = ds
end

function Main:update (node, data, w, h, duration, elapsed, progress)
    local f = progress * FRAMES

    local r1 = data.ae:get("motion1/0/ADBE Rotate Z", f)
    node.motion1:setFloat("u_angle", -r1)
    local s1 = data.ae:get("motion1/0/ADBE Scale/y", f) * 0.01
    node.motion1:setFloat("u_scale", s1)

    local s2x = data.ae:get("motion2/0/ADBE Scale/x", f) * 0.01
    local s2y = data.ae:get("motion2/0/ADBE Scale/y", f) * 0.01
    node.motion2:setVec2("u_scale", Amaz.Vector2f(s2x, s2y))

    local br = data.ae:get("effect/0/ADBE Radial Blur-0001", f) * data.ds * 0.1125
    node.blur1r:setFloat("u_step", br)
    node.blur2r:setFloat("u_step", br * 0.5)
    node.blur3r:setFloat("u_step", br * 0.25)
    node.blur4r:setFloat("u_step", br * 0.125)

    local blurFade0 = 0.0
    node.blur1r:setFloat("u_fade0", blurFade0)
    node.blur2r:setFloat("u_fade0", blurFade0)
    node.blur3r:setFloat("u_fade0", blurFade0)
    node.blur4r:setFloat("u_fade0", blurFade0)
    local blurFade1 = 0.18
    node.blur1r:setFloat("u_fade1", blurFade1)
    node.blur2r:setFloat("u_fade1", blurFade1)
    node.blur3r:setFloat("u_fade1", blurFade1)
    node.blur4r:setFloat("u_fade1", blurFade1)

    local bq = data.ae:get("effect/0/ADBE Gaussian Blur 2-0001", f) * 0.1
    node.blur1x:setFloat("u_intensity", bq)
    node.blur1y:setFloat("u_intensity", bq)
    node.blur1x:setFloat("u_intensity", bq * 0.5)
    node.blur1y:setFloat("u_intensity", bq * 0.5)

    node.crop:setFloat("u_ratio", RENDER_RATIO)
    node.crop:setFloat("u_opacity", 1)
end






---------- src/AnimEntry.lua ----------

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
---@class SeekModeScript : ScriptComponent
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field autoplay boolean

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)

    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.progress = 0
    self.curTime = 0
    self.startTime = 0
    self._duration = 15
    self.autoplay = true

    self.playDuration = 2

    return self
end

function SeekModeScript:constructor()
end

function SeekModeScript:_adapt_onStart(comp)
    self.curTime = 0
    self.duration = 2.0
    self.values = {}
    self.params = {}
    self.anims = {}
    self.animDirty = true
    self.entity = comp.entity
    self.scaleCorrect = 1.0
    self.videoMat = self.entity.scene:findEntityBy("video"):getComponent("MeshRenderer").material
    self.modelMat = self.entity.scene:findEntityBy("quad"):getComponent("MeshRenderer").material
    self.fxaaMat = self.entity.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.entity.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.transform = self.entity.scene:findEntityBy("quad"):getComponent("Transform")
    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)

    --
    self.__userNode__ = {}
    self.__userData__ = {}
    --
end

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)
    self.rootDir = comp.entity.scene.assetMgr.rootDir

    --
    self.__userData__.w0 = Amaz.BuiltinObject.getInputTextureWidth()
    self.__userData__.h0 = Amaz.BuiltinObject.getInputTextureHeight()
    Main:create(comp.entity.scene, self.__userNode__, self.__userData__, self.__userData__.w0, self.__userData__.h0)
    Main:layout(self.__userNode__, self.__userData__, self.__userData__.w0, self.__userData__.h0)
    Main:update(self.__userNode__, self.__userData__, self.__userData__.w0, self.__userData__.h0, 1, 0, 0)
    --
end

function SeekModeScript:autoPlay(time)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        if self.autoplay then
            self.progress = time % self._duration / self._duration
        end
    else
        -- self.duration = self.endTime - self.startTime
        -- self.progress = time % self.duration / self.duration
        self.progress = math.mod(time/(self.duration+0.0001), 1)
    end
end

--if Amaz.Macros and Amaz.Macros.EditorSDK then
--    function SeekModeScript:onUpdate(comp, detalTime)
--        self.blendMat:enableMacro("AMAZING_EDITOR_DEV", 1)
--        self.modelMat:enableMacro("AMAZING_EDITOR_DEV", 1)
--
--        self.lastTime = self.curTime
--        self.curTime = self.curTime + detalTime
--        self:autoPlay(self.curTime)
--        self:seek(self.curTime - self.startTime)
--    end
--end

function SeekModeScript:autoPlay(time)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        if self.autoplay then
            self.progress = time % self._duration / (self._duration + 0.01)
        end
    else
        -- self.duration = self.endTime - self.startTime
        -- -- local whole = self._duration / self.duration
        -- self.progress = time % (self._duration+0.001) / (self._duration + 0.001)
        self.progress = time / self._duration
    end
end

function SeekModeScript:_adapt_seek(time)
    local inputW = Amaz.BuiltinObject:getInputTextureWidth()
    local inputH = Amaz.BuiltinObject:getInputTextureHeight()
    local inputRatio = inputW / inputH
    local outputW = Amaz.BuiltinObject:getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject:getOutputTextureHeight()
    local outputRatio = outputW / outputH
    local fitScale = Amaz.Vector3f(1, 1, 1)
    local extraScale = 1
    if inputRatio < outputRatio then
        fitScale.x = inputRatio
        extraScale = inputH / outputH
    else
        fitScale.x = outputRatio
        fitScale.y = outputRatio / inputRatio
        extraScale = inputW / outputW
    end

    local uvScale = Amaz.Vector2f(1, 1)
    local xRatio = inputRatio / outputRatio
    local yRatio = outputRatio / inputRatio
    if outputRatio > 1. then
        if outputRatio > inputRatio then
            uvScale.x = xRatio
        else
            uvScale.y = yRatio
        end
    elseif math.abs(outputRatio - 1.) < .1 then
        if inputRatio < 1. then
            uvScale.x = xRatio
        else
            uvScale.y = yRatio
        end
    elseif outputRatio < 1. then
        if math.abs(inputRatio - 1.) < .1 or outputRatio < inputRatio then
            uvScale.y = yRatio
        else
            uvScale.x = xRatio
        end
    end

    self.modelMat:setFloat("u_OutputWidth", outputW)
    self.modelMat:setFloat("u_OutputHeight", outputH)

    local userMat = Amaz.Matrix4x4f()
    userMat:setTRS(
        Amaz.Vector3f(self.userPosition.x * outputRatio, self.userPosition.y, self.userPosition.z),
        Amaz.Quaternionf.EulerToQuaternion(-self.userEulerAngle / 180 * math.pi),
        Amaz.Vector3f(1, 1, 1) * self.userScale.x * extraScale
    )
    userMat:invert_Full()

    local fitMat = Amaz.Matrix4x4f()
    fitMat:setTRS(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.identity(), Amaz.Vector3f(uvScale.x, uvScale.y, 1))
    fitMat:invert_Full()

    self.modelMat:setMat4("userMat", userMat)
    self.modelMat:setMat4("fitMat", fitMat)
end

function SeekModeScript:seek(time)
    self:_adapt_seek(time)
    -- self:autoPlay(time)
    self.progress = math.mod(time/(self.duration+0.0001), 1)

    --
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if w ~= self.__userData__.w0 or h ~= self.__userData__.h0 then
        self.__userData__.w0 = w
        self.__userData__.h0 = h
        Main:layout(self.__userNode__, self.__userData__, self.__userData__.w0, self.__userData__.h0)
    end
    Main:update(self.__userNode__, self.__userData__, self.__userData__.w0, self.__userData__.h0, self.duration, time, self.progress)
    --
end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        -- local bgAspect = value.x / value.y
        -- local videoAspect = value.z / value.w
        -- if bgAspect > videoAspect then
        --     self.scaleCorrect = value.w / value.y
        -- else
        --     self.scaleCorrect = value.z / value.x
        -- end
        -- self.videoMat:setVec4("u_size", value)
        -- self.modelMat:setVec4("u_size", value)
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
    elseif name == "u_pos" then
        -- self.videoMat:setVec2("u_pos", value)
        -- self.blendMat:setVec2("u_pos", value)
        self.userPosition:set(value.x, value.y, 0)
    elseif name == "u_angle" then
        -- self.videoMat:setFloat("u_angle", value)
        -- self.blendMat:setFloat("u_angle", value)
        self.userEulerAngle:set(0, 0, value / math.pi * 180)
    elseif name == "u_scale" then
        -- self.videoMat:setFloat("u_scale", value)
        -- self.blendMat:setFloat("u_scale", value * self.scaleCorrect)
        self.userScale:set(value, value, 1)
    elseif name == "u_flipX" then
        self.videoMat:setFloat("u_flipX", value)
    elseif name == "u_flipY" then
        self.videoMat:setFloat("u_flipY", value)
    elseif name == "_alpha" then
        self.blendMat:setFloat("_alpha", value)
    end
end

function SeekModeScript:setDuration(duration)
    self.duration = duration
end


---#ifdef DEV
--//function SeekModeScript:onEvent (comp, event)
--//    if event.type == Amaz.EventType.TOUCH then
--//        local pointer = event.args:get(0)
--//        local type = pointer.type
--//        if type == Amaz.TouchType.TOUCH_BEGAN or type == Amaz.TouchType.TOUCH_MOVED then
--//            self:seek(pointer.x * self.duration)
--//        end
--//    end
--//end
---#endif


exports.SeekModeScript = SeekModeScript
return exports
