---@class LumiScaleWipe : ScriptComponent
---@field stretch number [UI(Range={-100, 100}, Drag)]
---@field center Vector2f
---@field direction number [UI(Range={-360, 360}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture
local exports = exports or {}
local LumiScaleWipe = LumiScaleWipe or {}
LumiScaleWipe.__index = LumiScaleWipe

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function LumiScaleWipe.new(construct, ...)
    local self = setmetatable({}, LumiScaleWipe)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.InputTex = nil
    self.OutputTex = nil

    self.stretch = 0.0
    self.center = Amaz.Vector2f(0.5, 0.5)
    self.direction = 0

    return self
end

function LumiScaleWipe:setEffectAttr(key, value, comp)
    self[key] = value
    comp.properties:set(key, value)
end

function LumiScaleWipe:onStart(comp)
    self.scene = comp.entity.scene
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.scaleWipe = self.entity:searchEntity("scaleWipe"):getComponent("MeshRenderer").material
    self.camera = self.entity:searchEntity("CameraScaleWipe"):getComponent("Camera")
end

function LumiScaleWipe:updateMaterial(comp, dt)
    if not self.OutputTex then
        return
    end

    local w = self.OutputTex.width
    local h = self.OutputTex.height
    local b = math.sqrt(w * w + h * h)
    w = w / b
    h = h / b

    local r
    if self.stretch >= 0 then
        r = math.rad(90 - self.direction)
    else
        r = math.rad(270 - self.direction)
    end
    local rx = math.cos(r)
    local ry = math.sin(r)

    self.scaleWipe:setVec2("u_size", Amaz.Vector2f(w, h))
    self.scaleWipe:setVec2("u_center", Amaz.Vector2f(w * self.center.x, h * self.center.y))
    self.scaleWipe:setVec2("u_orientation", Amaz.Vector2f(rx, ry))
    self.scaleWipe:setFloat("u_xscale", self.xscale)
    self.scaleWipe:setFloat("u_stretch", math.abs(self.stretch))
    self.scaleWipe:setTex("u_inputTex", self.InputTex)
    self.camera.renderTexture = self.OutputTex
end

exports.LumiScaleWipe = LumiScaleWipe
return exports
