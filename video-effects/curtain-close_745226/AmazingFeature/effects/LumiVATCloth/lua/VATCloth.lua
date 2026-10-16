local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local VATCloth = VATCloth or {}
VATCloth.__index = VATCloth
---@class VATCloth : ScriptComponent
---@field autoplay boolean
---@field frameByFrame boolean
---@field speed number [UI(Range={0.0, 1.0}, Drag)]
---@field duration number [UI(Range={0.0, 100.0}, Drag)]
---@field progress number [UI(Range={0, 1}, Slider)]
---@field displayFrame number [UI(Range={1, 100}, Drag)]
---@field frameCount number [UI(Range={1, 100}, Drag)]
---@field interpolation number [UI(Range={0, 1}, Slider)]
---@field startFrame number [UI(Range={0, 100}, Drag)]
---@field endFrame number [UI(Range={1, 100}, Drag)]
---@field boundMax Vector3f
---@field boundMin Vector3f

---@field camOrthoScale number [UI(Range={0.0, 2.0}, Drag)]
---@field camFOV number [UI(Range={0.0, 180.0}, Drag)]
---@field camPosXY Vector2f
---@field camPosZ number

---@field mesh Mesh
---@field pivot Vector3f
---@field positionXY Vector2f
---@field positionZ number
---@field direction Vector3f
---@field rotation Vector3f
---@field scale Vector3f

---@field rotateOnLandscape boolean [UI(Display="Rotate on Landscape")]
---@field rotateUV number [UI(Range={-360.0, 360.0}, Drag)]
---@field offsetUV Vector2f
---@field scaleUV Vector2f
---@field padding Vector2f
---@field edgeType String [UI(Option={"Tile", "Mirror", "Clamp", "Empty"})]

---@field lightingBlend number [UI(Range={0.0, 1.0}, Drag)]
---@field shadowIntensity number [UI(Range={0.0, 10.0}, Drag)]
---@field shadowContrast number [UI(Range={0.0, 10.0}, Drag)]
---@field shadowColor Color [UI(NoAlpha)]

---@field enableDirLight boolean
---@field dirLightDir Vector3f
---@field dirLightColor Color [UI(NoAlpha)]
---@field dirLightIntensity number [UI(Range={0.0, 1000.0}, Drag)]

---@field enablePointLight boolean
---@field pointLightPos Vector3f
---@field pointLightColor Color [UI(NoAlpha)]
---@field pointLightIntensity number [UI(Range={0.0, 1000.0}, Drag)]
---@field pointLightAttenRangeInv number [UI(Range={0.0, 1000.0}, Drag)]

---@field enableSpotLight boolean
---@field spotLightPos Vector3f
---@field spotLightDir Vector3f
---@field spotLightColor Color [UI(NoAlpha)]
---@field spotLightIntensity number [UI(Range={0.0, 1000.0}, Drag)]
---@field spotLightAttenRangeInv number [UI(Range={0.0, 1000.0}, Drag)]
---@field spotLightInnerAngle number [UI(Range={0.0, 360.0}, Drag)]
---@field spotLightOuterAngle number [UI(Range={0.0, 360.0}, Drag)]

---@field enableEnv boolean
---@field envLightIntensity number [UI(Range={0.0, 1000.0}, Drag)]
---@field envLightRotation number [UI(Range={-360.0, 360.0}, Drag)]
---@field envRotAxis Vector3f

---@field enableToneMapping boolean
---@field mainColor Color [UI(NoAlpha)]

---@field enableNormTex boolean
---@field normInt number [UI(Range={0.0, 1.0}, Drag)]
---@field metallic number [UI(Range={0.0, 1.0}, Drag)]
---@field roughness number [UI(Range={0.0, 1.0}, Drag)]
---@field anisoAngle number [UI(Range={0.0, 180.0}, Drag)]
---@field anisoStrength number [UI(Range={0.0, 1.0}, Drag)]

---@field normTex Texture
---@field envTex Texture

---@field posTex Texture
---@field rotTex Texture
---@field colTex Texture

---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local function createRenderTexture(width, height, filterMag, filterMin)
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = filterMag or Amaz.FilterMode.LINEAR
    rt.filterMin = filterMin or Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    rt.attachment = Amaz.RenderTextureAttachment.DEPTH
    return rt
end

local function updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

