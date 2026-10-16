local Utils = require("Utils")
local AEAdapter = require("AEAdapter")
local AEMin = require("AEMin")
local AEMax = require("AEMax")

local MIN_SPEED = 0.5
local MAX_SPEED = 1.0

local function clamp (value, min, max)
    return math.min(math.max(min, value), max)
end
local function mix (x, y, a)
    return x + (y - x) * a
end
local function step (edge0, edge1, value)
    return math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
end
local function smoothstep (edge0, edge1, value)
    local t = math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
    return t * t * (3 - t - t)
end


local Main = {}
Main.__index = Main
function Main.new (env)
    local self = setmetatable({}, Main)
    return self
end

function Main:create (env, data, scene)
    Utils.initPipeline(scene, "@Pipeline")

    self.motion = scene:findEntityBy("motion"):getComponent("MeshRenderer").material
    self.br1 = scene:findEntityBy("br1"):getComponent("MeshRenderer").material
    self.br2 = scene:findEntityBy("br2"):getComponent("MeshRenderer").material
    self.br3 = scene:findEntityBy("br3"):getComponent("MeshRenderer").material
    self.br4 = scene:findEntityBy("br4"):getComponent("MeshRenderer").material

    self.rt0 = scene:findEntityBy("camera_br1"):getComponent("Camera").renderTexture
    self.rt1 = scene:findEntityBy("camera_br2"):getComponent("Camera").renderTexture

    self.ae = AEAdapter:new()
    self.ae:add("min", AEMin)
    self.ae:add("max", AEMax)

    data.intensity = 0.5
end

function Main:layout (env, data, w, h)
	self.rt0.width = w
    self.rt0.height = h
    self.rt1.width = w
    self.rt1.height = h

    local s = math.min(w, h)
    w = w * 720 / s
    h = h * 720 / s

    local screenSize = Amaz.Vector2f(w, h)
    self.motion:setVec2("u_screen_size", screenSize)

    self.br1:setVec2("u_screen_size", screenSize)
    self.br2:setVec2("u_screen_size", screenSize)
    self.br3:setVec2("u_screen_size", screenSize)
    self.br4:setVec2("u_screen_size", screenSize)

    local screenCenter = Amaz.Vector2f(w * 0.5, h * 0.5)
    self.br1:setVec2("u_center", screenCenter)
    self.br2:setVec2("u_center", screenCenter)
    self.br3:setVec2("u_center", screenCenter)
    self.br4:setVec2("u_center", screenCenter)

    local core = s * 0.2
    self.br1:setFloat("u_core", core)
    self.br2:setFloat("u_core", core)
    self.br3:setFloat("u_core", core)
    self.br4:setFloat("u_core", core)
end

function Main:solveTiming (prev, next, q, p)
    if not prev then
        next.s = next.t - (0.2 - 0.0666667)
    elseif not next then
        prev.e = prev.t + (0.3666667 - 0.2)
    else
        local t = (next.t + prev.t) * 0.5
        prev.e = t
        next.s = t
    end
end

function Main:update (env, data_, time, duration, progress)
    if not env.timingData then
        if not env.rawTimingData then
            return
        end
        local src = env.rawTimingData
        local dst = {}
        for _, beat in ipairs(src) do
            table.insert(dst, {t = beat})
        end
        local q = step(env.RawHeadTime, env.RawFootTime, env.RawBeatTime)
        local p = 1 - q
        for i = 0, #dst do
            self:solveTiming(dst[i], dst[i+1], q, p)
        end
        env.timingData = dst
    end

    local time0 = env.RawHeadTime
    for i, beat in ipairs(env.timingData) do
        if beat.s <= time and time < beat.e then
            if time < beat.t then
                time0 = mix(env.RawHeadTime, env.RawBeatTime, step(beat.s, beat.t, time))
            else
                time0 = mix(env.RawBeatTime, env.RawFootTime, step(beat.t, beat.e, time))
            end
            env.currentBeatIndex = i
            break
        end
    end
    self:update0(env, data_, time0, duration)
end

function Main:update0 (env, data, elapsed, duration, progress)

    local data_light = data.intensity * 1.2 * 0.78
    local data_blur = data.intensity * 1.2 * 0.53
    local data_intensity = data.intensity * 1.2 * 0.19

    local w = env.w
    local h = env.h

    local positionMin = self.ae:get("min/ADBE Position", elapsed)
    local positionMax = self.ae:get("max/ADBE Position", elapsed)
    local position = Amaz.Vector2f(
            Utils.mix(positionMin.x, positionMax.x, data_intensity),
            Utils.mix(positionMin.y, positionMax.y, data_intensity))
    local x = position.x / 720
    local y = 1 - position.y / 1280
    y = (y - 0.5) * (w / h) + 0.5
    self.motion:setVec2("u_position", Amaz.Vector2f(x, y))

    local rotationMin = self.ae:get("min/ADBE Rotate Z", elapsed)
    local rotationMax = self.ae:get("max/ADBE Rotate Z", elapsed)
    local rotation = Utils.mix(rotationMin, rotationMax, data_intensity)
    self.motion:setFloat("u_angle", -rotation)

    local scaleMin = self.ae:get("min/ADBE Scale", elapsed)
    local scaleMax = self.ae:get("max/ADBE Scale", elapsed)
    local scale = Utils.mix(scaleMin.x, scaleMax.x, data_intensity)
    self.motion:setFloat("u_scale", scale * 0.01)

    local exposureMin = self.ae:get("min/ADBE Exposure2-0003", elapsed)
    local exposureMax = self.ae:get("max/ADBE Exposure2-0003", elapsed)
    local exposure = Utils.mix(exposureMin, exposureMax, data_intensity)
    self.motion:setFloat("u_exposure", exposure * data_light)

    local stepMin = self.ae:get("min/ADBE Radial Blur-0001", elapsed)
    local stepMax = self.ae:get("max/ADBE Radial Blur-0001", elapsed)
    local blurStep = Utils.mix(stepMin, stepMax, data_intensity)
    blurStep = blurStep * data_blur * 0.5
    self.br1:setFloat("u_step", blurStep)
    self.br2:setFloat("u_step", blurStep * 0.5)
    self.br3:setFloat("u_step", blurStep * 0.25)
    self.br4:setFloat("u_step", blurStep * 0.125)
end


return Main