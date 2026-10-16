local exports = exports or {}
local MeshWarp = MeshWarp or {}

---@class MeshWarp : ScriptComponent
---@field mesh_size number
---@field meshMode number
---@field transpose Bool
---@field InputTex Texture
---@field OutputTex Texture
MeshWarp.__index = MeshWarp

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function MeshWarp.new()
    local self = {}
    setmetatable(self, MeshWarp)

    self.InputTex = nil
    self.OutputTex = nil

    self.transform = {}
    self.mesh_size = 32
    self.meshMode = 0
    self.transpose = false

    self.controlPointsDirty = true
    self.controlPoints = Amaz.Vec2Vector()
    self.controlPoints:pushBack(Amaz.Vector2f(0.0, 0.0))
    self.controlPoints:pushBack(Amaz.Vector2f(0.333, 0))
    self.controlPoints:pushBack(Amaz.Vector2f(0, 0.333))
    self.controlPoints:pushBack(Amaz.Vector2f(0, 1))
    self.controlPoints:pushBack(Amaz.Vector2f(0, 0.667))
    self.controlPoints:pushBack(Amaz.Vector2f(0.333, 1))
    self.controlPoints:pushBack(Amaz.Vector2f(1, 0))
    self.controlPoints:pushBack(Amaz.Vector2f(1, 0.333))
    self.controlPoints:pushBack(Amaz.Vector2f(0.667, 0))
    self.controlPoints:pushBack(Amaz.Vector2f(1, 1))
    self.controlPoints:pushBack(Amaz.Vector2f(1, 0.667))
    self.controlPoints:pushBack(Amaz.Vector2f(0.667, 1))
    for i = 12, 90 do
        self.controlPoints:pushBack(Amaz.Vector2f(0.0, 0.0))
    end

    self.controlPointsAligned = Amaz.Vec2Vector()
    self.controlPointsAligned:resize(110)
    return self
end

function MeshWarp:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        if self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if string.sub(key, 1, 5) == "point" then
        local subStr = string.sub(key, 6)
        local number = tonumber(subStr)
        self.controlPoints:set(number-1, value)
        self.controlPointsDirty = true
    else
        _setEffectAttr(key, value)
    end
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
---@param comp Component
function MeshWarp:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.camera = self.entity:searchEntity("Camera_Bezier_Deformation"):getComponent("Camera")
    self.meshrenderer = self.entity:searchEntity("Bezier_Deformation"):getComponent("MeshRenderer")
    self.meshrenderer.mesh = createQuadMesh(math.floor(self.mesh_size))
    self.material = self.meshrenderer.material
end

local function getMeshNumBytype(type, transpose)
    local x_n = 2
    local y_n = 2
    if type == 0 then
        x_n = 2;
        y_n = 2;
    elseif type == 1 then
        x_n = 2;
        y_n = 3;
    elseif type == 2 then
        x_n = 2;
        y_n = 4;
    elseif type == 3 then
        x_n = 2;
        y_n = 5;
    elseif type == 4 then
        x_n = 2;
        y_n = 6;
    elseif type == 5 then
        x_n = 2;
        y_n = 7;
    elseif type == 6 then
        x_n = 2;
        y_n = 8;
    elseif type == 7 then
        x_n = 2;
        y_n = 9;
    elseif type == 8 then
        x_n = 2;
        y_n = 10;
    elseif type == 9 then
        x_n = 2;
        y_n = 11;
    elseif type == 10 then
        x_n = 3;
        y_n = 3;
    elseif type == 11 then
        x_n = 3;
        y_n = 4;
    elseif type == 12 then
        x_n = 3;
        y_n = 5;
    elseif type == 13 then
        x_n = 3;
        y_n = 6;
    elseif type == 14 then
        x_n = 4;
        y_n = 4;
    elseif type == 15 then
        x_n = 4;
        y_n = 5;
    end

    if transpose then
        local tmp = x_n;
        x_n = y_n;
        y_n = tmp;
    end
    return x_n, y_n
end

function MeshWarp:updatecontrolPoints(x_n, y_n)
    local tmpIdx = 0
    local tmpIdxAligned = 0
    for x = 0, x_n-1 do
        for y = 0, y_n-1 do
            self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
            tmpIdxAligned = tmpIdxAligned + 1
            tmpIdx = tmpIdx + 1
            if y > 0 then
                self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
                tmpIdxAligned = tmpIdxAligned + 1
                tmpIdx = tmpIdx + 1
            else
                self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
                tmpIdxAligned = tmpIdxAligned + 1
            end
            if x < x_n-1 then
                self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
                tmpIdxAligned = tmpIdxAligned + 1
                tmpIdx = tmpIdx + 1
            else
                self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
                tmpIdxAligned = tmpIdxAligned + 1
            end
            if y < y_n-1 then
                self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
                tmpIdxAligned = tmpIdxAligned + 1
                tmpIdx = tmpIdx + 1
            else
                self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
                tmpIdxAligned = tmpIdxAligned + 1
            end
            if x > 0 then
                self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
                tmpIdxAligned = tmpIdxAligned + 1
                tmpIdx = tmpIdx + 1
            else
                self.controlPointsAligned:set(tmpIdxAligned, self.controlPoints:get(tmpIdx))
                tmpIdxAligned = tmpIdxAligned + 1
            end
        end
    end
end

---@param comp Component
---@param deltaTime number
function MeshWarp:onUpdate(comp, deltaTime)
    self.camera.renderTexture = self.OutputTex
    self.material:setTex("u_InputTex", self.InputTex)

    local x_n, y_n = getMeshNumBytype(self.meshMode, self.transpose)
    if self.controlPointsDirty then
        self:updatecontrolPoints(x_n, y_n)
        self.controlPointsDirty = false
    end

    self.material:setFloat("u_xCount", x_n)
    self.material:setFloat("u_yCount", y_n)
    
    self.material:setVec2Vector("u_controlPoints", self.controlPointsAligned)
end

exports.MeshWarp = MeshWarp
return exports
