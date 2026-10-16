
local exports = exports or {}
local DeepGlow = DeepGlow or {}

---@class DeepGlow : ScriptComponent
---@field Intensity number
---@field Radius number
---@field InputTex Texture
---@field OutputTex Texture
DeepGlow.__index = DeepGlow

function DeepGlow.new()
    local self = setmetatable({}, DeepGlow)
    self.Intensity = 0
    self.Radius = 256
    self.first = true
    return self
end

---@param comp Component
function DeepGlow:onStart (comp)
    self.blendMat = comp.entity:searchEntity("Blend"):getComponent("MeshRenderer").material
    self.inputMat = comp.entity:searchEntity("GlowBlur_1"):searchEntity("GlowBlurH"):getComponent("MeshRenderer").material
    self.outputCam = comp.entity:searchEntity("Camera_Blend"):getComponent("Camera")
    self.first = true
end

---@param comp Component
---@param deltaTime number
function DeepGlow:onUpdate(comp, deltaTime)
    if self.first == true then
        local GlowBlurRoot1Lua = comp.entity:searchEntity("GlowBlur_1"):getComponent("ScriptComponent")
        self.LuaObj1 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot1Lua:getScript())
        local GlowBlurRoot2Lua = comp.entity:searchEntity("GlowBlur_2"):getComponent("ScriptComponent")
        self.LuaObj2 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot2Lua:getScript())
        local GlowBlurRoot3Lua = comp.entity:searchEntity("GlowBlur_3"):getComponent("ScriptComponent")
        self.LuaObj3 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot3Lua:getScript())
        local GlowBlurRoot4Lua = comp.entity:searchEntity("GlowBlur_4"):getComponent("ScriptComponent")
        self.LuaObj4 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot4Lua:getScript())
        local GlowBlurRoot5Lua = comp.entity:searchEntity("GlowBlur_5"):getComponent("ScriptComponent")
        self.LuaObj5 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot5Lua:getScript())
        local GlowBlurRoot6Lua = comp.entity:searchEntity("GlowBlur_6"):getComponent("ScriptComponent")
        self.LuaObj6 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot6Lua:getScript())
        local GlowBlurRoot7Lua = comp.entity:searchEntity("GlowBlur_7"):getComponent("ScriptComponent")
        self.LuaObj7 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot7Lua:getScript())
        local GlowBlurRoot8Lua = comp.entity:searchEntity("GlowBlur_8"):getComponent("ScriptComponent")
        self.LuaObj8 = Amaz.ScriptUtils.getLuaObj(GlowBlurRoot8Lua:getScript())
        self.first = false
    end
    self.blendMat:setFloat("u_GlowIntensity", self.Intensity)
    local downSample = 1
    local downSample1 = 1
    local downSample2 = 1
    local downSample3 = math.max(math.min(self.Radius / 128, 2.0), 1.0)
    local downSample4 = math.max(math.min(self.Radius / 64, 4.0), 1.0)
    local downSample5 = math.max(self.Radius / 32, 1.0)
    local downSample6 = math.max(self.Radius / 16, 1.0)
    local downSample7 = math.max(self.Radius / 8, 1.0)
    local downSample8 = math.max(self.Radius / 4, 1.0)
    self.LuaObj1.Intensity = self.Radius / 16 * 0.125
    self.LuaObj2.Intensity = self.Radius / 16 * 0.25
    self.LuaObj3.Intensity = self.Radius / 16 / downSample3 * 0.5
    self.LuaObj4.Intensity = self.Radius / 16 / downSample4
    self.LuaObj5.Intensity = self.Radius / downSample5 * 0.125
    self.LuaObj6.Intensity = self.Radius / downSample6 * 0.25
    self.LuaObj7.Intensity = self.Radius / downSample7 * 0.5
    self.LuaObj8.Intensity = self.Radius / downSample8

    self.LuaObj1.DownSample = downSample1
    self.LuaObj2.DownSample = downSample2
    self.LuaObj3.DownSample = downSample3
    self.LuaObj4.DownSample = downSample4
    self.LuaObj5.DownSample = downSample5
    self.LuaObj6.DownSample = downSample6
    self.LuaObj7.DownSample = downSample7
    self.LuaObj8.DownSample = downSample8

    self.inputMat:setTex("u_InputTex", self.InputTex)
    self.outputCam.renderTexture = self.OutputTex
end


exports.DeepGlow = DeepGlow
return exports
