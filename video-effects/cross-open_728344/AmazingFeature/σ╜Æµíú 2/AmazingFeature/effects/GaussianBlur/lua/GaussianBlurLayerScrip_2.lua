local exports = exports or {}
local GaussianBlurLayerScrip_2 = GaussianBlurLayerScrip_2 or {}

---@class GaussianBlurLayerScrip_2 : ScriptComponent
---@field intensity number
---@field steps number
---@field Blurred_Direction string[UI(Option={"Horizontal and Vertical", "Horizontal", "Vertical"})]
---@field MidTex Texture
---@field InputTex Texture
---@field OutputTex Texture
GaussianBlurLayerScrip_2.__index = GaussianBlurLayerScrip_2

function GaussianBlurLayerScrip_2.new()
    local self = {}
    setmetatable(self, GaussianBlurLayerScrip_2)
    self.intensity = 0.0
    self.steps = 0
    self.Blurred_Direction = "Horizontal and Vertical"
    self.transform = {}
    self.MidTex = nil
    self.InputTex = nil
    self.OutputTex = nil
    return self
end

---@param comp Component
function GaussianBlurLayerScrip_2:onStart(comp)
    self.HorizontalBlurMat_2 = comp.entity:searchEntity("Horizontal_Blur_2"):getComponent("MeshRenderer").material
    self.VerticalBlurMat_2 = comp.entity:searchEntity("Vertical_Blur_2"):getComponent("MeshRenderer").material

    self.hori_cam_2 = comp.entity:searchEntity("Camera_Horizontal_Blur_2"):getComponent("Camera")
    self.vert_cam_2 = comp.entity:searchEntity("Camera_Vertical_Blur_2"):getComponent("Camera")

end

---@param comp Component
---@param deltaTime number
function GaussianBlurLayerScrip_2:onUpdate(comp, deltaTime)
    local props = comp.entity:getComponent("ScriptComponent").properties
    if props:has("intensity") then
        self.intensity = props:get("intensity")
    end
    local intensity = math.max(self.intensity, 0.0)
    self.HorizontalBlurMat_2:setFloat("u_Sample", math.floor(intensity))
    self.VerticalBlurMat_2:setFloat("u_Sample", math.floor(intensity))
    self.HorizontalBlurMat_2:setFloat("u_Steps", self.steps)
    self.VerticalBlurMat_2:setFloat("u_Steps", self.steps)
    if self.Blurred_Direction == "Horizontal" then
        -- self.VerticalBlurMat:enableMacro("GLOWSAMPLE", 0)
        self.vert_cam_2.entity.visible = false
        self.horihori_cam_2_cam.entity.visible = true

        self.HorizontalBlurMat_2:setTex("u_InputTex", self.InputTex)
        self.hori_cam_2.renderTexture = self.OutputTex
    elseif self.Blurred_Direction == "Vertical" then
        -- self.HorizontalBlurMat:enableMacro("GLOWSAMPLE", 0)
        self.vert_cam_2.entity.visible = true
        self.hori_cam_2.entity.visible = false

        self.VerticalBlurMat_2:setTex("u_InputTex", self.InputTex)
        self.vert_cam_2.renderTexture = self.OutputTex
    
    else
        self.vert_cam_2.entity.visible = true
        self.hori_cam_2.entity.visible = true

        self.HorizontalBlurMat_2:setTex("u_InputTex", self.InputTex)
        self.hori_cam_2.renderTexture = self.MidTex
        self.VerticalBlurMat_2:setTex("u_InputTex", self.MidTex)
        self.vert_cam_2.renderTexture = self.OutputTex

    end
end

exports.GaussianBlurLayerScrip_2 = GaussianBlurLayerScrip_2
return exports





