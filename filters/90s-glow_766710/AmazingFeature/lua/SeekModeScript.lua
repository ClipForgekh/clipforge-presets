local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

local function clamp(value, minValue, maxValue)
    if value == nil then return nil end
    if value < minValue then return minValue end
    if value > maxValue then return maxValue end
    return value
end

local function normalize(value)
    value = tonumber(value)
    if value == nil then return nil end
    if value > 1.0 then value = value / 100.0 end
    return clamp(value, 0.0, 1.0)
end

local function findMaterial(scene)
    if scene == nil then return nil end
    local entity = scene:findEntityBy("SeekModeScript")
    if entity == nil then return nil end
    local renderer = entity:getComponent("MeshRenderer")
    if renderer == nil then renderer = entity:getComponent("Renderer") end
    if renderer == nil then return nil end
    return renderer.material
end

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.uniAlpha = 1.0
    return self
end

function SeekModeScript:constructor()
end

function SeekModeScript:onStart(comp, sys)
    self.pass6Material = findMaterial(comp.entity.scene)
    self:setIntensity(self.uniAlpha)
end

function SeekModeScript:setIntensity(value)
    local normalized = normalize(value)
    if normalized == nil then normalized = 1.0 end
    self.uniAlpha = normalized
    if self.pass6Material ~= nil then
        if self.pass6Material.setFloat ~= nil then
            self.pass6Material:setFloat("uniAlpha", normalized)
        end
        self.pass6Material["uniAlpha"] = normalized
    end
end

function SeekModeScript:onEvent(sys, event)
    if event == nil or event.args == nil then return end
    local key = event.args:get(0)
    if key == "effects_adjust_filter" or key == "Internal_Filter" or key == "intensity" or key == "uniAlpha" then
        local value = event.args:get(1)
        if value == nil then value = event.args:get(2) end
        self:setIntensity(value)
    end
end

exports.SeekModeScript = SeekModeScript
return exports