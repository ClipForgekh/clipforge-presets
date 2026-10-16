local function Log (fmt, ...)
    Amaz.LOGW("jorgen", string.format(fmt, ...))
end
local function clamp (value, min, max)
    return math.min(math.max(min, value), max)
end
local function mix (x, y, a)
    return x + (y - x) * a
end
local function step (edge0, edge1, value)
    return math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
end
local function smoothstep (edge0, edge1, value)
    local t = math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
    return t * t * (3 - t - t)
end
local function mirror (range, value)
    local round = value / range
    local roundF = 1 - math.abs(round % 2 - 1)
    local roundI = math.floor(round)
    return roundF, roundI
end


local ClassFilterQueue = {
    cycleQueueSize = 0;
    skinColorCycleQueue = {};
    firstPtr = 0;
    lastPtr = -1;
    queueSum = {};
    queueAvg = {};
}
ClassFilterQueue.__index = ClassFilterQueue
function ClassFilterQueue.new(size)
    local o = setmetatable({}, ClassFilterQueue)

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
function ClassFilterQueue:enqueueAndGetAvg(r, g, b, frameId)

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


local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript



function SeekModeScript:create (data, scene)
    self.samples = { 3, 44,   44, 29,   4, 45,   28, 45,   5, 80,   81, 27,   82, 6,   83, 26,   37, 38,   67, 68,   84, 10,   90, 22 }
    self.scene = scene
    self.mskRT = self.createRT(64, 112)
    self.srcRT = self.createRT(64, 112)
    self.buf = Amaz.CommandBuffer()
    self.frameCnt = 0
    self.queueSize = 8
    self.filterInstance = ClassFilterQueue.new(self.queueSize)

    self.camera = scene:findEntityBy("camera_filter"):getComponent("Camera")
    self.filter = scene:findEntityBy("filter"):getComponent("MeshRenderer").material
    self.filter:setFloat("hl_det1", 1.2)
    self.filter:setFloat("hl_det2", 0.9)

    self.buf:blit(self.camera.renderTexture, self.mskRT)
    self.buf:blit(scene:getInputTexture(Amaz.BuiltInTextureType.INPUT0), self.srcRT)
end

function SeekModeScript:layout (w, h)
    local s = math.min(w, h) / 720
    w = w / s
    h = h / s
    self.filter:setFloat("u_screenW", w)
    self.filter:setFloat("u_screenH", h)
end

function SeekModeScript:update (data, elapsed, duration)
    self.filter:setFloat("intensity", data.intensity)
    local result = Amaz.Algorithm.getAEAlgorithmResult()
    local faceCount = result:getFaceCount()
    if faceCount == 0 then
        Amaz.LOGE("00000000", "11111111111")
        return
    end
    local samples = self.samples
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
    local srcColors = self.srcRT:getPixels(positions)
    local skinColor = Amaz.Vector4f(0.0,0.0,0.0,0.0)
    for i = 0,11 do
        skinColor = skinColor + srcColors:get(i)
    end
    skinColor = skinColor/12.0

    if skinColor.x <= 0 or skinColor.y <= 0 or skinColor.z <= 0 then
        Amaz.LOGE("00000000", string.format("%.3f %.3f %.3f", skinColor.x, skinColor.y, skinColor.z))
        return
    end

    local skinColorFiltered = {0, 0, 0}
    if self.frameCnt < self.queueSize then
        skinColorFiltered = self.filterInstance:enqueueAndGetAvg(skinColor.x, skinColor.y, skinColor.z, self.frameCnt)
        self.frameCnt = self.frameCnt + 1
    else
        skinColorFiltered = self.filterInstance:enqueueAndGetAvg(skinColor.x, skinColor.y, skinColor.z, self.frameCnt)
    end

    self.filter:setVec4("skinColor", Amaz.Vector4f(skinColorFiltered[0], skinColorFiltered[1], skinColorFiltered[2], 0.0))
    self.scene:commitCommandBuffer(self.buf)
end



function SeekModeScript.new (construct, ...)
    local self = setmetatable({}, SeekModeScript)
    self.w = 0
    self.h = 0
    self.startTime = 0.0
    self.endTime = 10.0
    self.curTime = 0.0
    self.data = {
        intensity = 1
    }
    return self
end

function SeekModeScript:onStart (comp)
    self.w = Amaz.BuiltinObject.getInputTextureWidth()
    self.h = Amaz.BuiltinObject.getInputTextureHeight()
    self:create(self.data, comp.entity.scene)
    self:layout(self.w, self.h)
    self:update(self.data, 0, 1)
end

function SeekModeScript:onUpdate (comp, dt)
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if w ~= self.w or h ~= self.h then
        self.w = w
        self.h = h
        self:layout(w, h)
    end
    local t = self.curTime - self.startTime
    local T = self.endTime - self.startTime
    self:update(self.data, t, T)
    if Editor then
        self.curTime = self.curTime + dt
    end
end

function SeekModeScript:onEvent (comp, event)
    local data = event.args:get(0)
    if data == "intensity" then
        self.data.intensity = event.args:get(1)
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

function SeekModeScript.createRT(width, height)
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


local exports = exports or {}
exports.SeekModeScript = SeekModeScript
return exports
