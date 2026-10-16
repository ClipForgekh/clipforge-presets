local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiDistortChroma = LumiDistortChroma or {}
LumiDistortChroma.__index = LumiDistortChroma
---@class LumiDistortChroma : ScriptComponent
---@field quality double [UI(Range={0.1, 1.0}, Drag)]
---@field amount double [UI(Range={-100.0, 100.0}, Drag)]
---@field blurLens int [UI(Range={0, 1000}, Slider)]
---@field stride number [UI(Range={0.0, 1.}, Drag)]
---@field rotateWarpDir number [UI(Range={-360.0, 360.0}, Drag)]
---@field warpRed number [UI(Range={-3.0, 3.0}, Drag)]
---@field warpBlue number [UI(Range={-3.0, 3.0}, Drag)]
---@field amountRelX number [UI(Range={0., 5}, Drag)]
---@field amountRelY number [UI(Range={0., 5}, Drag)]
---@field steps int [UI(Range={3, 100}, Drag)]
---@field color1 Color [UI(NoAlpha)]
---@field color2 Color [UI(NoAlpha)] 
---@field color3 Color [UI(NoAlpha)]
---@field mix number [UI(Range={0.0, 1.0}, Drag)]
---@field wrapModeX int [UI(Range={0, 2}, Drag)]
---@field wrapModeY int [UI(Range={0, 2}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

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
    if rt == nil or width <= 0 or height <= 0 then return end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

function LumiDistortChroma.new(construct, ...)
    local self = setmetatable({}, LumiDistortChroma)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.quality = 0.5
    self.amount = 1.
    self.blurLens = 1.

    self.rotateWarpDir = 0.

    self.amountRelX = 1
    self.amountRelY = 1

    self.warpRed = 0.5
    self.warpBlue = 0.5

    self.steps = 8
    self.wrapModeX = 0
    self.wrapModeY = 0

    self.color1 = Amaz.Color(1., 0., 0.)
    self.color2 = Amaz.Color(0., 1., 0.)
    self.color3 = Amaz.Color(0., 0., 1.)
    self.mix = 1.

    self.stride = 1.
    self.angle = 0

    self.InputTex = nil
    self.tmpTex = nil
    self.tmpTex2 = nil
    self.OutputTex = nil

    return self
end

function LumiDistortChroma:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        if self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    _setEffectAttr(key, value)
end

function LumiDistortChroma:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.matLens = comp.entity:searchEntity("PassLens"):getComponent(
                       "MeshRenderer").material
    self.camLens = comp.entity:searchEntity("CameraLens"):getComponent("Camera")

    self.matBlurX = comp.entity:searchEntity("PassBlurX"):getComponent(
                        "MeshRenderer").material
    self.camBlurX = comp.entity:searchEntity("CameraBlurX"):getComponent(
                        "Camera")

    self.matBlurY = comp.entity:searchEntity("PassBlurY"):getComponent(
                        "MeshRenderer").material
    self.camBlurY = comp.entity:searchEntity("CameraBlurY"):getComponent(
                        "Camera")

    self.matBlurX2 = comp.entity:searchEntity("PassBlurX_2"):getComponent(
                         "MeshRenderer").material
    self.camBlurX2 = comp.entity:searchEntity("CameraBlurX_2"):getComponent(
                         "Camera")

    self.matBlurY2 = comp.entity:searchEntity("PassBlurY_2"):getComponent(
                         "MeshRenderer").material
    self.camBlurY2 = comp.entity:searchEntity("CameraBlurY_2"):getComponent(
                         "Camera")

    self.matDistort = comp.entity:searchEntity("PassDistort"):getComponent(
                          "MeshRenderer").material
    self.camDistort = comp.entity:searchEntity("CameraDistort"):getComponent(
                          "Camera")

    local w = self.OutputTex.width
    local h = self.OutputTex.height
    self.tmpTex = createRenderTexture(w, h)
    self.tmpTex2 = createRenderTexture(w, h)
end

function LumiDistortChroma:onUpdate(comp, deltaTime)
    -- Tex Settings
    local width = self.OutputTex.width * self.quality
    local height = self.OutputTex.height * self.quality
    updateTexSize(self.tmpTex, width, height)
    updateTexSize(self.tmpTex2, width, height)

    if self.tmpTex then
        self.camLens.renderTexture = self.tmpTex
        self.camBlurY.renderTexture = self.tmpTex
        self.camBlurY2.renderTexture = self.tmpTex
    end

    if self.tmpTex2 then
        self.camBlurX.renderTexture = self.tmpTex2
        self.camBlurX2.renderTexture = self.tmpTex2
    end

    if self.OutputTex then self.camDistort.renderTexture = self.OutputTex end

    self.matLens:setTex("u_inputTex", self.InputTex)
    self.matBlurX:setTex("u_inputTex", self.tmpTex)
    self.matBlurY:setTex("u_inputTex", self.tmpTex2)
    self.matBlurX2:setTex("u_inputTex", self.tmpTex)
    self.matBlurY2:setTex("u_inputTex", self.tmpTex2)
    self.matDistort:setTex("u_inputTex", self.InputTex)
    self.matDistort:setTex("u_lens", self.tmpTex)

    -- Blur Parms
    local steps = math.max(self.blurLens, 1)
    local stride = self.stride / 2

    self.matBlurX:setInt("u_steps", steps)
    self.matBlurX:setFloat("u_stride", stride)
    self.matBlurX:setFloat("u_angle", self.angle)
    self.matBlurY:setInt("u_steps", steps)
    self.matBlurY:setFloat("u_stride", stride)
    self.matBlurY:setFloat("u_angle", self.angle + 90)
    self.matBlurX2:setInt("u_steps", steps)
    self.matBlurX2:setFloat("u_stride", stride * 4)
    self.matBlurX2:setFloat("u_angle", self.angle)
    self.matBlurY2:setInt("u_steps", steps)
    self.matBlurY2:setFloat("u_stride", stride * 4)
    self.matBlurY2:setFloat("u_angle", self.angle + 90)

    local warpAmt = math.sqrt(math.abs(self.amount) * 18.18) *
                        (self.amount > 0 and 1 or -1)

    -- Distort Parms
    self.matDistort:setFloat("u_amount", warpAmt)
    self.matDistort:setFloat("u_rotateWarpDir", self.rotateWarpDir)
    self.matDistort:setFloat("u_warpRed", self.warpRed)
    self.matDistort:setFloat("u_warpBlue", self.warpBlue)
    self.matDistort:setFloat("u_amountRelX", self.amountRelX)
    self.matDistort:setFloat("u_amountRelY", self.amountRelY)
    self.matDistort:setInt("u_steps", self.steps)
    self.matDistort:setInt("u_wrapModeX", math.floor(self.wrapModeX))
    self.matDistort:setInt("u_wrapModeY", math.floor(self.wrapModeY))

    self.matDistort:setVec3("u_color1", Amaz.Vector3f(self.color1.r,
                                                      self.color1.g,
                                                      self.color1.b))
    self.matDistort:setVec3("u_color2", Amaz.Vector3f(self.color2.r,
                                                      self.color2.g,
                                                      self.color2.b))
    self.matDistort:setVec3("u_color3", Amaz.Vector3f(self.color3.r,
                                                      self.color3.g,
                                                      self.color3.b))
    self.matDistort:setFloat("u_mix", self.mix)

end

exports.LumiDistortChroma = LumiDistortChroma
return exports
