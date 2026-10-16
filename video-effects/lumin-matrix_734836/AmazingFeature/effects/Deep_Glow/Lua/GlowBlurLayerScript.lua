local exports = exports or {}
local GlowBlurLayerScript = GlowBlurLayerScript or {}

---@class GlowBlurLayerScript : ScriptComponent
---@field Intensity number
---@field DownSample number
---@field gamma number
---@field ratio number
---@field Blurred_Direction string[UI(Option={"Horizontal and Vertical", "Horizontal", "Vertical"})]
GlowBlurLayerScript.__index = GlowBlurLayerScript

function GlowBlurLayerScript.new()
    local self = {}
    setmetatable(self, GlowBlurLayerScript)
    self.Intensity = 0.0
    self.DownSample = 1
    self.Blurred_Direction = "Horizontal and Vertical"
    self.ratio = 1
    self.gamma = 2.2
    self.transform = {}
    return self
end

---@param comp Component
function GlowBlurLayerScript:onStart(comp)
    self.HorizontalBlurMat = comp.entity:searchEntity("GlowBlurH"):getComponent("MeshRenderer").material
    self.VerticalBlurMat = comp.entity:searchEntity("GlowBlurV"):getComponent("MeshRenderer").material
    self.entity = comp.entity
end


local clamp = function(value, min, max)
    return math.max(math.min(value, max), min)
end
---@param comp Component
---@param deltaTime number
function GlowBlurLayerScript:onUpdate(comp, deltaTime)

    local intensity = math.max(self.Intensity, 0.0)
    local ratio = clamp(self.ratio, 0, 2)
    self.HorizontalBlurMat:setFloat("u_Strength", intensity * ratio)
    self.VerticalBlurMat:setFloat("u_Strength", intensity * (2 - ratio))
    -- self.HorizontalBlurMat:enableMacro("GLOWSAMPLE", math.floor(intensity))
    -- self.VerticalBlurMat:enableMacro("GLOWSAMPLE", math.floor(intensity))

    if self.Blurred_Direction == "Horizontal" then
        self.VerticalBlurMat:setFloat("u_Strength", 0)
    end
    if self.Blurred_Direction == "Vertical" then
        self.HorizontalBlurMat:setFloat("u_Strength", 0)
    end
    self.HorizontalBlurMat:setFloat("u_DownSample", self.DownSample)
    self.VerticalBlurMat:setFloat("u_DownSample", self.DownSample)

    self.HorizontalBlurMat:setFloat("u_gamma", self.gamma)
    self.VerticalBlurMat:setFloat("u_gamma", self.gamma)
end

---@param comp Component
---@param event Event
function GlowBlurLayerScript:onEvent(comp, event)
end

exports.GlowBlurLayerScript = GlowBlurLayerScript
return exports
