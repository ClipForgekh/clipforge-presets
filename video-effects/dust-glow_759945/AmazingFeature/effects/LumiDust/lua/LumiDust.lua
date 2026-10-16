local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiDust = LumiDust or {}
LumiDust.__index = LumiDust
---@class LumiDust : ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture

---@field dustNum number [UI(Range={0, 2}, Slider)]
---@field dustSize number [UI(Range={0, 10}, Slider)]

---@field distorIns number

---@field brightness number
---@field contrast number
---@field quantity number
---@field complexity number
---@field evolution number
---@field cycle int [UI(Range={1, 100}, Slider)]
---@field offset_x number
---@field offset_y number

---@field maskType string [UI(Option={"Noise", "Line", "Image"})]

---@field mask_noise_brightness number
---@field mask_noise_contrast number
---@field mask_noise_quantity number
---@field mask_noise_complexity number
---@field mask_noise_evolution number
---@field mask_noise_cycle int [UI(Range={1, 100}, Slider)]
---@field mask_noise_offset_x number
---@field mask_noise_offset_y number
---@field mask_line_rot number 
---@field maskFeather number [UI(Range={0, 1}, Drag)]
---@field mask_image Texture

---@field startRotX number
---@field startRotY number
---@field startRotZ number
---@field startMoveX number
---@field startMoveY number
---@field startMoveZ number
---@field startSize number

---@field endRotX number
---@field endRotY number
---@field endRotZ number
---@field endMoveX number
---@field endMoveY number
---@field endMoveZ number
---@field endSize number
---@field endImg Texture

---@field progress number [UI(Range={0, 100}, Drag)]

local maskTypeVec = {"Noise", "Line", "Image"}

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function LumiDust.new(construct, ...)

    local self = setmetatable({}, LumiDust)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.InputTex = nil
    self.OutputTex = nil
    self.width = 0
    self.height = 0

    self.startTime = 0.0
    self.endTime = 6
    self.curTime = 0.0
    self.aeTime = 0.0
    self.AEPlugin = false

    -- for particle

    self.progress = 1

    self.maskFeather = 1
    self.brightness = 0
    self.contrast = 0
    self.quantity = 2
    self.complexity = 1
    self.evolution = 0
    self.cycle = 100
    self.offset_x = 0
    self.offset_y = 0
    self.distorIns = 1
    self.gravity = 0
    self.gravityRot = 0

    self.mask_noise_brightness = 0
    self.mask_noise_contrast = 0
    self.mask_noise_quantity = 2
    self.mask_noise_complexity = 1
    self.mask_noise_evolution = 0
    self.mask_noise_cycle = 100
    self.mask_noise_offset_x = 0
    self.mask_noise_offset_y = 0
    self.mask_line_rot = 0
    self.mask_image = nil
    self.maskType = "Noise"

    self.startRotX = 0
    self.startRotY = 0
    self.startRotZ = 0
    self.startMoveX = 0
    self.startMoveY = 0
    self.startMoveZ = 0
    self.startSize = 1

    self.endRotX = 0
    self.endRotY = 0
    self.endRotZ = 0
    self.endMoveX = 0
    self.endMoveY = 0
    self.endMoveZ = 0
    self.endSize = 1
    self.endImg = nil
    self.AEPlugin = false

    self.dustNum = 1
    self.dustSize = 1

    return self
end

function LumiDust:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == 'maskType' then
        local maskType = maskTypeVec[value + 1]
        _setEffectAttr(key, maskType)
    else
        _setEffectAttr(key, value)
    end
end
function LumiDust:createCustomMesh()
    local customMesh = Amaz.Mesh()
    local customSubMesh = Amaz.SubMesh()
    customSubMesh.primitive = Amaz.Primitive.POINTS
    if customMesh and customSubMesh then
    end

    local attPosition = Amaz.VertexAttribDesc()
    attPosition.semantic = Amaz.VertexAttribType.POSITION
    local texcoord1 = Amaz.VertexAttribDesc()
    texcoord1.semantic = Amaz.VertexAttribType.TEXCOORD1

    local vads = Amaz.Vector()

    vads:pushBack(attPosition)

    -- vads:pushBack(uv)
    vads:pushBack(texcoord1)

    customMesh.vertexAttribs = vads

    local vertexData = {}
    local indexData = {}

    local fv = Amaz.FloatVector()

    local indices = Amaz.UInt16Vector()

    local pointNum = 1

    fv:pushBack(0)
    fv:pushBack(0)
    fv:pushBack(14.50)
    fv:pushBack(pointNum)
    fv:pushBack(pointNum)
    indices:pushBack(pointNum - 1)
    customMesh.vertices = fv
    customSubMesh.indices16 = indices
    customSubMesh.mesh = customMesh
    customMesh:addSubMesh(customSubMesh)

    return customMesh
