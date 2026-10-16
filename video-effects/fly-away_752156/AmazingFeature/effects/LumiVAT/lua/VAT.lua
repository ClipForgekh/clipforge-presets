local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local VAT = VAT or {}
VAT.__index = VAT

---@class VAT : ScriptComponent
---@field autoplay boolean
---@field frameByFrame boolean
---@field reverseAnim boolean
---@field meshIndex int [UI(Range={0, 10}, Slider)]
---@field model Model
---@field posTex Texture
---@field normTex Texture
---@field frameCount number [UI(Range={1, 1000}, Drag)]
---@field startFrame number [UI(Range={0, 100}, Drag)]
---@field endFrame number [UI(Range={1, 1000}, Drag)]
---@field duration number [UI(Range={0.0, 100.0}, Drag)]
---@field speed number [UI(Range={0.0, 10.0}, Drag)]
---@field progress number [UI(Range={0, 1}, Slider)]
---@field currentFrame number [UI(Range={0, 100}, Drag)]

---@field boundMinX number
---@field boundMinY number
---@field boundMinZ number
---@field boundMaxX number
---@field boundMaxY number
---@field boundMaxZ number

---@field camType string [UI(Option={"Perspective","Orthogonal"})]
---@field camOrthoScale number [UI(Range={0.0, 2.0}, Drag)]
---@field camFOV number [UI(Range={0.0, 180.0}, Drag)]
---@field camPosX number
---@field camPosY number
---@field camPosZ number
---@field camRotX number
---@field camRotY number
---@field camRotZ number

---@field positionX number
---@field positionY number
---@field positionZ number
---@field rotationX number
---@field rotationY number
---@field rotationZ number
---@field direction Vector3f
---@field scale Vector3f
---@field pivot Vector3f

---@field rotateOnLandscape boolean [UI(Display="Rotate on Landscape")]
---@field rotateUV number [UI(Range={-360.0, 360.0}, Drag)]
---@field offsetUV Vector2f
---@field scaleUV Vector2f
---@field padding Vector2f
---@field edgeType String [UI(Option={"Tile", "Mirror", "Clamp", "Empty"})]

---@field InputTex Texture
---@field OutputTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function VAT.new(construct, ...)
    local self = setmetatable({}, VAT)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"
    -- VAT
    self.autoplay = true
    self.frameByFrame = false
    self.reverseAnim = false
    self.mode = "Cloth"
    self.MODES = {
        ["Cloth"] = 0,
        ["Fluid"] = 1,
        ["RBD"] = 2,
        ["Particles"] = 3,
        [0] = "Cloth",
        [1] = "Fluid",
        [2] = "RBD",
        [3] = "Particles"
    }
    self.progress = 0
    self.speed = 1
    self.duration = 3
    self.frameCount = 90
    self.startTime = 0
    self.endTime = 0
    self.curTime = 0
    self.aeTime = 0
    self.currentFrame = 1
    self.startFrame = 1
    self.endFrame = 90
    self.AEPlugin = false
    self.boundMinX = 0
    self.boundMinY = 0
    self.boundMinZ = 0
    self.boundMaxX = 1
    self.boundMaxY = 1
    self.boundMaxZ = 1
    -- VAT Resources 
    self.meshIndex = 0
    self.model = nil
    self.posTex = nil
    self.normTex = nil
    self.rotTex = nil
    self.colTex = nil
    -- Cam
    self.camType = "Perspective"
    self.CAM_TYPES = {
        ["Perspective"] = 0,
        ["Orthogonal"] = 1,
        [0] = "Perspective",
        [1] = "Orthogonal"
    }
    self.camOrthoScale = 1.2
    self.camFOV = 60
    self.camPosX = 0
    self.camPosY = 0
    self.camPosZ = 0
    self.camRotX = 0
    self.camRotY = 0
    self.camRotZ = 0
    -- Model Xform
    self.pivot = Amaz.Vector3f(0, 0, 0)
    self.scale = Amaz.Vector3f(1, 1, 1)
    self.direction = Amaz.Vector3f(0, 0, 0)
    self.rotation = Amaz.Vector3f(0, 0, 0)
    self.positionX = 0
    self.positionY = 0
    self.positionZ = 0
    self.rotationX = 0
    self.rotationY = 0
    self.rotationZ = 0
    self.scaleMult = 1
    -- UV
    self.rotateOnLandscape = true
    self.rotateUV = 0
    self.offsetUV = Amaz.Vector2f(0, 0)
    self.scaleUV = Amaz.Vector2f(1, 1)
    self.padding = Amaz.Vector2f(0.01, 0.01)
    self.edgeType = "Tile"
    self.EDGE_TYPES = {
        [0] = "Tile",
        "Mirror",
        "Clamp",
        "Empty",
        ["Tile"] = 0,
        ["Mirror"] = 1,
        ["Clamp"] = 2,
        ["Empty"] = 3
    }
    -- Shared
    self.sharedMaterials = {}
    self.InputTex = nil
    self.OutputTex = nil
    -- Others
    self.Utils = includeRelativePath("Utils").Utils
    return self
end

