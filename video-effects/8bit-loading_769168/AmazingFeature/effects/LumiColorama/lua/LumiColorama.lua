local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiColorama = LumiColorama or {}
LumiColorama.__index = LumiColorama
---@class LumiColorama : ScriptComponent
---@field phaseInputSource string [UI(Option={"Intensity", "Red", "Green", "Blue", "Hue", "Luminosity", "Saturation", "Value", "Alpha", "Zero"})]
---@field phaseExtraSource string [UI(Option={"Intensity", "Red", "Green", "Blue", "Hue", "Luminosity", "Saturation", "Value", "Alpha", "Zero"})]
---@field phaseExtraImage Texture
---@field phaseExtraMode string [UI(Option={"Wrap", "Fix", "Avg", "Screen"})]
---@field phaseShift double [UI(Range={0, 360}, Drag)]
---@field patternProfile string [UI(Option={"None", "AlphaGradient", "HueLoop", "Reverse", "RedGradient", "GreenGradient", "BlueGradient", "GreyGradient", "RGB", "RedOverexposure", "GreenOverexposure", "BlueOverexposure", "GreyOverexposure"})]
---@field patternCount int [UI(Range={1, 6}, Slider)]
---@field patternIndex1 double [UI(Range={0, 360}, Drag)]
---@field patternColor1 Color [UI(NoAlpha)]
---@field patternAlpha1 double [UI(Range={0, 1}, Drag)]
---@field patternIndex2 double [UI(Range={0, 360}, Drag)]
---@field patternColor2 Color [UI(NoAlpha)]
---@field patternAlpha2 double [UI(Range={0, 1}, Drag)]
---@field patternIndex3 double [UI(Range={0, 360}, Drag)]
---@field patternColor3 Color [UI(NoAlpha)]
---@field patternAlpha3 double [UI(Range={0, 1}, Drag)]
---@field patternIndex4 double [UI(Range={0, 360}, Drag)]
---@field patternColor4 Color [UI(NoAlpha)]
---@field patternAlpha4 double [UI(Range={0, 1}, Drag)]
---@field patternIndex5 double [UI(Range={0, 360}, Drag)]
---@field patternColor5 Color [UI(NoAlpha)]
---@field patternAlpha5 double [UI(Range={0, 1}, Drag)]
---@field patternIndex6 double [UI(Range={0, 360}, Drag)]
---@field patternColor6 Color [UI(NoAlpha)]
---@field patternAlpha6 double [UI(Range={0, 1}, Drag)]
---@field patternRepeat double [UI(Range={0, 20}, Drag)]
---@field patternSmooth boolean
---@field outputMode string [UI(Option={"All", "R", "G", "B", "RG", "GB", "RB", "H", "L", "S", "HL", "LS", "HS", "None"})]
---@field outputAlpha boolean
---@field outputAlpha0 boolean
---@field filterMode string [UI(Option={"None", "RGB", "Hue", "Chroma"})]
---@field filterColor Color [UI(NoAlpha)]
---@field filterWidth double [UI(Range={0, 1}, Drag)]
---@field filterSmooth double [UI(Range={0, 1}, Drag)]
---@field maskImage Texture
---@field maskMode string [UI(Option={"None", "Intensity", "Alpha", "ReverseIntensity", "ReverseAlpha})]
---@field maskBlend boolean
---@field inputMix double [UI(Range={0, 1}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture
---@field scale double [UI(Display="Scale", Range={0, 1}, Drag)]

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local function createRenderTexture(width, height, filterMag, filterMin)
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = filterMag or Amaz.FilterMode.LINEAR
    rt.filterMin = filterMin or Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    return rt
end

local function updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then return end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

function LumiColorama.new(construct, ...)
    local self = setmetatable({}, LumiColorama)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.InputTex = nil
    self.OutputTex = nil

    self.phaseInputSource = "Intensity"
    self.phaseExtraSource = "Intensity"
    self.phaseExtraImage = nil
    self.phaseExtraMode = "Wrap"
    self.phaseShift = 0
    self.patternProfile = "None"
    self.patternCount = 6

    self.patternIndex1 = 60
    self.patternColor1 = Amaz.Color(1, 1, 0)
    self.patternAlpha1 = 1
    self.patternIndex2 = 120
    self.patternColor2 = Amaz.Color(0, 1, 0)
    self.patternAlpha2 = 1
    self.patternIndex3 = 180
    self.patternColor3 = Amaz.Color(0, 1, 1)
    self.patternAlpha3 = 1
    self.patternIndex4 = 240
    self.patternColor4 = Amaz.Color(0, 0, 1)
    self.patternAlpha4 = 1
    self.patternIndex5 = 300
    self.patternColor5 = Amaz.Color(1, 0, 1)
    self.patternAlpha5 = 1
    self.patternIndex6 = 0
    self.patternColor6 = Amaz.Color(1, 0, 0)
    self.patternAlpha6 = 1
    self.patternRepeat = 1
    self.patternSmooth = true
    self.outputMode = "All"
    self.outputAlpha = true
    self.outputAlpha0 = false
    self.filterMode = "None"
    self.filterColor = Amaz.Color(1, 0, 0, 1)
    self.filterWidth = 0.5
    self.filterSmooth = 0.0
    self.maskImage = nil
    self.maskMode = "None"
    self.maskBlend = true
    self.inputMix = 0

    self.SOURCE_QUERY = {
        [0] = "Intensity",
        "Red",
        "Green",
        "Blue",
        "Hue",
        "Luminosity",
        "Saturation",
        "Value",
        "Alpha",
        "Zero",
        ["Intensity"] = 0,
        ["Red"] = 1,
        ["Green"] = 2,
        ["Blue"] = 3,
        ["Hue"] = 4,
        ["Luminosity"] = 5,
        ["Saturation"] = 6,
        ["Value"] = 7,
        ["Alpha"] = 8,
        ["Zero"] = 9
    }
    self.OUTPUT_QUERY = {
        [0] = "All",
        "R",
        "G",
        "B",
        "RG",
        "GB",
        "RB",
        "H",
        "L",
        "S",
        "HL",
        "LS",
        "HS",
        "None",
        ["All"] = 0,
        ["R"] = 1,
        ["G"] = 2,
        ["B"] = 3,
        ["RG"] = 4,
        ["GB"] = 5,
        ["RB"] = 6,
        ["H"] = 7,
        ["L"] = 8,
        ["S"] = 9,
        ["HL"] = 10,
        ["LS"] = 11,
        ["HS"] = 12,
        ["None"] = 13
    }
    self.EXTRA_QUERY = {
        [0] = "Wrap",
        "Fix",
        "Avg",
        "Screen",
        ["Wrap"] = 0,
        ["Fix"] = 1,
        ["Avg"] = 2,
        ["Screen"] = 3
    }
    self.PROFILE_QUERY = {
        [0] = "None",
        "AlphaGradient",
        "HueLoop",
        "Reverse",
        "RedGradient",
        "GreenGradient",
        "BlueGradient",
        "GreyGradient",
        "RGB",
        "RedOverexposure",
        "GreenOverexposure",
        "BlueOverexposure",
        "GreyOverexposure",
        ["None"] = 0,
        ["AlphaGradient"] = 1,
        ["HueLoop"] = 2,
        ["Reverse"] = 3,
        ["RedGradient"] = 4,
        ["GreenGradient"] = 5,
        ["BlueGradient"] = 6,
        ["GreyGradient"] = 7,
        ["RGB"] = 8,
        ["RedOverexposure"] = 9,
        ["GreenOverexposure"] = 10,
        ["BlueOverexposure"] = 11,
        ["GreyOverexposure"] = 12
    }
    self.FILTER_QUERY = {
        [0] = "None",
        "RGB",
        "Hue",
        "Chroma",
        ["None"] = 0,
        ["RGB"] = 1,
        ["Hue"] = 2,
        ["Chroma"] = 3
    }
    self.MASK_QUERY = {
        [0] = "None",
        "Intensity",
        "Alpha",
        "ReverseIntensity",
        "ReverseAlpha",
        ["None"] = 0,
        ["Intensity"] = 1,
        ["Alpha"] = 2,
        ["ReverseIntensity"] = 3,
        ["ReverseAlpha"] = 4
    }
    return self
end

function LumiColorama:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "phaseInputSource" or key == "phaseExtraSource" then
        value = math.max(0, math.min(value, #self.SOURCE_QUERY))
        value = self.SOURCE_QUERY[value]
        _setEffectAttr(key, value)
    elseif key == "phaseExtraMode" then
        value = math.max(0, math.min(value, #self.EXTRA_QUERY))
        value = self.EXTRA_QUERY[value]
        _setEffectAttr(key, value)
    elseif key == "patternProfile" then
        value = math.max(0, math.min(value, #self.PROFILE_QUERY))
        value = self.PROFILE_QUERY[value]
        _setEffectAttr(key, value)
    elseif key == "outputMode" then
        value = math.max(0, math.min(value, #self.OUTPUT_QUERY))
        value = self.OUTPUT_QUERY[value]
        _setEffectAttr(key, value)
    elseif key == "filterMode" then
        value = math.max(0, math.min(value, #self.FILTER_QUERY))
        value = self.FILTER_QUERY[value]
        _setEffectAttr(key, value)
    elseif key == "maskMode" then
        value = math.max(0, math.min(value, #self.MASK_QUERY))
        value = self.MASK_QUERY[value]
        _setEffectAttr(key, value)
    else
        _setEffectAttr(key, value)
    end
end

function LumiColorama:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.cam = self.entity:searchEntity("CameraColorama"):getComponent("Camera")
    self.mat = self.entity:searchEntity("PassColorama"):getComponent(
                   "MeshRenderer").material
end

function LumiColorama:onUpdate(comp, deltaTime)
    if self.OutputTex then
        self.mat:setTex("u_inputTexture", self.InputTex)
        self.mat:setInt("u_phaseInputSource",
                        self.SOURCE_QUERY[self.phaseInputSource])
        self.cam.renderTexture = self.OutputTex
    end

    self.mat:setTex("u_extraTexture", self.phaseExtraImage)
    self.mat:setInt("u_phaseExtraMode", self.phaseExtraImage and
                        self.EXTRA_QUERY[self.phaseExtraMode] or 100) -- 100: Disabled
    self.mat:setInt("u_phaseExtraSource",
                    self.SOURCE_QUERY[self.phaseExtraSource])
    self.mat:setFloat("u_phaseShift", self.phaseShift)

    self.mat:setInt("u_outputMode", self.OUTPUT_QUERY[self.outputMode])
    self.mat:setFloat("u_outputAlpha", self.outputAlpha and 1 or 0)
    self.mat:setFloat("u_outputAlpha0", self.outputAlpha0 and 1 or 0)

    self:formatPattern()

    self.mat:setInt("u_filterMode", self.FILTER_QUERY[self.filterMode])
    self.mat:setVec4("u_filterColor", Amaz.Vector4f(self.filterColor.r,
                                                    self.filterColor.g,
                                                    self.filterColor.b, 1))
    self.mat:setFloat("u_filterWidth", self.filterWidth)
    self.mat:setFloat("u_filterSmooth", self.filterSmooth)

    self.mat:setTex("u_maskTexture", self.maskImage)
    self.mat:setInt("u_maskMode", self.MASK_QUERY[self.maskMode])

    self.mat:setFloat("u_maskBlend", self.maskBlend and 1 or 0)
    self.mat:setFloat("u_inputMix", 1 - self.inputMix)
end

function LumiColorama:formatPattern()
    local entries = {}
    if self.patternProfile == "AlphaGradient" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(1, 1, 1, 0)})
        table.insert(entries, {i = 359, c = Amaz.Vector4f(1, 1, 1, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(1, 1, 1, 0)})
    elseif self.patternProfile == "HueLoop" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(1, 0, 0, 1)})
        table.insert(entries, {i = 060, c = Amaz.Vector4f(1, 1, 0, 1)})
        table.insert(entries, {i = 120, c = Amaz.Vector4f(0, 1, 0, 1)})
        table.insert(entries, {i = 180, c = Amaz.Vector4f(0, 1, 1, 1)})
        table.insert(entries, {i = 240, c = Amaz.Vector4f(0, 0, 1, 1)})
        table.insert(entries, {i = 300, c = Amaz.Vector4f(1, 0, 1, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(1, 0, 0, 1)})
    elseif self.patternProfile == "Reverse" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(1, 1, 1, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(0, 0, 0, 1)})
    elseif self.patternProfile == "RedGradient" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(0, 0, 0, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(1, 0, 0, 1)})
    elseif self.patternProfile == "GreenGradient" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(0, 0, 0, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(0, 1, 0, 1)})
    elseif self.patternProfile == "BlueGradient" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(0, 0, 0, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(0, 0, 1, 1)})
    elseif self.patternProfile == "GreyGradient" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(0, 0, 0, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(1, 1, 1, 1)})
    elseif self.patternProfile == "RGB" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(1, 0, 0, 1)})
        table.insert(entries, {i = 120, c = Amaz.Vector4f(0, 1, 0, 1)})
        table.insert(entries, {i = 240, c = Amaz.Vector4f(0, 0, 1, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(1, 0, 0, 1)})
    elseif self.patternProfile == "RedOverexposure" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(0, 0, 0, 1)})
        table.insert(entries, {i = 180, c = Amaz.Vector4f(1, 0, 0, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(0, 0, 0, 1)})
    elseif self.patternProfile == "GreenOverexposure" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(0, 0, 0, 1)})
        table.insert(entries, {i = 180, c = Amaz.Vector4f(0, 1, 0, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(0, 0, 0, 1)})
    elseif self.patternProfile == "BlueOverexposure" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(0, 0, 0, 1)})
        table.insert(entries, {i = 180, c = Amaz.Vector4f(0, 0, 1, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(0, 0, 0, 1)})
    elseif self.patternProfile == "GreyOverexposure" then
        table.insert(entries, {i = 000, c = Amaz.Vector4f(0, 0, 0, 1)})
        table.insert(entries, {i = 180, c = Amaz.Vector4f(1, 1, 1, 1)})
        table.insert(entries, {i = 360, c = Amaz.Vector4f(0, 0, 0, 1)})
    else
        -- Get pattern count
        local count = math.max(math.floor(self.patternCount), 1)

        -- Add each pattern point sequentially
        for i = 1, count do
            table.insert(entries, {
                i = self["patternIndex" .. i] % 360,
                c = Amaz.Vector4f(self["patternColor" .. i].r,
                                  self["patternColor" .. i].g,
                                  self["patternColor" .. i].b,
                                  self["patternAlpha" .. i])
            })
        end

        -- Sort entries by index
        table.sort(entries, function(a, b) return a.i < b.i end)

        -- Add wrap-around points
        local n = #entries
        if entries[1].i > 0 then
            table.insert(entries, 1, {i = 0, c = entries[n].c})
        end
        if entries[n].i < 360 then
            table.insert(entries, {i = 360, c = entries[1].c})
        end
    end

    local index = Amaz.FloatVector()
    local color = Amaz.Vec4Vector()
    for i, e in ipairs(entries) do
        index:pushBack(e.i / 360)
        color:pushBack(e.c)
    end
    self.mat:setFloatVector("u_patternIndex", index)
    self.mat:setVec4Vector("u_patternColor", color)
    self.mat:setInt("u_patternCount", #entries - 1)
    self.mat:setFloat("u_patternRepeat", self.patternRepeat)
    self.mat:setFloat("u_patternSmooth", self.patternSmooth and 1 or 0)
end

exports.LumiColorama = LumiColorama
return exports
