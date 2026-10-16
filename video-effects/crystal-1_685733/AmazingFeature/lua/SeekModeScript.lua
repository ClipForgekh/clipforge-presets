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

-- Bezier curve1（0.5, 0, 0.75, 0）
local function funcEaseAction1(t, b, c, d)
    t = t/d
    local controls = {.11,.99,.5,1}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

-- Bezier curve2（.07,.81,.28,.99）
local function funcEaseAction2(t, b, c, d)
    t = t/d
    local controls = {.82,.01,.93,.02}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

-- Bezier curve3（0.33, 1, 0.68, 1）
local function funcEaseAction3(t, b, c, d)
    t = t/d
    local controls = {0.34, 1.56, 0.64, 1}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

-- Bezier curve4（.11,0,.91,.06）
local function funcEaseAction4(t, b, c, d)
    t = t/d
    local controls = {.5,0,.85,.04}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

-- ================Custom curve================

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    return self
end

function SeekModeScript:constructor()

end

function SeekModeScript:onStart(comp)
    self.duration = 3.0
    self.params = {}
    self.anims = {}
    self.animDirty = true
    self.scene = comp.entity.scene
    self.trans = comp.entity:getComponent("Transform")
    self.localEulerX = 0.0
    self.localEulerY = 0.0
    self.localEulerZ = 0.0
    self.scaleCorrect = 1.0
    self.videoMat = self.scene:findEntityBy("video"):getComponent("MeshRenderer").material
    self.modelMat1 = self.scene:findEntityBy("sub1"):getComponent("MeshRenderer").material
    self.modelMat2 = self.scene:findEntityBy("sub2"):getComponent("MeshRenderer").material
    self.fxaaMat = self.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
end
    
function SeekModeScript:updateAnim()
    if not self.animDirty then
        return
    end
    self.animDirty = false

    -- time【0-1】
    self.params =
    {
        -- Displacement
        {
            key = "localPosition",
            obj = self.trans,
            startValue = Amaz.Vector3f(0.0, -0.3, 0.0),
            endValue = Amaz.Vector3f(0.0, 0.0, 0.0),
            curve = funcEaseAction3,
            startTime = 0.0,
            endTime = 1.0,
        },
        -- Zoom
        {
            key = "localScale",
            obj = self.trans,
            startValue = Amaz.Vector3f(2.5, 2.5, 2.5),
            endValue = Amaz.Vector3f(1.6, 1.6, 1.6),
            curve = funcEaseAction1,
            startTime = 0.0,
            endTime = 1.0,
        },
        -- {
        --     startRotate = Amaz.Vector3f(0.0,0.0,0.0),
        --     endRotate = Amaz.Vector3f(90.0, 0.0, 0.0),
        --     startTime = 0.0,
        --     endTime = 0.0
        -- },
        -- P = -x
        {
            key = "localEulerX",
            obj = self,
            startValue = 0.0,
            endValue = -30.0,
            curve = funcEaseAction2,
            startTime = 0.0,
            endTime = 1.0,
        },
        -- H = y
        {
            key = "localEulerY",
            obj = self,
            startValue = 0.0,
            endValue = 60.0,
            curve = funcEaseAction2,
            startTime = 0.0,
            endTime = 1.0,
        },
        -- B= -z
        {
            key = "localEulerZ",
            obj = self,
            startValue = 0.0,
            endValue = -8.0,
            curve = funcEaseAction2,
            startTime = 0.0,
            endTime = 1.0,
        }
    }
    
    for i=1, #self.params do
        local param = self.params[i]
        self.anims[i] = self.scene.tween:fromTo(
                            param.obj,
                            {[param.key] = param.startValue},
                            {[param.key] = param.endValue},
                            param.endTime - param.startTime,
                            param.curve,
                            nil,
                            0.0,
                            nil,
                            false)
    end
end


-- function SeekModeScript:onUpdate(comp, deltaTime)
--     local props = comp.entity:getComponent("ScriptComponent").properties
--     if props:has("curTime") then
--          self:seek(props:get("curTime"))
--     end
-- end


function SeekModeScript:setDuration(duration)
    self.duration = duration
    self.animDirty = true
end

function SeekModeScript:seek(time)
    self:updateAnim()
    
    local progress = time / self.duration
    for i=1, #self.anims do
        local param = self.params[i]
        if progress >= param.startTime and progress <= param.endTime then
            self.anims[i]:set(progress - param.startTime)
        end
    end
    self.trans.localEulerAngle = Amaz.Vector3f(self.localEulerX, self.localEulerY, self.localEulerZ)
end

function SeekModeScript:clear()
    self.anims = {}
    self.params = {}
    self.animDirty = true
    self.localEulerX = 0.0
    self.localEulerY = 0.0
    self.localEulerZ = 0.0
end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        self.videoMat:setVec4("u_size", value)
        self.modelMat1:setVec4("u_size", value)
        self.modelMat2:setVec4("u_size", value)
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
        local bgAspect = value.x / value.y;
        local videoAspect = value.z / value.w;
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
