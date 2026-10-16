local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local AETools = AETools or {}     ---@class AETools
AETools.__index = AETools
function AETools:new(attrs)
    local self = setmetatable({}, AETools)
    self.attrs = attrs
    local max_frame = 0
    for _,v in pairs(attrs) do
        for i = 1, #v do
            local content = v[i]
            local cur_frame = content[2][2]
            max_frame = math.max(cur_frame, max_frame)
        end
    end
    self:SetAllFrame(max_frame)
    return self
end
function AETools._remap01(a,b,x)
    if x < a then return 0 end
    if x > b then return 1 end
    return (x-a)/(b-a)
end
function AETools._cubicBezier(p1, p2, p3, p4, t)
    return {
        p1[1]*(1.-t)*(1.-t)*(1.-t) + 3*p2[1]*(1.-t)*(1.-t)*t + 3*p3[1]*(1.-t)*t*t + p4[1]*t*t*t,
        p1[2]*(1.-t)*(1.-t)*(1.-t) + 3*p2[2]*(1.-t)*(1.-t)*t + 3*p3[2]*(1.-t)*t*t + p4[2]*t*t*t,
    }
end
function AETools:_cubicBezier01(_bezier_val, p)
    local x = self:_getBezier01X(_bezier_val, p)
    return self._cubicBezier(
        {0,0},
        {_bezier_val[1], _bezier_val[2]},
        {_bezier_val[3], _bezier_val[4]},
        {1,1},
        x
    )[2]
end
function AETools:_getBezier01X(_bezier_val, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts+te)*0.5
        local value = self._cubicBezier(
            {0,0},
            {_bezier_val[1], _bezier_val[2]},
            {_bezier_val[3], _bezier_val[4]},
            {1,1},
            tm)
        if(value[1]>x) then
            te = tm
        else
            ts = tm
        end
    until(te-ts < 0.0001)
    return (te+ts)*0.5
end
function AETools._mix(a, b, x)
    return a * (1-x) + b * x
end
function AETools:SetAllFrame(val)
    self.all_frame = val
