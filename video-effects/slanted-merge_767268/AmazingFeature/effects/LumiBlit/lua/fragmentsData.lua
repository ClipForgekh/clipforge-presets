-- layout_diagonal_75_left_6_sequential: 75°
-- UV, V=-3.732x-y, span=4.732, 0.7887
-- : V<-3.943(c1) | -3.943<V<-3.155(c2_1) | -3.155<V<-2.366(c2_2_1) | -2.366<V<-1.577(c2_2_2_1) | -1.577<V<-0.789(c2_2_2_2_1) | V>-0.789(c2_2_2_2_2)
-- 0.06, ()

local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
local aspect = outputW / outputH

local tan75 = math.tan(math.pi * 75.0 / 180.0)
local slope = -tan75 / aspect
local invLen = 1.0 / math.sqrt(1.0 + slope * slope)
local adx = invLen
local ady = slope * invLen

local T = {
    p1 = { 1.0, 0.211 }, p2 = { 0.789, 1.0 },
    below = nil,
    above = {
        p1 = { 0.845, 0.0 }, p2 = { 0.577, 1.0 },
        below = nil,
        above = {
            p1 = { 0.634, 0.0 }, p2 = { 0.366, 1.0 },
            below = nil,
            above = {
                p1 = { 0.423, 0.0 }, p2 = { 0.155, 1.0 },
                below = nil,
                above = {
                    p1 = { 0.211, 0.0 }, p2 = { 0.0, 0.789 },
                    below = nil,
                    above = nil,
                },
            },
        },
    },
}

local animEnd = 0.5
-- FTD: d=(normalized), 
local function FTD(d,b) local t0,t1=d,d+animEnd;local sx,sy=-adx*2.5,-ady*2.5;local P={{time={t0,t1},curve="easeOutQuart",startVal={sx,sy,b+0.15},endVal={0,0,b}},{time={t1,1},curve="linear",startVal={0,0,b},endVal={0,0,b}}};return {localPosition={sx,sy,b+0.15},localRotation={0,0,0},localScale={1,1,1},alpha=1,anchor={type=1,point={0.5,0.5,0}},animation={localPosition=P}} end

local maskStart = 0.55

return { endTime=1.5, useMultiAspect=false, splitTree={["1:1"]=T},
    global={ lineMaskProgress=0, maskType="line", lineWidth=5, lineColor={0,0,0,1}, lineMask={p1={0,0.5},p2={1,0.5}},
        animation={lineMaskProgress={{time={0,maskStart},curve="linear",startVal=0,endVal=0},{time={maskStart,1},curve="easeIn",startVal=0,endVal=1}}} },
    fragments={
        camera_1           = FTD(0.00, 0.00),   -- 1: t=0~0.5
        camera_2_1         = FTD(0.06, 0.15),   -- 2: t=0.06~0.56
        camera_2_2_1       = FTD(0.12, 0.30),   -- 3: t=0.12~0.62
        camera_2_2_2_1     = FTD(0.18, 0.20),   -- 4: t=0.18~0.68
        camera_2_2_2_2_1   = FTD(0.24, 0.10),   -- 5: t=0.24~0.74
        camera_2_2_2_2_2   = FTD(0.30, 0.25),   -- 6: t=0.30~0.80
    }}
