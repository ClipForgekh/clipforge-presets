local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiMercury = LumiMercury or {}
LumiMercury.__index = LumiMercury
---@class LumiMercury : ScriptComponent
---@field customTime double
---@field useCustomTime boolean
---@field radiusX double [UI(Range={0, 10}, Drag)]
---@field radiusY double [UI(Range={0, 10}, Drag)]
---@field producerPosition Vector2f
---@field velocity double [UI(Range={-10, 10}, Drag)]
---@field birthRate double [UI(Range={0, 200}, Drag)]
---@field longevity double [UI(Range={0, 20}, Drag)]
---@field producerLongevity double [UI(Range={0, 600}, Drag)]
---@field resistance double [UI(Range={0.01, 5}, Drag)]
---@field blobInfluence double [UI(Range={0, 5}, Drag)]
---@field blobBirthSize double [UI(Range={0, 2}, Drag)]
---@field blobDeathSize double [UI(Range={0, 2}, Drag)]
---@field blobRandomSize double [UI(Range={0, 2}, Drag)]
---@field blobInfluenceInOut boolean
---@field gravity double [UI(Range={-10, 10}, Drag)]
---@field extra double [UI(Range={0, 20}, Drag)]
---@field animationType string [UI(Option={"Explosive", "Twirly", "Vortex", "Fire", "Jet"})]
---@field strength double
---@field lightType string [UI(Option={"Point", "Distant"})]
---@field lightIntensity double
---@field lightHeight double
---@field lightPosition Vector2f
---@field lightDirection double
---@field roughness double
---@field metal double
---@field specular double
---@field ambient double
---@field InputTex Texture
---@field OutputTex Texture
---@field mapTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local AnimationTypeName = {"Explosive", "Twirly", "Vortex", "Fire", "Jet"}
setmetatable(AnimationTypeName, {
    __index = function(_, _)
        return AnimationTypeName[1]
    end
})
local AnimationTypeIndex = {}
for index, value in ipairs(AnimationTypeName) do
    AnimationTypeIndex[value] = index - 1
end
setmetatable(AnimationTypeIndex, {
    __index = function(_, key)
        Amaz.LOGE(AE_EFFECT_TAG, "Unsupported Animation Type: " .. key)
        return 0
    end
})

function LumiMercury.new(construct, ...)
    local self = setmetatable({}, LumiMercury)
    if construct and LumiMercury.constructor then
        LumiMercury.constructor(self, ...)
    end

    self.InputTex = nil
    self.OutputTex = nil

    self.curTime = 0
    self.radiusX = 0
    self.radiusY = 0
    self.producerPosition = Amaz.Vector2f(0.5, 0.5)
    self.birthRate = 40.0
    self.velocity = 0.5
    self.longevity = 2.0
    self.producerLongevity = 600.0
    self.resistance = 1.0
    self.blobInfluence = 1.0
    self.blobBirthSize = 0.08
    self.blobDeathSize = 0.25
    self.blobRandomSize = 1.0
    self.customTime = 1.0
    self.useCustomTime = false
    self.gravity = 3
    self.extra = 1.0
    self.animationType = "Explosive"
    self.strength = 0.6
    -- parameters for ‘Light’ group
    self.lightType = "Point"
    self.lightIntensity = 1.7
    self.lightHeight = 0.65
    self.lightPosition = Amaz.Vector2f(0.28, 0.31)
    self.blobInfluenceInOut = true
    self.lightDirection = 0.65
    -- parameters for ‘Shading’ group
    self.roughness = 0.025
    self.metal = 1
    self.specular = 0.1
    self.ambient = 1
    return self
end

function LumiMercury:constructor()
end

function LumiMercury:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.displacementCamera = self.entity:searchEntity("DisplacementCamera"):getComponent("Camera")
    self.mapMaterial = self.entity:searchEntity("MapPass"):getComponent("MeshRenderer").material
    self.displacementMaterial = self.entity:searchEntity("DisplacementPass"):getComponent("MeshRenderer").material
end

function LumiMercury:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end

    if 'lightType' == key then
        local type = "Point"
        if value == 1 then
            type = "Distant"
        end
        _setEffectAttr(key, type, comp)
    elseif 'animationType' == key then
        local type = AnimationTypeName[value + 1]
        _setEffectAttr(key, type, comp)
    else
        _setEffectAttr(key, value, comp)
    end

end

function LumiMercury:onUpdate(comp, deltaTime)
    self.displacementMaterial:setTex("u_inputTexture", self.InputTex)
    self.displacementCamera.renderTexture = self.OutputTex
    local w = self.OutputTex.width * 0.5
    local h = self.OutputTex.height * 0.5
    if self.mapTex.width ~= w or self.mapTex.height ~= h then
        self.mapTex.width = w
        self.mapTex.height = h
    end

    local time = self.curTime + deltaTime
    if time == nil or self.useCustomTime then
        time = self.customTime
    end
    self.mapMaterial:setFloat('u_time', time)
    self.mapMaterial:setFloat('u_radiusX', self.radiusX)
    self.mapMaterial:setFloat('u_radiusY', self.radiusY)
    self.mapMaterial:setVec2('u_producerPosition', self.producerPosition)
    self.mapMaterial:setFloat('u_birthRate', self.birthRate)
    self.mapMaterial:setFloat('u_longevity', self.longevity)
    self.mapMaterial:setFloat('u_producerLongevity', self.producerLongevity)
    self.mapMaterial:setFloat('u_resistance', self.resistance)
    self.mapMaterial:setFloat('u_velocity', self.velocity)
    self.mapMaterial:setFloat('u_extra', self.extra)
    self.mapMaterial:setFloat('u_blobInfluence', self.blobInfluence)
    self.mapMaterial:setFloat('u_blobBirthSize', self.blobBirthSize)
    self.mapMaterial:setFloat('u_blobDeathSize', self.blobDeathSize)
    self.mapMaterial:setFloat('u_blobRandomSize', self.blobRandomSize)
    self.mapMaterial:setInt('u_blobInfluenceInOut', self.blobInfluenceInOut and 1 or 0)
    self.mapMaterial:setFloat('u_gravity', self.gravity)
    self.mapMaterial:setInt('u_animationType', AnimationTypeIndex[self.animationType])

    local lightType = 0
    if self.lightType == "Distant" then
        lightType = 1
    end
    self.displacementMaterial:setFloat('u_strength', self.strength)
    self.displacementMaterial:setInt('u_lightType', lightType)
    self.displacementMaterial:setFloat('u_lightIntensity', self.lightIntensity)
    self.displacementMaterial:setFloat('u_lightHeight', self.lightHeight)
    self.displacementMaterial:setVec2('u_lightPosition', self.lightPosition)
    self.displacementMaterial:setFloat('u_lightDirection', 90 - self.lightDirection)
    self.displacementMaterial:setFloat('u_roughness', self.roughness)
    self.displacementMaterial:setFloat('u_metal', self.metal)
    self.displacementMaterial:setFloat('u_specular', self.specular)
    self.displacementMaterial:setFloat('u_ambient', self.ambient)
end

exports.LumiMercury = LumiMercury
return exports
