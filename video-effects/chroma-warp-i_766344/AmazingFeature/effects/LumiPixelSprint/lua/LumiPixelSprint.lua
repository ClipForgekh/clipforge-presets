local exports = exports or {}

---@class LumiPixelSprint: ScriptComponent
---@field pixelSprintIntensity number [UI(Range={0., 1.}, Drag)]
---@field centerX number [UI(Range={0., 1.}, Drag)]
---@field centerY number [UI(Range={0., 1.}, Drag)]
---@field dLUT Texture
---@field sLUT Texture
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

local LumiPixelSprint = LumiPixelSprint or {}
LumiPixelSprint.__index = LumiPixelSprint

function LumiPixelSprint.new(construct, ...)
    local self = setmetatable({}, LumiPixelSprint)

    if construct and LumiPixelSprint.constructor then
        LumiPixelSprint.constructor(self, ...)
    end
    -- user parameters
    self.pixelSprintIntensity = 1
    self.centerX = 0.5
    self.centerY = 0.5
    self.sLUT = nil
    self.dLUT = nil
    self.InputTex = nil
    self.OutputTex = nil
    return self
end

function LumiPixelSprint:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _comp)
        if self[_key] ~= nil then
            self[_key] = _value
            if _comp and _comp.properties ~= nil then
                _comp.properties:set(_key, _value)
            end
        end
    end
    _setEffectAttr(key, value, comp)
end

function LumiPixelSprint:onStart(comp)
    local root = comp.entity
    self.depthCam = root:searchEntity("CamDepth"):getComponent("Camera")
    self.depth = root:searchEntity("PassDepth"):getComponent("MeshRenderer").material

    self.mainCam = root:searchEntity("CamMain"):getComponent("Camera")
    self.main = root:searchEntity("PassMain"):getComponent("MeshRenderer").material

    if self.lumiSharedRt and self.lumiSharedRt:size() >= 1 then
        self.midTex = self.lumiSharedRt:get(0)
    end

end

function LumiPixelSprint:onUpdate(comp, deltaTime)

    if self.midTex and self.OutputTex then
        if self.midTex.width ~= self.OutputTex.width or self.midTex.height ~= self.OutputTex.height then
            self.midTex.width = self.OutputTex.width
            self.midTex.height = self.OutputTex.height
        end
    end

    self.depth:setTex("u_inputImageTexture", self.InputTex)
    self.depthCam.renderTexture = self.midTex
    self.depth:setTex("u_depthFilter", self.dLUT)

    self.mainCam.renderTexture = self.OutputTex
    self.main:setTex("u_diffuseMap", self.InputTex)
    self.main:setTex("u_depthMap", self.midTex)
    self.main:setTex("u_sFilterTex", self.sLUT)
    self.main:setVec3("u_viewPos", Amaz.Vector3f(self.mix(-1, 1, self.centerX), self.mix(-1, 1, self.centerY), 2.0))
    self.main:setVec2("u_center", Amaz.Vector2f(self.centerX, self.centerY))
    self.main:setFloat("u_heightScale", self.pixelSprintIntensity)
    self.main:setFloat("u_intensity", self.pixelSprintIntensity)
end

function LumiPixelSprint.mix(a, b, t)
    return a + (b - a) * t
end

exports.LumiPixelSprint = LumiPixelSprint
return exports
