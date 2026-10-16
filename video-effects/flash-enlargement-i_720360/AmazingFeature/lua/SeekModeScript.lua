




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
        1.28667850207743,
        1.45,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
        1.2,
    },
    r = {
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
        0,
        4.000000000018,
        8,
        -3.59978713504461e-11,
        -8,
        5,
        -5,
    },
    x = {
        0.755,
        0.66508669096853,
        0.57655829476603,
        0.50678592981168,
        0.475,
        0.48407341904521,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
    },
    y = {
        0.75,
        0.66256838326687,
        0.57647036188544,
        0.5085397237085,
        0.4775,
        0.48566607714069,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.55538482676619,
        0.68622584999265,
        0.86294511855821,
        1.06906255687805,
        1.2909349342613,
        1.5,
    },
}

local FRAMES = 35
local DIR_I = 135 / 180
local DIR_O = 90 / 180
local RT_I = 90.7 / 7.3
local RT_O = 200 / 7.3
local RN = 1

local Main = {}

function Main:create (scene, node, data, w, h)
    Utils.initPipeline(scene, "@Pipeline")
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

    node.blur1t = scene:findEntityBy("blur1t"):getComponent("MeshRenderer").material
    node.blur2t = scene:findEntityBy("blur2t"):getComponent("MeshRenderer").material
    node.blur3t = scene:findEntityBy("blur3t"):getComponent("MeshRenderer").material
    node.blur4t = scene:findEntityBy("blur4t"):getComponent("MeshRenderer").material
    node.blur1n = scene:findEntityBy("blur1n"):getComponent("MeshRenderer").material
    node.blur2n = scene:findEntityBy("blur2n"):getComponent("MeshRenderer").material

    node.rt0 = scene:findEntityBy("motion_camera"):getComponent("Camera").renderTexture
    node.rt1 = scene:findEntityBy("exposure_camera"):getComponent("Camera").renderTexture

    node.motion:setVec2("u_position", Amaz.Vector2f(TR.x[1], 1 - TR.y[1]))
end

function Main:layout (node, data, w, h)
    node.rt0.width = w
    node.rt0.height = h
    node.rt1.width = w
    node.rt1.height = h

    node.motion:setVec2("u_screen_size", Amaz.Vector2f(w, h))

    local s = math.min(w, h) / 800
    local dx = s / w
    local dy = s / h
    node.blur1t:setFloat("u_step_x", dx)
    node.blur2t:setFloat("u_step_x", dx)
    node.blur3t:setFloat("u_step_x", dx)
    node.blur4t:setFloat("u_step_x", dx)
    node.blur1n:setFloat("u_step_x", dx)
    node.blur2n:setFloat("u_step_x", dx)

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
    local scale = Utils.mix(TR.s[i0], TR.s[i1], t)
    local angle = Utils.mix(TR.r[i0], TR.r[i1], t)
    local x = Utils.mix(TR.x[i0], TR.x[i1], t)
    local y = Utils.mix(TR.y[i0], TR.y[i1], t)
    node.motion:setFloat("u_scale", scale)
    node.motion:setFloat("u_angle", -angle)
    node.motion:setVec2("u_position", Amaz.Vector2f(x, 1 - y))
    Amaz.LOGE("----------", "y = "..(1 - y))

    local exposure = Utils.mix(1, 2.6 * 0.8, Utils.step(14/FRAMES, 15/FRAMES, progress) * Utils.step(19/FRAMES, 15/FRAMES, progress))
    node.exposure:setFloat("u_intensity", exposure)

    local d, Rt, Rn
    if progress < 5/FRAMES then
        self._enableBlur(node.blurD, true)
        d = DIR_I
        Rt = Utils.mix(RT_I, 0, Utils.step(0/FRAMES, 5/FRAMES, progress))
        Rn = Utils.mix(RN, 0, Utils.step(0/FRAMES, 5/FRAMES, progress))
    elseif progress > 28/FRAMES then
        self._enableBlur(node.blurD, true)
        d = DIR_O
        Rt = Utils.mix(0, RT_O, Utils.step(28/FRAMES, 35/FRAMES, progress))
        Rn = Utils.mix(0, RN, Utils.step(28/FRAMES, 35/FRAMES, progress))
    else
        d = 0
        Rt = 0
        Rn = 0
        self._enableBlur(node.blurD, false)
    end
    node.blur1t:setFloat("u_direction", d)
    node.blur2t:setFloat("u_direction", d)
    node.blur3t:setFloat("u_direction", d)
    node.blur4t:setFloat("u_direction", d)
    node.blur1n:setFloat("u_direction", d + 0.5)
    node.blur2n:setFloat("u_direction", d + 0.5)

    node.blur1t:setFloat("u_intensity", Rt)
    node.blur2t:setFloat("u_intensity", Rt * 0.5)
    node.blur3t:setFloat("u_intensity", Rt * 0.25)
    node.blur4t:setFloat("u_intensity", Rt * 0.125)
    node.blur1n:setFloat("u_intensity", Rn)
    node.blur2n:setFloat("u_intensity", Rn * 0.5)
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
