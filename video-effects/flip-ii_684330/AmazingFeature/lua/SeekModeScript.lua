--@input float curTime = 0.0{"widget":"slider","min":0,"max":3}

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

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

-- ================Costom curze================

local function funcEaseAction1(t, b, c, d)
    t = t/d
    value = math.exp(-7.0 * t) * 1.0 * math.sin((t - 0.075) * (2.0*math.pi) / 0.3) + 1.0
    return b + c * value
end

local function funcEaseAction2(t, b, c, d)
    t = t/d
    local controls = {.08,.75,.24,.96}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseAction3(t, b, c, d)
    t = t/d
    local controls = {.76,.04,.92,.25}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    return self
end

function SeekModeScript:constructor()

end

function SeekModeScript:onStart(comp)
    self.duration = 3.0
    self.anims = {}
    self.animDirty = true
    self.scene = comp.entity.scene
    self.trans = comp.entity:getComponent("Transform")
    self.localEulerY = 0.0
    self.localEulerZ = 0.0
    self.scaleCorrect = 1.0
    self.videoMat = self.scene:findEntityBy("video"):getComponent("MeshRenderer").material
    self.modelMat1 = self.scene:findEntityBy("model"):getComponent("MeshRenderer").material
    self.fxaaMat = self.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
end
    
function SeekModeScript:updateAnim()
    if not self.animDirty then
        return
    end
    self.animDirty = false
    -- H = y
    -- P = -x
    -- B = -z
    
    -- Zoom（0 - 1）
    self.anims[0] = self.scene.tween:fromTo(
                        self.trans,
                        {["localScale"] = Amaz.Vector3f(1.35, 1.35, 1.35)},
                        {["localScale"] = Amaz.Vector3f(0.95, 0.95, 0.95)},
                        1.0,
                        funcEaseAction2,
                        nil,
                        0.0,
                        nil,
                        false)
    -- Spin1（0 - 1）
    self.anims[1] = self.scene.tween:fromTo(
                        self,
                        {["localEulerZ"] = -8.0},
                        {["localEulerZ"] = 0.0},
                        1.0,
                        funcEaseAction1,
                        nil,
                        0.0,
                        nil,
                        false)
    -- Spin2（0 - 1）
    self.anims[2] = self.scene.tween:fromTo(
                        self,
                        {["localEulerY"] = 0.0},
                        {["localEulerY"] = 72.0},
                        1.0,
                        funcEaseAction3,
                        nil,
                        0.0,
                        nil,
                        false)
end

--[[
function SeekModeScript:onUpdate(comp, deltaTime)
    local props = comp.entity:getComponent("ScriptComponent").properties
    if props:has("curTime") then
        self:seek(props:get("curTime"))
    end
end
--]]

function SeekModeScript:setDuration(duration)
    self.duration = duration
    self.animDirty = true
end

function SeekModeScript:seek(time)
    self:updateAnim()
    
    local progress = time / self.duration
    self.anims[0]:set(progress)
    self.anims[1]:set(progress)
    self.anims[2]:set(progress)
    self.trans.localEulerAngle = Amaz.Vector3f(0.0, self.localEulerY, self.localEulerZ)
end

function SeekModeScript:clear()
    self.tweens = {}
    self.animDirty = true
    self.localEulerY = 0.0
    self.localEulerZ = 0.0
end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        self.videoMat:setVec4("u_size", value)
        self.modelMat1:setVec4("u_size", value)
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
        local bgAspect = value.x / value.y
        local videoAspect = value.z / value.w
        if bgAspect > videoAspect then
            self.scaleCorrect = value.w / value.y
        else
            self.scaleCorrect = value.z / value.x
        end
    elseif name == "u_pos" then
        self.videoMat:setVec2("u_pos", value)
        self.blendMat:setVec2("u_pos", value)
    elseif name == "u_angle" then
        self.videoMat:setFloat("u_angle", value)
        self.blendMat:setFloat("u_angle", value)
    elseif name == "u_scale" then
        self.videoMat:setFloat("u_scale", value)
        self.blendMat:setFloat("u_scale", value * self.scaleCorrect)
    elseif name == "u_flipX" then
        self.videoMat:setFloat("u_flipX", value)
    elseif name == "u_flipY" then
        self.videoMat:setFloat("u_flipY", value)
    elseif name == "_alpha" then
        self.blendMat:setFloat("_alpha", value)
    end
end

exports.SeekModeScript = SeekModeScript
return exports
