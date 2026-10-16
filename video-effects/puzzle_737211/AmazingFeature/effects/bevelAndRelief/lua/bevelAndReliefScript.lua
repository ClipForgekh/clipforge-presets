

local exports = exports or {}
local bevelAndReliefScript = bevelAndReliefScript or {}

---@class bevelAndReliefScript : ScriptComponent
---@field size number
---@field lightAngle number
---@field specOpacity number
---@field specColor Vector3f
---@field shadowOpacity number
---@field shadowColor Vector3f
---@field inputTexture Texture
---@field outputTexture Texture
bevelAndReliefScript.__index = bevelAndReliefScript

function bevelAndReliefScript.new()
    local self = {}
    setmetatable(self, bevelAndReliefScript)
    return self
end

---@param comp Component
function bevelAndReliefScript:onStart(comp)
    self.gaussianBlurScirpt = comp.entity.scene:findEntityBy("LuaGaussianBlur"):getComponent("ScriptComponent").properties
    self.innerLightMat = comp.entity.scene:findEntityBy("InnerLight"):getComponent("MeshRenderer").material
    self.innerLightCamera = comp.entity.scene:findEntityBy("Camera_InnerLight"):getComponent("Camera")
    self.alphaEncodeMat = comp.entity.scene:findEntityBy("AlphaEncode"):getComponent("MeshRenderer").material
    self.cameraAlphaEncode = comp.entity.scene:findEntityBy("Camera_AlphaEncode"):getComponent("Camera")
    self.props = comp.properties
    self.first = true
end

local getLuaObj = function(script_component)
    return Amaz.ScriptUtils.getLuaObj(script_component:getScript())
end

---@param comp Component
---@param deltaTime number
function bevelAndReliefScript:onUpdate(comp, deltaTime)
    local opacity = 1
    self.alphaEncodeMat:setTex("u_inputTex", self.props:get("inputTexture"))
    self.innerLightMat:setTex("u_inputTex", self.props:get("inputTexture"))
    self.innerLightCamera.renderTexture = self.props:get("outputTexture")
    self.innerLightMat:setFloat("u_lightDirection", self.props:get("lightAngle"))
    self.innerLightMat:setFloat("u_specOpacity", self.props:get("specOpacity") * opacity)
    self.innerLightMat:setFloat("u_shadowOpacity", self.props:get("shadowOpacity") * opacity)
    self.innerLightMat:setVec3("u_specColor", self.props:get("specColor"))
    self.innerLightMat:setVec3("u_shadowColor", self.props:get("shadowColor"))
    self.gaussianBlurScirpt:set("intensity", self.props:get("size") * 2.2)
    self.cameraAlphaEncode.renderTexture = self.props:get("outputTexture")
end

---@param comp Component
---@param event Event
function bevelAndReliefScript:onEvent(comp, event)
end

exports.bevelAndReliefScript = bevelAndReliefScript
return exports
