local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
--@input float curTime = 0.0{"widget":"slider","min":0,"max":1}
local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript
function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.width = 0
    self.height = 0
    self.GlowRange = 100
    
    return self
end

function SeekModeScript:constructor()

end


local function mix(a,b,x)
	return a+(b-a)*x
end
local function clamp(x,a,b)
    if x<a then
        x=a
    elseif x>b then
        x=b
    end
    return x
end
if Amaz.Macros and Amaz.Macros.EditorSDK then
    function SeekModeScript:onUpdate(comp, detalTime)
        --ceshiyong
        local props = comp.entity:getComponent("ScriptComponent").properties
        
        -- shijiyong
        self.curTime=self.curTime + detalTime
        if props:has("curTime") and isEditor then
            self.curTime= props:get("curTime")
        end
        self:seek(self.curTime - self.startTime)
    end
end

function SeekModeScript:_adapt_onStart(comp)
    self.curTime = 0
    self.duration = 1.0
    self.values = {}
    self.params = {}
    self.anims = {}
    self.animDirty = true
    self.entity = comp.entity
    self.scaleCorrect = 1.0
    self.videoMat = self.entity.scene:findEntityBy("video"):getComponent("MeshRenderer").material
    self.modelMat = self.entity.scene:findEntityBy("quad"):getComponent("MeshRenderer").material
    self.fxaaMat = self.entity.scene:findEntityBy("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.entity.scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.transform = self.entity.scene:findEntityBy("quad"):getComponent("Transform")
    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)
end

function SeekModeScript:onStart(comp)

    -- self.animSeqCom = comp.entity.scene:findEntityBy("rotPass"):getComponent("AnimSeqComponent")
    -- self.material = comp.entity.scene:findEntityBy("SeekModeScript"):getComponent("MeshRenderer").material
    -- self.material2 = comp.entity.scene:findEntityBy("SeekModeScript_2"):getComponent("MeshRenderer").material
    -- self.rotMaterial = comp.entity.scene:findEntityBy("rotPass"):getComponent("MeshRenderer").material
    -- self.rgbMaterial = comp.entity.scene:findEntityBy("RGBpass"):getComponent("MeshRenderer").material
    -- self.blurYMaterial = comp.entity.scene:findEntityBy("blurYpass"):getComponent("MeshRenderer").material
    -- local w = Amaz.BuiltinObject:getInputTextureWidth()
    -- local h = Amaz.BuiltinObject:getInputTextureHeight()
    -- self.width = w
    -- self.height = h
    -- self.material:setFloat("baseTexWidth", w)
    -- self.material:setFloat("baseTexHeight", h)
    -- self.material2:setFloat("baseTexWidth", w)
    -- self.material2:setFloat("baseTexHeight", h)
    
    -- self.attrs = AETools:new(ae_attribute)
    self:_adapt_onStart(comp)
    local aeTools = includeRelativePath("AETools1116")
	local aeData = includeRelativePath("AEData")
    self.attrs_3 = aeTools.new(aeData.ae_attribute_3)
    self.rotMaterial = comp.entity.scene:findEntityBy("rotPass"):getComponent("MeshRenderer").material
    self.blendMaterial = comp.entity.scene:findEntityBy("BlendPass"):getComponent("MeshRenderer").material
    self.scaleMaterial = comp.entity.scene:findEntityBy("scalePass"):getComponent("MeshRenderer").material
end

function SeekModeScript:_adapt_seek(time)
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

    self.modelMat:setFloat("u_OutputWidth", outputW)
    self.modelMat:setFloat("u_OutputHeight", outputH)

    local userMat = Amaz.Matrix4x4f()
    userMat:setTRS(
        Amaz.Vector3f(self.userPosition.x * outputRatio, self.userPosition.y, self.userPosition.z),
        Amaz.Quaternionf.EulerToQuaternion(-self.userEulerAngle / 180 * math.pi),
        Amaz.Vector3f(1, 1, 1) * self.userScale.x * extraScale
    )
    userMat:invert_Full()

    local fitMat = Amaz.Matrix4x4f()
    fitMat:setTRS(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.identity(), Amaz.Vector3f(uvScale.x, uvScale.y, 1))
    fitMat:invert_Full()

    self.modelMat:setMat4("userMat", userMat)
    self.modelMat:setMat4("fitMat", fitMat)
end

