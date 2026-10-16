local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.DESIGN_SIZE = 1080
    self.DESIGN_FOV = math.rad(39.6)
    self.DESIGN_CAMERA_Z = -(self.DESIGN_SIZE/2) / math.tan(self.DESIGN_FOV/2)
    self.RENDER_RATIO = 1.5
    self.DURATION = 18 / 30
    self.GS_X_INTENSITY = 0.5
    self.GS_Y_INTENSITY = 0.5
    self.AE = AE
    return self
end
function VAMain:tr (x)
    return ((self.RENDER_RATIO - 1) * 0.5 + x) / self.RENDER_RATIO
end


function VAMain:create (env, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.bx1 = scene:findEntityBy("bx1"):getComponent("MeshRenderer").material
    self.bx2 = scene:findEntityBy("bx2"):getComponent("MeshRenderer").material
    self.bx3 = scene:findEntityBy("bx3"):getComponent("MeshRenderer").material
    self.bx4 = scene:findEntityBy("bx4"):getComponent("MeshRenderer").material
    self.by1 = scene:findEntityBy("by1"):getComponent("MeshRenderer").material
    self.by2 = scene:findEntityBy("by2"):getComponent("MeshRenderer").material

    self.spriteT = scene:findEntityBy("sprite"):getComponent("Transform")
    self.spriteM = scene:findEntityBy("sprite"):getComponent("MeshRenderer").material
    self.spriteC = scene:findEntityBy("camera_sprite"):getComponent("Camera")
    self.spriteCT = scene:findEntityBy("camera_sprite"):getComponent("Transform")
    self.exposure = scene:findEntityBy("exposure"):getComponent("MeshRenderer").material

    self.ert0 = scene:findEntityBy("camera_bx2"):getComponent("Camera").renderTexture
    self.ert1 = scene:findEntityBy("camera_bx1"):getComponent("Camera").renderTexture
    self.rt0 = self.spriteC.renderTexture
    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
    self.rt0.width = w
    self.rt0.height = h
    local ew = w * self.RENDER_RATIO
    local eh = h * self.RENDER_RATIO
    self.ert0.width = ew
    self.ert0.height = eh
    self.ert1.width = ew
    self.ert1.height = eh

    local fov = math.atan(math.tan(self.DESIGN_FOV/2) * (h/w)) * 2
    self.spriteC.fovy = math.deg(fov)
    self.cameraZ = -(h/2) / math.tan(fov/2)
    self.spriteM:setVec2("u_size", Amaz.Vector2f(ew, eh))

    local s = math.min(w, h) / self.DESIGN_SIZE
    w = w / s
    h = h / s
    ew = ew / s
    eh = eh / s

    local _w = 1 / ew
    local _h = 1 / eh
    self.bx1:setFloat("u_step_x", _w)
    self.bx2:setFloat("u_step_x", _w)
    self.bx3:setFloat("u_step_x", _w)
    self.bx4:setFloat("u_step_x", _w)
    self.by1:setFloat("u_step_y", _h)
    self.by2:setFloat("u_step_y", _h)
end

function VAMain:update (env, duration, elapsed, progress)
    elapsed = progress * self.DURATION

    local p = self.ae:get("/ADBE Position_23", elapsed)
    local x = Utils.mix(-env.w * 0.5, env.w * 0.5, p[1] / self.DESIGN_SIZE)
    local y = Utils.mix(env.h * 0.5, -env.h * 0.5, p[2] / self.DESIGN_SIZE)
    local z = Utils.mix(0, self.cameraZ, Utils.step(self.DESIGN_CAMERA_Z, 0, p[3]))
    local rx = self.ae:get("/ADBE Rotate X_29", elapsed)[1]
    local ry = -self.ae:get("/ADBE Rotate Y_30", elapsed)[1]
    local s = self.ae:get("/ADBE Scale_27", elapsed)
    local sx = s[1] * 0.01
    local sy = s[2] * 0.01

    local M = self:transform(x, y, z, sx, sy, 1, rx, ry, 0)
    self.spriteM:setMat4("u_CustomModel", M)

    local exposure = self.ae:get("/ADBE Exposure2-0003", elapsed)[1]
    self.exposure:setFloat("u_Intensity", exposure)

    local bx = self.ae:get("/ADBE Gaussian Blur 2-0001_12", elapsed)[1] * self.GS_X_INTENSITY
    self.bx1:setFloat("u_radius", bx)
    self.bx2:setFloat("u_radius", bx * 0.5)
    self.bx3:setFloat("u_radius", bx * 0.25)
    self.bx4:setFloat("u_radius", bx * 0.125)
    local by = self.ae:get("/ADBE Gaussian Blur 2-0001_17", elapsed)[1] * self.GS_Y_INTENSITY
    self.by1:setFloat("u_radius", by)
    self.by2:setFloat("u_radius", by * 0.5)
end


function VAMain:transform (x, y, z, sx, sy, sz, rx, ry, rz)
    local translate = Amaz.Matrix4x4f()
    translate:setTranslate(Amaz.Vector3f(x, y, z))
    local scale = Amaz.Matrix4x4f()
    scale:setScale(Amaz.Vector3f(sx, sy, sz))
    local rotateX = Amaz.Matrix4x4f()
    rotateX:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(math.rad(rx), 0, 0)))
    local rotateY = Amaz.Matrix4x4f()
    rotateY:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(0, math.rad(ry), 0)))
    local rotateZ = Amaz.Matrix4x4f()
    rotateZ:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(0, 0, math.rad(rz))))

    local M = Amaz.Matrix4x4f()
    M = M * translate
    M = M * rotateX
    M = M * rotateY
    M = M * rotateZ
    M = M * scale
    return M
end


return VAMain