-- 暖奶油 v2: preserve the original pass0; slider controls color only here.
-- Fullness and smoothing receive the same master events in their native scripts.
--@input float curTime = 0.0{"widget":"slider","min":0,"max":10}

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

local function clamp01(value)
    return math.max(0.0, math.min(1.0, value))
end

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    self.width = 0
    self.height = 0
    self.amount = 1.0
    return self
end

function SeekModeScript:onStart(comp)
    self.filterMaterial = comp.entity.scene:findEntityBy("filter"):getComponent("MeshRenderer").material
    self.pass0Material = comp.entity.scene:findEntityBy("sharp"):getComponent("MeshRenderer").material
    self:applyAmount(1.0)
end

function SeekModeScript:applyAmount(value)
    self.amount = clamp01(value)
    self.filterMaterial:setFloat("intensity", self.amount * 0.48)
    self.pass0Material:setFloat("u_sharpness", 0.0)
end

function SeekModeScript:onUpdate(comp, deltaTime)
    local width = Amaz.BuiltinObject:getInputTextureWidth()
    local height = Amaz.BuiltinObject:getInputTextureHeight()
    if width ~= self.width or height ~= self.height then
        self.width = width
        self.height = height
        self.pass0Material:setInt("imageWidth", self.width)
        self.pass0Material:setInt("imageHeight", self.height)
    end
end

function SeekModeScript:onEvent(sys, event)
    local key = event.args:get(0)
    if key == "intensity" or key == "Internal_Filter" or key == "effects_adjust_filter" then
        self:applyAmount(event.args:get(1))
    end
end

exports.SeekModeScript = SeekModeScript
return exports
