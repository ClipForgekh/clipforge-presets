local Utils = require("Utils")


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
function AEAdapter:add (layerName, layerData)
    for trackName, trackData in pairs(layerData) do
        local trackPath = layerName.."/"..trackName
        self._tracks[trackPath] = trackData
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

    local K = track.k
    local N = #K
    if time <= K[1][1] then
        return Utils.vec(K[1], 2)
    elseif time >= K[N][1] then
        return Utils.vec(K[N], 2)
    end

    local interpolator = track.spatial and self._interpolateVector or self._interpolateScalar
    for i = 2, N do
        if time < K[i][1] then
            return interpolator(K[i - 1], K[i], track.s[i - 1], time)
        end
    end
    return Utils.vec(K[N], 2)
end



function AEAdapter._interpolateScalar (K0, K1, S, T)
    if S.hold then
        return Utils.vec(K0, 2)
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
    return Utils.vec(y)
end

function AEAdapter._interpolateVector (K0, K1, S, T)
    if S.hold then
        return Utils.vec(K0, 2)
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
        v[j - 1] = Utils.mix(P[j][i], P[j][i + 1], t)
    end
    return Utils.vec(v)
end


return AEAdapter

