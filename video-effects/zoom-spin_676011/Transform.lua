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

local function funcEaseAction1(t, b, c, d)
    t = t/d
    -- 第一阶段的位移曲线，贝塞尔曲线版本
    local controls = {.06,.81,.09,1.02}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction1(t, b, c, d)
    t=t/d
    -- 第一阶段的模糊曲线，要和上面的位移曲线一致
    local controls = {.06,.81,.09,1.02}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

local function funcEaseAction2(t, b, c, d)
    t = t/d
    -- 第二阶段的位移曲线，贝塞尔曲线版本
    local controls = {1,.01,.89,.15}
    local tvalue = getBezierTfromX(controls, t)
    local value =  getBezierValue(controls, tvalue)
    return b + c * value[2]
end

local function funcEaseBlurAction2(t, b, c, d)
    t=t/d
    -- 第二阶段的模糊曲线，要和上面的位移曲线一致
    local controls = {1,.01,.89,.15}
    local tvalue = getBezierTfromX(controls, t)
    local deriva = getBezierDerivative(controls, tvalue)
    return math.abs(deriva[2] / deriva[1]) * c
end

function Transform.new(construct, ...)
    local self = setmetatable({}, Transform)
    self.material = nil
    self.tweenTransform1 = nil
    self.tweenBlur1 = nil
    self.tweenTransform2 = nil
    self.tweenBlur2 = nil
    self.duration = 0
    -- 阶段一
    -- 设置起始点
    self.startPoint1 = Amaz.Vector3f(0.0, 0.0, 0.0)
    -- 设置起始点旋转方向
    self.startRotate1 = Amaz.Vector3f(0.0, 0.0, 0.0)
    -- 设置起始点缩放系数
    self.startScale1 = Amaz.Vector3f(1.9, 1.9, 1.0)
    -- 设置结束点
    self.endPoint1 = Amaz.Vector3f(0.0, 0.0, 0.0)
    -- 设置结束点旋转方向
    self.endRotate1 = Amaz.Vector3f(0.0, 0.0, 0.0)
    -- 设置结束点缩放系数
    self.endScale1 = Amaz.Vector3f(1.0, 1.0, 1.0)
    -- 设置模糊强度
    self.blurIntensity1 = 0.03
    -- 设置模糊类型, 1: 运动模糊, 2: 缩放模糊
    self.blurType1 = 2;
    -- 设置模糊的方向
    self.blurDirection1 = Amaz.Vector2f(1, 0);
    -- 作用时间，确保两个阶段系数和为1.0，否则会有问题
    self.blurDuration1 = 0.5
    -- 运动曲线，自定义曲线，固定曲线
    self.moveFunction1 = funcEaseAction1
    -- 模糊曲线，自定义曲线，固定曲线
    self.blurFunction1 = funcEaseBlurAction1

    -- 阶段二
    -- 设置起始点
    self.startPoint2 = Amaz.Vector3f(0.0, 0.0, 0.0)
    -- 设置起始点旋转方向
    self.startRotate2 = Amaz.Vector3f(0.0, 0.0, 0.0)
    -- 设置起始点缩放系数
    self.startScale2 = Amaz.Vector3f(1.0, 1.0, 1.0)
    -- 设置结束点
    self.endPoint2 = Amaz.Vector3f(0.0, 0.0, 0.0)
    -- 设置结束点旋转方向
    self.endRotate2 = Amaz.Vector3f(0.0, 0.0, 90.0)
    -- 设置结束点缩放系数
    self.endScale2 = Amaz.Vector3f(1.0, 1.0, 1.0)
    -- 设置模糊强度
    self.blurIntensity2 = 0.0
    -- 设置模糊类型, 1: 运动模糊, 2: 缩放模糊
    self.blurType2 = 1;
    -- 设置模糊的方向
    self.blurDirection2 = Amaz.Vector2f(1, 0);
    -- 作用时间，确保两个阶段系数和为1.0，否则会有问题
    self.blurDuration2 = 0.5
    -- 模糊曲线，自定义曲线，固定曲线
    self.moveFunction2 = funcEaseAction2
    -- 模糊曲线
    self.blurFunction2 = funcEaseBlurAction2

    if construct and Transform.constructor then Transform.constructor(self, ...) end
    return self
end

function Transform:constructor()

end

function Transform:onStart(comp)
    self.vfx = comp.entity.scene:findEntityBy("Blur")
    self.canvas = comp.entity.scene:findEntityBy("Root")
    local transform = comp.entity:getComponent("Transform")
    transform.localPosition = Amaz.Vector3f(0.0, 0.0, 0.0)
    self.material = self.vfx:getComponent("Sprite2DRenderer").material
    self.tweenDirty = true
end

-- 编辑器测试用方法，更新资源包前要注释掉！！！
-- function Transform:onUpdate(comp, deltaTime)
--     if self.tweenDirty then
--         self.time = 0.0
--         -- 测试代码，修改动画时间
--         self.duration = 3.0
--         -- 设置多少秒后重复
--         self.resetDuration = 3.5
--         self.startPoint1 = Amaz.Vector3f(self.startPoint1.x, -self.startPoint1.y, self.startPoint1.z)
--         -- self.startScale1 = Amaz.Vector3f(self.startScale1.x * 0.5625, self.startScale1.y, self.startScale1.z)
--         self.startScale1 = Amaz.Vector3f(self.startScale1.x, self.startScale1.y, self.startScale1.z)
--         self.endPoint1 = Amaz.Vector3f(self.endPoint1.x, -self.endPoint1.y, self.endPoint1.z)
--         self.endScale1 = Amaz.Vector3f(self.endScale1.x, self.endScale1.y, self.endScale1.z)
--         self.startRotate1 = Amaz.Vector3f(self.startRotate1.x, self.startRotate1.y, -self.startRotate1.z)
--         self.endRotate1 = Amaz.Vector3f(self.endRotate1.x, self.endRotate1.y, -self.endRotate1.z)

