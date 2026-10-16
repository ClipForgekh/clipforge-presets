local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local ShrinkOutput = ShrinkOutput or {}
ShrinkOutput.__index = ShrinkOutput
---@class ShrinkOutput : ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture

function ShrinkOutput.new(construct, ...)
    local self = setmetatable({}, ShrinkOutput)

    if construct and ShrinkOutput.constructor then ShrinkOutput.constructor(self, ...) end

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function ShrinkOutput:constructor()
end

function ShrinkOutput:onStart(comp)
    self.camera = comp.entity:searchEntity("CameraShrink"):getComponent("Camera")
    self.material = comp.entity:searchEntity("PassShrink"):getComponent("MeshRenderer").material
end

function ShrinkOutput:onUpdate(comp, deltaTime)
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end
    self.material:setTex("u_InputTexture", self.InputTex)
end

exports.ShrinkOutput = ShrinkOutput
return exports
