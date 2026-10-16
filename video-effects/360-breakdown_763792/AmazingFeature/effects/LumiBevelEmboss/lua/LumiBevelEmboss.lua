local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiBevelEmboss = LumiBevelEmboss or {}
LumiBevelEmboss.__index = LumiBevelEmboss
---@class LumiBevelEmboss : ScriptComponent
---@field depth double [UI(Display="Depth", Range={-500, 500}, Drag)]
---@field width double [UI(Display="Width", Range={0, 250}, Drag)]
---@field soft double [UI(Display="Soft", Range={0, 50}, Drag)]
---@field lightYaw double [UI(Display="Light Source Yaw", Range={-360, 360}, Drag)]
---@field lightPitch double [UI(Display="Light Source Pitch", Range={0, 90}, Drag)]
---@field upperBlendMode string [UI(Option={"Normal", "Dissolve", "Darken", "Multiply", "Color Burn", "Linear Burn", "Darker Color", "Lighten", "Screen", "Color Dodge", "Linear Dodge", "Lighter Color", "Overlay", "Soft Light", "Hard Light", "Vivid Light", "Linear Light", "Pin Light", "Hard Mix", "Difference", "Exclusion", "Hue", "Saturation", "Color", "Luminosity", "Subtract", "Divide"})]
---@field upperColor Color [UI(NoAlpha)]
---@field upperAlpha double [UI(Range={0, 1}, Drag)]
---@field lowerBlendMode string [UI(Option={"Normal", "Dissolve", "Darken", "Multiply", "Color Burn", "Linear Burn", "Darker Color", "Lighten", "Screen", "Color Dodge", "Linear Dodge", "Lighter Color", "Overlay", "Soft Light", "Hard Light", "Vivid Light", "Linear Light", "Pin Light", "Hard Mix", "Difference", "Exclusion", "Hue", "Saturation", "Color", "Luminosity", "Subtract", "Divide"})]
---@field lowerColor Color [UI(NoAlpha)]
---@field lowerAlpha double [UI(Range={0, 1}, Drag)]
---@field quality number [UI(Range={0, 1}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local function createRenderTexture(width, height, filterMag, filterMin)
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = filterMag or Amaz.FilterMode.LINEAR
    rt.filterMin = filterMin or Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    return rt
end

local function updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

local function remap(value, min, max, newMin, newMax)
    return (value - min) / (max - min) * (newMax - newMin) + newMin
end

function LumiBevelEmboss.new(construct, ...)
    local self = setmetatable({}, LumiBevelEmboss)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.scale = 1
    self.depth = 100
    self.width = 50
    self.soft = 0
    self.lightYaw = 30
    self.lightPitch = 30
    self.upperBlendMode = "Normal"
    self.upperColor = Amaz.Color(1, 1, 1, 1)
    self.upperAlpha = 0.75
    self.lowerBlendMode = "Normal"
    self.lowerColor = Amaz.Color(0, 0, 0, 1)
    self.lowerAlpha = 0.75
    self.quality = 0.5
    self.InputTex = nil
    self.OutputTex = nil
    self.tmpTex = nil
    self.BLEND_QUERY = {[0]="Normal", "Dissolve", "Darken", "Multiply", "Color Burn", "Linear Burn", "Darker Color",
                        "Lighten", "Screen", "Color Dodge", "Linear Dodge", "Lighter Color", "Overlay", "Soft Light",
                        "Hard Light", "Vivid Light", "Linear Light", "Pin Light", "Hard Mix", "Difference",
                        "Exclusion", "Hue", "Saturation", "Color", "Luminosity", "Subtract", "Divide",
                       ["Normal"]=0, ["Dissolve"]=1, ["Darken"]=2, ["Multiply"]=3, ["Color Burn"]=4, ["Linear Burn"]=5,
                       ["Darker Color"]=6, ["Lighten"]=7, ["Screen"]=8, ["Color Dodge"]=9, ["Linear Dodge"]=10,
                       ["Lighter Color"]=11, ["Overlay"]=12, ["Soft Light"]=13, ["Hard Light"]=14, ["Vivid Light"]=15,
                       ["Linear Light"]=16, ["Pin Light"]=17, ["Hard Mix"]=18, ["Difference"]=19, ["Exclusion"]=20,
                       ["Hue"]=21, ["Saturation"]=22, ["Color"]=23, ["Luminosity"]=24, ["Subtract"]=25, ["Divide"]=26}
    self.SIGMA = 2.5
    self.MAX_SOFT = 20
    return self
end

function LumiBevelEmboss:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "upperBlendMode" or key == "lowerBlendMode" then
        value = math.max(0, math.min(value, #self.BLEND_QUERY))
        value = self.BLEND_QUERY[value]
        _setEffectAttr(key, value)
    elseif key == "quality" then
        value = remap(value, 0, 1, 0.25, 1)
        _setEffectAttr(key, value)
    else
        _setEffectAttr(key, value)
    end
end

function LumiBevelEmboss:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    -- Use entity instead of scene
    self.camInput = self.entity:searchEntity("CameraInput"):getComponent("Camera")
    self.camBlurX = self.entity:searchEntity("CameraBlurX"):getComponent("Camera")
    self.camBlurY = self.entity:searchEntity("CameraBlurY"):getComponent("Camera")
    self.camLight = self.entity:searchEntity("CameraLight"):getComponent("Camera")
    self.matInput = self.entity:searchEntity("PassInput"):getComponent("MeshRenderer").material
    self.matBlurX = self.entity:searchEntity("PassBlurX"):getComponent("MeshRenderer").material
    self.matBlurY = self.entity:searchEntity("PassBlurY"):getComponent("MeshRenderer").material
    self.matLight = self.entity:searchEntity("PassLight"):getComponent("MeshRenderer").material

    self.tmpTex = createRenderTexture(self.OutputTex.width, self.OutputTex.height)
end

function LumiBevelEmboss:onUpdate(comp, deltaTime)
    -- set the input and output textures to be displayed
    updateTexSize(self.tmpTex, self.OutputTex.width * self.quality, self.OutputTex.height * self.quality)
    if self.OutputTex then
        self.matInput:setTex("u_inputTexture", self.InputTex)
        self.camInput.renderTexture = self.tmpTex
        self.matBlurX:setTex("u_inputTexture", self.tmpTex)
        self.camBlurX.renderTexture = self.OutputTex
        self.matBlurY:setTex("u_inputTexture", self.OutputTex)
        self.camBlurY.renderTexture = self.tmpTex
        self.matLight:setTex("u_inputTexture", self.InputTex)
        self.matLight:setTex("u_depthTexture", self.tmpTex)
        self.camLight.renderTexture = self.OutputTex

        self.scale = self.OutputTex.width / (self.OutputTex.width + self.width * 2) * self.quality
        self.matInput:setFloat("u_scale", self.scale)
        self.matLight:setFloat("u_scale", self.scale)
    end

    local rz = math.rad(90 - self.lightYaw)
    local vx = math.cos(rz)
    local vy = math.sin(rz)
    local ru = math.rad(90 - self.lightPitch)
    local vz = math.sin(ru)
    local vs = math.cos(ru)
    local dir = Amaz.Vector3f(vx * vs, vy * vs, vz):normalize()
    self.matLight:setVec4("u_light", Amaz.Vector4f(dir.x, dir.y, dir.z, 0.0))
    local radius = self.width * self.scale * self.quality
    self.matBlurX:setFloat("u_radius", radius)
    self.matBlurX:setFloat("u_sigma", radius / self.SIGMA)
    self.matBlurX:setFloat("u_step", 1)
    self.matBlurY:setFloat("u_radius", radius)
    self.matBlurY:setFloat("u_sigma", radius / self.SIGMA)
    self.matBlurY:setFloat("u_step", 1)

    self.matLight:setFloat("u_depth", self.depth * self.scale)
    self.matLight:setFloat("u_soft", self.soft * self.scale)
    self.matLight:setInt("u_upperBlendMode", self.BLEND_QUERY[self.upperBlendMode])
    self.matLight:setVec4("u_upperColor", Amaz.Vector4f(self.upperColor.r, self.upperColor.g, self.upperColor.b, 1))
    self.matLight:setFloat("u_upperAlpha", self.upperAlpha)
    self.matLight:setInt("u_lowerBlendMode", self.BLEND_QUERY[self.lowerBlendMode])
    self.matLight:setVec4("u_lowerColor", Amaz.Vector4f(self.lowerColor.r, self.lowerColor.g, self.lowerColor.b, 1))
    self.matLight:setFloat("u_lowerAlpha", self.lowerAlpha)
end

exports.LumiBevelEmboss = LumiBevelEmboss
return exports
