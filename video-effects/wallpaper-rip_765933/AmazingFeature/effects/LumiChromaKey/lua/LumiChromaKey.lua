local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiChromaKey = LumiChromaKey or {}
LumiChromaKey.__index = LumiChromaKey
---@class LumiChromaKey : ScriptComponent
---@field keyColor Color [UI(NoAlpha)]
---@field threshold number [UI(Range={0.0,1.0},Slider)]
---@field smoothness number [UI(Range={0.0,1.0},Slider)]
---@field shadow number [UI(Range={0.0,1.0},Slider)]
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

function LumiChromaKey.new(construct, ...)
    local self = setmetatable({}, LumiChromaKey)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.keyColor = Amaz.Color(1, 0, 0)
    self.threshold = 0.0
    self.smoothness = 0.0
    self.shadow = 0.0
    self.InputTex = nil
    self.OutputTex = nil
    self.chromaTex = nil
    self.blurTex = nil
    self.blurYTex = nil

    return self
end

function LumiChromaKey:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        self[_key] = _value
        if comp and comp.properties ~= nil then
            comp.properties:set(_key, _value)
        end
    end

    _setEffectAttr(key, value)
end

function LumiChromaKey:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')
    self.first = true

    -- Use entity instead of scene 
    self.chromaCamera = comp.entity:searchEntity("ChromaCamera"):getComponent("Camera")
    self.chromaMaterial = comp.entity:searchEntity("ChromaPass"):getComponent("MeshRenderer").material

    self.blurCamera = comp.entity:searchEntity("BlurCamera"):getComponent("Camera")
    self.blurMaterial = comp.entity:searchEntity("BlurPass"):getComponent("MeshRenderer").material

    self.blurYCamera = comp.entity:searchEntity("BlurYCamera"):getComponent("Camera")
    self.blurYMaterial = comp.entity:searchEntity("BlurYPass"):getComponent("MeshRenderer").material

    self.resultCamera = comp.entity:searchEntity("ResultCamera"):getComponent("Camera")
    self.resultMaterial = comp.entity:searchEntity("ResultPass"):getComponent("MeshRenderer").material

    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.chromaTex = self.lumiSharedRt:get(0)
        self.blurTex = self.lumiSharedRt:get(1)
        self.blurYTex = self.lumiSharedRt:get(2)
    end

end

function LumiChromaKey:onUpdate(comp, deltaTime)
    if not self.OutputTex or not self.InputTex then
        return
    end

    setRenderTexture(self.chromaCamera, self.chromaTex)
    setRenderTexture(self.blurCamera, self.blurTex)
    setRenderTexture(self.blurYCamera, self.blurYTex)
    setRenderTexture(self.resultCamera, self.OutputTex)

    local blurWidth = self.OutputTex.width
    local blurHeight = self.OutputTex.height
    local blurSize = 360

    if blurWidth > blurSize then
        blurHeight = blurHeight / blurWidth * blurSize
        blurWidth = blurSize
    end

    local radius = self.smoothness * 10.0 * blurSize / 360
    local sigma = radius / 2.4
    sigma = math.pow(sigma, 2) * 2.0

    self.chromaMaterial:setTex("u_inputTexture", self.InputTex)
    self.chromaMaterial:setVec3("u_keyColor", Amaz.Vector3f(self.keyColor.r, self.keyColor.g, self.keyColor.b))
    self.chromaMaterial:setFloat("u_threshold", self.threshold)
    self.chromaMaterial:setFloat("u_smoothness", self.smoothness)
    self.chromaMaterial:setFloat("u_inputShadow", self.shadow)

    self.blurMaterial:setTex("u_inputTexture", self.chromaTex)
    self.blurMaterial:setFloat("u_smoothness", self.smoothness * 1.1)

    self.blurYMaterial:setTex("u_inputTexture", self.chromaTex)
    self.blurYMaterial:setTex("u_smoothTexture", self.blurTex)
    self.blurYMaterial:setFloat("u_smoothness", self.smoothness * 1.1)

    self.resultMaterial:setTex("u_inputTexture", self.InputTex)
    self.resultMaterial:setTex("u_blurTexture", self.blurYTex)
end

exports.LumiChromaKey = LumiChromaKey
return exports
