local exports = exports or {}
local videoAnimationBaseScript = videoAnimationBaseScript or {}
videoAnimationBaseScript.__index = videoAnimationBaseScript
---@class videoAnimationBaseScript : ScriptComponent

local isEditor = Amaz.Macros and Amaz.Macros.EditorSDK

function videoAnimationBaseScript.new(construct, ...)
    local self = setmetatable({}, videoAnimationBaseScript)
    if construct and videoAnimationBaseScript.constructor then videoAnimationBaseScript.constructor(self, ...) end

    self.curTime = 0
    self.duration = 0
    return self
end

function videoAnimationBaseScript:_adapt_onStart(comp)
    self.curTime = 0
    self.duration = 2.0
    self.scaleCorrect = 1.0
    self.baseEntity = comp.entity:getComponent("Transform").parent.entity
    self.videoMat = self.baseEntity:searchEntity("video"):getComponent("MeshRenderer").material
    self.modelMat = self.baseEntity:searchEntity("quad"):getComponent("MeshRenderer").material
    self.fxaaMat = self.baseEntity:searchEntity("fxaa"):getComponent("MeshRenderer").material
    self.blendMat = self.baseEntity:searchEntity("blend"):getComponent("MeshRenderer").material
    self.transform = self.baseEntity:searchEntity("quad"):getComponent("Transform")
    self.userPosition = Amaz.Vector3f(0, 0, 0)
    self.userEulerAngle = Amaz.Vector3f(0, 0, 0)
    self.userScale = Amaz.Vector3f(1, 1, 1)
end

function videoAnimationBaseScript:onStart(comp)
    self:_adapt_onStart(comp)
end

function videoAnimationBaseScript:_adapt_seek(time)
    local inputW = Amaz.BuiltinObject.getInputTextureWidth()
    local inputH = Amaz.BuiltinObject.getInputTextureHeight()
    local inputRatio = inputW / inputH
    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
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

if isEditor then
    function videoAnimationBaseScript:onUpdate(comp, detalTime)
        self.blendMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        self.modelMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        self:seek(0.5)
    end
end

function videoAnimationBaseScript:seek(time)
    self.curTime = time
    self:_adapt_seek(time)
end

function videoAnimationBaseScript:setParams(name, value)
    if name == "u_size" then
        local FBS = Amaz.Vector2f(value.x, value.y)
        self.fxaaMat:setVec2("FBS", FBS)
        self.blendMat:setVec4("u_size", value)
    elseif name == "u_pos" then
        self.userPosition:set(value.x, value.y, 0)
    elseif name == "u_angle" then
        self.userEulerAngle:set(0, 0, math.deg(value))
    elseif name == "u_scale" then
        self.userScale:set(value, value, 1)
    elseif name == "u_flipX" then
        self.videoMat:setFloat("u_flipX", value)
    elseif name == "u_flipY" then
        self.videoMat:setFloat("u_flipY", value)
    elseif name == "_alpha" then
        self.blendMat:setFloat("_alpha", value)
    end
end

function videoAnimationBaseScript:setDuration(duration)
    self.duration = duration
end

exports.videoAnimationBaseScript = videoAnimationBaseScript
return exports