function VAT:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    -- ignore. the asset is replaced by AEPlugin
    if key == "camType" then
        value = math.max(0, math.min(value, #self.CAM_TYPES))
        value = self.CAM_TYPES[value]
        _setEffectAttr(key, value)
    elseif key == 'model' or key == 'posTex' or key == 'normTex' then
        return
    end

    _setEffectAttr(key, value)
end

function VAT:onStart(comp)
    -- Cache entity reference
    local entity = comp.entity
    self.entity = entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    -- Get camera components
    local camEntity = entity:searchEntity("CamVAT")
    self.camVAT = camEntity:getComponent("Camera")
    self.camVATXform = camEntity:getComponent("Transform")

    -- Get VAT components
    self.vatXform = entity:searchEntity("VATObj"):getComponent("Transform")
    self.vatPass = entity:searchEntity("PassVAT"):getComponent("MeshRenderer")
    self.vatMat = self.vatPass.material
    self.sharedMaterials = {self.vatMat}

    -- Get pivot
    local pivotEntity = entity:searchEntity("VATPivot")
    if pivotEntity then
        self.pivotXform = pivotEntity:getComponent("Transform")
    end
end

function VAT:onUpdate(comp, deltaTime)
    self.Utils:setRenderTexture(self.camVAT, self.OutputTex)
    self.camVAT.type = self.CAM_TYPES[self.camType]

    if self.model == nil then
        Amaz.LOGE(self.TAG, 'Invalid model.')
        return
    end

    local meshSize = self.model.Meshes:size()

    if meshSize == 0 then
        Amaz.LOGE(self.TAG, 'Invalid model, no mesh found.')
        return
    end

    local meshIndex = math.min(math.max(self.meshIndex, 0), meshSize - 1)
    self.vatPass.mesh = self.model.Meshes:get(meshIndex)

    local canvasWidth = self.OutputTex.width
    local canvasHeight = self.OutputTex.height
    self:calculateTransform(canvasWidth, canvasHeight)

    if isEditor then
        self.curTime = self.curTime + deltaTime
        if self.autoplay then
            self.progress = self.curTime * self.speed % self.duration / self.duration
        end
    else
        self.progress = self.curTime * self.speed % self.duration / self.duration
    end

    if self.reverseAnim then
        self.progress = 1.0 - self.progress
    end
    self:updateVAT(self.progress)
end

function VAT:updateVAT(progress)
    local displayFrame = (progress * (self.endFrame - self.startFrame + 1)) + self.startFrame
    displayFrame = math.max(self.startFrame, math.min(displayFrame, self.endFrame))

    for _, mat in ipairs(self.sharedMaterials) do
        mat:setFloat("u_frameCount", self.frameCount)
        mat:setFloat("u_displayFrame", displayFrame)
        mat:setFloat("u_yResolution", self.posTex.height)
        mat:setFloat("u_speed", self.speed)
        mat:setVec3("u_maxValues", Amaz.Vector3f(self.boundMaxX, self.boundMaxY, self.boundMaxZ))
        mat:setVec3("u_minValues", Amaz.Vector3f(self.boundMinX, self.boundMinY, self.boundMinZ))
        mat:setTex("u_inputTex", self.InputTex)
        mat:setTex("u_vatPosTex", self.posTex)
    end
end

function VAT:calculateTransform(width, height)
    if not self.OutputTex or not self.InputTex then
        return
    end

    local aspect = width / height
    local isLandscape = width > height

    -- Use camOrthoScale for Orthogonal camera    
    local cameraFactor
    if self.camType == "Perspective" then
        cameraFactor = self.camFOV
        self.camVAT.fovy = self.camFOV
    else
        cameraFactor = self.camOrthoScale
        self.camVAT.orthoScale = self.camOrthoScale
    end

    -- Calculate camera orientation using quaternion rotations around X, Y and Z axes
    local quatX = Amaz.Quaternionf.axisAngleToQuaternion(Amaz.Vector3f(0, 1, 0), math.rad(self.camRotX))
    local quatY = Amaz.Quaternionf.axisAngleToQuaternion(Amaz.Vector3f(1, 0, 0), math.rad(-self.camRotY))
    local quatZ = Amaz.Quaternionf.axisAngleToQuaternion(Amaz.Vector3f(0, 0, 1), math.rad(self.camRotZ))
    self.camVATXform.localOrientation = quatX * quatY * quatZ
    self.camVATXform.localPosition = Amaz.Vector3f(self.camPosX, self.camPosY, self.camPosZ)

    -- Set scale values
    self.scale.x = isLandscape and aspect or aspect
    self.scale.y = isLandscape and aspect or 1.0 / aspect

    -- Set UV scales
    local scaleX = cameraFactor / aspect
    local scaleY = aspect
    self.scaleUV.x = scaleX
    self.scaleUV.y = scaleY
    self.offsetUV.x = 0.5
    self.offsetUV.y = 0.5

    -- Apply mesh transforms
    self.pivotXform.localScale = Amaz.Vector3f(1, 1, 1)
    self.pivotXform.localPosition = Amaz.Vector3f(self.pivot.x, self.pivot.y, self.pivot.z)
    self.vatXform.localPosition = Amaz.Vector3f(self.positionX, self.positionY, self.positionZ)
    self.vatXform.localScale = self.scale
    self.Utils:rotateByAxis(self.vatXform, self.direction, Amaz.Vector3f(self.rotationX, self.rotationY, self.rotationZ))

end

exports.VAT = VAT
return exports
