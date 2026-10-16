-- hybrid_01:  + 4
local T = {
    p1 = { 0.0, 0.5 }, p2 = { 1.0, 0.5 },       -- y=0.5 
    -- below (hidePos=1):  y < 0.5 → 
    below = {
        p1 = { 0.5, 0.0 }, p2 = { 0.5, 1.0 },     -- x=0.5 
        -- below (hidePos=1):  x > 0.5 → 
        below = {
            p1 = { 3.0/4.0, 0.0 }, p2 = { 3.0/4.0, 1.0 },
            below = nil,  -- camera_1_1_1  [3/4,1]×[0,0.5)
            above = nil,  -- camera_1_1_2  [1/2,3/4]×[0,0.5)
        },
        -- above (hidePos=0):  x < 0.5 → 
        above = {
            p1 = { 1.0/4.0, 0.0 }, p2 = { 1.0/4.0, 1.0 },
            below = nil,  -- camera_1_2_1  [1/4,1/2]×[0,0.5)
            above = nil,  -- camera_1_2_2  [0,1/4]×[0,0.5)
        },
    },
    -- above (hidePos=0):  y > 0.5 → 
    above = nil,  -- camera_2  [0,1]×[0.5,1]
}

local function F(delay, bZ)
    local t0,t1,t2 = delay, delay+0.35, delay+0.43
    local R = {
        {time={t0,t1}, curve="easeOutExpo", startVal={0,85,0}, endVal={0,0,0}},
        {time={t1,t2}, curve="easeOutBack", startVal={0,0,0},   endVal={0,0,0}},
        {time={t2,1},   curve="linear",     startVal={0,0,0},   endVal={0,0,0}},
    }
    local A = {{time={delay,delay+0.05},curve="easeOut",startVal=0,endVal=1},{time={delay+0.05,1},curve="linear",startVal=1,endVal=1}}
    return { localPosition={0,0,bZ}, localRotation={0,85,0}, localScale={1,1,1}, alpha=0,
        anchor={type=0,point={0.5,0.5,0}}, animation={localRotation=R, alpha=A} }
end
return { useMultiAspect=false, splitTree={["1:1"]=T},
    global={ lineMaskProgress=0, maskType="circle", lineWidth=4, lineColor={0,0,0,1},
        lineMask={p1={0.5,0},p2={0.5,1},center={0.5,0.5}},
        animation={lineMaskProgress={{time={0,0.70},curve="linear",startVal=0,endVal=0},{time={0.70,1},curve="easeIn",startVal=0,endVal=1}}} },
    fragments={ -- →, →
        camera_2     = F(0.00, 0.00),   -- 
        camera_1_2_2 = F(0.15, 0.10),   -- 1
        camera_1_2_1 = F(0.22, 0.20),   -- 2
        camera_1_1_2 = F(0.29, 0.30),   -- 1
        camera_1_1_1 = F(0.36, 0.40),   -- 2
    }}
