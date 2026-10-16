




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
        dst[k] = type(v) == "table" and Utils.clone(v) or v
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
    for _, v in ipairs(src) do
        table.insert(dst, v)
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
function Utils.bezier4 (q, x1, x2, x3, x4, y1, y2, y3, y4)
    local p = 1 - q
    local p2 = p * p
    local p3 = p2 * p
    local q2 = q * q
    local q3 = q2 * q
    local x = x1*p3 + 3*x2*p2*q + 3*x3*p*q2 + x4*q3
    local y = y4 and y1*p3 + 3*y2*p2*q + 3*y3*p*q2 + y4*q3
    return x, y
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
    until _t - t_ < 0.00001

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
    B = B or R[3]
    G = G or R[2]
    R = B and R or R[1]
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

    return {H, S, L}
end
function Utils.hsl2rgb (H, S, L)
    L = L or H[3]
    S = S or H[2]
    H = L and H or H[1]
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
    return {R, G, B}
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
        local bytes = Utils.ucs4_size(string.byte(str, i))
        if bytes > 0 then
            if cb(str, i, bytes) then
                return
            end
            i = i + bytes
        else
            i = i + 1
        end
    end
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


function AEAdapter:_solveFrame (track, frame)
    if #track > 0 then
        return self._interpolateFrame(track, frame)
    else
        local x = self._interpolateFrame(track.x, frame)
        local y = self._interpolateFrame(track.y, frame)
        return {x, y}
    end
