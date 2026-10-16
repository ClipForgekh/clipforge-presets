local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiTwister = LumiTwister or {}
LumiTwister.__index = LumiTwister
---@class LumiTwister : ScriptComponent
---@field completion number [UI(Range={0, 1}, Drag=0.01)]
---@field lightIns number [UI(Range={0, 1}, Drag=0.01)]
---@field center Vector2f
---@field axis number [UI(Range={0, 360}, Drag=1)]
---@field meshSize number
---@field backTex Texture
---@field InputTex Texture
---@field OutputTex Texture
---@field tmpTex0 Texture
---@field tmpTex1 Texture
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
    rt.attachment = Amaz.RenderTextureAttachment.NONE
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

local function lerp(a, b, x)
    return a * (1 - x) + b * x
end

local function clamp(val, min, max)
    return math.min(math.max(val, min), max)
end

local function computeLocationFactor(center, angle)
    local rad = math.rad(angle)
    local weightX = math.cos(rad)
    local weightY = math.sin(rad)
    local numerator = center.x * weightX + center.y * weightY
    local denominator = math.abs(weightX) + math.abs(weightY)

    if denominator == 0 then
        return 0
    end
    local locationFactor = numerator / denominator

    if locationFactor > 1 then
        locationFactor = 1
    elseif locationFactor < -1 then
        locationFactor = -1
    end

    return locationFactor
end

local function createTransform(location, rotation, scale)
    local matrix = Amaz.Matrix4x4f()
    local rotate = Amaz.Matrix4x4f()
    matrix:setIdentity()

    local sx = scale and (scale.x or scale.s or 1) or 1
    local sy = scale and (scale.y or scale.s or 1) or 1
    local sz = scale and (scale.z or scale.s or 1) or 1
    matrix:scale(Amaz.Vector3f(sx, sy, sz))

    if rotation then
        if rotation.x then
            rotate:setTR(Amaz.Vector3f(0, 0, 0),
                Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(math.rad(rotation.x), 0, 0)))
            matrix = matrix * rotate
        end
        if rotation.y then
            rotate:setTR(Amaz.Vector3f(0, 0, 0),
                Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(0, -math.rad(rotation.y), 0)))
            matrix = matrix * rotate
        end
        if rotation.z then
            rotate:setTR(Amaz.Vector3f(0, 0, 0),
                Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(0, 0, -math.rad(rotation.z))))
            matrix = matrix * rotate
        end
    end

    matrix:translate(Amaz.Vector3f(location.x or 0, location.y or 0, location.z or 0))

    return matrix
end

