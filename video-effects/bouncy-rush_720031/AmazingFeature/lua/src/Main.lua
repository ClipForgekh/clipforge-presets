local Utils = require("Utils")
local AEAdapter = require("AEAdapter")
local AE = require("AE")

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

return Main