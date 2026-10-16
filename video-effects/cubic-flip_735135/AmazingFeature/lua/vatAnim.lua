local exports = exports or {}
local vatAnim = vatAnim or {}
vatAnim.__index = vatAnim
---@class vatAnim : ScriptComponent
---@field autoplay boolean
---@field autoplayGap number
---@field frameCount number
---@field _duration number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field gaussSigma number
---@field display_frame number
---@field smoothFrameNumber number
---@field modelUniformScale number
---@field distanceFromScreen number


local util = {}
local json = cjson.new()
local rootDir = nil

local function getBezierValue(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3*xc1*(1-t)*(1-t)*t+3*xc2*(1-t)*t*t+t*t*t
    ret[2] = 3*yc1*(1-t)*(1-t)*t+3*yc2*(1-t)*t*t+t*t*t
    return ret
end

local function getBezierDerivative(controls, t)
    local ret = {}
    local xc1 = controls[1]
    local yc1 = controls[2]
    local xc2 = controls[3]
    local yc2 = controls[4]
    ret[1] = 3*xc1*(1-t)*(1-3*t)+3*xc2*(2-3*t)*t+3*t*t
    ret[2] = 3*yc1*(1-t)*(1-3*t)+3*yc2*(2-3*t)*t+3*t*t
    return ret
end

local function getBezierTfromX(controls, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts+te)/2
        local value = getBezierValue(controls, tm)
        if(value[1]>x) then
            te = tm
        else
            ts = tm
        end
    until(te-ts < 0.0001)

    return (te+ts)/2
end

local function changeVec2ToTable(val)
    return {val.x, val.y}
end

local function changeVec3ToTable(val)
    return {val.x, val.y, val.z}
end

local function changeVec4ToTable(val)
    return {val.x, val.y, val.z, val.w}
end

local function changeCol3ToTable(val)
    return {val.r, val.g, val.b}
end

local function changeCol4ToTable(val)
    return {val.r, val.g, val.b, val.a}
end

local function changeTable2Vec4(t)
    return Amaz.Vector4f(t[1], t[2], t[3], t[4])
end

local function changeTable2Vec3(t)
    return Amaz.Vector3f(t[1], t[2], t[3])
end

local function changeTable2Vec2(t)
    return Amaz.Vector2f(t[1], t[2])
end

local function changeTable2Col3(t)
    return Amaz.Color(t[1], t[2], t[3])
end

local function changeTable2Col4(t)
    return Amaz.Color(t[1], t[2], t[3], t[4])
end

local _typeSwitch = {
    ["vec4"] = function(v)
        return changeVec4ToTable(v)
    end,
    ["vec3"] = function(v)
        return changeVec3ToTable(v)
    end,
    ["vec2"] = function(v)
        return changeVec2ToTable(v)
    end,
    ["float"] = function(v)
        return tonumber(v)
    end,
    ["string"] = function(v)
        return tostring(v)
    end,
    ["col3"] = function(v)
        return changeCol3ToTable(v)
    end,
    ["col4"] = function(v)
        return changeCol4ToTable(v)
    end,

    -- change table to userdata
    ["_vec4"] = function(v)
        return changeTable2Vec4(v)
    end,
    ["_vec3"] = function(v)
        return changeTable2Vec3(v)
    end,
    ["_vec2"] = function(v)
        return changeTable2Vec2(v)
    end,
    ["_float"] = function(v)
        return tonumber(v)
    end,
    ["_string"] = function(v)
        return tostring(v)
    end,
    ["_col3"] = function(v)
        return changeTable2Col3(v)
    end,
    ["_col4"] = function(v)
        return changeTable2Col4(v)
    end,
}

local function typeSwitch()
    return _typeSwitch
end

local function createTableContent()
    local t = {}
    for k,v in pairs(record_t) do
        t[k] = {}
        t[k]["type"] = v["type"]
        t[k]["val"] = v["func"](v["val"])
    end
    return t
end

function util.registerParams(_name, _data, _type)
    record_t[_name] = {
        ["type"] = _type,
        ["val"] = _data,
        ["func"] = _typeSwitch[_type]
    }
end

function util.getRegistedParams()
    return record_t
end

function util.setRegistedVal(_name, _data)
    record_t[_name]["val"] = _data
end

function util.getRootDir()
    if rootDir == nil then
        local str = debug.getinfo(2, "S").source
        rootDir = str:match("@?(.*/)")
    end
    -- Amaz.LOGI("lrc getRootDir 123", tostring(rootDir))
    return rootDir
end

function util.registerRootDir(path)
    rootDir = path
end

function util.bezier(controls)
    local control = controls
    if type(control) ~= "table" then
        control = changeVec4ToTable(controls)
    end
    return function (t, b, c, d)
        t = t/d
        local tvalue = getBezierTfromX(control, t)
        local value =  getBezierValue(control, tvalue)
        return b + c * value[2]
    end
end

function util.remap01(a,b,x)
    if x < a then return 0 end
    if x > b then return 1 end
    return (x-a)/(b-a)
end

function util.remap(smin, smax, dmin, dmax, value)
	return (value - smin) / (smax - smin) * (dmax - dmin) + dmin
end
function util.mix(a, b, x)
    return a * (1-x) + b * x
end

function util.CreateJsonFile(file_path)
    local t = createTableContent()
    local content = json.encode(t)
    local file = io.open(util.getRootDir()..file_path, "w+b")
    if file then
      file:write(tostring(content))
      io.close(file)
    end
end

function util.ReadFromJson(file_path)
    local file = io.input(util.getRootDir()..file_path)
    local json_data = json.decode(io.read("*a"))
    local res = {}
    for k, v in pairs(json_data) do
        local func = _typeSwitch["_"..tostring(v["type"])]
        res[k] = func(v["val"])
    end
    return res
end

function util.bezierWithParams(input_val_4, min_val, max_val, in_val, reverse)
    if type(input_val_4) == "tabke" then
        if reverse == nil then
            return util.bezier(input_val_4)(util.remap01(min_val, max_val, in_val), 0, 1, 1)
        else
            return util.bezier(input_val_4)(1-util.remap01(min_val, max_val, in_val), 0, 1, 1)
        end
    else
        if reverse == nil then
            return util.bezier(util.changeVec4ToTable(input_val_4))(util.remap01(min_val, max_val, in_val), 0, 1, 1)
        else
            return util.bezier(util.changeVec4ToTable(input_val_4))(1-util.remap01(min_val, max_val, in_val), 0, 1, 1)
        end
    end
end


function util.clamp(min, max, value)
	return math.min(math.max(value, min), max)
end

local function getRootDir()
    local rootDir = nil
    if rootDir == nil then
        local str = debug.getinfo(2, "S").source
        rootDir = str:match("@?(.*/)")
    end
    return rootDir
end

local function normpdf(x, sigma)
    return 0.39894 * math.exp(-0.5 * x * x / (sigma * sigma)) / sigma
end

function vatAnim.new(construct, ...)
    local self = setmetatable({}, vatAnim)

    if construct and vatAnim.constructor then
        vatAnim.constructor(self, ...)
    end
    self.progress = 0
    self.curTime = 0
    self.endTime = 0
    self.startTime = 0.1
    self._duration = 3
    self.autoplay = true
    self.playDuration = 2
    self.frameCount = 60
    self.gaussSigma = 0.1
    self.smoothFrameNumber = 10
    self.autoplayGap = 0.5
    self.display_frame = 1
    self.fadeEnable = 1
    self.fadeT = 0.2
    self.modelUniformScale = 65
    self.distanceFromScreen = 0.0
    self.init_z = -17.320

    
    return self
end

function vatAnim:constructor()
end

local isEditor = Amaz.Macros and Amaz.Macros.EditorSDK

function vatAnim:onStart(comp)
    self.entity = comp.entity
    
    local explosion = self.entity:searchEntity("explosion")

    self.explosion_trans = explosion:getComponent("Transform")
    self.explosion_mat = explosion:getComponent("MeshRenderer").material

    self.cam_explosion = self.entity:searchEntity("Cam_VAT"):getComponent("Camera")

    self.prop = comp.properties
    self.rootDir = getRootDir()
    self.rootDir = string.sub(self.rootDir, 1, -5)
end

function vatAnim:_AutoPlay(time)
    local progress = 0
    if isEditor then
        local duration = self._duration 
        if self.autoplay then
            local gap = self.autoplayGap
            progress = time % (duration + gap) / (duration)
            progress = math.min(progress, 1.)
            self.progress = progress
        end
    else
        local duration = (self.endTime - self.startTime)
        progress = util.clamp(0, 1, (time / duration))
    end
end

function vatAnim:onUpdate(comp, detalTime)
    if isEditor then
        self.curTime = self.curTime + detalTime
    end
    --shijiyong
    self:seekToTime(comp, self.curTime - self.startTime)
end

function vatAnim:_UpdateExplosion(progress)
    local frame_count = self.frameCount
    local p = progress
    local display_frame = p * (frame_count - 1)
    display_frame = display_frame + 1
    self.explosion_mat:setFloat("display_frame", display_frame)
    self.explosion_mat:setFloat("frame_count", frame_count)

    self.explosion_mat:setMat4("u_LightSpaceMatrix", self.depth_matrix)
    self.explosion_mat:setFloat("u_Progress", self.progress)


    return display_frame
end

function vatAnim:seekToTime(comp, time)
    self.width = Amaz.BuiltinObject:getInputTextureWidth()
    self.height = Amaz.BuiltinObject:getInputTextureHeight()

    local outputW = Amaz.BuiltinObject:getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject:getOutputTextureHeight()

    self:_AutoPlay(time)

    local p = self.prop:get("progress")
    local fovy = self.cam_explosion.fovy
    local distanceOfZPlane = 1.0 / math.tan(math.rad(fovy / 2.0))
    local ratio = self.width / self.height
    local outRatio = outputW / outputH

    local modelScale = 1.0 / self.modelUniformScale * math.max(ratio, 1.0)
    self.explosion_trans:setWorldPosition(Amaz.Vector3f(0, 0, (-distanceOfZPlane - self.distanceFromScreen * modelScale)))
    self.explosion_trans:setWorldScale(Amaz.Vector3f(modelScale * outRatio / ratio, modelScale, modelScale))

    local display_frame = self:_UpdateExplosion(util.clamp(0, 1, p))
    
    -- local aoTex = self.entity.scene.assetMgr:SyncLoad(self.rootDir..string.format("seq/ao/ao.%04d.png", math.floor(display_frame)))
    -- local aoTex1 = self.entity.scene.assetMgr:SyncLoad(self.rootDir..string.format("seq/ao/ao.%04d.png", math.min(math.floor(display_frame) + 1, self.frameCount - 1)))
    -- self.explosion_mat:setTex("normalBake", aoTex)
    self.explosion_mat:setFloat("u_imageScale", self.prop:get("imageScale"))
    -- self.explosion_mat:setTex("normalBake1", aoTex1)
    self.explosion_mat:setVec2("u_ratio", Amaz.Vector2f(math.max(self.height/self.width, 1.0), math.max(self.width/self.height, 1.0)))
end


function vatAnim:onEvent(sys,event)

end

exports.vatAnim = vatAnim
return exports
