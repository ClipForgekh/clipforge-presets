local utils = utils or {}
utils.__index = utils

-- ============================================================
--  old 
-- ============================================================

function utils:setLayer(cam, layer)
    local str = "1"
    for i = 1, layer do
        str = str .. "0"
    end
    local dynamic_bitset = Amaz.DynamicBitset.new(str)
    cam.layerVisibleMask = dynamic_bitset
end

--  fatherTrans  Camera blendCamEntity
function utils:findChild(lb, fatherTran, camArray)
    local cam = fatherTran.entity:getComponent("Camera")
    if cam and fatherTran.entity ~= lb.blendCamEntity then
        camArray[lb.orderIndex] = cam
        lb.orderIndex = lb.orderIndex + 1
    end
    if fatherTran.children then
        for i = 1, fatherTran.children:size() do
            local camTrans = fatherTran.children:get(i - 1)
            self:findChild(lb, camTrans, camArray)
        end
    end
end

--  layer
function utils:orderCam(lb, comp)
    lb.trans = comp.entity:getComponent("Transform")
    lb.orderIndex = 1
    local camArray = {}
    self:findChild(lb, lb.trans, camArray)

    -- blendCam 
    if lb.blendCam then
        camArray[lb.orderIndex] = lb.blendCam
        lb.orderIndex = lb.orderIndex + 1
    end

    for i = 1, lb.orderIndex - 1 do
        camArray[i].renderOrder = i
        self:setLayer(camArray[i], i)
        local transform = camArray[i].entity:getComponent("Transform")
        if transform.children then
            for j = 1, transform.children:size() do
                local rendererTrans = transform.children:get(j - 1)
                local renderers = rendererTrans.entity:getComponentsRecursive("Renderer")
                for k = 0, renderers:size() - 1 do
                    local renderer = renderers:get(k)
                    if renderer then
                        renderer.entity.layer = i
                    end
                end
            end
        end
    end
end

-- ============================================================
-- RenderTexture
-- ============================================================

function utils:createRenderTexture(width, height, filterMag, filterMin)
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

function utils:updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

-- ============================================================
--  splitTree
-- ============================================================
function utils:resolveSplitTree(fragmentsData)
    if not fragmentsData.useMultiAspect then
        return fragmentsData.splitTree["1:1"]
    end

    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
    local aspect = outputW / outputH

    local ratios = {
        { key = "1:1",  val = 1.0 },
        { key = "16:9", val = 16.0 / 9.0 },
        { key = "4:3",  val = 4.0 / 3.0 },
        { key = "3:4",  val = 3.0 / 4.0 },
        { key = "9:16", val = 9.0 / 16.0 },
    }

    local best = ratios[1]
    local bestDiff = math.abs(aspect - best.val)
    for _, r in ipairs(ratios) do
        local diff = math.abs(aspect - r.val)
        if diff < bestDiff then
            best = r
            bestDiff = diff
        end
    end

    Amaz.LOGI("AE_EFFECT_TAG LumiTag", "aspect: " .. aspect .. " → " .. best.key)
    return fragmentsData.splitTree[best.key]
end

-- ============================================================
-- 
-- ============================================================

--  UV  A*x + B*y + C = 0
-- //
function utils:pointsToLineABC(p1, p2)
    local A = p1[2] - p2[2]                 -- y1 - y2
    local B = p2[1] - p1[1]                 -- x2 - x1
    local C = p1[1] * p2[2] - p2[1] * p1[2] -- x1*y2 - x2*y1
    return A, B, C
end

-- ============================================================
--  / 
-- ============================================================

-- sidePath →  {0, 0} → "camera_1_1"
function utils:pathToName(sidePath)
    local parts = { "camera" }
    for _, s in ipairs(sidePath) do
        table.insert(parts, s == 0 and "1" or "2")
    end
    return table.concat(parts, "_")
end

-- 
function utils:copyTable(t)
    local new = {}
    for _, v in ipairs(t or {}) do
        table.insert(new, v)
    end
    return new
end

