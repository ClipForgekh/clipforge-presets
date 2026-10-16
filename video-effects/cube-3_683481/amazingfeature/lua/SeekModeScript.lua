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

-- ================Custom curve================

local function funcEaseAction1(t, b, c, d)
    t = t/d
    local controls = {.87,.01,1,.16}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseAction2(t, b, c, d)
    t = t/d
    local controls = {.06,.93,.32,.99}
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
    self.modelMat1 = self.scene:findEntityBy("sub1"):getComponent("MeshRenderer").material
    self.modelMat2 = self.scene:findEntityBy("sub2"):getComponent("MeshRenderer").material
    self.modelMat3 = self.scene:findEntityBy("sub3"):getComponent("MeshRenderer").material
    self.modelMat4 = self.scene:findEntityBy("sub4"):getComponent("MeshRenderer").material
    self.modelMat5 = self.scene:findEntityBy("sub5"):getComponent("MeshRenderer").material
    self.modelMat6 = self.scene:findEntityBy("sub6"):getComponent("MeshRenderer").material
    self.fxaaMat = self.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
end
    
function SeekModeScript:updateAnim()
    if not self.animDirty then
        return
    end
    self.animDirty = false
    
    -- pos（0 - 1）
    self.anims[0] = self.scene.tween:fromTo(
                        self.trans,
                        {["localPosition"] = Amaz.Vector3f(0.0, 0.0, 0.0)},
                        {["localPosition"] = Amaz.Vector3f(1.0, 0.0, 0.0)},
                        1.0,
                        funcEaseAction1,
                        nil,
                        0.0,
                        nil,
                        false)
    -- rotate1（0 - 1）
    self.anims[1] = self.scene.tween:fromTo(
                        self,
                        {["localEulerZ"] = 90.0},
                        {["localEulerZ"] = 0.0},
                        1.0,
                        funcEaseAction2,
                        nil,
                        0.0,
                        nil,
                        false)
    -- rotate2（0 - 1）
    self.anims[2] = self.scene.tween:fromTo(
                        self,
                        {["localEulerY"] = 0.0},
                        {["localEulerY"] = 90.0},
                        1.0,
                        funcEaseAction1,
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
        self.modelMat2:setVec4("u_size", value)
        self.modelMat3:setVec4("u_size", value)
        self.modelMat4:setVec4("u_size", value)
        self.modelMat5:setVec4("u_size", value)
        self.modelMat6:setVec4("u_size", value)
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