function VATCloth.new(construct, ...)
    local self = setmetatable({}, VATCloth)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"
    -- VAT 
    self.speed = 1
    self.progress = 0
    self.curTime = 0
    self.aeTime = 0
    self.AEPlugin = false
    self.endTime = 0
    self.startTime = 0.1
    self.duration = 3
    self.autoplay = true
    self.displayFrame = 1
    self.startFrame = 1
    self.endFrame = 24
    self.frameCount = 24
    self.frameByFrame = false
    self.interpolation = 1
    self.boundMax = Amaz.Vector3f(1, 1, 1)
    self.boundMin = Amaz.Vector3f(0, 0, 0)
    self.posTex = nil
    self.rotTex = nil
    self.colTex = nil
    -- Cam
    self.camOrthoScale = 1.2
    self.camFOV = 60
    self.camPosXY = Amaz.Vector2f(0.5, 0.5)
    self.camPosZ = 0
    -- Model
    self.mesh = nil
    self.pivot = Amaz.Vector3f(0, 0, 0)
    self.positionXY = Amaz.Vector2f(0.5, 0.5)
    self.positionZ = 0
    self.scale = Amaz.Vector3f(1, 1, 1)
    self.direction = Amaz.Vector3f(0, 0, 0)
    self.rotation = Amaz.Vector3f(0, 0, 0)
    -- UV
    self.rotateOnLandscape = true
    self.rotateUV = 0
    self.offsetUV = Amaz.Vector2f(0, 0)
    self.scaleUV = Amaz.Vector2f(1, 1)
    self.padding = Amaz.Vector2f(0.01, 0.01)
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
    self.edgeType = "Tile"

    -- Lighting
    self.lightingBlend = 0
    self.shadowIntensity = 0
    self.shadowContrast = 1
    self.shadowColor = Amaz.Color(1, 1, 1)

    self.enableDirLight = false
    self.dirLightIntensity = 1
    self.dirLightColor = Amaz.Color(1, 1, 1)
    self.dirLightDir = Amaz.Vector3f(0, 0, -1)

    self.pointLightIntensity = 1
    self.pointLightColor = Amaz.Color(1, 1, 1)
    self.pointLightAttenRangeInv = 1
    self.pointLightPos = Amaz.Vector3f(0, 0, 0)

    self.spotLightIntensity = 1
    self.spotLightColor = Amaz.Color(1, 1, 1)
    self.spotLightAttenRangeInv = 1
    self.spotLightInnerAngle = 30
    self.spotLightOuterAngle = 160
    self.spotLightPos = Amaz.Vector3f(0, 2.5, 2.5)
    self.spotLightDir = Amaz.Vector3f(-90, 0, -1)

    self.enableEnv = false
    self.envLightIntensity = 1
    self.envLightRotation = 0
    self.envRotAxis = Amaz.Vector3f(0, 0, 0)
    self.envTex = nil

    -- PBR
    self.enableToneMapping = false
    self.enableNormTex = false
    self.normTex = nil
    self.normInt = 1
    self.mainColor = Amaz.Color(1, 1, 1, 1)
    self.metallic = 0
    self.roughness = 0
    self.anisoAngle = 0
    self.anisoStrength = 0

    -- Shared
    self.sharedPBRMat = {}
    self.InputTex = nil
    self.InputTexBack = nil
    self.OutputTex = nil

    return self
end

function VATCloth:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "cropType" then
        value = math.max(0, math.min(value, #self.CROP_TYPES))
        _setEffectAttr(key, self.CROP_TYPES[value])
    else
        _setEffectAttr(key, value)
    end
end

function VATCloth:rotateByAxis(_trans, _direction, _euler_angle)
    -- ae xyz, editor yxz
    local right = Amaz.Vector3f(1.0, 0.0, 0.0)
    local up = Amaz.Vector3f(0.0, 1.0, 0.0)
    local forward = Amaz.Vector3f(0.0, 0.0, 1.0)

    local cur_orientation = Amaz.Quaternionf.axisAngleToQuaternion(right, math.rad(_direction.x)) *
                                Amaz.Quaternionf.axisAngleToQuaternion(up, -math.rad(_direction.y)) *
                                Amaz.Quaternionf.axisAngleToQuaternion(forward, -math.rad(_direction.z))

    up = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, up)
    right = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, right)
    forward = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, forward)

    cur_orientation = Amaz.Quaternionf.axisAngleToQuaternion(right, math.rad(_euler_angle.x)) *
                          Amaz.Quaternionf.axisAngleToQuaternion(up, -math.rad(_euler_angle.y)) *
                          Amaz.Quaternionf.axisAngleToQuaternion(forward, -math.rad(_euler_angle.z)) * cur_orientation

    _trans.localOrientation = cur_orientation
end

