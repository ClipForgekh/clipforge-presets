-- h01: 
local T = { p1={0,2/3}, p2={1,2/3}, below={ p1={0,1/3}, p2={1,1/3}, below=nil, above=nil }, above=nil }
local aspect = Amaz.BuiltinObject.getOutputTextureWidth() / Amaz.BuiltinObject.getOutputTextureHeight()

local function F(delay, bZ, xStart)
    local xd = xStart * aspect * 1.2
    local t0,t1 = delay, delay+0.50
    local P = {{time={t0,t1},curve="easeOutExpo",startVal={xd,0,bZ+0.1},endVal={0,0,bZ}},{time={t1,1},curve="linear",startVal={0,0,bZ},endVal={0,0,bZ}}}
    local A = {{time={delay,delay+0.03},curve="easeOut",startVal=0,endVal=1},{time={delay+0.03,1},curve="linear",startVal=1,endVal=1}}
    return { reverse = true, localPosition={xd,0,bZ+0.1}, localRotation={0,0,0}, localScale={1,1,1}, alpha=0, anchor={type=1,point={0.5,0.5,0}}, animation={localPosition=P, alpha=A} }
end
return { durationScale = 2.0,
    reverse = true, useMultiAspect=false, splitTree={["1:1"]=T},
    global={ showLine=false, lineMaskProgress=0, maskType="line", lineWidth=8, lineColor={0,0,0,1}, lineMask={p1={0.5,0},p2={0.5,1}}, animation={lineMaskProgress={{time={0,0.60},curve="linear",startVal=0,endVal=0},{time={0.60,1},curve="easeIn",startVal=0,endVal=1}}} },
    fragments={ camera_2=F(0.00,0.00,-2.0), camera_1_2=F(0.00,0.15,2.0), camera_1_1=F(0.00,0.30,-2.0) }}
