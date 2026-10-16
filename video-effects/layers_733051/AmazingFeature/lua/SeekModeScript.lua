




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
---@return Mat3
function Utils.uvTransform (screenSize, layers)
    local matrix = Amaz.Matrix4x4f()
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
            local rotate = Amaz.Matrix4x4f()
            rotate:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf.eulerToQuaternion(Amaz.Vector3f(0, 0, -math.rad(layer.r))))
            matrix = matrix * rotate
        end
        if layer.s then
            matrix:scale(Amaz.Vector3f(1/layer.s, 1/layer.s, 1))
        elseif layer.sx or layer.sy then
            matrix:scale(Amaz.Vector3f(1/layer.sx, 1/layer.sy, 1))
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

---@vararg any[]
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


---@param
---@return
function Helper.getLuaObject (comp)
    local script = comp:getScript()
    if script then
        return Amaz.ScriptUtils.getLuaObj(script)
    end
end






---------- AE.lua ----------
local AE = {
    ["Saturation_0"] = {
        d = 1,
        k = {
            {0.93333333333333, -50},
            {2, 0}
        },
        s = {
            {c = {{1.57333333333333, -50, 1.73333333333333, 0}}}
        }
    },
    ["Passivation_0_Sharpen"] = {
        d = 1,
        k = {
            {0.93333333333333, 100},
            {1.76666666666667, 100},
            {2, 0}
        },
        s = {
            {c = {{1.37078602533547, 100, 1.48888889166667, 100}}},
            {c = {{1.89465775080892, 100, 1.95659634809162, 0}}}
        }
    },
    ["DeepGlow_0_Exposure"] = {
        d = 1,
        k = {
            {0.93333333333333, 1.7},
            {1.6, 1.06813364740888},
            {2, 0}
        },
        s = {
            {c = {{1.22578901334316, 1.7, 1.44787270601667, 1.45011886350049}}},
            {c = {{1.71572098476395, 0.80121626638055, 1.85462726687354, 0}}}
        }
    },
    ["Scale_Bg"] = {
        d = 3,
        k = {
            {0.93333333333333, 33, 33, 100},
            {2, 100, 100, 100}
        },
        s = {
            {c = {{1.104, 33, 1.30666666666667, 100}, {1.104, 33, 1.30666666666667, 100}, {1.104, 100, 1.30666666666667, 100}}}
        }
    },

    ["Scale_Root"] = {
        d = 3,
        k = {
            {0, 10, 10, 100},
            {1.76666666666667, 500.000000000001, 500, 100}
        },
        s = {
            {c = {{1.30733333333333, 73.7000000000001, 1.7649, 500.000000000001}, {1.30733333333333, 73.7, 1.7649, 500}, {1.30733333333333, 100, 1.7649, 100}}}
        }
    },

    ["Position_8"] = {
        v = true,
        d = 3,
        k = {
            {0, 283.004231054111, -253.389532279875, 0},
            {0.93333333333333, 103.920095465063, -98.1364709678821, 0},
            {1.06666666666667, 86.4603417468146, -73.6868735956933, 0},
            {1.23333333333333, 61.6644504014672, -53.2254597704745, 0},
            {1.4, 37.9424108596323, -33.1475158173981, 0},
            {1.56666666666667, 17.0953352543079, -15.1246857207702, 0},
            {1.63333333333333, 9.54396648432125, -7.2639636940654, 0},
            {1.76471354166667, -0.2000000000053, 0.40000000000828, 0}
        },
        s = {
            {c = {0.3554758463195, 51.0682902743361, 0.67097199253323, 180.310912052758, 38.0866978199461, 143.66177281265, 28.1101436571539, 216.117922006756}, p1 = {283.004231054111, -253.389532279875, 0}, p2 = {103.920095465063, -98.1364709678821, 0}},
            {c = {0.97944277224718, 9.96507612295835, 1.02391102031454, 21.3222283951327, 34.5820791853873, 216.117922006749, 32.0667347640955, 203.984830092771}, p1 = {103.920095465063, -98.1364709678821, 0}, p2 = {86.4603417468146, -73.6868735956933, 0}},
            {c = {1.12553046994691, 12.0073229107345, 1.18114814209019, 22.3820209191092, 35.3182819681479, 203.984830092757, 31.3111147458873, 187.144322987834}, p1 = {86.4603417468146, -73.6868735956933, 0}, p2 = {61.6644504014672, -53.2254597704745, 0}},
            {c = {1.28209493896367, 9.12545767348842, 1.34028988175807, 21.2248718977541, 29.2569633782021, 187.144322987819, 35.8260709451567, 165.020610225552}, p1 = {61.6644504014672, -53.2254597704745, 0}, p2 = {37.9424108596323, -33.1475158173981, 0}},
            {c = {1.45643015619864, 9.31213881102228, 1.51421359832765, 20.205420786671, 33.8580937191823, 165.020610225551, 31.4718410034079, 140.167379168413}, p1 = {37.9424108596323, -33.1475158173981, 0}, p2 = {17.0953352543079, -15.1246857207702, 0}},
            {c = {1.59015816585596, 3.29274187409988, 1.61258051825666, 8.30765634113787, 35.2372487839373, 140.167379168412, 31.1292226150052, 124.924386791791}, p1 = {17.0953352543079, -15.1246857207702, 0}, p2 = {9.54396648432125, -7.2639636940654, 0}},
            {c = {1.71027858185844, 9.61233798854043, 1.76427261367879, 12.3968230749559, 58.5668492242599, 124.924386791793, 0.33561218502568, 0}, p1 = {9.54396648432125, -7.2639636940654, 0}, p2 = {-0.2000000000053, 0.40000000000828, 0}}
        }
    },
    ["Scale_8"] = {
        d = 3,
        k = {
            {0, 100, 100, 100},
            {0.93333333333333, 102.627670134319, 102.627670134319, 100},
            {1.06666666666667, 99.527686918508, 99.5276869185078, 100},
            {1.23333333333333, 98.2909573312402, 98.2909573312398, 100},
            {1.4, 96.1776608067873, 96.177660806787, 100},
            {1.56666666666667, 100, 100, 100},
            {1.63333333333333, 113, 113, 100},
            {1.76666666666667, 116.76416483894, 116.764164838939, 100}
        },
        s = {
            {c = {{0.3844973305464, 100.672924245312, 0.77777777777467, 102.696549125371}, {0.3844973305464, 100.672924245311, 0.77777777777467, 102.696549125371}, {0.3844973305464, 100, 0.77777777777467, 99.8484384973129}}},
            {c = {{0.955555555556, 102.617830278454, 1.044444444444, 99.8489249039277}, {0.955555555556, 102.617830278454, 1.044444444444, 99.8489249039275}, {0.955555555556, 100.021651643241, 1.044444444444, 99.9102814023948}}},
            {c = {{1.094444444445, 99.1261394367334, 1.205555555555, 98.5701261738891}, {1.094444444445, 99.1261394367332, 1.205555555555, 98.5701261738888}, {1.094444444445, 100.112148247007, 1.205555555555, 100.136551029944}}},
            {c = {{1.26111111111167, 98.0117884885912, 1.344444445, 96.1776608067873}, {1.26111111111167, 98.0117884885909, 1.344444445, 96.177660806787}, {1.26111111111167, 99.8634489700563, 1.344444445, 100}}},
            {c = {{1.455555555, 96.1776608067873, 1.53888888888833, 97.9973405721965}, {1.455555555, 96.177660806787, 1.53888888888833, 97.9973405721965}, {1.455555555, 100, 1.53888888888833, 100.033078511752}}},
            {c = {{1.577777777778, 100.801063771121, 1.622222222222, 112.068657508929}, {1.577777777778, 100.801063771121, 1.622222222222, 112.068657508929}, {1.577777777778, 99.9867685952992, 1.622222222222, 100.162637746447}}},
            {c = {{1.655555555556, 114.862684982142, 1.744444444444, 116.136804032438}, {1.655555555556, 114.862684982142, 1.744444444444, 116.136804032437}, {1.655555555556, 99.6747245071059, 1.744444444444, 100.341714408929}}}
        }
    },
    ["Rotate_8"] = {
        d = 1,
        k = {
            {0, -131.66423297612},
            {1.76666666666667, -218.11400370173}
        },
        s = {
            {c = {{0.29444444445033, -146.072528097344, 1.47222222221633, -203.705708580507}}}
        }
    },
    ["Opacity_8"] = {
        d = 1,
        k = {
            {0.76666666666667, 0},
            {0.83333333333333, 100}
        },
        s = {
            {c = {{0.78066666666667, 0, 0.80533333333333, 100}}}
        }
    },

    ["Position_7"] = {
        v = true,
        d = 3,
        k = {
            {0, -290.404759814774, 280.883963388767, 0},
            {0.93333333333333, -110.777927010962, 111.003409132372, 0},
            {1.06666666666667, -96.6996526882647, 86.7080717366758, 0},
            {1.2, -78.9569566333496, 79.229240787397, 0},
            {1.33333333333333, -63.1477487086918, 70.4614063576402, 0},
            {1.5, -31.9128141460817, 30.0971889463781, 0},
            {1.63333333333333, -7.16755384943449, 6.96364635440361, 0},
            {1.76471354166667, -2.48974174610339e-11, -0.40000000029519, 0}
        },
        s = {
            {c = {0.3554758463195, 54.2933196740909, 0.77777777777467, 207.085058891891, 38.086697819946, 152.734201876808, 16.666666667, 258.107499497511}, p1 = {-290.404759814774, 280.883963388767, 0}, p2 = {-110.777927010962, 111.003409132372, 0}},
            {c = {0.955555555556, 5.7357222111705, 1.044444444444, 24.1350465698152, 16.666666667, 258.107499497511, 16.666666667, 177.502733581458}, p1 = {-110.777927010962, 111.003409132372, 0}, p2 = {-96.6996526882647, 86.7080717366758, 0}},
            {c = {1.08888888888933, 3.94450519077795, 1.17777777777733, 16.1434866718833, 16.666666667, 177.502733581458, 16.666666667, 139.996073513253}, p1 = {-96.6996526882647, 86.7080717366758, 0}, p2 = {-78.9569566333496, 79.229240787397, 0}},
            {c = {1.22222222222267, 3.11102385591228, 1.31111111111067, 12.9580786792446, 16.666666667, 139.996073513253, 16.666666667, 230.386367837618}, p1 = {-78.9569566333496, 79.229240787397, 0}, p2 = {-63.1477487086918, 70.4614063576402, 0}},
            {c = {1.36111111111167, 6.39962132895071, 1.47222222222167, 43.175844128202, 16.666666667, 230.386367837618, 16.666666667, 283.042457298756}, p1 = {-63.1477487086918, 70.4614063576402, 0}, p2 = {-31.9128141460817, 30.0971889463781, 0}},
            {c = {1.52222222222267, 6.28983238454259, 1.61111111111067, 30.1682356460095, 16.666666667, 283.042457298756, 16.666666667, 166.786512059833}, p1 = {-31.9128141460817, 30.0971889463781, 0}, p2 = {-7.16755384943449, 6.96364635440361, 0}},
            {c = {1.65523003472266, 3.65207445034153, 1.74281684027734, 8.56337144066756, 16.666666667, 166.786512059833, 16.666666667, 78.2160864197303}, p1 = {-7.16755384943449, 6.96364635440361, 0}, p2 = {-2.48974174610339e-11, -0.40000000029519, 0}}
        }
    },
    ["Scale_7"] = {
        d = 3,
        k = {
            {0, 104.212067452118, 104.212067452118, 100},
            {0.93333333333333, 107.460088385242, 107.460088385242, 100},
            {1.63333333333333, 117.073597723054, 117.073597723054, 100},
            {1.76666666666667, 120.951485816406, 120.951485816405, 100}
        },
        s = {
            {c = {{0.3844973305464, 105.279264974054, 0.77283871648731, 106.524601834843}, {0.3844973305464, 105.279264974054, 0.77283871648731, 106.524601834843}, {0.3844973305464, 100, 0.77777777777467, 99.4648972207625}}},
            {c = {{1.13088231086964, 108.611556360692, 1.51799442898368, 111.002734891334}, {1.13088231086964, 108.611556360692, 1.51799442898368, 111.002734891333}, {1.05000000000233, 100.401327084428, 1.40000000233333, 100}}},
            {c = {{1.65376307892229, 118.148917311504, 1.70645995404941, 120.72682236659}, {1.65376307892229, 118.148917311504, 1.70645995404941, 120.72682236659}, {1.67777777733333, 100, 1.744444444444, 99.333915158771}}}
        }
    },
    ["Rotate_7"] = {
        d = 1,
        k = {
            {0, 116.953838577575},
            {1.76666666666667, 10.0271059043077}
        },
        s = {
            {c = {{0.29444444445033, 99.1327164650074, 1.47222222221633, 27.8482280168754}}}
        }
    },
    ["Opacity_7"] = {
        d = 1,
        k = {
            {0.76666666666667, 0},
            {0.83333333333333, 100}
        },
        s = {
            {c = {{0.78066666666667, 0, 0.80533333333333, 100}}}
        }
    },

    ["Exposure_6"] = {
        d = 1,
        k = {
            {0.53919270833333, -3},
            {0.8, 0}
        },
        s = {
            {c = {{0.58266059027865, -2.49999999999, 0.75653211805469, -0.50000000001}}}
        }
    },
    ["Position_6"] = {
        v = true,
        d = 3,
        k = {
            {0, -335.110005612987, -198.968219240883, 0},
            {1, -127.299474743955, -73.0585159881071, 0},
            {1.26666666666667, -74.0458453210224, -41.4679951510821, 0},
            {1.46666666666667, -17.1647473991905, -10.2303169092828, 0},
            {1.6, -2.61320979076976, -2.13465107939791, 0},
            {1.76471354166667, 0.00483479718578, -0.67811674727608, 0}
        },
        s = {
            {c = {0.39397404893194, 48.2950191431581, 0.83333333333, 202.860318310494, 39.3974048931943, 122.584264811566, 16.666666667, 240.708085734619}, p1 = {-335.110005612987, -198.968219240883, 0}, p2 = {-127.299474743955, -73.0585159881071, 0}},
            {c = {1.04444444444533, 10.6981371439748, 1.22222222222133, 49.8411726852261, 16.666666667, 240.708085734619, 16.666666667, 271.741574504632}, p1 = {-127.299474743955, -73.0585159881071, 0}, p2 = {-74.0458453210224, -41.4679951510821, 0}},
            {c = {1.30000000000067, 9.05805248366888, 1.43333333333267, 56.7395490561143, 16.666666667, 271.741574504632, 16.666666667, 244.638291472988}, p1 = {-74.0458453210224, -41.4679951510821, 0}, p2 = {-17.1647473991905, -10.2303169092828, 0}},
            {c = {1.48888888888933, 5.43640647728624, 1.57777777777733, 15.1870027286891, 16.666666667, 244.638291472988, 16.666666667, 65.9221045605251}, p1 = {-17.1647473991905, -10.2303169092828, 0}, p2 = {-2.61320979076976, -2.13465107939791, 0}},
            {c = {1.62745225694499, 1.80971055275026, 1.69882989090403, 1.35482465315163, 16.666666667, 65.9221045605251, 39.9989278938404, 24.9092787045092}, p1 = {-2.61320979076976, -2.13465107939791, 0}, p2 = {0.00483479718578, -0.67811674727608, 0}}
        }
    },
    ["Scale_6"] = {
        d = 3,
        k = {
            {0, 106.82418831128, 106.82418831128, 100},
            {1, 122.916556802076, 122.916556802076, 100},
            {1.26666666666667, 125.690266152338, 125.690266152338, 100},
            {1.46666666666667, 131.08105278712, 131.08105278712, 100},
            {1.6, 135.695097261792, 135.695097261792, 100},
            {1.76471354166667, 143.679503574076, 143.679503574076, 100}
        },
        s = {
            {c = {{0.42065122383981, 112.328308188737, 0.8079550329708, 121.257828010176}, {0.42065122383981, 112.328308188737, 0.8079550329708, 121.257828010176}, {0.42065122383981, 100, 0.74795723595847, 99.2238189496048}}},
            {c = {{1.09579038289675, 124.010015858843, 1.18897257682442, 123.86520237912}, {1.09579038289675, 124.010015858843, 1.18897257682442, 123.86520237912}, {1.10046541360507, 100.309389363178, 1.18897257682442, 99.6418183267285}}},
            {c = {{1.3435527205046, 127.496348851939, 1.40984944816184, 129.321410873844}, {1.3435527205046, 127.496348851939, 1.40984944816184, 129.321410873843}, {1.3435527205046, 100.35445650333, 1.40984944816184, 101.064454797103}}},
            {c = {{1.51880889883596, 132.695909332219, 1.56296741370484, 134.255668546365}, {1.51880889883596, 132.695909332219, 1.56296741370484, 134.255668546364}, {1.51880889883596, 99.0231297725436, 1.56296741370484, 101.608176990663}}},
            {c = {{1.71857886542294, 140.30416838019, 1.76409633601599, 143.679503574076}, {1.71857886542294, 140.304168380189, 1.76409633601599, 143.679503574076}, {1.71857886542294, 94.8505945160803, 1.76409633601599, 100}}}
        }
    },
    ["Rotate_6"] = {
        d = 1,
        k = {
            {0, -86.7284467713787},
            {1.76666666666667, -126.728446771379}
        },
        s = {
            {c = {{0.29444444445033, -93.3951134381787, 1.47222222221633, -120.061780104579}}}
        }
    },
    ["Opacity_6"] = {
        d = 1,
        k = {
            {0.44117838541667, 0},
            {0.55882161458333, 100}
        },
        s = {
            {c = {{0.46588346354167, 0, 0.50941145833333, 100}}}
        }
    },

    ["Exposure_5"] = {
        d = 1,
        k = {
            {0.38037109375, -3},
            {0.7, 0}
        },
        s = {
            {c = {{0.43364257812607, -2.49999999999, 0.64672851562393, -0.50000000001}}}
        }
    },
    ["Position_5"] = {
        v = true,
        d = 3,
        k = {
            {0, 501.029689378446, 182.589776829558, 0},
            {0.73333333333333, 248.868330553135, 93.4299262172603, 0},
            {0.93333333333333, 194.629887294317, 70.7528186021515, 0},
            {1.2, 133.219302853697, 47.4161080323701, 0},
            {1.4, 54.243268181088, 20.486197486194, 0},
            {1.76471354166667, 0.39999999999225, -1.08713038571295e-11, 0}
        },
        s = {
            {c = {0.27318950321663, 47.1399566083011, 0.61111111110867, 224.736977756847}, p1 = {501.029689378446, 182.589776829558, 0}, p2 = {248.868330553135, 93.4299262172603, 0}},
            {c = {0.76666666666733, 11.6517222477484, 0.89999999999933, 49.8965861926125}, p1 = {248.868330553135, 93.4299262172603, 0}, p2 = {194.629887294317, 70.7528186021515, 0}},
            {c = {0.97777777777867, 11.8555698745229, 1.15555555555467, 51.4917513438305}, p1 = {194.629887294317, 70.7528186021515, 0}, p2 = {133.219302853697, 47.4161080323701, 0}},
            {c = {1.233333333334, 10.6526015532496, 1.366666666666, 75.1154423451152}, p1 = {133.219302853697, 47.4161080323701, 0}, p2 = {54.243268181088, 20.486197486194, 0}},
            {c = {1.46078559027899, 15.18258583583, 1.56776822916667, 51.3136244040357}, p1 = {54.243268181088, 20.486197486194, 0}, p2 = {0.39999999999225, -1.08713038571295e-11, 0}}
        }
    },
    ["Scale_5"] = {
        d = 3,
        k = {
            {0, 118.740322338799, 118.740322338799, 100},
            {0.73333333333333, 132.677896831934, 132.677896831934, 100},
            {0.93333333333333, 141.387439053929, 141.387439053929, 100},
            {1.2, 150, 150, 100},
            {1.4, 157, 157, 100},
            {1.76471354166667, 182.068910166609, 182.068910166609, 100}
        },
        s = {
            {c = {{0.23207816056135, 121.308253535675, 0.52814077362834, 126.180842018521}, {0.23207816056135, 121.308253535675, 0.52814077362834, 126.180842018521}, {0.28558237425211, 100, 0.52814077362834, 99.5926105921248}}},
            {c = {{0.8044042918555, 134.928231414358, 0.87099258962109, 139.170221460856}, {0.8044042918555, 134.928231414358, 0.87099258962109, 139.170221460855}, {0.8044042918555, 100.14110431563, 0.87099258962109, 100.289777896823}}},
            {c = {{1.03269524125541, 144.921355353406, 1.14199945037632, 148.336487205379}, {1.03269524125541, 144.921355353405, 1.14199945037632, 148.336487205378}, {1.03269524125541, 99.5381369713064, 1.15555555555467, 100.128116745924}}},
            {c = {{1.25293566831475, 151.51824701843, 1.3418020405132, 154.139432876472}, {1.25293566831475, 151.51824701843, 1.3418020405132, 154.139432876472}, {1.233333333334, 99.9039124405572, 1.3418020405132, 101.75216654731}}},
            {c = {{1.67014444995958, 170.278237570051, 1.76382624964266, 182.068910166609}, {1.67014444995958, 170.278237570051, 1.76382624964266, 182.068910166609}, {1.67014444995958, 91.866758347981, 1.76382624964266, 100}}}
        }
    },
    ["Rotate_5"] = {
        d = 1,
        k = {
            {0, -134.4438336242},
            {1.76666666666667, -6.77236765561375}
        },
        s = {
            {c = {{0.29444444445033, -113.165255962343, 1.47222222221633, -28.0509453174704}}}
        }
    },
    ["Opacity_5"] = {
        d = 1,
        k = {
            {0.33333333333333, 0},
            {0.46666666666667, 100}
        },
        s = {
            {c = {{0.36133333333333, 0, 0.41066666666667, 100}}}
        }
    },

    ["Exposure_5"] = {
        d = 1,
        k = {
            {0.38037109375, -3},
            {0.7, 0}
        },
        s = {
            {c = {{0.43364257812607, -2.49999999999, 0.64672851562393, -0.50000000001}}}
        }
    },
    ["Position_5"] = {
        v = true,
        d = 3,
        k = {
            {0, 501.029689378446, 182.589776829558, 0},
            {0.73333333333333, 248.868330553135, 93.4299262172603, 0},
            {0.93333333333333, 194.629887294317, 70.7528186021515, 0},
            {1.2, 133.219302853697, 47.4161080323701, 0},
            {1.4, 54.243268181088, 20.486197486194, 0},
            {1.76471354166667, 0.39999999999225, -1.08713038571295e-11, 0}
        },
        s = {
            {c = {0.27318950321663, 47.1399566083011, 0.61111111110867, 224.736977756847, 37.2531140749945, 172.554055164123, 16.666666667, 349.55166742546}, p1 = {501.029689378446, 182.589776829558, 0}, p2 = {248.868330553135, 93.4299262172603, 0}},
            {c = {0.76666666666733, 11.6517222477484, 0.89999999999933, 49.8965861926125, 16.666666667, 349.55166742546, 16.666666667, 266.750322171431}, p1 = {248.868330553135, 93.4299262172603, 0}, p2 = {194.629887294317, 70.7528186021515, 0}},
            {c = {0.97777777777867, 11.8555698745229, 1.15555555555467, 51.4917513438305, 16.666666667, 266.750322171431, 16.666666667, 319.578046591096}, p1 = {194.629887294317, 70.7528186021515, 0}, p2 = {133.219302853697, 47.4161080323701, 0}},
            {c = {1.233333333334, 10.6526015532496, 1.366666666666, 75.1154423451152, 16.666666667, 319.578046591096, 16.666666667, 249.772779471994}, p1 = {133.219302853697, 47.4161080323701, 0}, p2 = {54.243268181088, 20.486197486194, 0}},
            {c = {1.46078559027899, 15.18258583583, 1.56776822916667, 51.3136244040357, 16.666666667, 249.772779471994, 54, 31.9644309508833}, p1 = {54.243268181088, 20.486197486194, 0}, p2 = {0.39999999999225, -1.08713038571295e-11, 0}}
        }
    },
    ["Scale_5"] = {
        d = 3,
        k = {
            {0, 118.740322338799, 118.740322338799, 100},
            {0.73333333333333, 132.677896831934, 132.677896831934, 100},
            {0.93333333333333, 141.387439053929, 141.387439053929, 100},
            {1.2, 150, 150, 100},
            {1.4, 157, 157, 100},
            {1.76471354166667, 182.068910166609, 182.068910166609, 100}
        },
        s = {
            {c = {{0.23207816056135, 121.308253535675, 0.52814077362834, 126.180842018521}, {0.23207816056135, 121.308253535675, 0.52814077362834, 126.180842018521}, {0.28558237425211, 100, 0.52814077362834, 99.5926105921248}}},
            {c = {{0.8044042918555, 134.928231414358, 0.87099258962109, 139.170221460856}, {0.8044042918555, 134.928231414358, 0.87099258962109, 139.170221460855}, {0.8044042918555, 100.14110431563, 0.87099258962109, 100.289777896823}}},
            {c = {{1.03269524125541, 144.921355353406, 1.14199945037632, 148.336487205379}, {1.03269524125541, 144.921355353405, 1.14199945037632, 148.336487205378}, {1.03269524125541, 99.5381369713064, 1.15555555555467, 100.128116745924}}},
            {c = {{1.25293566831475, 151.51824701843, 1.3418020405132, 154.139432876472}, {1.25293566831475, 151.51824701843, 1.3418020405132, 154.139432876472}, {1.233333333334, 99.9039124405572, 1.3418020405132, 101.75216654731}}},
            {c = {{1.67014444995958, 170.278237570051, 1.76382624964266, 182.068910166609}, {1.67014444995958, 170.278237570051, 1.76382624964266, 182.068910166609}, {1.67014444995958, 91.866758347981, 1.76382624964266, 100}}}
        }
    },
    ["Rotate_5"] = {
        d = 1,
        k = {
            {0, -25.6299592786504},
            {1.76666666666667, -125.62995927865}
        },
        s = {
            {c = {{0.29444444445033, -42.2966259456504, 1.47222222221633, -108.96329261165}}}
        }
    },
    ["Opacity_5"] = {
        d = 1,
        k = {
            {0.33333333333333, 0},
            {0.46666666666667, 100}
        },
        s = {
            {c = {{0.36133333333333, 0, 0.41066666666667, 100}}}
        }
    },

    ["Exposure_4"] = {
        d = 1,
        k = {
            {0.2548828125, -3},
            {0.63333333333333, 0}
        },
        s = {
            {c = {{0.31795789930682, -2.49999999999, 0.57025824652652, -0.50000000001}}}
        }
    },
    ["Position_4"] = {
        v = true,
        d = 3,
        k = {
            {0, -812.768112050506, -47.8424998444659, 0},
            {0.5, -291.62714085929, -12.1226205431558, 0},
            {0.76666666666667, -135.797074742924, -6.1693829320866, 0},
            {1, -35.0545497783927, -0.37170708572593, 0},
            {1.16666666666667, -15.7838574949408, -0.38699893622994, 0},
            {1.76471354166667, 0.60000000000149, -0.40000000001147, 0}
        },
        s = {
            {c = {0.135, 201.068944080391, 0.365, 406.596719325541, 27, 1489.39958578067, 27, 857.533094843419}, p1 = {-812.768112050506, -47.8424998444659, 0}, p2 = {-291.62714085929, -12.1226205431558, 0}},
            {c = {0.56133333333333, 46.7831224796896, 0.676, 113.838931367245, 23, 762.768301299286, 34, 464.391289320448}, p1 = {-291.62714085929, -12.1226205431558, 0}, p2 = {-135.797074742924, -6.1693829320866, 0}},
            {c = {0.82966666666667, 32.2909483394393, 0.90666666666667, 76.6910023061684, 27, 512.554735546656, 40, 259.480834870495}, p1 = {-135.797074742924, -6.1693829320866, 0}, p2 = {-35.0545497783927, -0.37170708572593, 0}},
            {c = {1.05214955038135, 8.10660345444034, 1.10774791369831, 14.3968390695504, 31.2897302288076, 155.449153351475, 35.3512517810139, 82.7216978570565}, p1 = {-35.0545497783927, -0.37170708572593, 0}, p2 = {-15.7838574949408, -0.38699893622994, 0}},
            {c = {1.3387559836493, 14.2355204838624, 1.53917159609269, 16.3838626533011, 28.7752221734519, 82.7216978570422, 37.7130882213839, 0}, p1 = {-15.7838574949408, -0.38699893622994, 0}, p2 = {0.60000000000149, -0.40000000001147, 0}}
        }
    },
    ["Scale_4"] = {
        d = 3,
        k = {
            {0, 170.777379502908, 170.777379502908, 100},
            {0.5, 183.505827226783, 183.505827226782, 100},
            {0.76666666666667, 210.880232576964, 210.880232576964, 100},
            {1, 220, 220, 100},
            {1.16666666666667, 222.081117087621, 222.08111708762, 100},
            {1.76471354166667, 286.315149804378, 286.315149804377, 100}
        },
        s = {
            {c = {{0.0005, 170.777379502908, 0.41845846206241, 178.356667665755}, {0.0005, 170.777379502908, 0.41845846206241, 178.356667665755}, {0.0005, 100, 0.416666666665, 99.9482106290614}}},
            {c = {{0.58779317405578, 189.049763152154, 0.69114442004009, 205.294200784436}, {0.58779317405578, 189.049763152154, 0.69114442004009, 205.294200784435}, {0.54444444444533, 100.027620997834, 0.72222222222133, 100.129784906794}}},
            {c = {{0.80546510618593, 213.749973962264, 0.93085963810104, 219.188300606631}, {0.80546510618593, 213.749973962264, 0.93085963810104, 219.188300606631}, {0.80555555555633, 99.8864382065549, 0.96111111111033, 100.002346900491}}},
            {c = {{1.04841946502899, 220.56843859812, 1.12449010191938, 219.96612899155}, {1.04841946502899, 220.568438598119, 1.12449010191938, 219.96612899155}, {1.02777777777833, 99.9983236425064, 1.13888888888833, 99.7451145097629}}},
            {c = {{1.28462621618199, 227.996322475673, 1.76360741659898, 286.315149804378}, {1.28462621618199, 227.996322475673, 1.76360741659898, 286.315149804377}, {1.26634114583533, 100.914600825515, 1.76360741659898, 100}}}
        }
    },
    ["Opacity_4"] = {
        d = 1,
        k = {
            {0.17646484375, 0},
            {0.53333333333333, 100}
        },
        s = {
            {c = {{0.2514072265625, 0, 0.38344856770833, 100}}}
        }
    },

    ["Exposure_3"] = {
        d = 1,
        k = {
            {0.17060546875, -3},
            {0.53333333333333, 0}
        },
        s = {
            {c = {{0.23106011284843, -2.49999999999, 0.4728786892349, -0.50000000001}}}
        }
    },
    ["Position_3"] = {
        v = true,
        d = 3,
        k = {
            {0, 505.996165811321, -199.804499438008, 0},
            {0.33333333333333, 317.121706369656, -107.296829983224, 0},
            {0.56666666666667, 210.695125561336, -57.868519042204, 0},
            {0.83333333333333, 143.929112519073, -38.2807364485548, 0},
            {1, 121.017181867126, -30.4494482425928, 0},
            {1.16666666666667, 105.75371351531, -26.0940069507486, 0},
            {1.76471354166667, 0.79999999999538, -0.39999999999563, 0}
        },
        s = {
            {c = {0.05555555555667, 35.0520368480548, 0.27777777777667, 175.260184236068, 16.666666667, 630.936663252368, 16.666666667, 630.936663252368}, p1 = {505.996165811321, -199.804499438008, 0}, p2 = {317.121706369656, -107.296829983224, 0}},
            {c = {0.372222222223, 19.5574474487503, 0.527777777777, 97.7872372414047, 16.666666667, 502.905791529235, 16.666666667, 502.905791529235}, p1 = {317.121706369656, -107.296829983224, 0}, p2 = {210.695125561336, -57.868519042204, 0}},
            {c = {0.611111111112, 11.5966730438439, 0.788888888888, 57.9833652178281, 16.666666667, 260.92514348127, 16.666666667, 260.92514348127}, p1 = {210.695125561336, -57.868519042204, 0}, p2 = {143.929112519073, -38.2807364485548, 0}},
            {c = {0.86111111111167, 4.03555600323183, 0.97222222222167, 20.1777800156749, 16.666666667, 145.28001611344, 16.666666667, 145.28001611344}, p1 = {143.929112519073, -38.2807364485548, 0}, p2 = {121.017181867126, -30.4494482425928, 0}},
            {c = {1.02777777777833, 2.64545383096516, 1.13888888888833, 13.2272691545084, 16.666666667, 95.2363379128412, 16.666666667, 95.2363379128412}, p1 = {121.017181867126, -30.4494482425928, 0}, p2 = {105.75371351531, -26.0940069507486, 0}},
            {c = {1.26634114583533, 18.0088434867637, 1.66503906249801, 90.0442174316577, 16.666666667, 180.676574755819, 16.666666667, 180.676574755819}, p1 = {105.75371351531, -26.0940069507486, 0}, p2 = {0.79999999999538, -0.39999999999563, 0}}
        }
    },
    ["Scale_3"] = {
        d = 3,
        k = {
            {0, 190.999487932311, 190.99948793231, 100},
            {0.33333333333333, 215.170864680733, 215.170864680733, 100},
            {0.56666666666667, 215.70476005906, 215.70476005906, 100},
            {0.83333333333333, 247.132571252224, 247.132571252224, 100},
            {1.16666666666667, 287.243505287849, 287.243505287848, 100},
            {1.76471354166667, 359.998680172147, 359.998680172147, 100}
        },
        s = {
            {c = {{0.11337870415943, 202.226103114743, 0.22222222333333, 215.170864680733}, {0.11337870415943, 202.226103114743, 0.22222222333333, 215.170864680733}, {0.1183680450608, 100, 0.22222222333333, 100}}},
            {c = {{0.41111111033333, 215.170864680733, 0.48888888966667, 215.70476005906}, {0.41111111033333, 215.170864680733, 0.48888888966667, 215.70476005906}, {0.41111111033333, 100, 0.48888888966667, 100}}},
            {c = {{0.61647922638908, 215.70476005906, 0.72492765825452, 232.963045287752}, {0.61647922638908, 215.70476005906, 0.72492765825452, 232.963045287752}, {0.65555555466667, 100, 0.75119745176496, 99.7929203495272}}},
            {c = {{0.83366666666667, 247.132571252224, 1.16633333333333, 287.243505287849}, {0.83366666666667, 247.132571252224, 1.16633333333333, 287.243505287848}, {0.83366666666667, 100, 1.16633333333333, 100}}},
            {c = {{1.58823384778935, 333.147745818625, 1.76364045505212, 359.998680172147}, {1.58823384778935, 333.147745818625, 1.76364045505212, 359.998680172147}, {1.619277854137, 101.914218037722, 1.76364045505212, 100}}}
        }
    },
    ["Rotate_3"] = {
        d = 1,
        k = {
            {0, 131.624684118674},
            {1.76666666666667, 101.624684118674}
        },
        s = {
            {c = {{0.29444444445033, 126.624684118574, 1.47222222221633, 106.624684118774}}}
        }
    },
    ["Opacity_3"] = {
        d = 1,
        k = {
            {0.11764322916667, 0},
            {0.43333333333333, 100}
        },
        s = {
            {c = {{0.18393815104167, 0, 0.30074348958333, 100}}}
        }
    },

    ["Exposure_2"] = {
        d = 1,
        k = {
            {0.05094401041667, -3},
            {0.4, 0}
        },
        s = {
            {c = {{0.10912000868172, -2.49999999999, 0.34182400173495, -0.50000000001}}}
        }
    },
    ["Position_2"] = {
        v = true,
        d = 3,
        k = {
            {0, 293.512035449172, 344.084503527348, 0},
            {0.33333333333333, 170.561507782308, 191.718019382956, 0},
            {0.56666666666667, 132.15537883449, 155.828415338549, 0},
            {0.83333333333333, 97.5988350626102, 116.536267777222, 0},
            {1.03333333333333, 65.7421276539615, 83.3001828837341, 0},
            {1.76471354166667, 0.3999999999989, -0.40000000000727, 0}
        },
        s = {
            {c = {0.00033333333333, 0, 0.16, 150.755652512492, 0.1, 0, 52, 259.793706877171}, p1 = {293.512035449172, 344.084503527348, 0}, p2 = {170.561507782308, 191.718019382956, 0}},
            {c = {0.372222222223, 8.76085742146295, 0.527777777777, 43.8042871062635, 16.666666667, 225.279190833113, 16.666666667, 225.279190833113}, p1 = {170.561507782308, 191.718019382956, 0}, p2 = {132.15537883449, 155.828415338549, 0}},
            {c = {0.611111111112, 8.7210275540539, 0.788888888888, 43.6051377692229, 16.666666667, 196.223119962288, 16.666666667, 196.223119962288}, p1 = {132.15537883449, 155.828415338549, 0}, p2 = {97.5988350626102, 116.536267777222, 0}},
            {c = {0.86666666666733, 7.67298135967329, 0.99999999999933, 38.3649067974457, 16.666666667, 230.189440785595, 16.666666667, 230.189440785595}, p1 = {97.5988350626102, 116.536267777222, 0}, p2 = {65.7421276539615, 83.3001828837341, 0}},
            {c = {1.03406471354167, 0, 1.47947526041667, 92.3811959450655, 0.1, 0, 39, 48.3949303365538}, p1 = {65.7421276539615, 83.3001828837341, 0}, p2 = {0.3999999999989, -0.40000000000727, 0}}
        }
    },
    ["Scale_2"] = {
        d = 3,
        k = {
            {0, 211.221596361713, 211.221596361713, 100},
            {0.33333333333333, 188.027926401092, 188.027926401092, 100},
            {0.56666666666667, 250.482244284821, 250.482244284821, 100},
            {0.83333333333333, 301, 301, 100},
            {1.03333333333333, 324, 324, 100},
            {1.76471354166667, 444.402557600561, 444.40255760056, 100}
        },
        s = {
            {c = {{0.10103029069202, 203.648728491836, 0.22222222333333, 188.027926401092}, {0.10103029069202, 203.648728491836, 0.22222222333333, 188.027926401092}, {0.1183680450608, 100, 0.22222222333333, 100}}},
            {c = {{0.43133333333333, 188.027926401092, 0.56643333333333, 250.482244284821}, {0.43133333333333, 188.027926401092, 0.56643333333333, 250.482244284821}, {0.43133333333333, 100, 0.56643333333333, 100}}},
            {c = {{0.62240534966787, 271.178590547727, 0.76399990374247, 293.829434852674}, {0.62240534966787, 271.178590547727, 0.76399990374247, 293.829434852674}, {0.56693333333333, 100, 0.83306666666667, 100}}},
            {c = {{0.90492293194909, 309.862524088436, 0.97149309123595, 315.836188229966}, {0.90492293194909, 309.862524088436, 0.97149309123595, 315.836188229966}, {0.90492293194909, 100.165743051737, 0.97149309123595, 99.7917580358392}}},
            {c = {{1.59016953025222, 397.510480299035, 1.76350508780948, 444.402557600561}, {1.59016953025222, 397.510480299035, 1.76350508780948, 444.40255760056}, {1.59016953025222, 101.875100410823, 1.76350508780948, 100}}}
        }
    },
    ["Opacity_2"] = {
        d = 1,
        k = {
            {0.05882161458333, 0},
            {0.33333333333333, 100}
        },
        s = {
            {c = {{0.11646907552083, 0, 0.21803841145833, 100}}}
        }
    },

    ["Exposure_1"] = {
        d = 1,
        k = {
            {0, -3},
            {0.33333333333333, 0}
        },
        s = {
            {c = {{0.05555555555667, -2.49999999999, 0.27777777777667, -0.50000000001}}}
        }
    },
    ["Position_1"] = {
        v = true,
        d = 3,
        k = {
            {0, -464.210972644056, 73.6431589379067, 0},
            {0.36666666666667, -191.487573228758, 25.0411494326616, 0},
            {0.73333333333333, -118.066905680001, 16.4476387400606, 0},
            {0.96666666666667, -81.5598132583482, 11.4501472487402, 0},
            {1.76471354166667, 0.60000000000284, -0.20000000000802, 0}
        },
        s = {
            {c = {0.02061741728996, 157.279711709039, 0.13180540894962, 227.391063779546, 5.62293198817166, 7628.48757907266, 64.0530702864659, 211.312699508202}, p1 = {-464.210972644056, 73.6431589379067, 0}, p2 = {-191.487573228758, 25.0411494326616, 0}},
            {c = {0.36703333333333, 0, 0.73296666666667, 73.9218698987588, 0.1, 0, 0.1, 0}, p1 = {-191.487573228758, 25.0411494326616, 0}, p2 = {-118.066905680001, 16.4476387400606, 0}},
            {c = {0.73356666666667, 0, 0.96643333333333, 36.8475605473264, 0.1, 0, 0.1, 0}, p1 = {-118.066905680001, 16.4476387400606, 0}, p2 = {-81.5598132583482, 11.4501472487402, 0}},
            {c = {1.22570816831968, 45.6637896536367, 1.5019829031791, 79.293852293987, 32.4594343725752, 176.279821427239, 32.9217050674586, 14.0365720128365}, p1 = {-81.5598132583482, 11.4501472487402, 0}, p2 = {0.60000000000284, -0.20000000000802, 0}}
        }
    },
    ["Scale_1"] = {
        d = 3,
        k = {
            {0, 231.443704791115, 231.443704791115, 100},
            {0.36666666666667, 201.411370411149, 201.411370411149, 100},
            {0.73333333333333, 319.657797145882, 319.65779714588, 100},
            {0.86666666666667, 359.976813012018, 359.976813012017, 100},
            {0.96666666666667, 377.340558523569, 377.340558523567, 100},
            {1.76471354166667, 542.424558209528, 542.424558209527, 100}
        },
        s = {
            {c = {{0.10141268742693, 221.83109086134, 0.24444444566667, 201.411370411149}, {0.10141268742693, 221.83109086134, 0.24444444566667, 201.411370411149}, {0.13110755754125, 100, 0.24444444566667, 100}}},
            {c = {{0.48888888766667, 201.411370411149, 0.61916012641644, 265.518599511748}, {0.48888888766667, 201.411370411149, 0.61916012641644, 265.518599511747}, {0.48888888766667, 100, 0.62234229919171, 99.7626789648995}}},
            {c = {{0.77819420662612, 340.158259065334, 0.82408351723013, 352.671367784682}, {0.77819420662612, 340.158259065333, 0.82408351723013, 352.671367784681}, {0.77966077891082, 100.099057346596, 0.82408351723013, 99.8860801989841}}},
            {c = {{0.90119811736388, 365.900931472653, 0.93451987589875, 371.689265761516}, {0.90119811736388, 365.900931472651, 0.93451987589875, 371.689265761514}, {0.90119811736388, 100.092379639465, 0.93451987589875, 99.9003474854922}}},
            {c = {{1.57643777222232, 484.536174416109, 1.76345812665681, 542.424558209528}, {1.57643777222232, 484.536174416107, 1.76345812665681, 542.424558209527}, {1.57643777222232, 101.890242306969, 1.76345812665681, 100}}}
        }
    },
    ["Rotate_1"] = {
        d = 1,
        k = {
            {0, 106.869802210588},
            {1.76666666666667, 68.8698022105876}
        },
        s = {
            {c = {{0.29444444445033, 100.536468877128, 1.47222222221633, 75.2031355440476}}}
        }
    },
    ["Opacity_1"] = {
        d = 1,
        k = {
            {0, 0},
            {0.26666666666667, 100}
        },
        s = {
            {c = {{0.056, 0, 0.15466666666667, 100}}}
        }
    },

    ["Scale_0"] = {
        d = 3,
        k = {
            {0, 15.0000000000001, 15, 100},
            {0.93333333333333, 609.773910933893, 609.773910933892, 100}
        },
        s = {
            {c = {{0.46506142712732, 58.7614140086568, 0.71560202704224, 235.11807090766}, {0.46506142712732, 58.7614140086567, 0.71560202704224, 235.118070907658}, {0.00093333333333, 100, 0.77777777777467, 100}}}
        }
    },
    ["Rotate_0"] = {
        d = 1,
        k = {
            {0, 150.6740625},
            {0.93333333333333, 80.6740625}
        },
        s = {
            {c = {{0.15555555555867, 139.0073958331, 0.77777777777467, 92.3407291669}}}
        }
    },
    ["Opacity_0"] = {
        d = 1,
        k = {
            {0, 0},
            {0.23333333333333, 100}
        },
        s = {
            {c = {{0.04433333333333, 0, 0.154, 100}}}
        }
    },

}