--         self.startPoint2 = Amaz.Vector3f(self.startPoint2.x, -self.startPoint2.y, self.startPoint2.z)
--         self.startScale2 = Amaz.Vector3f(self.startScale2.x, self.startScale2.y, self.startScale2.z)
--         self.endPoint2 = Amaz.Vector3f(self.endPoint2.x, -self.endPoint2.y, self.endPoint2.z)
--         self.endScale2 = Amaz.Vector3f(self.endScale2.x, self.endScale2.y, self.endScale2.z)
--         self.startRotate2 = Amaz.Vector3f(self.startRotate2.x, self.startRotate2.y, -self.startRotate2.z)
--         self.endRotate2 = Amaz.Vector3f(self.endRotate2.x, self.endRotate2.y, -self.endRotate2.z)
--     end

--     self.time = self.time + deltaTime
--     -- Amaz.LOGE("TAG", "time: " .. self.time)
--     -- self.time = 0.5
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

        -- 第一阶段设置
        self.startPoint1 = Amaz.Vector3f(self.startPoint1.x * ratio, self.startPoint1.y, self.startPoint1.z)
        self.endPoint1 = Amaz.Vector3f(self.endPoint1.x * ratio, self.endPoint1.y, self.endPoint1.z)
        self.tweenTransform1 = self.canvas.scene.tween:fromTo(transform, 
                                                {
                                                    ["localEulerAngle"] = self.startRotate1,
                                                    ["localScale"] = self.startScale1,
                                                    ["localPosition"] = self.startPoint1,
                                                },   
                                                {
                                                    ["localEulerAngle"] = self.endRotate1,
                                                    ["localScale"] = self.endScale1,
                                                    ["localPosition"] = self.endPoint1,
                                                }, 
                                                self.duration * self.blurDuration1,
                                                self.moveFunction1,
                                                nil, 
                                                0.0, 
                                                nil, 
                                                false)
        local material = self.vfx:getComponent("Sprite2DRenderer").material
        material["blurDirection"] = self.blurDirection
        self.tweenBlur1 = self.canvas.scene.tween:fromTo(self.material, 
                                                {["blurStep"] = self.blurIntensity1/self.duration/self.blurDuration1},
                                                {["blurStep"] = 0.0}, 
                                                self.duration * self.blurDuration1,
                                                self.blurFunction1,
                                                nil, 
                                                0.0, 
                                                nil, 
                                                false)

        -- 第二阶段设置
        self.startPoint2 = Amaz.Vector3f(self.startPoint2.x * ratio, self.startPoint2.y, self.startPoint2.z)
        self.endPoint2 = Amaz.Vector3f(self.endPoint2.x * ratio, self.endPoint2.y, self.endPoint2.z)
        self.tweenTransform2 = self.canvas.scene.tween:fromTo(transform, 
                                                {
                                                    ["localEulerAngle"] = self.startRotate2,
                                                    ["localScale"] = self.startScale2,
                                                    ["localPosition"] = self.startPoint2,
                                                },   
                                                {
                                                    ["localEulerAngle"] = self.endRotate2,
                                                    ["localScale"] = self.endScale2,
                                                    ["localPosition"] = self.endPoint2,
                                                }, 
                                                self.duration * self.blurDuration2,
                                                self.moveFunction2,
                                                nil, 
                                                0.0, 
                                                nil, 
                                                false)
        Amaz.LOGE("TAG", "blur: " .. self.blurIntensity2/self.duration/self.blurDuration2)
        self.tweenBlur2 = self.canvas.scene.tween:fromTo(self.material, 
                                                {["blurStep"] = self.blurIntensity2/self.duration/self.blurDuration2},
                                                {["blurStep"] = 0.0}, 
                                                self.duration * self.blurDuration2,
                                                self.blurFunction2,
                                                nil, 
                                                0.0, 
                                                nil, 
                                                false)
                                                
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
    -- if(time <= self.tweenTransform1.duration) then
    if(time <= self.duration * self.blurDuration1) then
        self.material:enableMacro("BLUR_TYPE", self.blurType1)
        self.material["blurDirection"] = self.blurDirection1
        self.tweenTransform1:set(time)
        self.tweenBlur1:set(time)
    else
        
        time = time - self.duration * self.blurDuration1
        if(time <= self.tweenTransform2.duration) then
            self.material:enableMacro("BLUR_TYPE", self.blurType2)
            self.material["blurDirection"] = self.blurDirection2
            self.tweenTransform2:set(time)
            self.tweenBlur2:set(time)
        end
    end

    updateHandle(self.vfx, self.canvas)
end

function Transform:setDuration(duration)
    self.duration = duration
    self.tweenDirty = true
end

function Transform:clear()
    self.tweenDirty = true
    if self.tweenTransform1 then
        self.tweenTransform1:set(0)
        self.tweenTransform1:clear()
        self.tweenTransform1 = nil
    end

    if self.tweenBlur1 then
        self.tweenBlur1:set(0)
        self.tweenBlur1:clear()
        self.tweenBlur1 = nil
    end

    if self.tweenTransform2 then
        self.tweenTransform2:set(0)
        self.tweenTransform2:clear()
        self.tweenTransform2 = nil
    end

    if self.tweenBlur2 then
        self.tweenBlur2:set(0)
        self.tweenBlur2:clear()
        self.tweenBlur2 = nil
    end
end
exports.Transform = Transform
return exports
