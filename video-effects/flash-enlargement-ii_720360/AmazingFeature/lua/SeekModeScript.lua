




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







---------- src/Main.lua ----------

local TR = {
    x = {
        0.9961947306644,
        0.99619472566876,
        0.99619472020902,
        0.99619471488272,
        0.99619470991381,
        0.99619470548148,
        0.99619470179556,
        0.99619469915888,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
        0.99619469809175,
    },
    y = {
        0.07715574584985,
        0.21863875022939,
        0.37326562908552,
        0.52411337808024,
        0.66483945677799,
        0.79036874762815,
        0.89475890303437,
        0.96943308458057,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
        0.99965574274766,
    },
    s = {
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1.45,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
        1.35,
    },
    r0 = {
        -3,
        5,
        -0.50000000002475,
        -6,
        1.0000000000315,
        8,
        5.92592591796877,
        2.07407408199924,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    },
    r1 = {
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        5,
        0,
        -7.7920590208922,
        -18.7325951009928,
        -30,
        -30,
    },
}

local FRAMES = 36
local SCALE0 = 1.15
local RT = 200 / 7.3
local RN = 0
local BLUR_RADIAN = math.rad(2)
local BLUR_RADIUS = 1

local Main = {}

function Main:create (scene, node, data, w, h)
    Utils.initPipeline(scene, "@Pipeline")
    node.motion1 = scene:findEntityBy("motion1"):getComponent("MeshRenderer").material
    node.motion2 = scene:findEntityBy("motion2"):getComponent("MeshRenderer").material
    node.motion = scene:findEntityBy("motion"):getComponent("MeshRenderer").material
    node.exposure = scene:findEntityBy("exposure"):getComponent("MeshRenderer").material

    node.blurD = {
        scene:findEntityBy("blur1t_camera"),
        scene:findEntityBy("blur2t_camera"),
        scene:findEntityBy("blur3t_camera"),
        scene:findEntityBy("blur4t_camera"),
        scene:findEntityBy("blur1n_camera"),
        scene:findEntityBy("blur2n_camera"),
    }
    node.blurC = {
        scene:findEntityBy("blur1c_camera"),
        scene:findEntityBy("blur2c_camera"),
        scene:findEntityBy("blur3c_camera"),
        scene:findEntityBy("blur4c_camera"),
        scene:findEntityBy("blur1r_camera"),
        scene:findEntityBy("blur2r_camera"),
    }

    node.blur1t = scene:findEntityBy("blur1t"):getComponent("MeshRenderer").material
    node.blur2t = scene:findEntityBy("blur2t"):getComponent("MeshRenderer").material
    node.blur3t = scene:findEntityBy("blur3t"):getComponent("MeshRenderer").material
    node.blur4t = scene:findEntityBy("blur4t"):getComponent("MeshRenderer").material
    node.blur1n = scene:findEntityBy("blur1n"):getComponent("MeshRenderer").material
    node.blur2n = scene:findEntityBy("blur2n"):getComponent("MeshRenderer").material

    node.blur1c = scene:findEntityBy("blur1c"):getComponent("MeshRenderer").material
    node.blur2c = scene:findEntityBy("blur2c"):getComponent("MeshRenderer").material
    node.blur3c = scene:findEntityBy("blur3c"):getComponent("MeshRenderer").material
    node.blur4c = scene:findEntityBy("blur4c"):getComponent("MeshRenderer").material
    node.blur1r = scene:findEntityBy("blur1r"):getComponent("MeshRenderer").material
    node.blur2r = scene:findEntityBy("blur2r"):getComponent("MeshRenderer").material

    node.rt0 = scene:findEntityBy("motion1_camera"):getComponent("Camera").renderTexture
    node.rt1 = scene:findEntityBy("motion2_camera"):getComponent("Camera").renderTexture
end

