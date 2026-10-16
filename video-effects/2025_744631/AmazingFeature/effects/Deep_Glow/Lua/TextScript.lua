
local exports = exports or {}
local TextScript = TextScript or {}

---@class TextScript : ScriptComponent
---@field glow_intensity number
---@field radius number
TextScript.__index = TextScript

function TextScript.new()
    local self = {}
    setmetatable(self, TextScript)
    self.transform = {}
    self.glow_intensity = 0
    self.radius = 256
    self.first = true
    return self
end

---@param comp Component
function TextScript:onStart(comp)
    self.blendMat = comp.entity:searchEntity("Blend"):getComponent("MeshRenderer").material
    self.text = comp.entity:searchEntity("TestText"):getComponent("SDFText")
    self.first = true
end

---@param comp Component
---@param deltaTime number
function TextScript:onUpdate(comp, deltaTime)
    local props = comp.entity:getComponent("ScriptComponent").properties
    if props:has("radius") then
        self.radius = props:get("radius")
    end
    if props:has("glow_intensity") then
        self.glow_intensity = props:get("glow_intensity")
    end
    if self.first == true then
        local GlowBlurRoot1Lua = self.text.entity.scene:findEntityBy("GlowBlur_1"):getComponent("ScriptComponent")
        self.LuaObj1 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot1Lua:getScript())
        local GlowBlurRoot2Lua = self.text.entity.scene:findEntityBy("GlowBlur_2"):getComponent("ScriptComponent")
        self.LuaObj2 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot2Lua:getScript())
        local GlowBlurRoot3Lua = self.text.entity.scene:findEntityBy("GlowBlur_3"):getComponent("ScriptComponent")
        self.LuaObj3 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot3Lua:getScript())
        local GlowBlurRoot4Lua = self.text.entity.scene:findEntityBy("GlowBlur_4"):getComponent("ScriptComponent")
        self.LuaObj4 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot4Lua:getScript())
        local GlowBlurRoot5Lua = self.text.entity.scene:findEntityBy("GlowBlur_5"):getComponent("ScriptComponent")
        self.LuaObj5 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot5Lua:getScript())
        local GlowBlurRoot6Lua = self.text.entity.scene:findEntityBy("GlowBlur_6"):getComponent("ScriptComponent")
        self.LuaObj6 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot6Lua:getScript())
        local GlowBlurRoot7Lua = self.text.entity.scene:findEntityBy("GlowBlur_7"):getComponent("ScriptComponent")
        self.LuaObj7 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot7Lua:getScript())
        local GlowBlurRoot8Lua = self.text.entity.scene:findEntityBy("GlowBlur_8"):getComponent("ScriptComponent")
        self.LuaObj8 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot8Lua:getScript())
        self.first = false
    end
    self.blendMat:setVec4("u_TextColor", Amaz.Vector4f(self.text.textColor.x, self.text.textColor.y, self.text.textColor.z, 1.0))
    self.blendMat:setFloat("u_GlowIntensity", self.glow_intensity)
    local downSample = 1
    local downSample1 = 1
    local downSample2 = 1
    local downSample3 = math.max(math.min(self.radius / 128, 2.0), 1.0)
    local downSample4 = math.max(math.min(self.radius / 64, 4.0), 1.0)
    local downSample5 = math.max(self.radius / 32, 1.0)
    local downSample6 = math.max(self.radius / 16, 1.0)
    local downSample7 = math.max(self.radius / 8, 1.0)
    local downSample8 = math.max(self.radius / 4, 1.0)
    self.LuaObj1.Intensity = self.radius / 16 * 0.125
    self.LuaObj2.Intensity = self.radius / 16 * 0.25
    self.LuaObj3.Intensity = self.radius / 16 / downSample3 * 0.5
    self.LuaObj4.Intensity = self.radius / 16 / downSample4
    self.LuaObj5.Intensity = self.radius / downSample5 * 0.125
    self.LuaObj6.Intensity = self.radius / downSample6 * 0.25
    self.LuaObj7.Intensity = self.radius / downSample7 * 0.5
    self.LuaObj8.Intensity = self.radius / downSample8

    self.LuaObj1.DownSample = downSample1
    self.LuaObj2.DownSample = downSample2
    self.LuaObj3.DownSample = downSample3
    self.LuaObj4.DownSample = downSample4
    self.LuaObj5.DownSample = downSample5
    self.LuaObj6.DownSample = downSample6
    self.LuaObj7.DownSample = downSample7
    self.LuaObj8.DownSample = downSample8
end

---@param comp Component
---@param event Event
function TextScript:onEvent(comp, event)
end

exports.TextScript = TextScript
return exports