---------- VAMain.lua ----------


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.CONTRAST_INTENSITY = 0.5
    self.DURATION = 60/30
    self.AE = AE
    self.CONFIG = {
        {t = 33/30, ax = 0, ay = 0, bs = 1.5, x = 544.4, y = 1080-580.3, s = 0.634, r = 105.6},
        {t = 36/30, ax = 1, ay = 1, bs = 2.0, x = 525.2, y = 1080-536.1, s = 0.610, r = 271.7, rr = -156},
        {t = 39/30, ax = 1, ay = 0, bs = 1.5, x = 528.7, y = 1080-549.7, s = 0.658, r = 222.7},
        {t = 39/30, ax = 0, ay = 1, bs = 2.0, x = 488.7, y = 1080-575.2, s = 0.746, r = 42.7, rr = 45},
        {t = 47/30, ax = 0, ay = 0, bs = 1.5, x = 502.4, y = 1080-549.9, s = 0.77, r = 90.6},
        {t = 49/30, ax = 1, ay = 1, bs = 2.0, x = 576.9, y = 1080-502.0, s = 0.702, r = 265.4},
        {t = 50/30, ax = 1, ay = 0, bs = 1.5, x = 511.4, y = 1080-580.6, s = 0.70, r = 349.1},
        {t = 50/30, ax = 0, ay = 1, bs = 2.0, x = 503.9, y = 1080-578.7, s = 0.701, r = 158.4},
    }
    return self
