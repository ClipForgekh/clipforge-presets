local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiBlobbylize = LumiBlobbylize or {}
LumiBlobbylize.__index = LumiBlobbylize
---@class LumiBlobbylize : ScriptComponent
---@field maskProperty string [UI(Option={"R", "G", "B", "A", "Luminance", "Lightness"})]
---@field maskEdgeMode int [UI(Option={"Clamp", "Repeat", "Mirror", "Transparent", "Stretch"})]
---@field blurSteps int [UI(Range={1, 500}, Drag)]
---@field blurStride number [UI(Range={0, 1}, Drag)]
---@field cutAway number [UI(Range={0, 100}, Drag)]
---@field cutAwayFade number [UI(Range={0, 10}, Drag)]
---@field height number [UI(Range={0, 200}, Drag)]
---@field displacement number [UI(Range={0, 500}, Drag)]

---@field lightMode string [UI(Option={"Distant", "Point"})]
---@field lightColor Color [UI(NoAlpha)]
---@field lightPosition Vector2f
---@field lightHeight number [UI(Range={0, 100}, Drag)]
---@field lightAngle number [UI(Range={-360, 360}, Drag)]
---@field lightIntensity number [UI(Range={0, 10}, Drag)]

---@field ambient number [UI(Range={0, 2}, Drag)]
---@field diffuse number [UI(Range={0, 1}, Drag)]
---@field specular number [UI(Range={0, 1}, Drag)]
---@field roughness number [UI(Range={0.001, 0.5}, Drag)]
---@field metallic number [UI(Range={0, 1}, Drag)]

---@field quality number [UI(Range={0, 1}, Drag)]

---@field InputTex Texture
---@field layerTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local function createRenderTexture(width, height, filterMag, filterMin)
    local rt = Amaz.RenderTexture()
    rt.width = width or 4
    rt.height = height or 4
    rt.depth = 1
    rt.filterMag = filterMag or Amaz.FilterMode.LINEAR
    rt.filterMin = filterMin or Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
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

local function setRenderTexture(camera, rt)
    if rt then
        camera.renderTexture = rt
    end
end

local function mix(a, b, t)
    return a + (b - a) * t
end

function LumiBlobbylize.new(construct, ...)
    local self = setmetatable({}, LumiBlobbylize)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.maskProperty = "Lightness"
    self.maskPropertyQuery = {
        [0] = "R",
        "G",
        "B",
        "A",
        "Luminance",
        "Lightness",
        ["R"] = 0,
        ["G"] = 1,
        ["B"] = 2,
        ["A"] = 3,
        ["Luminance"] = 4,
        ["Lightness"] = 5
    }
    self.maskEdgeMode = "Mirror"
    self.maskEdgeModeQuery = {
        [0] = "Clamp",
        "Repeat",
        "Mirror",
        "Transparent",
        "Stretch",
        ["Clamp"] = 0,
        ["Repeat"] = 1,
        ["Mirror"] = 2,
        ["Transparent"] = 3,
        ["Stretch"] = 4
    }

    self.blurSteps = 25
    self.blurStride = 0.3

    self.height = 25
    self.cutAway = 0
    self.cutAwayFade = 0
    self.wrapMode = 0
    self.displacement = 300

    self.ambient = 0.75
    self.diffuse = 0.25
    self.specular = 1.0
    self.metallic = 1.0
    self.roughness = 0.025
    self.lightMode = "Distant"
    self.lightModeQuery = {
        [0] = "Distant",
        "Point",
        ["Distant"] = 0,
        ["Point"] = 1
    }
    self.lightColor = Amaz.Color(1.0, 1.0, 1.0)
    self.lightPosition = Amaz.Vector2f(0.5, 0.5)
    self.lightHeight = 65
    self.lightAngle = -45
    self.lightIntensity = 1.0

    self.quality = 1.0

    self.InputTex = nil
    self.layerTex = nil
    self.OutputTex = nil

    return self
end