function VATCloth:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.camVAT = self.entity:searchEntity("CameraVAT"):getComponent("Camera")
    self.camVATXform = self.entity:searchEntity("CameraVAT"):getComponent("Transform")

    self.vatPass = self.entity:searchEntity("PassVAT"):getComponent("MeshRenderer")
    self.vatMat = self.vatPass.material

    self.vatXform = self.entity:searchEntity("VAT_obj"):getComponent("Transform")

    local pivotEntity = self.entity:searchEntity("VAT_pivot")
    if pivotEntity then
        self.pivotXform = pivotEntity:getComponent("Transform")
    end

    self.sharedPBRMat = {self.vatMat, self.vatMatBack}

    -- Lighting
    self.dirLightTransform = self.entity:searchEntity("DirectionalLight"):getComponent("Transform")

    self.pointLightTransform = self.entity:searchEntity("PointLight"):getComponent("Transform")

    self.spotLightTransform = self.entity:searchEntity("SpotLight"):getComponent("Transform")
end

function VATCloth:onUpdate(comp, deltaTime)
    if self.OutputTex then
        self.camVAT.renderTexture = self.OutputTex
    end
    self.camVAT.fovy = self.camFOV
    self.camVATXform.localPosition = Amaz.Vector3f(self.camPosXY.x, self.camPosXY.y, self.camPosZ)
    self.vatPass.mesh = self.mesh

    self:calculateTransform()

    self:rotateByAxis(self.dirLightTransform, Amaz.Vector3f(0, 0, 0), self.dirLightDir)
    self:rotateByAxis(self.spotLightTransform, Amaz.Vector3f(0, 0, 0), self.spotLightDir)

    self.spotLightTransform.localPosition = self.spotLightPos
    self.pointLightTransform.localPosition = self.pointLightPos

    for _, mat in ipairs(self.sharedPBRMat) do
        -- Basic material properties
        mat:setTex("u_normTex", self.normTex)
        mat:setVec4("u_mainColor", Amaz.Vector4f(self.mainColor.r, self.mainColor.g, self.mainColor.b, self.mainColor.a))
        mat:setFloat("u_metallic", self.metallic)
        mat:setFloat("u_roughness", self.roughness)
        mat:setFloat("u_anisoAngle", self.anisoAngle)
        mat:setFloat("u_anisoStrength", self.anisoStrength)

        -- Environment settings
        mat:setFloat("u_envEnabled", self.enableEnv and 1.0 or 0.0)
        mat:setTex("u_envTex", self.envTex)
        mat:setFloat("u_envInt", self.envLightIntensity)
        mat:setFloat("u_envRot", math.rad(self.envLightRotation))
        mat:setVec3("u_envRotAxis", Amaz.Vector3f(self.envRotAxis.x, self.envRotAxis.y, self.envRotAxis.z))

        -- Normal mapping
        mat:setInt("u_enableNormTex", self.enableNormTex and 1 or 0)
        mat:setFloat("u_normInt", self.normInt)

        -- Post processing
        mat:setInt("u_enableToneMapping", self.enableToneMapping and 1 or 0)
        mat:setFloat("u_lightingBlend", self.lightingBlend)

        -- Directional light
        local dirEnabled = self.enableDirLight and 1.0 or 0.0
        mat:setFloat("u_dirLightEnabled", dirEnabled)
        mat:setVec3("u_dirLightColor", Amaz.Vector3f(self.dirLightColor.r, self.dirLightColor.g, self.dirLightColor.b))
        mat:setFloat("u_dirLightIntensity", self.dirLightIntensity)

        local neutral = Amaz.Vector3f(0, 0, 0)
        self:rotateByAxis(self.dirLightTransform, neutral, self.dirLightDir)
        local dirLightQuat = self.dirLightTransform.localOrientation
        local forward = Amaz.Vector3f(0, 0, -1)
        local dirLightDirection = Amaz.Quaternionf.rotateVectorByQuat(dirLightQuat, forward)
        mat:setVec3("u_dirLightDirection", dirLightDirection)

        -- Point light
        local pointEnabled = self.enablePointLight and 1.0 or 0.0
        mat:setFloat("u_pointLightEnabled", pointEnabled)
        mat:setVec3("u_pointLightPosition",
            Amaz.Vector3f(self.pointLightPos.x, self.pointLightPos.y, self.pointLightPos.z))
        mat:setFloat("u_pointLightIntensity", self.pointLightIntensity)
        mat:setVec3("u_pointLightColor",
            Amaz.Vector3f(self.pointLightColor.r, self.pointLightColor.g, self.pointLightColor.b))
        mat:setFloat("u_pointLightAttenRangeInv", 1.0 / self.pointLightAttenRangeInv)

        -- Spot light
        local spotEnabled = self.enableSpotLight and 1.0 or 0.0
        mat:setFloat("u_spotLightEnabled", spotEnabled)
        mat:setFloat("u_spotLightIntensity", self.spotLightIntensity)
        mat:setVec3("u_spotLightPosition", Amaz.Vector3f(self.spotLightPos.x, -self.spotLightPos.y, self.spotLightPos.z))
        mat:setVec3("u_spotLightColor",
            Amaz.Vector3f(self.spotLightColor.r, self.spotLightColor.g, self.spotLightColor.b))
        mat:setFloat("u_spotLightAttenRangeInv", 1.0 / self.spotLightAttenRangeInv)
        mat:setFloat("u_spotLightInnerAngleCos", math.cos(math.rad(self.spotLightInnerAngle)))
        mat:setFloat("u_spotLightOuterAngleCos", math.cos(math.rad(self.spotLightOuterAngle)))

        local spotLightQuat = Amaz.Quaternionf()
        self:rotateByAxis(self.spotLightTransform, neutral, self.spotLightDir)
        spotLightQuat = self.spotLightTransform.localOrientation
        local spotLightDirection = Amaz.Quaternionf.rotateVectorByQuat(spotLightQuat, forward)
        mat:setVec3("u_spotLightDirection", spotLightDirection)
    end

    -- VAT animation update
    if isEditor then
        self.curTime = self.curTime + deltaTime
        if self.autoplay then
            self.progress = self.curTime % self.duration / self.duration
        end
    else
        self.progress = (self.curTime - self.startTime) * self.speed / self.duration
    end
    self:updateVAT(self.progress)

