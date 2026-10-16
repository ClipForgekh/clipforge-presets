local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local VATPBRDouble = VATPBRDouble or {}
VATPBRDouble.__index = VATPBRDouble

---@class VATPBRDouble : ScriptComponent
---@field meshIndex int [UI(Range={0, 10}, Slider)]
---@field model Model
---@field posTex Texture
---@field normTex Texture

---@field autoplay boolean
---@field frameByFrame boolean
---@field reverseAnim boolean

---@field frameCount number [UI(Range={1, 1000}, Drag)]
---@field startFrame number [UI(Range={0, 100}, Drag)]
---@field endFrame number [UI(Range={1, 1000}, Drag)]
---@field duration number [UI(Range={0.0, 100.0}, Drag)]
---@field speed number [UI(Range={0.0, 10.0}, Drag)]
---@field displayFrame int [UI(Range={0, 1000}, Drag)]
---@field progress number [UI(Range={0, 1}, Slider)]

---@field boundMin Vector3f
---@field boundMax Vector3f
---@field matchAxis Vector3f

---@field camType string [UI(Option={"Perspective","Orthogonal"})]
---@field camOrthoScale number [UI(Range={0.0, 2.0}, Drag)]
---@field camFOV number [UI(Range={0.0, 180.0}, Drag)]
---@field camPos Vector3f
---@field camRot Vector3f

---@field pivotPos Vector3f
---@field pivotRot Vector3f
---@field pivotScale Vector3f

---@field objPos Vector3f
---@field objRot Vector3f
---@field objScale Vector3f
---@field aspect Vector3f

---@field useOrientationSpecificRatio boolean [UI(Display="Use Orientation Specific Ratio")]
---@field portraitMultiRatioMode string [UI(Option={"Stretch","KeepAspectFit","KeepAspectFill","Invert"}, Display="Portrait Multi Ratio")]
---@field landscapeMultiRatioMode string [UI(Option={"Stretch","KeepAspectFit","KeepAspectFill","Invert"}, Display="Landscape Multi Ratio")]
---@field landscapeSizeScale number [UI(Range={0.1, 5.0}, Drag), Display="Landscape Size Scale"]
---@field rotateMeshOnLandscape boolean [UI(Display="Rotate Mesh on Landscape")]
---@field landscapeRotationDirection string [UI(Option={"Right","Left"}, Display="Landscape Rotation Direction")]
---@field rotateUVWithMesh boolean [UI(Display="Rotate UV with Mesh")]
---@field textureWrapMode string [UI(Option={"Clamp","Repeat","Mirror","Black","White", "Transparent"})]
---@field rotateUV number [UI(Range={-360.0, 360.0}, Drag)]
---@field offsetUV Vector2f
---@field scaleUV Vector2f

---@field swapSides boolean [UI(Display="Swap Sides")]
---@field backFaceHorizontalInvert boolean [UI(Display="Back Face Horizontal Invert")]
---@field backFaceVerticalInvert boolean [UI(Display="Back Face Vertical Invert")]
---@field backFaceRotateUV number [UI(Range={-360.0, 360.0}, Drag, Display="Back Face Rotate UV")]
---@field backFaceOffsetUV Vector2f [UI(Display="Back Face Offset UV")]
---@field backFaceScaleUV Vector2f [UI(Display="Back Face Scale UV")]
---@field frontFaceCullMode string [UI(Option={"None","Front","Back","Front&Back"}, Display="Front Face Cull Mode")]
---@field backFaceCullMode string [UI(Option={"None","Front","Back","Front&Back"}, Display="Back Face Cull Mode")]
---@field backColorOnly boolean
---@field backFaceColor Color [UI(NoAlpha)]
---@field backFaceTex Texture
---@field backFacePbrBlend number [UI(Range={0.0, 1.0}, Slider, Display="Back Face PBR Blend")]

---@field enablePBR boolean [UI(Display="Enable PBR")]
---@field pbrBlend number [UI(Range={0.0, 1.0}, Slider, Display="PBR Blend")]

---@field enableDirLight boolean [UI(Display="Enable Directional Light")]
---@field dirLightDirection Vector3f
---@field dirLightIntensity number [UI(Range={0.0, 100.0}, Drag)]
---@field dirLightColor Color [UI(NoAlpha)]

