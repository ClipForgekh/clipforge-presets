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

-- ================================

local function funcEaseAction1(t, b, c, d)
    t = t/d
    -- ，
    local controls = {0.27, 0.87, 0.35, 0.98}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction1(t, b, c, d)
    t = t/d
    -- ，
    local controls = {0.27, 0.87, 0.35, 0.98}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

local function funcEaseAction2(t, b, c, d)
    t = t/d
    -- ，
    local controls = {.06,.81,.09,1.02}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseAction3(t, b, c, d)
    t = t/d
    -- ，
    local controls = {.65,0.02,.73,.13}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction3(t, b, c, d)
    t = t/d
    -- ，
    local controls = {.65,0.02,.73,.13}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

local function funcEaseAction4(t, b, c, d)
    t = t/d
    -- ，
    local controls = {0.11, 0, 0.5, 0}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction2(t, b, c, d)
    t = t/d
    -- ，
    local controls = {1,.01,.89,.15}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

local function funcEaseAction2(t, b, c, d)
    t=t/d
    -- ，
    if t~=0.0 and t~=1.0 then
        t = math.exp(-7.0 * t) * 1.0 * math.sin((t - 0.075) * (1.5*math.pi) / 0.3) + 1.0
    end
    return Amaz.Ease.linearFunc(t,c,b)
end

local function funcEaseBlurAction2(t, b, c, d)
    t=t/d
    -- ，
    t = (-7 * math.exp(-7.0 * t) * 1.0 * math.sin((t - 0.075) * (1.5*math.pi) / 0.3) + math.exp(-7.0 * t) * 1.0 * math.cos((t - 0.075) * (2.0*math.pi) / 0.3) * 2.0 * math.pi / 0.3) * 0.1    
    
    return c * t
end

-- ================================

function Transform.new(construct, ...)
    local self = setmetatable({}, Transform)
    self.material = nil
    self.duration = 0
    self.values = {}

    self.defaultAnchor = Amaz.Vector3f(0,0,0);
    self.anchor = Amaz.Vector3f(0,0,0);
    self.delta = Amaz.Vector3f(0,0,0);

    self.anim0Start = 0.0;
    self.anim0End = 1.0;
    self.anchor0 = Amaz.Vector3f(1.0, 0.0, 0);

    self.anim1Start = 0.0;
    self.anim1End = 0.0;
    self.anchor1 = Amaz.Vector3f(1.0, 0.0, 0);

    self.moveStart = 0.0;
    self.moveEnd = 0.0;
    self.moveDis = Amaz.Vector3f(0,0,0);
    self.moveFunc = funcEaseAction4;

    -- 
    self.actions = 
    {
        -- {
        --     startScale = Amaz.Vector3f(1.0, 1.0, 1.0),
        --     endScale = Amaz.Vector3f(1.0, 1.0, 1.0),
        --     actionFunction = funcEaseAction1,
        --     startTime = 0.5,
        --     endTime = 1.0
        -- },
        {
            -- 
            blurIntensity = 0.0,
            -- ，0，1，2
            blurType = 0,
            -- ，0，0
            blurDirection = Amaz.Vector2f(1, 0),
            -- 
            actionFunction = funcEaseBlurAction1,
            -- 
            startTime = 0.0,
            -- 
            endTime = 1
        },

        --  
        {
            startRotate = Amaz.Vector3f(0.0, 0.0, 0.0),
            endRotate = Amaz.Vector3f(0.0, 0.0, 75.0),
            actionFunction = funcEaseAction3,
            startTime = self.anim0Start,
            endTime = self.anim0End
        },
        {
            key = "blurScale",
            startValue = 0.0,
            endValue = 1.5,
            defaultValue = 0.0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction3,
            startTime = self.anim0Start,
            endTime = self.anim0End
        },
        --  
        {
            startRotate = Amaz.Vector3f(0.0, 0.0, 0.0),
            endRotate = Amaz.Vector3f(0.0, 0.0, 0.0),
            actionFunction = funcEaseAction3,
            startTime = self.anim1Start,
            endTime = self.anim1End
        },
        {
            key = "blurScale",
            startValue = 0.0,
            endValue = 0.0,
            defaultValue = 0.0,
            actionHandle = function(comp, key, value)
                comp.material:setFloat(key, value)
            end,
            actionFunction = funcEaseAction3,
            startTime = self.anim1Start,
            endTime = self.anim1End
        }
        
        -- {
        --     -- 
        --     blurIntensity = 7.0,
        --     -- ，0，1，2
        --     blurType = 0,
        --     -- ，0，0
        --     blurDirection = Amaz.Vector2f(-1, 0),
        --     -- 
        --     actionFunction = funcEaseAction1,
        --     -- 
        --     startTime = 0.0,
        --     -- 
        --     endTime = 1.0
        -- },
    }

    if construct and Transform.constructor then Transform.constructor(self, ...) end
    return self
