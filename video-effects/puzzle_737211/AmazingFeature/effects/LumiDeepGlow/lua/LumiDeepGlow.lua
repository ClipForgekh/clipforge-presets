---@class LumiDeepGlow : ScriptComponent
---@field threshold number [UI(Range={0., 2.}, Drag)]
---@field thresholdSmooth number [UI(Range={0., 1.}, Drag)]
---@field radius number [UI(Range={0., 1000.}, Drag)]
---@field exposure number [UI(Range={0., 10.}, Drag)]
---@field blendMode string [UI(Option={"Add","Screen"})]
---@field view string [UI(Option={"Glow Input","Final Render"})]
---@field sourceOpacity number [UI(Range={0., 1.}, Drag)]
---@field gammaCorrect Bool
---@field unmult Bool
---@field gammaValue number [UI(Range={1., 3.}, Drag)]
---@field glowIntensity number [UI(Range={0., 1.}, Drag)]
---
---@field InputTex Texture
---@field ThresholdTex Texture
---@field OutputTex Texture
local exports = exports or {}
local LumiDeepGlow = LumiDeepGlow or {}
LumiDeepGlow.__index = LumiDeepGlow

------------ util functions ------------
local function clamp(val, min, max) return math.max(math.min(val, max), min) end

------------ class functions for ScriptComponent ------------
function LumiDeepGlow.new(construct, ...)
    local self = setmetatable({}, LumiDeepGlow)

    if construct and LumiDeepGlow.constructor then
        LumiDeepGlow.constructor(self, ...)
    end

    self.__lumi_type = "lumi_effect"
    self.__lumi_rt_pingpong_type = "custom"

    self.radius = 0.
    self.exposure = 0.
    self.threshold = 0.
    self.thresholdSmooth = 0.

    self.blendMode = "Screen"
    self.view = "Final Render"

    self.sourceOpacity = 0.
    self.glowIntensity = 0.

    self.gammaCorrect = true
    self.gammaValue = 2.2
    self.unmult = false

    self.InputTex = nil
    self.ThresholdTex = nil
    self.OutputTex = nil

    return self
end

function LumiDeepGlow:constructor() end

function LumiDeepGlow:onStart(comp)
    self.matThreshold = comp.entity:searchEntity("PassThreshold"):getComponent(
                            "MeshRenderer").material

    self.GlowIter1 = comp.entity:searchEntity("GlowIter_1"):getComponent(
                         "ScriptComponent")
    self.GlowIter2 = comp.entity:searchEntity("GlowIter_2"):getComponent(
                         "ScriptComponent")
    self.GlowIter3 = comp.entity:searchEntity("GlowIter_3"):getComponent(
                         "ScriptComponent")
    self.GlowIter4 = comp.entity:searchEntity("GlowIter_4"):getComponent(
                         "ScriptComponent")
    self.GlowIter5 = comp.entity:searchEntity("GlowIter_5"):getComponent(
                         "ScriptComponent")
    self.GlowIter6 = comp.entity:searchEntity("GlowIter_6"):getComponent(
                         "ScriptComponent")
    self.GlowIter7 = comp.entity:searchEntity("GlowIter_7"):getComponent(
                         "ScriptComponent")
    self.GlowIter8 = comp.entity:searchEntity("GlowIter_8"):getComponent(
                         "ScriptComponent")

    self.matBlend = comp.entity:searchEntity("PassBlend"):getComponent(
                        "MeshRenderer").material
    self.camBlend = comp.entity:searchEntity("CameraBlend"):getComponent(
                        "Camera")

    self.props = comp.properties
end

function LumiDeepGlow:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        if self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "view" then
        local view = "Final Render"
        if value == 0 then view = "Glow Input" end
        _setEffectAttr(key, view)

    elseif key == "blendMode" then
        local blendMode = "Add"
        if value == 1 then blendMode = "Screen" end
        _setEffectAttr(key, blendMode)

    else

        _setEffectAttr(key, value)
    end
end