end

function VATCloth:calculateTransform()
    if not self.OutputTex or not self.InputTex then
        return
    end

    local canvasWidth = self.OutputTex.width
    local canvasHeight = self.OutputTex.height
    local aspect = canvasWidth / canvasHeight

    local isLandscape = canvasWidth > canvasHeight
    local rotate = (isLandscape and self.rotateOnLandscape) and 90 or self.rotateUV
    local camOrthoScale = isLandscape and self.camOrthoScale * aspect or self.camOrthoScale

    -- Set rotation values 
    self.direction.z = isLandscape and -rotate or 0
    self.rotateUV = rotate

    -- Set scale values
    self.scale.x = isLandscape and aspect or aspect

    -- Set UV scales
    local scaleX = isLandscape and camOrthoScale / aspect or camOrthoScale
    local scaleY = isLandscape and camOrthoScale / aspect or camOrthoScale

    self.scaleUV.x = scaleX
    self.scaleUV.y = scaleY

    if not isLandscape then
        self.camVAT.orthoScale = camOrthoScale
    end

    -- Apply mesh transforms
    self.pivotXform.localPosition = self.pivot
    self.pivotXform.localScale = Amaz.Vector3f(1, 1, 1)
    self:rotateByAxis(self.pivotXform, Amaz.Vector3f(0, 0, 0), Amaz.Vector3f(0, 0, 0))

    self.vatXform.localPosition = Amaz.Vector3f(self.positionXY.x, self.positionXY.y, self.positionZ)
    self.vatXform.localScale = self.scale
    self:rotateByAxis(self.vatXform, self.direction, self.rotation)

end

function VATCloth:updateVAT(progress)
    local frameCount = self.frameCount
    local frameRange = self.endFrame - self.startFrame + 1
    local displayFrame = self.startFrame + math.floor(progress * frameRange)
    displayFrame = math.max(self.startFrame, math.min(displayFrame, self.endFrame))

    local finalFrame = (isEditor and self.frameByFrame) and self.displayFrame or displayFrame
    self.vatMat:setFloat("u_displayFrame", finalFrame)
    self.vatMat:setFloat("u_frameCount", frameCount)
    self.vatMat:setFloat("u_interpolate", self.interpolation)

    self.vatMat:setTex("u_posTex", self.posTex)
    self.vatMat:setTex("u_rotTex", self.rotTex)
    self.vatMat:setTex("u_colTex", self.colTex)

    self.vatMat:setVec3("u_boundMax", self.boundMax)
    self.vatMat:setVec3("u_boundMin", self.boundMin)

    self.vatMat:setFloat("u_shadowIntensity", self.shadowIntensity)
    self.vatMat:setFloat("u_shadowContrast", self.shadowContrast)
    self.vatMat:setVec3("u_shadowColor", Amaz.Vector3f(self.shadowColor.r, self.shadowColor.g, self.shadowColor.b))

    local function set_vat_material_properties(vat_mat, input, offset, scale, padding, rotate, edgeType)
        if not input then
            return
        end

        vat_mat:setTex("u_input", input)
        vat_mat:setVec2("u_offset", offset)
        vat_mat:setVec2("u_scale", scale)
        vat_mat:setFloat("u_rotate", math.rad(rotate))
        vat_mat:setInt("u_edgeType", self.EDGE_TYPES[edgeType])
    end

    set_vat_material_properties(self.vatMat, self.InputTex, self.offsetUV, self.scaleUV, self.padding, self.rotateUV,
        self.edgeType)
end

exports.VATCloth = VATCloth
return exports
