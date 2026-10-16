local exports = exports or {}
local ImageBusinessSlider = ImageBusinessSlider or {}
ImageBusinessSlider.__index = ImageBusinessSlider

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
    local entity = scene:findEntityBy("ImageBusinessSlider")
    if entity == nil then return nil end
    local renderer = entity:getComponent("MeshRenderer")
    if renderer == nil then renderer = entity:getComponent("Renderer") end
    if renderer == nil then return nil end
    return renderer.material
end

function ImageBusinessSlider.new(construct, ...)
    local self = setmetatable({}, ImageBusinessSlider)
    if construct and ImageBusinessSlider.constructor then ImageBusinessSlider.constructor(self, ...) end
    self.uniAlpha = 1.0
    return self
end

function ImageBusinessSlider:constructor()
end

function ImageBusinessSlider:onStart(sys)
    self.SeekModeScriptMaterial0 = findMaterial(sys.scene)
    self:setIntensity(self.uniAlpha)
end

function ImageBusinessSlider:setIntensity(value)
    local normalized = normalize(value)
    if normalized == nil then normalized = 1.0 end
    self.uniAlpha = normalized
    if self.SeekModeScriptMaterial0 ~= nil then
        if self.SeekModeScriptMaterial0.setFloat ~= nil then
            self.SeekModeScriptMaterial0:setFloat("uniAlpha", normalized)
        end
        self.SeekModeScriptMaterial0["uniAlpha"] = normalized
    end
end

function ImageBusinessSlider:onEvent(sys, event)
    if event == nil or event.args == nil then return end
    local key = event.args:get(0)
    if key == "effects_adjust_filter" or key == "Internal_Filter" or key == "intensity" or key == "uniAlpha" then
        local value = event.args:get(1)
        if value == nil then value = event.args:get(2) end
        self:setIntensity(value)
    end
end

exports.ImageBusinessSlider = ImageBusinessSlider
return exports