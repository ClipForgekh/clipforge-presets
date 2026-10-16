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

local FN = 88
local CYCLE = 1.5

local ANIM = {
    x = {
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
    },
    y = {
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.49990721388562,
        0.49960245306544,
        0.49903871957362,
        0.49816170464518,
        0.49688625817205,
        0.49507060177771,
        0.49244791914116,
        0.48839115061749,
        0.47804054054054,
        0.48542296420843,
        0.48869487727063,
        0.4910150686571,
        0.49281284570188,
        0.49425827824783,
        0.4954389319612,
        0.49641613831479,
        0.49722902219849,
        0.49790193390398,
        0.49845610322784,
        0.49890848930322,
        0.49927041024866,
        0.49955053471268,
        0.499756492143,
        0.49989557969151,
        0.49997473283975,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.49990721388562,
        0.49960245306544,
        0.49903871957362,
        0.49816170464518,
        0.49688625817205,
        0.49507060177771,
        0.49244791914116,
        0.48839115061749,
        0.47804054054054,
        0.48542296420843,
        0.48869487727063,
        0.4910150686571,
        0.49281284570188,
        0.49425827824783,
        0.4954389319612,
        0.49641613831479,
        0.49722902219849,
        0.49790193390398,
        0.49845610322784,
        0.49890848930322,
        0.49927041024866,
        0.49955053471268,
        0.499756492143,
        0.49989557969151,
        0.49997473283975,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
    },
    l = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0.00492101591619,
			0.02077402374233,
			0.04960532259284,
			0.09425751971272,
			0.15890978536461,
			0.25022753437303,
			0.3802966669053,
			0.5769835063225,
			1,
			0.85950381742893,
			0.74369864138137,
			0.64302270773756,
			0.55408237975997,
			0.47493642807071,
			0.40428785845899,
			0.34119336618218,
			0.28492856423872,
			0.23491561737251,
			0.19068041709378,
			0.15182540230027,
			0.11801137082971,
			0.08894479017127,
			0.0643686417916,
			0.04405562898821,
			0.02780301914006,
			0.01542864835645,
			0.00676777295163,
			0.00167055082452,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0.00492101591619,
			0.02077402374233,
			0.04960532259284,
			0.09425751971272,
			0.15890978536461,
			0.25022753437303,
			0.3802966669053,
			0.5769835063225,
			1,
			0.85950381742893,
			0.74369864138137,
			0.64302270773756,
			0.55408237975997,
			0.47493642807071,
			0.40428785845899,
			0.34119336618218,
			0.28492856423872,
			0.23491561737251,
			0.19068041709378,
			0.15182540230027,
			0.11801137082971,
			0.08894479017127,
			0.0643686417916,
			0.04405562898821,
			0.02780301914006,
			0.01542864835645,
			0.00676777295163,
			0.00167055082452,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
		},
}



local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript


function SeekModeScript:create (node, data, w, h, scene)
    node.motion = scene:findEntityBy("motion"):getComponent("MeshRenderer").material
    node.light = scene:findEntityBy("light"):getComponent("MeshRenderer").material
    node.blur1t = scene:findEntityBy("blur1t"):getComponent("MeshRenderer").material
    node.blur2t = scene:findEntityBy("blur2t"):getComponent("MeshRenderer").material
    node.blur3t = scene:findEntityBy("blur3t"):getComponent("MeshRenderer").material
    node.blur4t = scene:findEntityBy("blur4t"):getComponent("MeshRenderer").material
    node.blur1n = scene:findEntityBy("blur1n"):getComponent("MeshRenderer").material
    node.blur2n = scene:findEntityBy("blur2n"):getComponent("MeshRenderer").material
    node.rt0 = scene:findEntityBy("blur1t_camera"):getComponent("Camera").renderTexture

    data.intensity = 0.5
end

function SeekModeScript:layout (node, data, w, h)
    node.rt0.width = w
    node.rt0.height = h

    node.motion:setVec2("u_screen_size", Amaz.Vector2f(w, h))

    local s = math.min(w, h) / 720
    node.blur1t:setFloat("u_step_x", s / w)
    node.blur1t:setFloat("u_step_y", s / h)
    node.blur2t:setFloat("u_step_x", s / w)
    node.blur2t:setFloat("u_step_y", s / h)
    node.blur3t:setFloat("u_step_x", s / w)
    node.blur3t:setFloat("u_step_y", s / h)
    node.blur4t:setFloat("u_step_x", s / w)
    node.blur4t:setFloat("u_step_y", s / h)
    node.blur1n:setFloat("u_step_x", s / w)
    node.blur1n:setFloat("u_step_y", s / h)
    node.blur2n:setFloat("u_step_x", s / w)
    node.blur2n:setFloat("u_step_y", s / h)
end

