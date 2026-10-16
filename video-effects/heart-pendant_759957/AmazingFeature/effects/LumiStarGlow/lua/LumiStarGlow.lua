local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiStarGlow = LumiStarGlow or {}
LumiStarGlow.__index = LumiStarGlow
---@class LumiStarGlow : ScriptComponent

---@field inputType string [UI(Option={"Lightness", "Luminance", "Alpha", "Red", "Green", "Blue"})]
---@field threshold number [UI(Range={0.0, 1.0}, Drag)]
---@field thresholdSmooth number [UI(Range={0.0, 10.0}, Drag)]
---@field maskCenter Vector2f
---@field maskRadius number [UI(Range={0.0, 1.0}, Drag)]
---@field maskFade number [UI(Range={0.0, 1.0}, Drag)]
---@field mask number [UI(Range={0.0, 1.0}, Drag)]

---@field steps number [UI(Range={0.0, 100}, Drag)]
---@field directionWeight1 number [UI(Range={0.0, 10.0}, Drag)]
---@field directionWeight2 number [UI(Range={0.0, 10.0}, Drag)]
---@field directionWeight3 number [UI(Range={0.0, 10.0}, Drag)]
---@field directionWeight4 number [UI(Range={0.0, 10.0}, Drag)]
---@field directionWeight5 number [UI(Range={0.0, 10.0}, Drag)]
---@field directionWeight6 number [UI(Range={0.0, 10.0}, Drag)]
---@field directionWeight7 number [UI(Range={0.0, 10.0}, Drag)]
---@field directionWeight8 number [UI(Range={0.0, 10.0}, Drag)]
---@field rotation number [UI(Range={-360, 360.0}, Drag)]

---@field color1 string [UI(Option={"A", "B", "C"})]
---@field color2 string [UI(Option={"A", "B", "C"})]
---@field color3 string [UI(Option={"A", "B", "C"})]
---@field color4 string [UI(Option={"A", "B", "C"})]
---@field color5 string [UI(Option={"A", "B", "C"})]
---@field color6 string [UI(Option={"A", "B", "C"})]
---@field color7 string [UI(Option={"A", "B", "C"})]
---@field color8 string [UI(Option={"A", "B", "C"})]

---@field aType string [UI(Option={"Single", "3-Gradient", "5-Gradient"})]
---@field highLightA Color [UI(NoAlpha)]
---@field midHighA Color [UI(NoAlpha)]
---@field midToneA Color [UI(NoAlpha)]
---@field midLowA Color [UI(NoAlpha)]
---@field shadowA Color [UI(NoAlpha)]

---@field bType string [UI(Option={"Single", "3-Gradient", "5-Gradient"})]
---@field highLightB Color [UI(NoAlpha)]
---@field midHighB Color [UI(NoAlpha)]
---@field midToneB Color [UI(NoAlpha)]
---@field midLowB Color [UI(NoAlpha)]
---@field shadowB Color [UI(NoAlpha)]

---@field cType string [UI(Option={"Single", "3-Gradient", "5-Gradient"})]
---@field highLightC Color [UI(NoAlpha)]
---@field midHighC Color [UI(NoAlpha)]
---@field midToneC Color [UI(NoAlpha)]
---@field midLowC Color [UI(NoAlpha)]
---@field shadowC Color [UI(NoAlpha)]

---@field noiseScale number [UI(Range={0.1, 100.0}, Drag)]
---@field noiseSpeed number [UI(Range={0.0, 10.0}, Drag)]
---@field noiseAmplitude number [UI(Range={0.0, 100.0}, Drag)]
---@field useLoop boolean
---@field loopDuration number [UI(Range={0.1, 100.0}, Drag)]
---@field shimmerIntensity number [UI(Range={0.0, 1.0}, Drag)]

---@field viewType string [UI(Option={"Threshold", "Shimmer", "Combined", "Blend"})]
---@field blendMode string [UI(Option={"None", "Add", "Screen"})]
---@field glowOpacity number [UI(Range={0.0, 1.0}, Drag)]
---@field srcOpacity number [UI(Range={0.0, 1.0}, Drag)]
---@field brightness number [UI(Range={0.0, 100.0}, Drag)]
---@field exposure number [UI(Range={0.1, 5.0}, Drag)]
---@field gammaValue number [UI(Range={0.0, 10.0}, Drag)]

