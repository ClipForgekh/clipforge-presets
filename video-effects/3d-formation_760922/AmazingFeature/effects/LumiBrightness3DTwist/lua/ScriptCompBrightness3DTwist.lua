local exports = exports or {}

---@class ScriptCompBrightness3DTwist: ScriptComponent
---@field twistAngle number [UI(Range={-360., 360.}, Drag)]
---@field twistAxis string [UI(Option={"X", "Y", "Z", "XY", "XZ", "YZ", "XYZ"})]
---@field ioLayout string [UI(Option={"cover", "contains", "fitX", "fitY", "fill"})]
---@field rotationX number [UI(Range={-180., 180.}, Drag)]
---@field rotationY number [UI(Range={-180., 180.}, Drag)]
---@field rotationZ number [UI(Range={-180., 180.}, Drag)]
---@field focalLength number [UI(Range={-50., -1.}, Drag)]
---@field grid boolean
---@field invertGrid boolean
---@field gridHorizontalNumber int [UI(Range={0, 6}, Drag)]
---@field gridVerticalNumber int [UI(Range={0, 6}, Drag)]
---@field gridHorizontalSize number [UI(Range={0, 1}, Drag)]
---@field gridVerticalSize number [UI(Range={0, 1}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture
local ScriptCompBrightness3DTwist = ScriptCompBrightness3DTwist or {}
ScriptCompBrightness3DTwist.__index = ScriptCompBrightness3DTwist


function ScriptCompBrightness3DTwist.new(construct, ...)
    local self = setmetatable({}, ScriptCompBrightness3DTwist)

    if construct and ScriptCompBrightness3DTwist.constructor then ScriptCompBrightness3DTwist.constructor(self, ...) end
    self.AXIS_QUERY = {[0] = "X", "Y", "Z", "XY", "XZ", "YZ", "XYZ", ["X"] = 0, ["Y"] = 1, ["Z"] = 2, ["XY"] = 3, ["XZ"] = 4, ["YZ"] = 5, ["XYZ"] = 6}
    self.LAYOUT_QUERY = {[0] = "cover", "contains", "fitX", "fitY", "fill"}
    self.AE_TAN_FOV_X = math.tan(math.rad(39.6 / 2))
    -- user parameters
    self.twistAngle = 0.1
    self.twistAxis = "X"
    self.ioLayout = "cover"
    self.rotationX = 0
    self.rotationY = 0
    self.rotationZ = 0
    self.focalLength = -10
    self.lastGridVerticalNumber = 0
    self.meshMap = {}
    self.InputTex = nil
    self.OutputTex = nil
    return self
end

function ScriptCompBrightness3DTwist:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end
    if key == "twistAxis" then
        value = math.max(0, math.min(value, #self.AXIS_QUERY))
        value = self.AXIS_QUERY[value]
    elseif key == "ioLayout" then
        value = math.max(0, math.min(value, #self.LAYOUT_QUERY))
        value = self.LAYOUT_QUERY[value]
    end
    _setEffectAttr(key, value, comp)
end

function ScriptCompBrightness3DTwist:onStart(comp)
    local root = comp.entity
    self.camera = root:searchEntity("Brightness3DTwistCamera"):getComponent("Camera")
    self.transform = root:searchEntity("Brightness3DTwistRenderer"):getComponent("Transform")
    self.renderer = root:searchEntity("Brightness3DTwistRenderer"):getComponent("MeshRenderer")
    self.material = self.renderer.material
    self.pass = self.material.xshader.passes:get(0)
end

function ScriptCompBrightness3DTwist:onUpdate(comp, deltaTime)
    if self.grid then
        local gridHorizontalNumber = math.max(1, math.floor(self.gridHorizontalNumber) * 10)
        self.pass.instanceCount = gridHorizontalNumber
        self.material:setFloat("u_instanceNumber", gridHorizontalNumber)
        local gridVerticalNumber = math.max(1, math.floor(self.gridVerticalNumber) * 10)
        if gridVerticalNumber ~= self.lastGridVerticalNumber then
            self.lastGridVerticalNumber = gridVerticalNumber
            if self.meshMap[gridVerticalNumber] == nil then
                self.meshMap[gridVerticalNumber] = self:createCustomMesh(gridVerticalNumber)
            end
            self.renderer.mesh = self.meshMap[gridVerticalNumber]
        end
        self.material:setFloat("u_gridVerticalNumber", gridVerticalNumber)
        self.material:setFloat("u_gridHorizontalSize", self.gridHorizontalSize)
        self.material:setFloat("u_gridVerticalSize", self.gridVerticalSize)
    elseif not self.grid then
        self.pass.instanceCount = 500
        if self.meshMap[500] == nil then
            self.meshMap[500] = self:createCustomMesh(500)
        end
        self.renderer.mesh = self.meshMap[500]
        self.material:setFloat("u_instanceNumber", 500)
        self.material:setFloat("u_gridVerticalNumber", 500)
        self.material:setFloat("u_gridHorizontalSize", 1)
        self.material:setFloat("u_gridVerticalSize", 1)
    end
    local angleMax = math.max(math.abs(self.rotationZ), math.max(math.abs(self.rotationX), math.abs(self.rotationY)))
    self.material:setFloat("u_AAFlag", angleMax > 0 and 1 or 0)
    self.material:setFloat("u_gridFlag", self.grid and 1 or 0)
    self.material:setFloat("u_invertGridFlag", self.invertGrid and 1 or 0)
    self.renderer.material:setTex("u_inputTexture", self.InputTex)
    self.camera.renderTexture = self.OutputTex

    self.renderer.material:setFloat("u_twistAngle", self.twistAngle)
    self.renderer.material:setInt("u_twistAxis", self.AXIS_QUERY[self.twistAxis])

    self.transform.localPosition = Amaz.Vector3f(0, 0, self.focalLength)
    self.transform.localOrientation = self:solveRotation()

    local w = Amaz.BuiltinObject:getOutputTextureWidth()
    local h = Amaz.BuiltinObject:getOutputTextureHeight()
    local d_aspect = h / w
    local s_aspect = h / w
    if self.OutputTex and self.OutputTex.width and self.OutputTex.width > 0 and self.OutputTex.height and self.OutputTex.height > 0 then
        d_aspect = self.OutputTex.height / self.OutputTex.width
    end

    -- // comment out because it cannot get InputTex's size correctly
    -- // when first use after first installation
    -- if self.InputTex then
    --     s_aspect = self.InputTex.height / self.InputTex.width
    -- end

    local y_tan = d_aspect * self.AE_TAN_FOV_X
    self.camera.fovy = 2 * math.deg(math.atan(y_tan))
    self.transform.localScale = self:solveScaleByLayout(d_aspect, s_aspect, y_tan)
end

function ScriptCompBrightness3DTwist:solveRotation ()
    -- ae xyz, editor yxz
    local up = Amaz.Vector3f(0.0, 1.0, 0.0)
    local left = Amaz.Vector3f(1.0, 0.0, 0.0)
    local forward = Amaz.Vector3f(0.0, 0.0, 1.0)

    local y_angle = math.rad(self.rotationY)
    local x_angle = math.rad(self.rotationX)
    local z_angle = math.rad(self.rotationZ)

    if self.twistAxis == "Z" then
        y_angle = 0
        x_angle = 0
    end

    local qx = Amaz.Quaternionf.axisAngleToQuaternion(left, x_angle)
    local qy = Amaz.Quaternionf.axisAngleToQuaternion(up, y_angle)
    local qz = Amaz.Quaternionf.axisAngleToQuaternion(forward, z_angle)
    return qx * qy * qz
end

function ScriptCompBrightness3DTwist:solveScaleByLayout (d_aspect, s_aspect, y_tan)
    local type = self.ioLayout
    local focalLength = -self.focalLength
    local dh = focalLength * y_tan
    local dw = dh / d_aspect
    local sw, sh
    if type == "cover" then
        sw = math.max(dw, dh / s_aspect)
        sh = math.max(dw * s_aspect, dh)
    elseif type == "contains" then
        sw = math.min(dw, dh / s_aspect)
        sh = math.min(dw * s_aspect, dh)
    elseif type == "fitX" then
        sw = dw
        sh = dw * s_aspect
    elseif type == "fitY" then
        sh = dh
        sw = dh / s_aspect
    else
        sw = dw
        sh = dh
    end
    return Amaz.Vector3f(sw, sh, 1)
end

function ScriptCompBrightness3DTwist:createCustomMesh(n)
    local customMesh = Amaz.Mesh()
    local customSubMesh = Amaz.SubMesh()
    customSubMesh.primitive = Amaz.Primitive.TRIANGLES
    if customMesh and customSubMesh then
    end
    local pos = Amaz.VertexAttribDesc()
    pos.semantic = Amaz.VertexAttribType.POSITION
    local uv = Amaz.VertexAttribDesc()
    uv.semantic = Amaz.VertexAttribType.TEXCOORD0
    local vads = Amaz.Vector()
    vads:pushBack(pos)
    vads:pushBack(uv)
    customMesh.vertexAttribs = vads
    local fv = Amaz.FloatVector()
    local indices = Amaz.UInt16Vector()
    local px = 0
    local py = 0
    local scale = 1
    local width = 1
    local totalHeight = 1
    local height = (2 * totalHeight) / (n)

    for i = 0, n - 1 do
        if i == 0 then
            for vertexIndex = 0, 1 do
                fv:pushBack(px)
                fv:pushBack(py)
                fv:pushBack(scale)
                local uvx = 0
                local uvy = 0
                if vertexIndex == 0 then
                    uvx = -width
                    uvy = totalHeight - i * height
                elseif vertexIndex == 1 then
                    uvx = width
                    uvy = totalHeight - i * height
                -- elseif vertexIndex == 2 then
                --     uvx = -width
                --     uvy = totalHeight - i * height - height
                -- else
                --     uvx = width
                --     uvy = totalHeight - i * height - height
                end
                fv:pushBack(uvx)
                fv:pushBack(uvy)
            end
        end
        for vertexIndex = 2, 3 do
            fv:pushBack(px)
            fv:pushBack(py)
            fv:pushBack(scale)
            local uvx = 0
            local uvy = 0
            if vertexIndex == 2 then
                uvx = -width
                uvy = totalHeight - i * height - height
            else
                uvx = width
                uvy = totalHeight - i * height - height
            end
            fv:pushBack(uvx)
            fv:pushBack(uvy)
        end
        local index = i * 2
        indices:pushBack(0 + index)
        indices:pushBack(1 + index)
        indices:pushBack(2 + index)
        indices:pushBack(1 + index)
        indices:pushBack(3 + index)
        indices:pushBack(2 + index)
    end
    customMesh.vertices = fv
    customSubMesh.indices16 = indices
    customSubMesh.mesh = customMesh
    customMesh:addSubMesh(customSubMesh)
    return customMesh
end

exports.ScriptCompBrightness3DTwist = ScriptCompBrightness3DTwist
return exports
