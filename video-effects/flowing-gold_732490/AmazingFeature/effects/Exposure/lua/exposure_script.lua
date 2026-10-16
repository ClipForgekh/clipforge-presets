
local exports = exports or {}
local exposure_script = exposure_script or {}
exposure_script.__index = exposure_script
---@class exposure_script : ScriptComponent
---@field exposure number
---@field offset number
---@field grayscale_correct number
---@field no_use_linear_light boolean
---@field InputTex Texture
---@field OutputTex Texture

function exposure_script.new()
    local self = {}
    setmetatable(self, exposure_script)

    self.InputTex = nil
    self.OutputTex = nil

    self.exposure = 0
    self.offset = 0
    self.grayscale_correct = 1
    self.first = nil
    self.no_use_linear_light = false
    return self
end

---@param comp Component
function exposure_script:onStart(comp)
end

function exposure_script:start(comp)
    self.exposure_mat = comp.entity:searchEntity("Exposure"):getComponent("MeshRenderer").material
    self.exposure_cam = comp.entity:searchEntity("Camera_Exposure"):getComponent("Camera")
end

---@param comp Component
---@param deltaTime number
function exposure_script:onUpdate(comp, deltaTime)
    if self.first == nil then
        self.first = true
        self:start(comp)
    end
    self.exposure_cam.renderTexture = self.OutputTex
    self.exposure_mat:setTex("u_InputTex", self.InputTex)
    self.exposure_mat:setFloat("u_Intensity", self.exposure)
    self.exposure_mat:setFloat("u_Offset", self.offset)
    self.exposure_mat:setFloat("u_GrayscaleCorrect", self.grayscale_correct)
    if self.no_use_linear_light then
        self.exposure_mat:setFloat("use_linear_light", 1.0)
    else
        self.exposure_mat:setFloat("use_linear_light", 0.0)
    end
end

exports.exposure_script = exposure_script
return exports
