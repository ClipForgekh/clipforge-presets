---@class AdjustGlow: ScriptComponent
----@field show string [UI(Option={"Result", "Threshold"})]
----@field brightness double [UI(Range={0, 50}, Slider)]
----@field threshold double [UI(Range={0, 1}, Slider)]
----@field thresholdAddColor Color [UI(NoAlpha)]
----@field glowColor Color [UI(NoAlpha)]
----@field glowWidth double [UI(Display="Glow Width", Range={0, 1}, Slider)]
----@field widthX double [UI(Display="Width X", Range={0, 5}, Slider)]
----@field widthY double [UI(Display="Width Y", Range={0, 5}, Slider)]
----@field widthR double [UI(Display="Width Red", Range={0, 5}, Slider)]
----@field widthG double [UI(Display="Width Green", Range={0, 5}, Slider)]
----@field widthB double [UI(Display="Width Blue", Range={0, 5}, Slider)]
----@field combine string [UI(Option={"Screen", "Add", "Mult", "Difference", "Overlay"})]
----@field edgeMode string [UI(Option={"Transparent", "Reflect"})]
----@field glowFromAlpha double [UI(Range={0, 1}, Slider)]
----@field glowUnderSource double [UI(Range={0, 1}, Slider)]
----@field sourceOpacity double [UI(Range={0, 1}, Slider)]
----@field bgTexture Texture2D [UI(Type="Texture2D")]
----@field lightBackground double [UI(Range={0, 1}, Slider)]
----@field bgBrightness double [UI(Range={0, 1}, Slider)]
----@field quality double [UI(Range={0, 1}, Slider)]

local exports = exports or {}
local AdjustGlow = AdjustGlow or {}
AdjustGlow.__index = AdjustGlow

local Combine = {
    Screen = 0, Add = 1, Mult = 2, Difference = 3, Overlay = 4
}
local EdgeMode = {
    Transparent = 0, Reflect = 1
}

function AdjustGlow.new(construct, ...)
    local self = setmetatable({}, AdjustGlow)

    if construct and AdjustGlow.constructor then AdjustGlow.constructor(self, ...) end
    self.threshold = 0.5
    self.thresholdAddColor = Amaz.Color(0., 0., 0.)
    self.glowWidth = 0.1
    self.widthX = 1.
    self.widthY = 1.
    self.widthR = 1.
    self.widthG = 1.2
    self.widthB = 1.4
    self.brightness = 2.
    self.glowColor = Amaz.Color(1., 1., 1.)
    self.combine = "Screen"
    self.edgeMode = "Reflect"
    self.glowFromAlpha = 0.
    self.glowUnderSource = 0.
    self.sourceOpacity = 1.
    self.bgTexture = nil
    self.lightBackground = 0.0
    self.bgBrightness = 1.0
    self.show = "Result"
    self.quality = 0.2
    return self
end

function AdjustGlow:constructor()
end

function AdjustGlow:onStart(comp)
    self.outputTex = comp.properties:get('outputTex')
    self.blurTex = comp.properties:get('blurTex')
    self.camMask = comp.entity.scene:findEntityBy("MaskCamera"):getComponent("Camera")
    self.camHorzBlurEntity = comp.entity.scene:findEntityBy("BlurHorzCamera")
    self.camVertBlurEntity = comp.entity.scene:findEntityBy("BlurVertCamera")
    self.camHorzBlurEntity2 = comp.entity.scene:findEntityBy("BlurHorzCamera_2")
    self.camVertBlurEntity2 = comp.entity.scene:findEntityBy("BlurVertCamera_2")
    self.camBlendEntity = comp.entity.scene:findEntityBy("BlendCamera")
    self.matMask = comp.entity.scene:findEntityBy("PassMask"):getComponent("MeshRenderer").material
    self.matHorzBlur = comp.entity.scene:findEntityBy("PassHorzBlur"):getComponent("MeshRenderer").material
    self.matVertBlur = comp.entity.scene:findEntityBy("PassVertBlur"):getComponent("MeshRenderer").material
    self.matHorzBlur2 = comp.entity.scene:findEntityBy("PassHorzBlur_2"):getComponent("MeshRenderer").material
    self.matVertBlur2 = comp.entity.scene:findEntityBy("PassVertBlur_2"):getComponent("MeshRenderer").material
    self.matBlend = comp.entity.scene:findEntityBy("BlendPass"):getComponent("MeshRenderer").material
    self.camHorzBlur = self.camHorzBlurEntity:getComponent("Camera")
    self.camVertBlur = self.camVertBlurEntity:getComponent("Camera")
    self.camHorzBlur2 = self.camHorzBlurEntity2:getComponent("Camera")
    self.camVertBlur2 = self.camVertBlurEntity2:getComponent("Camera")
