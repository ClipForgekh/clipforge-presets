-- layout_diagonal_75_2: 75°
-- L1: y=3.732x-1.366, UV(0.5,0.5), 75°
-- camera_1(): , camera_2(): 
-- endTime=1.5: 0~0.75s, 0.825~1.5s sweep

local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
local aspect = outputW / outputH

local tan75 = math.tan(math.pi * 75.0 / 180.0)          -- ≈ 3.732
local slope = tan75 / aspect                              --  dy/dx
local invLen = 1.0 / math.sqrt(1.0 + slope * slope)
local adx = invLen
local ady = slope * invLen

local T = {
    p1 = { 0.366, 0.0 }, p2 = { 0.634, 1.0 },           -- L1: 75°
    below = nil,                                            -- : camera_1
    above = nil,                                            -- : camera_2
}

local animEnd = 0.5
-- FTD: , (→)
local function FTD(d,b) local sx,sy=adx*2.5,ady*2.5;local P={{time={0,animEnd},curve="easeOutQuart",startVal={sx,sy,b+0.15},endVal={0,0,b}},{time={animEnd,1},curve="linear",startVal={0,0,b},endVal={0,0,b}}};return {localPosition={sx,sy,b+0.15},localRotation={0,0,0},localScale={1,1,1},alpha=1,anchor={type=1,point={0.5,0.5,0}},animation={localPosition=P}} end
-- FBD: , (→)
local function FBD(d,b) local sx,sy=-adx*2.5,-ady*2.5;local P={{time={0,animEnd},curve="easeOutQuart",startVal={sx,sy,b-0.15},endVal={0,0,b}},{time={animEnd,1},curve="linear",startVal={0,0,b},endVal={0,0,b}}};return {localPosition={sx,sy,b-0.15},localRotation={0,0,0},localScale={1,1,1},alpha=1,anchor={type=1,point={0.5,0.5,0}},animation={localPosition=P}} end

local maskStart = 0.55

return { endTime=1.5, useMultiAspect=false, splitTree={["1:1"]=T},
    global={ lineMaskProgress=0, maskType="line", lineWidth=5, lineColor={0,0,0,1}, lineMask={p1={0,0.5},p2={1,0.5}},
        animation={lineMaskProgress={{time={0,maskStart},curve="linear",startVal=0,endVal=0},{time={maskStart,1},curve="easeIn",startVal=0,endVal=1}}} },
    fragments={
        camera_1       = FTD(0.00, 0.00),   -- : 
        camera_2       = FBD(0.00, 0.15),   -- : 
    }}
