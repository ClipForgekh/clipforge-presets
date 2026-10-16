--@input float curTime = 0.0{"widget":"slider","min":0,"max":3.0}

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript


function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.width = 0
    self.height = 0
    return self
end

function SeekModeScript:constructor()

end

function SeekModeScript:onUpdate(comp, detalTime)
    --
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("curTime") then
    --     self:seekToTime(comp, props:get("curTime") - self.startTime)
    -- end
    --
    --self.curTime =self.curTime + detalTime
    self:seekToTime(comp, self.curTime - self.startTime)
end

function SeekModeScript:onStart(comp)
    self.EASpeed = 1.0
    self.animSeqCom1 = comp.entity.scene:findEntityBy("Pass1"):getComponent("AnimSeqComponent")
    self.animSeqCom2 = comp.entity.scene:findEntityBy("SeekModeScript"):getComponent("AnimSeqComponent")
    -- self.pass0Material = comp.entity.scene:findEntityBy("Pass0"):getComponent("MeshRenderer").material
    self.pass1Material = comp.entity.scene:findEntityBy("Pass1"):getComponent("MeshRenderer").material
    self.pass2Material = comp.entity.scene:findEntityBy("SeekModeScript"):getComponent("MeshRenderer").material
end

function SeekModeScript:seekToTime(comp, time)

    self.animSeqCom1:seekToTime(time * self.EASpeed)
    self.animSeqCom2:seekToTime(time * self.EASpeed)

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        -- self.pass0Material:setInt("inputWidth", w)
        -- self.pass0Material:setInt("inputHeight", h)
        -- self.pass1Material:setInt("inputWidth", w)
        -- self.pass1Material:setInt("inputHeight", h)
        self.pass1Material:setInt("baseTexWidth", self.width)
        self.pass1Material:setInt("baseTexHeight", self.height)
        self.pass2Material:setInt("baseTexWidth", self.width)
        self.pass2Material:setInt("baseTexHeight", self.height)
    end
end

function SeekModeScript:onEvent(sys, event)
    --if "effects_adjust_intensity" == event.args:get(0) then
    --    local intensity = event.args:get(1) / 3
    --    self.EASpeed = 1.5*intensity+0.5
    --end
    -- if "effects_adjust_noise" == event.args:get(0) then
    --     local intensity = event.args:get(1)
    -- end
end


exports.SeekModeScript = SeekModeScript
return exports
