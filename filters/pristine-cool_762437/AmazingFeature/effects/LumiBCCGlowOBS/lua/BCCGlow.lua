local exports = exports or {}
local BCCGlow = BCCGlow or {}
BCCGlow.__index = BCCGlow
---@class BCCGlow: ScriptComponent
---@field show int [UI(Range={0, 2}, Slider)]
---@field glowChannels int [UI(Range={0, 6}, Slider)]
---@field glowThreshold double [UI(Range={0, 1}, Drag)]
---@field glowRadius double [UI(Range={0, 50}, Drag)]
---@field glowAspectRatio double [UI(Range={-1, 1}, Drag)]
---@field glowIntensity double [UI(Range={0, 3}, Drag)]
---@field delta double [UI(Range={0, 0.1}, Drag)]
--- @field step int [UI(Range={0, 10}, Slider)]
---@field combine string [UI(Option={"Screen", "Add", "Mult", "Difference", "Overlay", "Darken", "Lighten", "SoftLight", "HardLight", "Over", "Hue", "Saturation", "Color"})]
---@field colorA Color [UI(NoAlpha)]
---@field colorB Color [UI(NoAlpha)]
---@field edgeMode string [UI(Option={"Transparent", "Reflect"})]
---@field quality double [UI(Range={0, 1}, Slider)]
---@field InputTex Texture
---@field OutputTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local CombineModeName = {
    "Screen", "Add", "Mult", "Difference", "Overlay", "Darken", "Lighten", "SoftLight", "HardLight", "Over", "Hue", "Saturation", "Color"
}
setmetatable(CombineModeName, {__index = function(_, _) return CombineModeName[1] end})

local CombineModeIndex = {}
for index, value in ipairs(CombineModeName) do CombineModeIndex[value] = index - 1 end
setmetatable(CombineModeIndex, {
    __index = function(_, key)
        Amaz.LOGE(AE_EFFECT_TAG, "Unsupported combine mode: " .. key)
        return 0
    end
})

local EdgeMode = {
    Transparent = 0, Reflect = 1
}

function BCCGlow.new(construct, ...)
    local self = setmetatable({}, BCCGlow)

    self.InputTex = nil
    self.OutputTex = nil

    self.show = 2
    self.glowChannels = 0 -- 0: rgb, 1: red, 2: green, 3: blue, 4: alpha, 5: luminance, 6: brightness
    self.glowThreshold = 0.5
    self.delta = 0.075
    self.step = 0;
    self.glowRadius = 0
    self.glowAspectRatio = 0
    self.glowIntensity = 1
    self.colorA = Amaz.Color(0., 0., 0.)
    self.colorB = Amaz.Color(1., 1., 1.)
    self.combine = 'Add'
    self.edgeMode = 'Reflect'
    self.quality = 0.2

    return self
end

function BCCGlow:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.blurTex = comp.properties:get('blurTex')
    self.maskCamera = self.entity:searchEntity('MaskCamera'):getComponent('Camera')
    self.horzBlurCameraEntity = self.entity:searchEntity('HorzBlurCamera')
    self.vertBlurCameraEntity = self.entity:searchEntity('VertBlurCamera')
    self.blendCameraEntity = self.entity:searchEntity('BlendCamera')
    self.blendCamera = self.blendCameraEntity:getComponent('Camera')
    self.maskMat = self.entity:searchEntity('MaskPass'):getComponent('MeshRenderer').material
    self.horzBlurMat = self.entity:searchEntity('HorzBlurPass'):getComponent('MeshRenderer').material
    self.vertBlurMat = self.entity:searchEntity('VertBlurPass'):getComponent('MeshRenderer').material
    self.blendMat = self.entity:searchEntity('BlendPass'):getComponent('MeshRenderer').material
    self.horzBlurCamera = self.horzBlurCameraEntity:getComponent('Camera')
    self.vertBlurCamera = self.vertBlurCameraEntity:getComponent('Camera')
end

