local exports = exports or {}
local GaussianBlurLayerScrip_3 = GaussianBlurLayerScrip_3 or {}

---@class GaussianBlurLayerScrip_3 : ScriptComponent
---@field intensity number
---@field steps number
---@field Blurred_Direction string[UI(Option={"Horizontal and Vertical", "Horizontal", "Vertical"})]
---@field MidTex Texture
---@field InputTex Texture
---@field OutputTex Texture
GaussianBlurLayerScrip_3.__index = GaussianBlurLayerScrip_3

function GaussianBlurLayerScrip_3.new()
    local self = {}
    setmetatable(self, GaussianBlurLayerScrip_3)
    self.intensity = 0.0
    self.steps = 0.0
    self.Blurred_Direction = "Horizontal and Vertical"
    self.transform = {}
    self.MidTex = nil
    self.InputTex = nil
    self.OutputTex = nil
    return self
end

---@param comp Component
function GaussianBlurLayerScrip_3:onStart(comp)
    self.HorizontalBlurMat_3 = comp.entity:searchEntity("Horizontal_3"):getComponent("MeshRenderer").material
    self.VerticalBlurMat_3 = comp.entity:searchEntity("Vertical_3"):getComponent("MeshRenderer").material

    self.hori_cam_3 = comp.entity:searchEntity("Camera_Horizontal_3"):getComponent("Camera")
    self.vert_cam_3 = comp.entity:searchEntity("Camera_Vertical_3"):getComponent("Camera")

end

---@param comp Component
---@param deltaTime number
function GaussianBlurLayerScrip_3:onUpdate(comp, deltaTime)
    local props = comp.entity:getComponent("ScriptComponent").properties
    if props:has("intensity") then
        self.intensity = props:get("intensity")
    end
    Amaz.LOGI("intensity",1.-self.intensity/100.)
    self.OutputTex.pecentX = 1.-self.intensity/100.
    self.OutputTex.pecentY = 1.-self.intensity/100.

   
    local intensity = math.max(self.intensity, 0.0)
    self.HorizontalBlurMat_3:setFloat("u_Sample", math.floor(intensity))
    self.VerticalBlurMat_3:setFloat("u_Sample", math.floor(intensity))
    self.HorizontalBlurMat_3:setFloat("u_Steps", self.steps)
    self.VerticalBlurMat_3:setFloat("u_Steps", self.steps)
    if self.Blurred_Direction == "Horizontal" then
        -- self.VerticalBlurMat:enableMacro("GLOWSAMPLE", 0)
        self.vert_cam_3.entity.visible = false
        self.hori_cam_3.entity.visible = true

        self.HorizontalBlurMat_3:setTex("u_InputTex", self.InputTex)
        self.hori_cam_3.renderTexture = self.OutputTex
    elseif self.Blurred_Direction == "Vertical" then
        -- self.HorizontalBlurMat:enableMacro("GLOWSAMPLE", 0)
        self.vert_cam_3.entity.visible = true
        self.hori_cam_3.entity.visible = false

        self.VerticalBlurMat_3:setTex("u_InputTex", self.InputTex)
        self.vert_cam_3.renderTexture = self.OutputTex
    
    else
        self.vert_cam_3.entity.visible = true
        self.hori_cam_3.entity.visible = true

        self.HorizontalBlurMat_3:setTex("u_InputTex", self.InputTex)
        self.hori_cam_3.renderTexture = self.MidTex
        self.VerticalBlurMat_3:setTex("u_InputTex", self.MidTex)
        self.vert_cam_3.renderTexture = self.OutputTex

    end
end

exports.GaussianBlurLayerScrip_3 = GaussianBlurLayerScrip_3
return exports





