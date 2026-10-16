local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiThreshold = LumiThreshold or {}
LumiThreshold.__index = LumiThreshold
---@class LumiThreshold : ScriptComponent
---@field threshold number [UI(Range={0, 1}, Drag)]
---@field binary Bool
---@field grayrange number [UI(Range={0, 1}, Drag)]
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

function LumiThreshold.new(construct, ...)
    local self = setmetatable({}, LumiThreshold)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.threshold = 0.
    self.grayrange = 0.5
    self.binary = true

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function LumiThreshold:setEffectAttr(key, value, comp)
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

function LumiThreshold:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.camera = self.entity:searchEntity("BlitCamera"):getComponent("Camera")
    self.material = self.entity:searchEntity("BlitPass"):getComponent("MeshRenderer").material
end

function LumiThreshold:onUpdate(comp, deltaTime)
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end
    self.material:setTex("u_inputTexture", self.InputTex)
    self.material:setFloat("u_threshold", self.threshold)
    if self.binary then
        self.material:setFloat("u_binary", 1.0)
    else
        self.material:setFloat("u_binary", 0.0)
    end
    self.material:setFloat("u_grayrange", self.grayrange)
end

exports.LumiThreshold = LumiThreshold
return exports
