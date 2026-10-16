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
    self.duration = 3
    self.scene = comp.entity.scene
    self.trans = comp.entity:getComponent("Transform")
  
    local entity = self.scene:findEntityBy('Entity')
    local entity2 = self.scene:findEntityBy('Entity2')
    local entity3 = self.scene:findEntityBy('Entity3')
    local entity4 = self.scene:findEntityBy('Entity4')
    local blur = self.scene:findEntityBy('blur')
    self.blurMaterial = blur:getComponent("MeshRenderer").material

    self.videoMaterial = self.scene:findEntityBy("video"):getComponent("MeshRenderer").material

    self.entityTrans = entity:getComponent("Transform")
    self.entityTrans2 = entity2:getComponent("Transform")
    self.entityTrans3 = entity3:getComponent("Transform")
    self.entityTrans4 = entity4:getComponent("Transform")

    self.entityMaterial = entity:searchEntity('quad2'):getComponent("MeshRenderer").material
    self.entityMaterial2 = entity2:searchEntity('quad22'):getComponent("MeshRenderer").material
    self.entityMaterial3 = entity3:searchEntity('quad32'):getComponent("MeshRenderer").material
    self.entityMaterial4 = entity4:searchEntity('quad42'):getComponent("MeshRenderer").material
    
    self.entity1Material = entity:searchEntity('quad'):getComponent("MeshRenderer").material
    self.entity1Material2 = entity2:searchEntity('quad21'):getComponent("MeshRenderer").material
    self.entity1Material3 = entity3:searchEntity('quad31'):getComponent("MeshRenderer").material
    self.entity1Material4 = entity4:searchEntity('quad41'):getComponent("MeshRenderer").material
    self.fxaaMat = self.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.scene:findEntityBy("blend"):getComponent("MeshRenderer").material

    self.lastEntityWolrdMat = self.entityTrans:getWorldMatrix()
    self.lastEntityWolrdMat2 = self.entityTrans2:getWorldMatrix()
    self.lastEntityWolrdMat3 = self.entityTrans3:getWorldMatrix()
    self.lastEntityWolrdMat4 = self.entityTrans4:getWorldMatrix()
end
    
local lastTime = 0

--[[
local time = 0
function SeekModeScript:onUpdate(comp, deltaTime)
    local props = comp.entity:getComponent("ScriptComponent").properties
    if props:has("curTime") then
        self:seek(props:get("curTime"))
        lastTime = props:get("curTime")
    end

    if time >= self.duration then
        time = 0
    end
    time = time + deltaTime
    self:seek(time)
end
--]]

function SeekModeScript:setDuration(duration)
    self.duration = duration
end

function SeekModeScript:animate()
	return {
		['default'] = {
            ['blur'] = 0,
            ['model.scale'] = 2,
            ['model.localEulerZ'] = -5,
			['entity.localEulerY'] = 0,
            ['entity2.localEulerX'] = 0,
            ['entity3.localEulerY'] = 0,
            ['entity4.localEulerX'] = 0
		},
		['animations'] = {
            ['blur'] = {
                {0, .5, 0, 1, Amaz.Ease.linear},
                {.5, 1., 0, 0, Amaz.Ease.linear}
            },

            ['model.scale'] = {
                {0, 1, 1.4, 3.1, {.6,0,.9,.07}},
            },


            ['model.localEulerZ'] = {
                {0, 1, -5, 0, {0,0,1,1}},
            },

			['entity.localEulerY'] = {
                {0, 1, 90, 0, {.1,.95,.4,1}}
            },

            ['entity2.localEulerX'] = {
                {0, 1, -90, 0, {.1,.95,.4,1}}
            },

            ['entity3.localEulerY'] = {
                {0, 1, -90, 0, {.1,.95,.4,1}}
            },

            ['entity4.localEulerX'] = {
                {0, 1, -90, 0, {.1,.95,.4,1}}
            }
		}
	}
end

