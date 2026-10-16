
local exports = exports or {}
local SystemScript = SystemScript or {}
local face_points_size = 106

local samples = {
    3, 44,
    44, 29,
    4, 45,
    28, 45,
    5, 80,
    81, 27,
    82, 6,
    83, 26,
    37, 38,
    67, 68,
    84, 10,
    90, 22
}


classFilterQueue = 
{
    cycleQueueSize = 0;
    skinColorCycleQueue = {};
    firstPtr = 0;
    lastPtr = -1;

    queueSum = {};
    queueAvg = {};
};

classFilterQueue.meta = {__index = classFilterQueue}

function classFilterQueue:new(size)
    local o = {}
    setmetatable(o, self.meta)

    o.size = size

    for i = 0, size - 1 do
        o.skinColorCycleQueue[i * 3 + 0] = 0
        o.skinColorCycleQueue[i * 3 + 1] = 0
        o.skinColorCycleQueue[i * 3 + 2] = 0
    end

    o.queueSum[0] = 0
    o.queueSum[1] = 0
    o.queueSum[2] = 0

    o.queueAvg[0] = 0
    o.queueAvg[1] = 0
    o.queueAvg[2] = 0

    return o
end

function classFilterQueue:enqueueAndGetAvg(r, g, b, frameId)

    if frameId < self.size then
        self.lastPtr = self.lastPtr + 1
        
        self.skinColorCycleQueue[self.lastPtr * 3 + 0] = r
        self.skinColorCycleQueue[self.lastPtr * 3 + 1] = g
        self.skinColorCycleQueue[self.lastPtr * 3 + 2] = b

        self.queueSum[0] = self.queueSum[0] + r
        self.queueSum[1] = self.queueSum[1] + g
        self.queueSum[2] = self.queueSum[2] + b

        self.queueAvg[0] = self.queueSum[0] / (self.lastPtr - self.firstPtr + 1)
        self.queueAvg[1] = self.queueSum[1] / (self.lastPtr - self.firstPtr + 1)
        self.queueAvg[2] = self.queueSum[2] / (self.lastPtr - self.firstPtr + 1)
    else
        self.queueSum[0] = self.queueSum[0] - self.skinColorCycleQueue[self.firstPtr * 3 + 0] + r
        self.queueSum[1] = self.queueSum[1] - self.skinColorCycleQueue[self.firstPtr * 3 + 1] + g
        self.queueSum[2] = self.queueSum[2] - self.skinColorCycleQueue[self.firstPtr * 3 + 2] + b

        self.firstPtr = (self.firstPtr + 1) % self.size
        self.lastPtr = (self.lastPtr + 1) % self.size

        self.skinColorCycleQueue[self.lastPtr * 3 + 0] = r
        self.skinColorCycleQueue[self.lastPtr * 3 + 1] = g
        self.skinColorCycleQueue[self.lastPtr * 3 + 2] = b

        self.queueAvg[0] = self.queueSum[0] / self.size;
        self.queueAvg[1] = self.queueSum[1] / self.size;
        self.queueAvg[2] = self.queueSum[2] / self.size;
    end

    return self.queueAvg
end

local frameCnt = 0
local queueSize = 8
local filterInstance = classFilterQueue:new(queueSize)

SystemScript.__index = SystemScript

function SystemScript.createRT(width, height)
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = Amaz.FilterMode.FilterMode_LINEAR
    rt.filterMin = Amaz.FilterMode.FilterMode_LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.FilterMode_NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    return rt
end

function SystemScript.new(construct, ...)
    local self = setmetatable({}, SystemScript)
    self.comps = {}
    self.compsdirty = true

    self.Camera_Mask = nil
    self.maskRt = self.createRT(64, 112)
    self.srcRt = self.createRT(64, 112)
    self.cmdBuf1 = Amaz.CommandBuffer()
    return self
end

function SystemScript:constructor()
end

