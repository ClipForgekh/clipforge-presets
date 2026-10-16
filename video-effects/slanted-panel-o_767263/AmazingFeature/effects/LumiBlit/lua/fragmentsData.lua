-- layout_diagonal_75_left_sequential: 75°
-- UV: y = -3.732x + 3.549 / +2.366 / +1.183
-- V = -3.732x - y,  -3.549 / -2.366 / -1.183
-- : V<-3.549(1,c1) | -3.549<V<-2.366(2,c2_1) | -2.366<V<-1.183(3,c2_2_1) | V>-1.183(4,c2_2_2)
-- 0.08, ()

local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
local aspect = outputW / outputH

local tan75 = math.tan(math.pi * 75.0 / 180.0)
local slope = -tan75 / aspect
local invLen = 1.0 / math.sqrt(1.0 + slope * slope)
local adx = invLen
local ady = slope * invLen

local T = {
    p1 = { 0.951, 0.0 }, p2 = { 0.683, 1.0 },
    below = nil,
    above = {
        p1 = { 0.634, 0.0 }, p2 = { 0.366, 1.0 },
        below = nil,
        above = {
            p1 = { 0.317, 0.0 }, p2 = { 0.049, 1.0 },
            below = nil,
            above = nil,
        },
    },
}

local animEnd = 0.5
local shift = 0.05
-- FTD: d=(normalized),
local function FTD(d,b) local t0,t1=d+shift,d+shift+animEnd;local sx,sy=-adx*2.5,-ady*2.5;local P={{time={t0,t1},curve="easeOutQuart",startVal={sx,sy,b+0.15},endVal={0,0,b}},{time={t1,1},curve="linear",startVal={0,0,b},endVal={0,0,b}}};return { localPosition={sx,sy,b+0.15},localRotation={0,0,0},localScale={1,1,1},alpha=1,anchor={type=1,point={0.5,0.5,0}},animation={localPosition=P}} end

local maskStart = 0.55

return { durationScale = 1.351,
    reverse = true, endTime=1.5, useMultiAspect=false, splitTree={["1:1"]=T},
    global={ showLine=false, lineMaskProgress=0, maskType="line", lineWidth=5, lineColor={0,0,0,1}, lineMask={p1={0,0.5},p2={1,0.5}},
        animation={lineMaskProgress={{time={0,maskStart},curve="linear",startVal=0,endVal=0},{time={maskStart,1},curve="easeIn",startVal=0,endVal=1}}} },
    fragments={
        camera_1       = FTD(0.00, 0.00),   -- 1: t=0~0.5
        camera_2_1     = FTD(0.08, 0.15),   -- 2: t=0.08~0.58
        camera_2_2_1   = FTD(0.16, 0.30),   -- 3: t=0.16~0.66
        camera_2_2_2   = FTD(0.24, 0.20),   -- 4: t=0.24~0.74
    }}