---@field enablePointLight0 boolean [UI(Display="Enable Point Light 0")]
---@field pointLight0Position Vector3f
---@field pointLight0Intensity number [UI(Range={0.0, 10.0}, Drag, Display="Point Light 0 Intensity")]
---@field pointLight0Range number [UI(Range={0.1, 100.0}, Drag, Display="Point Light 0 Range")]
---@field pointLight0Color Color [UI(NoAlpha, Display="Point Light 0 Color")]

---@field enablePointLight1 boolean [UI(Display="Enable Point Light 1")]
---@field pointLight1Position Vector3f
---@field pointLight1Intensity number [UI(Range={0.0, 10.0}, Drag, Display="Point Light 1 Intensity")]
---@field pointLight1Range number [UI(Range={0.1, 1000.0}, Drag, Display="Point Light 1 Range")]
---@field pointLight1Color Color [UI(NoAlpha, Display="Point Light 1 Color")]

---@field enableSpotLight0 boolean [UI(Display="Enable Spot Light 0")]
---@field spotLight0Position Vector3f
---@field spotLight0Direction Vector3f
---@field spotLight0Intensity number [UI(Range={0.0, 100.0}, Drag, Display="Spot Light 0 Intensity")]
---@field spotLight0Range number [UI(Range={0.1, 1000.0}, Drag, Display="Spot Light 0 Range")]
---@field spotLight0InnerAngle number [UI(Range={0.1, 180.0}, Drag, Display="Spot Light 0 Inner Angle")]
---@field spotLight0ConeSize number [UI(Range={0.1, 180.0}, Drag, Display="Spot Light 0 Cone Size")]
---@field spotLight0Color Color [UI(NoAlpha, Display="Spot Light 0 Color")]

---@field enableSpotLight1 boolean [UI(Display="Enable Spot Light 1")]
---@field spotLight1Position Vector3f
---@field spotLight1Direction Vector3f
---@field spotLight1Intensity number [UI(Range={0.0, 100.0}, Drag, Display="Spot Light 1 Intensity")]
---@field spotLight1Range number [UI(Range={0.1, 1000.0}, Drag, Display="Spot Light 1 Range")]
---@field spotLight1InnerAngle number [UI(Range={0.1, 180.0}, Drag, Display="Spot Light 1 Inner Angle")]
---@field spotLight1ConeSize number [UI(Range={0.1, 180.0}, Drag, Display="Spot Light 1 Cone Size")]
---@field spotLight1Color Color [UI(NoAlpha, Display="Spot Light 1 Color")]

---@field baseColor Color [UI(NoAlpha)]
---@field metallic number [UI(Range={0.0, 1.0}, Slider, Display="Metallic")]
---@field roughness number [UI(Range={0.0, 1.0}, Slider, Display="Roughness")]
---@field ambientOcclusion number [UI(Range={0.0, 1.0}, Slider, Display="Ambient Occlusion")]
---@field reflectance number [UI(Range={0.0, 1.0}, Slider, Display="Reflectance")]
---@field emissiveColor Color [UI(NoAlpha, Display="Emissive Color")]
---@field emissiveIntensity number [UI(Range={0.0, 10.0}, Drag, Display="Emissive Intensity")]
---@field absoluteNormal boolean [UI(Display="Absolute Normal")]

---@field enableClearCoat boolean [UI(Display="Enable Clear Coat")]
---@field clearCoat number [UI(Range={0.0, 1.0}, Slider, Display="Clear Coat")]
---@field clearCoatRoughness number [UI(Range={0.0, 1.0}, Slider, Display="Clear Coat Roughness")]
---@field clearCoatColor Color [UI(NoAlpha)]

