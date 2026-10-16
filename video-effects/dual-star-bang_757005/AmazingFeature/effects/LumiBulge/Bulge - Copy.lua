local exports = exports or {}
local Bulge = Bulge or {}
Bulge.__index = Bulge
---@class Bulge : ScriptComponent
---@field curTime number
---@field bulge_height number
---@field taper_radius number
---@field pinning number
---@field bulge_radius_x number
---@field bulge_radius_y number
---@field bulge_center_x number
---@field bulge_center_y number
---@field InputTex Texture
---@field OutputTex Texture

function Bulge.new(construct, ...)
    local self = setmetatable({}, Bulge)
    if construct and Bulge.constructor then Bulge.constructor(self, ...) end

    self.InputTex = nil
    self.OutputTex = nil

    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    -- effect adjust params
    self.bulge_height = 1.0
    self.taper_radius = 0.0
    self.pinning = 0.0
    self.bulge_radius_x = 1.0
    self.bulge_radius_y = 1.0
    self.bulge_center_x = 0.0
    self.bulge_center_y = 0.0
    self.bulge_radius = Amaz.Vector2f(1.0, 1.0)
    self.bulge_center = Amaz.Vector2f(0.0, 0.0)
    return self
end

function Bulge:constructor()

end

function Bulge:onStart(comp)
    self.first = true
    self.pass0Material = comp.entity:searchEntity("pass"):getComponent("MeshRenderer").material
    self.pass0Camera = comp.entity:searchEntity("cam"):getComponent("Camera")
end

function Bulge:onUpdate(comp, detalTime)    
    if self.first == nil then
        self:onStart(comp)
    end
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        local props = comp.entity:getComponent("ScriptComponent").properties
        if props:has("bulge_height") then
            self.bulge_height = props:get("bulge_height")
        end
        if props:has("bulge_height") then
            self.taper_radius = props:get("taper_radius")
        end
        if props:has("pinning") then
            self.pinning = props:get("pinning")
        end
        if props:has("bulge_radius") then
            self.bulge_radius = props:get("bulge_radius")
        end
        if props:has("bulge_center") then
            self.bulge_center = props:get("bulge_center")
        end
    end

    self:seekToTime(comp, self.curTime - self.startTime)
end

function Bulge:seekToTime(comp, time)
    self.pass0Camera.renderTexture = self.OutputTex
    self.pass0Material:setTex("mainTex", self.InputTex)
    self.pass0Material:setFloat("bulge_height", self.bulge_height)
    self.pass0Material:setFloat("cone_radius", self.taper_radius)
    self.pass0Material:setFloat("pinning", self.pinning)

    self.bulge_radius = Amaz.Vector2f(self.bulge_radius_x, self.bulge_radius_y)
    self.bulge_center = Amaz.Vector2f(self.bulge_center_x, self.bulge_center_y)
    self.pass0Material:setVec2("bulge_radius", self.bulge_radius)
    self.pass0Material:setVec2("bulge_center", self.bulge_center)
end

exports.Bulge = Bulge
return exports