---@field tonemapMode string [UI(Option={"None", "ACES"})]
---@field singleGradientX number [UI(Range={0.0, 10.0}, Drag)]
---@field singleGradientY number [UI(Range={0.0, 10.0}, Drag)]
---@field threeGradientX number [UI(Range={0.0, 10.0}, Drag)]
---@field threeGradientY number [UI(Range={0.0, 10.0}, Drag)]
---@field threeGradientZ number [UI(Range={0.0, 10.0}, Drag)]
---@field fiveGradientX number [UI(Range={0.0, 10.0}, Drag)]
---@field fiveGradientY number [UI(Range={0.0, 10.0}, Drag)]
---@field fiveGradientZ number [UI(Range={0.0, 10.0}, Drag)]
---@field fiveGradientW number [UI(Range={0.0, 10.0}, Drag)]
---@field fiveGradientVeryHigh number [UI(Range={0.0, 10.0}, Drag)]

---@field quality number [UI(Range={0.0, 1.0}, Drag)]
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

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
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

local function setRenderTexture(camera, rt, width, height)
    if rt then
        if width and height and (rt.width ~= width or rt.height ~= height) then
            rt.width = width
            rt.height = height
        end
        camera.renderTexture = rt
    end
end

function LumiStarGlow:initMatCam(name)
    local cameraEntityName = "Camera" .. name
    local meshEntityName = "Pass" .. name
    local camera = self.entity:searchEntity(cameraEntityName):getComponent("Camera")
    local meshRenderer = self.entity:searchEntity(meshEntityName):getComponent("MeshRenderer")
    return camera, meshRenderer and meshRenderer.material
end

function LumiStarGlow.new(construct, ...)
    local self = setmetatable({}, LumiStarGlow)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.viewType = "Threshold"
    self.VIEWS = {
        [0] = "Threshold",
        "Shimmer",
        "Combined",
        "Blend",
        ["Threshold"] = 0,
        ["Shimmer"] = 1,
        ["Combined"] = 2,
        ["Blend"] = 3
    }

    self.inputType = "Lightness"
    self.INPUT_TYPES = {
        [0] = "Lightness",
        "Luminance",
        "Alpha",
        "Red",
        "Green",
        "Blue",
        ["Lightness"] = 0,
        ["Luminance"] = 1,
        ["Alpha"] = 2,
        ["Red"] = 3,
        ["Green"] = 4,
        ["Blue"] = 5
    }

    self.threshold = 0.5
    self.thresholdSmooth = 0.
    self.maskCenter = Amaz.Vector2f(0.5, 0.5)
    self.maskRadius = 0.5
    self.maskFade = 0.
    self.mask = 1.
    self.steps = 10
    self.rotation = 0.0

    -- Initialize direction weights (all enabled by default)
    self.directionWeight1 = 1.0
    self.directionWeight2 = 1.0
    self.directionWeight3 = 1.0
    self.directionWeight4 = 1.0
    self.directionWeight5 = 1.0
    self.directionWeight6 = 1.0
    self.directionWeight7 = 1.0
    self.directionWeight8 = 1.0

    -- Initialize color assignments for all 8 directions
    self.color1 = "A"
    self.color2 = "A"
    self.color3 = "B"
    self.color4 = "B"
    self.color5 = "A"
    self.color6 = "B"
    self.color7 = "B"
    self.color8 = "A"

    self.COLOR_TABLE = {
        [0] = "A",
        "B",
        "C",
        ["A"] = 0,
        ["B"] = 1,
        ["C"] = 2
    }
    self.COLOR_TYPES = {
        [0] = "Single",
        "3-Gradient",
        "5-Gradient",
        ["Single"] = 0,
        ["3-Gradient"] = 1,
        ["5-Gradient"] = 2
    }

    self.aType = "3-Gradient"
    self.highLightA = Amaz.Color(255 / 255, 255 / 255, 255 / 255) -- Light green
    self.midHighA = Amaz.Color(200 / 255, 255 / 255, 128 / 255) -- Bright green
    self.midToneA = Amaz.Color(166 / 255, 255 / 255, 0) -- Medium green
    self.midLowA = Amaz.Color(80 / 255, 255 / 255, 0) -- Deep green
    self.shadowA = Amaz.Color(0, 255 / 255, 0) -- Dark green

    self.bType = "3-Gradient"
    self.highLightB = Amaz.Color(1.000, 0.863, 0.863) -- Light red
    self.midHighB = Amaz.Color(0.980, 0.549, 0.549) -- Bright red
    self.midToneB = Amaz.Color(0.902, 0.235, 0.235) -- Medium red
    self.midLowB = Amaz.Color(0.706, 0.078, 0.078) -- Deep red
    self.shadowB = Amaz.Color(0.392, 0.039, 0.039) -- Dark red

    self.cType = "3-Gradient"
    self.highLightC = Amaz.Color(0.835, 0.835, 1.000) -- Light blue
    self.midHighC = Amaz.Color(0.392, 0.392, 0.980) -- Bright blue
    self.midToneC = Amaz.Color(0.157, 0.157, 0.902) -- Medium blue
    self.midLowC = Amaz.Color(0.078, 0.078, 0.706) -- Deep blue
    self.shadowC = Amaz.Color(0.039, 0.039, 0.392) -- Dark blue

    -- Tonemap Settings
    self.tonemapMode = "ACES"
    self.TONEMAP_MODES = {
        [0] = "None",
        "ACES",
        ["None"] = 0,
        ["ACES"] = 1
    }

    -- Gradient Settings
    self.singleGradientX = 0.15
    self.singleGradientY = 0.5
    self.threeGradientX = 0.0
    self.threeGradientY = 0.150
    self.threeGradientZ = 1.0
    self.fiveGradientX = 0.1
    self.fiveGradientY = 0.2
    self.fiveGradientZ = 0.3
    self.fiveGradientW = 0.4
    self.fiveGradientVeryHigh = 0.75

    -- BlendMode Settings
    self.blendMode = "Normal"
    self.BLEND_MODES = {
        [0] = "None",
        "Add",
        "Screen",
        ["None"] = 0,
        ["Add"] = 1,
        ["Screen"] = 2
    }

    self.glowOpacity = 1.0
    self.srcOpacity = 1.0
    self.brightness = 1.0 -- Add brightness control with default value 1.0
    self.exposure = 1.0
    self.gammaValue = 2.2 -- Add gamma control with default value 1.0
    self.quality = 1.0

    -- Noise control parameters
    self.noiseScale = 5.0
    self.noiseSpeed = 1.0
    self.noiseAmplitude = 1.0
    self.useLoop = false
    self.loopDuration = 1.0

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

