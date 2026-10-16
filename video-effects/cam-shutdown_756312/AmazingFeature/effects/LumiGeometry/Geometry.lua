local exports = exports or {}
local Geometry = Geometry or {}
Geometry.__index = Geometry
---@class Geometry : ScriptComponent
---@field rotation double [UI(Range={0, 360}, Drag)] 
---@field rotationAxis double [UI(Range={0, 360}, Drag)] 
---@field InputTex Texture
---@field OutputTex Texture

function Geometry.new()
    local self = {}
    setmetatable(self, Geometry)

    self.rotation = 0
    self.rotationAxis = 0
    self.InputTex = nil
    self.OutputTex = nil
    return self
end

function Geometry:onStart(comp)
    self.first = true
    self.cam_geometry = comp.entity:searchEntity('Camera_Geometry'):getComponent("Camera")
    self.geometryMat = comp.entity:searchEntity('Geometry_Renderer'):getComponent("MeshRenderer").material
end

function Geometry:onUpdate(comp, detalTime)
    if self.first == nil then
        return
    end
    self.geometryMat:setTex('u_inputTex', self.InputTex)
    self.cam_geometry.renderTexture = self.OutputTex
    self.geometryMat:setFloat('u_rotation', math.rad(self.rotation))
    local rotationAxis = self.rotationAxis
    rotationAxis = math.abs(rotationAxis%90)<0.01 and rotationAxis-0.01 or rotationAxis
    self.geometryMat:setFloat('u_rotationAxis', math.rad(rotationAxis))
end

exports.Geometry = Geometry
return exports
