




---------- common/Utils.lua ----------
local Utils = {}



-- System
---@param fmt string
---@vararg any
function Utils.log (fmt, ...)
    ---#ifdef DEV
--//    local args = { ... }
--//    for i, v in ipairs(args) do
--//        local type = type(v)
--//        if type == "table" then
--//            args[i] = cjson.encode(v)
--//        elseif type == "number" then
--//            args[i] = v
--//        else
--//            args[i] = tostring(v)
--//        end
--//    end
--//    if Editor then
--//        Amaz.LOGW("MoreFive", string.format(fmt, unpack(args)))
--//    elseif EffectSdk then
--//        EffectSdk.LOG_LEVEL(8, string.format(fmt, unpack(args)))
--//    end
    ---#endif
end



-- Container
---@param src table
---@return table
function Utils.table_clone (src)
    if not src then
        return src
    end
    local dst = {}
    for k, v in pairs(src) do
        dst[k] = type(v) == "table" and Utils.table_clone(v) or v
    end
    return dst
end
---@param src any[]
---@param si number|nil
---@param ei number|nil
---@return any[]
function Utils.table_slice (src, si, ei)
    si = si or 1
    ei = ei or #src
    local dst = {}
    for i = si, ei do
        table.insert(dst, src[i])
    end
    return dst
end
---@vararg any[]
---@return any[]
function Utils.array_concat(...)
    local dst = {}
    for _, src in ipairs({...}) do
        for _, ele in ipairs(src) do
            table.insert(dst, ele)
        end
    end
    return dst
end
---@param src any[]
---@return any[]
function Utils.array_shuffle (src)
    local dst = {}
    if type(src) == "number" then
        for i = 1, src do
            dst[i] = i
        end
    else
        for i, v in ipairs(src) do
            dst[i] = v
        end
    end
    for n = #dst, 1, -1 do
        local i = math.floor(math.random(n))
        local v = dst[i]
        dst[i] = dst[n]
        dst[n] = v
    end
    return dst
end



-- Math
function Utils.round (value)
    return math.floor(value + 0.5)
end
function Utils.clamp (value, min, max)
    return math.min(math.max(min, value), max)
end
function Utils.mix (x, y, a)
    return x + (y - x) * a
end
function Utils.step (edge0, edge1, value)
    return math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
end
function Utils.step0 (edge0, edge1, value)
    return (value - edge0) / (edge1 - edge0)
end
function Utils.linearstep (edge0, edge1, value)
    return math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
end
function Utils.smoothstep (edge0, edge1, value)
    local t = math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
    return t * t * (3 - t - t)
end
function Utils.mirror (range, value)
    local round = value / range
    local roundF = 1 - math.abs(round % 2 - 1)
    local roundI = math.floor(round)
    return roundF, roundI
end
function Utils.bezier4 (q, x1, x2, x3, x4, y1, y2, y3, y4, z1, z2, z3, z4)
    local p = 1 - q
    local p2 = p * p
    local p3 = p2 * p
    local q2 = q * q
    local q3 = q2 * q
    local x = x1*p3 + 3*x2*p2*q + 3*x3*p*q2 + x4*q3
    local y = y4 and y1*p3 + 3*y2*p2*q + 3*y3*p*q2 + y4*q3 or 0
    local z = z4 and z1*p3 + 3*z2*p2*q + 3*z3*p*q2 + z4*q3 or 0
    return x, y, z
end
function Utils.bezier4x2y (x1, x2, x3, x4, y1, y2, y3, y4, x)
    local t_ = 0
    local _t = 1
    local bezier4 = Utils.bezier4
    repeat
        local _t_ = (t_ + _t) * 0.5
        local _x_ = bezier4(_t_, x1, x2, x3, x4)
        if _x_ > x then
            _t = _t_
        else
            t_ = _t_
        end
    until _t - t_ < 0.0078125

    local t = (t_ + _t) * 0.5
    return bezier4(t, y1, y2, y3, y4)
end



-- Easing
function Utils.sineIn (t)
    return 1 - math.cos(math.pi * t * .5)
end
function Utils.sineOut (t)
    return math.sin(math.pi * t * .5)
end
function Utils.sineInOut (t)
    return -(math.cos(math.pi * t) - 1) * .5
end
function Utils.quadIn (t)
    return t * t
end
function Utils.quadOut (t)
    return (2 - t) * t
end
function Utils.quadInOut (t)
    return t < .5 and 2 * t * t or t * (4 - t - t) - 1
end
function Utils.cubicIn (t)
    return t * t * t
end
function Utils.cubicOut (t)
    t = 1 - t
    return 1 - t * t * t
end
function Utils.cubicInOut (t)
    if t < .5 then
        return 4 * t * t * t
    else
        t = 2 - t - t
        return 1 - t * t * t * .5
    end
end
function Utils.quartIn (t)
    t = t * t
    return t * t
end
function Utils.quartOut (t)
    t = 1 - t
    t = t * t
    return 1 - t * t
end
function Utils.quartInOut (t)
    if t < .5 then
        t = t * t
        return 8 * t * t
    else
        t = 2 - t - t
        t = t * t
        return 1 - t * t * .5
    end
end
function Utils.expoIn (t)
    return t ~= 0 and math.pow(2, 10 - t - 10) or 0
end
function Utils.expoOut (t)
    return t ~= 1 and 1 - math.pow(2, -10 * t) or 1
end
function Utils.expoInOut (t)
    if t == 0 then
        return 0
    elseif t == 1 then
        return 1
    elseif t < .5 then
        return math.pow(2, 20 * t - 10) * .5
    else
        return 1 - math.pow(2, -20 * t + 10) * .5
    end
end
function Utils.circIn (t) return 1 - math.sqrt(1 - t * t) end
function Utils.circOut (t)
    t = t - 1
    return math.sqrt(1 - t * t)