function SystemScript:onComponentAdded(sys, comp)
    if comp:isInstanceOf("Camera") then
        if comp.name == "Camera_camera" then
            self.Camera_Mask = comp
        end
    end
    if (comp:isInstanceOf("MeshRenderer")) then
        self.comps[comp.entity.name] = comp
    end
    -- mesh版本兼容
    self.hlremove = comp.entity.scene:findEntityBy("hlremove")
    self.hlremove1290 = comp.entity.scene:findEntityBy("hlremove1290")
    local version = EffectSdk.getSDKVersion()
    if version >= '12.9.0' then
        self.hlremove.visible = false
        self.hlremove1290.visible = true
    else
        self.hlremove.visible = true
        self.hlremove1290.visible = false
    end
end

function SystemScript:onComponentRemoved(sys, comp)
end

function SystemScript:onStart(sys)
    self.cmdBuf1:blit(self.Camera_Mask.renderTexture, self.maskRt)
    self.cmdBuf1:blit(sys.scene:getInputTexture(Amaz.BuiltInTextureType.INPUT0), self.srcRt)
end

function SystemScript:onUpdate(sys,deltaTime)

    local result = Amaz.Algorithm.getAEAlgorithmResult()
    local faceCount = result:getFaceCount()
    if faceCount == 0 then
        return 
    end
    local face106 = result:getFaceBaseInfo(0)
    local positions = Amaz.UInt16Vector()
    for i = 0,11 do 
        local x1 = face106.points_array:get(samples[i*2+1]).x*64
        local y1 = face106.points_array:get(samples[i*2+1]).y*112
        local x2 = face106.points_array:get(samples[i*2+2]).x*64
        local y2 = face106.points_array:get(samples[i*2+2]).y*112
        positions:pushBack((x1+x2)/2)
        positions:pushBack((y1+y2)/2)
    end
    local srcColors = self.srcRt:getPixels(positions)
    local skinColor = Amaz.Vector4f(0.0,0.0,0.0,0.0)
    for i = 0,11 do
        skinColor = skinColor + srcColors:get(i)
    end
    skinColor = skinColor/12.0

    if skinColor.x <= 0 or skinColor.y <= 0 or skinColor.z <= 0 then
        return
    end

    local skinColorFiltered = {0, 0, 0}
    if frameCnt < queueSize then
        skinColorFiltered = filterInstance:enqueueAndGetAvg(skinColor.x, skinColor.y, skinColor.z, frameCnt)
        frameCnt = frameCnt + 1
    else
        skinColorFiltered = filterInstance:enqueueAndGetAvg(skinColor.x, skinColor.y, skinColor.z, frameCnt)
    end

    if self.hlremove.visible then 
        self.comps["hlremove"].material:setVec4("skinColor", Amaz.Vector4f(skinColorFiltered[0], skinColorFiltered[1], skinColorFiltered[2], 0.0))
    end 

    if self.hlremove1290.visible then 
        self.comps["hlremove1290"].material:setVec4("skinColor", Amaz.Vector4f(skinColorFiltered[0], skinColorFiltered[1], skinColorFiltered[2], 0.0))
    end 
    -- Amaz.LOGE("lua-debug", "skin color RGB = "..skinColor.x..", "..skinColor.y..", "..skinColor.z)
    -- Amaz.LOGE("lua-debug", "filtered skin color RGB = "..skinColorFiltered[0]..", "..skinColorFiltered[1]..", "..skinColorFiltered[2])

    sys.scene:commitCommandBuffer(self.cmdBuf1)
end

function SystemScript:onEvent (comp, event)
    local data = event.args:get(0)
    if data == "intensity" then
        local int = event.args:get(1)
        self.comps["hlremove"].material:setFloat("intensity", int)
        self.comps["hlremove1290"].material:setFloat("intensity", int)
        return
    end
    ---#ifdef DEV
--//    if event.type == Amaz.EventType.TOUCH then
--//        if data.type == Amaz.TouchType.TOUCH_BEGAN or data.type == Amaz.TouchType.TOUCH_MOVED then
--//            self.data.intensity = data.x
--//        end
--//    end
    ---#endif
end


exports.SystemScript = SystemScript
return exports