local remap = function(v, min, max, min2, max2)
    return min2 + (v - min) * (max2 - min2) / (max - min)
end

local normalize = function(vec)
    local len = math.sqrt(vec.x * vec.x + vec.y * vec.y)
    return Amaz.Vector2f(vec.x / len, vec.y / len)
end

local length = function(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y)
end

function LumiStarGlow:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        self[_key] = _value
        if comp and comp.properties ~= nil then
            comp.properties:set(_key, _value)
        end
    end

    if key == "quality" then
        value = remap(value, 0.0, 1.0, 0.25, 1.0)
        _setEffectAttr(key, value)
    elseif key == "blendMode" then
        value = math.max(0, math.min(value, #self.BLEND_MODES))
        value = self.BLEND_MODES[value]
        _setEffectAttr(key, value)
    elseif key == "inputType" then
        value = math.max(0, math.min(value, #self.INPUT_TYPES))
        value = self.INPUT_TYPES[value]
        _setEffectAttr(key, value)
    elseif key == "aType" or key == "bType" or key == "cType" then
        value = math.max(0, math.min(value, #self.COLOR_TYPES))
        value = self.COLOR_TYPES[value]
        _setEffectAttr(key, value)
    elseif string.match(key, "^color[1-8]$") then
        value = math.max(0, math.min(value, #self.COLOR_TABLE))
        value = self.COLOR_TABLE[value]
        _setEffectAttr(key, value)
    elseif key == "viewType" then
        value = math.max(0, math.min(value, #self.VIEWS))
        value = self.VIEWS[value]
        _setEffectAttr(key, value)
    elseif key == "tonemapMode" then
        value = math.max(0, math.min(value, #self.TONEMAP_MODES))
        value = self.TONEMAP_MODES[value]
        _setEffectAttr(key, value)
    end

    _setEffectAttr(key, value)
end

function LumiStarGlow:setupMaterialCommon(material, angle, stepSize, aspect, weight)
    material:setTex("u_inputTexture", self.thresholdTex)
    material:setFloat("u_range", self.steps * weight)
    material:setFloat("u_stepSize", stepSize)

    local currentDir = normalize(Amaz.Vector2f(math.cos(math.rad(angle)), math.sin(math.rad(angle))))
    currentDir.y = currentDir.y / aspect
    currentDir.x = currentDir.x / aspect
    material:setVec2("u_currentDir", currentDir)
    material:setFloat("u_brightness", self.brightness) -- Add brightness parameter
    material:setFloat("u_gammaInv", math.max(1.0 / self.gammaValue, 0.001)) -- Add gamma parameter
    material:setVec2("u_singleGradient", Amaz.Vector2f(self.singleGradientX, self.singleGradientY))
    material:setVec3("u_threeGradient", Amaz.Vector3f(self.threeGradientX, self.threeGradientY, self.threeGradientZ))
    material:setVec4("u_fiveGradient",
        Amaz.Vector4f(self.fiveGradientX, self.fiveGradientY, self.fiveGradientZ, self.fiveGradientW))
    material:setFloat("u_fiveGradientVeryHigh", self.fiveGradientVeryHigh)
end

function LumiStarGlow:setupMaterialColors(material, colorSet)
    material:setInt("u_colorMode", self.COLOR_TYPES[colorSet.type])
    material:setVec3("u_color", Amaz.Vector3f(colorSet.colors[3].r, colorSet.colors[3].g, colorSet.colors[3].b))
    material:setVec3("u_color_high", Amaz.Vector3f(colorSet.colors[1].r, colorSet.colors[1].g, colorSet.colors[1].b))
    material:setVec3("u_color_midHigh", Amaz.Vector3f(colorSet.colors[2].r, colorSet.colors[2].g, colorSet.colors[2].b))
    material:setVec3("u_color_mid", Amaz.Vector3f(colorSet.colors[3].r, colorSet.colors[3].g, colorSet.colors[3].b))
    material:setVec3("u_color_midLow", Amaz.Vector3f(colorSet.colors[4].r, colorSet.colors[4].g, colorSet.colors[4].b))
    material:setVec3("u_color_low", Amaz.Vector3f(colorSet.colors[5].r, colorSet.colors[5].g, colorSet.colors[5].b))
end

function LumiStarGlow:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    self.camPreprocess, self.matPreprocess = self:initMatCam("Preprocess")
    self.camVertical_1, self.matVertical_1 = self:initMatCam("Vertical_1")
    self.camVertical_2, self.matVertical_2 = self:initMatCam("Vertical_2")
    self.camHorizontal_1, self.matHorizontal_1 = self:initMatCam("Horizontal_1")
    self.camHorizontal_2, self.matHorizontal_2 = self:initMatCam("Horizontal_2")
    self.camDiagonal_1, self.matDiagonal_1 = self:initMatCam("Diagonal_1")
    self.camDiagonal_2, self.matDiagonal_2 = self:initMatCam("Diagonal_2")
    self.camDiagonal_3, self.matDiagonal_3 = self:initMatCam("Diagonal_3")
    self.camDiagonal_4, self.matDiagonal_4 = self:initMatCam("Diagonal_4")
    self.camShimmer, self.matShimmer = self:initMatCam("Shimmer")
    self.camPostprocess, self.matPostprocess = self:initMatCam("Postprocess")
    self.camComp, self.matComp = self:initMatCam("Composite")

    local w, h = self.OutputTex.width, self.OutputTex.height
    self.thresholdTex = createRenderTexture(w, h)
    self.verticalTex1 = createRenderTexture(w, h)
    self.verticalTex2 = createRenderTexture(w, h)
    self.horizontalTex1 = createRenderTexture(w, h)
    self.horizontalTex2 = createRenderTexture(w, h)
    self.diagonal_1Tex = createRenderTexture(w, h)
    self.diagonal_2Tex = createRenderTexture(w, h)
    self.diagonal_3Tex = createRenderTexture(w, h)
    self.diagonal_4Tex = createRenderTexture(w, h)
    self.shimmerTex = createRenderTexture(w, h)
    self.postTex = createRenderTexture(w, h)
end

function LumiStarGlow:onUpdate(comp, deltaTime)
    local w, h = self.OutputTex.width, self.OutputTex.height
    local scaledW = w * self.quality
    local scaledH = h * self.quality
    local aspect = scaledW / scaledH
    local texelSize = Amaz.Vector2f(1.0 / scaledW, 1.0 / scaledH)
    local stepSize = length(texelSize)

    if self.shimmerIntensity == 0 then
        self.camShimmer.entity.visible = false
    else
        self.camShimmer.entity.visible = true
    end

    self.curTime = self.curTime + deltaTime
    -- Update render textures
    updateTexSize(self.thresholdTex, scaledW, scaledH)
    updateTexSize(self.verticalTex1, scaledW, scaledH)
    updateTexSize(self.verticalTex2, scaledW, scaledH)
    updateTexSize(self.horizontalTex1, scaledW, scaledH)
    updateTexSize(self.horizontalTex2, scaledW, scaledH)
    updateTexSize(self.diagonal_1Tex, scaledW, scaledH)
    updateTexSize(self.diagonal_2Tex, scaledW, scaledH)
    updateTexSize(self.diagonal_3Tex, scaledW, scaledH)
    updateTexSize(self.diagonal_4Tex, scaledW, scaledH)
    updateTexSize(self.shimmerTex, scaledW, scaledH)
    updateTexSize(self.postTex, scaledW, scaledH)

    setRenderTexture(self.camPreprocess, self.thresholdTex)
    setRenderTexture(self.camVertical_1, self.verticalTex1)
    setRenderTexture(self.camVertical_2, self.verticalTex2)
    setRenderTexture(self.camHorizontal_1, self.horizontalTex1)
    setRenderTexture(self.camHorizontal_2, self.horizontalTex2)
    setRenderTexture(self.camDiagonal_1, self.diagonal_1Tex)
    setRenderTexture(self.camDiagonal_2, self.diagonal_2Tex)
    setRenderTexture(self.camDiagonal_3, self.diagonal_3Tex)
    setRenderTexture(self.camDiagonal_4, self.diagonal_4Tex)
    setRenderTexture(self.camShimmer, self.shimmerTex)
    setRenderTexture(self.camPostprocess, self.postTex)
    setRenderTexture(self.camComp, self.OutputTex)
    -- Preprocess material setup with shimmer controls for noise
    self.matPreprocess:setTex("u_inputTex", self.InputTex)
    self.matPreprocess:setInt("u_inputType", self.INPUT_TYPES[self.inputType])
    self.matPreprocess:setFloat("u_threshold", remap(self.threshold, 0, 0.99, 0, 1))
    self.matPreprocess:setFloat("u_thresholdSmooth", self.thresholdSmooth)
    self.matPreprocess:setVec2("u_maskCenter", self.maskCenter)
    self.matPreprocess:setFloat("u_maskRadius", 1.0 - self.maskRadius)
    self.matPreprocess:setFloat("u_maskFade", self.maskFade)
    self.matPreprocess:setFloat("u_mask", self.mask)
    -- Create color sets lookup table
    local colorSets = {
        A = {
            type = self.aType,
            colors = {self.highLightA, self.midHighA, self.midToneA, self.midLowA, self.shadowA}
        },
        B = {
            type = self.bType,
            colors = {self.highLightB, self.midHighB, self.midToneB, self.midLowB, self.shadowB}
        },
        C = {
            type = self.cType,
            colors = {self.highLightC, self.midHighC, self.midToneC, self.midLowC, self.shadowC}
        }
    }
    -- Get color sets for each direction
    local colorSet1 = colorSets[self.color1]
    local colorSet2 = colorSets[self.color2]
    local colorSet3 = colorSets[self.color3]
    local colorSet4 = colorSets[self.color4]
    local colorSet5 = colorSets[self.color5]
    local colorSet6 = colorSets[self.color6]
    local colorSet7 = colorSets[self.color7]
    local colorSet8 = colorSets[self.color8]
    -- Setup commons
    self:setupMaterialCommon(self.matVertical_1, 90 + 180 + self.rotation, stepSize, aspect, self.directionWeight1)
    self:setupMaterialCommon(self.matVertical_2, 90 + self.rotation, stepSize, aspect, self.directionWeight2)
    self:setupMaterialCommon(self.matHorizontal_1, 0 + self.rotation, stepSize, aspect, self.directionWeight3)
    self:setupMaterialCommon(self.matHorizontal_2, 180 + self.rotation, stepSize, aspect, self.directionWeight4)
    self:setupMaterialCommon(self.matDiagonal_1, 45 + self.rotation, stepSize, aspect, self.directionWeight5)
    self:setupMaterialCommon(self.matDiagonal_2, 45 + 180 + self.rotation, stepSize, aspect, self.directionWeight6)
    self:setupMaterialCommon(self.matDiagonal_3, -45 + self.rotation, stepSize, aspect, self.directionWeight7)
    self:setupMaterialCommon(self.matDiagonal_4, -45 + 180 + self.rotation, stepSize, aspect, self.directionWeight8)
    -- Setup Material Colors
    self:setupMaterialColors(self.matVertical_1, colorSet1)
    self:setupMaterialColors(self.matVertical_2, colorSet2)
    self:setupMaterialColors(self.matHorizontal_1, colorSet3)
    self:setupMaterialColors(self.matHorizontal_2, colorSet4)
    self:setupMaterialColors(self.matDiagonal_1, colorSet5)
    self:setupMaterialColors(self.matDiagonal_2, colorSet6)
    self:setupMaterialColors(self.matDiagonal_3, colorSet7)
    self:setupMaterialColors(self.matDiagonal_4, colorSet8)
    -- Setup noise control parameters for shimmer
    self.matShimmer:setFloat("u_noiseScale", self.noiseScale)
    self.matShimmer:setFloat("u_noiseSpeed", self.noiseSpeed) -- speed affects shape within cycle
    self.matShimmer:setFloat("u_noiseAmplitude", self.noiseAmplitude)
    -- Compute phase in Lua (seamless: integer cycles per loop)
    local loopSec = math.max(self.loopDuration, 0.1) -- loop duration in seconds
    local tInLoop = self.curTime % loopSec -- time within current loop cycle
    local TAU = 2.0 * math.pi
    local targetCycles = self.noiseSpeed * loopSec -- desired cycles in one loop
    local cycles = math.max(1, math.floor(targetCycles + 0.5)) -- quantize to integer cycles
    local effectiveOmega = (TAU * cycles) / loopSec -- radians/sec for seamless looping
    local phaseAngle = self.useLoop and (effectiveOmega * tInLoop) or (self.noiseSpeed * TAU * self.curTime)
    self.matShimmer:setFloat("u_phaseAngle", phaseAngle)
    -- Setup Postprocess Pass
    self.matPostprocess:setTex("u_verticalTex1", self.verticalTex1)
    self.matPostprocess:setTex("u_verticalTex2", self.verticalTex2)
    self.matPostprocess:setTex("u_horizontalTex1", self.horizontalTex1)
    self.matPostprocess:setTex("u_horizontalTex2", self.horizontalTex2)
    self.matPostprocess:setTex("u_diagonal_1Tex", self.diagonal_1Tex)
    self.matPostprocess:setTex("u_diagonal_2Tex", self.diagonal_2Tex)
    self.matPostprocess:setTex("u_diagonal_3Tex", self.diagonal_3Tex)
    self.matPostprocess:setTex("u_diagonal_4Tex", self.diagonal_4Tex)
    self.matPostprocess:setTex("u_shimmerTex", self.shimmerTex)

    self.matPostprocess:setFloat("u_rotation", self.rotation)
    self.matPostprocess:setFloat("u_shimmerIntensity", self.shimmerIntensity)
    self.matPostprocess:setFloat("u_exposure", self.exposure)
    self.matPostprocess:setFloat("u_brightness", self.brightness)
    self.matPostprocess:setFloat("u_gammaValue", self.gammaValue)
    self.matPostprocess:setInt("u_tonemapMode", self.TONEMAP_MODES[self.tonemapMode])
    -- Setup Comp Pass
    self.matComp:setInt("u_blendMode", self.BLEND_MODES[self.blendMode])
    self.matComp:setInt("u_view", self.VIEWS[self.viewType])
    self.matComp:setTex("u_inputTex", self.InputTex)
    self.matComp:setTex("u_thresholdTex", self.thresholdTex)
    self.matComp:setTex("u_shimmerTex", self.shimmerTex)
    self.matComp:setTex("u_postTex", self.postTex)
    self.matComp:setFloat("u_gammaValue", self.gammaValue)
    self.matComp:setFloat("u_glowOpacity", self.glowOpacity)
    self.matComp:setFloat("u_srcOpacity", self.srcOpacity)
end

exports.LumiStarGlow = LumiStarGlow
return exports
