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

-- ================ccccc================

local function funcEaseAction1(t, b, c, d)
    t = t/d
    -- ccccc
    local controls = {.15,.95,.3,1}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction1(t, b, c, d)
    t = t/d
    -- ccccc
    local controls = {.15,.95,.3,1}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

-- t 0 1
local function AE(t, b, c, d)
    -- 5
    local data = {0,1,2,3,4}
    local item = data[(t * .8 + 1) * #data]
    return item
end

local function funcEaseBlurAction2(t, b, c, d)
    t = t/d
    -- ccccc
    local controls = {1,.01,.98,.08}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

local function funcEaseAction2(t, b, c, d)
    t = t/d
    -- ccccc
    local controls = {1,.01,.98,.08}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end
local function funcEaseAction3(t, b, c, d)
    t = t/d
    -- ccccc
    local controls = {.64,0,.78,0}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction4(t, b, c, d)
    t = t/d
    -- ccccc
    local controls = {1,.01,.89,.15}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

local function funcEaseAction5(t, b, c, d)
    t=t/d
    -- ccccc
    if t~=0.0 and t~=1.0 then
        t = math.exp(-7.0 * t) * 1.0 * math.sin((t - 0.075) * (2.0*math.pi) / 0.3) + 1.0
    end
    return Amaz.Ease.linearFunc(t,c,b)
end

local function funcEaseBlurAction5(t, b, c, d)
    t=t/d
    -- ccccc
    t = (-7 * math.exp(-7.0 * t) * 1.0 * math.sin((t - 0.075) * (2.0*math.pi) / 0.3) + math.exp(-7.0 * t) * 1.0 * math.cos((t - 0.075) * (2.0*math.pi) / 0.3) * 2.0 * math.pi / 0.3) * 0.1    
    
    return c * t
end

-- ================ccccc================

function Transform.new(construct, ...)
    local self = setmetatable({}, Transform)
    self.material = nil
    self.duration = 0
    self.values = {}
    
    -- ccccc
    self.actions = 
    {
        -- {
        --     startScale = Amaz.Vector3f(4.0, 4.0, 4.0),
        --     endScale = Amaz.Vector3f(4.0, 4.0, 4.0),
        --     actionFunction = funcEaseAction1,
        --     startTime = 0.0,
        --     endTime = 1.0
        -- },
        -- {
        --     startRotate = Amaz.Vector3f(0.0, 0.0, -90.0),
        --     endRotate = Amaz.Vector3f(0.0, 0.0, 0.0),
        --     actionFunction = funcEaseAction2,
        --     startTime = 0.0,
        --     endTime = 1.0
        -- },
        {
            -- ccccc
            blurIntensity = 0.04,
            -- ccccc
            blurType = 0,
            -- ccccc
            blurDirection = Amaz.Vector2f(1, 0),
            -- ccccc
            actionFunction = funcEaseBlurAction1,
            -- ccccc
            startTime = 0.0,
            -- ccccc
            endTime = 0.8
        },
        {
            -- ccccc
            key = "leftScale",
            startValue = 2,
            endValue = 1.0,
            defaultValue = 2.0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction1,
            startTime = 0.0,
            endTime = 0.8
        }, 
        {
            -- ccccc
            key = "rightScale",
            startValue = 2,
            endValue = 1.0,
            defaultValue = 2.0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction1,
            startTime = 0.0,
            endTime = 0.8
        },
        {
            -- ccccc
            key = "leftOffsetX",
            startValue = 0,
            endValue = -.025,
            defaultValue = 0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction2,
            startTime = 0.2,
            endTime = 1.
        },
        {
            -- ccccc
            key = "leftOffsetY",
            startValue = 0,
            endValue = -2,
            defaultValue = 0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction2,
            startTime = 0.2,
            endTime = 1.
        },
        {
            -- ccccc
            key = "rightOffsetX",
            startValue = 0,
            endValue = .025,
            defaultValue = 0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction2,
            startTime = 0.2,
            endTime = 1.
        },
        {
            -- ccccc
            key = "rightOffsetY",
            startValue = 0,
            endValue = 2,
            defaultValue = 0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction2,
            startTime = 0.2,
            endTime = 1.
        },
    }



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

-- ccccc！！！
-- function Transform:onUpdate(comp, deltaTime)
--     if self.tweenDirty then
--         self.blend = comp.entity.scene:findEntityBy("Root")
--         self.blendMaterial = self.blend:getComponent("Sprite2DRenderer").material

--         self.time = 0.0
--         -- ccccc
--         self.duration = 3.0
--         -- ccccc
--         self.resetDuration = 3.5

--         for i = 1, #self.actions do
--             local action = self.actions[i]
--             if action.startPosition ~= nil then
--                 action.startPosition.y = -action.startPosition.y
--             end
--             if action.endPosition ~= nil then
--                 action.endPosition.y = -action.endPosition.y
--             end
--             if action.startRotate ~= nil then
--                 action.startRotate.z = -action.startRotate.z
--             end
--             if action.endRotate ~= nil then
--                 action.endRotate.z = -action.endRotate.z
--             end

--         end

--     end

--     self.time = self.time + deltaTime

--     if self.time > self.duration then
--         self:seek(self.duration)
--     else
--         self:seek(self.time)
--     end
    
--     if self.time > self.resetDuration then
--         self.time = 0.0
--     end
-- end

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
    -- ccccc
    local userS = parentTrans.localScale
    local userR = parentTrans.localOrientation
    local userT = parentTrans.localPosition

    -- ccccc
    local animS = animTrans.localScale
    local animR = animTrans.localOrientation
    local animT = animTrans.localPosition

    local mat = parentTrans.localMatrix

    local matA = animTrans.localMatrix

    -- ccccc
    local userM = parentTrans.localMatrix
    userM:SetTRS(Amaz.Vector3f(0.0, 0.0, 0.0), userR, userS)

    -- move to (0,0)
    -- ccccc
    matA:SetTRS(animT, animR, animS)
    matA:AddTranslate(userT)

    -- ccccc
    -- ccccc
    -- animTrans.localMatrix = matA * userM * parentTrans.localMatrix:Invert_Full()
    animTrans.localMatrix = matA * userM
end

function Transform:seek(time)
    checkDirty(self)
    -- ccccc
    local animTrans = self.vfx:getComponent("Transform")
    animTrans.localMatrix = animTrans.localMatrix:SetIdentity()

    -- ccccc
    self.blendMaterial["_alpha"] = 1.0

    -- ccccc
    for i = 1, #self.actions do
        local action = self.actions[i]
        if action.key ~= nil then
            action.actionHandle(self, action.key, action.defaultValue)
        end
    end

    -- ccccc
    self.material:enableMacro("BLUR_TYPE", 0)
    self.material["blurStep"] = 0
    for i = 1, #self.actions do
        local action = self.actions[i]
        local normalTime = time / self.duration

        if normalTime >= action.startTime and normalTime <= action.endTime then
            if action.blurType ~= nil then
                self.material:enableMacro("BLUR_TYPE", action.blurType)
                self.material["blurDirection"] = action.blurDirection
            end
            action.tween:set(time - action.startTime * self.duration)
            if action.key ~= nil then
                action.actionHandle(self, action.key, self.values[action.key])
            end
        else
            if action.key ~= nil then
                if normalTime < action.startTime then
                    action.actionHandle(self, action.key, action.defaultValue)
                end
                if normalTime > action.endTime then
                    action.actionHandle(self, action.key, action.endValue)
                end
            end
        end
    end
    
    -- ccccc
    -- ccccc
    -- ccccc
    -- ccccc
    -- updateHandle(self.vfx, self.canvas)

    local screenW = Amaz.BuiltinObject:getOutputTextureWidth()
    local screenH = Amaz.BuiltinObject:getOutputTextureHeight()
    local ratio = screenW / screenH

    local inputW = Amaz.BuiltinObject.getInputTextureWidth()
    local inputH = Amaz.BuiltinObject.getInputTextureHeight()
    local inputRatio = inputW / inputH
    self.material:setFloat('inputRatio', inputRatio)

    local parentTrans = self.canvas:getComponent("Transform")
    local aaTrans = self.aa:getComponent("Transform")
    -- export bug
    local scale = parentTrans.localScale.x * aaTrans.localScale.x
    if ratio > inputRatio then
        scale = scale / (screenH / inputH)
    else
        scale = scale / (screenW / inputW)
    end
    -- if ratio > 1.01 and inputRatio < .99 then
    --     if ratio > 1.4 then
    --         if inputRatio > .6 then
    --             scale = scale * 1 / inputRatio
    --         else
    --             scale = scale * ratio
    --         end
    --     else
    --         scale = scale * 1. / inputRatio
    --     end
    -- elseif ratio < .99 and inputRatio > 1.01 then
    --     if ratio < .6 then
    --         scale = scale * inputRatio
    --     else
    --         scale = scale * 1 / ratio
    --     end
    -- end
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
end

function Transform:setDuration(duration)
    self.duration = duration
    self.tweenDirty = true
end

function Transform:clear()
    self.tweenDirty = true
    -- ccccc
    local animTrans = self.vfx:getComponent("Transform")
    animTrans.localMatrix = animTrans.localMatrix:SetIdentity()
    self.blendMaterial["_alpha"] = 1.0

    -- ccccc
    for i = 1, #self.actions do
        local action = self.actions[i]
        if action.key ~= nil and action.defaultValue ~= nil then
            action.actionHandle(self, action.key, action.defaultValue)
        end
    end
end
exports.Transform = Transform
return exports
