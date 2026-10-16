local Utils = require("common/Utils")
local Mat3 = require("common/Mat3")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.DURATION = 40/30
    self.BLUR3_FRAMES = 16
    self.BLUR2_FRAMES = 16
    self.FOV = 39.6
    self.AE = AE
    return self
end


function VAMain:create (env, scene)
    local order = 0
    order = Helper.initPipeline(scene, "main", order, 128)
    Utils.log("order = %d", order)
    order = Helper.initPipeline(scene, "base", order, 128)
    Utils.log("order = %d", order)

    self.square = scene:findEntityBy("Square"):getComponent("MeshRenderer").material
    self.layers = {}
    for i = 1, self.BLUR3_FRAMES do
        local id = string.format("%02d", i)
        local camera = scene:findEntityBy("CameraMove"..id):getComponent("Camera")
        local motion = scene:findEntityBy("Move"..id):getComponent("MeshRenderer").material
        local output = scene:findEntityBy("Blur"..id):getComponent("MeshRenderer").material
        output:setFloat("u_opacity", 1 / self.BLUR3_FRAMES)
        table.insert(self.layers, {camera = camera, motion = motion, output = output})
    end
    self.motionBlur = scene:findEntityBy("MotionBlur"):getComponent("MeshRenderer").material
    self.blend32 = scene:findEntityBy("Blend32"):getComponent("MeshRenderer").material
    self.root3 = scene:findEntityBy("MotionBlur3D")
    self.root2 = scene:findEntityBy("MotionBlur2D")

    self.sat = scene:findEntityBy("LuaSaturation"):getComponent("ScriptComponent").properties
    self.glow = scene:findEntityBy("LumiDeepGlow"):getComponent("ScriptComponent").properties

    self.rti = scene.assetMgr:SyncLoad("rt/rti.rt")
    self.rt2 = scene.assetMgr:SyncLoad("rt/rt2.rt")

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
    local maxEdge = math.max(w, h)
    self.rti.width = maxEdge
    self.rti.height = maxEdge
    self.rt2.width = maxEdge
    self.rt2.height = maxEdge
    local s = 1080 / maxEdge
    maxEdge = maxEdge * s
    w = w * s
    h = h * s

    self.square:setFloat("u_aspect_src", w/h)

    for i, layer in ipairs(self.layers) do
        layer.camera.fovy = self.FOV
        layer.output:setFloat("u_dst_aspect", w/h)
        layer.output:setFloat("u_src_aspect", 1)
    end

    self.motionBlur:setVec2("u_screen_size", Amaz.Vector2f(w, h))
    self.motionBlur:setVec2("u_sprite_size", Amaz.Vector2f(w, h))

    self.f = h * 0.5 / math.tan(math.rad(self.FOV * 0.5))
    self.w = w
    self.h = h
end

function VAMain:update (env, duration, elapsed, progress)
    elapsed = progress * self.DURATION
    local elapsed0 = elapsed - 0.3/30
    local elapsed1 = elapsed + 0.3/30
    local w = self.w
    local h = self.h

    if elapsed < 24/30 then
        local p
        for i = 0, self.BLUR3_FRAMES - 1 do
            local t = Utils.mix(elapsed0, elapsed1, i/self.BLUR3_FRAMES)
            local layer = self.layers[i + 1]
            local model = Utils.aeTransform({
                {x = self.ae:get("/3Position_x", t)[1] - 540,
                 y = 540 - self.ae:get("/3Position_y", t)[1],
                 z = -self.ae:get("/3Position_z", t)[1] - self.f,
                 rx = 36,
                 ry = 9,
                 rz = 337,
                 s = 540 * self.ae:get("/3Scale", t)[1] * 0.01},
                {rx = self.ae:get("/3Rotate_x", t)[1],
                 ry = self.ae:get("/3Rotate_y", t)[1],
                 rz = self.ae:get("/3Rotate_z", t)[1]},
            })
            layer.motion:setMat4("u_AEModel", model)
            if i == math.floor(self.BLUR3_FRAMES/2) then
                p = model:multiplyVector4(Amaz.Vector4f(0, 0, 0, 1))
                p = layer.camera.projectionMatrix:multiplyVector4(p)
            end
        end
        self.root3.visible = true
        self.blend32:setFloat("u_opacity3d", 1)
    else
        self.root3.visible = false
        self.blend32:setFloat("u_opacity3d", 0)
    end
    self.sat:set("saturationIntensity", self.ae:get("/Saturation_intensity", elapsed)[1] * 0.01)

    if elapsed >= 23/30 then
        Mat3.toMaterialVector(self.motionBlur, "u_matrices", self.BLUR2_FRAMES, function (i)
            local t = Utils.mix(elapsed0, elapsed1, i/self.BLUR2_FRAMES)
            local q = self.ae:get("/2Position", t)
            local x = w * 0.5 + (q[1] - 540)
            local y = h * 0.5 - (q[2] - 540)
            local s = self.ae:get("/2Scale", t)[1] * 0.01
            local r = -self.ae:get("/2Rotate", t)[1]
            return Mat3.makeTransform(nil, { {w = w, h = h, ax = 0.5, ay = 0.5, x = x, y = y, s = s, r = r} })
        end)
        self.root2.visible = true
        self.blend32:setFloat("u_opacity2d", self.ae:get("/2Opacity", elapsed)[1] * 0.01)
    else
        self.root2.visible = false
        self.blend32:setFloat("u_opacity2d", 0)
    end

    self.glow:set("exposure", self.ae:get("/DeepGlow_exposure", elapsed)[1])
    self.glow:set("glowIntensity", self.ae:get("/DeepGlow_intensity", elapsed)[1] * 0.01)
end

return VAMain