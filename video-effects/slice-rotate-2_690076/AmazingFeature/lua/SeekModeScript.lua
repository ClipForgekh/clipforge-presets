--@input float curTime = 0.0{"widget":"slider","min":0,"max":3}

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

function clamp(min, max, value)
	return math.min(math.max(value, 0), 1)
end

function saturate(value)
	return clamp(0, 1, value)
end

function lerp(a, b, c)
	c = saturate(0, 1, c)
	return (1 - c) * a + c * b
end

function lerpVector3(a, b, c)
	c = saturate(0, 1, c)
	return Amaz.Vector3f(
		lerp(a.x, b.x, c),
		lerp(a.y, b.y, c),
		lerp(a.z, b.z, c)
	)
end

function remap(smin, smax, dmin, dmax, value)
	return (value - smin) / (smax - smin) * (dmax - dmin) + dmin
end

function remapClamped(smin, smax, dmin, dmax, value)
	return saturate(value - smin) / (smax - smin) * (dmax - dmin) + dmin
end

function remapVector3(smin, smax, dmin, dmax, value)
	return Amaz.Vector3f(
		remap(smin.x, smax.x, dmin.x, dmax.x, value.x),
		remap(smin.y, smax.y, dmin.y, dmax.y, value.y),
		remap(smin.z, smax.z, dmin.z, dmax.z, value.z)
	) 
end

function remapVector4(smin, smax, dmin, dmax, value)
	return Amaz.Vector3f(
		remap(smin.x, smax.x, dmin.x, dmax.x, value.x),
		remap(smin.y, smax.y, dmin.y, dmax.y, value.y),
		remap(smin.z, smax.z, dmin.z, dmax.z, value.z),
		remap(smin.w, smax.w, dmin.w, dmax.w, value.w)
	) 
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

-- ================Custom curve================

local function bezier(controls)
	return function (t, b, c, d)
		t = t/d
		local tvalue = getBezierTfromX(controls, t)
		local value =  getBezierValue(controls, tvalue)
		return b + c * value[2]
	end
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
    self.duration = 2
    self.trans = comp.entity:getComponent("Transform")
    self.scene = comp.entity.scene
    self.videoMat = self.scene:findEntityBy("video"):getComponent("MeshRenderer").material
    self.fxaaMat = self.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.cube = self.scene:findEntityBy("model"):getComponent("Transform")
    self.front = self.scene:findEntityBy("front"):getComponent("Transform")
    self.back = self.scene:findEntityBy("back"):getComponent("Transform")
end
    

--[[
local time = 0
function SeekModeScript:onUpdate(comp, deltaTime)
    local props = comp.entity:getComponent("ScriptComponent").properties
    if props:has("curTime") then
        self:seek(props:get("curTime"))
    end

    if time >= self.duration then
        time = 0
    end
    time = time + deltaTime
    self:seek(time)
end
]]--


function SeekModeScript:setDuration(duration)
    self.duration = duration
end

function SeekModeScript:animate()
	return {
		['default'] = {
            ['position'] = {0, 0, -5},
            ['scale'] = 1,
            ['rotateY'] = 0
		},
		['animations'] = {
            ['scale'] = {
                {0, 1, 0.8, 1.4, {.72,0,.9,.07}},
            },
            ['position'] = {
                {0, 0, {0, 0, 0}, {0, 0, 0}, {0.5, 0, 0.75, 0}},
            },
            ['rotateY'] = {
                {0, 1.0, 270, 0, {.1,.93,.27,1}}
            }
		}
	}
end

function SeekModeScript:setValue(key, value)
    if key == 'position' then
        self.trans.localPosition = Amaz.Vector3f(value[1], value[2], value[3])
    elseif key == 'scale' then
        self.trans.localScale = Amaz.Vector3f(value * 3, value * 3, value * 3)
    elseif key == 'rotateY' then
        self.trans.localEulerAngle = Amaz.Vector3f(0, value, 0)
    end
end

function SeekModeScript:seek(time)
    local nt = time / self.duration
    local info = self:animate()
  
    for key, value in pairs(info.default) do
        self:setValue(key, value)
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
                        self:setValue(key, func(nt - keyframe[1], keyframe[3], keyframe[4] - keyframe[3], keyframe[2] - keyframe[1]))
                    elseif type(keyframe[3]) == 'table'
                        and type(keyframe[4]) == 'table'
                        and #keyframe[3] == #keyframe[4] then
                        local values = {}
                        for i = 1, #keyframe[3] do
                            values[i] = func(nt - keyframe[1], keyframe[3][i], keyframe[4][i] - keyframe[3][i], keyframe[2] - keyframe[1])
                        end
                        self:setValue(key, values)
                    end
                end
                break
            elseif nt < keyframe[1] then
                if index > 1 then
                    self:setValue(key, value[index - 1][4])
                end
                break
            elseif nt > keyframe[2] then
                self:setValue(key, value[index][4])
            end
        end
    end

    local outputWidth = Amaz.BuiltinObject:getOutputTextureWidth()
    local outputHeight = Amaz.BuiltinObject:getOutputTextureHeight()
    local inputWidth = Amaz.BuiltinObject:getInputTextureWidth()
    local inputHeight = Amaz.BuiltinObject:getInputTextureHeight()
    self:setParams('u_size', Amaz.Vector4f(outputWidth, outputHeight, inputWidth, inputHeight))
end

function SeekModeScript:clear()
end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        self.videoMat:setVec4("u_size", value)
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