function Main:layout (node, data, w, h)
    node.rt0.width = w
    node.rt0.height = h
    node.rt1.width = w
    node.rt1.height = h

    local screenSize = Amaz.Vector2f(w, h)
    node.motion1:setVec2("u_screen_size", screenSize)
    node.motion2:setVec2("u_screen_size", screenSize)
    node.motion:setVec2("u_screen_size", screenSize)
    node.blur1c:setVec2("u_screen_size", screenSize)
    node.blur2c:setVec2("u_screen_size", screenSize)
    node.blur3c:setVec2("u_screen_size", screenSize)
    node.blur4c:setVec2("u_screen_size", screenSize)
    node.blur1r:setVec2("u_screen_size", screenSize)
    node.blur2r:setVec2("u_screen_size", screenSize)

    local center = Amaz.Vector2f(w, 0)
    node.blur1c:setVec2("u_center", center)
    node.blur2c:setVec2("u_center", center)
    node.blur3c:setVec2("u_center", center)
    node.blur4c:setVec2("u_center", center)
    node.blur1r:setVec2("u_center", center)
    node.blur2r:setVec2("u_center", center)

    local dx = 1 / w
    node.blur1t:setFloat("u_step_x", dx)
    node.blur2t:setFloat("u_step_x", dx)
    node.blur3t:setFloat("u_step_x", dx)
    node.blur4t:setFloat("u_step_x", dx)
    node.blur1n:setFloat("u_step_x", dx)
    node.blur2n:setFloat("u_step_x", dx)

    local dy = 1 / h
    node.blur1t:setFloat("u_step_y", dy)
    node.blur2t:setFloat("u_step_y", dy)
    node.blur3t:setFloat("u_step_y", dy)
    node.blur4t:setFloat("u_step_y", dy)
    node.blur1n:setFloat("u_step_y", dy)
    node.blur2n:setFloat("u_step_y", dy)
end

function Main:update (node, data, w, h, duration, elapsed, progress)
    local i = progress * FRAMES + 1
    local i0 = math.floor(i)
    local i1 = math.ceil(i)
    local t = i - i0

    local exposure = Utils.mix(1, 2.6 * 0.8, Utils.step(16/FRAMES, 17/FRAMES, progress) * Utils.step(21/FRAMES, 17/FRAMES, progress))
    node.exposure:setFloat("u_intensity", exposure)

    local scale1 = Utils.mix(TR.s[i0], TR.s[i1], t) * SCALE0
    node.motion1:setFloat("u_scale", scale1)
    node.motion:setFloat("u_scale1", scale1)
    local angle1 = Utils.mix(TR.r0[i0], TR.r0[i1], t)
    node.motion1:setFloat("u_angle", -angle1)
    node.motion:setFloat("u_angle1", -angle1)

    local x2 = Utils.mix(TR.x[i0], TR.x[i1], t)
    local y2 = Utils.mix(TR.y[i0], TR.y[i1], t)
    node.motion2:setVec2("u_position", Amaz.Vector2f(x2, 1 - y2))
    node.motion:setVec2("u_position2", Amaz.Vector2f(x2, 1 - y2))
    local angle2 = Utils.mix(TR.r1[i0], TR.r1[i1], t)
    node.motion2:setFloat("u_angle", -angle2)
    node.motion:setFloat("u_angle2", -angle2)

    local px1 = math.min(w, h) / 800
    if progress < 8/FRAMES then
        self._enableBlur(node.blurD, true)
        self._enableBlur(node.blurC, false)
        local Rt = Utils.mix(RT, 0, Utils.step(0, 8/FRAMES, progress)) * px1
        node.blur1t:setFloat("u_intensity", Rt)
        node.blur2t:setFloat("u_intensity", Rt * 0.5)
        node.blur3t:setFloat("u_intensity", Rt * 0.25)
        node.blur4t:setFloat("u_intensity", Rt * 0.125)
        local Rn = Utils.mix(RN, 0, Utils.step(0, 8/FRAMES, progress)) * px1
        node.blur1n:setFloat("u_intensity", Rn)
        node.blur2n:setFloat("u_intensity", Rn * 0.5)
    elseif progress > 31/FRAMES then
        self._enableBlur(node.blurD, false)
        self._enableBlur(node.blurC, true)
        local Ra = Utils.mix(0, BLUR_RADIAN, Utils.step(31/FRAMES, 1, progress))
        node.blur1c:setFloat("u_radian", Ra)
        node.blur2c:setFloat("u_radian", Ra * 0.5)
        node.blur3c:setFloat("u_radian", Ra * 0.25)
        node.blur4c:setFloat("u_radian", Ra * 0.125)
        local Rr = Utils.mix(0, BLUR_RADIUS, Utils.step(31/FRAMES, 1, progress)) * px1
        node.blur1r:setFloat("u_step", Rr)
        node.blur2r:setFloat("u_step", Rr * 0.5)
    else
        self._enableBlur(node.blurD, false)
        self._enableBlur(node.blurC, false)
    end
end

function Main._enableBlur (cameras, enabled)
    for _, camera in ipairs(cameras) do
        camera.visible = enabled
    end
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
