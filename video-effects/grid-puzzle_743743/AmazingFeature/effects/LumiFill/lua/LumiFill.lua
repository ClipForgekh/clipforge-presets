      
local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiFill = LumiFill or {}
LumiFill.__index = LumiFill
---@class LumiFill : ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture
---@field color Color [UI(NoAlpha)]
---@field alpha double [UI(Range={0, 1}, Drag)]
---@field reverse Bool

function LumiFill.new(construct, ...)
    local self = setmetatable({}, LumiFill)

    if construct and LumiFill.constructor then LumiFill.constructor(self, ...) end

    self.InputTex = nil
    self.OutputTex = nil

    self.color = Amaz.Color(1., 1., 1.)
    self.alpha = 1.0
    self.reverse = false

    return self
end

function LumiFill:constructor()
end

function LumiFill:onStart(comp)
    self.camera = comp.entity:searchEntity("BlitCamera"):getComponent("Camera")
    self.material = comp.entity:searchEntity("BlitPass"):getComponent("MeshRenderer").material
end

function LumiFill:onUpdate(comp, deltaTime)
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end
    self.material:setTex("u_InputTexture", self.InputTex)

    self.material:setFloat('u_Alpha', self.alpha)
    self.material:setFloat('u_Reverse', self.reverse and 1 or 0)
    self.material:setVec3("u_Color", Amaz.Vector3f(self.color.r, self.color.g, self.color.b))
end

exports.LumiFill = LumiFill
return exports
