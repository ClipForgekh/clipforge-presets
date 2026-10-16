local Utils = require("common/Utils")
local AEAdapter = require("common/AEAdapter")
local Helper = require("cc/Helper")
local AE = require("AE")




local CCMain = {}
CCMain.__index = CCMain
function CCMain.new (env)
    local self = setmetatable({}, CCMain)
    self.AE = AE
    self.VIDEO_ASPECT = 9/16
    self.TRACK_DURATION = 72 / 23.976
    return self
end

function CCMain:create (env, data, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.blend = scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.src1a = scene:findEntityBy("blend"):getComponent("VideoAnimSeq")
    self.filter = scene:findEntityBy("filter"):getComponent("MeshRenderer").material
    self.rt0 = scene:findEntityBy("camera_filter"):getComponent("Camera").renderTexture

    self.blur1Material = scene:findEntityBy("blur1"):getComponent("MeshRenderer").material
    self.blur2Material = scene:findEntityBy("blur2"):getComponent("MeshRenderer").material
    self.blur3Material = scene:findEntityBy("blur3"):getComponent("MeshRenderer").material
    self.XMaterial = scene:findEntityBy("X"):getComponent("MeshRenderer").material
    self.YMaterial = scene:findEntityBy("Y"):getComponent("MeshRenderer").material

    self.src1a.enableFixedSeekMode = true

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)

    data.intensity = 0.5
end

function CCMain:layout (env, data, w, h)
    self.rt0.width = w
    self.rt0.height = h

    local s = math.min(w, h) / 1080
    w = w / s
    h = h / s

    local a = w / h
    local w1, h1, r1
    if a < (9/16 + 3/4) * 0.5 then
        w1 = math.max(w, h * self.VIDEO_ASPECT)
        h1 = math.max(w / self.VIDEO_ASPECT, h)
        r1 = 0
    elseif a < (3/4 + 1/1) * 0.5 then
        w1 = math.max(w, h * self.VIDEO_ASPECT)
        h1 = math.max(w / self.VIDEO_ASPECT, h)
        r1 = 0
    elseif a < (1/1 + 4/3) * 0.5 then
        w1 = math.max(w, h * self.VIDEO_ASPECT)
        h1 = math.max(w / self.VIDEO_ASPECT, h)
        r1 = 0
    elseif a < (4/3 + 16/9) * 0.5 then
        w1 = math.max(h, w * self.VIDEO_ASPECT)
        h1 = math.max(h / self.VIDEO_ASPECT, w)
        r1 = 90
    else
        w1 = math.max(h, w * self.VIDEO_ASPECT)
        h1 = math.max(h / self.VIDEO_ASPECT, w)
        r1 = 90
    end

    local screenSize = Amaz.Vector2f(w, h)
    self.blend:setVec2("u_screen_size", screenSize)
    self.blend:setVec2("u_size1", Amaz.Vector2f(w1, h1))
    self.blend:setFloat("u_angle1", r1)

    self.blur1Material:setVec2("u_ScreenSize", screenSize)
    self.blur2Material:setVec2("u_ScreenSize", screenSize)
    self.blur3Material:setVec2("u_ScreenSize", screenSize)
    self.XMaterial:setVec2("u_ScreenSize", screenSize)
    self.YMaterial:setVec2("u_ScreenSize", screenSize)
end

function CCMain:update (env, data, realElapsed, elapsed, duration, progress)
    local data_scale = data.intensity * 0.8 * 1.8
    local data_intensity = data.intensity * 0.5 * 4
    local data_light = data.intensity * 0.5 * 2.3
    local data_texture = math.min(data.intensity * 0.64 * 2, 1) * 3
    self.src1a:seekToTime(realElapsed % (self.src1a:getDuration() / 1000))

    if elapsed == nil then
        elapsed = 0.5
    end
    elapsed = elapsed % self.TRACK_DURATION
    local scale = self.ae:get("/BCC6LensBlur-9961714", elapsed)[1] / 36
    self.blur1Material:setFloat("u_SizeScale", scale)
    self.blur2Material:setFloat("u_SizeScale", scale)
    self.blur3Material:setFloat("u_SizeScale", scale)
    self.XMaterial:setFloat("u_SizeScale", scale)
    self.YMaterial:setFloat("u_SizeScale", scale)
    self.blur1Material:setFloat("u_Size", data_scale * 1.2)
    self.blur2Material:setFloat("u_Size", data_scale * 1.2)
    self.blur3Material:setFloat("u_Size", data_scale * 1.2)
    self.YMaterial:setFloat("u_Strength", data_scale * 0.4)
    self.XMaterial:setFloat("u_Strength", data_scale * 0.4)

    self.blur1Material:setFloat("u_Bright", data_intensity * 5)
    self.blur2Material:setFloat("u_Bright", data_intensity * 5)
    self.blur3Material:setFloat("u_Bright", data_intensity * 5)

    local light = self.ae:get("/ADBE Opacity", elapsed)[1] / 100 * data_light
    self.filter:setFloat("u_intensity", light)
    self.blend:setFloat("u_opacity1", data_texture * light)
end


return CCMain