end
function Utils.circInOut (t)
    if t < .5 then
        return .5 - math.sqrt(1 - 4 * t * t) * .5
    else
        t = 2 - t - t
        return .5 + math.sqrt(1 - t * t) * 0.5
    end
end
function Utils.backIn (t)
    local tt = t * t
    return 2.70158 * tt * t - 1.70158 * tt
end
function Utils.backOut (t)
    t = t - 1
    local tt = t * t
    return 1 + 2.70158 * tt * t + 1.70158 * tt
end
function Utils.backInOut (t)
    if t < .5 then
        t = t + t
        return (t * t * (3.5949095 * t - 2.5949095)) * .5
    else
        t = t + t - 2
        return (t * t * (3.5949095 * t + 2.5949095) + 2) * .5
    end
end
function Utils.elasticIn (t)
    if t == 0 then
        return 0
    elseif t == 1 then
        return 1
    else
        return -math.pow(2, 10 * t - 10) * math.sin((t * 10 - 10.75) * math.pi * 2 / 3)
    end
end
function Utils.elasticOut (t)
    if t == 0 then
        return 0
    elseif t == 1 then
        return 1
    else
        return math.pow(2, -10 * t) * math.sin((t * 10 - .75) * math.pi * 2 / 3) + 1
    end
end
function Utils.elasticInOut (t)
    if t == 0 then
        return 0
    elseif t == 1 then
        return 1
    elseif t < 0.5 then
        return -(math.pow(2, 20 * t - 10) * math.sin((t * 20 - 11.125) * math.pi * 2 / 4.5)) * .5
    else
        return (math.pow(2, -20 * t + 10) * math.sin((t * 20 - 11.125) * math.pi * 2 / 4.5)) * .5 + 1
    end
end
function Utils.bounceIn (t)
    return 1 - Utils.bounceOut(1 - t)
end
function Utils.bounceOut (t)
    local n1 = 7.5625;
    local d1 = 2.75;
    if t < 1 / d1 then
        return n1 * t * t;
    elseif t < 2 / d1 then
        t = t - 1.5 / d1
        return n1 * t * t + .75;
    elseif t < 2.5 / d1 then
        t = t - 2.25 / d1
        return n1 * t * t + .9375;
    else
        t = t - 2.625 / d1
        return n1 * t * t + .984375;
    end
end
function Utils.bounceInOut (t)
    if t < .5 then
        return (1 - Utils.bounceOut(1 - t + t)) * .5
    else
        return (1 + Utils.bounceOut(t + t - 1)) * .5
    end
end



-- Vector Math
---@param screenSize Vector2f|nil
---@param layers table[]
---@return Matrix4x4f
function Utils.uvTransform (screenSize, layers)
    local matrix = Amaz.Matrix4x4f()
    local rotate = Amaz.Matrix4x4f()
    if screenSize then
        local last = layers[#layers]
        matrix:setScale(Amaz.Vector3f(1/last.w, 1/last.h, 1))
    else
        matrix:setIdentity()
    end
    for i = #layers, 1, -1 do
        local layer = layers[i]
        if layer.ax or layer.ay then
            local dx = layer.ax and layer.ax * layer.w or 0
            local dy = layer.ay and layer.ay * layer.h or 0
            matrix:translate(Amaz.Vector3f(dx, dy, 0))
        end
        if layer.r then
            rotate:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(0, 0, -math.rad(layer.r))))
            matrix = matrix * rotate
        end
        if layer.s then
            matrix:scale(Amaz.Vector3f(1/layer.s, 1/layer.s, 1))
        elseif layer.sx or layer.sy then
            local sx = layer.sx and 1/layer.sx or 1
            local sy = layer.sy and 1/layer.sy or 1
            matrix:scale(Amaz.Vector3f(sx, sy, 1))
        end
        if layer.x or layer.y then
            local x = layer.x and -layer.x or 0
            local y = layer.y and -layer.y or 0
            matrix:translate(Amaz.Vector3f(x, y, 0))
        end
    end
    if screenSize then
        matrix:scale(Amaz.Vector3f(screenSize.x, screenSize.y, 1))
    end
    return matrix
end
---@param
function Utils.aeTransform (layers)
    local matrix = Amaz.Matrix4x4f()
    local rotate = Amaz.Matrix4x4f()
    matrix:setIdentity()
    for i = 1, #layers do
        local layer = layers[i]
        local dx = layer.x and layer.x or 0
        local dy = layer.y and layer.y or 0
        local dz = layer.z and layer.z or 0
        matrix:translate(Amaz.Vector3f(dx, dy, dz))
        if layer.rx then
            rotate:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(math.rad(layer.rx), 0, 0)))
            matrix = matrix * rotate
        end
        if layer.ry then
            rotate:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(0, -math.rad(layer.ry), 0)))
            matrix = matrix * rotate
        end
        if layer.rz then
            rotate:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(0, 0, -math.rad(layer.rz))))
            matrix = matrix * rotate
        end
        local sx = layer.sx or layer.s or 1
        local sy = layer.sy or layer.s or 1
        local sz = layer.sz or layer.s or 1
        matrix:scale(Amaz.Vector3f(sx, sy, sz))
    end
    return matrix
end



-- Convert
---@param arr number[]
---@param si number
---@param ei number
---@return number|Vector2f|Vector3f|Vector4f
function Utils.arr2vec (arr, si, ei)
    si = si or 1
    ei = ei or #arr
    if si == ei then
        return arr[si]
    end
    local n = ei - si + 1
    if n == 3 then
        return Amaz.Vector3f(arr[si], arr[si + 1], arr[si + 2])
    elseif n == 2 then
        return Amaz.Vector2f(arr[si], arr[si + 1])
    elseif n == 4 then
        return Amaz.Vector4f(arr[si], arr[si + 1], arr[si + 2], arr[si + 3])
    end
