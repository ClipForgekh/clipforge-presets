local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.CONTRAST_INTENSITY = 0.5
    self.DURATION = 60/30
    self.AE = AE
    self.CONFIG = {
        {t = 33/30, ax = 0, ay = 0, bs = 1.5, x = 544.4, y = 1080-580.3, s = 0.634, r = 105.6},
        {t = 36/30, ax = 1, ay = 1, bs = 2.0, x = 525.2, y = 1080-536.1, s = 0.610, r = 271.7, rr = -156},
        {t = 39/30, ax = 1, ay = 0, bs = 1.5, x = 528.7, y = 1080-549.7, s = 0.658, r = 222.7},
        {t = 39/30, ax = 0, ay = 1, bs = 2.0, x = 488.7, y = 1080-575.2, s = 0.746, r = 42.7, rr = 45},
        {t = 47/30, ax = 0, ay = 0, bs = 1.5, x = 502.4, y = 1080-549.9, s = 0.77, r = 90.6},
        {t = 49/30, ax = 1, ay = 1, bs = 2.0, x = 576.9, y = 1080-502.0, s = 0.702, r = 265.4},
        {t = 50/30, ax = 1, ay = 0, bs = 1.5, x = 511.4, y = 1080-580.6, s = 0.70, r = 349.1},
        {t = 50/30, ax = 0, ay = 1, bs = 2.0, x = 503.9, y = 1080-578.7, s = 0.701, r = 158.4},
    }
    return self
end


