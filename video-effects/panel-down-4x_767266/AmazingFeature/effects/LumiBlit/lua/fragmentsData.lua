-- h4_01:  — 
local T = { p1={0,0.5}, p2={1,0.5},
    below={ p1={0,1/4}, p2={1,1/4}, below=nil, above=nil },
    above={ p1={0,3/4}, p2={1,3/4}, below=nil, above=nil } }
local function F(delay, bZ)
    local t0,t1 = delay, delay+0.33
    local P = {
        {time={t0,t1}, curve="easeOutExpo", startVal={0,2.5,bZ+0.18}, endVal={0,0,bZ}},
        {time={t1,1},   curve="linear",      startVal={0,0,bZ},        endVal={0,0,bZ}},
    }
    local A = {{time={delay,delay+0.04},curve="easeOut",startVal=0,endVal=1},{time={delay+0.04,1},curve="linear",startVal=1,endVal=1}}
    return { localPosition={0,2.5,bZ+0.18}, localRotation={0,0,0}, localScale={1,1,1}, alpha=0,
        anchor={type=1,point={0.5,0.5,0}}, animation={localPosition=P, alpha=A} }
end
return { useMultiAspect=false, splitTree={["1:1"]=T},
    global={ lineMaskProgress=0, maskType="line", lineWidth=4, lineColor={0,0,0,1},
        lineMask={p1={0.5,0},p2={0.5,1}},
        animation={lineMaskProgress={{time={0,0.60},curve="linear",startVal=0,endVal=0},{time={0.60,1},curve="easeIn",startVal=0,endVal=1}}} },
    fragments={ camera_2_2=F(0.00,0.30),camera_2_1=F(0.05,0.20),camera_1_2=F(0.10,0.10),camera_1_1=F(0.15,0.00) }}