end
function Utils.rgb2hsl (R, G, B)
    B = B or R.z
    G = G or R.y
    R = B and R or R.x
    local H, S, L;
    local max = math.max(R, G, B);
    local min = math.min(R, G, B);
    local delta = max - min

    L = (max + min) * 0.5
    S = delta == 0 and 0 or 1 - math.abs(L + L - 1)

    if delta == 0 then
        H = 0
    elseif max == R then
        H = (G - B) / delta % 6
    elseif max == G then
        H = (B - R) / delta + 2
    else
        H = (R - G) / delta + 4
    end
    H = H / 6

    if B then
        return H, S, L
    else
        return Amaz.Vector3f(H, S, L)
    end
end
function Utils.hsl2rgb (H, S, L)
    L = L or H.z
    S = S or H.y
    H = L and H or H.x
    H = H * 360
    local R, G, B
    local C = (1 - math.abs(L + L - 1)) * S
    local X = C * (1 - math.abs((H / 60) % 2 - 1))
    local m = L - C * 0.5

    if H < 60 then
        R, G, B = C, X, 0
    elseif H < 120 then
        R, G, B = X, C, 0
    elseif H < 180 then
        R, G, B = 0, C, X
    elseif H < 240 then
        R, G, B = 0, X, C
    elseif H < 300 then
        R, G, B = X, 0, C
    else
        R, G, B = C, 0, X
    end

    R = R + m
    G = G + m
    B = B + m

    if L then
        return R, G, B
    else
        return Amaz.Vector3f(R, G, B)
    end
end
function Utils.hueShift (R, G, B, shift)
    local H, S, L = Utils.rgb2hsl(R, G, B)
    H = H + shift
    R, G, B = Utils.hsl2rgb(H, S, L)
    return Amaz.Vector3f(R, G, B)
end



---@param range number
---@param step number
---@return number, number
function Utils.solveSamples (range, step)
    local samples = math.ceil(range / step)
    step = range / (samples + 0.1)
    return samples, step
end



-- String
function Utils.startswith (str, prefix)
    local n0 = string.len(str)
    local n1 = string.len(prefix)
    return n0 >= n1 and string.sub(str, 1, n1) == prefix
end
function Utils.endswith (str, suffix)
    local n0 = string.len(str)
    local n1 = string.len(suffix)
    return n0 > n1 and string.sub(str, n0 - n1 + 1, n0) == suffix
end
function Utils.trim (str, mode)
    local si = 1
    local ei = #str
    mode = mode or 0
    if mode >= 0 then
        while si <= ei and string.byte(str, si) <= 32 do
            si = si + 1
        end
    end
    if mode <= 0 then
        while ei > si and string.byte(str, ei) <= 32 do
            ei = ei - 1
        end
    end
    if si ~= 1 or ei ~= #str then
        return string.sub(str, si, ei)
    else
        return str
    end
end



-- UTF-8
---@param lead number
---@return number
function Utils.ucs4_size (lead)
    if lead < 128 then
        return 1
    elseif lead < 192 then
        return 0
    elseif lead < 224 then
        return 2
    elseif lead < 240 then
        return 3
    elseif lead < 248 then
        return 4
    elseif lead < 252 then
        return 5
    else
        return 6
    end
end
---@param str string
---@return number
function Utils.utf8_len (str)
    local n = #str
    local i = 1
    local l = 0
    while i <= n do
        local bytes = Utils.ucs4_size(string.byte(str, i))
        if bytes > 0 then
            i = i + bytes
            l = l + 1
        else
            i = i + 1
        end
    end
    return l
end
---@param str string
---@param si number|nil
---@param ei number|nil
---@return string
function Utils.utf8_sub (str, si, ei)
    local n = #str
    si = si or 1
    ei = ei or n
    ei = ei - si
    local i = 1
    while i <= n and si > 1 do
        local bytes = Utils.ucs4_size(string.byte(str, i))
        i = i + (bytes > 0 and bytes or 1)
        si = si - 1
    end
    local j = i
    while j <= n and ei > 0 do
        local bytes = Utils.ucs4_size(string.byte(str, j))
        j = j + (bytes > 0 and bytes or 1)
        ei = ei - 1
    end
    return string.sub(str, i, j)
end
---@param str string
---@param cb fun(str: string, index: number, size: number): boolean
function Utils.utf8_for (str, cb)
    local n = #str
    local i = 1
    while i <= n do
        local code = string.byte(str, i)
        local bytes = Utils.ucs4_size(code)
        if bytes > 0 then
            if cb(i, bytes, code) then
                return
            end
            i = i + bytes
        else
            i = i + 1
        end
    end
end



-- Size Fit
---@param dstSize Vector2f
---@param srcSizeOrAspect Vector2f|number
---@return Vector2f
function Utils.sizeFill (dstSize, srcSizeOrAspect)
    return dstSize:copy()
end
---@param dstSize Vector2f
---@param srcSizeOrAspect Vector2f|number
---@return Vector2f
function Utils.sizeFitX (dstSize, srcSizeOrAspect)
    srcSizeOrAspect = type(srcSizeOrAspect) == "number" and srcSizeOrAspect or srcSizeOrAspect.x / srcSizeOrAspect.y
    return Amaz.Vector2f(dstSize.x, dstSize.x / srcSizeOrAspect)
end
---@param dstSize Vector2f
---@param srcSizeOrAspect Vector2f|number
---@return Vector2f
function Utils.sizeFitY (dstSize, srcSizeOrAspect)
    srcSizeOrAspect = type(srcSizeOrAspect) == "number" and srcSizeOrAspect or srcSizeOrAspect.x / srcSizeOrAspect.y
    return Amaz.Vector2f(dstSize.y * srcSizeOrAspect, dstSize.y)
