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
    self.first = nil
    return self
end

function SeekModeScript:constructor()
end

function SeekModeScript:onUpdate(comp, detalTime)

    self:seekToTime(comp, self.curTime - self.startTime)

end

function SeekModeScript:onStart(comp)

    self.SkinMaterial = comp.entity.scene:findEntityBy("SeekModeScript"):getComponent("MeshRenderer").material
    self.noiseMaterial = comp.entity.scene:findEntityBy("noise"):getComponent("MeshRenderer").material
    self.noiseMaterial:setInt("lightNoise", 15)
    self.noiseMaterial:setInt("darkNoise", 15)
end

function SeekModeScript:seekToTime(comp, time)
    -- if self.first == nil then
    --     self.first = true
    --     self:start(comp)
    -- end

end

function SeekModeScript:onEvent(sys, event)
    
    -- if "Internal_Filter" == event.args:get(0) then
    --     local intensity = event.args:get(2)
    --     self.SkinMaterial:setFloat("intensity",intensity)
    -- end
    -- if "intensity" == event.args:get(0) then
    --     local intensity = event.args:get(1)
    --     self.SkinMaterial:setFloat("intensity",intensity)
    -- end
    
    if "intensity" == event.args:get(0) then
        local intensity = event.args:get(1)
        self.SkinMaterial:setFloat("intensity",intensity)
        -- self.noiseMaterial:setFloat("u_op",intensity)
    end
    
    
end

exports.SeekModeScript = SeekModeScript
return exports