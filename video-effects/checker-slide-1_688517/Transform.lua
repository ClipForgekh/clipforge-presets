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
                {0, 1, 0, 0.5, {1,.01,.98,.08}},
            },
            ['allScale'] = {
                {0, 1, 2.3, 1., {.15,.95,.3,1}},
            },
            ['move2X'] = {
                {0, 1, 0., 0., {0.7, 0, 0.84, 0}},
            },
            ['move2Y'] = {
                {0, 1, -0.1, 0, {0.34, 1.56, 0.64, 1}},
            },
            ['blur'] = {
                {0, 1, 0., 0., {1,.01,.98,.08}},
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

local function checkDirty(self)
    if self.tweenDirty then
        local transform = self.vfx:getComponent("Transform")
        local screenW = Amaz.BuiltinObject:getOutputTextureWidth()
        local screenH = Amaz.BuiltinObject:getOutputTextureHeight()
        local ratio = screenW / screenH

        for i = 1, #self.actions do
            local action = self.actions[i]
            local from = {}
            local to = {}
            local target = nil;
            if action.startPosition ~= nil then
                target = transform
                action.startPosition.x = action.startPosition.x * ratio
                from["localPosition"] = action.startPosition
            end

            if action.startScale ~= nil then
                target = transform
                from["localScale"] = action.startScale
            end

            if action.startRotate ~= nil then
                target = transform
                from["localEulerAngle"] = action.startRotate
            end


            if action.endPosition ~= nil then
                target = transform
                action.endPosition.x = action.endPosition.x * ratio
                to["localPosition"] = action.endPosition
            end

            if action.endScale ~= nil then
                target = transform
                to["localScale"] = action.endScale
            end

            if action.endRotate ~= nil then
                target = transform
                to["localEulerAngle"] = action.endRotate
            end

            if action.endRotate ~= nil then
                target = transform
                to["localEulerAngle"] = action.endRotate
            end
            
            if action.blurType ~= nil then
                target = self.material
                self.material:enableMacro("BLUR_TYPE", 1)
                self.material["blurDirection"] = action.blurDirection
                from["blurStep"] = action.blurIntensity / (self.duration * (action.endTime - action.startTime))
                to["blurStep"] = 0.0
            end

            if action.startAlpha ~= nil then
                target = self.blendMaterial
                from["_alpha"] = action.startAlpha
            end

            if action.endAlpha ~= nil then
                target = self.blendMaterial
                to["_alpha"] = action.endAlpha
            end

            if action.key ~= nil then
                target = self.values
                from[action.key] = action.startValue
                to[action.key] = action.endValue
            end

            action.tween = self.canvas.scene.tween:fromTo(target, 
                                                             from,
                                                             to,
                                                             self.duration * (action.endTime - action.startTime),
                                                             action.actionFunction,
                                                             nil, 
                                                             0.0, 
                                                             nil, 
                                                             false)            

        end
                                                
        self.tweenDirty = false

    end
end

local function updateHandle(entity, canvas)
    if entity == nil then
        return
    end

    local animTrans = entity:getComponent("Transform")
    local parentTrans = canvas:getComponent("Transform")
    
    local userS = parentTrans.localScale
    local userR = parentTrans.localOrientation
    local userT = parentTrans.localPosition

    local animS = animTrans.localScale
    local animR = animTrans.localOrientation
    local animT = animTrans.localPosition

    local mat = parentTrans.localMatrix

    local matA = animTrans.localMatrix

    local userM = parentTrans.localMatrix
    userM:SetTRS(Amaz.Vector3f(0.0, 0.0, 0.0), userR, userS)

    -- move to (0,0)
    matA:SetTRS(animT, animR, animS)
    matA:AddTranslate(userT)

    animTrans.localMatrix = matA * userM * parentTrans.localMatrix:Invert_Full()
end

function Transform:_logScene()
    local entities = self.entity.scene.entities
    for i = 1, entities:size() do
        Amaz.LOGI("lrc", "=========== "..i.." start =============")
        local entity = entities:get(i-1)
        local name = entity.name
        local trans = entity:getComponent("Transform")

        local comps = entity.components
        Amaz.LOGI("lrc entity name", name)

        if trans then
            local parent = trans.parent
            if parent then
                -- body
                Amaz.LOGI("lrc parent name", trans.parent.entity.name)
            end
            Amaz.LOGI("lrc children size", tostring(trans.children:size()))
            Amaz.LOGI("lrc pos", tostring(trans.localPosition))
            Amaz.LOGI("lrc scale", tostring(trans.localScale))
            Amaz.LOGI("lrc angle", tostring(trans.localEulerAngle))
        end

        Amaz.LOGI("lrc", "=========== "..i.." end =============")
    end
end

function Transform:seek(time)
    -- ccccc
    local animTrans = self.vfx:getComponent("Transform")
    animTrans.localMatrix = animTrans.localMatrix:SetIdentity()
    -- Amaz.LOGI("lrc seek", time)
    -- self:_logScene()


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

    Amaz.LOGI("lrc inputWidth", inputW)
    Amaz.LOGI("lrc inputHeight", inputH)
    -- self.material:setFloat('inputWidth', inputW)
    -- self.material:setFloat('inputHeight', inputH)
    self.material:setFloat('inputRatio', inputRatio)

    -- self.material:setFloat('widthIORatio', screenW/inputW);
    self.material:setFloat('widthIORatio', math.max(screenW/inputW,screenH/inputH));

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
    local u_InputTex = self.scene:getInputTexture(1)
    self.material:setTex('u_InputTex', u_InputTex) 
    self.material:setVec2('inputSize', Amaz.Vector2f(u_InputTex.width, u_InputTex.height))

    if self.props == nil then
        self.props = self.entity:getComponent("ScriptComponent").properties
    end
    local swing_index = self.props:get("enable_swing_render_index")
    self.material:setFloat('swing_index', swing_index and 1 or 0) 

    -- local screenW = Amaz.BuiltinObject:getOutputTextureWidth()
    -- local screenH = Amaz.BuiltinObject:getOutputTextureHeight()
    -- local ratio = screenW / screenH

    -- local inputW = Amaz.BuiltinObject.getInputTextureWidth()
    -- local inputH = Amaz.BuiltinObject.getInputTextureHeight()
    -- local inputRatio = inputW / inputH
    -- self.material:setFloat('inputRatio', inputRatio)


    -- local parentTrans = self.canvas:getComponent("Transform")
    -- local aaTrans = self.aa:getComponent("Transform")
    -- -- export bug
    -- local scale = parentTrans.localScale.x * aaTrans.localScale.x
    -- if ratio > inputRatio then
    --     scale = scale / (screenH / inputH)
    -- else
    --     scale = scale / (screenW / inputW)
    -- end
    -- local invMat = Amaz.Matrix4x4f()
    -- invMat:setTRS(
    --     parentTrans.localPosition,
    --     parentTrans.localOrientation,
    --     Amaz.Vector3f(scale, scale, scale)
    -- )
    -- invMat:Invert_Full()
    -- --self.material:setMat4('u_Mat', mat)
    -- self.material:setMat4('u_InvMat', invMat)
    -- local u_InputTex = self.scene:getInputTexture(1)
    -- self.material:setTex('u_InputTex', u_InputTex)
    -- self.material:setVec2('inputSize', Amaz.Vector2f(u_InputTex.width, u_InputTex.height))

    -- if self.props == nil then
    --     self.props = self.entity:getComponent("ScriptComponent").properties
    -- end
    -- local swing_index = self.props:get("enable_swing_render_index")
    -- self.material:setFloat('swing_index', swing_index and 1 or 0) 
end

function Transform:setDuration(duration)
    self.duration = duration
end

function Transform:clear()
end
exports.Transform = Transform
return exports