end
---@param dstSize Vector2f
---@param srcSizeOrAspect Vector2f|number
---@return Vector2f
function Utils.sizeContains (dstSize, srcSizeOrAspect)
    srcSizeOrAspect = type(srcSizeOrAspect) == "number" and srcSizeOrAspect or srcSizeOrAspect.x / srcSizeOrAspect.y
    return Amaz.Vector2f(math.min(dstSize.x, dstSize.y * srcSizeOrAspect), math.min(dstSize.x / srcSizeOrAspect, dstSize.y))
end
---@param dstSize Vector2f
---@param srcSizeOrAspect Vector2f|number
---@return Vector2f
function Utils.sizeCover (dstSize, srcSizeOrAspect)
    srcSizeOrAspect = type(srcSizeOrAspect) == "number" and srcSizeOrAspect or srcSizeOrAspect.x / srcSizeOrAspect.y
    return Amaz.Vector2f(math.max(dstSize.x, dstSize.y * srcSizeOrAspect), math.max(dstSize.x / srcSizeOrAspect, dstSize.y))
end








---------- common/Mat3.lua ----------

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
function Mat3.toMaterialVector (material, varName, count, maker)
    local arr = Amaz.Vec3Vector()
    for i = 0, count do
        local mat = maker(i)
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






---------- common/AEAdapter.lua ----------


---@class AEAdapter
local AEAdapter = {}
AEAdapter.__index = AEAdapter


function AEAdapter:new ()
    local self = setmetatable({}, AEAdapter)
    self._tracks = {}
    return self
end


---@param layerName string
---@param layerData table<string, table>
function AEAdapter:addKeyframes (layerName, layerData)
    for trackName, trackData in pairs(layerData) do
        local trackPath = layerName.."/"..trackName
        trackData.from_ae = true
        self._tracks[trackPath] = trackData
        if trackData.v then
            AEAdapter._solveBezierLength(trackData)
        end
    end
end


---@param layerName string
---@param layerData table
function AEAdapter:addFrames (layerName, layerData)
    local fps = layerData.frameRate
    layerData = layerData.layer0
    for attrName, attrData in pairs(layerData) do
        if type(attrData) == "table" then
            local trackPath = layerName.."."..attrName
            attrData.fps = fps
            self._tracks[trackPath] = attrData
        end
    end
end


---@param layerName string
---@param layerData table
function AEAdapter:addAnimations (layerName, layerData)
    for attrName, attrData in pairs(layerData) do
        local trackPath = layerName..":"..attrName
        self._tracks[trackPath] = attrData
    end
end


---@param path string
---@param time number
---@return number|number[]
function AEAdapter:get (path, time)
    local track = self._tracks[path]
    if not track then
        return
    end

    if track.fps then
        return self:_solveFrame(track, time * track.fps)
    elseif track.from_ae then
        return self:_solveKeyframe(track, time)
    else
        return self:_solveAnimation(track, time)
    end
end
---@param path string
---@param time number
---@param delta number|nil
---@return number|number[]
function AEAdapter:getVelocity (path, time, delta)
    delta = delta or 0.001
    local v0 = self:get(path, time - delta)
    local v1 = self:get(path, time + delta)
    delta = delta + delta
    local v = {}
    for i = 1, #v0 do
        v[i] = (v1[i] - v0[i]) / delta
    end
    return v
end


function AEAdapter:_solveFrame (track, frame)
    if #track > 0 then
        local v = self._interpolateFrame(track, frame)
        return type(v) == "number" and {v} or v
    else
        local x = self._interpolateFrame(track.x, frame)
        local y = self._interpolateFrame(track.y, frame)
        return {x, y}
    end
end
function AEAdapter._interpolateFrame (array, frame)
    local n = #array
    local t, k0, k1

    if frame <= 0 then
        k0 = array[1]
        k1 = array[1]
        t = 0
    elseif frame >= n - 1 then
        k0 = array[n]
        k1 = array[n]
        t = 0
    else
        local i = math.floor(frame)
        k0 = array[i + 1]
        k1 = array[i + 2]
        t = frame - i
    end

    if type(k0) == "table" then
        local x = k0.x + (k1.x - k0.x) * t
        local y = k0.y + (k1.y - k0.y) * t
        if k0.z then
            local z = k0.z + (k1.z - k0.z) * t
            return {x, y, z}
        else
            return {x, y}
        end
    else
        return k0 + (k1 - k0) * t
    end
end


function AEAdapter:_solveKeyframe (track, time)
    local K = track.k
    local N = #K
    if time <= K[1][1] then
        return Utils.table_slice(K[1], 2)
    elseif time >= K[N][1] then
        return Utils.table_slice(K[N], 2)
    end

    local interpolator = track.v and self._interpolateVector or self._interpolateScalar
    for i = 2, N do
        if time < K[i][1] then
            return interpolator(K[i - 1], K[i], track.s[i - 1], time)
        end
    end
    return Utils.table_slice(K[N], 2)
end
function AEAdapter._interpolateScalar (K0, K1, S, T)
    if S.h then
        return Utils.table_slice(K0, 2)
    end
    local C = S.c
    local y = {}
    for i = 1, #K0 - 1 do
        local x1 = K0[1]
        local x2 = C[i][1]
        local x3 = C[i][3]
        local x4 = K1[1]
        local y1 = K0[i + 1]
        local y2 = C[i][2]
        local y3 = C[i][4]
        local y4 = K1[i + 1]
        y[i] = Utils.bezier4x2y(x1, x2, x3, x4, y1, y2, y3, y4, T)
    end
    return y
