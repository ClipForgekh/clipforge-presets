local exports = exports or {}
local Grain = Grain or {}
Grain.__index = Grain
---@class Grain: ScriptComponent
---@field combine string [UI(Option={"Screen", "Add", "Mult", "Overlay", "Film", "Difference"})]
---@field brightness double [UI(Range={-1, 1}, Drag)]
---@field contrast double [UI(Range={-1, 1}, Drag)]
---@field saturation double [UI(Range={0, 1}, Drag)]
---@field grainIntensity double [UI(Range={0, 10}, Drag)]
---@field intensityR double [UI(Range={0, 10}, Drag)]
---@field intensityG double [UI(Range={0, 10}, Drag)]
---@field intensityB double [UI(Range={0, 10}, Drag)]
---@field scale double [UI(Range={0.22, 1}, Drag)]
---@field scaleR double [UI(Range={0.2, 1}, Drag)]
---@field scaleG double [UI(Range={0.2, 1}, Drag)]
---@field scaleB double [UI(Range={0.2, 1}, Drag)]
---@field interval double [UI(Range={0, 1}, Drag)]
---@field monochrome Bool
---@field speed double [UI(Range={0, 1}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture

local Combine = {
    Screen = 0,
    Add = 1,
    Mult = 2,
    Overlay = 3,
    Film = 4,
    Difference = 5
}

local function rangeMapper(value, srcMin, srcMax, dstMin, dstMax)
    return (value - srcMin) * (dstMax - dstMin) / (srcMax - srcMin) + dstMin
end

function Grain.new(construct, ...)
    local self = setmetatable({}, Grain)

    if construct and Grain.constructor then Grain.constructor(self, ...) end

    self.InputTex = nil
    self.OutputTex = nil

    self.combine = 'Film'
    self.grainIntensity = 1.0
    self.intensityR = 1.0
    self.intensityG = 1.0
    self.intensityB = 1.0
    self.scale = 0.3
    self.scaleR = 1
    self.scaleG = 1
    self.scaleB = 1
    self.monochrome = false
    self.speed = 0.1
    self.curTime = 0.0
    self.interval = 0

    return self
end

function Grain:constructor() end

function Grain:onStart(comp)
    self.noiseMat = comp.entity:searchEntity('NoisePass'):getComponent(
                        'MeshRenderer').material
    self.noiseCam = comp.entity:searchEntity('NoiseCamera'):getComponent(
                        'Camera')
end

local function clamp(val, min, max) return math.max(math.min(val, max), min) end

function Grain:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        if self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "combine" then
        local combine = "Screen"
        if value == 1 then
            combine = "Add"
        elseif value == 2 then
            combine = "Mult"
        elseif value == 3 then
            combine = "Overlay"
        elseif value == 4 then
            combine = "Film"
        end
        _setEffectAttr(key, combine)
    else
        _setEffectAttr(key, value)
    end
end

function Grain:onUpdate(comp, deltaTime)
    local props = comp.properties

    local speed = self.curTime * (self.speed / 10)
    -- local speed = self.curTime
    if self.lastTime then
        if self.curTime - self.lastTime >= self.interval or self.curTime <
            self.lastTime then
            self.seed = speed
            self.lastTime = self.curTime
        end
    else
        self.lastTime = self.curTime
        self.seed = speed
    end

    self.noiseMat:setFloat('u_seed', self.seed)
    self.noiseMat:setTex("u_InputTexture", self.InputTex)
    self.noiseCam.renderTexture = self.OutputTex

    self.noiseMat:setFloat('u_intensity', self.grainIntensity / 10)
    self.noiseMat:setFloat('u_intensityR', self.intensityR / 10)
    self.noiseMat:setFloat('u_intensityG', self.intensityG / 10)
    self.noiseMat:setFloat('u_intensityB', self.intensityB / 10)
    self.noiseMat:setFloat('u_scale', self.scale)
    self.noiseMat:setFloat('u_scaleR', self.scaleR)
    self.noiseMat:setFloat('u_scaleG', self.scaleG)
    self.noiseMat:setFloat('u_scaleB', self.scaleB)
    self.noiseMat:setInt('u_monochrome', (self.monochrome and {1} or {0})[1])
    self.noiseMat:setFloat('u_Brightness', self.brightness)
    self.noiseMat:setFloat('u_Contrast', self.contrast)
    self.noiseMat:setFloat('u_Saturation', self.saturation)
    self.noiseMat:setInt('u_combine', Combine[self.combine])
end

exports.Grain = Grain
return exports