end

function LumiDust:onStart(comp)

    self.entity = comp.entity
    self.comp = comp
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    -- Use entity instead of scene 
    self.camera = self.entity:searchEntity("Camera_renderer"):getComponent("Camera")

    -- if temporary texture has the same dimensions as self.OutputTex, and need not persist, advised to used sharedRT
    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.midTex = self.lumiSharedRt:get(0)
    end

    self.dust_mat = self.entity:searchEntity("render_mesh"):getComponent("MeshRenderer").material
    self.dust_mat2 = self.entity:searchEntity("render_mesh_2"):getComponent("MeshRenderer").material
    self.dust_mat3 = self.entity:searchEntity("render_mesh_3"):getComponent("MeshRenderer").material

    self.noiseMaterial = self.entity:searchEntity("noise"):getComponent("MeshRenderer").material
    self.maskNoiseMaterial = self.entity:searchEntity("maskNoise"):getComponent("MeshRenderer").material

    self.MeshEntity = self.entity:searchEntity("render_mesh")
    self.MeshEntity2 = self.entity:searchEntity("render_mesh_2")
    self.MeshEntity3 = self.entity:searchEntity("render_mesh_3")
end

function LumiDust:onUpdate(comp, deltaTime)

    -- set the input and output textures to be displayed
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end

    -- if using sharedRT, dimensions need to be consistent with self.InputTex or self.OutputTex
    if self.midTex then
        if self.midTex.width ~= self.OutputTex.width or self.midTex.height ~= self.OutputTex.height then
            self.midTex.width = self.OutputTex.width
            self.midTex.height = self.OutputTex.height
        end
    end

    if isEditor then
        self.curTime = self.curTime + deltaTime
    elseif self.AEPlugin then
        self.curTime = self.curTime
    else
        self.curTime = self.aeTime
    end

    self:updateMaterials(self.curTime)
end

-- Helper function: Convert Euler angles to 9 float elements of a 3x3 rotation matrix
-- Order follows your original Shader logic: Z -> Y -> X (or adjust according to your original mix order)
-- Your original Shader logic seems to mix angles and then convert to quaternion, here we simplify to directly generate the matrix
local function getRotationMatrix3x3(rotX, rotY, rotZ)
    local radX = math.rad(rotX)
    local radY = math.rad(rotY)
    local radZ = math.rad(rotZ)

    local cx, sx = math.cos(radX), math.sin(radX)
    local cy, sy = math.cos(radY), math.sin(radY)
    local cz, sz = math.cos(radZ), math.sin(radZ)

    local m00 = cy * cz
    local m01 = -cx * sz + sx * sy * cz
    local m02 = sx * sz + cx * sy * cz

    local m10 = cy * sz
    local m11 = cx * cz + sx * sy * sz
    local m12 = -sx * cz + cx * sy * sz

    local m20 = -sy
    local m21 = sx * cy
    local m22 = cx * cy

    return Amaz.Vector3f(m00, m10, m20), Amaz.Vector3f(m01, m11, m21), Amaz.Vector3f(m02, m12, m22)
end

