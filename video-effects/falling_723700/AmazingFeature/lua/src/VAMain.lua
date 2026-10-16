local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")

local DESIGN_SIZE = 1080
local RENDER_RATIO = 1.5
local DURATION = 90 / 30

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

    node.displaceB = scene:findEntityBy("displaceB"):getComponent("MeshRenderer").material
    node.displaceB:setVec4("u_intensityX", Amaz.Vector4f(7.0 / DESIGN_SIZE / RENDER_RATIO, 0, 0, 0))
    node.displaceB:setVec4("u_intensityY", Amaz.Vector4f(0, -6.6 / DESIGN_SIZE / RENDER_RATIO, 0, 0))
    node.displaceBa0 = scene:findEntityBy("displaceB"):getComponents("AnimSeqComponent"):get(0)
    node.displaceBa1 = scene:findEntityBy("displaceB"):getComponents("AnimSeqComponent"):get(1)
    node.displaceA = scene:findEntityBy("displaceA"):getComponent("MeshRenderer").material

    node.by1 = scene:findEntityBy("by1"):getComponent("MeshRenderer").material
    node.by2 = scene:findEntityBy("by2"):getComponent("MeshRenderer").material
    node.by3 = scene:findEntityBy("by3"):getComponent("MeshRenderer").material
    node.by4 = scene:findEntityBy("by4"):getComponent("MeshRenderer").material
    node.by5 = scene:findEntityBy("by5"):getComponent("MeshRenderer").material
    node.by6 = scene:findEntityBy("by6"):getComponent("MeshRenderer").material
    node.bx1 = scene:findEntityBy("bx1"):getComponent("MeshRenderer").material

    node.exposure = scene:findEntityBy("exposure"):getComponent("MeshRenderer").material
    node.crop = scene:findEntityBy("crop"):getComponent("MeshRenderer").material
    node.crop:setFloat("u_ratio", RENDER_RATIO)

    node.rt0 = scene:findEntityBy("camera_by1"):getComponent("Camera").renderTexture
    node.rt1 = scene:findEntityBy("camera_by2"):getComponent("Camera").renderTexture

    data.ae = AEAdapter:new()
    data.ae:addKeyframes("motion", AE.motion)
    data.ae:addKeyframes("effect", AE.effect)
    data.ae:addKeyframes("displace", AE.displace)
end

function VAMain:layout (node, data, w, h)
    local ew = w * RENDER_RATIO
    local eh = h * RENDER_RATIO
    node.rt0.width = ew
    node.rt0.height = eh
    node.rt1.width = ew
    node.rt1.height = eh

    local s = math.min(w, h) / DESIGN_SIZE
    w = w / s
    h = h / s
    ew = ew / s
    eh = eh / s

    local extendedScreenSize = Amaz.Vector2f(ew, eh)
    node.motion:setVec2("u_screen_size", extendedScreenSize)
    node.motion:setVec2("u_size", Amaz.Vector2f(w, h))
    local mapWb = math.max(w, h * 1)
    local mapHb = math.max(w / 1, h)
    node.displaceB:setVec2("u_screen_size", extendedScreenSize)
    node.displaceB:setVec2("u_size", Amaz.Vector2f(mapWb, mapHb))
    node.displaceB:setVec2("u_position", Amaz.Vector2f(0.5, 0.5))
    node.displaceB:setFloat("u_scale", 1)
    node.displaceB:setFloat("u_angle", 0)
    local mapWa = math.max(w, h * 0.666667) * 1.1
    local mapHa = math.max(w / 0.666667, h) * 1.1
    node.displaceA:setVec2("u_screen_size", extendedScreenSize)
    node.displaceA:setVec2("u_size", Amaz.Vector2f(mapWa, mapHa))
    node.displaceA:setVec2("u_position", Amaz.Vector2f(0.5, 0.5))
    node.displaceA:setFloat("u_scale", 1)
    node.displaceA:setFloat("u_angle", 0)

    node.by1:setFloat("u_step_y", 1 / eh)
    node.by2:setFloat("u_step_y", 1 / eh)
    node.by3:setFloat("u_step_y", 1 / eh)
    node.by4:setFloat("u_step_y", 1 / eh)
    node.by5:setFloat("u_step_y", 1 / eh)
    node.by6:setFloat("u_step_y", 1 / eh)
    node.bx1:setFloat("u_step_x", 1 / ew)
end

function VAMain:update (node, data, w, h, duration, elapsed, progress)
    elapsed = progress * DURATION

    local p = data.ae:get("motion/ADBE Position", elapsed)
    local x = p[1] / DESIGN_SIZE
    local y = 1 - p[2] / DESIGN_SIZE
    node.motion:setVec2("u_position", Amaz.Vector2f(tr(x), tr(y)))
    local scale = data.ae:get("motion/ADBE Scale", elapsed)[1] * 0.01
    node.motion:setFloat("u_scale", scale)
    local angle = -data.ae:get("motion/ADBE Rotate Z", elapsed)[1]
    node.motion:setFloat("u_angle", angle)

    local displaceX = data.ae:get("displace/ADBE Displacement Map-0003", elapsed)[1] / DESIGN_SIZE / RENDER_RATIO
    local displaceY = data.ae:get("displace/ADBE Displacement Map-0005", elapsed)[1] / DESIGN_SIZE / RENDER_RATIO
    node.displaceA:setVec4("u_intensityX", Amaz.Vector4f(displaceX, 0, 0, 0))
    node.displaceA:setVec4("u_intensityY", Amaz.Vector4f(0, -displaceY, 0, 0))

    p = data.ae:get("displace/ADBE Position", elapsed)
    x = p[1] / DESIGN_SIZE
    y = 1 - p[2] / DESIGN_SIZE
    node.displaceA:setVec2("u_position", Amaz.Vector2f(tr(x), tr(y)))
    scale = data.ae:get("displace/ADBE Scale", elapsed)[1] * 0.01
    node.displaceA:setFloat("u_scale", scale)
    angle = -data.ae:get("displace/ADBE Rotate Z", elapsed)[1]
    node.displaceA:setFloat("u_angle", angle)

    local f = elapsed * 30 % 35
    local f0 = math.floor(f)
    local f1 = math.ceil(f) % 35
    local ft = f - f0
    node.displaceBa0:seek(f0)
    node.displaceBa1:seek(f1)
    node.displaceB:setFloat("u_progress", 0)

    local br = data.ae:get("effect/ADBE Gaussian Blur 2-0001", elapsed)[1] * 0.4818
    node.by1:setFloat("u_radius", br)
    node.by2:setFloat("u_radius", br * 0.5)
    node.by3:setFloat("u_radius", br * 0.25)
    node.by4:setFloat("u_radius", br * 0.125)
    node.by5:setFloat("u_radius", br * 0.0625)
    node.by6:setFloat("u_radius", br * 0.03125)
    node.bx1:setFloat("u_radius", br / 333)

    local exposure = data.ae:get("effect/ADBE Exposure2-0003", elapsed)[1]
    node.exposure:setFloat("u_Intensity", exposure)
end


return VAMain