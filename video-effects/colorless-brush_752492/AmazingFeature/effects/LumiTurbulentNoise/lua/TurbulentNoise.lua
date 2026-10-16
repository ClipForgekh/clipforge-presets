local exports = exports or {}
local TurbulentNoise = TurbulentNoise or {}
TurbulentNoise.__index = TurbulentNoise
---@class TurbulentNoise : ScriptComponent
---@field brightness number
---@field contrast number
---@field size number
---@field complexity number
---@field evolution number
---@field cycle int [UI(Range={1, 100}, Slider)]
---@field rotate number
---@field offset_x number
---@field offset_y number
---@field scale_x number
---@field scale_y number
---@field sub_impact number
---@field sub_rotate number
---@field sub_scale number
---@field sub_offset_x number
---@field sub_offset_y number
---@field fractalType string [UI(Option={"TurbulentSpectrum", "TurbulenceFoundation", "TurbulenceDynamics"})]
---@field quality number [UI(Range={0, 1.0}, Slider)]
---@field noiseType string [UI(Option={"Linear", "Block"})]
---@field InputTex Texture
---@field noiseTex Texture
---@field OutputTex Texture

function TurbulentNoise.new(construct, ...)
    local self = setmetatable({}, TurbulentNoise)
    if construct and TurbulentNoise.constructor then
        TurbulentNoise.constructor(self, ...)
    end

    self.InputTex = nil
    -- self.noiseTex = nil
    self.OutputTex = nil

    self.brightness = 0
    self.contrast = 0
    self.size = 0
    self.complexity = 1
    self.evolution = 0
    self.cycle = 100
    self.rotate = 0
    self.offset_x = 0
    self.offset_y = 0
    self.scale_x = 1
    self.scale_y = 1
    self.sub_impact = 0.7
    self.sub_rotate = 0
    self.sub_scale = 0.56
    self.sub_offset_x = 0
    self.sub_offset_y = 0
    self.fractalType = "TurbulentSpectrum"
    self.quality = 0
    self.noiseType = "Linear"

    return self
end

local function createRenderTexture(width, height, is2D)
    local rt = nil
    if is2D then
        rt = Amaz.Texture2D()
    else
        rt = Amaz.RenderTexture()
        rt.depth = 1
        rt.attachment = Amaz.RenderTextureAttachment.DEPTH
    end
    rt.width = width
    rt.height = height
    rt.filterMag = Amaz.FilterMode.LINEAR
    rt.filterMin = Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    return rt
end

local function updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

function TurbulentNoise:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        if self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "noiseType" then
        local noiseType = "Linear"
        if value == 1 then
            noiseType = "Block"
        end
        _setEffectAttr(key, noiseType)
    elseif key == "fractalType" then
        local fractal = "TurbulentSpectrum"
        if value == 1 then
            fractal = "TurbulenceFoundation"
        end
        if value == 2 then
            fractal = "TurbulenceDynamics"
        end
        _setEffectAttr(key, fractal)
    else
        _setEffectAttr(key, value)
    end
end

function TurbulentNoise:onStart(comp)
    self.noiseCamera = comp.entity:searchEntity("cam_Noise"):getComponent("Camera")
    self.noiseMaterial = comp.entity:searchEntity("Noise"):getComponent("MeshRenderer").material
    self.camera = comp.entity:searchEntity("cam_Output"):getComponent("Camera")
    self.material = comp.entity:searchEntity("output"):getComponent("MeshRenderer").material
    self.scale = Amaz.Vector2f(1, 1)
    self.subOffset = Amaz.Vector2f(0., 0.)

    local w, h = self.OutputTex.width, self.OutputTex.height
    self.noiseTex = createRenderTexture(w, h, false)
end

function TurbulentNoise:onUpdate(comp, detalTime)
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end

    if self.noiseTex then
        self.noiseCamera.renderTexture = self.noiseTex
    end

    local w, h = self.OutputTex.width, self.OutputTex.height
    self.quality = math.max(self.quality, 0.01)
    local noiseTexSize = math.ceil(self.quality * 4.0) / 4.0
    updateTexSize(self.noiseTex, noiseTexSize * w, noiseTexSize * h)

    if self.fractalType == "TurbulentSpectrum" then
        self.noiseMaterial:setFloat("u_type", 0.0)
    elseif self.fractalType == "TurbulenceFoundation" then
        self.noiseMaterial:setFloat("u_type", 1.0)
    else
        self.noiseMaterial:setFloat("u_type", 2.0)
    end

    if self.noiseType == "Linear" then
        self.noiseMaterial:setFloat("u_interpolationUVMap", 100.0);
    else
        self.noiseMaterial:setFloat("u_interpolationUVMap", 1000.0);
    end

    self.scale = Amaz.Vector2f(self.scale_x * 10, self.scale_y * 10)
    self.subOffset = Amaz.Vector2f(self.sub_offset_x, self.sub_offset_y)
    self.noiseMaterial:setFloat("u_brightness", self.brightness)
    self.noiseMaterial:setFloat("u_contrast", self.contrast)
    self.noiseMaterial:setVec2("u_scale", self.scale);
    self.noiseMaterial:setFloat("u_complexity", self.complexity);
    self.noiseMaterial:setFloat("u_evolution", math.abs(self.evolution) / 90.0);
    self.noiseMaterial:setFloat("u_cycle", math.max(2, math.floor(self.cycle * 3.0 + 0.5)))
    self.noiseMaterial:setFloat("u_rotate", self.rotate)
    self.noiseMaterial:setVec2("u_offset", Amaz.Vector2f(self.offset_x, self.offset_y))
    self.noiseMaterial:setFloat("u_type", self.type);
    self.noiseMaterial:setFloat("u_subImpact", self.sub_impact)
    self.noiseMaterial:setFloat("u_subRotate", self.sub_rotate)
    self.noiseMaterial:setFloat("u_subScale", self.sub_scale)
    self.noiseMaterial:setVec2("u_subOffset", self.subOffset)
    self.material:setTex("inputImageTexture", self.noiseTex)
end

exports.TurbulentNoise = TurbulentNoise
return exports
