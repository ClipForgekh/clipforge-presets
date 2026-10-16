---@class SeekModeScript : ScriptComponent
----@field curTime number [UI(Range={0, 3}, Slider)]
----@field duration number [UI(Input)]
local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

local function getBezierValue(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3 * xc1 * (1 - t) * (1 - t) * t + 3 * xc2 * (1 - t) * t * t + t * t * t
    ret[2] = 3 * yc1 * (1 - t) * (1 - t) * t + 3 * yc2 * (1 - t) * t * t + t * t * t
    return ret
end

local function getBezierDerivative(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3 * xc1 * (1 - t) * (1 - 3 * t) + 3 * xc2 * (2 - 3 * t) * t + 3 * t * t
    ret[2] = 3 * yc1 * (1 - t) * (1 - 3 * t) + 3 * yc2 * (2 - 3 * t) * t + 3 * t * t
    return ret
end

local function getBezierTfromX(controls, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts + te) / 2
        local value = getBezierValue(controls, tm)
        if (value[1] > x) then
            te = tm
        else
            ts = tm
        end
    until (te - ts < 0.0001)

    return (te + ts) / 2
end

function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then
        SeekModeScript.constructor(self, ...)
    end
    return self
end

---@function [UI(Button="_replacedText_replacedText")]
---@return void
function SeekModeScript:ButtonClip()
    self.curTime = 0
    self.isPlay = true
end

function SeekModeScript:constructor()
end

function SeekModeScript:onStart(comp)
    self.blurMin = 0.1
    self.scaleData = {
            {x=0.04496383370705, y=0.04496383370705, }, 
            {x=0.14578751455525, y=0.15430098473914, }, 
            {x=0.25165818990966, y=0.2780145938835, }, 
            {x=0.36499455285817, y=0.41681987434646, }, 
            {x=0.48930954268421, y=0.57307131426987, }, 
            {x=0.63025788838825, y=0.75160420501922, }, 
            {x=0.79838183137391, y=0.96250820163077, }, 
            {x=1.01905723597305, y=1.23213554799318, }, 
            {x=1.25611967156766, y=1.45609527662965, }, 
            {x=1.42513783821674, y=1.52821035007688, }, 
            {x=1.51489715409233, y=1.50004281764199, }, 
            {x=1.52676002531751, y=1.4125966488838, }, 
            {x=1.47844414927947, y=1.29804588500634, }, 
            {x=1.39595115193859, y=1.18136388447352, }, 
            {x=1.30188348867858, y=1.08174998986914, }, 
            {x=1.22549330661979, y=1.02979182935537, }, 
            {x=1.16959748849455, y=1.0124899774211, }, 
            {x=1.12498413978464, y=1.01147078066175, }, 
            {x=1.08837675628288, y=1.02013291034713, }, 
            {x=1.05841598291962, y=1.03501148209678, }, 
            {x=1.03478902075293, y=1.05371259295234, }, 
            {x=1.01824201527834, y=1.07385706510355, }, 
            {x=1.01181469164329, y=1.09102211298294, }, 
            {x=1.0140145629493, y=1.1009578055414, }, 
            {x=1.01800692971633, y=1.10674215292167, }, 
            {x=1.02343060140366, y=1.10873036070041, }, 
            {x=1.02988779210888, y=1.10747279204199, }, 
            {x=1.0369605099045, y=1.10364977454513, }, 
            {x=1.04422861522774, y=1.09798570683205, }, 
            {x=1.05128741866786, y=1.09116936730082, }, 
            {x=1.05776286303879, y=1.08379936291026, }, 
            {x=1.06332290991168, y=1.07635939697393, }, 
            {x=1.06768452414822, y=1.06921731468122, }, 
            {x=1.07061639026537, y=1.062638203003, }, 
            {x=1.07193803380914, y=1.05680313907423, }, 
            {x=1.07151629579496, y=1.05182822224735, }, 
            {x=1.06926014610554, y=1.04778125500129, }, 
            {x=1.06511469877609, y=1.04469522120841, }, 
            {x=1.05905509175037, y=1.04257864551175, }, 
            {x=1.05108068110853, y=1.04142330041199, }, 
            {x=1.04120981396981, y=1.04120981396981, }, 
            {x=1.04056952382747, y=1.05034082360417, }, 
            {x=1.06448533971244, y=1.08073100637259, }, 
            {x=1.12179308543772, y=1.13963662125328, }, 
            {x=1.22692735156611, y=1.23877207568027, }, 
            {x=1.40582954081299, y=1.39894149350205, }, 
            {x=1.7122131788842, y=1.66285896294788, }, 
            {x=2.28566228437334, y=2.14307063403533, }, 
            {x=3.62245922914608, y=3.33436669236297, }, 
            {x=6.02243971528359, y=6.02243971528359, }, 
    }
    self.curTime = 0
    self.duration = 2.0
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
    self.modelMat["blurDirection"] = Amaz.Vector2f(1.0, 0.0)
end

if Amaz.Macros and Amaz.Macros.EditorSDK then
    function SeekModeScript:onUpdate(comp, deltaTime)
        self.blendMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        self.modelMat:enableMacro("AMAZING_EDITOR_DEV", 1)
        -- self.modelMat:setTex("u_inputTexture", comp.entity.scene.assetMgr:SyncLoad("share://input.texture"))
        -- local props = comp.entity:getComponent("ScriptComponent").properties
        -- if props:has("curTime") then
        --     self:seek(props:get("curTime"))
        -- end
        if self.isPlay and self.curTime < self.duration then
            self.curTime = (self.curTime + deltaTime)
        else
            self.isPlay = false
        end
        self:seek(math.min(self.curTime, self.duration))
    end
end

function SeekModeScript:setDuration(duration)
    self.duration = duration
    self.animDirty = true
end

function SeekModeScript:seek(time)
    self.modelMat:disableMacro("USE_SACLE_BLUR")
    self.modelMat:disableMacro("USE_DIR_BLUR")

    if self.duration < 0.0001 then
        self.transform.localScale = Amaz.Vector3f(1, 1, 1)

        return
    end

    local progress = time / self.duration

    local xChange = 1.0
    local yChange = 1.0
    local blurChange = 2001000000.
    local dataIndex = time / self.duration * (#self.scaleData - 1)
    -- Amaz.LOGI(#self.scaleData, dataIndex )
    local maxWeight = (dataIndex - math.floor(dataIndex))
    if dataIndex - (#self.scaleData) > -1.05 then
        -- Amaz.LOGI('yyb   ',12)
        -- return
        -- elseif math.floor(dataIndex) <= 0.05 then
        --     self.modelMat["blurStep"] = 0
        --     self.transform.localScale = Amaz.Vector3f(self.scaleData[1].x,self.scaleData[1].y,0)
        --     return
        -- end
        self.modelMat["blurStep"] = 0

        self.transform.localScale =
            Amaz.Vector3f(self.scaleData[#self.scaleData].x, self.scaleData[#self.scaleData].y, 1)
    else
        -- Amaz.LOGI('yyb  ', math.log(math.abs((xLastScale + yLastScale) * blurChange)+1))
        local minWeight = 1. - maxWeight
        local xScale =
            minWeight * self.scaleData[math.floor(dataIndex) % (#self.scaleData) + 1].x +
            maxWeight * self.scaleData[math.ceil(dataIndex) % (#self.scaleData) + 1].x
        local yScale =
            minWeight * self.scaleData[math.floor(dataIndex) % (#self.scaleData) + 1].y +
            maxWeight * self.scaleData[math.ceil(dataIndex) % (#self.scaleData) + 1].y
        self.transform.localScale = Amaz.Vector3f(xScale * xChange, yScale * yChange, 1)
        local xLastScale =
            math.abs(
            self.scaleData[math.ceil(dataIndex) % (#self.scaleData) + 1].x -
                self.scaleData[math.floor(dataIndex) % (#self.scaleData) + 1].x
        )
        local yLastScale =
            math.abs(
            self.scaleData[math.ceil(dataIndex) % (#self.scaleData) + 1].y -
                self.scaleData[math.floor(dataIndex) % (#self.scaleData) + 1].y
        )
        if xLastScale > self.blurMin and yLastScale > self.blurMin then
            self.modelMat["blurStep"] = math.log(math.abs((xLastScale + yLastScale) * blurChange) + 1)
        else
            self.modelMat["blurStep"] = 0
        end
    end
    -- Amaz.LOGI('yyb   ',tostring(self.transform.localScale))
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
    -- self.quadTrans.localScale = fitScale

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

    -- self.modelMat:setFloat('u_InputWidth', inputW)
    -- self.modelMat:setFloat('u_InputHeight', inputH)
    self.modelMat:setFloat("u_OutputWidth", outputW)
    self.modelMat:setFloat("u_OutputHeight", outputH)
    -- self.modelMat:setVec2('u_UVScale', uvScale)

    local userMat = Amaz.Matrix4x4f()
    -- userMat:setTRS(
    --     Amaz.Vector3f(self.userPosition.x * outputRatio, self.userPosition.y, self.userPosition.z),
    --     Amaz.Quaternionf.EulerToQuaternion(-self.userEulerAngle / 180 * math.pi),
    --     Amaz.Vector3f(1, 1, 1) * self.userScale.x * extraScale
    -- )
    -- userMat:invert_Full()

    local fitMat = Amaz.Matrix4x4f()
    fitMat:setTRS(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.identity(), Amaz.Vector3f(uvScale.x, uvScale.y, 1))
    fitMat:invert_Full()

    self.modelMat:setMat4("userMat", userMat)
    self.modelMat:setMat4("fitMat", fitMat)
end

function SeekModeScript:clear()
    self.anims = {}
    self.params = {}
    self.animDirty = true
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

function SeekModeScript:clear()
end

exports.SeekModeScript = SeekModeScript
return exports
