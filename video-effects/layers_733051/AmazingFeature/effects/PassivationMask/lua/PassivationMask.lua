local exports = exports or {}
local PassivationMask = PassivationMask or {}

---@class PassivationMask : ScriptComponent
---@field Size number
---@field Sharpen number
---@field InputTex Texture
---@field OutputTex Texture
PassivationMask.__index = PassivationMask

function PassivationMask.new()
    local self = {}
    setmetatable(self, PassivationMask)
    self.Size = 0
    self.Sharp = 0
    self.InputTex = nil
    self.OutputTex = nil
    return self
end

---@param comp Component
function PassivationMask:onStart(comp)
    self.edgeComp = comp.entity:searchEntity("Passivation_Edge"):getComponent("ScriptComponent")
    self.blur1Comp = comp.entity:searchEntity("Passivation_Blur1"):getComponent("ScriptComponent")
    self.blur2Comp = comp.entity:searchEntity("Passivation_Blur2"):getComponent("ScriptComponent")
    self.sharp = comp.entity:searchEntity("PassivationSharp"):getComponent("MeshRenderer").material
    self.camera = comp.entity:searchEntity("CameraPassivationSharp"):getComponent("Camera")
end


---@param comp Component
---@param deltaTime number
function PassivationMask:onUpdate(comp, deltaTime)
    if not self.edge then
        local script =  self.edgeComp:getScript()
        if script then
            self.edge = Amaz.ScriptUtils.getLuaObj(script)
        end
    end
    if not self.blur1 then
        local script =  self.blur1Comp:getScript()
        if script then
            self.blur1 = Amaz.ScriptUtils.getLuaObj(script)
        end
    end
    if not self.blur2 then
        local script =  self.blur2Comp:getScript()
        if script then
            self.blur2 = Amaz.ScriptUtils.getLuaObj(script)
        end
    end

    if self.edge then
        self.edge.InputTex = self.InputTex
    end
    if self.blur1 then
    end
    if self.blur2 then
        self.blur2.InputTex = self.InputTex
        self.blur2.intensity = self.Size
    end
    self.sharp:setFloat("quantity", self.Sharpen)
    self.sharp:setTex("u_albedo", self.InputTex)
    self.camera.renderTexture = self.OutputTex
end

exports.PassivationMask = PassivationMask
return exports
