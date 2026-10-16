local exports = exports or {}
local AdjustGlow = AdjustGlow or {}
AdjustGlow.__index = AdjustGlow
---@class AdjustGlow: ScriptComponent
---@field show int [UI(Range={0, 2}, Slider)]
---@field threshold double [UI(Range={0, 1}, Drag)]
---@field radius double [UI(Range={0, 100}, Drag)]
---@field glowIntensity double [UI(Range={0, 4}, Drag)]
---@field blendMode string [UI(Option={"Add", "Multiply", "Difference", "Lighten", "Screen", "Exclusion", "None"})]
---@field glowColor string [UI(Option={"Original", "A&B"})]
---@field colorLooping string [UI(Option={"A>B", "B>A", "A>B>A", "B>A>B"})]
---@field colorLoops double [UI(Range={1, 10}, Drag)]
---@field colorPhase double [UI(Range={0, 360}, Drag)]
---@field midpoint double [UI(Range={0, 1}, Drag)]
---@field colorA Color [UI(NoAlpha)]
---@field colorB Color [UI(NoAlpha)]
---@field glowDimensions string [UI(Option={"Horizontal and Vertical", "Horizontal", "Vertical"})]
---@field InputTex Texture
---@field OutputTex Texture

local BlendModeName = {
    "Add", "Multiply", "Difference", "Lighten", "Screen", "Exclusion", "None"
}
setmetatable(BlendModeName, {__index = function(_, _) return BlendModeName[1] end})

local BlendModeIndex = {}
for index, value in ipairs(BlendModeName) do BlendModeIndex[value] = index - 1 end
setmetatable(BlendModeIndex, {
    __index = function(_, key)
        Amaz.LOGE("AE_LUA_TAG", "Unsupported blend mode: " .. key)
        return 0
    end
})

function AdjustGlow.new(construct, ...)
    local self = setmetatable({}, AdjustGlow)

    if construct and AdjustGlow.constructor then
        AdjustGlow.constructor(self, ...)
    end

    self.InputTex = nil
    self.OutputTex = nil

    self.show = 0
    self.threshold = .6
    self.radius = 10.
    self.glowIntensity = 1.
    self.glowColor = "Original"
    self.colorLooping = "A>B"
    self.blendMode = "Add"
    self.colorLoops = 1
    self.colorPhase = 0
    self.midpoint = 0.5
    self.colorA = Amaz.Color(1., 1., 1.)
    self.colorB = Amaz.Color(0., 0., 0.)
    self.glowDimensions = "Horizontal and Vertical"

    return self
end

function AdjustGlow:constructor()
end

function AdjustGlow:onStart(comp)
    self.matHighlight = comp.entity:searchEntity("PassHighlight"):getComponent("MeshRenderer").material
    self.matHorzBlur = comp.entity:searchEntity("PassHorzBlur1"):getComponent("MeshRenderer").material
    self.matVertBlur = comp.entity:searchEntity("PassVertBlur1"):getComponent("MeshRenderer").material
    self.matOutput = comp.entity:searchEntity("PassOutput"):getComponent("MeshRenderer").material
    self.outputCamera = comp.entity:searchEntity("CameraOutput"):getComponent("Camera")
    self.camHorzBlur = comp.entity:searchEntity("CameraHorzBlur"):getComponent("Camera")
    self.camVertBlur = comp.entity:searchEntity("CameraVertBlur"):getComponent("Camera")
    self.camHighlight = comp.entity:searchEntity("CameraHighlight"):getComponent("Camera")
end

