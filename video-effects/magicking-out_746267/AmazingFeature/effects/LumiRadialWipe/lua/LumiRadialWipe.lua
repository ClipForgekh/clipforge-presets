local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiRadialWipe = LumiRadialWipe or {}
LumiRadialWipe.__index = LumiRadialWipe
---@class LumiRadialWipe : ScriptComponent
---@field progress number [UI(Range={0.0, 1.0}, Drag)]
---@field rotation number [UI(Range={-360, 360.0}, Drag)]
---@field wipeCenter Vector2f [UI(Range={0.0, 1.0}, Slider)]
---@field wipeMode string [UI(Option={"ClockWise", "CounterClockWise", "Both"})]
---@field feather number [UI(Range={0.0, 1000.0}, Drag)]
---@field stride number [UI(Range={0.1, 1.0}, Drag)]
---@field quality number [UI(Range={0.1, 1.0}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

local WipeMode = {"ClockWise", "CounterClockWise", "Both"}
setmetatable(WipeMode, {__index = function(_, _) return WipeMode[1] end})
local WipeModeIndex = {}
for index, value in ipairs(WipeMode) do WipeModeIndex[value] = index - 1 end

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

function LumiRadialWipe.new(construct, ...)
    local self = setmetatable({}, LumiRadialWipe)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.quality = 0.5
    self.progress = 0.0
    self.rotation = 0.0
    self.feather = 0.0
    self.stride = 0.3
    self.angle = 0.0
    self.wipeCenter = Amaz.Vector2f(0.5, 0.5)
    self.wipeMode = "ClockWise"

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function LumiRadialWipe:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "wipeCenter" then
        value.y = 1.0 - value.y
        _setEffectAttr(key, value)
    elseif key == 'wipeMode' then
        local mode = "ClockWise"
        if value == 1 then
            mode = "CounterClockWise"
        elseif value == 2 then
            mode = "Both"
        end
        _setEffectAttr(key, mode)
    else
        _setEffectAttr(key, value)
    end
end

function LumiRadialWipe:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.matMask = comp.entity:searchEntity("PassMask"):getComponent(
                       "MeshRenderer").material
    self.camMask = comp.entity:searchEntity("CameraMask"):getComponent("Camera")

    self.matBlurX = comp.entity:searchEntity("PassBlurX"):getComponent(
                        "MeshRenderer").material
    self.camBlurX = comp.entity:searchEntity("CameraBlurX"):getComponent(
                        "Camera")
    self.matBlurY = comp.entity:searchEntity("PassBlurY"):getComponent(
                        "MeshRenderer").material
    self.camBlurY = comp.entity:searchEntity("CameraBlurY"):getComponent(
                        "Camera")

    self.matRadialWipe = comp.entity:searchEntity("PassRadialWipe")
                             :getComponent("MeshRenderer").material
    self.camRadialWipe = comp.entity:searchEntity("CameraRadialWipe")
                             :getComponent("Camera")

    local w = self.OutputTex.width
    local h = self.OutputTex.height
    self.tmp1 = createRenderTexture(width, height)
    self.tmp2 = createRenderTexture(width, height)
end

function LumiRadialWipe:onUpdate(comp, deltaTime)
    local w = self.OutputTex.width * self.quality
    local h = self.OutputTex.height * self.quality
    updateTexSize(self.tmp1, w, h)
    updateTexSize(self.tmp2, w, h)

    if self.tmp1 then
        self.camMask.renderTexture = self.tmp1
        self.camBlurY.renderTexture = self.tmp1
    end
    if self.tmp2 then self.camBlurX.renderTexture = self.tmp2 end
    if self.OutputTex then self.camRadialWipe.renderTexture = self.OutputTex end

    local rotation = -self.rotation
    local wipeCenter = Amaz.Vector2f(self.wipeCenter.x, 1. - self.wipeCenter.y)
    self.matMask:setFloat("u_progress", self.progress)
    self.matMask:setFloat("u_rotation", rotation)
    self.matMask:setInt("u_wipeMode", WipeModeIndex[self.wipeMode])
    self.matMask:setVec2("u_wipeCenter", wipeCenter)

    local steps = math.max(self.feather, 1)
    self.matBlurX:setTex("u_inputTex", self.tmp1)
    self.matBlurX:setInt("u_steps", steps)
    self.matBlurX:setFloat("u_stride", self.stride)
    self.matBlurX:setFloat("u_angle", 0.0)

    self.matBlurY:setTex("u_inputTex", self.tmp2)
    self.matBlurY:setInt("u_steps", steps)
    self.matBlurY:setFloat("u_stride", self.stride)
    self.matBlurY:setFloat("u_angle", 90.0)

    self.matRadialWipe:setTex("u_inputTexture", self.InputTex)
    self.matRadialWipe:setTex("u_mask", self.tmp1)
end

exports.LumiRadialWipe = LumiRadialWipe
return exports
