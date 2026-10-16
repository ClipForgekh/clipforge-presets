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

local function funcEaseAction2(t, b, c, d)
    t = t/d
    -- ccccccccc，ccccccc
    local controls = {0.85, 0, 0.9, 0}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction2(t, b, c, d)
    t = t/d
    -- ccccccccc，ccccccc
    local controls = {0.85, 0, 0.9, 0}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

local function funcEaseAction1(t, b, c, d)
    t = t/d
    -- ccccccccc，ccccccc
    local controls = {.1,1,.15,1}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction1(t, b, c, d)
    t = t/d
    -- ccccccccc，ccccccc
    local controls = {.1,1,.15,1}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

-- local function funcEaseAction3(t, b, c, d)
--     t = t/d
--     -- ccccccccc，ccccccc
--     local controls = {0,-1.61,1,-0.18}
--     local tvalue = getBezierTfromX(controls, t)
--     local value =  getBezierValue(controls, tvalue)
--     return b + c * value[2]
-- end

-- local function funcEaseAction3(t, b, c, d)
--     t=t/d
--     if t~=0.0 and t~=1.0 then
--         t = math.exp(-7.0 * t) * 1.0 * math.sin((t - 0.075) * (2.0*math.pi) / 0.3) + 1.0
--     end
--     return Amaz.Ease.linearFunc(t,c,b)
-- end

local function funcEaseAction3(t, b, c, d)
    t=t/d
    -- ccccccccc，ccccccc
    if t~=0.0 and t~=1.0 then
        t = math.pow(2, -10 * (t/ 2.0)) * math.sin((t/2.0 - 0.4 / 4) * (2 *math.pi) / 0.4) + 1
    end
    return Amaz.Ease.linearFunc(t,c,b)
end

-- ================ccccc================

function Transform.new(construct, ...)
    local self = setmetatable({}, Transform)
    self.material = nil
    self.duration = 0
    self.values = {}
    
    -- cccccc
    self.actions = 
    {
        -- {
        --     -- cccccc【cc】
        --     startRotate = Amaz.Vector3f(0.0, 0.0, -4.0),
        --     -- cccccc,ccccccccc【cc】
        --     endRotate = Amaz.Vector3f(0.0, 0.0, -4.0),
        --     -- cccccccc【cc】
        --     startScale = Amaz.Vector3f(1.8, 1.8, 1.0),
        --     -- cccccccc，ccccccccc【cc】
        --     endScale = Amaz.Vector3f(0.6, 0.6, 1.0),
        --     -- cccc【cc】
        --     actionFunction = funcEaseAction1,
        --     -- cccc【cc】
        --     startTime = 0.0,
        --     -- cccc【cc】
        --     endTime = 1.0
        -- },
        -- -- ccccc，cccc，cccccccc，ccccc0.0～1.0
        -- {
        --     -- cccc
        --     startPosition = Amaz.Vector3f(0.0, 0.05, 0.0),
        --     -- cccc
        --     endPosition = Amaz.Vector3f(0.0, 0.0, 0.0),
        --     -- cccc
        --     actionFunction = funcEaseAction3,
        --     -- cccc
        --     startTime = 0.0,
        --     -- cccc
        --     endTime = 1.0
        -- },
        {
            -- cccc
            blurIntensity = 0.0,
            -- cccc，0ccc，1cc，2cc
            blurType = 1,
            -- cccc，ccccc0，0
            blurDirection = Amaz.Vector2f(1, 0),
            -- cccc
            actionFunction = funcEaseBlurAction2,
            -- cccc
            startTime = 0.0,
            -- cccc
            endTime = 1.0
        },
        {
            key = "offset",
            startValue = 0.0,
            endValue = 1.4,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction2,
            startTime = 0.0,
            endTime = 1
        },
        {
            key = "texscale",
            startValue = 2,
            endValue = 0.85,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction1,
            startTime = 0,
            endTime = 1
        },
        {
            key = "rorate",
            startValue = -90,
            endValue = 0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction1,
            startTime = 0,
            endTime = 1
        }
        -- {
        --     -- cccccc【cc】
        --     startRotate = Amaz.Vector3f(0.0, 0.0, -4.0),
        --     -- cccccc,ccccccccc【cc】
        --     endRotate = Amaz.Vector3f(0.0, 0.0, -4.0),
        --     -- cccccccc【cc】
        --     startScale = Amaz.Vector3f(1.0, 1.0, 1.0),
        --     -- cccccccc，ccccccccc【cc】
        --     endScale = Amaz.Vector3f(0.6, 0.6, 1.0),
        --     -- cccc【cc】
        --     actionFunction = funcEaseAction2,
        --     -- cccc【cc】
        --     startTime = 0.7,
        --     -- cccc【cc】
        --     endTime = 1.0
        -- },
        -- {
        --     -- cccc
        --     blurIntensity = 0.05,
        --     -- cccc，0ccc，1cc，2cc
        --     blurType = 2,
        --     -- cccc，ccccc0，0
        --     blurDirection = Amaz.Vector2f(1, 0),
        --     -- cccc
        --     actionFunction = funcEaseBlurAction2,
        --     -- cccc
        --     startTime = 0.7,
        --     -- cccc
        --     endTime = 1.0
        -- }
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

-- cccccccc，cccccccccc！！！
-- function Transform:onUpdate(comp, deltaTime)
--     if self.tweenDirty then
--         self.blend = comp.entity.scene:findEntityBy("Root")
--         self.blendMaterial = self.blend:getComponent("Sprite2DRenderer").material

--         self.time = 0.0
--         -- cccc，cccccc
--         self.duration = 3.0
--         -- cccccccc
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

function Transform:seek(time)
    checkDirty(self)
    local animTrans = self.vfx:getComponent("Transform")
    animTrans.localMatrix = animTrans.localMatrix:SetIdentity()

    -- seekccccccccccc1.0，ccccccccccc
    self.blendMaterial["_alpha"] = 1.0

    -- seekccccccccccccccccc，ccccccccseekcc
    for i = 1, #self.actions do
        local action = self.actions[i]
        if action.key ~= nil then
            action.actionHandle(self, action.key, action.defaultValue)
        end
    end

    for i = 1, #self.actions do
        local action = self.actions[i]
        local normalTime = time / self.duration

        if normalTime >= action.startTime and normalTime <= action.endTime then
            if action.blurType ~= nil then
                self.material:enableMacro("BLUR_TYPE", action.blurType)
            end
            action.tween:set(time - action.startTime * self.duration)
            if action.key ~= nil then
                action.actionHandle(self, action.key, self.values[action.key])
            end
        end
    end    

    --updateHandle(self.vfx, self.canvas)

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
    local invMat = Amaz.Matrix4x4f()
    invMat:setTRS(
        parentTrans.localPosition,
        parentTrans.localOrientation,
        Amaz.Vector3f(scale, scale, scale)
    )
    invMat:Invert_Full()
    --self.material:setMat4('u_Mat', mat)
    self.material:setMat4('u_InvMat', invMat)
    local u_InputTex = self.scene:getInputTexture(1)
    self.material:setTex('u_InputTex', u_InputTex)
    self.material:setVec2('inputSize', Amaz.Vector2f(u_InputTex.width, u_InputTex.height))
    --1
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
    for i = 1, #self.actions do
        local action = self.actions[i]
        action.tween:set(0)
        action.tween:clear()
        action.tween = nil
    end
end
exports.Transform = Transform
return exports
