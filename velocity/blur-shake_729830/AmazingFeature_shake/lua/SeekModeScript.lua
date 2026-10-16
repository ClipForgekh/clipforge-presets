local function mix (a, b, t)
    return a + (b - a) * t
end
local function step (edge0, edge1, value)
    return (value - edge0) / (edge1 - edge0)
end


local exports = exports or {}
local SeekModeScript = SeekModeScript or {}
SeekModeScript.__index = SeekModeScript


function SeekModeScript.new(construct, ...)
    local self = setmetatable({}, SeekModeScript)
    if construct and SeekModeScript.constructor then SeekModeScript.constructor(self, ...) end
    self.startTime = 0.0
    self.endTime = 5.0
    self.curTime = 0.0
    self.width = 0
    self.height = 0
    self.angle = 0
    self.runTime = 0
    self.rotateAngle = 0
    self.rotateSpeed = 30.0
    self.direction = {{-1,-1},{-1,1},{1,1},{1,-1},{0,0}}
    self.intensity = 0.01*0.15    -- zhendong fudu
    self.fps = 5  -- zhendong pinlv
    self.pi = 3.1415926

    ---#ifdef DEV
--//    self.rawTimingData = { 0.8, 1.1, 2.5, 2.8, 4.0, 4.5 }
--//    self.endTime = self.rawTimingData[#self.rawTimingData] + 1
    ---#else
    self.rawTimingData = {999999999999}
    ---#endif
    self.RawHeadTime = 0
    self.RawBeatTime = 1
    self.RawFootTime = 1
    return self
end

function SeekModeScript:constructor()

end

function SeekModeScript:onStart(comp)
    self.material = comp.entity:getComponent("MeshRenderer").material
    self.rotateAngle = self.material:getFloat("rotateAngle")

    if "effects_adjust_speed" == "effects_adjust_speed" then
        local ity = 0.19
        self.rotateSpeed = 90*ity
    end
    if "effects_adjust_range" == "effects_adjust_range" then
        local ity = 0.78
        self.intensity = 0.01*ity
    end
end

function SeekModeScript:onUpdate(comp, detalTime)
    ---#ifdef DEV
--//    if self.dev_seek then
--//        self:update((self.endTime - self.startTime) * self.dev_seek)
--//    else
--//        self:update(self.curTime - self.startTime)
--//    end
--//    self.curTime = self.curTime + detalTime
    ---#else
    self:update(self.curTime - self.startTime)
    ---#endif
end

function SeekModeScript:solveTiming (prev, next, q, p)
    if not prev then
        next.s = -next.t
    elseif not next then
        prev.e = prev.t
    else
        prev.e = prev.t
        next.s = prev.t
    end
end

function SeekModeScript:update (time)
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
    self:update0(time0)
end

function SeekModeScript:update0 (time)
    local id = math.floor(time*self.fps)
    id = math.mod(id,10)+1
    if id>5 then 
        id = 10-id
        if id == 0 then
            id = 5
        end
    end
    
    local x = time * self.rotateSpeed
    self.angle = self.rotateAngle * math.sin(x)
    self.material:setVec2("direction", Amaz.Vector2f(self.direction[id][1]*self.intensity, self.direction[id][2]*self.intensity))
    self.material:setFloat("runtime", self.angle)

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w ~= self.width or h ~= self.height then
        self.width = w
        self.height = h
        self.material:setInt("baseTexWidth", self.width)
        self.material:setInt("baseTexHeight", self.height)
    end
end

function SeekModeScript:onEvent(sys, event)
    if event.args:get(0) == "effects_adjust_intensity" then
        local intensity = event.args:get(1) * 1.2
        self.rotateSpeed = 90*intensity*0.19
        self.intensity = 0.01*intensity*0.78
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

exports.SeekModeScript = SeekModeScript
return exports
