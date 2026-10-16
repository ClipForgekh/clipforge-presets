local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiSoftUnmult = LumiSoftUnmult or {}
LumiSoftUnmult.__index = LumiSoftUnmult
---@class LumiSoftUnmult : ScriptComponent
---@field unmultIntensity number
---@field unmultLowerLimit number
---@field unmultUpperLimit number
---@field edgeLowerLimit number
---@field edgeUpperLimit number
---@field edgeBrightness number
---@field softEdge boolean
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

function LumiSoftUnmult.new(construct, ...)
    local self = setmetatable({}, LumiSoftUnmult)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.InputTex = nil
    self.OutputTex = nil

    self.unmultIntensity = 1
    self.unmultLowerLimit = 0
    self.unmultUpperLimit = 1

    self.edgeLowerLimit = 0.8
    self.edgeUpperLimit = 1.0
    self.edgeBrightness = 1.0
    self.softEdge = true

    self.rt0 = nil
    return self
end

function LumiSoftUnmult:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        self[_key] = _value
        if comp and comp.properties ~= nil then
            comp.properties:set(_key, _value)
        end
    end
    _setEffectAttr(key, value)
end

function LumiSoftUnmult:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    -- Amaz.LOGI(self.TAG, 'onStart')

    -- Use entity instead of scene 
    self.unmultCamera = self.entity:searchEntity("BlitCamera"):getComponent("Camera")
    self.unmultMat = self.entity:searchEntity("BlitPass"):getComponent("MeshRenderer").material
    self.edgeEntity = self.entity:searchEntity("EdgeCamera")
    self.edgeCamera = self.edgeEntity:getComponent("Camera")
    self.edgeMat = self.entity:searchEntity("EdgePass"):getComponent("MeshRenderer").material

    -- if temporary texture has the same dimensions as self.OutputTex, and need not persist, advised to used sharedRT
    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.rt0 = self.lumiSharedRt:get(0)
    end
end

function LumiSoftUnmult:onUpdate(comp, deltaTime)
    if self.rt0.width ~= self.OutputTex.width or self.rt0.height ~= self.OutputTex.height then
        self.rt0.width = self.OutputTex.width
        self.rt0.height = self.OutputTex.height
    end

    self.unmultIntensity = math.min(1.0, math.max(self.unmultIntensity, 0))
    self.unmultUpperLimit = math.min(1.0, math.max(self.unmultUpperLimit, 0))
    self.unmultLowerLimit = math.min(1.0, math.max(self.unmultLowerLimit, 0))
    self.edgeUpperLimit = math.min(1.0, math.max(self.edgeUpperLimit, 0))
    self.edgeLowerLimit = math.min(1.0, math.max(self.edgeLowerLimit, 0))
    if self.softEdge then
        self.edgeEntity.visible = true

        self.unmultCamera.inputTexture = self.InputTex
        self.unmultCamera.renderTexture = self.rt0
        self.unmultMat:setTex("u_inputTexture", self.InputTex)
        self.unmultMat:setFloat("u_intensity", self.unmultIntensity)
        self.unmultMat:setFloat("u_upperLimit", self.unmultUpperLimit)
        self.unmultMat:setFloat("u_lowerLimit", self.unmultLowerLimit)

        self.edgeCamera.inputTexture = self.rt0
        self.edgeCamera.renderTexture = self.OutputTex
        self.edgeMat:setTex("u_inputTexture", self.rt0)
        self.edgeMat:setFloat("brightness", 1.0)
        self.edgeMat:setFloat("upperLimit", self.edgeUpperLimit)
        self.edgeMat:setFloat("lowerLimit", self.edgeLowerLimit)
        self.edgeMat:setFloat("u_edgeBrightness", self.edgeBrightness)
    else
        self.edgeEntity.visible = false

        self.unmultCamera.inputTexture = self.InputTex
        self.unmultCamera.renderTexture = self.OutputTex
        self.unmultMat:setTex("u_inputTexture", self.InputTex)
        self.unmultMat:setFloat("u_intensity", self.unmultIntensity)
        self.unmultMat:setFloat("u_upperLimit", self.unmultUpperLimit)
        self.unmultMat:setFloat("u_lowerLimit", self.unmultLowerLimit)
    end
end

exports.LumiSoftUnmult = LumiSoftUnmult
return exports