end

function Transform:constructor()

end

function Transform:onStart(comp)
    self.vfx = comp.entity.scene:findEntityBy("Blur")
    self.canvas = comp.entity.scene:findEntityBy("Root")
    self.blend = comp.entity.scene:findEntityBy("Canvas")
    local transform = comp.entity:getComponent("Transform")
    transform.localPosition = Amaz.Vector3f(0.0, 0.0, 0.0)
    self.material = self.vfx:getComponent("Sprite2DRenderer").material
    if self.blend ~= nil then
        self.blendMaterial = self.blend:getComponent("Sprite2DRenderer").material
    end
    self.tweenDirty = true
    self.delta = Amaz.Vector3f(0,0,0);
end

-- ，！！！
-- function Transform:onUpdate(comp, deltaTime)
--     if self.tweenDirty then
--         self.blend = comp.entity.scene:findEntityBy("Root")
--         self.blendMaterial = self.blend:getComponent("Sprite2DRenderer").material

--         self.time = 0.0
--         -- ，
--         self.duration = 3.0
--         -- 
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

local function printVector(s, a) 
    print(s.." x="..a.x.." y="..a.y);
end

local function updateHandle(self, entity, canvas, delta)
    if entity == nil then
        return
    end

    -- local sprite = entity:getComponent("Sprite2DRenderer");
    local textureW = Amaz.BuiltinObject:getInputTextureWidth();
    local textureH = Amaz.BuiltinObject:getInputTextureHeight();
    local screenW = Amaz.BuiltinObject:getOutputTextureWidth();
    local screenH = Amaz.BuiltinObject:getOutputTextureHeight();
    local width = textureW / screenW;
    local height = textureH / screenH;
    local maxWidth = screenW / screenH;
    local maxHeight = 1.0;

    -- print("textureW="..textureW.." screenW="..screenW.." width="..width)

    local animTrans = entity:getComponent("Transform")
    local parentTrans = canvas:getComponent("Transform")
    -- TRS
    local userS = parentTrans.localScale
    local userR = parentTrans.localOrientation
    local userT = parentTrans.localPosition

    -- TRS
    local animS = animTrans.localScale
    local animR = animTrans.localOrientation
    local animT = animTrans.localPosition
    --printVector("animT",animT);

    -------- test ----------

    -- local anchor = Amaz.Vector3f(0, -1.0, 0);      --  🌛🌛

    --anchor = anchor:Scale(Amaz.Vector3f(2,2,0)) - Amaz.Vector3f(1,1,0);
    -- local anchor = self.anchor;
    local anchor = Amaz.Vector3f(0,0,0);
    anchor.x = self.anchor.x;
    anchor.y = self.anchor.y;
    anchor = anchor:Scale(Amaz.Vector3f(1,-1,0));

    local anchorPointInScreen = anchor:Scale(Amaz.Vector3f(textureW, textureH, 0));         
    local anchorPoint = anchorPointInScreen:Scale(Amaz.Vector3f(1 / screenH, 1 / screenH, 0));     -- 
    local anchorOffset = anchorPoint:Scale(userS);                   
    local offset = anchorOffset;
    -- printVector(offset, "anchorOffset");

    local offsetMat = Amaz.Matrix4x4f();
    offsetMat:SetTranslate(-offset);
    local rotateMat = Amaz.Matrix4x4f();
    rotateMat:SetTR(Amaz.Vector3f(0,0,0), animR);
    local returnMat = Amaz.Matrix4x4f();
    returnMat:SetTranslate(offset);
    -- animTrans.localMatrix = returnMat * rotateMat * offsetMat;
    
    -- move to (0,0)
    -- matATransform+
    local matA = returnMat * rotateMat * offsetMat;
    matA:AddTranslate(userT + delta);
    
    -- EntityEntity
    -- transform，
    -- userM
    local userM = Amaz.Matrix4x4f();
    userM:SetTRS(Amaz.Vector3f(0.0, 0.0, 0.0), userR, userS)
    animTrans.localMatrix = matA * userM * parentTrans.localMatrix:Invert_Full()

    -- ，center[0,1]²。
    -- ，。
    local scr = Amaz.Vector2f(maxWidth, maxHeight);
    local offset_xy = Amaz.Vector2f(offset.x + userT.x + delta.x, offset.y + userT.y + delta.y);
    local tmp = offset_xy + scr;
    local center = tmp:Scale(Amaz.Vector2f(0.5, 0.5));
    center.x = center.x / maxWidth;
    -- printVector("center", center);
    self.material:setVec2("center", center);
    ------------------------
    -- local mat = parentTrans.localMatrix
    -- local matA = animTrans.localMatrix

    -- -- mat
    -- local mat = parentTrans.localMatrix
    -- mat:SetTRS(-offset, userR, userS)

    -- -- move to (0,0)
    -- -- matATransform+
    -- matA:SetTRS(animT, animR, animS)
    -- matA:AddTranslate(userT)

    -- -- EntityEntity
    -- -- transform，
    -- animTrans.localMatrix = matA * mat * parentTrans.localMatrix:Invert_Full()

    ----------------------
    -- local mat = Amaz.Matrix4x4f()
    -- mat:Copy(parentTrans.localMatrix)
    -- mat:AddTranslate(Amaz.Vector3f(-userT.x, -userT.y, -userT.z))
    -- mat:AddTranslate(Amaz.Vector3f(width / userS.x, 0, 0))

    -- --anim rotate scale
    -- local rot = Amaz.Matrix4x4f()
    -- rot:SetIdentity()
    -- rot:SetTR(Amaz.Vector3f(0,0,0), animR)
    -- mat = rot * mat

    -- -- move back 
    -- mat:AddTranslate(Amaz.Vector3f(-width / userS.x, 0, 0))
    -- mat:AddTranslate(userT)

    -- -- set anim local matrix
    -- local animLocal = parentTrans.localMatrix:Invert_Full() * mat
    -- animTrans.localMatrix = animLocal