end


function VAMain:create (env, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.hsl0 = scene:findEntityBy("hsl0"):getComponent("MeshRenderer").material
    self.pass0Comp = scene:findEntityBy("PassivationMask_0"):getComponent("ScriptComponent")
    self.contrast0Comp = scene:findEntityBy("lumi_contrast_0"):getComponent("ScriptComponent")
    self.glow0Comp = scene:findEntityBy("Deep_Glow_Root_0"):getComponent("ScriptComponent")
    self.motionB = scene:findEntityBy("motionB"):getComponent("MeshRenderer").material
    self.pass1Comp = scene:findEntityBy("PassivationMask_1"):getComponent("ScriptComponent")
    self.contrast1Comp = scene:findEntityBy("lumi_contrast_1"):getComponent("ScriptComponent")
    self.blend8 = scene:findEntityBy("blend8"):getComponent("MeshRenderer").material
    self.blend7 = scene:findEntityBy("blend7"):getComponent("MeshRenderer").material
    self.blend6 = scene:findEntityBy("blend6"):getComponent("MeshRenderer").material
    self.blend5 = scene:findEntityBy("blend5"):getComponent("MeshRenderer").material
    self.blend4 = scene:findEntityBy("blend4"):getComponent("MeshRenderer").material
    self.blend3 = scene:findEntityBy("blend3"):getComponent("MeshRenderer").material
    self.blend2 = scene:findEntityBy("blend2"):getComponent("MeshRenderer").material
    self.blend1 = scene:findEntityBy("blend1"):getComponent("MeshRenderer").material
    self.blend0 = scene:findEntityBy("blend0"):getComponent("MeshRenderer").material
    self.shine = scene:findEntityBy("shine"):getComponent("MeshRenderer").material
    self.video = scene:findEntityBy("shine"):getComponent("VideoAnimSeq")
    if not Editor then
        self.video.enableFixedSeekMode = true
    end

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
    local q = math.max(w, h)
    local s = 1080 / q
    local k = q / math.min(w, h)
    w = w * s
    h = h * s
    local screenSize = Amaz.Vector2f(w, h)

    self.shine:setFloat("u_dstAspect", w / h)

    self.w = w
    self.h = h
    self.k = k
    self.screenSize = screenSize

end

function VAMain:update (env, duration, elapsed, progress)
    if not self.pass0 then
        self.pass0 = Helper.getLuaObject(self.pass0Comp)
    end
    if not self.pass1 then
        self.pass1 = Helper.getLuaObject(self.pass1Comp)
    end
    if not self.glow0 then
        self.glow0 = Helper.getLuaObject(self.glow0Comp)
    end
    if not self.contrast0 then
        self.contrast0 = Helper.getLuaObject(self.contrast0Comp)
    end
    if not self.contrast1 then
        self.contrast1 = Helper.getLuaObject(self.contrast1Comp)
    end

    progress = Utils.step(48/49, 0, progress)
    elapsed = progress * self.DURATION

    local saturation0 = self.ae:get("/Saturation_0", elapsed)[1] * 0.01
    self.hsl0:setFloat("u_saturation", saturation0)

    if self.pass0 then
        self.pass0.Sharpen = self.ae:get("/Passivation_0_Sharpen", elapsed)[1] * 0.02
        if self.contrast0 then
            self.contrast0.intensity = self.pass0.Sharpen * self.CONTRAST_INTENSITY
        end
    end

    if self.pass1 then
        if self.contrast1 then
            self.contrast1.intensity = self.pass1.Sharpen * self.CONTRAST_INTENSITY
        end
    end
    if self.glow0 then
        local intensity = Utils.clamp(self.ae:get("/DeepGlow_0_Exposure", elapsed)[1], 0, 1.7)
        self.glow0.Intensity = Utils.sineIn(intensity / 1.7) * 1.7
    end

    local w, h, k = self.w, self.h, self.k
    local ox, oy = w * 0.5, h * 0.5
    local rs = self.ae:get("/Scale_Root", elapsed)[1] * 0.01

    self.motionB:setMat4("u_matrix", Utils.uvTransform(self.screenSize, {
        {w = w, h = h, ax = 0.5, ay = 0.5, x = ox, y = oy,
         s = self.ae:get("/Scale_Bg", elapsed)[1] * 0.01}
    }))
    self.motionB:setFloat("u_opacity", elapsed < 27/30 and 0 or 1)

    local TR0 = {
        {w = 1080, h = 1080, ax = 0.5, ay = 0.5, x = ox, y = oy,
         s = self.ae:get("/Scale_0", elapsed)[1] * 0.01,
         r = -self.ae:get("/Rotate_0", elapsed)[1]},
        {w = w, h = h, ax = 0.5, ay = 0, x = 540, y = 0.111111 * 1080, s = 1.5 * k}
    }
    self.blend0:setMat4("u_baseMat", Utils.uvTransform(self.screenSize, TR0))
    TR0[2] = {w = 1000, h = 1000, ax = 0.5, ay = 0.5, x = 540, y = 540, s = 1.086}
    self.blend0:setMat4("u_baseMaskMat", Utils.uvTransform(self.screenSize, TR0))
    TR0[2] = {w = 408, h = 408, ax = 0.5, ay = 0.5, x = 540, y = 540}
    self.blend0:setMat4("u_haloMat", Utils.uvTransform(self.screenSize, TR0))
    local a0 = (elapsed < 28/30 and 1 or 0) * self.ae:get("/Opacity_0", elapsed)[1] * 0.01
    self.blend0:setFloat("u_opacity", a0)

    TR0[2] = {w = 480, h = 480, ax = 0.5, ay = 0.5, x = 540, y = 540}
    local TRm = Utils.uvTransform(self.screenSize, TR0)

    self:updateLayer(8, k, rs, TRm, elapsed)
    self:updateLayer(7, k, rs, TRm, elapsed)
    self:updateLayer(6, k, rs, TRm, elapsed)
    self:updateLayer(5, k, rs, TRm, elapsed)
    self:updateLayer(4, k, rs, TRm, elapsed)
    self:updateLayer(3, k, rs, TRm, elapsed)
    self:updateLayer(2, k, rs, TRm, elapsed)
    self:updateLayer(1, k, rs, TRm, elapsed)

    if not Editor then
        self.video:seekToTime(math.max(elapsed - 28/30, 0))
    end
    self.shine:setFloat("u_opacity", elapsed < 28/30 and 0 or 1)
end

function VAMain:updateLayer (i, k, rs, TRm, elapsed)
    local mat = self["blend"..i]
    local cfg = self.CONFIG[i]

    local w, h = self.w, self.h
    local ox, oy = w * 0.5, h * 0.5

    local p = self.ae:get("/Position_"..i, elapsed)
    local s = self.ae:get("/Scale_"..i, elapsed)
    local r = self.ae:get("/Rotate_"..i, elapsed)
    local TR = {
        {x = ox, y = oy, s = rs},
        {w = 1080, h = 1080, ax = 0.5, ay = 0.5,
         x = p and p[1] or 0,
         y = p and -p[2] or 0,
         s = s and s[1] * 0.01 or 1,
         r = r and -r[1] or -cfg.rr},
    }
    TR[3] = {w = w, h = h, ax = cfg.ax, ay = cfg.ay, x = cfg.ax * 1080, y = cfg.ay * 1080, s = k * cfg.bs}
    mat:setMat4("u_baseMat", Utils.uvTransform(self.screenSize, TR))
    TR[3] = {w = 1086, h = 1086, ax = 0.5, ay = 0.5, x = 540, y = 540}
    mat:setMat4("u_baseMaskMat", Utils.uvTransform(self.screenSize, TR))
    TR[3] = {w = 408, h = 408, ax = 0.5, ay = 0.5, x = 540, y = 540}
    mat:setMat4("u_haloMat", Utils.uvTransform(self.screenSize, TR))
    TR[3] = {w = 1472, h = 1472, ax = 0.5, ay = 0.5, x = cfg.x, y = cfg.y, s = cfg.s, r = cfg.r}
    mat:setMat4("u_shadowMat", Utils.uvTransform(self.screenSize, TR))

    mat:setMat4("u_maskMat", TRm)

    local a = self.ae:get("/Opacity_"..i, elapsed)
    a = a and a[1] * 0.01 or 1
    a = a * (elapsed < cfg.t and 1 or 0)
    mat:setFloat("u_opacity", a)

    local e = self.ae:get("/Exposure_"..i, elapsed)
    e = e and e or 0
    mat:setFloat("u_exposure", e)
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