end
function AEAdapter._interpolateVector (K0, K1, S, T)
    if S.h then
        return Utils.table_slice(K0, 2)
    end

    local C = S.c
    local P1 = S.p1
    local P2 = S.p2
    local L = S.l

    local t1 = K0[1]
    local t2 = C[1]
    local t3 = C[3]
    local t4 = K1[1]
    local l1 = 0
    local l2 = C[2]
    local l3 = C[4]
    local l4 = L[#L]
    local l = Utils.bezier4x2y(t1, t2, t3, t4, l1, l2, l3, l4, T)
    l = math.min(l, L[#L])

    local si = 1
    local ei = #L
    while si < ei - 1 do
        local i = math.floor((si + ei) * 0.5)
        if l < L[i] then
            ei = i
        else
            si = i
        end
    end

    local t = Utils.step(L[si], L[ei], l)
    t = ((si-1) + t) / (#L-1)

    local x1 = K0[2]
    local x2 = P1[1]
    local x3 = P2[1]
    local x4 = K1[2]
    local y1 = K0[3]
    local y2 = P1[2]
    local y3 = P2[2]
    local y4 = K1[3]
    local z1, z2, z3, z4
    if K0[4] then
        z1 = K0[4]
        z2 = P1[3]
        z3 = P2[3]
        z4 = K1[4]
    end
    local x, y, z = Utils.bezier4(t, x1, x2, x3, x4, y1, y2, y3, y4, z1, z2, z3, z4)
    return {x, y, z}
end


function AEAdapter:_solveAnimation (track, time)
    local N = #track
    if time <= track[1][1] then
        return track[1][3]
    elseif time >= track[N][2] then
        return track[N][4]
    end

    for i = 1, N do
        local frag = track[i]
        if time <= frag[2] then
            local x = Utils.step(frag[1], frag[2], time)
            local m = frag[5]
            local y = type(m) == "function" and m(x) or Utils.bezier4x2y(0, m[1], m[3], 1, 0, m[2], m[4], 1, x)
            local v0 = frag[3]
            local v1 = frag[4]
            local v = {}
            for j = 1, #v0 do
                v[j] = Utils.mix(v0[j], v1[j], y)
            end
            return v
        end
    end
    return track[N][4]
end

function AEAdapter._splitBezierCurve (segments, K0, P1, P2, K3)
    local L = {0}
    local x0, y0, z0 = K0[2], K0[3], K0[4]
    for i = 1, segments do
        local t = i / segments
        local x1, y1, z1 = Utils.bezier4(t, K0[2], P1[1], P2[1], K3[2], K0[3], P1[2], P2[2], K3[3], K0[4], P1[3], P2[3], K3[4])
        local dx = x1 - x0
        local dy = y1 - y0
        local dz = z0 and z1 - z0 or 0
        local dL = math.sqrt(dx*dx + dy*dy + dz*dz)
        table.insert(L, L[#L] + dL)
        x0, y0, z0 = x1, y1, z1
    end
    return L
end
function AEAdapter._solveBezierLength (track)
    for i, s in ipairs(track.s) do
        if not s.h then
            local k0 = track.k[i]
            local k3 = track.k[i+1]
            s.l = AEAdapter._splitBezierCurve(128, k0, s.p1, s.p2, k3)
        end
    end
end







---------- cc/Helper.lua ----------
local Helper = {}

---@param scene Scene
---@param rootName string
---@param order number|nil
---@param maxBits number|nil
---@return number, number
function Helper.initPipeline (scene, rootName, order, maxBits)
    maxBits = maxBits or 64
    order = order or 0
    local function setLayerRecursion (parent, lastOrder)
        local entity = parent.entity
        local camera = entity:getComponent("Camera")
        if camera then
            lastOrder = lastOrder + 1
            entity.layer = 0
            camera.renderOrder = lastOrder
            camera.layerVisibleMask = Amaz.DynamicBitset.new(maxBits, "0x0"):set(lastOrder, true)
        else
            entity.layer = lastOrder
        end
        for i = 0, parent.children:size() - 1 do
            local child =  parent.children:get(i)
            lastOrder = setLayerRecursion(child, lastOrder)
        end
        return lastOrder
    end
    return setLayerRecursion(scene:findEntityBy(rootName):getComponent("Transform"), order)
end


function Helper.linkPipeline1 (...)
    local queue = {...}
    local input = table.remove(queue)
    while #queue > 0 do
        local effect = table.remove(queue)
        local output = table.remove(queue)
        if type(input) == "table" then
            for i, tex in ipairs(input) do
                effect["input"..i] = tex
            end
        else
            effect.input = input
        end
        if type(output) == "table" then
            for i, fb in ipairs(output) do
                effect["output"..i] = fb
            end
        else
            effect.output = output
        end
        input = output
    end
end


function Helper.getLuaObject (comp)
    local script = comp:getScript()
    if script then
        return Amaz.ScriptUtils.getLuaObj(script)
    end
end


function Helper.makeGaussianKernel (radius, sigma)
    sigma = sigma or 2
    local weights = {sum = 0}
    local sigma2q = sigma * sigma * 2
    for i = 0, radius do
        weights[i] = 1 / math.sqrt(math.pi * sigma2q) * math.exp(-i*i / sigma2q)
        weights.sum = weights.sum + weights[i] * (i == 0 and 1 or 2)
    end
    for i = 0, radius do
        weights[i] = weights[i] / weights.sum
    end

    local kernel = Amaz.FloatVector()
    for i = radius, 1 do
        kernel:pushBack(weights[i])
    end
    kernel:pushBack(weights[0])
    for i = 1, radius do
        kernel:pushBack(weights[i])
    end
    return kernel
end






---------- AE.lua ----------
local AE = {
    ["3Position_x"] = {
        d = 1,
        k = {
            {0, 2500},
            {0.36666666666667, 168},
            {0.76666666666667, 540},
            {0.8, 540}
        },
        s = {
            {c = {{0.08035858498886, 416.091912827213, 0.24216363719081, 168}}},
            {c = {{0.4739279544151, 168, 0.54165226666133, 540}}},
            {c = {{0.7667, 540, 0.79996666666667, 540}}}
        }
    },
    ["3Position_y"] = {
        d = 1,
        k = {
            {0, 3000},
            {0.46666666666667, 300},
            {0.76666666666667, 540},
            {0.8, 582.634554973822}
        },
        s = {
            {c = {{0.19375699058653, 877.60300312413, 0.36791491092191, 300}}},
            {c = {{0.57042784392175, 300, 0.71123407618205, 473.352881926214}}},
            {c = {{0.76669925754163, 540.03918431148, 0.79996666666667, 582.634554973822}}}
        }
    },
    ["3Position_z"] = {
        d = 1,
        k = {
            {0, 12000},
            {0.36666666666667, 3396.40601386026},
            {0.76666666666667, 107.303870588736},
            {0.8, -253.835593026894}
        },
        s = {
            {c = {{0.10117622870331, 7472.52729541572, 0.25348279117194, 3911.41786587602}}},
            {c = {{0.47864034710891, 2886.90081897703, 0.69202419964472, 960.233902265429}}},
            {c = {{0.7667, 106.922974803934, 0.79996666666667, -253.835593026894}}}
        }
    },
    ["3Scale"] = {
        d = 3,
        k = {
            {0, 0, 0, 0},
            {0.23333333333333, 100, 100, 100}
        },
        s = {
            {c = {{0.09208051651617, 32.543844131225, 0.15672204287847, 99.8515857553737}, {0.09208051651617, 32.543844131225, 0.15672204287847, 99.8515857553737}, {0.09208051651617, 32.543844131225, 0.15672204287847, 99.8515857553737}}}
        }
    },
    ["3Rotate_x"] = {
        d = 1,
        k = {
            {0, 150},
            {0.4, 1.02274809160305},
            {0.76666666666667, -19},
            {0.8, -23.9266596858639}
        },
        s = {
            {c = {{0.04178161910219, 87.242330167995, 0.23410301421858, 8.60732517197236}}},
            {c = {{0.52819789454422, -4.83827951014497, 0.68958753082365, -9.3949690056735}}},
            {c = {{0.7667, -19, 0.79996666666667, -23.9266596858639}}}
        }
    },
    ["3Rotate_y"] = {
        d = 1,
        k = {
            {0, -202},
            {0.4, 23.8490508297513},
            {0.76666666666667, 247},
            {0.8, 318.274227167692}
        },
        s = {
            {c = {{0.10246837156534, -59.6464726128125, 0.27393047947865, -5.03497800355123}}},
            {c = {{0.54106960945857, 57.8471779038414, 0.69800509098036, 115.889555514995}}},
            {c = {{0.7667, 247, 0.79996666666667, 318.274227167692}}}
        }
    },
    ["3Rotate_z"] = {
        d = 1,
        k = {
            {0, 99},
            {0.4, 7},
            {0.76666666666667, -77},
            {0.8, -87.8477470176456}
        },
        s = {
            {c = {{0.0004, 99, 0.27092681941838, 7}}},
            {c = {{0.57398446218896, 7, 0.7663, -77}}},
            {c = {{0.7667, -77, 0.79996666666667, -87.8477470176456}}}
        }
    },

    ["2Position"] = {
        v = true,
        d = 3,
        k = {
            {0.76666666666667, 1662, -87, 0},
            {0.83333333333333, 506.5, 587.5, 0},
            {0.86666666666667, 360, 531, 0},
            {1.03333333333333, 559.875, 519.5, 0},
            {1.16666666666667, 536.1875, 534.125, 0},
            {1.33333333333333, 540, 540, 0}
        },
        s = {
            {c = {0.777777777778, 235.559102196234, 0.822222222222, 1177.79556665041, 16.666666667, 21200.3191972371, 16.666666667, 21200.3191972371}, p1 = {1294, 447.5, 0}, p2 = {1015.40194702148, 597.813149452209, 0}},
            {c = {0.838888888889, 26.8194219968518, 0.861111111111, 134.097124153997, 16.666666667, 4827.49595933677, 16.666666667, 4827.49595933677}, p1 = {473.146579742432, 578.345508575439, 0}, p2 = {371, 564, 0}},
            {c = {0.86683333333333, 0, 0.88333333333333, 186.606587774531, 0.1, 0, 90, 106.125842491094}, p1 = {407.125, 510, 0}, p2 = {544.375, 508.75, 0}},
            {c = {1.08933333333333, 0, 1.11066666666667, 28.3457555016013, 42, 0, 42, 0}, p1 = {558.5, 525.5625, 0}, p2 = {540.625, 530.0625, 0}},
            {c = {1.21166666666667, 2.10108788785715, 1.235, 6.96536296562833, 27, 46.690841952381, 59, 4.27339909394674}, p1 = {535.6875, 537.4375, 0}, p2 = {540, 540, 0}}
        }
    },
    ["2Scale"] = {
        d = 3,
        k = {
            {0.76666666666667, 135, 135, 100},
            {1.33333333333333, 100, 100, 100}
        },
        s = {
            {c = {{0.76723333333333, 135, 0.86713063542048, 100}, {0.76723333333333, 135, 0.86713063542048, 100}, {0.76723333333333, 100, 0.88566666666667, 100}}}
        }
    },
    ["2Rotate"] = {
        d = 1,
        k = {
            {0.76666666666667, -19},
            {0.93333333333333, 4},
            {1.1, -1},
            {1.33333333333333, 0}
        },
        s = {
            {c = {{0.82222222166667, -19, 0.87777777833333, 4}}},
            {c = {{0.98034939048101, 4, 1.044444445, -1}}},
            {c = {{1.14511264352374, -1, 1.21196584514406, 0}}}
        }
    },
    ["2Opacity"] = {
        d = 1,
        k = {
            {0.76666666666667, 0},
            {0.8, 100}
        },
        s = {
            {c = {{0.77222222222233, 16.666666667, 0.79444444444433, 83.333333333}}}
        }
    },

    ["Saturation_intensity"] = {
        d = 1,
        k = {
            {0.83333333333333, 25},
            {1.33333333333333, 0}
        },
        s = {
            {c = {{0.96333333333333, 25, 1.15333333333333, 0}}}
        }
    },
    ["DeepGlow_exposure"] = {
        d = 1,
        k = {
            {0, 0},
            {0.7, 0.7},
            {0.83333333333333, 4},
            {1.33333333333333, 0}
        },
        s = {
            {c = {{0.17310398638248, 0.03693070674004, 0.48630201131759, 0.34715693535106}}},
            {c = {{0.8322374738897, 0.91834120122683, 0.8332, 4}}},
            {c = {{0.83383333333333, 4, 1.08333333333333, 0}}}
        }
    },
    ["DeepGlow_intensity"] = {
        d = 1,
        k = {
            {0, 0},
            {0.7, 14},
            {0.83333333333333, 80},
            {1.33333333333333, 0}
        },
        s = {
            {c = {{0.17767941772938, 1.21746402534544, 0.50387766436983, 7.59250654598128}}},
            {c = {{0.83211460810181, 18.3163033107505, 0.8332, 80}}},
            {c = {{0.83383333333333, 80, 1.08333333333333, 0}}}
        }
    },

}







---------- VAMain.lua ----------


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.DURATION = 40/30
    self.BLUR3_FRAMES = 16
    self.BLUR2_FRAMES = 16
    self.FOV = 39.6
    self.AE = AE
    return self
end


function VAMain:create (env, scene)
    local order = 0
    order = Helper.initPipeline(scene, "main", order, 128)
    Utils.log("order = %d", order)
    order = Helper.initPipeline(scene, "base", order, 128)
    Utils.log("order = %d", order)

    self.square = scene:findEntityBy("Square"):getComponent("MeshRenderer").material
    self.layers = {}
    for i = 1, self.BLUR3_FRAMES do
        local id = string.format("%02d", i)
        local camera = scene:findEntityBy("CameraMove"..id):getComponent("Camera")
        local motion = scene:findEntityBy("Move"..id):getComponent("MeshRenderer").material
        local output = scene:findEntityBy("Blur"..id):getComponent("MeshRenderer").material
        output:setFloat("u_opacity", 1 / self.BLUR3_FRAMES)
        table.insert(self.layers, {camera = camera, motion = motion, output = output})
    end
    self.motionBlur = scene:findEntityBy("MotionBlur"):getComponent("MeshRenderer").material
    self.blend32 = scene:findEntityBy("Blend32"):getComponent("MeshRenderer").material
    self.root3 = scene:findEntityBy("MotionBlur3D")
    self.root2 = scene:findEntityBy("MotionBlur2D")

    self.sat = scene:findEntityBy("LuaSaturation"):getComponent("ScriptComponent").properties
    self.glow = scene:findEntityBy("LumiDeepGlow"):getComponent("ScriptComponent").properties

    self.rti = scene.assetMgr:SyncLoad("rt/rti.rt")
    self.rt2 = scene.assetMgr:SyncLoad("rt/rt2.rt")

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
    local maxEdge = math.max(w, h)
    self.rti.width = maxEdge
    self.rti.height = maxEdge
    self.rt2.width = maxEdge
    self.rt2.height = maxEdge
    local s = 1080 / maxEdge
    maxEdge = maxEdge * s
    w = w * s
    h = h * s

    self.square:setFloat("u_aspect_src", w/h)

    for i, layer in ipairs(self.layers) do
        layer.camera.fovy = self.FOV
        layer.output:setFloat("u_dst_aspect", w/h)
        layer.output:setFloat("u_src_aspect", 1)
    end

    self.motionBlur:setVec2("u_screen_size", Amaz.Vector2f(w, h))
    self.motionBlur:setVec2("u_sprite_size", Amaz.Vector2f(w, h))

    self.f = h * 0.5 / math.tan(math.rad(self.FOV * 0.5))
    self.w = w
    self.h = h
end

function VAMain:update (env, duration, elapsed, progress)
    elapsed = progress * self.DURATION
    local elapsed0 = elapsed - 0.3/30
    local elapsed1 = elapsed + 0.3/30
    local w = self.w
    local h = self.h

    if elapsed < 24/30 then
        local p
        for i = 0, self.BLUR3_FRAMES - 1 do
            local t = Utils.mix(elapsed0, elapsed1, i/self.BLUR3_FRAMES)
            local layer = self.layers[i + 1]
            local model = Utils.aeTransform({
                {x = self.ae:get("/3Position_x", t)[1] - 540,
                 y = 540 - self.ae:get("/3Position_y", t)[1],
                 z = -self.ae:get("/3Position_z", t)[1] - self.f,
                 rx = 36,
                 ry = 9,
                 rz = 337,
                 s = 540 * self.ae:get("/3Scale", t)[1] * 0.01},
                {rx = self.ae:get("/3Rotate_x", t)[1],
                 ry = self.ae:get("/3Rotate_y", t)[1],
                 rz = self.ae:get("/3Rotate_z", t)[1]},
            })
            layer.motion:setMat4("u_AEModel", model)
            if i == math.floor(self.BLUR3_FRAMES/2) then
                p = model:multiplyVector4(Amaz.Vector4f(0, 0, 0, 1))
                p = layer.camera.projectionMatrix:multiplyVector4(p)
            end
        end
        self.root3.visible = true
        self.blend32:setFloat("u_opacity3d", 1)
    else
        self.root3.visible = false
        self.blend32:setFloat("u_opacity3d", 0)
    end
    self.sat:set("saturationIntensity", self.ae:get("/Saturation_intensity", elapsed)[1] * 0.01)

    if elapsed >= 23/30 then
        Mat3.toMaterialVector(self.motionBlur, "u_matrices", self.BLUR2_FRAMES, function (i)
            local t = Utils.mix(elapsed0, elapsed1, i/self.BLUR2_FRAMES)
            local q = self.ae:get("/2Position", t)
            local x = w * 0.5 + (q[1] - 540)
            local y = h * 0.5 - (q[2] - 540)
            local s = self.ae:get("/2Scale", t)[1] * 0.01
            local r = -self.ae:get("/2Rotate", t)[1]
            return Mat3.makeTransform(nil, { {w = w, h = h, ax = 0.5, ay = 0.5, x = x, y = y, s = s, r = r} })
        end)
        self.root2.visible = true
        self.blend32:setFloat("u_opacity2d", self.ae:get("/2Opacity", elapsed)[1] * 0.01)
    else
        self.root2.visible = false
        self.blend32:setFloat("u_opacity2d", 0)
    end

    self.glow:set("exposure", self.ae:get("/DeepGlow_exposure", elapsed)[1])
    self.glow:set("glowIntensity", self.ae:get("/DeepGlow_intensity", elapsed)[1] * 0.01)
end






---------- VAEntry.lua ----------

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript


function SeekModeScript.new (construct, ...)
    local self = setmetatable({}, SeekModeScript)
    self.curTime = 0
    self.duration = 3
    self.main = VAMain.new()
    return self
end

function SeekModeScript:onStart (comp)
    self:_adapt_onStart(comp)
    self.rootDir = comp.entity.scene.assetMgr.rootDir
    --
    self.w = Amaz.BuiltinObject.getInputTextureWidth()
    self.h = Amaz.BuiltinObject.getInputTextureHeight()
    self.main:create(self, comp.entity.scene)
    self.main:layout(self, self.w, self.h)
    self.main:update(self, 1, 0, 0)
    ---#ifdef DEV
--//    self.sampleNode = comp.entity.scene:findEntityBy("@Sample")
--//    if self.sampleNode then
--//        self.sampleNode.visible = false
--//        self.sampleAnim = self.sampleNode:searchEntity("sample"):getComponent("AnimSeqComponent")
--//    end
    ---#endif
    --
end

function SeekModeScript:seek (time)
    self:_adapt_seek(time)
    --
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if w ~= self.w or h ~= self.h then
        self.w = w
        self.h = h
        self.main:layout(self, self.w, self.h)
    end
    self.main:update(self, self.duration, time, time / self.duration)
    --
end

function SeekModeScript:setParams (name, value)
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

function SeekModeScript:setDuration (duration)
    self.duration = duration
end

function SeekModeScript:_adapt_onStart (comp)
    self.curTime = 0
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
end

function SeekModeScript:_adapt_seek (time)
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

    self.modelMat:setFloat("u_OutputWidth", outputW)
    self.modelMat:setFloat("u_OutputHeight", outputH)

    local userMat = Amaz.Matrix4x4f()
    userMat:setTRS(
        Amaz.Vector3f(self.userPosition.x * outputRatio, self.userPosition.y, self.userPosition.z),
        Amaz.Quaternionf.EulerToQuaternion(-self.userEulerAngle / 180 * math.pi),
        Amaz.Vector3f(1, 1, 1) * self.userScale.x * extraScale
    )
    userMat:invert_Full()

    local fitMat = Amaz.Matrix4x4f()
    fitMat:setTRS(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.identity(), Amaz.Vector3f(uvScale.x, uvScale.y, 1))
    fitMat:invert_Full()

    self.modelMat:setMat4("userMat", userMat)
    self.modelMat:setMat4("fitMat", fitMat)
end


---#ifdef DEV
--//function SeekModeScript:onUpdate (comp, dt)
--//    self.blendMat:enableMacro("AMAZING_EDITOR_DEV", 1)
--//    self.modelMat:enableMacro("AMAZING_EDITOR_DEV", 1)

--//    if self.dev_seek then
--//        self:seek(self.dev_seek * self.duration)
--//    else
--//        self:seek(self.curTime)
--//    end
--//    self.curTime = self.curTime + dt
--//end
--//function SeekModeScript:onEvent (comp, event)
--//    if event.type == Amaz.EventType.TOUCH then
--//        local pointer = event.args:get(0)
--//        if pointer.type == Amaz.TouchType.TOUCH_BEGAN then
--//            self.dev_seek = 0
--//        elseif pointer.type == Amaz.TouchType.TOUCH_MOVED then
--//            self.dev_seek = pointer.x
--//            if self.sampleAnim and self.sampleAnim.animSeq then
--//                self.sampleNode.visible = pointer.y > 0.5
--//                local frameCount = self.sampleAnim.animSeq:getFrameCount()
--//                local frameIndex = math.min(math.floor(self.dev_seek * frameCount), frameCount - 1)
--//                self.sampleAnim:seek(frameIndex)
--//            end
--//        elseif pointer.type == Amaz.TouchType.TOUCH_ENDED or pointer.type == Amaz.TouchType.TOUCH_CANCELLED then
--//            if pointer.y > 0.9 then
--//                self.curTime = self.duration * self.dev_seek
--//                self.dev_seek = nil
--//                if self.sampleAnim then
--//                    self.sampleNode.visible = false
--//                end
--//            end
--//        end
--//    end
--//end
---#endif


exports.SeekModeScript = SeekModeScript
return exports
