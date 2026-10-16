local Utils = require("common/Utils")
local Mat3 = require("common/Mat3")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.DESIGN_SIZE = 1080
    self.DURATION = 17/30
    self.MOTION_KEYFRAMES = 96
    self.AE = AE
    return self
end


function VAMain:create (env, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.exposure = scene:findEntityBy("exposure"):getComponent("MeshRenderer").material
    self.motion = scene:findEntityBy("motion"):getComponent("MeshRenderer").material

    self.rt0 = scene.assetMgr:SyncLoad("rt/rt0.rt")

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
    self.rt0.width = w
    self.rt0.height = h

    local s = math.min(w, h) / self.DESIGN_SIZE
    local vw = w / s
    local vh = h / s

    local screenSize = Amaz.Vector2f(vw, vh)
    self.motion:setVec2("u_screen_size", screenSize)
    self.motion:setVec2("u_sprite_size", screenSize)

    self.vw = vw
    self.vh = vh
end

function VAMain:update (env, duration, elapsed, progress)
    local elapsed0 = progress * self.DURATION
    local elapsed1 = elapsed0 + 1.66/30

    local exposure = self.ae:get("/ADBE Exposure2-0003_14", elapsed0)[1]
    self.exposure:setFloat("u_intensity", exposure)

    local matrices = {}
    for i = 0, self.MOTION_KEYFRAMES do
        local elapsed_ = Utils.mix(elapsed0, elapsed1, i / self.MOTION_KEYFRAMES)
        local x = (0 + self.ae:get("/ADBE Position_0_38", elapsed_)[1] / self.DESIGN_SIZE) * self.vw
        local y = (1 - self.ae:get("/ADBE Position_1_39", elapsed_)[1] / self.DESIGN_SIZE) * self.vh
        local r = -self.ae:get("/ADBE Rotate Z_45", elapsed_)[1]
        table.insert(matrices, AEAdapter.makeTransform2D(nil, {
            {w = self.vw, h = self.vh, ax = 0.5, ay = 0.0, x = x, y = y, r = r}
        }))
    end
    Mat3.toMaterialVector(self.motion, "u_matrices", matrices)

    local opacity = self.ae:get("/ADBE Opacity_46", elapsed0)[1] * 0.01
    self.motion:setFloat("u_opacity", opacity)
end

return VAMain