function LumiDeepGlow:onUpdate(comp, detalTime)
    local exposure
    local glowIntensity
    local radius = self.props:get("radius")
    local gammaValue = self.props:get("gammaValue")
    local ThresholdTex = self.props:get("ThresholdTex")
    local OutputTex = self.props:get("OutputTex")
    if comp.properties:has("exposure") then
        exposure = self.props:get("exposure")
    end

    if comp.properties:has("glowIntensity") then
        glowIntensity = self.props:get("glowIntensity")
    end
    -- Prepare Parms

    local toggle = ( radius > 0)
    self.matBlend:setInt("u_toggle", toggle and 1 or 0)

    -- Texture settings
    self.matThreshold:setTex("u_inputTex", self.props:get("InputTex"))
    self.matThreshold:setFloat("u_threshold", self.props:get("threshold"))
    self.matThreshold:setFloat("u_thresholdSmooth", self.props:get("thresholdSmooth"))
    self.matThreshold:setFloat("u_exposure", exposure)
    self.matThreshold:setInt("u_gamma", self.props:get("gammaCorrect") and 1 or 0)
    self.matThreshold:setFloat("u_gammaValue", gammaValue)

    -- Glow Settings
    local GlowIter1 = Amaz.ScriptUtils.getLuaObj(self.GlowIter1:getScript())
    local GlowIter2 = Amaz.ScriptUtils.getLuaObj(self.GlowIter2:getScript())
    local GlowIter3 = Amaz.ScriptUtils.getLuaObj(self.GlowIter3:getScript())
    local GlowIter4 = Amaz.ScriptUtils.getLuaObj(self.GlowIter4:getScript())
    local GlowIter5 = Amaz.ScriptUtils.getLuaObj(self.GlowIter5:getScript())
    local GlowIter6 = Amaz.ScriptUtils.getLuaObj(self.GlowIter6:getScript())
    local GlowIter7 = Amaz.ScriptUtils.getLuaObj(self.GlowIter7:getScript())
    local GlowIter8 = Amaz.ScriptUtils.getLuaObj(self.GlowIter8:getScript())

    local w = OutputTex.width * 0.5
    local h = OutputTex.height * 0.5
    if ThresholdTex.width ~= w or ThresholdTex.height ~= h then
        ThresholdTex.width = w
        ThresholdTex.height = h
        self.GlowIter1.properties:get("BlurX").width = w
        self.GlowIter1.properties:get("BlurX").height = h
        self.GlowIter1.properties:get("OutputTex").width = w
        self.GlowIter1.properties:get("OutputTex").height = h
        self.GlowIter2.properties:get("OutputTex").width = w
        self.GlowIter2.properties:get("OutputTex").height = h
        self.GlowIter3.properties:get("OutputTex").width = w
        self.GlowIter3.properties:get("OutputTex").height = h
        self.GlowIter4.properties:get("OutputTex").width = w
        self.GlowIter4.properties:get("OutputTex").height = h
        self.GlowIter5.properties:get("OutputTex").width = w
        self.GlowIter5.properties:get("OutputTex").height = h
        self.GlowIter6.properties:get("OutputTex").width = w
        self.GlowIter6.properties:get("OutputTex").height = h
        self.GlowIter7.properties:get("OutputTex").width = w
        self.GlowIter7.properties:get("OutputTex").height = h
        self.GlowIter8.properties:get("OutputTex").width = w
        self.GlowIter8.properties:get("OutputTex").height = h
    end

    local downSample1 = 1
    local downSample2 = 1
    local downSample3 = math.max(math.min(radius / 128, 2.0), 1.0)
    local downSample4 = math.max(math.min(radius / 64, 4.0), 1.0)
    local downSample5 = math.max(radius / 32, 1.0)
    local downSample6 = math.max(radius / 16, 1.0)
    local downSample7 = math.max(radius / 8, 1.0)
    local downSample8 = math.max(radius / 4, 1.0)

    --self.GlowIter1.intensity = radius / 16 * 0.125
    self.GlowIter1.properties:set("intensity", radius / 16 * 0.125)
    self.GlowIter2.properties:set("intensity", radius / 16 * 0.25)
    self.GlowIter3.properties:set("intensity", radius / 16 / downSample3 * 0.5)
    self.GlowIter4.properties:set("intensity", radius / 16 / downSample4)
    self.GlowIter5.properties:set("intensity", radius / downSample5 * 0.125)
    self.GlowIter6.properties:set("intensity", radius / downSample6 * 0.25)
    self.GlowIter7.properties:set("intensity", radius / downSample7 * 0.5)
    self.GlowIter8.properties:set("intensity", radius / downSample8)

    --self.GlowIter1.downSample = downSample1
    self.GlowIter1.properties:set("downSample", downSample1)
    self.GlowIter2.properties:set("downSample", downSample2)
    self.GlowIter3.properties:set("downSample", downSample3)
    self.GlowIter4.properties:set("downSample", downSample4)
    self.GlowIter5.properties:set("downSample", downSample5)
    self.GlowIter6.properties:set("downSample", downSample6)
    self.GlowIter7.properties:set("downSample", downSample7)
    self.GlowIter8.properties:set("downSample", downSample8)

    --self.GlowIter1.gammaValue = gammaValue
    self.GlowIter1.properties:set("gammaValue", gammaValue)

    self.GlowIter2.properties:set("gammaValue", gammaValue)
    self.GlowIter3.properties:set("gammaValue", gammaValue)
    self.GlowIter4.properties:set("gammaValue", gammaValue)
    self.GlowIter5.properties:set("gammaValue", gammaValue)
    self.GlowIter6.properties:set("gammaValue", gammaValue)
    self.GlowIter7.properties:set("gammaValue", gammaValue)
    self.GlowIter8.properties:set("gammaValue", gammaValue)

    -- Blending Options
    if OutputTex then self.camBlend.renderTexture = OutputTex end

    self.matBlend:setTex("u_inputTex", self.props:get("InputTex"))
    self.matBlend:setTex("u_thresholdTex", ThresholdTex)
    self.matBlend:setTex("u_blurTex", self.BlurTex)
    self.matBlend:setFloat("u_srcOpacity", self.props:get("sourceOpacity"))
    self.matBlend:setFloat("u_exposure", exposure)
    self.matBlend:setInt("u_gamma", self.props:get("gammaCorrect") and 1 or 0)
    self.matBlend:setInt("u_unmult", self.props:get("unmult") and 1 or 0)
    self.matBlend:setFloat("u_gammaValue", gammaValue)
    self.matBlend:setFloat("u_glowIntensity", glowIntensity)

    -- View Options
    if self.props:get("view") == "Glow Input" then
        self.matThreshold:setInt("u_viewMode", 0)
        self.matBlend:setInt("u_viewMode", 0)

    elseif self.props:get("view") == "Final Render" then
        self.matThreshold:setInt("u_viewMode", 1)
        self.matBlend:setInt("u_viewMode", 1)

        if self.props:get("blendMode") == "Add" then
            self.matThreshold:setInt("u_blendMode", 0)
            self.matBlend:setInt("u_blendMode", 0)
        elseif self.props:get("blendMode") == "Screen" then
            self.matThreshold:setInt("u_blendMode", 1)
            self.matBlend:setInt("u_blendMode", 1)
        end
    end
end

function LumiDeepGlow:onDestroy(comp) end

function LumiDeepGlow:updateMaterials(comp, detalTime) end

exports.LumiDeepGlow = LumiDeepGlow
return exports
