local Utils = require("common/Utils")
local Mat3 = require("common/Mat3")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local LEWrapper = require("cc/LEWrapper")
local AE = require("AE")

local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.DURATION = 40 / 30
    self.BLUR3_FRAMES = 16
    self.BLUR2_FRAMES = 16
    self.FOV = 39.6
    self.AE = AE
    return self
end

function VAMain:create (env, scene)
    local order = 0
    order = Helper.initPipeline(scene, "main", order)
    order = Helper.initPipeline(scene, "base", order)

    self.square = scene:findEntityBy("Square"):getComponent("MeshRenderer").material
    self.Image5 = scene:findEntityBy("Image5"):getComponent("MeshRenderer").material
    self.blend5 = scene:findEntityBy("Blend5"):getComponent("MeshRenderer").material
    self.blendmi1 = scene:findEntityBy("Blend1"):getComponent("MeshRenderer").material
    self.blendmi2 = scene:findEntityBy("Blend2"):getComponent("MeshRenderer").material
    self.blendmi3 = scene:findEntityBy("Blend3"):getComponent("MeshRenderer").material
    self.blendmi4 = scene:findEntityBy("Blend4"):getComponent("MeshRenderer").material

    self.LumiDeepGlow = scene:findEntityBy("LumiDeepGlow"):getComponent("ScriptComponent").properties

    self.LuaExposure = LEWrapper:new(scene, "LuaExposure")
    --self.LuaExposure = scene:findEntityBy("LuaExposure"):getComponent("ScriptComponent")
    self.root1 = scene:findEntityBy("Root001"):getComponent("ScriptComponent")
    self.layers = {}
    for i = 1, 4 do
        local id = string.format("%d", i)
        local cameraMask = scene:findEntityBy("CameraMask" .. id):getComponent("Camera")
        local shaderMask = scene:findEntityBy("Mask" .. id):getComponent("MeshRenderer").material
        local cameraImage = scene:findEntityBy("CameraImage" .. id):getComponent("Camera")
        local shaderImage = scene:findEntityBy("Image" .. id):getComponent("MeshRenderer").material
        table.insert(self.layers, {
            cameraMask = cameraMask,
            shaderMask = shaderMask,
            cameraImage = cameraImage,
            shaderImage = shaderImage,
        })
    end

    self.cameraImage5 = scene:findEntityBy("CameraImage5"):getComponent("Camera")

    self.rti = scene.assetMgr:SyncLoad("rt/rti.rt")
    self.rt1 = scene.assetMgr:SyncLoad("rt/rt1.rt")
    self.rt2 = scene.assetMgr:SyncLoad("rt/rt2.rt")
    self.rt6 = scene.assetMgr:SyncLoad("rt/rt6.rt")
    self.rt7 = scene.assetMgr:SyncLoad("rt/rt7.rt")

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
    local maxEdge = math.max(w, h)
    self.rti.width = maxEdge
    self.rti.height = maxEdge
    self.rt1.width = w
    self.rt1.height = h
    self.rt2.width = w
    self.rt2.height = h
    self.rt6.width = w
    self.rt6.height = h
    self.rt7.width = w
    self.rt7.height = h

    local s = 1080 / maxEdge
    self.scale = s
    maxEdge = maxEdge * s
    w = w * s
    h = h * s

    self.square:setFloat("u_aspect_src", w / h)
    self.f = (w * 0.5) / math.tan(math.rad(self.FOV * 0.5))

    self.w = w
    self.h = h

    local a = math.atan((h * 0.5) / self.f) * 180 / math.pi
    a = a * 2

    for i, layer in ipairs(self.layers) do
        layer.cameraMask.fovy = a
        layer.cameraImage.fovy = a
    end

    self.cameraImage5.fovy = a
end

