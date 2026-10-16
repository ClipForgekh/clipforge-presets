local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local ExpandInput = ExpandInput or {}
ExpandInput.__index = ExpandInput
---@class ExpandInput : ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture

function ExpandInput.new(construct, ...)
    local self = setmetatable({}, ExpandInput)

    if construct and ExpandInput.constructor then ExpandInput.constructor(self, ...) end

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function ExpandInput:constructor()
end

function ExpandInput:onStart(comp)
    self.camera = comp.entity:searchEntity("CameraExpand"):getComponent("Camera")
    self.material = comp.entity:searchEntity("PassExpand"):getComponent("MeshRenderer").material
end

function ExpandInput:onUpdate(comp, deltaTime)
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end
    self.material:setTex("u_InputTexture", self.InputTex)
end

exports.ExpandInput = ExpandInput
return exports
