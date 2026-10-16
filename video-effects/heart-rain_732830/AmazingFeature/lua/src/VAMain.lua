local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.DURATION = 69/30
    self.AE = AE
    return self
end


function VAMain:create (env, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.blend0 = scene:findEntityBy("blend0"):getComponent("MeshRenderer").material
    self.mask0 = scene:findEntityBy("blend0"):getComponent("VideoAnimSeq")
    self.blend1 = scene:findEntityBy("blend1"):getComponent("MeshRenderer").material
    self.mask1 = scene:findEntityBy("blend1"):getComponent("VideoAnimSeq")
    self.filter = scene:findEntityBy("filter"):getComponent("MeshRenderer").material

    if not Editor then
        self.mask0.enableFixedSeekMode = true
        self.mask1.enableFixedSeekMode = true
    end

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
    local q = math.max(w, h)
    local s = 1080 / q
    w = w * s
    h = h * s
    q = q * s
    local screenSize = Amaz.Vector2f(w, h)
    local maskSize = Amaz.Vector2f(q, q)

    self.blend0:setVec2("u_screenSize", screenSize)
    self.blend0:setVec2("u_maskSize", maskSize)

    self.blend1:setVec2("u_screenSize", screenSize)
    self.blend1:setVec2("u_maskSize", maskSize)
    self.blend1:setVec2("u_origin", Amaz.Vector2f(0.0, 0.0))
    self.blend1:setVec2("u_cell", Amaz.Vector2f(q / 44 / w, q / 44 / h))
end

function VAMain:update (env, duration, elapsed, progress)
    elapsed = progress * self.DURATION

    self.blend1:setFloat("u_opacity", self.ae:get("/Opacity", elapsed)[1] * 0.01)
    self.blend1:setFloat("u_maskEnabled", elapsed < 68/30 and 1 or 0)

    if not Editor then
        local f = math.floor(Utils.mix(1.001, 70.001, progress))
        self.mask0:seek(Utils.clamp(f, 0, 24))
        self.mask1:seek(Utils.clamp(f, 0, 69))
    end

    self.filter:setFloat("u_intensity", self.ae:get("/Filter", elapsed)[1] * 0.01)
end


return VAMain