function SeekModeScript:solveTiming (prev, next, q, p)
    local T = 0.3
    if not prev then
        next.s = next.t - T*q
    elseif not next then
        prev.e = prev.t + T*p
    else
        local t = next.t - prev.t
        if t < T then
            prev.e = prev.t + t*0.5
            next.s = next.t - t*0.5
        else
            prev.e = prev.t + T*0.5
            next.s = next.t - T*0.5
        end
    end
end

function SeekModeScript:update (node, data_, w, h, time, duration)
    if not self.timingData then
        if not self.rawTimingData then
            return
        end
        local src = self.rawTimingData
        local dst = {}
        for _, beat in ipairs(src) do
            table.insert(dst, {t = beat})
        end
        local q = step(self.RawHeadTime, self.RawFootTime, self.RawBeatTime)
        local p = 1 - q
        for i = 0, #dst do
            self:solveTiming(dst[i], dst[i+1], q, p)
        end
        self.timingData = dst
    end

    local time0 = self.RawHeadTime
    for _, beat in ipairs(self.timingData) do
        if beat.s <= time and time < beat.e then
            if time < beat.t then
                time0 = mix(self.RawHeadTime, self.RawBeatTime, step(beat.s, beat.t, time))
            else
                time0 = mix(self.RawBeatTime, self.RawFootTime, step(beat.t, beat.e, time))
            end
            break
        end
    end
    self:update0(node, data_, w, h, time0, duration)
end

function SeekModeScript:update0 (node, data, w, h, elapsed, duration)
    local data_intensity = data.intensity * 1.2 * 1
    local data_luminance = data.intensity * 1.2 * 0.34
    local data_range = data.intensity * 1.2 * 1
    local t = clamp(elapsed / CYCLE, 0, 1)

    local f = t * FN
    local i0 = math.floor(f)
    local i1 = math.ceil(f)
    local i = f - i0

    local dx = mix(ANIM.x[i0 + 1], ANIM.x[i1 + 1], i) - 0.5
    local dy = 1 - mix(ANIM.y[i0 + 1], ANIM.y[i1 + 1], i) - 0.5
    local x = 0.5 + dx * data_range
    local y = 0.5 + dy * data_range
    node.motion:setVec2("u_position", Amaz.Vector2f(x, y))

    local lightIntensity = mix(ANIM.l[i0 + 1], ANIM.l[i1 + 1], f - i0)
    node.light:setFloat("u_intensity", 1 + lightIntensity * 1.5 * data_luminance)

    local blurIntensity
    if i0 < 72 then
        blurIntensity = step(8/FN, 17/FN, t) * step(32/FN, 17/FN, t)
    else
        blurIntensity = step(115/FN, 124/FN, t) * step(139/FN, 124/FN, t)
    end
    blurIntensity = blurIntensity * blurIntensity

    local Rt = blurIntensity * data_intensity * 20
    node.blur1t:setFloat("u_intensity", Rt)
    node.blur2t:setFloat("u_intensity", Rt * 0.5)
    node.blur3t:setFloat("u_intensity", Rt * 0.25)
    node.blur4t:setFloat("u_intensity", Rt * 0.125)
    local Rn = blurIntensity * data_intensity * 1
    node.blur1n:setFloat("u_intensity", Rn)
    node.blur2n:setFloat("u_intensity", Rn * 0.5)
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
    ---#ifdef DEV
--//    self.rawTimingData = { 0.8, 1.1, 2.5, 2.8, 4.0, 4.5 }
--//    self.endTime = self.rawTimingData[#self.rawTimingData] + 1
    ---#else
    self.rawTimingData = {999999999999}
    ---#endif
    self.RawHeadTime = 0
    self.RawBeatTime = 0.1955
    self.RawFootTime = 0.391
    return self
end

function SeekModeScript:onStart (comp)
    local scene = comp.entity.scene
    local order = 0
    local layer = 1
    local function setLayerRecursion (node)
        node.entity.layer = order
        for i = 0, node.children:size() - 1 do
            setLayerRecursion(node.children:get(i))
        end
    end
    local nodes = scene:findEntityBy("@Pipeline"):getComponent("Transform").children
    for i = 0, nodes:size() - 1 do
        local node = nodes:get(i)
        local entity = node.entity
        local camera = entity:getComponent("Camera")
        if camera then
            order = order + 1
            layer = layer * 2
            entity.layer = 0
            camera.renderOrder = order
            camera.layerVisibleMask = Amaz.DynamicBitset.new(64, string.format("%#x", layer))
        end
        setLayerRecursion(node)
    end
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
        local intensity = event.args:get(1)
        self.data.intensity = intensity * 1
        self.data.luminance = intensity * 0.34
        self.data.range = intensity * 1
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
    local type = event.args:get(0)
    if type == "time" then
        local dst = {}
        local src = event.args:get(1)
        if src and src:size() > 0 then
            for i = 0, src:size() - 1 do
                table.insert(dst, src:get(i))
            end
        else
            table.insert(dst, 99999999999)
        end
        self.rawTimingData = dst
        self.timingData = nil
    end
    ---#endif
end


local exports = exports or {}
exports.SeekModeScript = SeekModeScript
return exports