end
function AEAdapter._interpolateFrame (array, frame)
    local n = #array - 1
    if frame <= 0 then
        return array[1]
    elseif frame >= n then
        return array[#array]
    end

    local i = math.floor(frame)
    local t = frame - i
    local k0 = array[i + 1]
    local k1 = array[i + 2]
    if type(k0) == "table" then
        local x = k0.x + (k1.x - k0.x) * t
        local y = k0.y + (k1.y - k0.y) * t
        return {x, y}
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

    local interpolator = track.spatial and self._interpolateVector or self._interpolateScalar
    for i = 2, N do
        if time < K[i][1] then
            return interpolator(K[i - 1], K[i], track.s[i - 1], time)
        end
    end
    return Utils.table_slice(K[N], 2)
end
function AEAdapter._interpolateScalar (K0, K1, S, T)
    if S.hold then
        return Utils.table_slice(K0, 2)
    end
    local O = S.o
    local I = S.i
    local y = {}
    for i = 1, #K0 - 1 do
        local x1 = K0[1]
        local x2 = O[i][1]
        local x3 = I[i][1]
        local x4 = K1[1]
        local y1 = K0[i + 1]
        local y2 = O[i][2]
        local y3 = I[i][2]
        local y4 = K1[i + 1]
        y[i] = Utils.bezier4x2y(x1, x2, x3, x4, y1, y2, y3, y4, T)
    end
    return y
end
function AEAdapter._interpolateVector (K0, K1, S, T)
    if S.hold then
        return Utils.table_slice(K0, 2)
    end
    local O = S.o
    local I = S.i
    local P = S.p
    local L = P[1]

    local x1 = K0[1]
    local x2 = O[1]
    local x3 = I[1]
    local x4 = K1[1]
    local y1 = 0
    local y2 = O[2]
    local y3 = I[2]
    local y4 = L[#L]
    local l = Utils.bezier4x2y(x1, x2, x3, x4, y1, y2, y3, y4, T)

    local si = 1
    local ei = #L - 1
    local i
    while true do
        i = math.floor((si + ei) * 0.5 + 0.5)
        if l < L[i] then
            ei = i - 1
        elseif l > L[i + 1] then
            si = i + 1
        else
            break
        end
    end

    local t = Utils.step(L[i], L[i + 1], l)
    local v = {}
    for j = 2, #K0 do
        local v0 = P[j][i]
        local v1 = P[j][i + 1]
        v[j - 1] = v0 + (v1 - v0) * t
    end
    return v
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







---------- cc/Helper.lua ----------
local Helper = {}

---@param scene Scene
---@param rootName string
---@param layer number|nil
---@param order number|nil
---@return number, number
function Helper.initPipeline (scene, rootName, layer, order)
    layer = layer or 1
    order = order or 0
    local function setLayerRecursion (node)
        node.entity.layer = order
        for i = 0, node.children:size() - 1 do
            setLayerRecursion(node.children:get(i))
        end
    end
    local root = scene:findEntityBy(rootName)
    if not root then
        return
    end
    local nodes = root:getComponent("Transform").children
    for i = 0, nodes:size() - 1 do
        local node = nodes:get(i)
        local entity = node.entity
        local camera = entity:getComponent("Camera")
        if camera then
            entity.layer = 0
            camera.renderOrder = order
            camera.layerVisibleMask = Amaz.DynamicBitset.new(64, string.format("%#x", layer))
            setLayerRecursion(node)
            order = order + 1
            layer = layer * 2
        else
            setLayerRecursion(node)
        end
    end
    return layer, order
end







---------- AE.lua ----------
local AE = {
    ["BCC6LensBlur-9961714"] = {
        ["d"] = 1,
        ["k"] = {
            {
                0,
                36
            },
            {
                0.5005005005005,
                0
            },
            {
                0.54220887554221,
                36
            },
            {
                0.75075075075075,
                0
            },
            {
                0.79245912579246,
                36
            },
            {
                1.37132966299633,
                0
            },
            {
                1.41554054054054,
                36
            },
            {
                2.04371037704371,
                0
            },
            {
                2.07907907907908,
                36
            },
            {
                2.29396062729396,
                0
            },
            {
                2.33566900233567,
                36
            },
            {
                2.91958625291959,
                0
            }
        },
        ["s"] = {
            {
                ["o"] = { { 0.00005005005005, 35.9999999999464 } },
                ["i"] = { { 0.05080620809035, 4.81264486218499e-7 } }
            },
            {
                ["o"] = { { 0.51440329204204, 0 } },
                ["i"] = { { 0.52830608400067, 36 } }
            },
            {
                ["o"] = { { 0.54222972972973, 35.9999999999777 } },
                ["i"] = { { 0.56337812891319, 2.00526869257708e-7 } }
            },
            {
                ["o"] = { { 0.76465354229229, 0 } },
                ["i"] = { { 0.77855633425092, 36 } }
            },
            {
                ["o"] = { { 0.79251701284618, 35.999999999938 } },
                ["i"] = { { 0.85122073929962, 5.56622483685545e-7 } }
            },
            {
                ["o"] = { { 1.37869814258718, 0 } },
                ["i"] = { { 1.40080358150651, 36 } }
            },
            {
                ["o"] = { { 1.41560335752419, 35.9999999999328 } },
                ["i"] = { { 1.4793065655446, 6.04027035578067e-7 } }
            },
            {
                ["o"] = { { 2.05549994427094, 0 } },
                ["i"] = { { 2.06728951185185, 36 } }
            },
            {
                ["o"] = { { 2.0791005672339, 35.999999999977 } },
                ["i"] = { { 2.10089187775254, 2.06622886083142e-7 } }
            },
            {
                ["o"] = { { 2.3078634188355, 0 } },
                ["i"] = { { 2.32176621079413, 36 } }
            },
            {
                ["o"] = { { 2.33572739406073, 35.9999999999375 } },
                ["i"] = { { 2.39494291177441, 5.61475233921582e-7 } }
            }
        }
    },
    ["ADBE Opacity"] = {
        ["d"] = 1,
        ["k"] = {
            {
                0,
                100
            },
            {
                0.5005005005005,
                1
            },
            {
                0.54220887554221,
                100
            },
            {
                0.752002002002,
                1
            },
            {
                0.79245912579246,
                100
            },
            {
                1.37637637637638,
                1
            },
            {
                1.41808475141808,
                100
            },
            {
                2.04371037704371,
                1
            },
            {
                2.07907907907908,
                100
            },
            {
                2.29396062729396,
                1
            },
            {
                2.33566900233567,
                100
            },
            {
                2.91958625291959,
                1
            }
        },
        ["s"] = {
            {
                ["o"] = { { 0.1668334984985, 100 } },
                ["i"] = { { 0.333667002002, 1 } }
            },
            {
                ["o"] = { { 0.51440329204204, 1 } },
                ["i"] = { { 0.52830608400067, 100 } }
            },
            {
                ["o"] = { { 0.61213991699616, 100 } },
                ["i"] = { { 0.68207096054805, 1 } }
            },
            {
                ["o"] = { { 0.75874485596721, 1 } },
                ["i"] = { { 0.77897341799716, 100 } }
            },
            {
                ["o"] = { { 0.98709820737404, 100 } },
                ["i"] = { { 1.18173729479479, 1 } }
            },
            {
                ["o"] = { { 1.3833277722168, 1 } },
                ["i"] = { { 1.40418195987654, 100 } }
            },
            {
                ["o"] = { { 1.62662662454121, 100 } },
                ["i"] = { { 1.83516850392059, 1 } }
            },
            {
                ["o"] = { { 2.04960516071639, 1 } },
                ["i"] = { { 2.06728951185185, 100 } }
            },
            {
                ["o"] = { { 2.1507062611011, 100 } },
                ["i"] = { { 2.22233344527194, 1 } }
            },
            {
                ["o"] = { { 2.30091202313438, 1 } },
                ["i"] = { { 2.32176621079413, 100 } }
            },
            {
                ["o"] = { { 2.53030808391725, 100 } },
                ["i"] = { { 2.724947171338, 1 } }
            }
        }
    }
}






---------- CCMain.lua ----------




local CCMain = {}
CCMain.__index = CCMain
function CCMain.new (env)
    local self = setmetatable({}, CCMain)
    self.AE = AE
    self.VIDEO_ASPECT = 9/16
    self.TRACK_DURATION = 72 / 23.976
    return self
end

function CCMain:create (env, data, scene)
    Helper.initPipeline(scene, "@Pipeline")

    self.blend = scene:findEntityBy("blend"):getComponent("MeshRenderer").material
    self.src1a = scene:findEntityBy("blend"):getComponent("VideoAnimSeq")
    self.filter = scene:findEntityBy("filter"):getComponent("MeshRenderer").material
    self.rt0 = scene:findEntityBy("camera_filter"):getComponent("Camera").renderTexture

    self.blur1Material = scene:findEntityBy("blur1"):getComponent("MeshRenderer").material
    self.blur2Material = scene:findEntityBy("blur2"):getComponent("MeshRenderer").material
    self.blur3Material = scene:findEntityBy("blur3"):getComponent("MeshRenderer").material
    self.XMaterial = scene:findEntityBy("X"):getComponent("MeshRenderer").material
    self.YMaterial = scene:findEntityBy("Y"):getComponent("MeshRenderer").material

    self.src1a.enableFixedSeekMode = true

    self.ae = AEAdapter:new()
    self.ae:addKeyframes("", self.AE)

    data.intensity = 0.5
end

function CCMain:layout (env, data, w, h)
    self.rt0.width = w
    self.rt0.height = h

    local s = math.min(w, h) / 1080
    w = w / s
    h = h / s

    local a = w / h
    local w1, h1, r1
    if a < (9/16 + 3/4) * 0.5 then
        w1 = math.max(w, h * self.VIDEO_ASPECT)
        h1 = math.max(w / self.VIDEO_ASPECT, h)
        r1 = 0
    elseif a < (3/4 + 1/1) * 0.5 then
        w1 = math.max(w, h * self.VIDEO_ASPECT)
        h1 = math.max(w / self.VIDEO_ASPECT, h)
        r1 = 0
    elseif a < (1/1 + 4/3) * 0.5 then
        w1 = math.max(w, h * self.VIDEO_ASPECT)
        h1 = math.max(w / self.VIDEO_ASPECT, h)
        r1 = 0
    elseif a < (4/3 + 16/9) * 0.5 then
        w1 = math.max(h, w * self.VIDEO_ASPECT)
        h1 = math.max(h / self.VIDEO_ASPECT, w)
        r1 = 90
    else
        w1 = math.max(h, w * self.VIDEO_ASPECT)
        h1 = math.max(h / self.VIDEO_ASPECT, w)
        r1 = 90
    end

    local screenSize = Amaz.Vector2f(w, h)
    self.blend:setVec2("u_screen_size", screenSize)
    self.blend:setVec2("u_size1", Amaz.Vector2f(w1, h1))
    self.blend:setFloat("u_angle1", r1)

    self.blur1Material:setVec2("u_ScreenSize", screenSize)
    self.blur2Material:setVec2("u_ScreenSize", screenSize)
    self.blur3Material:setVec2("u_ScreenSize", screenSize)
    self.XMaterial:setVec2("u_ScreenSize", screenSize)
    self.YMaterial:setVec2("u_ScreenSize", screenSize)
end

function CCMain:update (env, data, realElapsed, elapsed, duration, progress)
    local data_scale = data.intensity * 0.8 * 1.8
    local data_intensity = data.intensity * 0.5 * 4
    local data_light = data.intensity * 0.5 * 2.3
    local data_texture = math.min(data.intensity * 0.64 * 2, 1) * 3
    self.src1a:seekToTime(realElapsed % (self.src1a:getDuration() / 1000))

    if elapsed == nil then
        elapsed = 0.5
    end
    elapsed = elapsed % self.TRACK_DURATION
    local scale = self.ae:get("/BCC6LensBlur-9961714", elapsed)[1] / 36
    self.blur1Material:setFloat("u_SizeScale", scale)
    self.blur2Material:setFloat("u_SizeScale", scale)
    self.blur3Material:setFloat("u_SizeScale", scale)
    self.XMaterial:setFloat("u_SizeScale", scale)
    self.YMaterial:setFloat("u_SizeScale", scale)
    self.blur1Material:setFloat("u_Size", data_scale * 1.2)
    self.blur2Material:setFloat("u_Size", data_scale * 1.2)
    self.blur3Material:setFloat("u_Size", data_scale * 1.2)
    self.YMaterial:setFloat("u_Strength", data_scale * 0.4)
    self.XMaterial:setFloat("u_Strength", data_scale * 0.4)

    self.blur1Material:setFloat("u_Bright", data_intensity * 5)
    self.blur2Material:setFloat("u_Bright", data_intensity * 5)
    self.blur3Material:setFloat("u_Bright", data_intensity * 5)

    local light = self.ae:get("/ADBE Opacity", elapsed)[1] / 100 * data_light
    self.filter:setFloat("u_intensity", light)
    self.blend:setFloat("u_opacity1", data_texture * light)
end







---------- CCEntry.lua ----------

local function mix (a, b, t)
    return a + (b - a) * t
end
local function step (edge0, edge1, value)
    return (value - edge0) / (edge1 - edge0)
end

local CCHandlers = {
    effects_adjust_speed = "speed",
    effects_adjust_filter = "filter",
    effects_adjust_texture = "texture",
    effects_adjust_noise = "noise",
    effects_adjust_sharpen = "sharp",
    effects_adjust_soft = "soft",
    effects_adjust_luminance = "light",
    effects_adjust_blur = "blur",
    effects_adjust_distortion = "shape",
    effects_adjust_range = "range",
    effects_adjust_horizontal_chromatic = "color_x",
    effects_adjust_vertical_chromatic = "color_y",
    effects_adjust_horizontal_shift = "shift_x",
    effects_adjust_vertical_shift = "shift_y",
    effects_adjust_number = "count",
    effects_adjust_size = "scale",
    effects_adjust_intensity = "intensity",
    effects_adjust_rotate = "angle",
    effects_adjust_color = "color",
    effects_adjust_background_animation = "animate",
    sticker = "alpha"
}

local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript

function SeekModeScript.new (construct, ...)
    local self = setmetatable({}, SeekModeScript)
    self.main = CCMain.new(self)
    ---#ifdef DEF
--//    self.rawTimingData = {1230,2090,2960,3850,4760,5610,6460,7170,7850,8570,9250,9960,10640,11340,12070,12740,13420,14120,14830,15540,16250,16930,17620,18330,19020,19720,20420,21120,21810,22510,23200,23930,24600,25300,26000,26720,27410,28010,28620,29250}
--//    for i = 1, #self.rawTimingData do
--//        self.rawTimingData[i] = self.rawTimingData[i] * 0.001
--//    end
    ---#endif
    self.RawHeadTime = 0
    self.RawBeatTime = 0
    self.RawFootTime = 0.5
    self.RawIdleTime = self.RawFootTime
    return self
end

function SeekModeScript:onStart (comp)
    self.w = 0
    self.h = 0
    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.data = {}

    self.w = Amaz.BuiltinObject.getInputTextureWidth()
    self.h = Amaz.BuiltinObject.getInputTextureHeight()
    self.main:create(self, self.data, comp.entity.scene)
    self.main:layout(self, self.data, self.w, self.h)
    self:update(self, self.data, 0, self.endTime, 0)
end

function SeekModeScript:solveTiming (prev, next, q, p)
    local T = 0.5
    if not prev then
        next.s = next.t - T*q
    elseif not next then
        prev.e = prev.t + T*p
    else
        local t = next.t - prev.t
        if t < T then
            prev.e = prev.t + t*p
            next.s = next.t - t*q
        else
            prev.e = prev.t + T*p
            next.s = next.t - T*q
        end
    end
end

function SeekModeScript:update (env, data, time, duration, progress)
    if not self.timingData then
        if self.rawTimingData then
            local src = self.rawTimingData
            local dst = {}
            for _, beat in ipairs(src) do
                table.insert(dst, {t = beat})
            end
            local q = step(self.RawHeadTime, self.RawFootTime, self.RawBeatTime)
            local p = 1 - q
            for i = 0, #dst do
                self:solveTiming(dst[i], dst[i+1], q, p)
            end
            self.timingData = dst
        end
    end

    if self.timingData then
        local time0 = self.RawIdleTime
        for _, beat in ipairs(self.timingData) do
            if beat.s <= time and time < beat.e then
                if time < beat.t then
                    time0 = mix(self.RawHeadTime, self.RawBeatTime, step(beat.s, beat.t, time))
                else
                    time0 = mix(self.RawBeatTime, self.RawFootTime, step(beat.t, beat.e, time))
                end
                break
            end
        end
        self.main:update(env, data, time, time0, duration, time0 / duration)
    else
        self.main:update(env, data, time, nil, duration, nil)
    end
end

function SeekModeScript:onUpdate (comp, dt)
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if w ~= self.w or h ~= self.h then
        self.w = w
        self.h = h
        self.main:layout(self, self.data, w, h)
    end
    local T = self.endTime - self.startTime
    local t = self.curTime - self.startTime
    ---#ifndef DEV
    self:update(self, self.data, t, T, t / T)
    ---#else
--//    if self.dev_seek then
--//        self:update(self, self.data, self.dev_seek * T, T, self.dev_seek)
--//    else
--//        self:update(self, self.data, t, T, t / T)
--//    end
--//    if Editor then
--//        self.curTime = self.curTime + dt
--//    end
    ---#endif
end

function SeekModeScript:onEvent(sys, event)
    if event.args:get(0) == "effects_adjust_intensity" then
        local intensity = event.args:get(1)
        self.data.intensity = intensity
    end
    ---#ifdef DEV
--//    if event.type == Amaz.EventType.TOUCH then
--//        local pointer = event.args:get(0)
--//        if pointer.type == Amaz.TouchType.TOUCH_BEGAN then
--//            self.dev_seek = pointer.x
--//        elseif pointer.type == Amaz.TouchType.TOUCH_MOVED then
--//            self.dev_seek = pointer.x
--//        elseif pointer.type == Amaz.TouchType.TOUCH_ENDED or pointer.type == Amaz.TouchType.TOUCH_CANCELLED then
--//            if pointer.y > 0.9 then
--//                self.curTime = self.startTime + (self.endTime - self.startTime) * self.dev_seek
--//                self.dev_seek = nil
--//            end
--//        end
--//    end
    ---#else
    local type = event.args:get(0)
    if type == "time" then
        local src = event.args:get(1)
        if src and src:size() > 0 then
            local dst = {}
            for i = 0, src:size() - 1 do
                table.insert(dst, src:get(i))
            end
            if #dst == 0 then
                return
            end
            self.rawTimingData = dst
            self.timingData = nil
        end
    end
    ---#endif
end

exports.SeekModeScript = SeekModeScript
return exports
