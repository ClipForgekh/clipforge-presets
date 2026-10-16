local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiBlit = LumiBlit or {}
LumiBlit.__index = LumiBlit
---@class LumiBlit : ScriptComponent
---@field globalTransform number
---@field smoothness number [UI(Range={-1.0, 1.0}, Drag)]
---@field weight number [UI(Range={-1.0, 1.0}, Drag)]
---@field center vector2f
---@field scaleStart number 
---@field scaleEnd number 
---@field angleStart number
---@field angleEnd number
---@field falloff number 
---@field offsetStart vector2f
---@field offsetEnd vector2f
---@field colorStart vector3f
---@field colorMid vector3f
---@field colorEnd vector3f
---@field boolDeform bool
---@field size number
---@field twist number
---@field XSpeed number
---@field speed number [UI(Range={0, 10}, Slider)]
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
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    return rt
end

function LumiBlit.new(construct, ...)
    local self = setmetatable({}, LumiBlit)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"
    self.scaleStart = 100
    self.scaleEnd = 100
    self.angleStart = 0
    self.angleEnd = 0
    self.falloff = 100
    self.globalTransform = 150.
    self.center = Amaz.Vector2f(0.5,0.5)
    self.smoothness = 1
    self.weight = 1
    self.offsetStart = Amaz.Vector2f(0.5,0.5)
    self.offsetEnd = Amaz.Vector2f(0.5,0.5)
    self.colorStart = Amaz.Color(1,0,0,1)
    self.colorMid = Amaz.Color(0,1,0,1)
    self.colorEnd = Amaz.Color(0,0,1,1)
    self.boolDeform = false
    self.size = 0
    self.twist = 0
    self.speed = 0
    
    self.XSpeed = 0
    return self
end

function LumiBlit:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        if self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    _setEffectAttr(key, value)
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


function LumiBlit:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    -- Use entity instead of scene 
    self.camera = self.entity:searchEntity("BlitCamera"):getComponent("Camera")
    self.material = self.entity:searchEntity("BlitPass"):getComponent("MeshRenderer").material


    self.deform_mr = self.entity:searchEntity("BlitPass"):getComponent("MeshRenderer")
    self.deform_mat = self.deform_mr.material
    self.mesh = createQuadMesh(self.size)

    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.midTex = self.lumiSharedRt:get(0)
    end

    if self.boolDeform then     
        self.deform_mr.mesh = self.mesh
        Amaz.LOGI("u_Twist",self.size)
    end

end

function LumiBlit:onUpdate(comp, deltaTime)
    -- set the input and output textures to be displayed
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end
    local width = self.OutputTex.width
    local height = self.OutputTex.height

    local ratio = width/height
    local material = self.material
    if self.boolDeform then     
        self.deform_mat:setFloat("u_Twist", self.twist * 0.003*ratio)
        material =  self.deform_mat
        -- Amaz.LOGI("u_Twist",self.twist)
    end
    material:setFloat("u_Speed", self.speed)
    material:setFloat("u_XSpeed", self.XSpeed)
    -- Amaz.LOGI("u_Speed", self.speed)
    
    material:setTex("u_inputTexture", self.InputTex)
    material:setFloat("u_scaleStart", self.scaleEnd)
    material:setFloat("u_scaleEnd", self.scaleStart)


    material:setFloat("u_angleStart", self.angleStart * 3.14159/180)
    material:setFloat("u_angleEnd", self.angleEnd * 3.14159/180)
    material:setFloat("u_fallOff", self.falloff/100)
    material:setVec2("u_center", self.center)


    
    
    material:setFloat("u_weight", self.weight)
    material:setFloat("u_smoothness", self.smoothness)
    material:setFloat("u_globalTransform", self.globalTransform/100)
    -- Amaz.LOGI("self.event_intensity",self.globalTransform/1000)
    material:setVec2("u_offsetStart", self.offsetStart)
    material:setVec2("u_offsetEnd",self.offsetEnd)

    material:setVec3("u_colorEnd", Amaz.Vector3f(self.colorEnd.r, self.colorEnd.g, self.colorEnd.b))
    material:setVec3("u_colorMid",  Amaz.Vector3f(self.colorMid.r, self.colorMid.g, self.colorMid.b))
    material:setVec3("u_colorStart",  Amaz.Vector3f(self.colorStart.r, self.colorStart.g, self.colorStart.b))
    if self.midTex then
        if self.midTex.width ~= self.OutputTex.width or self.midTex.height ~= self.OutputTex.height then
            self.midTex.width = self.OutputTex.width
            self.midTex.height = self.OutputTex.height
        end
    end

    -- temporary texture's dimensions need to be based on self.InputTex or self.OutputTex's dimensions
    if self.myTex then
        local scale = 1.0 -- 需要缩放的尺寸 the necessary scale factor
        local realW = self.OutputTex.width * scale
        local realH = self.OutputTex.height * scale

        -- when temporary texture type is RenderTexture
        self.myTex.width = realW
        self.myTex.height = realH

        -- when temporary texture type is ScreenRenderTexture
        self.myTex.pecentX = realW / Amaz.BuiltinObject.getOutputTextureWidth()
        self.myTex.pecentY = realH / Amaz.BuiltinObject.getOutputTextureHeight()
    end
end

exports.LumiBlit = LumiBlit
return exports