function SeekModeScript:seek(time)
    self:_adapt_seek(time)
    -- self.material:setFloat("uTime", time)
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.rotMaterial:setFloat("baseTexWidth", w)
        self.rotMaterial:setFloat("baseTexHeight", h)
        -- self.material:setFloat("baseTexWidth", w)
        -- self.material:setFloat("baseTexHeight", h)
        -- self.material2:setFloat("baseTexWidth", w)
        -- self.material2:setFloat("baseTexHeight", h)
    end
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("blurSize") then
    --     self.GlowRange = props:get("blurSize")
    -- end
    -- self.rotMaterial:setFloat("ins", props:get("ins"))
    -- self.rotMaterial:setFloat("centerX", props:get("centerX"))
    -- local controls = {0.21,-0.46,0.33,0.45}

    local t = math.mod(time,self.duration+0.001)/(self.duration+0.001)
    if t>1 then
        t=1
    end
    local progress = (t*34)/77
    local rotVec = Amaz.Vector()
    local preRotVec = Amaz.Vector()
    local alphaVec = Amaz.Vector()
    local satVec = Amaz.Vector()
    local lightVec = Amaz.Vector()
    local preTime = math.max(progress-1/76,0.0)
    for i=0,4 do
        local rot =self.attrs_3:GetVal("rot"..i, progress)[1]/180*3.14159
        rotVec:pushBack(rot)
        local preRot =self.attrs_3:GetVal("rot"..i, preTime)[1]/180*3.14159
        preRotVec:pushBack(preRot)
        local alpha =self.attrs_3:GetVal("alpha"..i, progress)[1]/100
        alphaVec:pushBack(alpha)
        local sat =self.attrs_3:GetVal("sat"..i, progress)[1]/100
        satVec:pushBack(sat)
        local light =self.attrs_3:GetVal("light"..i, progress)[1]
        lightVec:pushBack(light)
    end
    self.rotMaterial:setFloatVector("rotVec", rotVec)
    self.rotMaterial:setFloatVector("preRotVec", preRotVec)
    self.rotMaterial:setFloatVector("alphaVec", alphaVec)
    self.rotMaterial:setFloatVector("satVec", satVec)
    self.blendMaterial:setFloatVector("lightVec", lightVec)
    local scale =self.attrs_3:GetVal("ADBE_Scale_0_1", progress)[1]/100
    self.scaleMaterial:setFloat("scale", scale)
    
    -- local rotAngle = self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]/180*3.14159
    -- self.rotMaterial:setFloat("rotAngle", rotAngle)
    -- self.material:setFloat("rotAngle", -rotAngle)
    -- self.material2:setFloat("rotAngle", -rotAngle)


    -- Amaz.LOGI("AEProgress",(AEProgress*25))
    -- local posX = self.attrs:GetVal("ADBE_Position_0_3", AEProgress)[1]-540
    -- local posY = self.attrs:GetVal("ADBE_Position_0_3", AEProgress)[2]-540
    -- self.rotMaterial:setFloat("posX", posX)
    -- self.rotMaterial:setFloat("posY", posY)
    -- Amaz.LOGI("posX",posX+540)
    -- Amaz.LOGI("posY",posY+540)
    -- Amaz.LOGI("rot",self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1])


    -- local blurIns = self.attrs:GetVal("ADBE_Motion_Blur_0002_0_1", AEProgress)[1]/60
    -- self.material:setFloat("blurIns", blurIns)
    -- self.material2:setFloat("blurIns", blurIns)


    -- local blurAngle = self.attrs:GetVal("ADBE_Motion_Blur_0001_0_0", AEProgress)[1]/180*3.14159
    -- self.material:setFloat("blurAngle", -blurAngle)
    -- self.material2:setFloat("blurAngle", -blurAngle)

    -- local lightIns = self.attrs:GetVal("ADBE_Exposure2_0003_0_2", AEProgress)[1]
    -- self.material2:setFloat("lightIns", lightIns)
    -- Amaz.LOGI("rot",self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1])
    -- self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]
    -- local midMove = (self.attrs:GetVal("ADBE_Rotate_Z_0_4", AEProgress)[1]-500)/1000
    -- self.rotMaterial:setFloat("midMove", midMove)

    -- local bottomMove = (self.attrs:GetVal("ADBE_Position_0_bottom", AEProgress)[1]-500)/1000
    -- self.rotMaterial:setFloat("bottomMove", bottomMove)

    -- local topMove = (self.attrs:GetVal("ADBE_Position_0_top", AEProgress)[1]-500)/1000
    -- self.rotMaterial:setFloat("topMove", topMove)
    
    -- Amaz.LOGI("asdasd",self.attrs:GetVal("ADBE_Position_0_bottom", AEProgress)[1])
    -- Amaz.LOGI("progress",t*12)
end



function SeekModeScript:setParams(name, value)
    if name == "u_size" then
        -- local bgAspect = value.x / value.y
        -- local videoAspect = value.z / value.w
        -- if bgAspect > videoAspect then
        --     self.scaleCorrect = value.w / value.y
        -- else
        --     self.scaleCorrect = value.z / value.x
        -- end
        -- self.videoMat:setVec4("u_size", value)
        -- self.modelMat:setVec4("u_size", value)
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
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

function SeekModeScript:setDuration(duration)
    self.duration = duration
end

exports.SeekModeScript = SeekModeScript
return exports
