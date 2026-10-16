-- Prompt 03: diagonal counterbeat, outward retreat, then a single clean return.
-- RGB separation is restricted to the impact; no global expansion is used.

local linear = "linear"
local impact = { type = "cubicBezier", x1 = 0.10, y1 = 0.72, x2 = 0.20, y2 = 1.00 }
local fade = { type = "cubicBezier", x1 = 0.22, y1 = 0.74, x2 = 0.36, y2 = 1.00 }
local slope = 0.50

local function seg(a, b, x, y, curve)
    return { time = { a, b }, curve = curve or linear, startVal = x, endVal = y }
end

local function base(depth, alpha)
    return {
        localPosition = { 0.0, 0.0, 0.0 }, localRotation = { 0.0, 0.0, 0.0 },
        selfRotation = { 0.0, 0.0, 0.0 }, localScale = { 1.0, 1.0, 1.0 },
        alpha = alpha, depth = depth,
        anchor = { type = 0, point = { 0.5, 0.5, 0.0 } },
    }
end

local function v(x)
    return { x, x * slope }
end

local function motion(curr, prev, intensity, center)
    return {
        currRotate = 0.0, prevRotate = 0.0,
        currAnchor = { 0.0, 0.0 }, prevAnchor = { 0.0, 0.0 },
        currPosition = curr[1].startVal, prevPosition = prev[1].startVal,
        currScale = { 1.0, 1.0 }, prevScale = { 1.0, 1.0 },
        vIntensity = 0.0, vCenter = 0.0,
        minSamples = 6.0, maxSamples = 34.0, dither = 0.44,
        unifiedScale = false, mirrorEdge = false,
        animation = { currPosition = curr, prevPosition = prev,
            vIntensity = intensity, vCenter = center },
    }
end

local firstCurr = {
    seg(0.00, 0.04, v(-1.16), v(-1.16)),
    seg(0.04, 0.18, v(-1.16), v(0.0), linear),
    seg(0.18, 0.26, v(0.0), v(0.0)),
    seg(0.26, 0.32, v(0.0), v(-0.10), impact),
    seg(0.32, 0.38, v(-0.10), v(-0.10)),
    seg(0.38, 0.50, v(-0.10), v(0.0), impact),
    seg(0.50, 1.00, v(0.0), v(0.0)),
}
local firstPrev = {
    seg(0.00, 0.055, v(-1.22), v(-1.22)),
    seg(0.055, 0.195, v(-1.22), v(0.0), linear),
    seg(0.195, 0.27, v(0.0), v(0.0)),
    seg(0.27, 0.33, v(0.0), v(-0.10), impact),
    seg(0.33, 0.395, v(-0.10), v(-0.10)),
    seg(0.395, 0.515, v(-0.10), v(0.0), impact),
    seg(0.515, 1.00, v(0.0), v(0.0)),
}
local secondCurr = {
    seg(0.00, 0.20, v(1.16), v(1.16)),
    seg(0.20, 0.34, v(1.16), v(0.0), linear),
    seg(0.34, 0.38, v(0.0), v(0.0)),
    seg(0.38, 0.43, v(0.0), v(0.10), impact),
    seg(0.43, 0.47, v(0.10), v(0.10)),
    seg(0.47, 0.55, v(0.10), v(0.0), impact),
    seg(0.55, 1.00, v(0.0), v(0.0)),
}
local secondPrev = {
    seg(0.00, 0.215, v(1.22), v(1.22)),
    seg(0.215, 0.355, v(1.22), v(0.0), linear),
    seg(0.355, 0.395, v(0.0), v(0.0)),
    seg(0.395, 0.445, v(0.0), v(0.10), impact),
    seg(0.445, 0.485, v(0.10), v(0.10)),
    seg(0.485, 0.565, v(0.10), v(0.0), impact),
    seg(0.565, 1.00, v(0.0), v(0.0)),
}

