




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
    ["Scale_1"] = {
        d = 3,
        k = {
            {0.36666666666667, 75.0000000000001, 75, 100},
            {0.5, 100, 100, 100}
        },
        s = {
            {c = {{0.39078541457084, 74.9999997305174, 0.36666666666667, 100.000002847649}, {0.39078541457084, 74.9999997305174, 0.36666666666667, 100.000002847649}, {0.41111111066667, 100, 0.455555556, 100}}}
        }
    },
    ["Scale_2"] = {
        d = 3,
        k = {
            {0.4, 75.0000000000001, 75, 100},
            {0.53333333333333, 100, 100, 100}
        },
        s = {
            {c = {{0.42411874790418, 74.9999997305174, 0.4, 100.000002847649}, {0.42411874790418, 74.9999997305174, 0.4, 100.000002847649}, {0.444444444, 100, 0.48888888933333, 100}}}
        }
    },
    ["Scale_3"] = {
        d = 3,
        k = {
            {0.4, 75.0000000000001, 75, 100},
            {0.53333333333333, 100, 100, 100}
        },
        s = {
            {c = {{0.42411874790418, 74.9999997305174, 0.4, 100.000002847649}, {0.42411874790418, 74.9999997305174, 0.4, 100.000002847649}, {0.444444444, 100, 0.48888888933333, 100}}}
        }
    },
    ["Scale_4"] = {
        d = 3,
        k = {
            {0.4, 75.0000000000001, 75, 100},
            {0.53333333333333, 100, 100, 100}
        },
        s = {
            {c = {{0.42411874790418, 74.9999997305174, 0.4, 100.000002847649}, {0.42411874790418, 74.9999997305174, 0.4, 100.000002847649}, {0.444444444, 100, 0.48888888933333, 100}}}
        }
    },

    ["Scale"] = {
        d = 3,
        k = {
            {0.63333333333333, 90, 90, 100},
            {0.8, 99, 99, 100},
            {1.06666666666667, 100, 100, 100}
        },
        s = {
            {c = {{0.68888888833333, 90, 0.744444445, 99}, {0.68888888833333, 90, 0.744444445, 99}, {0.68888888833333, 100, 0.744444445, 100}}},
            {c = {{0.888888888, 99, 0.97777777866667, 100}, {0.888888888, 99, 0.97777777866667, 100}, {0.888888888, 100, 0.97777777866667, 100}}}
        }
    },
    ["RadialBlur"] = {
        d = 1,
        k = {
            {0.03333333333333, 0},
            {0.1, 12},
            {0.43333333333333, 0}
        },
        s = {
            {c = {{0.08266666095419, 6.7595039119602e-7, 0.077777778, 12}}},
            {c = {{0.19199999674974, 12.0000012605562, 0.19733334874294, -0.00000323360068}}}
        }
    },
    ["MotionBlur"] = {
        d = 1,
        k = {
            {0.04814453125, 0},
            {0.0962890625, 52.9},
            {0.43333333333333, 0}
        },
        s = {
            {c = {{0.06419270817285, 0, 0.08024088557715, 52.9}}},
            {c = {{0.12999348958333, 47.5477300045779, 0.32098524417904, 0}}}
        }
    },
    ["Grey"] = {
        d = 1,
        k = {
            {0, 0},
            {0.192578125, 100}
        },
        s = {
            {h = true}
        }
    },
}







---------- VAMain.lua ----------


local VAMain = {}
VAMain.__index = VAMain
function VAMain.new (env)
    local self = setmetatable({}, VAMain)
    self.DURATION = 24/30
    self.AE = AE
    return self
end


function VAMain:create (env, scene)
    Helper.initPipeline(scene, "main")

    self.motion1 = scene:findEntityBy("Motion1"):getComponent("MeshRenderer").material
    self.motion2 = scene:findEntityBy("Motion2"):getComponent("MeshRenderer").material
    self.motion3 = scene:findEntityBy("Motion3"):getComponent("MeshRenderer").material
    self.motion4 = scene:findEntityBy("Motion4"):getComponent("MeshRenderer").material
    self.hsl = scene:findEntityBy("HSL"):getComponent("MeshRenderer").material
    self.rBlurComp = scene:findEntityBy("LuaRadialBlur"):getComponent("ScriptComponent")
    self.mBlurComp = scene:findEntityBy("LumiDirectionBlur"):getComponent("ScriptComponent")

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)
end

function VAMain:layout (env, w, h)
end

function VAMain:update (env, duration, elapsed, progress)
    if not self.rBlur then
        self.rBlur = Helper.getLuaObject(self.rBlurComp)
    end
    if not self.mBlur then
        self.mBlur = Helper.getLuaObject(self.mBlurComp)
    end

    elapsed = progress * self.DURATION + 0.0001

    if self.rBlur then
        self.rBlur.amount = self.ae:get("/RadialBlur", elapsed)[1] * (2/3)
    end
    if self.mBlur then
        self.mBlur.intensity = self.ae:get("/MotionBlur", elapsed)[1]
    end

    --local s = self.ae:get("/Scale", elapsed)[1] * 0.01
    self.motion1:setFloat("u_scale", 1)
    self.motion2:setFloat("u_scale", 1)
    self.motion3:setFloat("u_scale", 1)
    self.motion4:setFloat("u_scale", 1)

    self.motion1:setFloat("u_grey", 0)
    self.motion2:setFloat("u_grey", 0)
    self.motion3:setFloat("u_grey", 0)
    self.motion4:setFloat("u_grey", 0)

    self.motion1:setFloat("u_exposure", 0)
    self.motion2:setFloat("u_exposure", 0)
    self.motion3:setFloat("u_exposure", 0)
    self.motion4:setFloat("u_exposure", 0)

    self.motion1:setFloat("u_opacity", Utils.step(06/30, 05/30, elapsed))
    self.motion2:setFloat("u_opacity", Utils.step(18/30, 17/30, elapsed))
    self.motion3:setFloat("u_opacity", Utils.step(10/30, 09/30, elapsed))
    self.motion4:setFloat("u_opacity", Utils.step(15/30, 14/30, elapsed))

    self.hsl:setFloat("u_sat", self.ae:get("/Grey", elapsed)[1] * 0.01 * -1)
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
