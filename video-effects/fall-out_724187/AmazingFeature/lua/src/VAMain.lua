local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")

local DESIGN_SIZE = 1080
local RENDER_RATIO = 1.5
local DURATION = 31 / 30

local function tr (x)
    return ((RENDER_RATIO - 1) * 0.5 + x) / RENDER_RATIO
end

local VAMain = {}
VAMain.__index = VAMain
function VAMain.new ()
    return setmetatable({}, VAMain)
end


function VAMain:create (env, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.distortion = scene:findEntityBy("distortion"):getComponent("MeshRenderer").material

    self.motion1 = scene:findEntityBy("motion1"):getComponent("MeshRenderer").material
    self.motion2 = scene:findEntityBy("motion2"):getComponent("MeshRenderer").material

    self.radialBlur = scene:findEntityBy("radialBlur"):getComponent("MeshRenderer").material
    self.crop = scene:findEntityBy("crop"):getComponent("MeshRenderer").material
    self.crop:setFloat("u_ratio", RENDER_RATIO)

    self.ccLens = scene:findEntityBy("ccLens"):getComponent("MeshRenderer").material
    self.exposure = scene:findEntityBy("exposure"):getComponent("MeshRenderer").material

    self.rt0 = scene:findEntityBy("camera_radialBlur"):getComponent("Camera").renderTexture
    self.rt1 = scene:findEntityBy("camera_motion1"):getComponent("Camera").renderTexture
    self.rt2 = scene:findEntityBy("camera_motion2"):getComponent("Camera").renderTexture
    self.rt3 = scene:findEntityBy("camera_crop"):getComponent("Camera").renderTexture
    self.rt4 = scene:findEntityBy("camera_ccLens"):getComponent("Camera").renderTexture

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("motion1", AE.motion1)
    self.ae:addKeyframes("motion2", AE.motion2)
    self.ae:addKeyframes("effect", AE.effect)
end

function VAMain:layout (env, w, h)
    local ew = w * RENDER_RATIO
    local eh = h * RENDER_RATIO
    self.rt0.width = ew
    self.rt0.height = eh
    self.rt1.width = ew
    self.rt1.height = eh
    self.rt2.width = ew
    self.rt2.height = eh
    self.rt3.width = w
    self.rt3.height = h
    self.rt4.width = w
    self.rt4.height = h

    local s = math.min(w, h) / DESIGN_SIZE
    w = w / s
    h = h / s
    ew = ew / s
    eh = eh / s

    local screenSize = Amaz.Vector2f(w, h)
    local extendedScreenSize = Amaz.Vector2f(ew, eh)
    self.motion1:setVec2("u_screen_size", extendedScreenSize)
    self.motion1:setVec2("u_size", screenSize)
    self.motion2:setVec2("u_screen_size", extendedScreenSize)
    self.motion2:setVec2("u_size", screenSize)
end

function VAMain:update (env, duration, elapsed, progress)
    elapsed = progress * DURATION

    self.motion1:setVec2("u_position", Amaz.Vector2f(0.5, 0.5))
    self.motion1:setFloat("u_scale", 1.2)
    local angle1 = -self.ae:get("motion1/ADBE Rotate Z_11", elapsed)[1]
    self.motion1:setFloat("u_angle", angle1)
    local alpha1 = self.ae:get("motion1/ADBE Opacity_12", elapsed)[1] * 0.01
    self.motion1:setFloat("u_opacity", alpha1)

    local p2 = self.ae:get("motion2/ADBE Position_20", elapsed)
    local x2 = tr(p2[1] / DESIGN_SIZE)
    local y2 = tr(1 - p2[2] / DESIGN_SIZE)
    self.motion2:setVec2("u_position", Amaz.Vector2f(x2, y2))
    local scale2 = self.ae:get("motion2/ADBE Scale_24", elapsed)[1] * 0.01
    self.motion2:setFloat("u_scale", scale2)
    local angle2 = -self.ae:get("motion2/ADBE Rotate Z_28", elapsed)[1]
    self.motion2:setFloat("u_angle", angle2)

    local d = self.ae:get("motion2/ADBE WRPMESH-0003_14", elapsed)[1]
    self.distortion:setFloat("u_fov", env.c_range * 180)
    self.distortion:setFloat("u_strength", env.c_distortion * 1)
    self.distortion:setFloat("intensity", env.c_intensity * d)
    self.distortion:setVec2("u_center", Amaz.Vector2f(x2, y2))

    local blurAmount = self.ae:get("effect/ADBE Radial Blur-0001_3", elapsed)[1] * 0.001 / RENDER_RATIO * 3
    local maxEdge = math.max(env.w, env.h)
    local maxSamplePixels = maxEdge * blurAmount
    local sampleCount = math.ceil(maxSamplePixels / 2)
    self.radialBlur:enableMacro("SAMPLES", sampleCount)
    self.radialBlur:setFloat("u_amount", blurAmount)
    local blurCenter = self.ae:get("effect/ADBE Radial Blur-0002_4", elapsed)
    local blurCenterX = tr(blurCenter[1] / DESIGN_SIZE)
    local blurCenterY = tr(1 - blurCenter[2] / DESIGN_SIZE)
    self.radialBlur:setVec2("u_center", Amaz.Vector2f(blurCenterX, blurCenterY))

    local ccLensSize = self.ae:get("effect/CC Lens-0002_11", elapsed)[1]
    local ccLensConvergence = self.ae:get("effect/CC Lens-0003_12", elapsed)[1]
    self.ccLens:setFloat("u_Radius", ccLensSize)
    self.ccLens:setFloat("u_Convergence", ccLensConvergence)

    local exposureIntensity = self.ae:get("effect/ADBE Exposure2-0003_17", elapsed)[1]
    self.exposure:setFloat("u_Intensity", exposureIntensity)
end


return VAMain