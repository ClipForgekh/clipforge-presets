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


local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript


function SeekModeScript:create (node, data, w, h, scene)
    node.resultMaterial0 = scene:findEntityBy("result"):getComponent("Renderer").material
    node.blur2Material1 = scene:findEntityBy("blur2"):getComponent("Renderer").material
    node.blur3_edgeMaterial2 = scene:findEntityBy("blur3_edge"):getComponent("Renderer").material
    node.surfaceBlurMaterial3 = scene:findEntityBy("surfaceBlur"):getComponent("Renderer").material
    node.blur1Material4 = scene:findEntityBy("blur1"):getComponent("Renderer").material
    node.blur0Material5 = scene:findEntityBy("blur0"):getComponent("Renderer").material

    data.intensity = 1
end

function SeekModeScript:layout (node, data, w, h)
end

function SeekModeScript:update (node, data, w, h, time, duration)
    local data_range = data.intensity * 0.2
    local data_sharp = data.intensity * 0.30
    local data_filter = data.intensity * 0.48
    local data_blur = data.intensity * 0.61
    node.resultMaterial0:setFloat("whiteEdgeIns", mix(2, 0, data_range))
    node.resultMaterial0:setFloat("blackEdgeIns", mix(0, 2, data_range))
    node.blur2Material1:setFloat("blurSize", mix(0, 4.5, data_sharp))
    node.blur3_edgeMaterial2:setFloat("blurSize", mix(0, 4.5, data_sharp))
    node.resultMaterial0:setFloat("filterIns", mix(0, 1, data_filter))
    node.surfaceBlurMaterial3:setFloat("T", mix(0.001, 10, data_blur))
    node.blur1Material4:setFloat("blurSize", mix(0, 0.2, data_blur))
    node.blur0Material5:setFloat("blurSize", mix(0, 0.2, data_blur))
end


function SeekModeScript.new (construct, ...)
    local self = setmetatable({}, SeekModeScript)
    self.w = 0
    self.h = 0
    self.startTime = 0.0
    self.endTime = 5
    self.curTime = 0.0
    self.node = {}
    self.data = {}
    return self
end

function SeekModeScript:onStart (comp)
    self.w = Amaz.BuiltinObject.getInputTextureWidth()
    self.h = Amaz.BuiltinObject.getInputTextureHeight()
    self:create(self.node, self.data, self.w, self.h, comp.entity.scene)
    self:layout(self.node, self.data, self.w, self.h)
    self:update(self.node, self.data, self.w, self.h, 0, 1)
end

function SeekModeScript:onUpdate (comp, dt)
    if Editor then
        self.curTime = self.curTime + dt
    end
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if w ~= self.w or h ~= self.h then
        self.w = w
        self.h = h
        self:layout(self.node, self.data, w, h)
    end
    local t = self.curTime - self.startTime
    local T = self.endTime - self.startTime

    ---#ifdef DEV
--//    if self.dev_seek then
--//        self:update(self.node, self.data, w, h, T * self.dev_seek, T)
--//    else
--//        self:update(self.node, self.data, w, h, t, T)
--//    end
--//    self.curTime = self.curTime + dt
    ---#else
    self:update(self.node, self.data, w, h, t, T)
    ---#endif
end

function SeekModeScript:onEvent(sys, event)
    if event.args:get(0) == "effects_adjust_intensity" then
        self.data.intensity = event.args:get(1) * 2
        return
    end
    ---#ifdef DEV
--//    if event.type == Amaz.EventType.TOUCH then
--//        local pointer = event.args:get(0)
--//        if pointer.type == Amaz.TouchType.TOUCH_BEGAN then
--//            self.dev_seek = pointer.x
--//        elseif pointer.type == Amaz.TouchType.TOUCH_MOVED then
--//            self.dev_seek = pointer.x
--//        elseif pointer.type == Amaz.TouchType.TOUCH_ENDED or pointer.type == Amaz.TouchType.TOUCH_CANCELLED then
--//            if pointer.y > 0.9 then
--//                self.curTime = self.startTime + (self.endTime - self.startTime) * self.dev_seek
--//                self.dev_seek = nil
--//            end
--//        end
--//    end
    ---#else
    ---#endif
end


local exports = exports or {}
exports.SeekModeScript = SeekModeScript
return exports
