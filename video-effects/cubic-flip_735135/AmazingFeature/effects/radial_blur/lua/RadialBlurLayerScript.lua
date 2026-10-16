
local exports = exports or {}
local RadialBlurLayerScript = RadialBlurLayerScript or {}

---@class RadialBlurLayerScript : ScriptComponent
---@field Type int [UI(Range={1, 6}, Slider)]
---@field Amount number [UI(Range={-250, 250}, Slider)]
---@field Quality number
---@field Center Vector2f
---@field InputTex Texture
---@field OutputTex Texture
RadialBlurLayerScript.__index = RadialBlurLayerScript

local cc_radial_blur_type = {
    "Straight Zoom", "Fading Zoom", "Centered Zoom", "Rotate", "Scratch", "Rotate Fading"
}

function RadialBlurLayerScript.new()
    local self = {}
    setmetatable(self, RadialBlurLayerScript)
    self.InputTex = nil
    self.OutputTex = nil
    self.transform = {}
    self.Type = 1
    self.lastType = ""
    self.Amount = 0.0
    self.Quality = 10
    self.Center = Amaz.Vector2f(0.5, 0.5)
    self.MatTable = {}
    return self
end

function RadialBlurLayerScript:start(comp)
    self.first = nil

end

function RadialBlurLayerScript:start(comp)
    self.MatTable["Straight Zoom"] = comp.entity:searchEntity("Straight_Zoom_Radial_Blur"):getComponent("MeshRenderer")
    self.MatTable["Fading Zoom"] = comp.entity:searchEntity("Fading_Zoom_Radial_Blur"):getComponent("MeshRenderer")
    self.MatTable["Centered Zoom"] = comp.entity:searchEntity("Centered_Zoom_Radial_Blur"):getComponent("MeshRenderer")
    self.MatTable["Rotate"] = comp.entity:searchEntity("Rotate_Radial_Blur"):getComponent("MeshRenderer")
    self.MatTable["Scratch"] = comp.entity:searchEntity("Scratch_Radial_Blur"):getComponent("MeshRenderer")
    self.MatTable["Rotate Fading"] = comp.entity:searchEntity("Rotate_Fading_Radial_Blur"):getComponent("MeshRenderer")
    self.outputCamera = comp.entity:searchEntity("Camera_Radial_Blur"):getComponent("Camera")

    self.MatTable["Straight Zoom"].entity.selfvisible = false
    self.MatTable["Fading Zoom"].entity.selfvisible = false
    self.MatTable["Centered Zoom"].entity.selfvisible = false
    self.MatTable["Rotate"].entity.selfvisible = false
    self.MatTable["Scratch"].entity.selfvisible = false
    self.MatTable["Rotate Fading"].entity.selfvisible = false

end

---@param comp Component
---@param deltaTime number
function RadialBlurLayerScript:onUpdate(comp, deltaTime)
    if self.first == nil then
        self.first = true
        self:start(comp)
    end

    self.outputCamera.renderTexture = self.OutputTex
    self.MatTable["Centered Zoom"].material:setTex("u_InputTex", self.InputTex)
    self.MatTable["Fading Zoom"].material:setTex("u_InputTex", self.InputTex)
    self.MatTable["Rotate Fading"].material:setTex("u_InputTex", self.InputTex)
    self.MatTable["Rotate"].material:setTex("u_InputTex", self.InputTex)
    self.MatTable["Scratch"].material:setTex("u_InputTex", self.InputTex)
    self.MatTable["Straight Zoom"].material:setTex("u_InputTex", self.InputTex)

    -- Amaz.LOGI("lrc aaa", tostring(cc_radial_blur_type[self.Type]))

    if self.lastType ~= self.Type then
        self.MatTable[cc_radial_blur_type[self.Type]].entity.selfvisible = true
        if self.lastType ~= "" then
            self.MatTable[cc_radial_blur_type[self.lastType]].entity.selfvisible = false
        end
        self.lastType = self.Type
    end
    local mat = self.MatTable[cc_radial_blur_type[self.Type]].material
    mat:setFloat("u_Quality", self.Quality)
    mat:setFloat("u_Amount", self.Amount)
    mat:setVec2("u_Center", self.Center)
    -- local rt = nil
    -- if  self.Custom_Input == true then
    --     if self.Input == nil then
    --         rt = comp.entity.scene:getInputTexture(Amaz.BuiltInTextureType.INPUT0)
    --     else
    --         rt = self.Input
    --     end
    -- else
    --     if self.LastLayerOutput == nil then
    --         rt = comp.entity.scene:getInputTexture(Amaz.BuiltInTextureType.INPUT0)
    --     else
    --         rt = self.LastLayerOutput
    --     end
    -- end
    -- self.MatTable["Straight Zoom"].material:setTex("u_InputTex", rt)
    -- self.MatTable["Fading Zoom"].material:setTex("u_InputTex", rt)
    -- self.MatTable["Centered Zoom"].material:setTex("u_InputTex", rt)
    -- self.MatTable["Rotate"].material:setTex("u_InputTex", rt)
    -- self.MatTable["Scratch"].material:setTex("u_InputTex", rt)
    -- self.MatTable["Rotate Fading"].material:setTex("u_InputTex", rt)
end

exports.RadialBlurLayerScript = RadialBlurLayerScript
return exports