local createQuadMesh = function(vertexNumber)
    local customMesh = Amaz.Mesh()
    local customSubMesh = Amaz.SubMesh()
    customSubMesh.primitive = Amaz.Primitive.TRIANGLES
    local pos = Amaz.VertexAttribDesc()
    pos.semantic = Amaz.VertexAttribType.POSITION
    local uv = Amaz.VertexAttribDesc()
    uv.semantic = Amaz.VertexAttribType.TEXCOORD0
    local vads = Amaz.Vector()
    vads:pushBack(pos)
    vads:pushBack(uv)
    customMesh.vertexAttribs = vads
    local vertexData = {}
    local indexData = {}
    for i = 0, vertexNumber - 1 do
        for j = 0, vertexNumber - 1 do
            local x = j / (vertexNumber - 1)
            local y = i / (vertexNumber - 1)
            table.insert(vertexData, #vertexData + 1, x * 2 - 1)
            table.insert(vertexData, #vertexData + 1, y * 2 - 1)
            table.insert(vertexData, #vertexData + 1, 0)
            table.insert(vertexData, #vertexData + 1, x)
            table.insert(vertexData, #vertexData + 1, y)
        end
    end

    for i = 0, vertexNumber - 2 do
        for j = 0, vertexNumber - 2 do
            local k = i * vertexNumber + j
            table.insert(indexData, #indexData + 1, k)
            table.insert(indexData, #indexData + 1, k + 1)
            table.insert(indexData, #indexData + 1, k + vertexNumber)
            table.insert(indexData, #indexData + 1, k + 1)
            table.insert(indexData, #indexData + 1, k + vertexNumber + 1)
            table.insert(indexData, #indexData + 1, k + vertexNumber)
        end
    end
    local fv = Amaz.FloatVector()
    for i = 1, table.getn(vertexData) do
        fv:pushBack(vertexData[i])
    end
    customMesh.vertices = fv
    local indices = Amaz.UInt16Vector()
    for i = 1, table.getn(indexData) do
        indices:pushBack(indexData[i])
    end

    customSubMesh.indices16 = indices
    customSubMesh.mesh = customMesh
    customMesh:addSubMesh(customSubMesh)
    return customMesh
end

function LumiTwister.new(construct, ...)
    local self = setmetatable({}, LumiTwister)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.completion = 0.0
    self.center = Amaz.Vector2f(0.5, 0.5)
    self.axis = 120.0
    self.lightIns = 0.0
    self.meshSize = 32

    self.backTex = nil
    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function LumiTwister:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    _setEffectAttr(key, value)
end

function LumiTwister:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.camera = self.entity:searchEntity("twisterCamera"):getComponent("Camera")
    self.material = self.entity:searchEntity("twisterPass"):getComponent("MeshRenderer").material
    self.meshrenderer = self.entity:searchEntity("twisterPass"):getComponent("MeshRenderer")
    self.meshrenderer.mesh = createQuadMesh(math.floor(self.meshSize))

    self.backsideCamera = self.entity:searchEntity("backsideCamera"):getComponent("Camera")
    self.backsideMaterial = self.entity:searchEntity("backsidePass"):getComponent("MeshRenderer").material
    self.backsideMeshrenderer = self.entity:searchEntity("backsidePass"):getComponent("MeshRenderer")
    self.backsideMeshrenderer.mesh = createQuadMesh(math.floor(self.meshSize))

    self.blendCamera = self.entity:searchEntity("blendCamera"):getComponent("Camera")
    self.blendMaterial = self.entity:searchEntity("blendPass"):getComponent("MeshRenderer").material

    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.midTex = self.lumiSharedRt:get(0)
    end

end

function LumiTwister:onUpdate(comp, deltaTime)
    self.material:setTex("u_inputTexture", self.InputTex)
    self.backsideMaterial:setTex("u_inputTexture", self.backTex)

    if self.completion > 0.5 then
        self.material:setTex("u_inputTexture", self.backTex)
        self.backsideMaterial:setTex("u_inputTexture", self.InputTex)
    end

    self.camera.renderTexture = self.tmpTex0
    self.backsideCamera.renderTexture = self.tmpTex1

    self.blendMaterial:setTex("u_inputTexture", self.tmpTex0)
    self.blendMaterial:setTex("u_inputTexture1", self.tmpTex1)

    if self.backTex == nil then
        self.backTex = self.InputTex
    end

    if self.OutputTex then
        self.blendCamera.renderTexture = self.OutputTex
    end

    if self.midTex then
        if self.midTex.width ~= self.OutputTex.width or self.midTex.height ~= self.OutputTex.height then
            self.midTex.width = self.OutputTex.width
            self.midTex.height = self.OutputTex.height
        end
    end

    local maxFactor = 180.0
    local completion = self.completion * maxFactor;
    local angle = self.axis
    local center = Amaz.Vector2f((clamp(self.center.x, 0.0, 1.0) - 0.5) * 2.0,
        (clamp((1.0 - self.center.y), 0.0, 1.0) - 0.5) * 2.0)
    local locationFactor = computeLocationFactor(center, angle)

    if self.completion > 0.5 then
        angle = angle + 180.0
        completion = maxFactor - completion
        locationFactor = -locationFactor
    end

    if angle >= 360.0 then
        angle = angle - 360.0
    end

    if angle < 0.0 then
        angle = angle + 360.0
    end

    local location = {
        x = math.max(math.min(locationFactor, 1.0), -1.0),
        y = 1.0,
        z = 0.0
    }
    local rotation = {
        x = 0.0,
        y = 0.0,
        z = angle
    }
    local scale = {
        x = 1.0,
        y = 1.0,
        z = 1.0
    }
    local targetMatrix = createTransform(location, rotation, scale)

    self.material:setMat4("u_targetMatrix", targetMatrix)
    self.material:setFloat("u_completion", completion)
    self.material:setFloat("u_angle", self.axis)
    self.material:setVec2("u_center", self.center)
    self.material:setInt("u_twistType", 0)

    self.backsideMaterial:setMat4("u_targetMatrix", targetMatrix)
    self.backsideMaterial:setFloat("u_completion", completion)
    self.backsideMaterial:setFloat("u_angle", self.axis)
    self.backsideMaterial:setVec2("u_center", self.center)
    self.backsideMaterial:setInt("u_twistType", 1)

    self.blendMaterial:setFloat("u_completion", self.completion)

    self.material:setFloat("u_shadingProgress", self.completion)
    self.backsideMaterial:setFloat("u_shadingProgress", self.completion)
    self.material:setFloat("u_lightIns", self.lightIns)
    self.backsideMaterial:setFloat("u_lightIns", self.lightIns)
end

exports.LumiTwister = LumiTwister
return exports