end

local function clamp(val, min, max)
    return math.max(math.min(val, max), min)
end

function AdjustGlow:onEvent(comp, event)
    if event.type == Amaz.AppEventType.SetEffectIntensity then
        local props = comp.entity:getComponent("ScriptComponent").properties
        local value = event.args:get(1)
        if ("Brightness" == event.args:get(0)) then
            if props:has("brightness") then
                props:set("brightness", clamp(value, 0.0, 5.0))
            end
        elseif ("Threshold" == event.args:get(0)) then
            if props:has("threshold") then
                props:set("threshold", clamp(value, 0.0, 1.0))
            end
        elseif ("ThresholdAddColor" == event.args:get(0)) then
            if props:has("thresholdAddColor") then
                local thresholdAddColor = props:get("thresholdAddColor")
                thresholdAddColor.r = value:get(0) / 255.0
                thresholdAddColor.g = value:get(1) / 255.0
                thresholdAddColor.b = value:get(2) / 255.0
                props:set("thresholdAddColor", thresholdAddColor)
            end
        elseif ("GlowColor" == event.args:get(0)) then
            if props:has("glowColor") then
                local glowColor = props:get("glowColor")
                glowColor.r = value:get(0) / 255.0
                glowColor.g = value:get(1) / 255.0
                glowColor.b = value:get(2) / 255.0
                props:set("glowColor", glowColor)
            end
        elseif ("GlowWidth" == event.args:get(0)) then
            if props:has("glowWidth") then
                props:set("glowWidth", clamp(value, 0.0, 1.0))
            end
        elseif ("WidthX" == event.args:get(0)) then
            if props:has("widthX") then
                props:set("widthX", clamp(value, 0.0, 5.0))
            end
        elseif ("WidthY" == event.args:get(0)) then
            if props:has("widthY") then
                props:set("widthY", clamp(value, 0.0, 5.0))
            end
        elseif ("WidthRed" == event.args:get(0)) then
            if props:has("widthR") then
                props:set("widthR", clamp(value, 0.0, 5.0))
            end
        elseif ("WidthGreen" == event.args:get(0)) then
            if props:has("widthG") then
                props:set("widthG", clamp(value, 0.0, 5.0))
            end
        elseif ("WidthBlue" == event.args:get(0)) then
            if props:has("widthB") then
                props:set("widthB", clamp(value, 0.0, 5.0))
            end
        elseif ("Combine" == event.args:get(0)) then
            if props:has("combine") then
                if value == 0 then props:set("combine", "Screen")
                elseif value == 1 then props:set("combine", "Add")
                elseif value == 2 then props:set("combine", "Mult")
                elseif value == 3 then props:set("combine", "Difference")
                elseif value == 4 then props:set("combine", "Overlay")
                else props:set("combine", "Screen") end
            end
        elseif ("EdgeMode" == event.args:get(0)) then
            if props:has("edgeMode") then
                if value == 0 then props:set("edgeMode", "Transparent")
                elseif value == 1 then props:set("edgeMode", "Reflect")
                else props:set("edgeMode", "Reflect") end
            end
        elseif ("GlowFromAlpha" == event.args:get(0)) then
            if props:has("glowFromAlpha") then
                props:set("glowFromAlpha", clamp(value, 0.0, 1.0))
            end
        elseif ("GlowUnderSource" == event.args:get(0)) then
            if props:has("glowUnderSource") then
                props:set("glowUnderSource", clamp(value, 0.0, 1.0))
            end
        elseif ("SourceOpacity" == event.args:get(0)) then
            if props:has("sourceOpacity") then
                props:set("sourceOpacity", clamp(value, 0.0, 1.0))
            end
        elseif ("LightBackground" == event.args:get(0)) then
            if props:has("lightBackground") then
                props:set("lightBackground", clamp(value, 0.0, 1.0))
            end
        elseif ("Show" == event.args:get(0)) then
            if props:has("show") then
                if value == 0 then props:set("show", "Result")
                elseif value == 1 then props:set("show", "Threshold")
                else props:set("show", "Result") end
            end
        elseif ("Quality" == event.args:get(0)) then
            if props:has("quality") then
                props:set("quality", clamp(value, 0.0, 1.0))
            end
        end
    end