function VAMain:update (env, duration, elapsed, progress)
    elapsed = progress * (32 / 30)

    --local a = elapsed > (31 / 30) and 0 or 1

    self.blendmi1:setFloat("u_opacity", 1)
    self.blendmi2:setFloat("u_opacity", 1)
    self.blendmi3:setFloat("u_opacity", 1)
    self.blendmi4:setFloat("u_opacity", 1)

    local w = self.w
    local h = self.h

    local image_move = {
        {
            x = -356 + 569.5,
            y = 356 - 569.3,
            s = 540 * 0.791,
        }, {
            x = -356 + 569.5,
            y = 356 - 569.3,
            s = 540 * 0.791,
            rz = 90
        }, {
            x = -356 + 569.5,
            y = 356 - 569.3,
            s = 540 * 0.791,
            rz = 180
        }, {
            x = -356 + 569.5,
            y = 356 - 569.3,
            s = 540 * 0.791,
            rz = 270
        }, {
            x = 0,
            y = 0,
            s = 540 * 0.791,
            rz = 270
        }

    }

    local p0 = self.ae:get("/0_Position", elapsed)

    for i = 1, 4 do
        local layer = self.layers[i]
        local pm = self.ae:get("/M" .. i .. "_Position", elapsed)
        layer.shaderMask:setMat4("u_AEModel", Utils.aeTransform({
            { x = p0[1] - 540,
              y = 540 - p0[2],
              z = -self.f,
              rx = self.ae:get("/0_RotateX", elapsed)[1],
              ry = self.ae:get("/0_RotateY", elapsed)[1],
              rz = self.ae:get("/0_RotateZ", elapsed)[1],
              s = self.ae:get("/0_Scale", elapsed)[1] * 0.01
            },
            { x = pm[1],
              y = -pm[2],
              rz = self.ae:get("/M" .. i .. "_RotateZ", elapsed)[1],
              s = 356,
            },
        }))
        layer.shaderImage:setMat4("u_AEModel", Utils.aeTransform({
            { x = p0[1] - 540,
              y = 540 - p0[2],
              z = -self.f,
              rx = self.ae:get("/0_RotateX", elapsed)[1],
              ry = self.ae:get("/0_RotateY", elapsed)[1],
              rz = self.ae:get("/0_RotateZ", elapsed)[1],
              s = self.ae:get("/0_Scale", elapsed)[1] * 0.01
            },
            { x = pm[1],
              y = -pm[2],
              rz = self.ae:get("/M" .. i .. "_RotateZ", elapsed)[1],
            },
            image_move[i]
        }))
    end

    self.Image5:setMat4("u_AEModel", Utils.aeTransform({
            { x = p0[1] - 540,
              y = 540 - p0[2],
              z = -self.f,
              rx = self.ae:get("/0_RotateX", elapsed)[1],
              ry = self.ae:get("/0_RotateY", elapsed)[1],
              rz = self.ae:get("/0_RotateZ", elapsed)[1],
              s = self.ae:get("/0_Scale", elapsed)[1] * 0.01
            },
            image_move[5]
    }))

    local screenWidth = Amaz.BuiltinObject.getInputTextureWidth()
    local screenHeight = Amaz.BuiltinObject.getInputTextureHeight()

    self.blend5:setFloat("u_opacity0", self.ae:get("/Opacity_5", elapsed)[1] / 100)


    self.blend5:setMat4("u_mat", Utils.uvTransform(Amaz.Vector2f(screenWidth, screenHeight), {
        {
            w = screenWidth,
            h = screenHeight,
            ax = 0.5,
            ay = 0.5,
            x = screenWidth * 0.5,
            y = screenHeight * 0.5,
        },
    }))

    self.LumiDeepGlow:set("exposure", self.ae:get("/Deep_Glow_Exposure", elapsed)[1])
    self.LumiDeepGlow:set("glowIntensity", self.ae:get("/Glow_Intensity", elapsed)[1] / 100)


    self.LuaExposure.exposure = self.ae:get("/Exposure", elapsed)[1]
    

    if not self.rootTool then
        self.rootTool = Helper.getLuaObject(self.root1)
    end
    if self.rootTool then
        self.rootTool.size = self.ae:get("/size_70", elapsed)[1]
        self.rootTool.specOpacity = self.ae:get("/highlightOpacity_77", elapsed)[1] * 0.01
        self.rootTool.shadowOpacity = self.ae:get("/shadowOpacity_80", elapsed)[1] * 0.01
    end







end

return VAMain