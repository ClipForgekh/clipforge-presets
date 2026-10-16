local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new ()
    local self = setmetatable({}, VAMain)
    self.DESIGN_SIZE = 1080
    self.RENDER_RATIO = 1.5
    self.DURATION = 45/30
    return self
end

function VAMain:tr (x)
    return ((self.RENDER_RATIO - 1) * 0.5 + x) / self.RENDER_RATIO
end

function VAMain:create (env, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.distortion = scene:findEntityBy("distortion"):getComponent("MeshRenderer").material

    self.motion = scene:findEntityBy("motion"):getComponent("MeshRenderer").material
    self.motion:setFloat("u_ratio", self.RENDER_RATIO)

    self.radialBlur = scene:findEntityBy("radialBlur"):getComponent("MeshRenderer").material
    self.crop = scene:findEntityBy("crop"):getComponent("MeshRenderer").material
    self.crop:setFloat("u_ratio", self.RENDER_RATIO)

    self.distort = scene:findEntityBy("distort"):getComponent("MeshRenderer").material
    self.exposure = scene:findEntityBy("exposure"):getComponent("MeshRenderer").material

    self.rt0 = scene:findEntityBy("camera_motion"):getComponent("Camera").renderTexture
    self.rt1 = scene:findEntityBy("camera_radialBlur"):getComponent("Camera").renderTexture
    self.rt2 = scene:findEntityBy("camera_crop"):getComponent("Camera").renderTexture
    self.rt3 = scene:findEntityBy("camera_distort"):getComponent("Camera").renderTexture

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("motion", AE.motion)
    self.ae:addKeyframes("effect", AE.effect)
end

function VAMain:layout (env, w, h)
    local ew = w * self.RENDER_RATIO
    local eh = h * self.RENDER_RATIO
    self.rt0.width = ew
    self.rt0.height = eh
    self.rt1.width = ew
    self.rt1.height = eh
    self.rt2.width = w
    self.rt2.height = h
    self.rt3.width = w
    self.rt3.height = h

    local s = math.min(w, h) / self.DESIGN_SIZE
    w = w / s
    h = h / s
    ew = ew / s
    eh = eh / s

    local screenSize = Amaz.Vector2f(w, h)
    local extendedScreenSize = Amaz.Vector2f(ew, eh)
    self.motion:setVec2("u_screen_size", extendedScreenSize)
    self.motion:setVec2("u_size", screenSize)

    self.distort:setFloat("u_aspect", w / h)
end

function VAMain:update (env, duration, elapsed, progress)
    elapsed = progress * self.DURATION

    local d = self.ae:get("motion/ADBE WRPMESH-0003", elapsed)[1] * 0.01 * -0.35
    self.distortion:setFloat("u_intensity", d)

    local p = self.ae:get("motion/ADBE Position", elapsed)
    local x = self:tr(p[1] / self.DESIGN_SIZE)
    local y = self:tr(1 - p[2] / self.DESIGN_SIZE)
    self.motion:setVec2("u_position", Amaz.Vector2f(x, y))
    local scale = self.ae:get("motion/ADBE Scale", elapsed)[1] * 0.01
    self.motion:setFloat("u_scale", scale)
    local angle = -self.ae:get("motion/ADBE Rotate Z", elapsed)[1]
    self.motion:setFloat("u_angle", angle)

    local blurAmount = self.ae:get("effect/ADBE Radial Blur-0001", elapsed)[1] * 0.001 / self.RENDER_RATIO * 3
    local maxEdge = math.max(env.w, env.h)
    local maxSamplePixels = maxEdge * blurAmount
    local sampleCount = math.ceil(maxSamplePixels / 2)
    self.radialBlur:enableMacro("SAMPLES", sampleCount)
    self.radialBlur:setFloat("u_amount", blurAmount)
    local blurCenter = self.ae:get("effect/ADBE Radial Blur-0002", elapsed)
    local blurCenterX = self:tr(blurCenter[1] / self.DESIGN_SIZE)
    local blurCenterY = self:tr(1 - blurCenter[2] / self.DESIGN_SIZE)
    self.radialBlur:setVec2("u_center", Amaz.Vector2f(blurCenterX, blurCenterY))

    local lensR = self.ae:get("effect/CC Lens-0002_11", elapsed)[1]
    lensR = Utils.mix(1.3, 1.3, Utils.step(188, 300, lensR))
    self.distort:setFloat("u_radius", math.max(env.w, env.h) / env.h * lensR)
    local lensI = self.ae:get("effect/CC Lens-0003_12", elapsed)[1]
    lensI = Utils.mix(0, -0.26, Utils.step(0, 100, lensI))
    self.distort:setVec3("u_Ki", Amaz.Vector3f(lensI, 0, 0))

    local exposureIntensity = self.ae:get("effect/ADBE Exposure2-0003", elapsed)[1]
    self.exposure:setFloat("u_Intensity", exposureIntensity)
end


return VAMain