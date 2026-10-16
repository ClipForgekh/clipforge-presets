local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.DURATION = 28/30
    self.AE = AE
    return self
end


function VAMain:create (env, scene)
    Helper.initPipeline(scene, "main")

    self.motion1 = scene:findEntityBy("Motion1"):getComponent("MeshRenderer").material
    self.motion2 = scene:findEntityBy("Motion2"):getComponent("MeshRenderer").material
    self.motion3 = scene:findEntityBy("Motion3"):getComponent("MeshRenderer").material
    self.motion4 = scene:findEntityBy("Motion4"):getComponent("MeshRenderer").material
    self.sGlowComp = scene:findEntityBy("S_Glow"):getComponent("ScriptComponent")
    self.hsl = scene:findEntityBy("HSL"):getComponent("MeshRenderer").material
    self.rBlurComp = scene:findEntityBy("LuaRadialBlur"):getComponent("ScriptComponent")
    self.mBlurComp = scene:findEntityBy("LumiDirectionBlur"):getComponent("ScriptComponent")

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
end

function VAMain:update (env, duration, elapsed, progress)
    if not self.sGlow then
        self.sGlow = Helper.getLuaObject(self.sGlowComp)
    end
    if not self.rBlur then
        self.rBlur = Helper.getLuaObject(self.rBlurComp)
    end
    if not self.mBlur then
        self.mBlur = Helper.getLuaObject(self.mBlurComp)
    end

    elapsed = progress * self.DURATION + 0.0001

    if self.sGlow then
        self.sGlow.brightness = self.ae:get("/Glow", elapsed)[1]
    end
    if self.rBlur then
        self.rBlur.amount = self.ae:get("/RadialBlur", elapsed)[1]
    end
    if self.mBlur then
        self.mBlur.intensity = self.ae:get("/MotionBlur", elapsed)[1]
    end

    local s = self.ae:get("/Scale", elapsed)[1] * 0.01
    self.motion1:setFloat("u_scale", (self.ae:get("/Scale_1", elapsed + 20/30)[1] * 0.01) * s)
    self.motion2:setFloat("u_scale", (self.ae:get("/Scale_2", elapsed + 20/30)[1] * 0.01) * s)
    self.motion3:setFloat("u_scale", (self.ae:get("/Scale_3", elapsed + 20/30)[1] * 0.01) * s)
    self.motion4:setFloat("u_scale", (self.ae:get("/Scale_4", elapsed + 20/30)[1] * 0.01) * s)

    local g = self.ae:get("/Grey", elapsed)[1] * 0.01
    self.motion1:setFloat("u_grey", g)
    self.motion2:setFloat("u_grey", g)
    self.motion3:setFloat("u_grey", g)
    self.motion4:setFloat("u_grey", g)

    self.motion1:setFloat("u_exposure", self.ae:get("/Exposure_1", elapsed)[1])
    self.motion2:setFloat("u_exposure", self.ae:get("/Exposure_2", elapsed)[1])
    self.motion3:setFloat("u_exposure", self.ae:get("/Exposure_3", elapsed)[1])
    self.motion4:setFloat("u_exposure", self.ae:get("/Exposure_4", elapsed)[1])

    self.motion1:setFloat("u_opacity", Utils.step(02/30, 03/30, elapsed))
    self.motion2:setFloat("u_opacity", Utils.step(13/30, 14/30, elapsed))
    self.motion3:setFloat("u_opacity", Utils.step(05/30, 06/30, elapsed))
    self.motion4:setFloat("u_opacity", Utils.step(10/30, 11/30, elapsed))

    self.hsl:setFloat("u_sat", self.ae:get("/HSL", elapsed)[1] * 0.01 * -1)
end

return VAMain