end

function AdjustGlow:onUpdate(comp, deltaTime)
    -- local props = comp.entity:getComponent("ScriptComponent").properties
    -- if props:has("brightness") then
    --     self.brightness = props:get("brightness")
    -- end
    -- if props:has("threshold") then
    --     self.threshold = props:get("threshold")
    -- end
    -- if props:has("thresholdAddColor") then
    --     self.thresholdAddColor = props:get("thresholdAddColor")
    -- end
    -- if props:has("glowWidth") then
    --     self.glowWidth = props:get("glowWidth")
    -- end
    -- if props:has("widthX") then
    --     self.widthX = props:get("widthX")
    -- end
    -- if props:has("widthY") then
    --     self.widthY = props:get("widthY")
    -- end
    -- if props:has("widthR") then
    --     self.widthR = props:get("widthR")
    -- end
    -- if props:has("widthG") then
    --     self.widthG = props:get("widthG")
    -- end
    -- if props:has("widthB") then
    --     self.widthB = props:get("widthB")
    -- end
    -- if props:has("glowColor") then
    --     self.glowColor = props:get("glowColor")
    -- end
    -- if props:has("combine") then
    --     self.combine = props:get("combine")
    -- end
    -- if props:has("edgeMode") then
    --     self.edgeMode = props:get("edgeMode")
    -- end
    -- if props:has("glowFromAlpha") then
    --     self.glowFromAlpha = props:get("glowFromAlpha")
    -- end
    -- if props:has("glowUnderSource") then
    --     self.glowUnderSource = props:get("glowUnderSource")
    -- end
    -- if props:has("sourceOpacity") then
    --     self.sourceOpacity = props:get("sourceOpacity")
    -- end
    -- if props:has("lightBackground") then
    --     self.lightBackground = props:get("lightBackground")
    -- end
    -- if props:has("bgBrightness") then
    --     self.bgBrightness = props:get("bgBrightness")
    -- end
    -- if props:has("show") then
    --     self.show = props:get("show")
    -- end
    -- if props:has("quality") then
    --     self.quality = props:get("quality")
    -- end

    local isShowResult = self.show == 'Result'
    self.camHorzBlurEntity.visible = isShowResult
    self.camVertBlurEntity.visible = isShowResult
    self.camHorzBlurEntity2.visible = isShowResult
    self.camVertBlurEntity2.visible = isShowResult
    self.camBlendEntity.visible = isShowResult
    if isShowResult then
        self.camMask.renderTexture = self.blurTex
    else
        self.camMask.renderTexture = self.outputTex
    end

    self.matMask:setFloat("glowFromAlpha", self.glowFromAlpha)
    self.matMask:setFloat("threshold", self.threshold)
    self.matMask:setVec3("color", Amaz.Vector3f(self.thresholdAddColor.r, self.thresholdAddColor.g, self.thresholdAddColor.b))

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if w > 360 then
        h = h / w * 360
        w = 360
    end
    local radius = self.glowWidth * w
    -- Amaz.LOGS('tqh-log radius: ', '' .. radius)
    local widthXR = (radius * self.widthX * self.widthR)
    local widthXG = (radius * self.widthX * self.widthG)
    local widthXB = (radius * self.widthX * self.widthB)
    local widthYR = (radius * self.widthY * self.widthR)
    local widthYG = (radius * self.widthY * self.widthG)
    local widthYB = (radius * self.widthY * self.widthB)
    -- local blurDegree = radius / math.max(w, h)
    self.camHorzBlur.renderTexture.width  = math.floor(w)
    self.camHorzBlur.renderTexture.height = math.floor(h)
    self.camVertBlur.renderTexture.width  = math.floor(w)
    self.camVertBlur.renderTexture.height = math.floor(h)
    self.camHorzBlur2.renderTexture.width  = math.floor(w)
    self.camHorzBlur2.renderTexture.height = math.floor(h)
    self.camVertBlur2.renderTexture.width  = math.floor(w)
    self.camVertBlur2.renderTexture.height = math.floor(h)
    local colorRadiusX = Amaz.Vector3f(widthXR, widthXG, widthXB)
    local colorRadiusY = Amaz.Vector3f(widthYR, widthYG, widthYB)
    self.matHorzBlur:setVec3("ColorRadius", colorRadiusX)
    self.matVertBlur:setVec3("ColorRadius", colorRadiusY)
    self.matHorzBlur:setFloat("MaxRadius", 10+math.floor(100*self.quality)) -- w / 2
    self.matVertBlur:setFloat("MaxRadius", 10+math.floor(100*self.quality)) -- h / 2
    self.matHorzBlur2:setVec3("ColorRadius", colorRadiusX)
    self.matVertBlur2:setVec3("ColorRadius", colorRadiusY)
    self.matHorzBlur2:setFloat("MaxRadius", 10+100*self.quality) -- w / 2
    self.matVertBlur2:setFloat("MaxRadius", 10+100*self.quality) -- h / 2
    local colorSigmaX = colorRadiusX / 2.4
    local colorSigmaY = colorRadiusY / 2.4
    colorSigmaX.x = math.pow(colorSigmaX.x, 2) * 2.0
    colorSigmaX.y = math.pow(colorSigmaX.y, 2) * 2.0
    colorSigmaX.z = math.pow(colorSigmaX.z, 2) * 2.0
    colorSigmaY.x = math.pow(colorSigmaY.x, 2) * 2.0
    colorSigmaY.y = math.pow(colorSigmaY.y, 2) * 2.0
    colorSigmaY.z = math.pow(colorSigmaY.z, 2) * 2.0
    self.matHorzBlur:setVec3("ColorSigma", colorSigmaX)
    self.matVertBlur:setVec3("ColorSigma", colorSigmaY)
    self.matHorzBlur:setFloat("threshold", self.threshold)
    self.matVertBlur:setFloat("threshold", self.threshold)
    self.matHorzBlur:setInt("edgeMode", EdgeMode[self.edgeMode])
    self.matVertBlur2:setInt("edgeMode", EdgeMode[self.edgeMode])
    self.matHorzBlur2:setVec3("ColorSigma", colorSigmaX)
    self.matVertBlur2:setVec3("ColorSigma", colorSigmaY)
    self.matHorzBlur2:setFloat("threshold", self.threshold)
    self.matVertBlur2:setFloat("threshold", self.threshold)
    self.matHorzBlur2:setInt("edgeMode", EdgeMode[self.edgeMode])
    self.matVertBlur:setInt("edgeMode", EdgeMode[self.edgeMode])
    self.matBlend:setFloat("brightness", self.brightness)
    self.matBlend:setFloat("threshold", self.threshold)
    self.matBlend:setVec3("GlowColor", Amaz.Vector3f(self.glowColor.r, self.glowColor.g, self.glowColor.b))
    self.matBlend:setInt("combine", Combine[self.combine])
    -- Amaz.LOGS('tqh-log combine: ', self.combine)
    self.matBlend:setFloat("glowUnderSource", self.glowUnderSource)
    self.matBlend:setFloat("sourceOpacity", self.sourceOpacity)
    -- Amaz.LOGS('tqh-log hasBgTex: ', tostring(self.bgTexture))
    if self.bgTexture then
        self.matBlend:setInt("hasBgTex", 1)
        self.matBlend:setTex("bgTexture", self.bgTexture)
        self.matBlend:setVec2("bgTextureSize", Amaz.Vector2f(self.bgTexture.width, self.bgTexture.height))
    else
        self.matBlend:setInt("hasBgTex", 0)
    end
    self.matBlend:setFloat("lightBackground", self.lightBackground)
    self.matBlend:setFloat("bgBrightness", self.bgBrightness)
end

exports.AdjustGlow = AdjustGlow
return exports
