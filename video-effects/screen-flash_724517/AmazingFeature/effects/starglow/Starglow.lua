local exports = exports or {}
local Starglow = Starglow or {}
Starglow.__index = Starglow
---@class Starglow: ScriptComponent
---@field streak_length number
---@field boost_light number
---@field threshould Vector2f
---@field colormapA_hightlight Color [UI(NoAlpha)]
---@field colormapA_midtones Color [UI(NoAlpha)]
---@field colormapA_shadows Color [UI(NoAlpha)]
---@field colormapB_hightlight Color [UI(NoAlpha)]
---@field colormapB_midtones Color [UI(NoAlpha)]
---@field colormapB_shadows Color [UI(NoAlpha)]
---@field right_individual_len number
---@field left_individual_len number
---@field source_alpha number [UI(Range={0, 1}, Slider)]
---@field starglow_alpha number [UI(Range={0, 1}, Slider)]


function Starglow.new(construct, ...)
    local self = setmetatable({}, Starglow)
    if construct and Starglow.constructor then
        Starglow.constructor(self, ...)
    end

    self.streak_length = 1
    self.boost_light = 1
    self.threshould = Amaz.Vector2f(0.7, 0.85)
    self.colormapA_hightlight = Amaz.Color(240/255,252/255,208/255)
    self.colormapA_midtones = Amaz.Color(192/255,248/255,120/255)
    self.colormapA_shadows = Amaz.Color(77/255,154/255,70/255)
    self.colormapB_hightlight = Amaz.Color(255/255,234/255,216/255)
    self.colormapB_midtones = Amaz.Color(246/255,179/255,53/255)
    self.colormapB_shadows = Amaz.Color(172/255,89/255,66/255)
    self.right_individual_len = 1
    self.left_individual_len = 1
    self.source_alpha = 1
    self.starglow_alpha = 1


    return self
end

function Starglow:constructor()
end

local function col2vec3(_col)
    return Amaz.Vector3f(_col.r, _col.g, _col.b)
end

function Starglow:onStart(comp)
    self.pick_lightness_mat = comp.entity:searchEntity("pick_lightness"):getComponent("MeshRenderer").material
    self.sg_blur_left_mat = comp.entity:searchEntity("sg_blur_left"):getComponent("MeshRenderer").material
    self.sg_blur_right_mat = comp.entity:searchEntity("sg_blur_right"):getComponent("MeshRenderer").material
    self.combine_mat = comp.entity:searchEntity("combine"):getComponent("MeshRenderer").material
end

function Starglow:updateMaterial()

    self.pick_lightness_mat:setVec2("threshould", self.threshould)

    self.sg_blur_left_mat:setVec3("colormap_hightlight", col2vec3(self.colormapA_hightlight))
    self.sg_blur_left_mat:setVec3("colormap_midtones",   col2vec3(self.colormapA_midtones))
    self.sg_blur_left_mat:setVec3("colormap_shadows",    col2vec3(self.colormapA_shadows))

    self.sg_blur_right_mat:setVec3("colormap_hightlight", col2vec3(self.colormapB_hightlight))
    self.sg_blur_right_mat:setVec3("colormap_midtones",   col2vec3(self.colormapB_midtones))
    self.sg_blur_right_mat:setVec3("colormap_shadows",    col2vec3(self.colormapB_shadows))


    self.sg_blur_left_mat:setFloat("individual_len", self.left_individual_len)
    self.sg_blur_right_mat:setFloat("individual_len", self.right_individual_len)

    self.combine_mat:setFloat("source_alpha", self.source_alpha)
    self.combine_mat:setFloat("starglow_alpha", self.starglow_alpha)
end

function Starglow:onUpdate(comp, detalTime)

    self:updateMaterial()
end

function Starglow:onEvent(sys, event)

end

exports.Starglow = Starglow
return exports
