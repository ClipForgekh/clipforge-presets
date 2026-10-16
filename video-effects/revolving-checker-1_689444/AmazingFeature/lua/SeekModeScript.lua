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

local function bezier(controls)
	return function (t, b, c, d)
		t = t/d
		local tvalue = getBezierTfromX(controls, t)
		local value =  getBezierValue(controls, tvalue)
		return b + c * value[2]
	end
end

local function funcEaseBlurAction1(t, b, c, d)
    t = t/d
    -- diyijieduandeweiyiquxian，beisaierquxianbanben
    local controls = {.05,.71,.61,.99}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

local function funcEaseBlurAction2(t, b, c, d)
    t = t/d
    -- diyijieduandeweiyiquxian，beisaierquxianbanben
    local controls = {.01,.92,0,.99}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
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
    self.duration = 3.
    self.frames = 0
    -- self.scaleCorrect = 1.0
    self.scene = comp.entity.scene
    self.modelTrans = comp.entity:getComponent("Transform")
    self.quadTrans = self.scene:findEntityBy('quad'):getComponent("Transform")

    self.videoMat = self.scene:findEntityBy("video"):getComponent("MeshRenderer").material
    self.quadMat = self.scene:findEntityBy("quad"):getComponent("MeshRenderer").material
    self.fxaaMat = self.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.scene:findEntityBy("blend"):getComponent("MeshRenderer").material

    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)
    self.animPosition = Amaz.Vector3f(0, 0, 0)
    self.animEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.animScale = Amaz.Vector3f(1, 1, 1)
end
    

local time = 0
-- function SeekModeScript:onUpdate(comp, deltaTime)
--     local props = comp.entity:getComponent("ScriptComponent").properties
--     if props:has("curTime") then
--         self:seek(props:get("curTime"))
--     end

--     if time >= self.duration then
--         time = 0
--     end
--     time = time + deltaTime
--     self:seek(time)
-- end


function SeekModeScript:setDuration(duration)
    self.duration = duration
end

function SeekModeScript:animate()
	return {
		['default'] = {
            ['blurType'] = 0,
            ['blurDirection'] = {0, 1},
            ['blurStep'] = 0,
            ['localPosition'] = {0, 0, 0},
            ['localEulerAngle'] = {0, 0, 0},
            ['localScale'] = {1, 1, 1},

            ['angleTopLeft'] = 0,
            ['angleTopRight'] = 0,
            ['angleBottomLeft'] = 0,
            ['angleBottomRight'] = 0,
            ['blurIntensity'] = 0,
		},
		['animations'] = {
            ['localPosition'] = {
                {0, 1, {0, -0.1, 0}, {0, 0, 0}, {.45,1.88,.48,.77}}
            },
            ['localScale'] = {
                {0, 1, {2, 2, 2}, {1, 1, 1}, {.15,.95,.3,1}}
            },

            ['angleTopLeft'] = {
                {0.2, 1, 0, 90, {1,.01,.98,.08}}
            },
            ['angleTopRight'] = {
                {0.2, 1, 0, -90, {1,.01,.98,.08}}
            },
            ['angleBottomLeft'] = {
                {0.2, 1, 0, -90, {1,.01,.98,.08}}
            },
            ['angleBottomRight'] = {
                {0.2, 1, 0, 90, {1,.01,.98,.08}}
            },
            ['blurIntensity'] = {
                {0, 1, 0, 0, {.15,.95,.3,1}}
            }
		}
	}
end

function playAnimation(info, nt, cb)
    for key, value in pairs(info.default) do
        cb(key, value)
    end
    for key, value in pairs(info.animations) do
        for index, keyframe in pairs(value) do
            if nt >= keyframe[1] and nt <= keyframe[2] then
                local func
                if type(keyframe[5]) == 'function' then
                    func = keyframe[5]
                elseif type(keyframe[5]) == 'table' and #keyframe[5] == 4 then
                    func = bezier(keyframe[5])
                end
                if type(func) == 'function' then
                    if type(keyframe[3]) == 'number' and type(keyframe[4]) == 'number' then
                        cb(key, func(nt - keyframe[1], keyframe[3], keyframe[4] - keyframe[3], keyframe[2] - keyframe[1]))
                    elseif type(keyframe[3]) == 'table'
                        and type(keyframe[4]) == 'table'
                        and #keyframe[3] == #keyframe[4] then
                        local values = {}
                        for i = 1, #keyframe[3] do
                            values[i] = func(nt - keyframe[1], keyframe[3][i], keyframe[4][i] - keyframe[3][i], keyframe[2] - keyframe[1])
                        end
                        cb(key, values)
                    end
                end
                break
            elseif nt < keyframe[1] then
                if index > 1 then
                    cb(key, value[index - 1][4])
                end
                break
            elseif nt > keyframe[2] then
                cb(key, value[index][4])
            end
        end
    end
