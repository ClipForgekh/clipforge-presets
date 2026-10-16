--@input int blurSize = 100{"widget":"slider","min":0,"max":100}
--@input float ins = 1
--@input float centerX = 0.0{"widget":"slider","min":0.0,"max":1.0}
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
    self.GlowRange = 100
    
    return self
end

function SeekModeScript:constructor()

end

local function getBezierValue(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3*xc1*(1-t)*(1-t)*t+3*xc2*(1-t)*t*t+t*t*t
    ret[2] = 3*yc1*(1-t)*(1-t)*t+3*yc2*(1-t)*t*t+t*t*t
    return ret
end

local function getBezierDerivative(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3*xc1*(1-t)*(1-3*t)+3*xc2*(2-3*t)*t+3*t*t
    ret[2] = 3*yc1*(1-t)*(1-3*t)+3*yc2*(2-3*t)*t+3*t*t
    return ret
end

local function getBezierTfromX(controls, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts+te)/2
        local value = getBezierValue(controls, tm)
        if(value[1]>x) then
            te = tm
        else
            ts = tm
        end
    until(te-ts < 0.0001)

    return (te+ts)/2
end
local function mix(a,b,x)
	return a+(b-a)*x
end
local function clamp(x,a,b)
    if x<a then
        x=a
    elseif x>b then
        x=b
    end
    return x
end
if Amaz.Macros and Amaz.Macros.EditorSDK then
    function SeekModeScript:onUpdate(comp, detalTime)
        --ceshiyong
        --local props = comp.entity:getComponent("ScriptComponent").properties
        --if props:has("curTime") then
            --self:seekToTime(comp, props:get("curTime"))
        --end
        --shijiyong
        self.curTime=self.curTime + detalTime
        self:seek(self.curTime - self.startTime)
    end
end

function SeekModeScript:_adapt_onStart(comp)
    self.curTime = 0
    self.duration = 1.5
    self.values = {}
    self.params = {}
    self.anims = {}
    self.animDirty = true
    self.entity = comp.entity
    self.scaleCorrect = 1.0
    self.videoMat = self.entity.scene:findEntityBy("video"):getComponent("MeshRenderer").material
    self.modelMat = self.entity.scene:findEntityBy("quad"):getComponent("MeshRenderer").material
    self.fxaaMat = self.entity.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.entity.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.transform = self.entity.scene:findEntityBy("quad"):getComponent("Transform")
    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)
end

function SeekModeScript:onStart(comp)
    self:_adapt_onStart(comp)

    self.material = comp.entity.scene:findEntityBy("SeekModeScript"):getComponent("MeshRenderer").material
    self.material2 = comp.entity.scene:findEntityBy("SeekModeScript_2"):getComponent("MeshRenderer").material
    self.lasiMaterial = comp.entity.scene:findEntityBy("lasiPass"):getComponent("MeshRenderer").material
    self.rgbMaterial = comp.entity.scene:findEntityBy("RGBpass"):getComponent("MeshRenderer").material
    self.blurYMaterial = comp.entity.scene:findEntityBy("blurYpass"):getComponent("MeshRenderer").material
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    self.width = w
    self.height = h
    self.material:setFloat("baseTexWidth", w)
    self.material:setFloat("baseTexHeight", h)
    self.material2:setFloat("baseTexWidth", w)
    self.material2:setFloat("baseTexHeight", h)
    
end

function SeekModeScript:_adapt_seek(time)
    local inputW = Amaz.BuiltinObject:getInputTextureWidth()
    local inputH = Amaz.BuiltinObject:getInputTextureHeight()
    local inputRatio = inputW / inputH
    local outputW = Amaz.BuiltinObject:getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject:getOutputTextureHeight()
    local outputRatio = outputW / outputH
    local fitScale = Amaz.Vector3f(1, 1, 1)
    local extraScale = 1
    if inputRatio < outputRatio then
        fitScale.x = inputRatio
        extraScale = inputH / outputH
    else
        fitScale.x = outputRatio
        fitScale.y = outputRatio / inputRatio
        extraScale = inputW / outputW
    end

    local uvScale = Amaz.Vector2f(1, 1)
    local xRatio = inputRatio / outputRatio
    local yRatio = outputRatio / inputRatio
    if outputRatio > 1. then
        if outputRatio > inputRatio then
            uvScale.x = xRatio
        else
            uvScale.y = yRatio
        end
    elseif math.abs(outputRatio - 1.) < .1 then
        if inputRatio < 1. then
            uvScale.x = xRatio
        else
            uvScale.y = yRatio
        end
    elseif outputRatio < 1. then
        if math.abs(inputRatio - 1.) < .1 or outputRatio < inputRatio then
            uvScale.y = yRatio
        else
            uvScale.x = xRatio
        end
    end

    self.modelMat:setFloat("u_OutputWidth", outputW)
    self.modelMat:setFloat("u_OutputHeight", outputH)

    local userMat = Amaz.Matrix4x4f()
    userMat:setTRS(
        Amaz.Vector3f(self.userPosition.x * outputRatio, self.userPosition.y, self.userPosition.z),
        Amaz.Quaternionf.EulerToQuaternion(-self.userEulerAngle / 180 * math.pi),
        Amaz.Vector3f(1, 1, 1) * self.userScale.x * extraScale
    )
    userMat:invert_Full()

    local fitMat = Amaz.Matrix4x4f()
    fitMat:setTRS(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.identity(), Amaz.Vector3f(uvScale.x, uvScale.y, 1))
    fitMat:invert_Full()

    self.modelMat:setMat4("userMat", userMat)
    self.modelMat:setMat4("fitMat", fitMat)
end

function SeekModeScript:seek(time)
    self:_adapt_seek(time)
    self.material:setFloat("uTime", time)
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.material:setFloat("baseTexWidth", w)
        self.material:setFloat("baseTexHeight", h)
        self.material2:setFloat("baseTexWidth", w)
        self.material2:setFloat("baseTexHeight", h)
    end
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("blurSize") then
    --     self.GlowRange = props:get("blurSize")
    -- end
    -- self.lasiMaterial:setFloat("ins", props:get("ins"))
    -- self.lasiMaterial:setFloat("centerX", props:get("centerX"))
    local controls = {0.21,-0.46,0.33,0.45}

    local t = math.mod(time,self.duration+0.0001)/(self.duration+0.0001)
    if t>1 then
        t=1
    end
    -- Amaz.LOGI("asdasd",t)
    local tvalue = getBezierTfromX(controls, t)
    local value = getBezierValue(controls, tvalue)[2]
    value=clamp(value,0.0,1.0)
    value=value*value*value
    self.lasiMaterial:setFloat("offset",0.03*(1.0-t))
    self.lasiMaterial:setFloat("ins", value*1.0+0.00)
    self.lasiMaterial:setFloat("centerX", 0.5-t*0.5)
    self.rgbMaterial:setFloat("RGBins",(1.0-t)*20.)
    self.blurYMaterial:setFloat("y_index",1.5*(1.0-value))
    self.GlowRange = 75*(1.0-t)
    if value<0.05 then
        self.GlowRange=25*(1.0-t)
    end
    local range = math.abs(self.GlowRange)
    local myrange1 = math.ceil(math.sqrt(range))
    if myrange1 == 0 then
        myrange1 = 0.5
    end
    local y_index =range/myrange1
    local myrange2 = math.ceil(y_index)
    self.material:setFloat("GlowRange",myrange1)
    -- Amaz.LOGI("myrange1",myrange1)
    self.material:setFloat("y_indez", y_index)
    self.material2:setFloat("GlowRange",myrange2) 
    
    -- Amaz.LOGI("myrange2",myrange2)
end

-- function SeekModeScript:onEvent(sys, event)
--     if("effects_adjust_horizontal_shift" == event.args:get(0)) then
--         local intensity = event.args:get(1)
--         self.GlowRange = intensity*200.0
--         if self.GlowRange > 100 then
--             self.material:enableMacro('RightBlur', 1)
--             self.material2:enableMacro('RightBlur2', 1)
--         else
--             self.material:disableMacro('RightBlur')
--             self.material2:disableMacro('RightBlur2')
--         end
--         local range = math.abs(self.GlowRange-100)
--         local myrange1 = math.ceil(math.sqrt(range))
--         if myrange1 == 0 then
--             myrange1 = 0.5
--         end
--         local y_index =range/myrange1
--         local myrange2 = math.ceil(y_index)
--         self.material:setFloat("GlowRange",myrange1)
--         self.material:setFloat("y_indez", y_index)
--         self.material2:setFloat("GlowRange",myrange2) 
--     end

--     if("effects_adjust_intensity" == event.args:get(0)) then
--         local intensity = event.args:get(1)
--         self.material2:setFloat("alpha", intensity)
--     end
-- end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        -- local bgAspect = value.x / value.y
        -- local videoAspect = value.z / value.w
        -- if bgAspect > videoAspect then
        --     self.scaleCorrect = value.w / value.y
        -- else
        --     self.scaleCorrect = value.z / value.x
        -- end
        -- self.videoMat:setVec4("u_size", value)
        -- self.modelMat:setVec4("u_size", value)
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
    elseif name == "u_pos" then
        -- self.videoMat:setVec2("u_pos", value)
        -- self.blendMat:setVec2("u_pos", value)
        self.userPosition:set(value.x, value.y, 0)
    elseif name == "u_angle" then
        -- self.videoMat:setFloat("u_angle", value)
        -- self.blendMat:setFloat("u_angle", value)
        self.userEulerAngle:set(0, 0, value / math.pi * 180)
    elseif name == "u_scale" then
        -- self.videoMat:setFloat("u_scale", value)
        -- self.blendMat:setFloat("u_scale", value * self.scaleCorrect)
        self.userScale:set(value, value, 1)
    elseif name == "u_flipX" then
        self.videoMat:setFloat("u_flipX", value)
    elseif name == "u_flipY" then
        self.videoMat:setFloat("u_flipY", value)
    elseif name == "_alpha" then
        self.blendMat:setFloat("_alpha", value)
    end
end

function SeekModeScript:setDuration(duration)
    self.duration = duration
end

exports.SeekModeScript = SeekModeScript
return exports