function SeekModeScript:setValue(key, value)
    if key == 'model.position' then
        self.trans.localPosition = Amaz.Vector3f(value[1], value[2], value[3])
    elseif key == 'model.scale' then
        self.trans.localScale = Amaz.Vector3f(value, value, value)
    elseif key == 'model.localEulerZ' then
        self.trans.localEulerAngle = Amaz.Vector3f(0, 0, value)
    elseif key == 'entity.localEulerY' then
        self.entityTrans.localEulerAngle = Amaz.Vector3f(0, value, 0)
    elseif key == 'entity2.localEulerX' then
        self.entityTrans2.localEulerAngle = Amaz.Vector3f(value, 0, 0)
    elseif key == 'entity3.localEulerY' then
        self.entityTrans3.localEulerAngle = Amaz.Vector3f(0, value, 0)
    elseif key == 'entity4.localEulerX' then
        self.entityTrans4.localEulerAngle = Amaz.Vector3f(value, 0, 0)
    elseif key == 'blur' then
        self.blurMaterial:setFloat('blurScale', value)
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

    local screenW = Amaz.BuiltinObject:getInputTextureWidth()
    local screenH = Amaz.BuiltinObject:getInputTextureHeight()
    self.videoMaterial:setVec4('u_size', Amaz.Vector4f(720, 1280, screenW, screenH))

    -- self.entityMaterial:setMat4('u_LastModel', self.lastEntityWolrdMat)
    -- self.entityMaterial2:setMat4('u_LastModel', self.lastEntityWolrdMat2)
    -- self.entityMaterial3:setMat4('u_LastModel', self.lastEntityWolrdMat3)
    -- self.entityMaterial4:setMat4('u_LastModel', self.lastEntityWolrdMat4)

    -- if lastTime ~= time then
        -- self.lastEntityWolrdMat:setScale(Amaz.Vector3f(self.trans.localScale.x))
        -- self.lastEntityWolrdMat2:setScale(Amaz.Vector3f(self.trans.localScale.x))
        -- self.lastEntityWolrdMat3:setScale(Amaz.Vector3f(self.trans.localScale.x))
        -- self.lastEntityWolrdMat4:setScale(Amaz.Vector3f(self.trans.localScale.x))

        -- self.lastEntityWolrdMat = self.entityTrans:getWorldMatrix()
        -- self.lastEntityWolrdMat2 = self.entityTrans2:getWorldMatrix()
        -- self.lastEntityWolrdMat3 = self.entityTrans3:getWorldMatrix()
        -- self.lastEntityWolrdMat4 = self.entityTrans4:getWorldMatrix()
    -- end
end

function SeekModeScript:clear()
end

function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        self.videoMaterial:setVec4("u_size", value)
        self.entityMaterial:setVec4("u_size", value)
        self.entityMaterial2:setVec4("u_size", value)
        self.entityMaterial3:setVec4("u_size", value)
        self.entityMaterial4:setVec4("u_size", value)
        self.entity1Material:setVec4("u_size", value)
        self.entity1Material2:setVec4("u_size", value)
        self.entity1Material3:setVec4("u_size", value)
        self.entity1Material4:setVec4("u_size", value)
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
        self.videoMaterial:setVec2("u_pos", value)
        self.blendMat:setVec2("u_pos", value)
    elseif name == "u_angle" then
        self.videoMaterial:setFloat("u_angle", value)
        self.blendMat:setFloat("u_angle", value)
    elseif name == "u_scale" then
        self.videoMaterial:setFloat("u_scale", value)
        self.blendMat:setFloat("u_scale", value * self.scaleCorrect)
    elseif name == "u_flipX" then
        self.videoMaterial:setFloat("u_flipX", value)
    elseif name == "u_flipY" then
        self.videoMaterial:setFloat("u_flipY", value)
    elseif name == "_alpha" then
        self.blendMat:setFloat("_alpha", value)
    end
end

exports.SeekModeScript = SeekModeScript
return exports