-- ============================================================
--  InputTex
--  splitPath 
--  RT 
--  alpha 
-- ============================================================
function utils:buildPipeline(node, inputSource, sidePath, splitPath, comp, lb)
    local lineA, lineB, lineC = self:pointsToLineABC(node.p1, node.p2)

    -- ---------- below (_1) ----------
    local belowPath = self:copyTable(sidePath)
    table.insert(belowPath, 0)
    local belowName = self:pathToName(belowPath)

    local belowSplitPath = self:copyTable(splitPath)
    table.insert(belowSplitPath, { lineA = lineA, lineB = lineB, lineC = lineC, hidePositive = 1.0 })

    if node.below then
        -- 
        self:buildPipeline(node.below, inputSource, belowPath, belowSplitPath, comp, lb)
    else
        --  camera InputTex 
        local belowRT = self:createRenderTexture(1, 1)
        local belowCam = lb:createLeafCamera(comp, belowName, belowRT, belowSplitPath)
        belowCam.inputSource = inputSource
        belowCam.splitPath = belowSplitPath
        belowCam.isLeaf = true
        table.insert(lb.allCameras, belowCam)
        table.insert(lb.leafRTs, belowRT)
        table.insert(lb.leafCameras, belowCam)
    end

    -- ---------- above (_2) ----------
    local abovePath = self:copyTable(sidePath)
    table.insert(abovePath, 1)
    local aboveName = self:pathToName(abovePath)

    local aboveSplitPath = self:copyTable(splitPath)
    table.insert(aboveSplitPath, { lineA = lineA, lineB = lineB, lineC = lineC, hidePositive = 0.0 })

    if node.above then
        -- 
        self:buildPipeline(node.above, inputSource, abovePath, aboveSplitPath, comp, lb)
    else
        --  camera InputTex 
        local aboveRT = self:createRenderTexture(1, 1)
        local aboveCam = lb:createLeafCamera(comp, aboveName, aboveRT, aboveSplitPath)
        aboveCam.inputSource = inputSource
        aboveCam.splitPath = aboveSplitPath
        aboveCam.isLeaf = true
        table.insert(lb.allCameras, aboveCam)
        table.insert(lb.leafRTs, aboveRT)
        table.insert(lb.leafCameras, aboveCam)
    end
end

-- ============================================================
-- Sutherland–Hodgman A*x+B*y+C=0 
-- keepSign > 0  A*x+B*y+C >= 0 
-- keepSign < 0  A*x+B*y+C <= 0 
-- ============================================================
function utils:clipPolygon(poly, A, B, C, keepSign)
    local out = {}
    local n = #poly
    if n == 0 then return out end

    for i = 1, n do
        local curr = poly[i]
        local next = poly[i % n + 1]

        local cv = A * curr[1] + B * curr[2] + C
        local nv = A * next[1] + B * next[2] + C

        local currInside = false
        local nextInside = false
        if keepSign > 0 then
            currInside = (cv >= -0.000001)
            nextInside = (nv >= -0.000001)
        else
            currInside = (cv <= 0.000001)
            nextInside = (nv <= 0.000001)
        end

        if currInside then
            table.insert(out, { curr[1], curr[2] })
        end

        if currInside ~= nextInside then
            local t = cv / (cv - nv)
            table.insert(out, { curr[1] + t * (next[1] - curr[1]),
                curr[2] + t * (next[2] - curr[2]) })
        end
    end

    return out
end

-- ============================================================
-- 
-- splitPath: { {lineA, lineB, lineC, hidePositive}, ... }
-- ============================================================
function utils:computeLeafPolygon(splitPath)
    local poly = { { 0, 0 }, { 1, 0 }, { 1, 1 }, { 0, 1 } } -- UV 
    for _, sp in ipairs(splitPath) do
        -- hidePositive=1 → keep negative side, hidePositive=0 → keep positive side
        local keepSign = (sp.hidePositive == 1.0) and -1 or 1
        poly = self:clipPolygon(poly, sp.lineA, sp.lineB, sp.lineC, keepSign)
        if #poly == 0 then break end
    end
    return poly
end