function AdjustGlow:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end

    if "glowColor" == key then
        local glowColor = "Original"
        if value == 1 then glowColor = "A&B" end
        _setEffectAttr(key, glowColor, comp)
    elseif "colorLooping" == key then
        local colorLooping = "A>B"
        if value == 1 then colorLooping = "B>A"
        elseif value == 2 then colorLooping = "A>B>A"
        elseif value == 3 then colorLooping = "B>A>B"
        end
        _setEffectAttr(key, colorLooping, comp)
    elseif key == "blendMode" then
        local blendMode = BlendModeName[value + 1]
        _setEffectAttr(key, blendMode, comp)
    elseif key == "glowDimensions" then
        local glowDimensions = "Horizontal and Vertical"
        if value == 1 then glowDimensions = "Horizontal"
        elseif value == 2 then glowDimensions = "Vertical"
        end
        _setEffectAttr(key, glowDimensions, comp)
    elseif key == "show" then -- for test
        _setEffectAttr(key, math.floor(value), comp)
    elseif key == "threshold"
        or key == "radius"
        or key == "glowIntensity"
        or key == "colorLoops"
        or key == "colorPhase"
        or key == "midpoint"
        or key == "colorA" or key == "colorB"
    then
        _setEffectAttr(key, value, comp)
    end

end

function AdjustGlow:onUpdate(comp, deltaTime)
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if self.OutputTex then
        w = self.OutputTex.width
        h = self.OutputTex.height
    end

    self.matHorzBlur:setVec2("u_outputSize", Amaz.Vector2f(w, h))
    self.matVertBlur:setVec2("u_outputSize", Amaz.Vector2f(w, h))

    self.matHighlight:setTex("u_inputTexture", self.InputTex)
    self.matOutput:setTex("u_inputTexture", self.InputTex)
    self.outputCamera.renderTexture = self.OutputTex

    if self.glowDimensions == "Horizontal" then
        self.camVertBlur.entity.visible = false
        self.camHorzBlur.entity.visible = true

        self.matHorzBlur:setTex("u_inputTexture", self.camHighlight.renderTexture)
        self.matOutput:setTex("u_blurTexture", self.camHorzBlur.renderTexture)
    elseif self.glowDimensions == "Vertical" then
        self.camVertBlur.entity.visible = true
        self.camHorzBlur.entity.visible = false

        self.matVertBlur:setTex("u_inputTexture", self.camHighlight.renderTexture)
        self.matOutput:setTex("u_blurTexture", self.camVertBlur.renderTexture)
    else
        self.camVertBlur.entity.visible = true
        self.camHorzBlur.entity.visible = true

        self.matHorzBlur:setTex("u_inputTexture", self.camHighlight.renderTexture)
        self.matVertBlur:setTex("u_inputTexture", self.camHorzBlur.renderTexture)
        self.matOutput:setTex("u_blurTexture", self.camVertBlur.renderTexture)
    end

    local glowColors = 0
    if self.glowColor == "Original" then
        glowColors = 0
    elseif self.colorLooping == "A>B" or self.colorLooping == "B>A" then
        glowColors = 1
    else
        glowColors = 2
    end

    if glowColors > 0 then
        self.matOutput:setFloat("u_colorLoops", self.colorLoops)
        self.matOutput:setFloat("u_colorPhase", self.colorPhase / 360)
        self.matOutput:setFloat("u_midpoint", self.midpoint)
        self.matOutput:setVec3("u_colorA", Amaz.Vector3f(self.colorA.r, self.colorA.g, self.colorA.b))
        self.matOutput:setVec3("u_colorB", Amaz.Vector3f(self.colorB.r, self.colorB.g, self.colorB.b))
    end

    self.matHighlight:setFloat("u_threshold", self.threshold)
    self.matHighlight:setInt("u_glowColors", glowColors)

    local blurDegree = self.radius / 100 -- 100: the max blur radius
    self.camHorzBlur.renderTexture.width = w * (1. - blurDegree * 0.5)
    self.camHorzBlur.renderTexture.height = h * (1. - blurDegree * 0.5)
    self.camVertBlur.renderTexture.width = w * (1. - blurDegree * 0.5)
    self.camVertBlur.renderTexture.height = h * (1. - blurDegree * 0.5)
    self.matHorzBlur:setFloat("u_horzR", self.radius)
    self.matVertBlur:setFloat("u_vertR", self.radius)
    self.matOutput:setFloat("u_intensity", self.glowIntensity)
    self.matOutput:setInt("u_glowColors", glowColors)
    self.matOutput:setInt("u_show", self.show)
    self.matOutput:setInt("u_blendMode", BlendModeIndex[self.blendMode])
end

exports.AdjustGlow = AdjustGlow
return exports
