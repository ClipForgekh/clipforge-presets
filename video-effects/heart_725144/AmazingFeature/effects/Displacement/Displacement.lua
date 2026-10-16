local exports = exports or {}
local Displacement = Displacement or {}
Displacement.__index = Displacement
---@class Displacement : ScriptComponent
---@field size number
---@field quantity number
---@field complexity number
---@field evolution number
---@field cycle number
---@field offset_x number
---@field offset_y number
---@field type number
---@field fix_type number
---@field picture_scale number
---@field motion_tile_type number

function Displacement.new(construct, ...)
    local self = setmetatable({}, Displacement)
    if construct and Displacement.constructor then
        Displacement.constructor(self, ...)
    end

    self.size = 0
    self.quantity = 2
    self.complexity = 1
    self.evolution = 0
    self.cycle = 100
    self.offset_x = 0
    self.offset_y = 0
    self.type = 0
    self.fix_type = 0
    self.motion_tile_type = 0
    self.picture_scale = 1

    return self
end

function Displacement:constructor()
end

function Displacement:onUpdate(comp, detalTime)

    self.material:setFloat("u_Contrast", self.size);
    self.material:setVec2("u_Scale", Amaz.Vector2f(self.quantity, self.quantity));
    self.material:setFloat("u_Complexity", self.complexity);
    self.material:setFloat("u_Evolution", math.abs(self.evolution)/36.0);
    self.material:setFloat("u_Cycle", math.max(2, math.floor(self.cycle+0.5)));
    self.material:setVec2("u_Offset", Amaz.Vector2f(self.offset_x, self.offset_y))
    self.material:setFloat("u_type", self.type);
    self.material:setFloat("u_fix_type", self.fix_type)
    self.material:setFloat("motion_tile_type", self.motion_tile_type)
    self.material:setFloat("picture_scale", self.picture_scale)

end

function Displacement:onStart(comp)
    self.material = comp.entity:searchEntity("displacement"):getComponent("MeshRenderer").material
end

function Displacement:onEvent(sys, event)
    if self.first == nil then
        self.first = true
        self:start(sys)
    end
    if self.material == nil then 
        return
    end
    if event.type == Amaz.AppEventType.SetEffectIntensity then
        local intensity = event.args:get(1)
        if ("size" == event.args:get(0)) then
            self.size = intensity
            -- self.material:setFloat("u_Contrast", intensity);
        elseif ("quantity" == event.args:get(0)) then
            self.quantity = intensity
            -- self.scale:Set(intensity, intensity)
            -- self.material:setVec2("u_Scale", self.scale);
        elseif ("complexity" == event.args:get(0)) then
            self.complexity = intensity
            -- self.material:setFloat("u_Complexity", intensity);
        elseif ("evolution" == event.args:get(0)) then
            self.evolution = intensity
            -- self.material:setFloat("u_Evolution", math.abs(intensity)/36.0);
        elseif ("cycle" == event.args:get(0)) then
            self.cycle = intensity
            -- self.material:setFloat("u_Cycle", math.max(2, math.floor(intensity+0.5)));
        elseif ("type" == event.args:get(0)) then
            self.type = intensity
            -- self.material:setFloat("u_type", intensity);
        elseif ("fix_type" == event.args:get(0)) then
            self.fix_type = intensity
            -- self.material:setFloat("u_fix_type", intensity);
        elseif ("offset_x" == event.args:get(0)) then
            self.offset_x = intensity
            -- self.offset:Set(intensity, self.offset.y)
            -- self.material:setVec2("u_Offset", self.offset)
        elseif ("offset_y" == event.args:get(0)) then
            self.offset_y = intensity
            -- self.offset:Set(self.offset.x, intensity)
            -- self.material:setVec2("u_Offset", self.offset)
        elseif ("motion_tile_type" == event.args:get(0)) then
            self.motion_tile_type = intensity
            -- self.material:setFloat("motion_tile_type", self.offset)
        elseif ("picture_scale" == event.args:get(0)) then
            self.picture_scale = intensity
        end
    end
end

exports.Displacement = Displacement
return exports
