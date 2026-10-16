local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")

local DESIGN_SIZE = 1080
local RENDER_RATIO = 2.0
local DURATION = 23 / 30

local function tr (x)
    return ((RENDER_RATIO - 1) * 0.5 + x) / RENDER_RATIO
end

local VAMain = {}
VAMain.__index = VAMain
function VAMain.new ()
    return setmetatable({}, VAMain)
end


function VAMain:create (node, data, w, h, scene)
    Helper.initPipeline(scene, "@Pipeline")

    node.motion = scene:findEntityBy("motion"):getComponent("MeshRenderer").material
    node.motion:setFloat("u_ratio", RENDER_RATIO)

    node.bx1 = scene:findEntityBy("bx1"):getComponent("MeshRenderer").material
    node.bx2 = scene:findEntityBy("bx2"):getComponent("MeshRenderer").material
    node.bx3 = scene:findEntityBy("bx3"):getComponent("MeshRenderer").material
    node.bx4 = scene:findEntityBy("bx4"):getComponent("MeshRenderer").material
    node.by1 = scene:findEntityBy("by1"):getComponent("MeshRenderer").material

    node.wave = scene:findEntityBy("wave"):getComponent("MeshRenderer").material
    node.expo = scene:findEntityBy("expo"):getComponent("MeshRenderer").material
    node.crop = scene:findEntityBy("crop"):getComponent("MeshRenderer").material
    node.crop:setFloat("u_ratio", RENDER_RATIO)

    node.rt0 = scene:findEntityBy("camera_bx1"):getComponent("Camera").renderTexture
    node.rt1 = scene:findEntityBy("camera_bx2"):getComponent("Camera").renderTexture

    data.ae = AEAdapter:new()
    data.ae:addKeyframes("", AE)
end

function VAMain:layout (node, data, w, h)
    local ew = w * RENDER_RATIO
    local eh = h * RENDER_RATIO
    node.rt0.width = ew
    node.rt0.height = eh
    node.rt1.width = ew
    node.rt1.height = eh

    local s = math.min(w, h) / 720
    w = w / s
    h = h / s
    ew = ew / s
    eh = eh / s
    data.s = math.min(w, h)
    data.w = w
    data.h = h

    node.bx1:setFloat("u_step_x", 1 / ew)
    node.bx2:setFloat("u_step_x", 1 / ew)
    node.bx3:setFloat("u_step_x", 1 / ew)
    node.bx4:setFloat("u_step_x", 1 / ew)
    node.by1:setFloat("u_step_y", 1 / eh)

    node.motion:setVec2("u_screen_size", Amaz.Vector2f(ew, eh))
    node.wave:setVec2("u_screen_size", Amaz.Vector2f(ew, eh))
end

function VAMain:update (node, data, w, h, duration, elapsed, progress)
    elapsed = progress * DURATION

    local p = data.ae:get("/ADBE Position", elapsed)
    local x = p[1] / DESIGN_SIZE
    local y = 1 - p[2] / DESIGN_SIZE
    node.motion:setVec2("u_position", Amaz.Vector2f(tr(x), tr(y)))

    local s = data.ae:get("/ADBE Scale", elapsed)[1] * 0.01
    node.motion:setFloat("u_scale", s)

    local b = data.ae:get("/ADBE Gaussian Blur 2-0001", elapsed)[1] / DESIGN_SIZE
    node.by1:setFloat("u_radius", b * 3 * 0.4)
    b = b * data.s * 0.4
    node.bx1:setFloat("u_radius", b)
    node.bx2:setFloat("u_radius", b * 0.5)
    node.bx3:setFloat("u_radius", b * 0.25)
    node.bx4:setFloat("u_radius", b * 0.125)

    local a = data.ae:get("/ADBE Wave Warp-0002", elapsed)[1] / DESIGN_SIZE * data.w
    node.wave:setFloat("u_amplitude", a)
    local l = data.ae:get("/ADBE Wave Warp-0003", elapsed)[1] / DESIGN_SIZE * data.s * 2.1
    node.wave:setFloat("u_wavelength", l)

    local e = data.ae:get("/ADBE Exposure2-0003", elapsed)[1]
    node.expo:setFloat("u_exposure", e)
end


return VAMain