end

function Transform:seek(time)
    checkDirty(self)
    -- Transform，seek
    local animTrans = self.vfx:getComponent("Transform")
    animTrans.localMatrix = animTrans.localMatrix:SetIdentity()

    -- seek，seek
    for i = 1, #self.actions do
        local action = self.actions[i]
        if action.key ~= nil then
            action.actionHandle(self, action.key, action.defaultValue)
        end
    end

    -- seek
    local normalTime = time / self.duration
    for i = 1, #self.actions do
        local action = self.actions[i]
        -- local normalTime = time / self.duration

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

    --  
    if (normalTime >= self.anim0Start and normalTime <= self.anim0End) then
        self.anchor = self.anchor0;
        -- printVector("anchor", self.anchor);
        -- printVector("anchor0", self.anchor0);
    elseif (normalTime >= self.anim1Start and normalTime <= self.anim1End) then
        self.anchor = self.anchor1;
        -- printVector("anchor", self.anchor );
    else
        self.anchor = self.defaultAnchor;
    end

    --  
    if (normalTime < self.moveStart) then
        self.delta = Amaz.Vector3f(0,0,0);
    elseif (normalTime <= self.moveEnd) then
        self.delta = self.moveFunc(normalTime - self.moveStart, Amaz.Vector3f(0,0,0), self.moveDis, self.moveEnd - self.moveStart);
    end
    
    -- TRSTRS
    -- 
    -- 
    -- 
    updateHandle(self, self.vfx, self.canvas, self.delta)
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
        if action.key ~= nil then
            action.actionHandle(self, action.key, action.defaultValue)
        end
    end
    self.delta = Amaz.Vector3f(0,0,0);
    self.anchor = self.defaultAnchor;
end
exports.Transform = Transform
return exports
