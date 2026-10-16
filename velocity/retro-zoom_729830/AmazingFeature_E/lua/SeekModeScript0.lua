local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)

    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.curTime = 0.
    self.startTime = 0.
    self.endTime = 3.
    self.intensity = 1
    self.speedIntensity = .33
    self.sharpenIntensity = 1
    self.distortionIntensity = 1
    return self
end

function SeekModeScript:constructor()
end

function SeekModeScript:onStart(comp)
    self.matTurbulence = comp.entity.scene:findEntityBy("PassTurbulence"):getComponent("MeshRenderer").material
    self.matBounce = comp.entity.scene:findEntityBy("PassBounce"):getComponent("MeshRenderer").material
    self.matShake = comp.entity.scene:findEntityBy("PassShake"):getComponent("MeshRenderer").material
    self.matSharpen = comp.entity.scene:findEntityBy("PassSharpen"):getComponent("MeshRenderer").material
    self.camHorzBlur = comp.entity.scene:findEntityBy("CameraHorzBlur"):getComponent("Camera")
end

function SeekModeScript:onUpdate(comp, deltaTime)
    self.duration = self.endTime - self.startTime
    self.curTime = self.curTime + deltaTime
    local time = (self.curTime - self.startTime) * (.5 + self.speedIntensity * 1.5)
    self.matTurbulence:setFloat("time", time / 6000)
    local bounceTime = time / 2. % 1.
    local shakeTime = time / 4. % 1.
    self.matBounce:setFloat("bounceTime", bounceTime)
    self.matShake:setFloat("shakeTime", shakeTime)
    self.matTurbulence:setFloat("intensity", self.distortionIntensity)
    self.matBounce:setFloat("intensity", self.intensity)
    self.matShake:setFloat("intensity", self.intensity)
    self.matSharpen:setFloat("sharpenIntensity", self.sharpenIntensity)
    self.camHorzBlur.renderTexture.pecentX = 1. - .5 * self.sharpenIntensity
    self.camHorzBlur.renderTexture.pecentY = 1. - .5 * self.sharpenIntensity
    -- Amaz.LOGI("time", time / 10)
end

function SeekModeScript:onEvent (comp, event)
    local type = event.args:get(0)
    if "effects_adjust_speed" == type then
        self.speedIntensity = event.args:get(1)
    end
    if "effects_adjust_intensity" == type then
        self.intensity = event.args:get(1)
    end
    if "effects_adjust_distortion" == type then
        self.distortionIntensity = event.args:get(1)
    end
    if "effects_adjust_sharpen" == type then
        self.sharpenIntensity = event.args:get(1)
    end
end

exports.SeekModeScript = SeekModeScript
return exports
