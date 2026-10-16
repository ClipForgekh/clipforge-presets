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
            {x=3.80679944018571, y=3.81715030847372, }, 
            {x=2.76577280045449, y=3.01813266348122, }, 
            {x=2.1393102636753, y=2.34902942971709, }, 
            {x=1.70528237729206, y=1.80243010520408, }, 
            {x=1.38946634133006, y=1.37023699185164, }, 
            {x=1.15613535747305, y=1.04362493025384, }, 
            {x=0.98484911501795, y=0.81300032421122, }, 
            {x=0.86263665199054, y=0.66795973572819, }, 
            {x=0.78067654081467, y=0.59724838863445, }, 
            {x=0.73266543967026, y=0.58871898196229, }, 
            {x=0.71392827169415, y=0.62929128248353, }, 
            {x=0.72088741510134, y=0.70491303881101, }, 
            {x=0.75070366870745, y=0.80052283632119, }, 
            {x=0.80093826578363, y=0.90001559160027, }, 
            {x=0.86882453034687, y=0.98621146546451, }, 
            {x=0.94500171787458, y=1.04082905267719, }, 
            {x=0.99685335005898, y=1.06459365452751, }, 
            {x=1.03311926762329, y=1.07268787801779, }, 
            {x=1.05819285359289, y=1.06779913855276, }, 
            {x=1.07456514860845, y=1.05274167720154, }, 
            {x=1.08377725765276, y=1.03040690488198, }, 
            {x=1.08682406741577, y=1.00371121248738, }, 
            {x=1.08434703606033, y=0.97554385520476, }, 
            {x=1.0767290814629, y=0.94871745444753, }, 
            {x=1.06413344893478, y=0.9259233590635, }, 
            {x=1.04649806515107, y=0.90969361942512, }, 
            {x=1.02347358919116, y=0.90237072780221, }, 
            {x=0.99926768500533, y=0.90221161933205, }, 
            {x=0.97885459343842, y=0.90611229482832, }, 
            {x=0.96269312613611, y=0.91397146074007, }, 
            {x=0.95110508903933, y=0.92524668185455, }, 
            {x=0.94416258906453, y=0.93891275807016, }, 
            {x=0.94160177291776, y=0.95361504448516, }, 
            {x=0.94281833842964, y=0.96797826203301, }, 
            {x=0.94696616838849, y=0.98089591465255, }, 
            {x=0.9531179218744, y=0.99165811660789, }, 
            {x=0.96041404265902, y=0.99992079044091, }, 
            {x=0.96815093778308, y=1.00560209401672, }, 
            {x=0.97580486090027, y=1.0087776507075, }, 
            {x=0.98301462808038, y=1.00960328060636, }, 
            {x=0.98954792641325, y=1.00826664891449, }, 
            {x=0.99526674031801, y=1.00496016457221, }, 
            {x=0.99999049596121, y=0.99998974475748, }, 
            {x=0.981098921279, y=0.97927965586833, }, 
            {x=0.92772320245951, y=0.92024739426779, }, 
            {x=0.83973763695412, y=0.82333236102804, }, 
            {x=0.71386378683317, y=0.68712664486129, }, 
            {x=0.54281423207884, y=0.50817325206319, }, 
            {x=0.31226432505309, y=0.28025685289379, }, 
            {x=0.001, y=0.001, }, 
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
