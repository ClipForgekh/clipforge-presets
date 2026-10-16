local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local Lumi4Color = Lumi4Color or {}
Lumi4Color.__index = Lumi4Color
---@class Lumi4Color : ScriptComponent
---@field point1 Vector2f
---@field color1 Color [UI(NoAlpha)]
---@field point2 Vector2f
---@field color2 Color [UI(NoAlpha)]
---@field point3 Vector2f
---@field color3 Color [UI(NoAlpha)]
---@field point4 Vector2f
---@field color4 Color [UI(NoAlpha)]
---@field blend double [UI(Display="Blend", Range={10, 10000}, Drag)]
---@field dithering double [UI(Display="Dithering", Range={0, 1}, Drag)]
---@field opacity double [UI(Display="Opacity", Range={0, 1}, Drag)]
---@field blendMode string [UI(Option={"None", "Normal", "Add", "Multiply", "Screen", "Overlay", "Soft Light", "Hard Light", "Color Dodge", "Color Burn", "Darken", "Lighten", "Difference", "Exclusion", "Hue", "Saturation", "Color", "Luminosity"})]
---@field InputTex Texture
---@field OutputTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function Lumi4Color.new(construct, ...)
    local self = setmetatable({}, Lumi4Color)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.InputTex = nil
    self.OutputTex = nil

    self.point1 = Amaz.Vector2f(0.1, 0.1)
    self.color1 = Amaz.Color(1, 1, 0)

    self.point2 = Amaz.Vector2f(0.9, 0.1)
    self.color2 = Amaz.Color(0, 1, 0)

    self.point3 = Amaz.Vector2f(0.1, 0.9)
    self.color3 = Amaz.Color(1, 0, 1)

    self.point4 = Amaz.Vector2f(0.9, 0.9)
    self.color4 = Amaz.Color(0, 0, 1)
    self.blend = 100
    self.dithering = 0
    self.opacity = 1
    self.blendMode = "None"

    self.MODE_QUERY = {
        [0] = "None",
        "Normal",
        "Add",
        "Multiply",
        "Screen",
        "Overlay",
        "Soft Light",
        "Hard Light",
        "Color Dodge",
        "Color Burn",
        "Darken",
        "Lighten",
        "Difference",
        "Exclusion",
        "Hue",
        "Saturation",
        "Color",
        "Luminosity",
        ["None"] = 0,
        ["Normal"] = 1,
        ["Add"] = 2,
        ["Multiply"] = 3,
        ["Screen"] = 4,
        ["Overlay"] = 5,
        ["Soft Light"] = 6,
        ["Hard Light"] = 7,
        ["Color Dodge"] = 8,
        ["Color Burn"] = 9,
        ["Darken"] = 10,
        ["Lighten"] = 11,
        ["Difference"] = 12,
        ["Exclusion"] = 13,
        ["Hue"] = 14,
        ["Saturation"] = 15,
        ["Color"] = 16,
        ["Luminosity"] = 17
    }
    self.DESIGN_SIZE = 1
    return self
end

function Lumi4Color:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "blendMode" then
        value = math.max(0, math.min(value, #self.MODE_QUERY))
        value = self.MODE_QUERY[value]
        _setEffectAttr(key, value)
    elseif key == "point1" then
        value.y = 1.0 - value.y
        _setEffectAttr(key, value)
    elseif key == "point2" then
        value.y = 1.0 - value.y
        _setEffectAttr(key, value)
    elseif key == "point3" then
        value.y = 1.0 - value.y
        _setEffectAttr(key, value)
    elseif key == "point4" then
        value.y = 1.0 - value.y
        _setEffectAttr(key, value)
    else
        _setEffectAttr(key, value)
    end
end

function Lumi4Color:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    -- Use entity instead of scene
    self.camera = self.entity:searchEntity("Camera4Color")
                      :getComponent("Camera")
    self.material = self.entity:searchEntity("Pass4Color"):getComponent(
                        "MeshRenderer").material
end

function Lumi4Color:onUpdate(comp, deltaTime)
    -- set the input and output textures to be displayed
    local w = self.DESIGN_SIZE
    local h = self.DESIGN_SIZE
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
        w = self.OutputTex.width
        h = self.OutputTex.height
        local s = self.DESIGN_SIZE / math.min(w, h)
        w = w * s
        h = h * s
    end

    local c1 = self.color1
    local c2 = self.color2
    local c3 = self.color3
    local c4 = self.color4
    local ra = (c1.r + c2.r + c3.r + c4.r) * 0.25
    local ga = (c1.g + c2.g + c3.g + c4.g) * 0.25
    local ba = (c1.b + c2.b + c3.b + c4.b) * 0.25
    local max = math.max
    local abs = math.abs
    local rd = max(max(max(abs(c1.r - ra), abs(c2.r - ra)), abs(c3.r - ra)),
                   abs(c4.r - ra))
    local gd = max(max(max(abs(c1.g - ga), abs(c2.g - ga)), abs(c3.g - ga)),
                   abs(c4.g - ga))
    local bd = max(max(max(abs(c1.b - ba), abs(c2.b - ba)), abs(c3.b - ba)),
                   abs(c4.b - ba))

    self.material:setTex("u_inputTexture", self.InputTex)
    self.material:setInt("u_blendMode", self.MODE_QUERY[self.blendMode])
    self.material:setVec2("u_screenSize", Amaz.Vector2f(w, h))

    self.material:setVec4("u_colorA", Amaz.Vector4f(ra, ga, ba, 1))
    self.material:setVec4("u_colorD", Amaz.Vector4f(rd, gd, bd, 1))

    self.material:setVec2("u_point1",
                          Amaz.Vector2f(w * self.point1.x, h * self.point1.y))
    self.material:setVec4("u_color1", Amaz.Vector4f(c1.r, c1.g, c1.b, 1))

    self.material:setVec2("u_point2",
                          Amaz.Vector2f(w * self.point2.x, h * self.point2.y))
    self.material:setVec4("u_color2", Amaz.Vector4f(c2.r, c2.g, c2.b, 1))

    self.material:setVec2("u_point3",
                          Amaz.Vector2f(w * self.point3.x, h * self.point3.y))
    self.material:setVec4("u_color3", Amaz.Vector4f(c3.r, c3.g, c3.b, 1))

    self.material:setVec2("u_point4",
                          Amaz.Vector2f(w * self.point4.x, h * self.point4.y))
    self.material:setVec4("u_color4", Amaz.Vector4f(c4.r, c4.g, c4.b, 1))

    self.material:setFloat("u_dithering", self.dithering * 0.1)
    self.material:setFloat("u_opacity", self.opacity)

    local blend = math.log(self.blend / 10) / math.log(1000)
    blend = math.pow(blend, 6) * 100

    self.material:setFloat("u_blend", blend)
    self.material:setFloat("u_size_", 0.03)
    self.material:setFloat("u_seed_", 0)
end

function Lumi4Color.mix(x, y, a) return x + (y - x) * a end
function Lumi4Color.step(edge0, edge1, value)
    return math.min(math.max(0, (value - edge0) / (edge1 - edge0)), 1)
end

exports.Lumi4Color = Lumi4Color
return exports
