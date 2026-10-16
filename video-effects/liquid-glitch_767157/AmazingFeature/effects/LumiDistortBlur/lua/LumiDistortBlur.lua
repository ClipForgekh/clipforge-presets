local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiDistortBlur = LumiDistortBlur or {}
LumiDistortBlur.__index = LumiDistortBlur

---@class LumiDistortBlur : ScriptComponent
---@field quality double [UI(Range={0.1, 1.0}, Drag)]
---@field blurAmount double [UI(Range={0, 100.0}, Drag)]
---@field blurInterval double [UI(Range={0.1, 1.0}, Drag)]
---@field warpAmount double [UI(Range={-100, 100})]
---@field blurLens number [UI(Range={0, 1000}, Drag)]
---@field stride number [UI(Range={0.1, 2.0}, Drag)]
---@field rotateWarpDir number [UI(Range={-360.0, 360.0}, Drag)]
---@field amountRelX number [UI(Range={0, 100.0}, Drag)]
---@field amountRelY number [UI(Range={0, 100.0}, Drag)]
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
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

local function setRenderTexture(camera, rt)
    if rt then
        camera.renderTexture = rt
    end
end

local function sq(x)
    return x * x
end

function LumiDistortBlur.new(construct, ...)
    local self = setmetatable({}, LumiDistortBlur)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.blurAmount = 1.
    self.blurInterval = 0.5
    self.quality = 0.5
    self.warpAmount = 1.

    self.blurLens = 0.
    self.rotateWarpDir = 0.

    self.amountRelX = 1
    self.amountRelY = 1

    self.wrapModeX = 0
    self.wrapModeY = 0

    self.stride = 1.
    self.angle = 0

    self.InputTex = nil
    self.tmpTex = nil
    self.tmpTex2 = nil
    self.OutputTex = nil

    return self
end

function LumiDistortBlur:setEffectAttr(key, value, comp)
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

function LumiDistortBlur:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.matLens = comp.entity:searchEntity("PassLens"):getComponent("MeshRenderer").material
    self.camLens = comp.entity:searchEntity("CameraLens"):getComponent("Camera")
    self.matBlurX = comp.entity:searchEntity("PassBlurX"):getComponent("MeshRenderer").material
    self.camBlurX = comp.entity:searchEntity("CameraBlurX"):getComponent("Camera")
    self.matBlurY = comp.entity:searchEntity("PassBlurY"):getComponent("MeshRenderer").material
    self.camBlurY = comp.entity:searchEntity("CameraBlurY"):getComponent("Camera")
    self.matBlurX2 = comp.entity:searchEntity("PassBlurX_2"):getComponent("MeshRenderer").material
    self.camBlurX2 = comp.entity:searchEntity("CameraBlurX_2"):getComponent("Camera")
    self.matBlurY2 = comp.entity:searchEntity("PassBlurY_2"):getComponent("MeshRenderer").material
    self.camBlurY2 = comp.entity:searchEntity("CameraBlurY_2"):getComponent("Camera")
    self.matDistort = comp.entity:searchEntity("PassDistortBlur"):getComponent("MeshRenderer").material
    self.camDistort = comp.entity:searchEntity("CameraDistortBlur"):getComponent("Camera")

    local w = self.OutputTex.width
    local h = self.OutputTex.height
    self.tmpTex = createRenderTexture(w, h)
    self.tmpTex2 = createRenderTexture(w, h)
end

function LumiDistortBlur:onUpdate(comp, deltaTime)
    -- Tex Settings
    local w = self.OutputTex.width * self.quality
    local h = self.OutputTex.height * self.quality
    updateTexSize(self.tmpTex, w, h)
    updateTexSize(self.tmpTex2, w, h)

    setRenderTexture(self.camLens, self.tmpTex)
    setRenderTexture(self.camBlurY, self.tmpTex)
    setRenderTexture(self.camBlurY2, self.tmpTex)
    setRenderTexture(self.camBlurX, self.tmpTex2)
    setRenderTexture(self.camBlurX2, self.tmpTex2)
    setRenderTexture(self.camDistort, self.OutputTex)

    self.matLens:setTex("u_inputTex", self.InputTex)
    self.matBlurX:setTex("u_inputTex", self.tmpTex)
    self.matBlurY:setTex("u_inputTex", self.tmpTex2)
    self.matBlurX2:setTex("u_inputTex", self.tmpTex)
    self.matBlurY2:setTex("u_inputTex", self.tmpTex2)
    self.matDistort:setTex("u_inputTex", self.InputTex)
    self.matDistort:setTex("u_lens", self.tmpTex)

    -- Blur Parms
    local steps = math.max(self.blurLens, 1)
    local stride = self.stride * 0.5 -- Optimize division
    local minDim = math.min(w, h)
    local invMinDim = 720.0 / minDim -- Cache division
    local ratio = Amaz.Vector2f(invMinDim * w, invMinDim * h)
    local invRatioX = 1.0 / ratio.x
    local invRatioY = 1.0 / ratio.y
    local horizontalDir = Amaz.Vector2f(invRatioX, 0.0)
    local verticalDir = Amaz.Vector2f(0.0, invRatioY)

    self.matBlurX:setFloat("u_steps", steps)
    self.matBlurX:setFloat("u_stride", stride)
    self.matBlurX:setVec2("u_dir", horizontalDir)
    self.matBlurY:setFloat("u_steps", steps)
    self.matBlurY:setFloat("u_stride", stride)
    self.matBlurY:setVec2("u_dir", verticalDir)
    self.matBlurX2:setFloat("u_steps", steps)
    self.matBlurX2:setFloat("u_stride", stride * 4)
    self.matBlurX2:setVec2("u_dir", horizontalDir)
    self.matBlurY2:setFloat("u_steps", steps)
    self.matBlurY2:setFloat("u_stride", stride * 4)
    self.matBlurY2:setVec2("u_dir", verticalDir)

    -- Distort Parms
    local blurAmt = math.sqrt(sq(2 + self.blurAmount) - sq(2))
    local warpAmt = math.sqrt(math.abs(self.warpAmount) * 18.18) * (self.warpAmount > 0 and 1 or -1)
    self.matDistort:setFloat("u_warpAmount", warpAmt)
    self.matDistort:setFloat("u_blurAmount", blurAmt)
    self.matDistort:setFloat("u_blurInterval", math.max(self.blurInterval, 0.1))
    self.matDistort:setInt("u_wrapModeX", math.floor(self.wrapModeX))
    self.matDistort:setInt("u_wrapModeY", math.floor(self.wrapModeY))
    -- Cache trigonometric calculations
    local angleRad = math.rad(self.rotateWarpDir)
    local rotationSinCos = Amaz.Vector2f(math.sin(angleRad), math.cos(angleRad))
    local amountRel = Amaz.Vector2f(self.amountRelX, self.amountRelY)
    self.matDistort:setVec2("u_screenRatio", ratio)
    self.matDistort:setVec2("u_rotationSinCos", rotationSinCos)
    self.matDistort:setVec2("u_amountRel", amountRel)
end

exports.LumiDistortBlur = LumiDistortBlur
return exports