function LumiDust:updateMaterials(time)
    self.noiseMaterial:setFloat("u_Brightness", self.brightness)
    self.noiseMaterial:setFloat("u_Contrast", self.contrast)
    self.noiseMaterial:setVec2("u_Scale", Amaz.Vector2f(self.quantity, self.quantity));
    self.noiseMaterial:setFloat("u_Complexity", self.complexity);
    self.noiseMaterial:setFloat("u_Evolution", math.abs(self.evolution) / 90.0);
    self.noiseMaterial:setFloat("u_Cycle", math.max(2, math.floor(self.cycle * 3.0 + 0.5)));
    self.noiseMaterial:setVec2("u_Offset", Amaz.Vector2f(self.offset_x, self.offset_y))
    self.noiseMaterial:setFloat("picture_scale", 1)

    self.maskNoiseMaterial:setFloat("u_Brightness", self.mask_noise_brightness)
    self.maskNoiseMaterial:setFloat("u_Contrast", self.mask_noise_contrast)
    self.maskNoiseMaterial:setVec2("u_Scale", Amaz.Vector2f(self.mask_noise_quantity, self.mask_noise_quantity));
    self.maskNoiseMaterial:setFloat("u_Complexity", self.mask_noise_complexity);
    self.maskNoiseMaterial:setFloat("u_Evolution", math.abs(self.mask_noise_evolution) / 90.0);
    self.maskNoiseMaterial:setFloat("u_Cycle", math.max(2, math.floor(self.mask_noise_cycle * 3.0 + 0.5)));
    self.maskNoiseMaterial:setVec2("u_Offset", Amaz.Vector2f(self.mask_noise_offset_x, self.mask_noise_offset_y))
    self.maskNoiseMaterial:setFloat("picture_scale", 1)

    local sizeFactor = math.max(1.0, math.pow(self.dustSize * 0.3 + 0.5, 2.0))
    local gridStep = 4.0 * sizeFactor
    local normalW = math.floor((self.OutputTex.width / math.min(self.OutputTex.width, self.OutputTex.height) * 720) /
                                   gridStep)
    local normalH = math.floor((self.OutputTex.height / math.min(self.OutputTex.width, self.OutputTex.height) * 720) /
                                   gridStep)
    local instanceCount = normalW * normalH * self.dustNum * self.dustNum

    local sCol1, sCol2, sCol3 = getRotationMatrix3x3(self.startRotX, self.startRotY, self.startRotZ)
    local eCol1, eCol2, eCol3 = getRotationMatrix3x3(self.endRotX, self.endRotY, self.endRotZ)

    local startRotX = math.rad(self.startRotX)
    local startRotY = math.rad(self.startRotY)
    local startRotZ = math.rad(self.startRotZ)
    local endRotX = math.rad(self.endRotX)
    local endRotY = math.rad(self.endRotY)
    local endRotZ = math.rad(self.endRotZ)
    local progress = self.progress / 100
    local aePluginInt = self.AEPlugin and 1 or 0

    local activeMaterial = nil
    local maskTypeInt = 0

    if (self.maskType == "Noise") then
        maskTypeInt = 0
        activeMaterial = self.dust_mat
        self.MeshEntity.visible = true
        self.MeshEntity2.visible = false
        self.MeshEntity3.visible = false
    elseif (self.maskType == "Line") then
        maskTypeInt = 1
        activeMaterial = self.dust_mat2
        self.MeshEntity.visible = false
        self.MeshEntity2.visible = true
        self.MeshEntity3.visible = false
    else
        maskTypeInt = 2
        activeMaterial = self.dust_mat3
        self.MeshEntity.visible = false
        self.MeshEntity2.visible = false
        self.MeshEntity3.visible = true
    end

    if activeMaterial then
        activeMaterial:setTex("inputTex", self.InputTex)
        activeMaterial:setFloat("normalW", normalW)
        activeMaterial:setFloat("normalH", normalH)
        activeMaterial.xshader.passes:get(0).instanceCount = instanceCount
        activeMaterial:setFloat("dustNum", self.dustNum)
        activeMaterial:setFloat("dustSize", self.dustSize)

        activeMaterial:setFloat("iTime", self.curTime)
        activeMaterial:setFloat("distorIns", self.distorIns)
        activeMaterial:setFloat("noiseFeather", self.maskFeather)

        activeMaterial:setVec3("u_StartRot_Row1", sCol1)
        activeMaterial:setVec3("u_StartRot_Row2", sCol2)
        activeMaterial:setVec3("u_StartRot_Row3", sCol3)
        activeMaterial:setVec3("u_EndRot_Row1", eCol1)
        activeMaterial:setVec3("u_EndRot_Row2", eCol2)
        activeMaterial:setVec3("u_EndRot_Row3", eCol3)

        activeMaterial:setInt("maskType", maskTypeInt)

        if maskTypeInt == 1 then
            -- Line mask type
            activeMaterial:setFloat("mask_line_rot", math.rad(self.mask_line_rot))
        elseif maskTypeInt == 2 then
            -- Image mask type
            activeMaterial:setTex("mask_image", self.mask_image)
        end

        activeMaterial:setFloat("startRotX", startRotX)
        activeMaterial:setFloat("startRotY", startRotY)
        activeMaterial:setFloat("startRotZ", startRotZ)
        activeMaterial:setFloat("startMoveX", self.startMoveX)
        activeMaterial:setFloat("startMoveY", self.startMoveY)
        activeMaterial:setFloat("startMoveZ", self.startMoveZ)
        activeMaterial:setFloat("startSize", self.startSize)

        activeMaterial:setFloat("endRotX", endRotX)
        activeMaterial:setFloat("endRotY", endRotY)
        activeMaterial:setFloat("endRotZ", endRotZ)
        activeMaterial:setFloat("endMoveX", self.endMoveX)
        activeMaterial:setFloat("endMoveY", self.endMoveY)
        activeMaterial:setFloat("endMoveZ", self.endMoveZ)
        activeMaterial:setFloat("endSize", self.endSize)
        activeMaterial:setTex("endImg", self.endImg)

        activeMaterial:setFloat("progress", progress)
        activeMaterial:setInt('AEPlugin', aePluginInt)
    end

end
function LumiDust:onEvent(sys, event)

end

exports.LumiDust = LumiDust
return exports
