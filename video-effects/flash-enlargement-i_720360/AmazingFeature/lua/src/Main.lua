local Utils = require("Utils")

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


return Main