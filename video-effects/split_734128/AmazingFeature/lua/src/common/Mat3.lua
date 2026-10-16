
---@class Mat3
local Mat3 = {}
Mat3.__index = Mat3
Mat3.__call = function (m)
    return Amaz.Matrix3x3f(m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8], m[9])
end
Mat3.__mul = function (a, b)
    if type(b) == "table" then
        return a:mulMatrix(b)
    elseif b.z == 0 then
        return a:mulVector(b)
    else
        return a:mulPoint(b)
    end
end
function Mat3.identity ()
    return setmetatable({1, 0, 0, 0, 1, 0, 0, 0, 1}, Mat3)
end
function Mat3.rotate (angle)
    local s = math.sin(angle)
    local c = math.cos(angle)
    return setmetatable({c, s, 0, -s, c, 0, 0, 0, 1}, Mat3)
end
function Mat3.translate (x, y)
    return setmetatable({1, 0, 0, 0, 1, 0, x, y, 1}, Mat3)
end
function Mat3.scale (x, y)
    y = y or x
    return setmetatable({x, 0, 0, 0, y, 0, 0, 0, 1}, Mat3)
end
function Mat3.skewX (r)
    local t = math.tan(r)
    return setmetatable({1, t, 0, 0, 1, 0, 0, 0, 1}, Mat3)
end
function Mat3.skewY (r)
    local t = math.tan(r)
    return setmetatable({1, 0, 0, t, 1, 0, 0, 0, 1}, Mat3)
end
function Mat3:determinant ()
    return self[1] * (self[5] * self[9] - self[6] * self[8])
         + self[2] * (self[6] * self[7] - self[4] * self[9])
         + self[3] * (self[4] * self[8] - self[5] * self[7])
end
function Mat3:inverse ()
    local a1 = self[5] * self[9] - self[6] * self[8]
    local a2 = self[3] * self[8] - self[2] * self[9]
    local a3 = self[2] * self[6] - self[3] * self[5]
    local a4 = self[6] * self[7] - self[4] * self[9]
    local a5 = self[1] * self[9] - self[3] * self[7]
    local a6 = self[3] * self[4] - self[1] * self[6]
    local a7 = self[4] * self[8] - self[5] * self[7]
    local a8 = self[2] * self[7] - self[1] * self[8]
    local a9 = self[1] * self[5] - self[2] * self[4]
    local det = self[1] * a1 + self[2] * a4 + self[3] * a7
    if math.abs(det) < 0.000001 then
        return nil
    end
    det = 1.0 / det
    return setmetatable({
        a1 * det,
        a2 * det,
        a3 * det,
        a4 * det,
        a5 * det,
        a6 * det,
        a7 * det,
        a8 * det,
        a9 * det,
    }, Mat3)

end
function Mat3:mulMatrix (b)
    local a1, a2, a3 = self[1], self[2], self[3]
    local a4, a5, a6 = self[4], self[5], self[6]
    local a7, a8, a9 = self[7], self[8], self[9]
    self[1] = a1*b[1] + a4*b[2] + a7*b[3]
    self[2] = a2*b[1] + a5*b[2] + a8*b[3]
    self[3] = a3*b[1] + a6*b[2] + a9*b[3]
    self[4] = a1*b[4] + a4*b[5] + a7*b[6]
    self[5] = a2*b[4] + a5*b[5] + a8*b[6]
    self[6] = a3*b[4] + a6*b[5] + a9*b[6]
    self[7] = a1*b[7] + a4*b[8] + a7*b[9]
    self[8] = a2*b[7] + a5*b[8] + a8*b[9]
    self[9] = a3*b[7] + a6*b[8] + a9*b[9]
    return self
end
function Mat3:mulVector (v)
    local x = self[1]*v.x + self[4]*v.y
    local y = self[2]*v.x + self[5]*v.y
    return Amaz.Vector2f(x, y)
end
function Mat3:mulPoint (p)
    local x = self[1]*p.x + self[4]*p.y + self[7]
    local y = self[2]*p.x + self[5]*p.y + self[8]
    return Amaz.Vector2f(x, y)
end
function Mat3:mulScalar (s)
    return setmetatable({self[1]*s, self[2]*s, self[3]*s, self[4]*s, self[5]*s, self[6]*s, self[7]*s, self[8]*s, self[9]*s}, Mat3)
end
function Mat3:toMaterial (material, varName)
    local arr = Amaz.Vec3Vector()
    arr:pushBack(Amaz.Vector3f(self[1], self[2], self[3]))
    arr:pushBack(Amaz.Vector3f(self[4], self[5], self[6]))
    arr:pushBack(Amaz.Vector3f(self[7], self[8], self[9]))
    material:setVec3Vector(varName, arr)
    return self
end
function Mat3.toMaterialVector (material, varName, matrices)
    local arr = Amaz.Vec3Vector()
    for _, mat in ipairs(matrices) do
        arr:pushBack(Amaz.Vector3f(mat[1], mat[2], mat[3]))
        arr:pushBack(Amaz.Vector3f(mat[4], mat[5], mat[6]))
        arr:pushBack(Amaz.Vector3f(mat[7], mat[8], mat[9]))
    end
    material:setVec3Vector(varName, arr)
end


---@param screenSize Vector2f|nil
---@param layers table[]
---@return Mat3
function Mat3.makeTransform (screenSize, layers)
    local matrix
    if screenSize then
        local last = layers[#layers]
        matrix = Mat3.scale(1/last.w, 1/last.h)
    else
        matrix = Mat3.identity()
    end
    for i = #layers, 1, -1 do
        local layer = layers[i]
        if layer.ax or layer.ay then
            matrix:mulMatrix(Mat3.translate(layer.ax and layer.ax * layer.w or 0, layer.ay and layer.ay * layer.h or 0))
        end
        if layer.ky then
            matrix:mulMatrix(Mat3.skewY(math.rad(-layer.ky)))
        end
        if layer.kx then
            matrix:mulMatrix(Mat3.skewX(math.rad(-layer.kx)))
        end
        if layer.r then
            matrix:mulMatrix(Mat3.rotate(math.rad(-layer.r)))
        end
        if layer.s then
            matrix:mulMatrix(Mat3.scale(1/layer.s, 1/layer.s))
        elseif layer.sx or layer.sy then
            matrix:mulMatrix(Mat3.scale(layer.sx and 1/layer.sx or 1, layer.sy and 1/layer.sy or 1))
        end
        if layer.x or layer.y then
            matrix:mulMatrix(Mat3.translate(layer.x and -layer.x or 0, layer.y and -layer.y or 0))
        end
    end
    if screenSize then
        matrix:mulMatrix(Mat3.scale(screenSize.x, screenSize.y))
    end
    return matrix
end


return Mat3