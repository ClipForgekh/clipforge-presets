local Utils = require("Utils")

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


return Main