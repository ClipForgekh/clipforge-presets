local exports = exports or {}

---@class ScriptCompPixelSprint: ScriptComponent
---@field pxielSprintIntensity number [UI(Range={0., 1.}, Drag)]
---@field centerX number [UI(Range={0., 1.}, Drag)]
---@field centerY number [UI(Range={0., 1.}, Drag)]
---@field dLUT Texture
---@field sLUT Texture
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]
local ScriptCompPixelSprint = ScriptCompPixelSprint or {}
ScriptCompPixelSprint.__index = ScriptCompPixelSprint


function ScriptCompPixelSprint.new(construct, ...)
    local self = setmetatable({}, ScriptCompPixelSprint)

    if construct and ScriptCompPixelSprint.constructor then ScriptCompPixelSprint.constructor(self, ...) end
    -- user parameters
    self.pxielSprintIntensity = 1
    self.centerX = 0.5
    self.centerY = 0.5
    self.sLUT = nil
    self.dLUT = nil
    self.InputTex = nil
    self.OutputTex = nil
    return self
end

function ScriptCompPixelSprint:setEffectAttr(key, value, comp)
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

function ScriptCompPixelSprint:onStart(comp)
    local root = comp.entity
    self.depthCam = root:searchEntity("PixelSprintCamera_depth"):getComponent("Camera")
    self.depth = root:searchEntity("PixelSprint_depth"):getComponent("MeshRenderer").material
    self.mainCam = root:searchEntity("PixelSprintCamera_main"):getComponent("Camera")
    self.main = root:searchEntity("PixelSprint_main"):getComponent("MeshRenderer").material
    self.blurCam = root:searchEntity("PixelSprintCamera_blur"):getComponent("Camera")
    self.blur = root:searchEntity("PixelSprint_blur"):getComponent("MeshRenderer").material
end

function ScriptCompPixelSprint:onUpdate(comp, deltaTime)
    local midTex
    if self.lumiSharedRt and self.lumiSharedRt:size() >= 1 then
        midTex = self.lumiSharedRt:get(0)
    end
    if midTex and self.OutputTex then
        if midTex.width ~= self.OutputTex.width or midTex.height ~= self.OutputTex.height then
            midTex.width = self.OutputTex.width
            midTex.height = self.OutputTex.height
        end
    end

    self.depth:setTex("u_inputImageTexture", self.InputTex)
    self.depthCam.renderTexture = self.OutputTex
    self.main:setTex("u_diffuseMap", self.InputTex)
    self.main:setTex("u_depthMap", self.OutputTex)
    self.mainCam.renderTexture = midTex
    self.blur:setTex("u_inputImageTexture", midTex)
    self.blurCam.renderTexture = self.OutputTex

    self.depth:setTex("u_depthFilter", self.dLUT)
    self.main:setTex("u_sFilterTex", self.sLUT)
    self.main:setVec3("u_viewPos", Amaz.Vector3f(self.mix(-1,1,self.centerX), self.mix(-1,1,self.centerY), 2.0))
    self.main:setVec2("u_center", Amaz.Vector2f(self.centerX, self.centerY))
    self.main:setFloat("u_heightScale", self.pxielSprintIntensity)
    self.main:setFloat("u_intensity", self.pxielSprintIntensity)
end

function ScriptCompPixelSprint.mix (a, b, t)
    return a + (b - a) * t
end

exports.ScriptCompPixelSprint = ScriptCompPixelSprint
return exports