function VAMain:create (env, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.hsl0 = scene:findEntityBy("hsl0"):getComponent("MeshRenderer").material
    self.pass0Comp = scene:findEntityBy("PassivationMask_0"):getComponent("ScriptComponent")
    self.contrast0Comp = scene:findEntityBy("lumi_contrast_0"):getComponent("ScriptComponent")
    self.glow0Comp = scene:findEntityBy("Deep_Glow_Root_0"):getComponent("ScriptComponent")
    self.motionB = scene:findEntityBy("motionB"):getComponent("MeshRenderer").material
    self.pass1Comp = scene:findEntityBy("PassivationMask_1"):getComponent("ScriptComponent")
    self.contrast1Comp = scene:findEntityBy("lumi_contrast_1"):getComponent("ScriptComponent")
    self.blend8 = scene:findEntityBy("blend8"):getComponent("MeshRenderer").material
    self.blend7 = scene:findEntityBy("blend7"):getComponent("MeshRenderer").material
    self.blend6 = scene:findEntityBy("blend6"):getComponent("MeshRenderer").material
    self.blend5 = scene:findEntityBy("blend5"):getComponent("MeshRenderer").material
    self.blend4 = scene:findEntityBy("blend4"):getComponent("MeshRenderer").material
    self.blend3 = scene:findEntityBy("blend3"):getComponent("MeshRenderer").material
    self.blend2 = scene:findEntityBy("blend2"):getComponent("MeshRenderer").material
    self.blend1 = scene:findEntityBy("blend1"):getComponent("MeshRenderer").material
    self.blend0 = scene:findEntityBy("blend0"):getComponent("MeshRenderer").material
    self.shine = scene:findEntityBy("shine"):getComponent("MeshRenderer").material
    self.video = scene:findEntityBy("shine"):getComponent("VideoAnimSeq")
    if not Editor then
        self.video.enableFixedSeekMode = true
    end

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
    local q = math.max(w, h)
    local s = 1080 / q
    local k = q / math.min(w, h)
    w = w * s
    h = h * s
    local screenSize = Amaz.Vector2f(w, h)

    self.shine:setFloat("u_dstAspect", w / h)

    self.w = w
    self.h = h
    self.k = k
    self.screenSize = screenSize

end

function VAMain:update (env, duration, elapsed, progress)
    if not self.pass0 then
        self.pass0 = Helper.getLuaObject(self.pass0Comp)
    end
    if not self.pass1 then
        self.pass1 = Helper.getLuaObject(self.pass1Comp)
    end
    if not self.glow0 then
        self.glow0 = Helper.getLuaObject(self.glow0Comp)
    end
    if not self.contrast0 then
        self.contrast0 = Helper.getLuaObject(self.contrast0Comp)
    end
    if not self.contrast1 then
        self.contrast1 = Helper.getLuaObject(self.contrast1Comp)
    end

    progress = Utils.step(48/49, 0, progress)
    elapsed = progress * self.DURATION

    local saturation0 = self.ae:get("/Saturation_0", elapsed)[1] * 0.01
    self.hsl0:setFloat("u_saturation", saturation0)

    if self.pass0 then
        self.pass0.Sharpen = self.ae:get("/Passivation_0_Sharpen", elapsed)[1] * 0.02
        if self.contrast0 then
            self.contrast0.intensity = self.pass0.Sharpen * self.CONTRAST_INTENSITY
        end
    end

    if self.pass1 then
        if self.contrast1 then
            self.contrast1.intensity = self.pass1.Sharpen * self.CONTRAST_INTENSITY
        end
    end
    if self.glow0 then
        local intensity = Utils.clamp(self.ae:get("/DeepGlow_0_Exposure", elapsed)[1], 0, 1.7)
        self.glow0.Intensity = Utils.sineIn(intensity / 1.7) * 1.7
    end

    local w, h, k = self.w, self.h, self.k
    local ox, oy = w * 0.5, h * 0.5
    local rs = self.ae:get("/Scale_Root", elapsed)[1] * 0.01

    self.motionB:setMat4("u_matrix", Utils.uvTransform(self.screenSize, {
        {w = w, h = h, ax = 0.5, ay = 0.5, x = ox, y = oy,
         s = self.ae:get("/Scale_Bg", elapsed)[1] * 0.01}
    }))
    self.motionB:setFloat("u_opacity", elapsed < 27/30 and 0 or 1)

    local TR0 = {
        {w = 1080, h = 1080, ax = 0.5, ay = 0.5, x = ox, y = oy,
         s = self.ae:get("/Scale_0", elapsed)[1] * 0.01,
         r = -self.ae:get("/Rotate_0", elapsed)[1]},
        {w = w, h = h, ax = 0.5, ay = 0, x = 540, y = 0.111111 * 1080, s = 1.5 * k}
    }
    self.blend0:setMat4("u_baseMat", Utils.uvTransform(self.screenSize, TR0))
    TR0[2] = {w = 1000, h = 1000, ax = 0.5, ay = 0.5, x = 540, y = 540, s = 1.086}
    self.blend0:setMat4("u_baseMaskMat", Utils.uvTransform(self.screenSize, TR0))
    TR0[2] = {w = 408, h = 408, ax = 0.5, ay = 0.5, x = 540, y = 540}
    self.blend0:setMat4("u_haloMat", Utils.uvTransform(self.screenSize, TR0))
    local a0 = (elapsed < 28/30 and 1 or 0) * self.ae:get("/Opacity_0", elapsed)[1] * 0.01
    self.blend0:setFloat("u_opacity", a0)

    TR0[2] = {w = 480, h = 480, ax = 0.5, ay = 0.5, x = 540, y = 540}
    local TRm = Utils.uvTransform(self.screenSize, TR0)

    self:updateLayer(8, k, rs, TRm, elapsed)
    self:updateLayer(7, k, rs, TRm, elapsed)
    self:updateLayer(6, k, rs, TRm, elapsed)
    self:updateLayer(5, k, rs, TRm, elapsed)
    self:updateLayer(4, k, rs, TRm, elapsed)
    self:updateLayer(3, k, rs, TRm, elapsed)
    self:updateLayer(2, k, rs, TRm, elapsed)
    self:updateLayer(1, k, rs, TRm, elapsed)

    if not Editor then
        self.video:seekToTime(math.max(elapsed - 28/30, 0))
    end
    self.shine:setFloat("u_opacity", elapsed < 28/30 and 0 or 1)
end

function VAMain:updateLayer (i, k, rs, TRm, elapsed)
    local mat = self["blend"..i]
    local cfg = self.CONFIG[i]

    local w, h = self.w, self.h
    local ox, oy = w * 0.5, h * 0.5

    local p = self.ae:get("/Position_"..i, elapsed)
    local s = self.ae:get("/Scale_"..i, elapsed)
    local r = self.ae:get("/Rotate_"..i, elapsed)
    local TR = {
        {x = ox, y = oy, s = rs},
        {w = 1080, h = 1080, ax = 0.5, ay = 0.5,
         x = p and p[1] or 0,
         y = p and -p[2] or 0,
         s = s and s[1] * 0.01 or 1,
         r = r and -r[1] or -cfg.rr},
    }
    TR[3] = {w = w, h = h, ax = cfg.ax, ay = cfg.ay, x = cfg.ax * 1080, y = cfg.ay * 1080, s = k * cfg.bs}
    mat:setMat4("u_baseMat", Utils.uvTransform(self.screenSize, TR))
    TR[3] = {w = 1086, h = 1086, ax = 0.5, ay = 0.5, x = 540, y = 540}
    mat:setMat4("u_baseMaskMat", Utils.uvTransform(self.screenSize, TR))
    TR[3] = {w = 408, h = 408, ax = 0.5, ay = 0.5, x = 540, y = 540}
    mat:setMat4("u_haloMat", Utils.uvTransform(self.screenSize, TR))
    TR[3] = {w = 1472, h = 1472, ax = 0.5, ay = 0.5, x = cfg.x, y = cfg.y, s = cfg.s, r = cfg.r}
    mat:setMat4("u_shadowMat", Utils.uvTransform(self.screenSize, TR))

    mat:setMat4("u_maskMat", TRm)

    local a = self.ae:get("/Opacity_"..i, elapsed)
    a = a and a[1] * 0.01 or 1
    a = a * (elapsed < cfg.t and 1 or 0)
    mat:setFloat("u_opacity", a)

    local e = self.ae:get("/Exposure_"..i, elapsed)
    e = e and e or 0
    mat:setFloat("u_exposure", e)
end

return VAMain