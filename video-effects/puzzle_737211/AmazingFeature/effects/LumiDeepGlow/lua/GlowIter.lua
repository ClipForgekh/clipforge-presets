---@class GlowIter : ScriptComponent
---@field intensity number
---@field downSample number
---@field gammaValue number
---@field InputTex Texture
---@field BlurX Texture
---@field OutputTex Texture
local exports = exports or {}
local GlowIter = GlowIter or {}
GlowIter.__index = GlowIter

------------ class functions for ScriptComponent ------------
function GlowIter.new(construct, ...)
    local self = setmetatable({}, GlowIter)

    if construct and GlowIter.constructor then
        GlowIter.constructor(self, ...)
    end

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.intensity = 0.0
    self.downSample = 1
    self.gammaValue = 2.2

    self.InputTex = nil
    self.BlurX = nil
    self.OutputTex = nil

    return self
end

function GlowIter:constructor() end

function GlowIter:onStart(comp)
    self.camBlurX = comp.entity:searchEntity("CameraBlurX"):getComponent("Camera")
    self.matBlurX = comp.entity:searchEntity("PassBlurX"):getComponent("MeshRenderer").material
    self.camBlurY = comp.entity:searchEntity("CameraBlurY"):getComponent("Camera")
    self.matBlurY = comp.entity:searchEntity("PassBlurY"):getComponent("MeshRenderer").material

    self.props = comp.properties
end

function GlowIter:onUpdate(comp, detalTime)
    --if self.BlurX then self.camBlurX.renderTexture = self.props:get("BlurX") end
    --if self.OutputTex then self.camBlurY.renderTexture = self.OutputTex end

    local BlurX = self.props:get("BlurX")
    local OutputTex = self.props:get("OutputTex")

    self.camBlurX.renderTexture = BlurX
    self.camBlurY.renderTexture = OutputTex

    self.matBlurX:setTex("u_inputTex", self.props:get("InputTex"))
    self.matBlurY:setTex("u_inputTex", BlurX)
    local intensity = 0.0
    if self.props:get("intensity") then
        intensity = math.max(self.props:get("intensity"), 0.0)
    end
    self.matBlurX:enableMacro("GLOWSAMPLE", math.floor(intensity))
    self.matBlurY:enableMacro("GLOWSAMPLE", math.floor(intensity))
    self.matBlurX:setFloat("u_downSample", self.props:get("downSample"))
    self.matBlurY:setFloat("u_downSample", self.props:get("downSample"))
    self.matBlurX:setFloat("u_gammaValue", self.props:get("gammaValue"))
    self.matBlurY:setFloat("u_gammaValue", self.props:get("gammaValue"))
end

function GlowIter:onDestroy(comp) end

function GlowIter:updateMaterials(comp, detalTime) end

exports.GlowIter = GlowIter
return exports
