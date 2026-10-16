

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

local function remap(x, a, b)
    return x * (b - a) + a
end

function SeekModeScript:onStart(comp)
    self.material = comp.entity.scene:findEntityBy("Noise"):getComponent("Renderer").material
    self.BloomMaterial0 = comp.entity.scene:findEntityBy("Bloom"):getComponent("Renderer").material
    self.FilterEntityMaterial1 = comp.entity.scene:findEntityBy("FilterEntity"):getComponent("Renderer").material
    
    -- local intensity = 0.8
    -- self.material:setFloat("slider_value", intensity*2.0)
    self.BloomMaterial0["u_edge"] = 2
end

function SeekModeScript:onUpdate(comp, detalTime)
    --ceshiyong
    --local props = comp.entity:getComponent("ScriptComponent").properties
    --if props:has("curTime") then
        --self:seekToTime(comp, props:get("curTime"))
    --end
    --shijiyong
    self:seekToTime(comp, self.curTime - self.startTime)
end

function SeekModeScript:seekToTime(comp, time)
    if self.first == nil then
        self.first = true
        -- self:start(comp)
    end
    self.material:setFloat("uTime", time)
    
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.material:setInt("baseTexWidth", self.width)
        self.material:setInt("baseTexHeight", self.height)
    end
end

function SeekModeScript:onEvent(sys, event)
    if("intensity" == event.args:get(0)) then
        local intensity = event.args:get(1)
        -- print("Noise_intensity = ",intensity)
        self.material:setFloat("slider_value", intensity*2.0 * 0.3)
        self.BloomMaterial0["radius"] = remap(intensity,0,6)
        self.FilterEntityMaterial1["uniAlpha"] = remap(intensity,0,1)
    end

end

exports.SeekModeScript = SeekModeScript
return exports
