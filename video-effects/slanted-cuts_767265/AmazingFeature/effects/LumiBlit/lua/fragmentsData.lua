-- layout_diagonal_75_left: 75°
-- UV: y = -3.732x + 3.549 / +2.366 / +1.183
-- V = -3.732x - y,  -3.549 / -2.366 / -1.183
-- : V<-3.549(1,c1) | -3.549<V<-2.366(2,c2_1) | -2.366<V<-1.183(3,c2_2_1) | V>-1.183(4,c2_2_2)
-- 1,3=FTD(), 2,4=FBD()
-- endTime=1.5: 0~0.75s(0~0.5), 0.825~1.5s sweep(0.55~1.0)

-- ============================================================
-- NDC
-- UVUVaspect
-- 75°:  = -tan(75°) dy/dx = -tan(75°) / aspect
-- ============================================================
local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
local aspect = outputW / outputH

local tan75 = math.tan(math.pi * 75.0 / 180.0)          -- ≈ 3.732
local slope = -tan75 / aspect                             -- : , dy/dx < 0
local invLen = 1.0 / math.sqrt(1.0 + slope * slope)
local adx = invLen                                        --  x (>0)
local ady = slope * invLen                                --  y (<0, )

-- p1p2 → (Ax+By+C<0)V(bottom-right)
-- below=, above=, 
local T = {
    p1 = { 0.951, 0.0 }, p2 = { 0.683, 1.0 },           -- L1: below=V<-3.549(1), above=V>-3.549(2+3+4)
    below = nil,                                            -- 1: camera_1 (leaf)
    above = {
        p1 = { 0.634, 0.0 }, p2 = { 0.366, 1.0 },         -- L2: below=-3.549<V<-2.366(2), above=V>-2.366(3+4)
        below = nil,                                        -- 2: camera_2_1 (leaf)
        above = {
            p1 = { 0.317, 0.0 }, p2 = { 0.049, 1.0 },     -- L3: below=-2.366<V<-1.183(3), above=V>-1.183(4)
            below = nil,                                    -- 3: camera_2_2_1 (leaf)
            above = nil,                                    -- 4: camera_2_2_2 (leaf)
        },
    },
}

-- : keyframe, easeOutQuart(0~0.5, 0~0.75s), linear
-- easeOutQuart, 
local animEnd = 0.5    -- , 
local function FTD(d,b) local sx,sy=-adx*2.5,-ady*2.5;local P={{time={0,animEnd},curve="easeOutQuart",startVal={sx,sy,b+0.15},endVal={0,0,b}},{time={animEnd,1},curve="linear",startVal={0,0,b},endVal={0,0,b}}};return { localPosition={sx,sy,b+0.15},localRotation={0,0,0},localScale={1,1,1},alpha=1,anchor={type=1,point={0.5,0.5,0}},animation={localPosition=P}} end
local function FBD(d,b) local sx,sy=adx*2.5,ady*2.5;local P={{time={0,animEnd},curve="easeOutQuart",startVal={sx,sy,b-0.15},endVal={0,0,b}},{time={animEnd,1},curve="linear",startVal={0,0,b},endVal={0,0,b}}};return { localPosition={sx,sy,b-0.15},localRotation={0,0,0},localScale={1,1,1},alpha=1,anchor={type=1,point={0.5,0.5,0}},animation={localPosition=P}} end

-- : hold 0~0.55(), sweep 0.55~1.0()
local maskStart = 0.55         -- , 0.55×1.5=0.825s

return { durationScale = 2.0,
    reverse = true, endTime=1.5, useMultiAspect=false, splitTree={["1:1"]=T},
    global={ showLine=false, lineWidth=0, lineMaskProgress=0, maskType="line", lineWidth=5, lineColor={0,0,0,1}, lineMask={p1={0,0.5},p2={1,0.5}},
        animation={lineMaskProgress={{time={0,maskStart},curve="linear",startVal=0,endVal=0},{time={maskStart,1},curve="easeIn",startVal=0,endVal=1}}} },
    fragments={
        camera_1       = FTD(0.00, 0.00),   -- 1: () ↓
        camera_2_1     = FBD(0.00, 0.15),   -- 2: () ↑
        camera_2_2_1   = FTD(0.00, 0.30),   -- 3: () ↓
        camera_2_2_2   = FBD(0.00, 0.20),   -- 4: () ↑
    }}