function BCCGlow:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end

    if 'combine' == key then
        local combine = CombineModeName[value + 1]
        _setEffectAttr(key, combine, comp)
    else
        _setEffectAttr(key, value, comp)
    end

end

function BCCGlow:onUpdate(comp, deltaTime)
    self.maskMat:setTex('u_InputTexture', self.InputTex)
    self.blendMat:setTex('u_InputTexture', self.InputTex)
    self.blendCamera.renderTexture = self.OutputTex

    local isShowResult = self.show ~= 0
    self.horzBlurCameraEntity.visible = isShowResult
    self.vertBlurCameraEntity.visible = isShowResult
    self.blendCameraEntity.visible = isShowResult
    if isShowResult then
        self.maskCamera.renderTexture = self.blurTex
    else
        self.maskCamera.renderTexture = self.OutputTex
    end

    if self.glowRadius == 0 then
        self.horzBlurCameraEntity.visible = false
        self.vertBlurCameraEntity.visible = false
    end

    -- Amaz.LOGS('tqh-log', self.maskMat:getTex('inputTexture').width .. 'x' .. self.maskMat:getTex('inputTexture').height)

    self.maskMat:setInt('u_GlowChannels', self.glowChannels)
    self.maskMat:setFloat('u_Threshold', self.glowThreshold)
    self.maskMat:setFloat('u_Delta', self.delta)
    self.maskMat:setInt('u_Step', self.step)

    local blurWidth = self.OutputTex.width
    local blurHeight = self.OutputTex.height
    local blurSize = math.max(math.min(self.quality * 1200, 360), 120)
    if blurWidth > blurSize then
        blurHeight = blurHeight / blurWidth * blurSize
        blurWidth = blurSize
    end
    local radius = self.glowRadius * (blurSize / 360)
    local radiusX = radius
    local radiusY = radius
    if self.glowAspectRatio > 0 then
        radiusY = radius * (1.0 - self.glowAspectRatio)
    elseif self.glowAspectRatio < 0 then
        radiusX = radius * (1.0 - math.abs(self.glowAspectRatio))
    end
    -- Amaz.LOGS('tqh-log radius: ', '' .. radius)
    self.horzBlurCamera.renderTexture.width  = math.floor(blurWidth)
    self.horzBlurCamera.renderTexture.height = math.floor(blurHeight)
    self.vertBlurCamera.renderTexture.width  = math.floor(blurWidth)
    self.vertBlurCamera.renderTexture.height = math.floor(blurHeight)
    self.horzBlurMat:setFloat('u_Radius', radiusX)
    self.vertBlurMat:setFloat('u_Radius', radiusY)
    self.horzBlurMat:setFloat("u_MaxRadius", 5 + math.floor(50 * self.quality))
    self.vertBlurMat:setFloat("u_MaxRadius", 5 + math.floor(50 * self.quality))
    local sigma = radius / 2.4
    sigma = math.pow(sigma, 2) * 2.0
    self.horzBlurMat:setFloat('u_Sigma', sigma)
    self.vertBlurMat:setFloat('u_Sigma', sigma)
    self.horzBlurMat:setInt('u_edgeMode', EdgeMode[self.edgeMode])
    self.vertBlurMat:setInt('u_edgeMode', EdgeMode[self.edgeMode])

    self.blendMat:setFloat('u_Intensity', self.glowIntensity)
    self.blendMat:setFloat('u_Threshold', self.glowThreshold)
    self.blendMat:setInt('u_GlowChannels', self.glowChannels)
    self.blendMat:setVec3('u_ColorA', Amaz.Vector3f(self.colorA.r, self.colorA.g, self.colorA.b))
    self.blendMat:setVec3('u_ColorB', Amaz.Vector3f(self.colorB.r, self.colorB.g, self.colorB.b))
    self.blendMat:setInt('u_Combine', CombineModeIndex[self.combine])
    self.blendMat:setInt('u_ShowMode', self.show)
    -- Amaz.LOGS('tqh-log combine: ', self.combine)
end

exports.BCCGlow = BCCGlow
return exports