end

function SeekModeScript:seek(time)
    self.frames = self.frames + 1

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
    self.quadTrans.localScale = fitScale

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

    self.quadMat:setFloat('u_InputWidth', inputW)
    self.quadMat:setFloat('u_InputHeight', inputH)
    self.quadMat:setFloat('u_OutputWidth', outputW)
    self.quadMat:setFloat('u_OutputHeight', outputH)
    self.quadMat:setVec2('u_UVScale', uvScale)

    local nt = time / self.duration
    local info = self:animate()
  
    playAnimation(info, nt, function (key, value)
        if key == 'localPosition' then
            self.animPosition = Amaz.Vector3f(value[1], value[2], value[3])
        elseif key == 'localEulerAngle' then
            self.animEulerAngle = Amaz.Vector3f(value[1], value[2], value[3])
        elseif key == 'localScale' then
            self.animScale = Amaz.Vector3f(value[1], value[2], value[3])
        elseif key == 'blurType' then
            self.quadMat:enableMacro('BLUR_TYPE', value)
        elseif key == 'blurDirection' then
            self.quadMat:setVec2('blurDirection', Amaz.Vector2f(value[1], value[2]))
        elseif key == 'blurStep' then
            self.quadMat:setFloat('blurStep', value)
        elseif key == 'angleTopLeft' then
            self.quadMat:setFloat('angleTopLeft', value / 180 * math.pi)
        elseif key == 'angleTopRight' then
            self.quadMat:setFloat('angleTopRight', value / 180 * math.pi)
        elseif key == 'angleBottomLeft' then
            self.quadMat:setFloat('angleBottomLeft', value / 180 * math.pi)
        elseif key == 'angleBottomRight' then
            self.quadMat:setFloat('angleBottomRight', value / 180 * math.pi)
        elseif key == 'blurIntensity' then
            self.quadMat:setFloat('blurIntensity', value)
        end
    end)
    
    local animMat = Amaz.Matrix4x4f()
    animMat:setTRS(
        self.animPosition,
        Amaz.Quaternionf.EulerToQuaternion(self.animEulerAngle / 180 * math.pi),
        self.animScale + Amaz.Vector3f(.001, .001, .001)
    )
    animMat:invert_Full()

    local userMat = Amaz.Matrix4x4f()
    -- userMat:setTRS(
    --     Amaz.Vector3f(self.userPosition.x * outputRatio, self.userPosition.y, self.userPosition.z),
    --     Amaz.Quaternionf.EulerToQuaternion(-self.userEulerAngle / 180 * math.pi),
    --     Amaz.Vector3f(1, 1, 1) * self.userScale.x * extraScale
    -- )
    -- userMat:invert_Full()

    local fitMat = Amaz.Matrix4x4f()
    fitMat:setTRS(
        Amaz.Vector3f(0, 0, 0),
        Amaz.Quaternionf.identity(),
        Amaz.Vector3f(uvScale.x, uvScale.y, 1)
    )
    fitMat:invert_Full()

    self.quadMat:setMat4('animMat', animMat)
    self.quadMat:setMat4('userMat', userMat)
    self.quadMat:setMat4('fitMat', fitMat)
    
    -- self.quadMat:setVec2("u_pos", Amaz.Vector2f(self.animPosition.x + self.userPosition.x, self.animPosition.y + self.userPosition.y) * -1)
    -- self.quadMat:setFloat("u_angle", -(self.animEulerAngle.z + self.userEulerAngle.z) / 180 * math.pi)
    -- self.quadMat:setFloat("u_scale", 1. / (self.animScale.x * self.userScale.x * extraScale))

    -- self.blendMat:setVec2("u_pos", Amaz.Vector2f(self.userPosition.x, self.userPosition.y))
    -- self.blendMat:setFloat("u_angle", self.userEulerAngle.z / 180 * math.pi)
    -- self.blendMat:setFloat("u_scale", self.userScale.x * extraScale)
end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        -- self.videoMat:setVec4("u_size", value)
        -- self.modelMat:setVec4("u_size", value)
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
        -- local bgAspect = value.x / value.y
        -- local videoAspect = value.z / value.w
        -- if bgAspect > videoAspect then
        --     self.scaleCorrect = value.w / value.y
        -- else
        --     self.scaleCorrect = value.z / value.x
        -- end
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

function SeekModeScript:clear()
end

exports.SeekModeScript = SeekModeScript
return exports