---@field InputTex Texture
---@field OutputTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function VATPBRDouble.new(construct, ...)
    local self = setmetatable({}, VATPBRDouble)

    if construct and VATPBRDouble.constructor then
        VATPBRDouble.constructor(self, ...)
    end

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"
    self._temp30 = Amaz.Vector3f(0, 0, 0)
    self._temp31 = Amaz.Vector3f(1, 1, 1)
    self._tempColor = Amaz.Color(1, 1, 1)
    -- VAT
    self.autoplay = true
    self.frameByFrame = false
    self.reverseAnim = false
    self.progress = 0
    self.speed = 1
    self.duration = 3

    self.curTime = 0
    self.startTime = 0
    self.frameCount = 30
    self.displayFrame = 0
    self.startFrame = 1
    self.endFrame = 30

    self.AEPlugin = false
    self.aeTime = 0
    self.aeDuration = 3

    self.boundMin = Amaz.Vector3f(-2.1, -0.1, -0.1)
    self.boundMax = Amaz.Vector3f(0.1, 0.1, 0.9)
    self.matchAxis = Amaz.Vector3f(0, 0, 90)
    -- VAT Resources
    self.meshIndex = 0
    self.model = nil
    self.posTex = nil
    self.normTex = nil
    -- Cam
    self.camType = "Perspective"
    self.CAM_TYPES = {
        [0] = "Perspective",
        [1] = "Orthogonal",
        ["Perspective"] = 0,
        ["Orthogonal"] = 1
    }
    self.camOrthoScale = 1.2
    self.camFOV = 60
    self.camPos = self._temp30
    self.camRot = self._temp30
    -- Model Xform
    self.pivotPos = self._temp30
    self.pivotRot = self._temp30
    self.pivotScale = self._temp31
    self.objPos = Amaz.Vector3f(0, 0, -1)
    self.objRot = self._temp30
    self.objScale = self._temp31
    self.aspect = self._temp31
    -- Mutlti Aspect
    self.multiRatioMode = "Stretch"
    self.MULTI_RATIO_MODES = {
        [0] = "Stretch",
        [1] = "KeepAspectFit",
        [2] = "KeepAspectFill",
        [3] = "Invert",
        ["Stretch"] = 0,
        ["KeepAspect"] = 1,
        ["KeepAspectFit"] = 1,
        ["KeepAspectFill"] = 2,
        ["Invert"] = 3
    }
    self.useOrientationSpecificRatio = false
    self.portraitMultiRatioMode = 0
    self.landscapeMultiRatioMode = 0
    -- UV
    self.rotateMeshOnLandscape = false
    self.landscapeRotationDirection = "Right"
    self.LANDSCAPE_ROTATION_DIRECTIONS = {
        [0] = "Right",
        "Left",
        ["Right"] = 0,
        ["Left"] = 1
    }
    self.rotateUVWithMesh = false
    self.rotateUV = 0
    self.offsetUV = Amaz.Vector2f(0.5, 0.5)
    self.scaleUV = Amaz.Vector2f(1, 1)
    self.landscapeSizeScale = 1.0
    self.textureWrapMode = "Clamp"
    self.WRAP_MODES = {
        [0] = "Clamp",
        "Repeat",
        "Mirror",
        "Black",
        "White",
        "Transparent",
        ["Clamp"] = 0,
        ["Repeat"] = 1,
        ["Mirror"] = 2,
        ["Black"] = 3,
        ["White"] = 4,
        ["Transparent"] = 5
    }
    -- Back Face properties
    self.swapSides = false
    self.backFaceHorizontalInvert = false
    self.backFaceVerticalInvert = false
    self.previousSwapState = false
    self.frontFaceCullMode = "Back" -- Show front faces (cull back faces)
    self.backFaceCullMode = "Front" -- Show back faces (cull front faces)
    self.CULL_MODES = {
        ["None"] = 0, -- No culling - show both sides
        ["Front"] = 1, -- Cull front faces - show back faces
        ["Back"] = 2, -- Cull back faces - show front faces
        ["Front&Back"] = 3,
        [0] = "None",
        [1] = "Front",
        [2] = "Back",
        [3] = "Front&Back"
    }
    self.invertNormal = false
    self.backColorOnly = false
    self.backFaceColor = self._tempColor
    self.backFaceTex = nil
    -- Back Face UV properties
    self.backFaceRotateUV = 0
    self.backFaceOffsetUV = Amaz.Vector2f(0.5, 0.5)
    self.backFaceScaleUV = Amaz.Vector2f(1, 1)
    -- Directional Light Parameters
    self.enableDirLight = true
    self.dirLightDirection = self._temp30
    self.dirLightIntensity = 2.0
    self.dirLightColor = self._tempColor
    -- Point Light Parameters
    self.enablePointLight0 = false
    self.pointLight0Position = self._temp30
    self.pointLight0Color = self._tempColor
    self.pointLight0Intensity = 3.0
    self.pointLight0Range = 15.0
    -- Point light 1
    self.enablePointLight1 = false
    self.pointLight1Position = self._temp30
    self.pointLight1Color = self._tempColor
    self.pointLight1Intensity = 3.0
    self.pointLight1Range = 15.0
    -- Spot light 0
    self.enableSpotLight0 = false
    self.spotLight0Position = self._temp30
    self.spotLight0Direction = self._temp30
    self.spotLight0Color = self._tempColor
    self.spotLight0Intensity = 3.0
    self.spotLight0Range = 15.0
    self.spotLight0InnerAngle = 180
    self.spotLight0ConeSize = 10
    -- Spot light 1
    self.enableSpotLight1 = false
    self.spotLight1Position = self._temp30
    self.spotLight1Direction = self._temp30
    self.spotLight1Color = self._tempColor
    self.spotLight1Intensity = 3.0
    self.spotLight1Range = 15.0
    self.spotLight1InnerAngle = 180
    self.spotLight1ConeSize = 10
    -- PBR Control
    self.pbrBlend = 1.0
    self.backFacePbrBlend = 1.0
    -- PBR Material Parameters
    self.baseColor = self._tempColor
    self.metallic = 0.0
    self.roughness = 0.5
    self.reflectance = 0.0
    self.emissiveColor = self._tempColor
    self.emissiveIntensity = 0.0
    self.ambientOcclusion = 1.0
    self.absoluteNormal = false
    -- ClearCoat properties
    self.enableClearCoat = false
    self.clearCoat = 0.0
    self.clearCoatRoughness = 0.0
    self.clearCoatColor = self._tempColor
    -- Shared
    self.sharedMaterials = {}
    self.InputTex = nil
    self.OutputTex = nil
    -- Others
    self.Utils = includeRelativePath("Utils").Utils
    return self