end
function AETools:GetVal(_name, _progress)
    local content = self.attrs[_name]
    if content == nil then
        return nil
    end
    local cur_frame = _progress * self.all_frame
    for i = 1, #content do
        local info = content[i]
        local start_frame = info[2][1]
        local end_frame = info[2][2]
        if cur_frame >= start_frame and cur_frame < end_frame then
            local cur_progress = self._remap01(start_frame, end_frame, cur_frame)
            local bezier = info[1]
            local value_range = info[3]
            if #bezier > 4 then
                -- currently scale attrs contains more than 4 bezier values
                local res = {}
                for k = 1, 3 do
                    local cur_bezier = {bezier[k], bezier[k+3], bezier[k+3*2], bezier[k+3*3]}
                    local p = self:_cubicBezier01(cur_bezier, cur_progress)
                    res[k] = self._mix(value_range[1][k], value_range[2][k], p)
                end
                return res
            else
                local p = self:_cubicBezier01(bezier, cur_progress)
                if type(value_range[1]) == "table" then
                    local res = {}
                    for j = 1, #value_range[1] do
                        res[j] = self._mix(value_range[1][j], value_range[2][j], p)
                    end
                    return res
                end
                return self._mix(value_range[1], value_range[2], p)
            end
        end
    end
    local first_info = content[1]
    local start_frame = first_info[2][1]
    if cur_frame<start_frame then
        return first_info[3][1]
    end
    local last_info = content[#content]
    local end_frame = last_info[2][2]
    if cur_frame>=end_frame then
        return last_info[3][2]
    end
    return nil
end
function AETools:test()
    Amaz.LOGI("lrc "..tostring(self.key_frame_info), tostring(#self.key_frame_info))
end
local ae_attribute = {
    ["ADBE_IE_8cb17a2f56325a949dc60f2_0002_0_0"]={
		{{0.801083116, 0.137614609, 0.999, 1, }, {4, 6, }, {{0.73395, }, {1.100925, }, }, {6417, }, {0, }, }, 
		{{0.33333333, 0, 0.833333333, 0.833333333, }, {6, 9, }, {{1.100925, }, {0.917438, }, }, {6417, }, {0, }, }, 
		{{0.001, 0, 0.431097763, 1, }, {9, 12, }, {{0.917438, }, {0.73395, }, }, {6417, }, {0, }, }, 
		{{0.547898902, 0, 0.881091596, 1, }, {12, 16, }, {{0.73395, }, {1.009182, }, }, {6417, }, {0, }, }, 
		{{0.188038094, 0, 0.42927997, 1, }, {16, 20, }, {{1.009182, }, {0.73395, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.85, 1, }, {20, 22, }, {{0.73395, }, {1.100925, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.58, 0, }, {22, 23, }, {{1.100925, }, {1.100925, }, }, {6417, }, {0, }, }, 
		{{0.494524283, 0, 0.728820132, 1, }, {23, 27, }, {{1.100925, }, {0.642206, }, }, {6417, }, {0, }, }, 
		{{0.271753235, 0, 0.376016216, 1, }, {27, 32, }, {{0.642206, }, {0.917438, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.81293989, 0.928222132, }, {32, 39, }, {{0.917438, }, {0.516059, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.58, 1, }, {39, 40, }, {{0.516059, }, {0.560401, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.58, 1, }, {40, 41, }, {{0.560401, }, {0.401379, }, }, {6417, }, {0, }, }, 
		{{0.328174958, 0.334077464, 0.58, 1, }, {41, 48, }, {{0.401379, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
	["ADBE_IE_8cb17a2f56325a949dc60f2_0003_0_1"]={
		{{0.42, 0, 0.788734199, 1, }, {4, 6, }, {{95.2279, }, {66, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.58, 1, }, {6, 9, }, {{66, }, {95.2279, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.674669461, 0.74392044, }, {9, 12, }, {{95.2279, }, {90.929679, }, }, {6417, }, {0, }, }, 
		{{0.313620908, 0.769202143, 0.58, 1, }, {12, 16, }, {{90.929679, }, {89.210391, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.403273271, 1, }, {16, 20, }, {{89.210391, }, {90.929679, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.684457736, 0.465662787, }, {20, 22, }, {{90.929679, }, {86.631459, }, }, {6417, }, {0, }, }, 
		{{0.308060689, 0.850618948, 0.58, 1, }, {22, 23, }, {{86.631459, }, {84.912171, }, }, {6417, }, {0, }, }, 
		{{0.594349397, 0, 0.789469348, 1, }, {23, 27, }, {{84.912171, }, {104.683985, }, }, {6417, }, {0, }, }, 
		{{0.233857555, 0, 0.459584551, 1, }, {27, 32, }, {{104.683985, }, {90.929679, }, }, {6417, }, {0, }, }, 
		{{0.512890774, 0, 0.736417234, 0.47350437, }, {32, 39, }, {{90.929679, }, {92.810151, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.58, 1, }, {39, 40, }, {{92.810151, }, {92.5, }, }, {6417, }, {0, }, }, 
		{{0.42, 0, 0.58, 1, }, {40, 41, }, {{92.5, }, {93.347428, }, }, {6417, }, {0, }, }, 
		{{0.258408402, 0.693804751, 0.58, 1, }, {41, 48, }, {{93.347428, }, {95.2279, }, }, {6417, }, {0, }, }, 
	}, 

    ["ADBE_Opacity_0_0"]={
		{{0.66, 0, 0.34, 1, }, {5, 6, }, {{0, }, {4, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {6, 8, }, {{4, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 0, }, {8, 15, }, {{0, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {15, 16, }, {{0, }, {6, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {16, 17, }, {{6, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 0, }, {17, 21, }, {{0, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {21, 22, }, {{0, }, {15, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {22, 24, }, {{15, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 0, }, {24, 31, }, {{0, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {31, 32, }, {{0, }, {2, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {32, 34, }, {{2, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 0, }, {34, 39, }, {{0, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {39, 40, }, {{0, }, {0.5, }, }, {6417, }, {0, }, }, 
		{{0.66, 0, 0.34, 1, }, {40, 41, }, {{0.5, }, {0, }, }, {6417, }, {0, }, }, 
	}, 

    ["ADBE_Time_Remapping_0_0"]={
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {0, 38, }, {{0, }, {1.266667, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {38, 39, }, {{1.266667, }, {1.318543, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {39, 40, }, {{1.318543, }, {1.383673, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {40, 41, }, {{1.383673, }, {1.453265, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {41, 42, }, {{1.453265, }, {1.524305, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {42, 43, }, {{1.524305, }, {1.595175, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {43, 44, }, {{1.595175, }, {1.664731, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {44, 45, }, {{1.664731, }, {1.731979, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {45, 46, }, {{1.731979, }, {1.795899, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {46, 47, }, {{1.795899, }, {1.855291, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {47, 48, }, {{1.855291, }, {1.908581, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {48, 49, }, {{1.908581, }, {1.953489, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {49, 50, }, {{1.953489, }, {1.986306, }, }, {6417, }, {1, }, }, 
		{{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {50, 51, }, {{1.986306, }, {2, }, }, {6417, }, {1, }, }, 
		-- {{0.166666667, 0.166666667, 0.833333333, 0.833333333, }, {51, 65, }, {{2, }, {2.166667, }, }, {6417, }, {1, }, }, 
	}, 
}


-- local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local VATPBR = VATPBR or {}
VATPBR.__index = VATPBR

---@class VATPBR : ScriptComponent
---@field autoplay boolean
---@field frameByFrame boolean
---@field frameCount number [UI(Range={1, 250}, Drag)]
---@field duration number [UI(Range={0.0, 100.0}, Drag)]
---@field speed number [UI(Range={0.0, 2.0}, Drag)]
---@field startFrame number [UI(Range={0, 100}, Drag)]
---@field endFrame number [UI(Range={1, 250}, Drag)]
---@field progress number [UI(Range={0, 1}, Slider)]
---@field displayFrame number [UI(Range={1, 100}, Drag)]

---@field curveType String [UI(Option={"Linear", "EaseIn", "EaseOut", "EaseInOut", "Bounce", "Accelerate", "Decelerate", "Rush", "Burst"})]
---@field curveStartFrame number [UI(Range={0, 100}, Drag)]
---@field curveEndFrame number [UI(Range={0, 100}, Drag)]
---@field curveStrength number [UI(Range={0.0, 5.0}, Drag)]

---@field camOrthoScale number [UI(Range={0.0, 2.0}, Drag)]
---@field camFOV number [UI(Range={0.0, 180.0}, Drag)]
---@field camPosX number
---@field camPosY number
---@field camPosZ number
---@field camRotX number
---@field camRotY number
---@field camRotZ number

---@field positionX number
---@field positionY number
---@field positionZ number
---@field direction Vector3f
---@field rotation Vector3f
---@field scale Vector3f
---@field scaleMult number
---@field pivot Vector3f

---@field meshes Vector [UI(Type="Mesh")]
---@field posTexs Vector [UI(Type="Texture")]
---@field rotTexs Vector [UI(Type="Texture")]
---@field colTexs Vector [UI(Type="Texture")]

---@field rotateOnLandscape boolean [UI(Display="Rotate on Landscape")]
---@field rotateUV number [UI(Range={-360.0, 360.0}, Drag)]
---@field offsetUV Vector2f
---@field scaleUV Vector2f
---@field padding Vector2f
---@field edgeType String [UI(Option={"Tile", "Mirror", "Clamp", "Empty"})]

---@field lightingBlend number [UI(Range={0.0, 1.0}, Drag)]
---@field useVertexColor boolean [UI(Display="Use Vertex Color")]
---@field vertexShadowInt number [UI(Range={0.0, 10.0}, Drag)]
---@field vertexShadowContrast number [UI(Range={0.0, 10.0}, Drag)]
---@field vertexShadowColor Color [UI(NoAlpha)]

---@field enableDirLight boolean
---@field dirLightDir Vector3f
---@field dirLightColor Color [UI(NoAlpha)]
---@field dirLightIntensity number [UI(Range={0.0, 1000.0}, Drag)]

---@field enablePointLight boolean
---@field pointLightPos Vector3f
---@field pointLightColor Color [UI(NoAlpha)]
---@field pointLightIntensity number [UI(Range={0.0, 1000.0}, Drag)]
---@field pointLightAttenRangeInv number [UI(Range={0.0, 1000.0}, Drag)]

---@field enableSpotLight boolean
---@field spotLightPos Vector3f
---@field spotLightDir Vector3f
---@field spotLightColor Color [UI(NoAlpha)]
---@field spotLightIntensity number [UI(Range={0.0, 1000.0}, Drag)]
---@field spotLightAttenRangeInv number [UI(Range={0.0, 1000.0}, Drag)]
---@field spotLightInnerAngle number [UI(Range={0.0, 360.0}, Drag)]
---@field spotLightOuterAngle number [UI(Range={0.0, 360.0}, Drag)]

---@field enableEnv boolean
---@field envMapMipLevel int [UI(Range={0, 7}, Slider)]
---@field envLightIntensity number [UI(Range={0.0, 1000.0}, Drag)]
---@field envLightRotation number [UI(Range={-360.0, 360.0}, Drag)]

---@field enableNormTex boolean
---@field normInt number [UI(Range={0.0, 1.0}, Drag)]
---@field enableToneMapping boolean
---@field toneMappingType String [UI(Option={"Linear", "Reinhard", "Uncharted2", "Filmic", "ACES", "AGX", "FidelityFX", "ModifiedReinhard"})]
---@field enableAlbedoTex boolean
---@field albedoTex Texture
---@field albedoColor Color [UI(NoAlpha)]
---@field metallic number [UI(Range={0.0, 1.0}, Drag)]
---@field roughness number [UI(Range={0.0, 1.0}, Drag)]
---@field anisoAngle number [UI(Range={0.0, 180.0}, Drag)]
---@field anisoStrength number [UI(Range={0.0, 100.0}, Drag)]

---@field normTex Texture
---@field blendTex Texture
---@field envTex Texture
---@field InputTex Texture
---@field BackTex Texture
---@field OutputTex Texture
---@field HightLightColor Color [UI(NoAlpha)]
---@field isBlend number
local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local EPS = 1e-5

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

local function getSigmoidXFactor(intensity)
    return math.exp(8.33 * intensity - 12.16) + 5.82 * intensity - 1.72
end

local function getSigmoid(x, intensity, pivot)
    local a = getSigmoidXFactor(intensity)
    local s = 1.0 / (1.0 + math.exp(-a * (x - pivot)))
    local y = s + pivot - 0.5       -- sigmoid value
    local k = a * s * (1.0 - s)     -- sigmoid derivative
    return y, k
end

function VATPBR.new(construct, ...)
    local self = setmetatable({}, VATPBR)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.first = true

    self.isBlend = 1.0

    -- VAT
    self.autoplay = true
    self.frameByFrame = false
    self.progress = 0
    self.speed = 1
    self.duration = 3
    self.frameCount = 90
    self.startTime = 0
    self.endTime = 0
    self.curTime = 0
    self.aeTime = 0
    self.displayFrame = 1
    self.startFrame = 1
    self.endFrame = 90
    self.AEPlugin = false
    -- Cam
    self.camOrthoScale = 1.2
    self.camFOV = 60
    self.camPosX = 0
    self.camPosY = 0
    self.camPosZ = 0
    self.camRotX = 0
    self.camRotY = 0
    self.camRotZ = 0
    -- Model
    self.meshes = {}
    self.posTexs = {}
    self.rotTexs = {}
    self.colTexs = {}
    self.vatPasses = {}
    -- Model Xform
    self.pivot = Amaz.Vector3f(0, 0, 0)
    self.positionX = 0
    self.positionY = 0
    self.positionZ = 0
    self.scale = Amaz.Vector3f(1, 1, 1)
    self.scaleMult = 1
    self.direction = Amaz.Vector3f(0, 0, 0)
    self.rotation = Amaz.Vector3f(0, 0, 0)
    -- UV
    self.rotateOnLandscape = true
    self.rotateUV = 0
    self.offsetUV = Amaz.Vector2f(0, 0)
    self.scaleUV = Amaz.Vector2f(1, 1)
    self.padding = Amaz.Vector2f(0.01, 0.01)
    self.EDGE_TYPES = {
        [0] = "Tile",
        "Mirror",
        "Clamp",
        "Empty",
        ["Tile"] = 0,
        ["Mirror"] = 1,
        ["Clamp"] = 2,
        ["Empty"] = 3
    }
    self.edgeType = "Tile"
    -- Lighting
    self.lightingBlend = 1.0 -- Full lighting influence for metallic reflections
    -- EnvLight (important for metallic reflections)
    self.enableEnv = true
    self.envMapMipLevel = 0
    self.envLightIntensity = 1.5 -- Increased for stronger reflections
    self.envLightRotation = 0
    -- DirLight
    self.enableDirLight = true
    self.dirLightIntensity = 2.0 -- Increased for stronger specular highlights
    self.dirLightColor = Amaz.Color(1.0, 0.95, 0.8) -- Warm light color
    self.dirLightDir = Amaz.Vector3f(0, 0, -1)
    -- PointLight
    self.enablePointLight = false
    self.pointLightIntensity = 1
    self.pointLightColor = Amaz.Color(1, 1, 1)
    self.pointLightAttenRangeInv = 1
    self.pointLightPos = Amaz.Vector3f(0, 0, 0)
    -- SpotLight
    self.enableSpotLight = false
    self.spotLightIntensity = 1
    self.spotLightColor = Amaz.Color(1, 1, 1)
    self.spotLightAttenRangeInv = 1
    self.spotLightInnerAngle = 30
    self.spotLightOuterAngle = 160
    self.spotLightPos = Amaz.Vector3f(0, 2.5, 2.5)
    self.spotLightDir = Amaz.Vector3f(-90, 0, -1)
    -- Vertex Color
    self.useVertexColor = false
    self.vertexShadowInt = 0
    self.vertexShadowContrast = 1
    self.vertexShadowColor = Amaz.Color(0.5, 0.5, 0.5)
    -- PBR
    self.enableToneMapping = false
    self.toneMappingType = "ACES"
    self.TONE_MAPPING_TYPES = {
        [0] = "Linear",
        "Reinhard",
        "Uncharted2",
        "Filmic",
        "ACES",
        "AGX",
        "FidelityFX",
        "ModifiedReinhard",
        ["Linear"] = 0,
        ["Reinhard"] = 1,
        ["Uncharted2"] = 2,
        ["Filmic"] = 3,
        ["ACES"] = 4,
        ["AGX"] = 5,
        ["FidelityFX"] = 6,
        ["ModifiedReinhard"] = 7
    }
    -- Norm
    self.enableNormTex = false
    self.normTex = nil
    self.normInt = 1
    -- Albedo
    self.enableAlbedoTex = false
    self.albedoTex = nil
    self.albedoColor = Amaz.Color(1.0, 0.765, 0.336, 1.0) -- Warm gold color
    self.metallic = 1.0 -- Full metallic for gold
    self.roughness = 0.2 -- Low roughness for polished gold
    self.anisoAngle = 0
    self.anisoStrength = 0
    -- Shared
    self.sharedMaterials = {}
    self.InputTex = nil
    self.BackTex = nil
    self.OutputTex = nil
    self.blendTex = nil
    self.HightLightColor = Amaz.Color(1.0, 1.0, 1.0 , 1.0)
    -- Curve Animation
    self.curveType = "Linear"
    self.curveTypeList = {
        [0] = "Linear",
        "EaseIn",
        "EaseOut",
        "EaseInOut",
        "Bounce",
        "Accelerate",
        "Decelerate",
        "Rush",
        "Burst",
        ["Linear"] = 0,
        ["EaseIn"] = 1,
        ["EaseOut"] = 2,
        ["EaseInOut"] = 3,
        ["Bounce"] = 4,
        ["Accelerate"] = 5,
        ["Decelerate"] = 6,
        ["Rush"] = 7,
        ["Burst"] = 8
    }
    self.curveStartFrame = 1
    self.curveEndFrame = 24
    self.curveStrength = 1.0
    -- Others
    return self
end

local function remap(value, min, max, newMin, newMax)
    return newMin + (value - min) * (newMax - newMin) / (max - min)
end

local function mix(a, b, t)
    return a * (1 - t) + b * t
end

local function clamp(value, min, max)
    --[[
        Description: clamp value between [min, max]
    ]]
    return math.min(math.max(value, min), max)
end


function VATPBR:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "curveType" then
        value = math.max(0, math.min(value, #self.curveTypeList))
        _setEffectAttr(key, self.curveTypeList[value])
    elseif key == "camFOV" then
        _setEffectAttr(key, value)
    else
        _setEffectAttr(key, value)
    end
end

function VATPBR:rotateByAxis(_trans, _direction, _euler_angle)
    -- ae xyz, editor yxz
    local right = Amaz.Vector3f(1.0, 0.0, 0.0)
    local up = Amaz.Vector3f(0.0, 1.0, 0.0)
    local forward = Amaz.Vector3f(0.0, 0.0, 1.0)

    local cur_orientation = Amaz.Quaternionf.axisAngleToQuaternion(right, math.rad(_direction.x)) *
                                Amaz.Quaternionf.axisAngleToQuaternion(up, -math.rad(_direction.y)) *
                                Amaz.Quaternionf.axisAngleToQuaternion(forward, -math.rad(_direction.z))

    up = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, up)
    right = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, right)
    forward = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, forward)

    cur_orientation = Amaz.Quaternionf.axisAngleToQuaternion(right, math.rad(_euler_angle.x)) *
                          Amaz.Quaternionf.axisAngleToQuaternion(up, -math.rad(_euler_angle.y)) *
                          Amaz.Quaternionf.axisAngleToQuaternion(forward, -math.rad(_euler_angle.z)) * cur_orientation

    _trans.localOrientation = cur_orientation
end

function VATPBR:onStart(comp)
    -- Cache entity reference
    local entity = comp.entity
    self.entity = entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    -- Get camera components
    local camEntity = entity:searchEntity("CameraVAT")
    self.camVAT = camEntity:getComponent("Camera")
    self.camVATXform = camEntity:getComponent("Transform")

    -- Get VAT components
    self.vatXform = entity:searchEntity("VATObj"):getComponent("Transform")

    self.vatPass_1 = entity:searchEntity("PassVAT_1"):getComponent("MeshRenderer")
    self.vatPass_2 = entity:searchEntity("PassVAT_2"):getComponent("MeshRenderer")
    self.vatPass_3 = entity:searchEntity("PassVAT_3"):getComponent("MeshRenderer")
    self.vatPasses = {self.vatPass_1, self.vatPass_2, self.vatPass_3}

    self.contrastComp = comp.entity.scene:findEntityBy("LumiContrast_front"):getComponent("ScriptComponent")
    self.deepGlowComp = comp.entity.scene:findEntityBy("LumiDeepGlow"):getComponent("ScriptComponent")

    self.blendPass = comp.entity.scene:findEntityBy("video"):getComponent("MeshRenderer")


    -- Cache materials
    self.sharedMaterials = {}
    local materialIndex = 1

    -- Add materials from vatPass_1
    local materials_1 = self.vatPass_1.materials
    for i = 0, #materials_1 - 1 do
        local mat = materials_1:get(i)
        self.sharedMaterials[materialIndex] = mat
        materialIndex = materialIndex + 1
    end
    self.faceMaterial_1 = materials_1:get(0)

    -- Add materials from vatPass_2
    local materials_2 = self.vatPass_2.materials
    for i = 0, #materials_2 - 1 do
        local mat = materials_2:get(i)
        self.sharedMaterials[materialIndex] = mat
        materialIndex = materialIndex + 1
    end
    self.faceMaterial_2 = materials_2:get(0)

    -- Add materials from vatPass_3
    local materials_3 = self.vatPass_3.materials
    for i = 0, #materials_3 - 1 do
        local mat = materials_3:get(i)
        self.sharedMaterials[materialIndex] = mat
        materialIndex = materialIndex + 1
    end
    self.faceMaterial_3 = materials_3:get(0)

    -- Get pivot
    local pivotEntity = entity:searchEntity("VATPivot")
    if pivotEntity then
        self.pivotXform = pivotEntity:getComponent("Transform")
    end

    -- Lighting
    self.dirLightXform = entity:searchEntity("DirectionalLight"):getComponent("Transform")
    self.pointLightXform = entity:searchEntity("PointLight"):getComponent("Transform")
    self.spotLightXform = entity:searchEntity("SpotLight"):getComponent("Transform")

    -- Others

    self.attrs = AETools:new(ae_attribute)
end

function VATPBR:onUpdate(comp, deltaTime)
    if self.OutputTex then
        self.camVAT.renderTexture = self.OutputTex
        -- self.camVAT_last.renderTexture = self.OutputTex
    end

    -- Invert FOV mapping: higher values (up to 180) become lower FOV angles (more zoomed in)
    self.camVAT.fovy = remap(self.camFOV, 0, 180, 180, 0)

    self.vatPass_1.mesh = self.meshes:get(0)
    self.vatPass_2.mesh = self.meshes:get(1)
    self.vatPass_3.mesh = self.meshes:get(2)

    self:calculateTransform()

    self:rotateByAxis(self.dirLightXform, Amaz.Vector3f(0, 0, 0), self.dirLightDir)
    self:rotateByAxis(self.spotLightXform, Amaz.Vector3f(0, 0, 0), self.spotLightDir)
    self.spotLightXform.localPosition = self.spotLightPos
    self.pointLightXform.localPosition = self.pointLightPos

    for _, mat in ipairs(self.sharedMaterials) do
        mat:setVec2("u_offset", self.offsetUV)
        mat:setVec2("u_scale", self.scaleUV)
        mat:setFloat("u_rotate", math.rad(self.rotateUV))
        mat:setInt("u_edgeType", self.EDGE_TYPES[self.edgeType])

        -- Basic material properties
        mat:setTex("u_inputTex", self.InputTex)
        mat:setTex("u_backTex", self.BackTex)
        mat:setVec3("u_hightLightColor" , Amaz.Vector3f(self.HightLightColor.r , self.HightLightColor.g , self.HightLightColor.b))
        mat:setInt("u_enableAlbedoTex", self.enableAlbedoTex and 1 or 0)
        mat:setTex("u_albedoTex", self.albedoTex)
        mat:setVec4("u_albedoColor",
            Amaz.Vector4f(self.albedoColor.r, self.albedoColor.g, self.albedoColor.b, self.albedoColor.a))
        mat:setFloat("u_metallic", self.metallic)
        mat:setFloat("u_roughness", self.roughness)
        mat:setInt("u_useVertexColor", self.useVertexColor and 1 or 0)
        mat:setFloat("u_vertexShadowInt", self.vertexShadowInt)
        mat:setFloat("u_vertexShadowContrast", self.vertexShadowContrast)
        mat:setVec3("u_vertexShadowColor",
            Amaz.Vector3f(self.vertexShadowColor.r, self.vertexShadowColor.g, self.vertexShadowColor.b))

        -- Update all lighting parameters
        self:updateLighting(mat)

        -- Normal mapping
        mat:setInt("u_enableNormTex", self.enableNormTex and 1 or 0)
        mat:setTex("u_normTex", self.normTex)
        mat:setFloat("u_normInt", self.normInt)

        -- Post processing
        mat:setInt("u_enableToneMapping", self.enableToneMapping and 1 or 0)
        mat:setInt("u_toneMappingType", self.TONE_MAPPING_TYPES[self.toneMappingType])
    end

    local currentSpeed = self.speed;
    local currentDuration = self.duration
    

    -- VAT animation update
    if isEditor then
        self.curTime = self.curTime + deltaTime
        if self.autoplay then
            self.progress = self.curTime * currentSpeed % currentDuration / currentDuration
        end
    elseif self.AEPlugin then
        self.progress = self.curTime * currentSpeed % currentDuration / currentDuration
    else
        self.progress = self.aeTime * currentSpeed % currentDuration / currentDuration
    end

    local currentP = self.attrs:GetVal("ADBE_Time_Remapping_0_0", self.progress)[1]
    currentP = currentP / 2.0
    self:updateVAT(currentP)
end

function VATPBR:calculateTransform()
    if not self.OutputTex or not self.InputTex then
        return
    end

    local canvasWidth = self.OutputTex.width
    local canvasHeight = self.OutputTex.height
    local aspect = canvasWidth / canvasHeight

    local isLandscape = canvasWidth > canvasHeight
    local rotate = (isLandscape and self.rotateOnLandscape) and 90 or self.rotateUV
    -- local camOrthoScale = isLandscape and self.camOrthoScale or self.camOrthoScale / aspect
    local camOrthoScale = isLandscape and self.camOrthoScale * aspect or self.camOrthoScale / aspect

    self.camVATXform.localPosition = Amaz.Vector3f(self.camPosX, self.camPosY, self.camPosZ)
    self.camVATXform.localRotation = Amaz.Quaternionf.axisAngleToQuaternion(Amaz.Vector3f(0, 1, 0),
        math.rad(self.camRotY)) * Amaz.Quaternionf.axisAngleToQuaternion(Amaz.Vector3f(1, 0, 0), math.rad(self.camRotX)) *
                                         Amaz.Quaternionf
                                             .axisAngleToQuaternion(Amaz.Vector3f(0, 0, 1), math.rad(self.camRotZ))

    -- Set rotation values
    self.direction.z = isLandscape and -rotate or 0
    self.rotateUV = rotate

    -- Set scale values
    -- self.scale.x = isLandscape and camOrthoScale or aspect
    -- self.scale.y = isLandscape and camOrthoScale or aspect
    self.scale.x = isLandscape and camOrthoScale or 1.0
    self.scale.y = isLandscape and camOrthoScale or 1.0

    -- Set UV scales
    -- local scaleX = camOrthoScale * aspect
    -- local scaleY = camOrthoScale
    local scaleX = 1.0 * (isLandscape and 1.0 or aspect)
    local scaleY = 1.0 * (isLandscape and 1.0 / aspect or 1.0)

    self.scaleUV.x = scaleX
    self.scaleUV.y = scaleY
    self.offsetUV.x = 0.5
    self.offsetUV.y = 0.5

    if not isLandscape then
        self.camVAT.orthoScale = camOrthoScale
    end

    -- Apply mesh transforms
    self.pivotXform.localPosition = Amaz.Vector3f(self.pivot.x, self.pivot.y, self.pivot.z)
    self.pivotXform.localScale = Amaz.Vector3f(1, 1, 1)
    self:rotateByAxis(self.pivotXform, Amaz.Vector3f(0, 0, 0), Amaz.Vector3f(0, 0, 0))

    self.vatXform.localPosition = Amaz.Vector3f(self.positionX, self.positionY, self.positionZ)
    self.vatXform.localScale = self.scale
    self:rotateByAxis(self.vatXform, self.direction, self.rotation)

end

function VATPBR:applyEasing(t, type)
    local strength = self.curveStrength

    if type == self.curveTypeList[0] then
        return t
    elseif type == self.curveTypeList[1] then
        return pow(t, 1 + strength)
    elseif type == self.curveTypeList[2] then
        return 1 - pow(1 - t, 1 + strength)
    elseif type == self.curveTypeList[3] then
        t = t * 2
        if t < 1 then
            return 0.5 * pow(t, 1 + strength)
        else
            return 1 - 0.5 * pow(2 - t, 1 + strength)
        end
    elseif type == self.curveTypeList[4] then
        return 1 - (math.cos(t * math.pi * strength) * math.exp(-strength * t))
    elseif type == self.curveTypeList[5] then
        return t * (1 + (t * strength))
    elseif type == self.curveTypeList[6] then
        return t * (1 + ((1 - t) * strength))
    elseif type == self.curveTypeList[7] then
        local rushFactor = math.exp(-3 * t) * strength
        return t * (1 + rushFactor)
    elseif type == self.curveTypeList[8] then
        local mid = 0.5
        local burstCurve = math.exp(-16 * (t - mid) * (t - mid)) * strength
        return t * (1 + burstCurve)
    end
    return t
end

function VATPBR:calculateFrameWithCurve(progress)
    local frameRange = self.endFrame - self.startFrame + 1
    local curveRange = self.curveEndFrame - self.curveStartFrame + 1
    local currentFrame = self.startFrame + progress * frameRange

    if currentFrame >= self.curveStartFrame and currentFrame <= self.curveEndFrame then
        local curveProgress = (currentFrame - self.curveStartFrame) / curveRange
        local easedProgress = self:applyEasing(curveProgress, self.curveType)
        currentFrame = self.curveStartFrame + (easedProgress * curveRange)
    end

    return math.max(self.startFrame, math.min(currentFrame, self.endFrame))
end

function VATPBR:updateVAT(progress)

    local exposure = self.attrs:GetVal("ADBE_IE_8cb17a2f56325a949dc60f2_0002_0_0", progress * 1.25)[1]
    local threshold = self.attrs:GetVal("ADBE_IE_8cb17a2f56325a949dc60f2_0003_0_1", progress * 1.25)[1]
    local blendAlpha = self.attrs:GetVal("ADBE_Opacity_0_0", progress * 1.25)[1] 
    blendAlpha = blendAlpha / 100.0
    -- Amaz.LOGI("sjw" , blendAlpha)

    local frameCount = self.frameCount
    local displayFrame = self:calculateFrameWithCurve(progress * 0.733)
    local finalFrame = (isEditor and self.frameByFrame) and self.displayFrame or displayFrame
     
    -- frontContrast-script
    if self.first then
        self.luaScript = Amaz.ScriptUtils.getLuaObj(self.contrastComp:getScript())
        self.luaScriptDeepGlow = Amaz.ScriptUtils.getLuaObj(self.deepGlowComp:getScript())
        self.first = false
    end
    local intensityCur = mix(self.luaScript.contrastIntensity , 1.0 , math.min(math.max(progress - 0.54 , 0.0) , 1.0) * 2.17)
    self.luaScript.currentIntensity = intensityCur

    local aph = math.min(math.max((progress - 0.9) * 10.0 , 0.0) , 1.0)
    self.blendPass.material:setFloat("u_prograss" , aph)
    self.blendPass.material:setTex("u_blendTex" , self.blendTex)
    self.blendPass.material:setFloat("u_blendAlpha" , blendAlpha)

    self.luaScriptDeepGlow.threshold = threshold / 100.0
    self.luaScriptDeepGlow.exposure = exposure

    -- Update materials in groups of 3, mapping to corresponding textures
    for i = 0, 2 do -- For each set of materials (0,1,2)
        local posTex = self.posTexs:get(i)
        local rotTex = self.rotTexs:get(i)
        local colTex = self.colTexs:get(i)

        -- Get the 3 materials corresponding to this set
        local baseIndex = i * 3 + 1 -- Convert to 1-based indexing
        for j = 0, 2 do
            local mat = self.sharedMaterials[baseIndex + j]
            if mat then
                mat:setFloat("u_displayFrame", finalFrame)
                mat:setFloat("u_frameCount", frameCount)
                mat:setTex("u_posTex", posTex)
                mat:setTex("u_rotTex", rotTex)
                mat:setTex("u_colTex", colTex)

                mat:setFloat("u_prograss" , math.min(math.max((progress - 0.87)*7.7 , 0.0) , 1.0))
            end
        end
    end
end

function VATPBR:updateLighting(mat)
    self:updateDirectionalLight(mat)
    self:updatePointLight(mat)
    self:updateSpotLight(mat)
    self:updateEnvironmentLight(mat)
    self:updateLightingProperties(mat)
end

function VATPBR:updateDirectionalLight(mat)
    local dirEnabled = self.enableDirLight and 1.0 or 0.0
    mat:setFloat("u_dirLightEnabled", dirEnabled)
    mat:setVec3("u_dirLightColor", Amaz.Vector3f(self.dirLightColor.r, self.dirLightColor.g, self.dirLightColor.b))
    mat:setFloat("u_dirLightIntensity", self.dirLightIntensity)

    local neutral = Amaz.Vector3f(0, 0, 0)
    self:rotateByAxis(self.dirLightXform, neutral, self.dirLightDir)
    local dirLightQuat = self.dirLightXform.localOrientation
    local forward = Amaz.Vector3f(0, 0, -1)
    local dirLightDirection = Amaz.Quaternionf.rotateVectorByQuat(dirLightQuat, forward)
    mat:setVec3("u_dirLightDirection", dirLightDirection)
end

function VATPBR:updatePointLight(mat)
    local pointEnabled = self.enablePointLight and 1.0 or 0.0
    mat:setFloat("u_pointLightEnabled", pointEnabled)
    mat:setVec3("u_pointLightPosition",
        Amaz.Vector3f(self.pointLightPos.x, -self.pointLightPos.y, -self.pointLightPos.z))
    mat:setFloat("u_pointLightIntensity", self.pointLightIntensity)
    mat:setVec3("u_pointLightColor",
        Amaz.Vector3f(self.pointLightColor.r, self.pointLightColor.g, self.pointLightColor.b))
    mat:setFloat("u_pointLightAttenRangeInv", 1.0 / self.pointLightAttenRangeInv)
end

function VATPBR:updateSpotLight(mat)
    local spotEnabled = self.enableSpotLight and 1.0 or 0.0
    mat:setFloat("u_spotLightEnabled", spotEnabled)
    mat:setFloat("u_spotLightIntensity", self.spotLightIntensity)
    mat:setVec3("u_spotLightPosition", Amaz.Vector3f(self.spotLightPos.x, self.spotLightPos.y, self.spotLightPos.z))
    mat:setVec3("u_spotLightColor", Amaz.Vector3f(self.spotLightColor.r, self.spotLightColor.g, self.spotLightColor.b))
    mat:setFloat("u_spotLightAttenRangeInv", 1.0 / self.spotLightAttenRangeInv)
    mat:setFloat("u_spotLightInnerAngleCos", math.rad(self.spotLightInnerAngle))
    mat:setFloat("u_spotLightOuterAngleCos", math.rad(self.spotLightOuterAngle))

    local spotLightQuat = self.spotLightXform.localOrientation
    local forward = Amaz.Vector3f(0, 0, -1)
    local spotLightDirection = Amaz.Quaternionf.rotateVectorByQuat(spotLightQuat, forward)
    mat:setVec3("u_spotLightDirection", spotLightDirection)
end

function VATPBR:updateEnvironmentLight(mat)
    local envEnabled = self.enableEnv and 1.0 or 0.0
    mat:setFloat("u_envEnabled", envEnabled)
    mat:setTex("u_envTex", self.envTex)
    mat:setFloat("u_envInt", self.envLightIntensity)
    mat:setFloat("u_envRot", math.rad(self.envLightRotation))
    mat:setFloat("u_envMipLevel", self.envMapMipLevel)
end

function VATPBR:updateLightingProperties(mat)
    mat:setFloat("u_lightingBlend", self.lightingBlend)
    mat:setFloat("u_vertexShadowInt", self.vertexShadowInt)
    mat:setFloat("u_vertexShadowContrast", self.vertexShadowContrast)
    mat:setVec3("u_vertexShadowColor",
        Amaz.Vector3f(self.vertexShadowColor.r, self.vertexShadowColor.g, self.vertexShadowColor.b))
end

exports.VATPBR = VATPBR
return exports
