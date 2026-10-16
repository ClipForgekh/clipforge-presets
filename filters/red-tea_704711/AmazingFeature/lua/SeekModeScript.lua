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
   
    self:seekToTime(comp, self.curTime - self.startTime)
end

function SeekModeScript:onStart(comp, sys)
   
    self.pass0Material = comp.entity.scene:findEntityBy("Pass0"):getComponent("MeshRenderer").material
    self.pass1Material = comp.entity.scene:findEntityBy("Pass1"):getComponent("MeshRenderer").material
    self.pass3Material = comp.entity:getComponent("MeshRenderer").material
    self.pass4Material = comp.entity.scene:findEntityBy("Pass4"):getComponent("MeshRenderer").material
    self.pass6Material = comp.entity.scene:findEntityBy("Pass6"):getComponent("MeshRenderer").material
    self.camera0 = comp.entity.scene:findEntityBy("CameraPass0"):getComponent("Camera")
    self.camera1 = comp.entity.scene:findEntityBy("CameraPass1"):getComponent("Camera")
    self.camera3 = comp.entity.scene:findEntityBy("CameraPass3"):getComponent("Camera")
    self.camera4 = comp.entity.scene:findEntityBy("CameraPass4"):getComponent("Camera")

end

function SeekModeScript:seekToTime(comp, time)
    
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        -- adaptive max side length 
        local standard_side = 1000
        local max_side = math.max(w,h)
        if max_side>1000 then
            standard_side = max_side*standard_side/1000*1.1
        end
        
        local zoom_factor = standard_side/max_side
        local mW = self.width*zoom_factor
        local mH = self.height*zoom_factor
        self.pass0Material:setInt("imageWidth", mW)
        self.pass0Material:setInt("imageHeight", mH)
        self.pass1Material:setInt("imageWidth", mW)
        self.pass1Material:setInt("imageHeight", mH)
        self.camera0.renderTexture.width = mW
        self.camera0.renderTexture.height = mH
        self.camera1.renderTexture.width = mW
        self.camera1.renderTexture.height = mH
        self.pass3Material:setInt("imageWidth", mW)
        self.pass3Material:setInt("imageHeight", mH)
        self.pass4Material:setInt("imageWidth", mW)
        self.pass4Material:setInt("imageHeight", mH)
        self.camera3.renderTexture.width = mW
        self.camera3.renderTexture.height = mH
        
    end

    local blurRadius = 0
    self.pass0Material:setInt("blurRadius",blurRadius)
    self.pass1Material:setInt("blurRadius",blurRadius)
    local sharpenRadius = 1
    self.pass3Material:setInt("blurRadius",sharpenRadius)
    self.pass4Material:setInt("blurRadius",sharpenRadius)
    local sharpness = 1.35
    self.pass4Material:setFloat("sharpness",sharpness)

end
function SeekModeScript:onEvent(sys, event)
    
    if "intensity" == event.args:get(0) then
        local intensity = event.args:get(1)
        self.pass6Material:setFloat("uniAlpha",intensity)
    end
    
end
exports.SeekModeScript = SeekModeScript
return exports