end

function VATPBRDouble:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    local function setParmVectorNf(parmKey, channel, parmValue)
        local parm = self[parmKey]

        if parm then
            parm[channel] = parmValue
            _setEffectAttr(parmKey, parm)
        end
    end

    local vectorNf_parms = {
        boundMinX = {"boundMin", "x"},
        boundMinY = {"boundMin", "y"},
        boundMinZ = {"boundMin", "z"},
        boundMaxX = {"boundMax", "x"},
        boundMaxY = {"boundMax", "y"},
        boundMaxZ = {"boundMax", "z"},
        matchAxisX = {"matchAxis", "x"},
        matchAxisY = {"matchAxis", "y"},
        matchAxisZ = {"matchAxis", "z"},

        camPosX = {"camPos", "x"},
        camPosY = {"camPos", "y"},
        camPosZ = {"camPos", "z"},
        camRotX = {"camRot", "x"},
        camRotY = {"camRot", "y"},
        camRotZ = {"camRot", "z"},

        objPosX = {"objPos", "x"},
        objPosY = {"objPos", "y"},
        objPosZ = {"objPos", "z"},
        objRotX = {"objRot", "x"},
        objRotY = {"objRot", "y"},
        objRotZ = {"objRot", "z"},
        objScaleX = {"objScale", "x"},
        objScaleY = {"objScale", "y"},
        objScaleZ = {"objScale", "z"},

        pivotPosX = {"pivotPos", "x"},
        pivotPosY = {"pivotPos", "y"},
        pivotPosZ = {"pivotPos", "z"},
        pivotRotX = {"pivotRot", "x"},
        pivotRotY = {"pivotRot", "y"},
        pivotRotZ = {"pivotRot", "z"},
        pivotScaleX = {"pivotScale", "x"},
        pivotScaleY = {"pivotScale", "y"},
        pivotScaleZ = {"pivotScale", "z"},

        dirLightDirectionX = {"dirLightDirection", "x"},
        dirLightDirectionY = {"dirLightDirection", "y"},
        dirLightDirectionZ = {"dirLightDirection", "z"},

        pointLight0PositionX = {"pointLight0Position", "x"},
        pointLight0PositionY = {"pointLight0Position", "y"},
        pointLight0PositionZ = {"pointLight0Position", "z"},

        pointLight1PositionX = {"pointLight1Position", "x"},
        pointLight1PositionY = {"pointLight1Position", "y"},
        pointLight1PositionZ = {"pointLight1Position", "z"},

        spotLight0PosX = {"spotLight0Position", "x"},
        spotLight0PosY = {"spotLight0Position", "y"},
        spotLight0PosZ = {"spotLight0Position", "z"},

        spotLight0DirX = {"spotLight0Direction", "x"},
        spotLight0DirY = {"spotLight0Direction", "y"},
        spotLight0DirZ = {"spotLight0Direction", "z"},

        spotLight1PosX = {"spotLight1Position", "x"},
        spotLight1PosY = {"spotLight1Position", "y"},
        spotLight1PosZ = {"spotLight1Position", "z"},

        spotLight1DirX = {"spotLight1Direction", "x"},
        spotLight1DirY = {"spotLight1Direction", "y"},
        spotLight1DirZ = {"spotLight1Direction", "z"}
    }

    if vectorNf_parms[key] then
        local parmKey = vectorNf_parms[key][1]
        local channel = vectorNf_parms[key][2]
        setParmVectorNf(parmKey, channel, value)
    elseif key == "frontFaceCullMode" then
        value = self.CULL_MODES[value]
        _setEffectAttr(key, value)
    elseif key == "backFaceCullMode" then
        value = self.CULL_MODES[value]
        _setEffectAttr(key, value)
    elseif key == "landscapeRotationDirection" then
        value = math.max(0, math.min(value, #self.LANDSCAPE_ROTATION_DIRECTIONS))
        value = self.LANDSCAPE_ROTATION_DIRECTIONS[value]
        _setEffectAttr(key, value)
    elseif key == "multiRatioMode" then
        value = math.max(0, math.min(value, #self.MULTI_RATIO_MODES))
        value = self.MULTI_RATIO_MODES[value]
        _setEffectAttr(key, value)
    elseif key == "camType" then
        value = math.max(0, math.min(value, #self.CAM_TYPES))
        value = self.CAM_TYPES[value]
        _setEffectAttr(key, value)
    elseif key == "portraitMultiRatioMode" then
        value = math.max(0, math.min(value, #self.MULTI_RATIO_MODES))
        value = self.MULTI_RATIO_MODES[value]
        _setEffectAttr(key, value)
    elseif key == "landscapeMultiRatioMode" then
        value = math.max(0, math.min(value, #self.MULTI_RATIO_MODES))
        value = self.MULTI_RATIO_MODES[value]
        _setEffectAttr(key, value)
    elseif key == "textureWrapMode" then
        value = math.max(0, math.min(value, #self.WRAP_MODES))
        value = self.WRAP_MODES[value]
        _setEffectAttr(key, value)
    elseif key == 'model' or key == 'posTex' or key == 'normTex' then
        return
    end

    _setEffectAttr(key, value)
end

function VATPBRDouble:onStart(comp)
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
    self.vatObjXform = entity:searchEntity("VATObj"):getComponent("Transform")
    self.vatPivotXform = entity:searchEntity("VATPivot"):getComponent("Transform")
    self.vatPassXform = entity:searchEntity("PassVAT"):getComponent("Transform")
    self.vatPass = entity:searchEntity("PassVAT"):getComponent("MeshRenderer")

    self.sharedMaterials = {self.vatPass.material}
    -- Get lights
    self.directionalLight = entity:searchEntity("DirectionalLight")
    self.directionalLightComp = self.directionalLight:getComponent("DirectionalLight")
    self.directionalLightXform = self.directionalLight:getComponent("Transform")

    self.pointLight0 = entity:searchEntity("PointLight0")
    self.pointLight0Comp = self.pointLight0:getComponent("PointLight")
    self.pointLight0Xform = self.pointLight0:getComponent("Transform")

    self.pointLight1 = entity:searchEntity("PointLight1")
    self.pointLight1Comp = self.pointLight1:getComponent("PointLight")
    self.pointLight1Xform = self.pointLight1:getComponent("Transform")

    self.spotLight0 = entity:searchEntity("SpotLight0")
    self.spotLight0Comp = self.spotLight0:getComponent("SpotLight")
    self.spotLight0Xform = self.spotLight0:getComponent("Transform")

    self.spotLight1 = entity:searchEntity("SpotLight1")
    self.spotLight1Comp = self.spotLight1:getComponent("SpotLight")
    self.spotLight1Xform = self.spotLight1:getComponent("Transform")
end

function VATPBRDouble:onUpdate(comp, deltaTime)
    local w, h = self.OutputTex.width, self.OutputTex.height
    self.Utils:setRenderTexture(self.camVAT, self.OutputTex)
    self.camVAT.type = self.CAM_TYPES[self.camType]

    -- Check if swap sides toggle has changed
    if self.swapSides ~= self.previousSwapState then
        self:swapSidesToggle()
        self.previousSwapState = self.swapSides
    end

    self:updateFaceCullModes()

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
    self.Utils:rotateByAxis(self.vatPassXform, self.matchAxis, self._temp30)

    if isEditor then
        self.curTime = self.curTime + deltaTime
        if self.autoplay then
            self.progress = (self.curTime * self.speed) % self.duration / self.duration
        end
    elseif self.AEPlugin then
        self.progress = (self.curTime * self.speed) % self.duration / self.duration
    else
        self.progress = (self.aeTime * self.speed) % self.aeDuration / self.aeDuration
    end

    if self.reverseAnim then
        self.progress = 1.0 - self.progress
    end

    local frameCount = self.frameCount + 1
    local displayFrame = (self.progress * (self.endFrame - self.startFrame)) + self.startFrame
    displayFrame = math.max(self.startFrame, math.min(displayFrame, self.endFrame))
    local finalFrame = (isEditor and self.frameByFrame) and self.displayFrame or displayFrame

    self.Utils:updateCamera(self.camVATXform, self.camVAT, self.camPos, self.camRot, self.camFOV, self.camOrthoScale)
    self:calculateTransform(w, h)
    self:updateVAT(frameCount, finalFrame)
    self:updateLighting()
end

function VATPBRDouble:calculateTransform(width, height)
    local aspect = width / height
    local isLandscape = aspect > 1.0

    -- Determine which multiRatioMode to use
    local currentMultiRatioMode = self.Utils:determineMultiRatioMode(self.useOrientationSpecificRatio, isLandscape,
        self.landscapeMultiRatioMode, self.portraitMultiRatioMode)

    local mode = self.MULTI_RATIO_MODES[currentMultiRatioMode]

    -- Calculate transform parameters
    local offsetUV = Amaz.Vector2f(0.5, 0.5)
    local transformParams = self.Utils:calculateTransformParams(aspect, isLandscape, self.rotateMeshOnLandscape,
        self.landscapeRotationDirection, self.rotateUVWithMesh, offsetUV, mode, self.landscapeSizeScale)

    -- Apply calculated parameters
    self:_applyTransformParams(transformParams)
end

function VATPBRDouble:_applyTransformParams(params)
    -- Apply rotation and UV settings
    self.rotateUV = params.rotateUV
    self.offsetUV.x = params.offsetUV.x
    self.offsetUV.y = params.offsetUV.y
    self.pivotRot.z = params.pivotRotZ

    -- Apply aspect and scale
    self.aspect.x = params.aspectX
    self.aspect.y = params.aspectY
    self.scaleUV.x = params.scaleUVX
    self.scaleUV.y = params.scaleUVY
    self.backFaceScaleUV.x = params.backUVX
    self.backFaceScaleUV.y = params.backUVY

    -- Apply transforms
    self.vatPivotXform.localScale = self.pivotScale
    self.vatPivotXform.localPosition = Amaz.Vector3f(-self.pivotPos.x, -self.pivotPos.y, -self.pivotPos.z)
    self.vatPivotXform.localOrientation = self.Utils:calculateQuarternion(self.pivotRot)

    self.vatObjXform.localScale = Amaz.Vector3f(self.aspect.x * self.objScale.x, self.aspect.y * self.objScale.y,
        self.objScale.z)
    self.vatObjXform.localPosition = self.objPos
    self.vatObjXform.localOrientation = self.Utils:calculateQuarternion(self.objRot)
end

function VATPBRDouble:updateVAT(frameCount, finalFrame)
    local posTex = self.posTex
    local normTex = self.normTex

    for _, mat in ipairs(self.sharedMaterials) do
        -- Tex Inputs
        mat:setTex("u_inputTex", self.InputTex)
        mat:setTex("u_vatPosTex", posTex)
        mat:setTex("u_vatNormTex", normTex)
        -- Texture Wrapper
        mat:setInt("u_wrapMode", self.WRAP_MODES[self.textureWrapMode])
        mat:setInt("u_backFaceHorizontalInvert", self.backFaceHorizontalInvert and 1 or 0)
        mat:setInt("u_backFaceVerticalInvert", self.backFaceVerticalInvert and 1 or 0)
        mat:setVec2("u_scaleUV", Amaz.Vector2f(self.scaleUV.x, self.scaleUV.y))
        mat:setVec2("u_offsetUV", Amaz.Vector2f(self.offsetUV.x, self.offsetUV.y))
        mat:setFloat("u_rotateUV", math.rad(self.rotateUV))
        -- VAT uniforms
        mat:setFloat("u_frameCount", frameCount)
        mat:setFloat("u_displayFrame", finalFrame)
        mat:setFloat("u_yResolution", posTex.height)
        mat:setVec3("u_maxValues", self.boundMax)
        mat:setVec3("u_minValues", self.boundMin)
        -- PBR Control
        mat:setInt("u_enablePBR", self.enablePBR and 1 or 0)
        mat:setFloat("u_pbrBlend", self.pbrBlend)
        mat:setFloat("u_backFacePbrBlend", self.backFacePbrBlend)
        -- PBR Material uniforms
        mat:setVec3("u_camPos", self.camPos)
        mat:setVec3("u_baseColor", Amaz.Vector3f(self.baseColor.r, self.baseColor.g, self.baseColor.b))
        mat:setFloat("u_metallic", self.metallic)
        mat:setFloat("u_roughness", self.roughness)
        mat:setFloat("u_reflectance", self.reflectance)
        mat:setFloat("u_ambientOcclusion", self.ambientOcclusion)
        mat:setVec3("u_emissiveColor", Amaz.Vector3f(self.emissiveColor.r, self.emissiveColor.g, self.emissiveColor.b))
        mat:setFloat("u_emissiveIntensity", self.emissiveIntensity)
        mat:setInt("u_absoluteNormal", self.absoluteNormal and 1 or 0)
        -- light
        mat:setInt("u_enableDirectionalLight", self.enableDirLight and 1 or 0)
        mat:setInt("u_enablePointLight0", self.enablePointLight0 and 1 or 0)
        mat:setInt("u_enablePointLight1", self.enablePointLight1 and 1 or 0)
        mat:setInt("u_enableSpotLight0", self.enableSpotLight0 and 1 or 0)
        mat:setInt("u_enableSpotLight1", self.enableSpotLight1 and 1 or 0)
        -- ClearCoat properties
        mat:setInt("u_enableClearCoat", self.enableClearCoat and 1 or 0)
        mat:setFloat("u_clearCoat", self.clearCoat)
        mat:setFloat("u_clearCoatRoughness", self.clearCoatRoughness)
        mat:setVec3("u_clearCoatColor",
            Amaz.Vector3f(self.clearCoatColor.r, self.clearCoatColor.g, self.clearCoatColor.b))
        -- BackFace
        mat:setInt("u_colorOnly", self.backColorOnly and 1 or 0)
        mat:setInt("u_invertNormal", self.invertNormal and 1 or 0)
        mat:setTex("u_backFaceTex", self.backFaceTex)
        mat:setVec3("u_backFaceColor", Amaz.Vector3f(self.backFaceColor.r, self.backFaceColor.g, self.backFaceColor.b))
        -- Back Face UV
        mat:setFloat("u_backFaceRotateUV", math.rad(self.backFaceRotateUV))
        mat:setVec2("u_backFaceOffsetUV", Amaz.Vector2f(self.backFaceOffsetUV.x, self.backFaceOffsetUV.y))
        mat:setVec2("u_backFaceScaleUV", Amaz.Vector2f(self.backFaceScaleUV.x, self.backFaceScaleUV.y))
    end
end

function VATPBRDouble:updateLighting()
    self.Utils:updateDirLight(self.directionalLight, self.directionalLightComp, self.directionalLightXform,
        self.enableDirLight, self.dirLightDirection, self.dirLightIntensity, self.dirLightColor)

    self.Utils:updatePointLight(self.pointLight0, self.pointLight0Comp, self.pointLight0Xform, self.enablePointLight0,
        self.pointLight0Position, self.pointLight0Intensity, self.pointLight0Range, self.pointLight0Color)

    self.Utils:updatePointLight(self.pointLight1, self.pointLight1Comp, self.pointLight1Xform, self.enablePointLight1,
        self.pointLight1Position, self.pointLight1Intensity, self.pointLight1Range, self.pointLight1Color)

    self.Utils:updateSpotLight(self.spotLight0, self.spotLight0Comp, self.spotLight0Xform, self.enableSpotLight0,
        self.spotLight0Position, self.spotLight0Direction, self.spotLight0Intensity, self.spotLight0Range,
        self.spotLight0InnerAngle, self.spotLight0ConeSize, self.spotLight0Color)

    self.Utils:updateSpotLight(self.spotLight1, self.spotLight1Comp, self.spotLight1Xform, self.enableSpotLight1,
        self.spotLight1Position, self.spotLight1Direction, self.spotLight1Intensity, self.spotLight1Range,
        self.spotLight1InnerAngle, self.spotLight1ConeSize, self.spotLight1Color)
end

-- Add this new method before updateFaceCullModes function
function VATPBRDouble:swapSidesToggle()
    -- Swap front and back face cull modes
    local tempCullMode = self.frontFaceCullMode
    self.frontFaceCullMode = self.backFaceCullMode
    self.backFaceCullMode = tempCullMode

    -- Toggle normal inversion
    self.invertNormal = not self.invertNormal

    Amaz.LOGI(self.TAG,
        'Sides swapped - Front: ' .. self.frontFaceCullMode .. ', Back: ' .. self.backFaceCullMode .. ', InvertNormal: ' ..
            tostring(self.invertNormal))

    -- Update cull modes immediately
    self:updateFaceCullModes()

    return true
end

function VATPBRDouble:updateFaceCullModes()
    -- Check if material and passes exist
    if not self.vatPass or not self.vatPass.material or not self.vatPass.material.xshader then
        Amaz.LOGE(self.TAG, 'Cannot update cull modes: material or xshader not found')
        return false
    end

    local passes = self.vatPass.material.xshader.passes
    if passes:size() < 2 then
        Amaz.LOGE(self.TAG, 'Cannot update cull modes: need at least 2 passes')
        return false
    end

    local pass0 = passes:get(0) -- Front face pass
    local pass1 = passes:get(1) -- Back face pass

    -- Set cull mode for front face pass (pass 0)
    local frontCullMode = self.CULL_MODES[self.frontFaceCullMode]
    if pass0.renderState and pass0.renderState.rasterization then
        pass0.renderState.rasterization.cullMode = frontCullMode
        -- Amaz.LOGI(self.TAG,
        -- 'Front face pass cull mode set to: ' .. self.frontFaceCullMode .. ' (' .. frontCullMode .. ')')
    end

    -- Set cull mode for back face pass (pass 1)
    local backCullMode = self.CULL_MODES[self.backFaceCullMode]
    if pass1.renderState and pass1.renderState.rasterization then
        pass1.renderState.rasterization.cullMode = backCullMode
        -- Amaz.LOGI(self.TAG, 'Back face pass cull mode set to: ' .. self.backFaceCullMode .. ' (' .. backCullMode .. ')')
    end

    return true
end

function VATPBRDouble:configureFrontBackRendering(frontCull, backCull)
    -- Check if material and passes exist
    if not self.vatPass or not self.vatPass.material or not self.vatPass.material.xshader then
        Amaz.LOGE(self.TAG, 'Cannot configure rendering: material or xshader not found')
        return false
    end

    local passes = self.vatPass.material.xshader.passes
    if passes:size() < 2 then
        Amaz.LOGE(self.TAG, 'Cannot configure rendering: need at least 2 passes')
        return false
    end

    local pass0 = passes:get(0)
    local pass1 = passes:get(1)

    -- Configure pass 0 for front faces
    if pass0.renderState and pass0.renderState.rasterization then
        pass0.renderState.rasterization.cullMode = self.CULL_MODES[frontCull or "Back"]
    end

    -- Configure pass 1 for back faces
    if pass1.renderState and pass1.renderState.rasterization then
        pass1.renderState.rasterization.cullMode = self.CULL_MODES[backCull or "Front"]
    end

    -- Amaz.LOGI(self.TAG, 'Front/Back rendering configured - Front: ' .. (frontCull or "Back") .. ', Back: ' ..
    --     (backCull or "Front"))
    return true
end

exports.VATPBRDouble = VATPBRDouble
return exports
