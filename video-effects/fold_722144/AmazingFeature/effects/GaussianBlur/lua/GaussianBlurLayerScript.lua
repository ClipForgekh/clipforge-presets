local exports = exports or {}
local GaussianBlurLayerScript = GaussianBlurLayerScript or {}

---@class GaussianBlurLayerScript : ScriptComponent
---@field Intensity number
---@field Step number
---@field Blurred_Direction string[UI(Option={"Horizontal and Vertical", "Horizontal", "Vertical"})]
GaussianBlurLayerScript.__index = GaussianBlurLayerScript

function GaussianBlurLayerScript.new()
    local self = {}
    setmetatable(self, GaussianBlurLayerScript)
    self.Intensity = 0.0
    self.Step = 1.0
    self.Blurred_Direction = "Horizontal and Vertical"
    self.transform = {}
    return self
end

---@param comp Component
function GaussianBlurLayerScript:onStart(comp)
    self.HorizontalBlurMat = comp.entity:searchEntity("Horizontal_Blur"):getComponent("MeshRenderer").material
    self.VerticalBlurMat = comp.entity:searchEntity("Vertical_Blur"):getComponent("MeshRenderer").material
end

---@param comp Component
---@param deltaTime number
function GaussianBlurLayerScript:onUpdate(comp, deltaTime)
    -- local intensity = math.max(self.Intensity, 0.0)
    local intensity = math.max(comp.properties:get("Intensity"), 0.0)
    local xins = intensity / 8
    local ystep = math.max(intensity / 16, 1.0)
    local yins = intensity / ystep
    self.HorizontalBlurMat:enableMacro("GLOWSAMPLE", math.floor(xins))
    self.VerticalBlurMat:enableMacro("GLOWSAMPLE", math.floor(yins))
    self.HorizontalBlurMat:setFloat("u_Step", 1.0)
    self.VerticalBlurMat:setFloat("u_Step", ystep)
    if self.Blurred_Direction == "Horizontal" then
        self.VerticalBlurMat:enableMacro("GLOWSAMPLE", 0)
    end
    if self.Blurred_Direction == "Vertical" then
        self.HorizontalBlurMat:enableMacro("GLOWSAMPLE", 0)
    end
end

---@param comp Component
---@param event Event
function GaussianBlurLayerScript:onEvent(comp, event)
end

exports.GaussianBlurLayerScript = GaussianBlurLayerScript
return exports