-- ============================================================
-- UV 
-- ============================================================
function utils:computeCentroid(poly)
    if #poly == 0 then return { 0.5, 0.5 } end
    local cx, cy = 0.0, 0.0
    for _, v in ipairs(poly) do
        cx = cx + v[1]
        cy = cy + v[2]
    end
    return { cx / #poly, cy / #poly } -- UV 
end

-- ============================================================
-- UV 
-- ============================================================
function utils:computeBounds(poly)
    if #poly == 0 then return { minX = 0, maxX = 1, minY = 0, maxY = 1 } end
    local minX, maxX = 1.0, 0.0
    local minY, maxY = 1.0, 0.0
    for _, v in ipairs(poly) do
        if v[1] < minX then minX = v[1] end
        if v[1] > maxX then maxX = v[1] end
        if v[2] < minY then minY = v[2] end
        if v[2] > maxY then maxY = v[2] end
    end
    return { minX = minX, maxX = maxX, minY = minY, maxY = maxY }
end

-- ============================================================
-- anchorPoint[0..1] 
-- anchorPoint=(0.5,0.5) → = 
-- anchorPoint=(0,0)     → 
-- anchorPoint=(1,1)     → 
--  NDC 
-- ============================================================
function utils:computeAnchorFromBounds(bounds, anchorPoint)
    local ax = anchorPoint[1] or 0.5
    local ay = anchorPoint[2] or 0.5
    local ndcX = (bounds.minX + ax * (bounds.maxX - bounds.minX)) * 2.0 - 1.0
    local ndcY = (bounds.minY + ay * (bounds.maxY - bounds.minY)) * 2.0 - 1.0
    return { ndcX, ndcY, anchorPoint[3] or 0.0 }
end

-- ============================================================
-- 
-- ============================================================
local Easing = {}

function Easing.linear(t) return t end

function Easing.easeIn(t) return t * t end

function Easing.easeOut(t) return 1.0 - (1.0 - t) * (1.0 - t) end

function Easing.easeInOut(t)
    if t < 0.5 then return 2.0 * t * t end
    return 1.0 - (-2.0 * t + 2.0) ^ 2.0 / 2.0
end

function Easing.easeOutBack(t)
    local c1 = 1.70158
    local c3 = c1 + 1.0
    return 1.0 + c3 * (t - 1.0) ^ 3.0 + c1 * (t - 1.0) ^ 2.0
end

function Easing.easeOutElastic(t)
    if t == 0.0 or t == 1.0 then return t end
    return 2.0 ^ (-10.0 * t) * math.sin((t - 1.0) * (2.0 * math.pi) / 0.3) + 1.0
end

function Easing.easeOutBounce(t)
    local n1 = 7.5625
    local d1 = 2.75
    if t < 1.0 / d1 then
        return n1 * t * t
    elseif t < 2.0 / d1 then
        t = t - 1.5 / d1
        return n1 * t * t + 0.75
    elseif t < 2.5 / d1 then
        t = t - 2.25 / d1
        return n1 * t * t + 0.9375
    else
        t = t - 2.625 / d1
        return n1 * t * t + 0.984375
    end
end

-- 
function Easing.easeInQuart(t)
    return t * t * t * t
end

function Easing.easeOutQuart(t)
    local u = 1.0 - t
    return 1.0 - u * u * u * u
end

function Easing.easeInExpo(t)
    if t <= 0.0 then return 0.0 end
    return 2.0 ^ (10.0 * (t - 1.0))
end

function Easing.easeOutExpo(t)
    if t >= 1.0 then return 1.0 end
    return 1.0 - 2.0 ^ (-10.0 * t)
end

function Easing.getValue(t, curveType)
    local fn = Easing[curveType]
    return fn and fn(t) or t
end

-- ============================================================
-- 
-- ============================================================
function utils:lerp(a, b, t)
    if type(a) == "table" then
        local r = {}
        for i = 1, #a do r[i] = a[i] + (b[i] - a[i]) * t end
        return r
    end
    return a + (b - a) * t
end

-- ============================================================
--  curTime / startTime / endTime  RTS + alpha
--  LumiBlit_old 
-- ============================================================
function utils:applyAnimation(lb)
    local duration = lb.endTime - lb.startTime
    if duration <= 0 then return end
    local t = (lb.curTime - lb.startTime) / duration
    if t < 0.0 then t = 0.0 elseif t > 1.0 then t = 1.0 end
    if lb.durationScale then
        if lb.reverse then
            t = (1.0 - t) / lb.durationScale
        else
            t = t / lb.durationScale
        end
        if t > 1.0 then t = 1.0 end
        if t < 0.0 then t = 0.0 end
    elseif lb.reverse then
        t = 1.0 - t
    end

    --
    for _, lc in ipairs(lb.leafCameras) do
        local fragData = lb.fragmentsData.fragments[lc.entity.name]
        if fragData then
            local anim = fragData.animation
            if anim then
                for key, parts in pairs(anim) do
                    local applied = false
                    --  ipairs 
                    for _, part in ipairs(parts) do
                        local tStart = part.time[1]
                        local tEnd   = part.time[2]
                        if t >= tStart and t <= tEnd then
                            local rawT = (t - tStart) / (tEnd - tStart)
                            local ct = part.curve or "linear"
                            local et = Easing.getValue(rawT, ct)
                            local sv = part.startVal
                            local ev = part.endVal

                            if key == "localPosition" then
                                lc.translation = self:lerp(sv, ev, et)
                            elseif key == "localRotation" then
                                lc.rotation = self:lerp(sv, ev, et)
                            elseif key == "localScale" then
                                lc.scale = self:lerp(sv, ev, et)
                            elseif key == "alpha" then
                                lc.alpha = self:lerp(sv, ev, et)
                            end
                            applied = true
                            break
                        end
                    end
                    --  t 
                    if not applied and #parts > 0 then
                        local firstPart = parts[1]
                        if t < firstPart.time[1] then
                            if key == "localPosition" then
                                lc.translation = firstPart.startVal
                            elseif key == "localRotation" then
                                lc.rotation = firstPart.startVal
                            elseif key == "localScale" then
                                lc.scale = firstPart.startVal
                            elseif key == "alpha" then
                                lc.alpha = firstPart.startVal
                            end
                        end
                    end
                end
            end
        end
    end

    -- 
    local g = lb.fragmentsData.global
    if g and g.animation then
        for key, parts in pairs(g.animation) do
            for _, part in pairs(parts) do
                local tStart = part.time[1]
                local tEnd   = part.time[2]
                if t >= tStart and t <= tEnd then
                    local rawT = (t - tStart) / (tEnd - tStart)
                    local ct = part.curve or "linear"
                    local et = Easing.getValue(rawT, ct)
                    local sv = part.startVal
                    local ev = part.endVal
                    lb[key] = self:lerp(sv, ev, et)
                    break
                end
            end
        end
    end
end

return utils
