local exports = exports or {}
local Transform = Transform or {}
Transform.__index = Transform

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

local function bezier(controls)
	return function (t, b, c, d)
		t = t/d
		local tvalue = getBezierTfromX(controls, t)
		local value =  getBezierValue(controls, tvalue)
		return b + c * value[2]
	end
end

-- ================ccccc================

function Transform.new(construct, ...)
    local self = setmetatable({}, Transform)
    self.material = nil
    self.duration = 0
    self.values = {}

    if construct and Transform.constructor then Transform.constructor(self, ...) end
    return self
end

function Transform:constructor()

end

function Transform:onStart(comp)
    self.vfx = comp.entity.scene:findEntityBy("Blur")
    self.canvas = comp.entity.scene:findEntityBy("Root")
    self.aa = comp.entity.scene:findEntityBy("AA")
    self.blend = comp.entity.scene:findEntityBy("Canvas")
    local transform = comp.entity:getComponent("Transform")
    transform.localPosition = Amaz.Vector3f(0.0, 0.0, 0.0)
    self.material = self.vfx:getComponent("Sprite2DRenderer").material
    if self.blend ~= nil then
        self.blendMaterial = self.blend:getComponent("Sprite2DRenderer").material
    end
    self.tweenDirty = true
    self.scene = comp.entity.scene
    self.entity = comp.entity
end

function Transform:animate()
	return {
		['default'] = {
            ['time'] = 0,
            ['allScale'] = 1.,
            ['move2X'] = 0.,
            ['move2Y'] = 0.,
		},
		['animations'] = {
            ['time'] = {
                {0, 1, 1.5, 2, {.15,.95,.3,1}},
            },
            ['allScale'] = {
                {0, 1, 1, 0., {1,.01,.98,.08}},
            },
            ['move2X'] = {
                {0, 1, 0, 0, {0.16, 1, 0.3, 1}},
            },
            ['move2Y'] = {
                {0, 1, 0.0, 0, {0.34, 1.56, 0.64, 1}},
            },
            ['blur'] = {
                {0, 1, 0., 0., {.15,.95,.3,1}},
            }
		}
	}
end

function Transform:setValue(key, value)
    if key == 'time' then
        self.material:setFloat('time', value)
    end
    if key == 'allScale' then
        self.material:setFloat('allScale', value)
    end
    if key == 'move2X' then
        self.material:setFloat('move2X', value)
    end
    if key == 'move2Y' then
        self.material:setFloat('move2Y', value)
    end
    if key == 'blur' then
        self.material:setFloat('blur', value)
    end
end

function Transform:seek(time)
    -- ccccc
    local animTrans = self.vfx:getComponent("Transform")
    animTrans.localMatrix = animTrans.localMatrix:SetIdentity()

    -- ccccc
    self.blendMaterial["_alpha"] = 1.0

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
    

    local screenW = Amaz.BuiltinObject:getOutputTextureWidth()
    local screenH = Amaz.BuiltinObject:getOutputTextureHeight()

    local ratio = screenW / screenH
    self.material:setFloat('outputRatio', ratio)
    local inputW = Amaz.BuiltinObject.getInputTextureWidth()
    local inputH = Amaz.BuiltinObject.getInputTextureHeight()
    local inputRatio = inputW / inputH
    -- self.material:setFloat('inputWidth', inputW)
    -- self.material:setFloat('inputHeight', inputH)
    -- Amaz.LOGE('yyb11 ','screenW: '..screenW..' screenH: '..screenH..' inputW: '..inputW..' inputH: '..inputH)
    self.material:setFloat('inputRatio', inputRatio)

    self.material:setFloat('widthIORatio', math.max(screenW/inputW,screenH/inputH));
    -- self.material:setFloat('widthIORatio', screenW/inputW);
    -- Amaz.LOGE('yyb ','outputRatio: '..ratio..' inputRatio: '..inputRatio..' widthIORatio: '..screenW/inputW)

    local parentTrans = self.canvas:getComponent("Transform")
    local aaTrans = self.aa:getComponent("Transform")
    -- export bug
    local scale = parentTrans.localScale.x * aaTrans.localScale.x
    if ratio > inputRatio then
        scale = scale / (screenH / inputH)
    else
        scale = scale / (screenW / inputW)
    end

    local mat = Amaz.Matrix4x4f()
    mat:setTRS(
        parentTrans.localPosition,
        parentTrans.localOrientation,
        Amaz.Vector3f(scale, scale, scale)
    )
    local invMat = Amaz.Matrix4x4f()
    invMat:setTRS(
        parentTrans.localPosition,
        parentTrans.localOrientation,
        Amaz.Vector3f(scale, scale, scale)
    )
    invMat:Invert_Full()
    self.material:setMat4('u_Mat', mat)
    self.material:setMat4('u_InvMat', invMat)
    self.material:setTex('u_InputTex', self.scene:getInputTexture(1)) 

    if self.props == nil then
        self.props = self.entity:getComponent("ScriptComponent").properties
    end
    local swing_index = self.props:get("enable_swing_render_index")
    self.material:setFloat('swing_index', swing_index and 1 or 0) 
end

function Transform:setDuration(duration)
    self.duration = duration
end

function Transform:clear()
end
exports.Transform = Transform
return exports