local firstBlur = {
    seg(0.00, 0.04, 0.0, 0.0), seg(0.04, 0.07, 0.0, 0.72, impact),
    seg(0.07, 0.15, 0.72, 0.72), seg(0.15, 0.18, 0.72, 0.0, linear),
    seg(0.18, 0.26, 0.0, 0.0), seg(0.26, 0.28, 0.0, 0.56, impact),
    seg(0.28, 0.30, 0.56, 0.56), seg(0.30, 0.32, 0.56, 0.0, linear),
    seg(0.32, 0.38, 0.0, 0.0), seg(0.38, 0.41, 0.0, 0.72, impact),
    seg(0.41, 0.47, 0.72, 0.72), seg(0.47, 0.50, 0.72, 0.0, linear),
    seg(0.50, 1.00, 0.0, 0.0),
}
local secondBlur = {
    seg(0.00, 0.20, 0.0, 0.0), seg(0.20, 0.23, 0.0, 0.82, impact),
    seg(0.23, 0.31, 0.82, 0.82), seg(0.31, 0.34, 0.82, 0.0, linear),
    seg(0.34, 0.38, 0.0, 0.0), seg(0.38, 0.40, 0.0, 0.62, impact),
    seg(0.40, 0.42, 0.62, 0.62), seg(0.42, 0.43, 0.62, 0.0, linear),
    seg(0.43, 0.47, 0.0, 0.0), seg(0.47, 0.49, 0.0, 0.72, impact),
    seg(0.49, 0.53, 0.72, 0.72), seg(0.53, 0.55, 0.72, 0.0, linear),
    seg(0.55, 1.00, 0.0, 0.0),
}

local function negTrack(parts)
    local result = {}
    for _, p in ipairs(parts) do
        table.insert(result, seg(p.time[1], p.time[2], -p.startVal, -p.endVal, p.curve))
    end
    return result
end

local firstCenter = negTrack(firstBlur)
local secondCenter = negTrack(secondBlur)
local first = base(1.0, 0.0)
first.animation = { alpha = {
    seg(0.00, 0.04, 0.0, 0.0), seg(0.04, 0.18, 0.0, 1.0, linear),
    seg(0.18, 1.00, 1.0, 1.0),
} }
first.motionBlur2D = motion(firstCurr, firstPrev, firstBlur, firstCenter)
first.cumCam = {
    blackWhiteIntensity = 0.0, blackWhiteContrast = 0.0,
    overlayProgress = 0.0, rgbSeparation = 0.0, rgbSeparationAngle = 0.0,
    transformRotation = 0.0, transformPosition = { 0.0, 0.0 },
    transformScale = { 1.0, 1.0 }, mirrorEdge = true, tileEdge = false,
    animation = { rgbSeparation = {
        seg(0.00, 0.25, 0.0, 0.0), seg(0.25, 0.32, 0.0, 34.0, impact),
        seg(0.32, 0.50, 34.0, 0.0, fade), seg(0.50, 1.00, 0.0, 0.0),
    } },
}
local second = base(2.0, 0.0)
second.animation = { alpha = {
    seg(0.00, 0.20, 0.0, 0.0), seg(0.20, 0.34, 0.0, 1.0, linear),
    seg(0.34, 1.00, 1.0, 1.0),
} }
second.motionBlur2D = motion(secondCurr, secondPrev, secondBlur, secondCenter)
second.cumCam = {
    blackWhiteIntensity = 0.0, blackWhiteContrast = 0.0,
    overlayProgress = 0.0, rgbSeparation = 0.0, rgbSeparationAngle = 0.0,
    transformRotation = 0.0, transformPosition = { 0.0, 0.0 },
    transformScale = { 1.0, 1.0 }, mirrorEdge = true, tileEdge = false,
    animation = { rgbSeparation = {
        seg(0.00, 0.38, 0.0, 0.0), seg(0.38, 0.45, 0.0, 34.0, impact),
        seg(0.45, 0.55, 34.0, 0.0, fade), seg(0.55, 1.00, 0.0, 0.0),
    } },
}

return {
    fov = 40.0, cameraType = "perspective",
    input1 = {
        splitType = "customLine",
        splitTrees = {
            { splits = { { p1 = { 0.0, 0.25 }, p2 = { 1.0, 0.75 }, hidePositive = 0.0 } } },
            { splits = { { p1 = { 0.0, 0.25 }, p2 = { 1.0, 0.75 }, hidePositive = 1.0 } } },
        },
        fragments = { camera_t1 = first, camera_t2 = second },
        global = {
            showLine = false, lineWidth = 1.0, lineColor = { 1.0, 1.0, 1.0, 0.0 },
            maskType = "line", lineMask = { p1 = { 0.0, 0.25 }, p2 = { 1.0, 0.75 } },
            lineMaskProgress = 0.0, localPosition = { 0.0, 0.0, 0.0 },
        },
    },
}