function LumiBlobbylize:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "lightMode" then
        value = math.max(0, math.min(value, #self.lightModeQuery))
        value = self.lightModeQuery[value]
        _setEffectAttr(key, value)
    elseif key == "maskProperty" then
        value = math.max(0, math.min(value, #self.maskPropertyQuery))
        value = self.maskPropertyQuery[value]
        _setEffectAttr(key, value)
    elseif key == "maskEdgeMode" then
        value = math.max(0, math.min(value, #self.maskEdgeModeQuery))
        value = self.maskEdgeModeQuery[value]
        _setEffectAttr(key, value)
    elseif key == "lightPosition" then
        _setEffectAttr(key, value)
    elseif key == "layerTex" then
        _setEffectAttr(key, value, true)
    else
        _setEffectAttr(key, value)
    end
end

function LumiBlobbylize:initializeComponents(name, isXform)
    local cameraEntityName = "Cam" .. name
    local meshEntityName = "Pass" .. name

    local camera = self.entity:searchEntity(cameraEntityName):getComponent("Camera")
    local meshRenderer = self.entity:searchEntity(meshEntityName):getComponent("MeshRenderer")
    local transform = isXform and self.entity:searchEntity(meshEntityName):getComponent("Transform")

    return camera, meshRenderer and meshRenderer.material, transform
end

function LumiBlobbylize:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.camMask, self.matMask, self.transformMask = self:initializeComponents("Mask", true)
    self.camBlurX, self.matBlurX = self:initializeComponents("BlurX", false)
    self.camBlurY, self.matBlurY = self:initializeComponents("BlurY", false)
    self.camBlurX2, self.matBlurX2 = self:initializeComponents("BlurX_2", false)
    self.camBlurY2, self.matBlurY2 = self:initializeComponents("BlurY_2", false)
    self.camLight, self.matLight = self:initializeComponents("Light", false)

    -- self.maskRT = createRenderTexture()
    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.maskRT = self.lumiSharedRt:get(0)
    end

    self.tempRT0 = createRenderTexture()
    self.tempRT1 = createRenderTexture()
end

function LumiBlobbylize:onUpdate(comp, deltaTime)
    if not self.OutputTex then
        return
    end
    -- Texture Settings
    local w, h = self.OutputTex.width, self.OutputTex.height
    local minEdge = math.min(w, h)
    local maxEdge = math.max(w, h)
    local scaledW = w * self.quality
    local scaledH = h * self.quality

    local maskTex = self.layerTex or self.OutputTex
    local maskW = self.maskEdgeMode == "Stretch" and w or maskTex.width
    local maskH = self.maskEdgeMode == "Stretch" and h or maskTex.height

    -- Set shader properties
    updateTexSize(self.maskRT, w, h)
    updateTexSize(self.tempRT0, scaledW, scaledH)
    updateTexSize(self.tempRT1, scaledW, scaledH)

    setRenderTexture(self.camMask, self.maskRT)
    setRenderTexture(self.camBlurX, self.tempRT0)
    setRenderTexture(self.camBlurY, self.tempRT1)
    setRenderTexture(self.camBlurX2, self.tempRT0)
    setRenderTexture(self.camBlurY2, self.tempRT1)
    setRenderTexture(self.camLight, self.OutputTex)

    self.matMask:setTex("u_inputTexture", self.layerTex or self.InputTex)
    self.matMask:setVec2("u_inputSize", Amaz.Vector2f(maskW, maskH))
    self.matMask:setInt("u_edgeMode", self.maskEdgeModeQuery[self.maskEdgeMode])
    self.matMask:setInt("u_property", self.maskPropertyQuery[self.maskProperty])

    self.matBlurX:setTex("u_inputTexture", self.maskRT)
    self.matBlurY:setTex("u_inputTexture", self.tempRT0)
    self.matBlurX2:setTex("u_inputTexture", self.tempRT1)
    self.matBlurY2:setTex("u_inputTexture", self.tempRT0)

    -- Blur Settings
    local steps = math.max(self.blurSteps * 3, 1)
    local stride = self.blurStride
    self.matBlurX:setInt("u_steps", steps)
    self.matBlurX:setFloat("u_stride", stride)
    self.matBlurX:setFloat("u_angle", math.rad(0))
    self.matBlurY:setInt("u_steps", steps)
    self.matBlurY:setFloat("u_stride", stride)
    self.matBlurY:setFloat("u_angle", math.rad(90))

    self.matBlurX2:setInt("u_steps", steps)
    self.matBlurX2:setFloat("u_stride", stride)
    self.matBlurX2:setFloat("u_angle", math.rad(0))
    self.matBlurY2:setInt("u_steps", steps)
    self.matBlurY2:setFloat("u_stride", stride)
    self.matBlurY2:setFloat("u_angle", math.rad(90))

    -- Light Settings
    self.matLight:setInt("u_wrapMode", self.wrapMode)
    self.matLight:setTex("u_inputTexture", self.InputTex)
    self.matLight:setTex("u_heightTexture", self.tempRT0)
    self.matLight:setFloat("u_height", (maxEdge / 20) * self.height / 100)
    self.matLight:setFloat("u_cutAway", self.cutAway / 100)
    self.matLight:setFloat("u_cutAwayFade", self.cutAwayFade / 100)
    self.matLight:setFloat("u_displacement", self.displacement * 28 / 100)

    self.matLight:setInt("u_lightMode", self.lightModeQuery[self.lightMode])
    self.matLight:setVec3("u_lightColor", Amaz.Vector3f(self.lightColor.r, self.lightColor.g, self.lightColor.b))
    self.matLight:setFloat("u_lightIntensity", self.lightIntensity)
    if self.lightMode == "Point" then
        local x = self.lightPosition.x * w - w / 2
        local y = self.lightPosition.y * h - h / 2
        local z = self.lightHeight / 100 * maxEdge
        self.matLight:setVec3("u_lightDirOrPos", Amaz.Vector3f(x, y, z))
    else
        local yaw = math.rad(90 - self.lightAngle)
        local pitch = (math.pi / 2) * (self.lightHeight / 100)
        local x = math.cos(yaw)
        local y = math.sin(yaw)
        local z = math.tan(pitch) * math.sqrt(x * x + y * y)
        self.matLight:setVec3("u_lightDirOrPos", Amaz.Vector3f.normalize(Amaz.Vector3f(x, y, z)))
    end

    self.matLight:setFloat("u_ambient", self.ambient)
    self.matLight:setFloat("u_diffuse", self.diffuse)
    self.matLight:setFloat("u_specular", self.specular)
    self.matLight:setFloat("u_roughness", 1 / self.roughness)
    self.matLight:setFloat("u_metallic", self.metallic)
end

exports.LumiBlobbylize = LumiBlobbylize
return exports
