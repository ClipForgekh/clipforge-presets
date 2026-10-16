local exports = exports or {}
local LumiScript = LumiScript or {}
LumiScript.__index = LumiScript
---@class LumiScript: ScriptComponent
----@field brilliance number
----@field brightness number
----@field contrast number
----@field exposure number
----@field fade number
----@field highlight number
----@field lightSensation number
----@field saturation number
----@field shadow number
----@field temperature number
----@field tone number
----@field vibrance number


function LumiScript.new(construct, ...)
    local self = setmetatable({}, LumiScript)
    if construct and LumiScript.constructor then
        LumiScript.constructor(self, ...)
    end

    return self
end

function LumiScript:constructor()
end

function LumiScript:onStart(comp)
    Amaz.LOGI("lrc onstart", "LumiScript")
    self.properties = comp.properties
    self.material = comp.entity:searchEntity("map_renderer"):getComponent("MeshRenderer").material
    self.material_splendor = comp.entity:searchEntity("splendor_renderer"):getComponent("MeshRenderer").material

end

function LumiScript:updateMaterial()
    -- if self.first == nil then
    --     return
    -- end

    self.material_splendor:setFloat("ins", self.brilliance*0.5+0.5)
    self.material:setFloat("intensityBrightness", self.brightness)
    self.material:setFloat("intensityContrast", self.contrast)
    self.material:setFloat("intensityExposure", self.exposure)
    self.material:setFloat("intensityFade", self.fade)
    self.material:setFloat("intensityHighlight", self.highlight)
    self.material:setFloat("intensityLightSensation", self.lightSensation)
    self.material:setFloat("intensitySaturation", self.saturation)
    self.material:setFloat("intensityShadow", self.shadow)
    self.material:setFloat("intensityTemperature", self.temperature)
    self.material:setFloat("intensityVibrance", self.vibrance)
    self.material:setFloat("intensityTone", self.tone)
end

function LumiScript:onUpdate(comp, detalTime)
    -- if self.first == nil then
    --     self.first = true
    --     self:start(comp)
    -- end
    self:updateMaterial()
end

function LumiScript:onEvent(sys, event)

end

--  ↓↓↓ LumiScript pubulic api ↓↓↓
local effect_attrs = {
    "brilliance",
    "brightness",
    "contrast",
    "exposure",
    "fade",
    "highlight",
    "lightSensation",
    "saturation",
    "shadow",
    "temperature",
    "tone",
    "vibrance",
}

local function _checkKeyExist(_name)
    for i = 1, #effect_attrs do
        if _name == effect_attrs[i] then
            return true
        end
    end
    return false
end

function LumiScript:setEffectAttr(_name, _value)
    if self[_name] ~= nil and _checkKeyExist(_name) then
        self[_name] = _value
        if self.properties ~= nil then
            self.properties:set(_name, _value)
        end
    end
end

function LumiScript:getEffectAttrs()
    return effect_attrs
end
-- ↑↑↑ LumiScript pubulic api ↑↑↑

exports.LumiScript = LumiScript
return exports
