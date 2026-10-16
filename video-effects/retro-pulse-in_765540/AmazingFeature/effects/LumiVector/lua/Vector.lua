local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local Vector = Vector or {}
Vector.__index = Vector
---@class Vector : ScriptComponent
---@field opacity double [UI(Display="Opacity", Range={0, 1}, Drag)]
---@field scale double [UI(Display="Scale", Range={0, 1}, Drag)]
---@field radius double [UI(Display="radius", Range={0, 256}, Drag)]
---@field maskWidth double
---@field maskHeight double
---@field maskPosition Vector2f
---@field isPercentagePos boolean
---@field rotation double [UI(Display="Rotation", Range={-360, 360}, Drag)]
---@field rotationPoint Vector2f [UI(Display="Rotation Point")]
---@field maskType string [UI(Option={"rectangle", "circle"})]
---@field rotateOnLandscape boolean [UI(Display="Rotate on Landscape")]

---@field InputTex Texture
---@field OutputTex Texture

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

function Vector.new(construct, ...)
    local self = setmetatable({}, Vector)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.radius = 0
    self.opacity = 1.0
    self.maskWidth = 50
    self.maskHeight = 70
    self.maskSize = Amaz.Vector2f(self.maskWidth, self.maskHeight)
    self.maskPosition = Amaz.Vector2f(0.5, 0.5)
    self.rotation = 0
    self.maskType = "rectangle"
    self.isPercentagePos = true
    self.rotationPoint = Amaz.Vector2f(50, 50)
    self.scale = 1.0
    self.screenSize = Amaz.Vector2f(0.0, 0.0)
    self.isLandscape = false
    self.rotateOnLandscape = true

    self.MASK_TYPE = {
        [0] = "rectangle",
        "circle",
        ["rectangle"] = 0,
        ["circle"] = 1
    }
    self.SIGMA = 2.5
    self.MAX_SOFT = 20
    return self
end

function Vector:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    if key == "maskType" or key == "maskType" then
        value = math.max(0, math.min(value, #self.MASK_TYPE))
        value = self.MASK_TYPE[value]
        _setEffectAttr(key, value)
    else
        _setEffectAttr(key, value)
    end
end

function Vector.uvTransform(screenSize, layers)
    local matrix = Amaz.Matrix4x4f()
    if screenSize then
        local last = layers[#layers]
        matrix:setScale(Amaz.Vector3f(1 / last.w, 1 / last.h, 1))
    else
        matrix:setIdentity()
    end
    for i = #layers, 1, -1 do
        local layer = layers[i]
        if layer.ax or layer.ay then
            local dx = layer.ax and layer.ax * layer.w or 0
            local dy = layer.ay and layer.ay * layer.h or 0
            matrix:translate(Amaz.Vector3f(dx, dy, 0))
        end
        if layer.r then
            local rotate = Amaz.Matrix4x4f()
            rotate:setTR(Amaz.Vector3f(0, 0, 0), Amaz.Quaternionf
                             .eulerToQuaternion(
                             Amaz.Vector3f(0, 0, -math.rad(layer.r))))
            matrix = matrix * rotate
        end
        if layer.s then
            matrix:scale(Amaz.Vector3f(1 / layer.s, 1 / layer.s, 1))
        elseif layer.sx or layer.sy then
            matrix:scale(Amaz.Vector3f(1 / layer.sx, 1 / layer.sy, 1))
        end
        if layer.x or layer.y then
            local x = layer.x and -layer.x or 0
            local y = layer.y and -layer.y or 0
            matrix:translate(Amaz.Vector3f(x, y, 0))
        end
    end
    if screenSize then
        matrix:scale(Amaz.Vector3f(screenSize.x, screenSize.y, 1))
    end
    return matrix
end

function Vector:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    -- Use entity instead of scene
    self.camInput = self.entity:searchEntity("CameraInput"):getComponent(
                        "Camera")
    self.matInput = self.entity:searchEntity("PassInput"):getComponent(
                        "MeshRenderer").material
end

function Vector:drawRectangle(scale, rotation, OutputTex, opacity,
                              isPercentagePos, maskWidth, maskHeight, matInput,
                              maskPosition, rotationPointX, rotationPointY,
                              radius, maskType)

    local halfMinEdge = math.min(OutputTex.width, OutputTex.height) * 0.5
    local radius = halfMinEdge * (radius / 256)
    matInput:setFloat("u_radius", radius)

    local fade0, fade1
    fade0 = -(halfMinEdge * 1 / 256) - 0.1
    fade1 = 0
    matInput:setFloat("u_fade0", fade0)
    matInput:setFloat("u_fade1", fade1)

    local maskSize = Amaz.Vector2f(0.0, 0.0)
    if isPercentagePos then
        maskSize = Amaz.Vector2f(maskWidth / 100 * OutputTex.width,
                                 maskHeight / 100 * OutputTex.height)
    else
        maskSize = Amaz.Vector2f(maskWidth, maskHeight)
    end
    matInput:setVec2("u_screenSize", maskSize)
    local pos = Amaz.Vector2f(0.0, 0.0);
    local rotationPoint = Amaz.Vector2f(0.0, 0.0)
    pos = Amaz.Vector2f(maskPosition.x, maskPosition.y)
    rotationPoint = Amaz.Vector2f(rotationPointX, rotationPointY)

    matInput:setFloat("u_angle", rotation)
    matInput:setVec2("u_rotationPoint", rotationPoint)
    matInput:setFloat("u_aspectRatio", maskSize.x / maskSize.y)
    matInput:setInt("u_maskType", maskType)
    matInput:setFloat("u_opacity", opacity)

    matInput:setMat4("u_mat",
                     Vector.uvTransform(
                         Amaz.Vector2f(OutputTex.width, OutputTex.height), {
            {
                w = maskSize.x,
                h = maskSize.y,
                ax = 0.5,
                ay = 0.5,
                x = OutputTex.width * pos.x,
                y = OutputTex.height * pos.y,
                s = scale
            }
        }))

end

function Vector:drawCircle(scale, rotation, OutputTex, opacity, isPercentagePos,
                           maskWidth, maskHeight, matInput, maskPosition,
                           rotationPointX, rotationPointY, maskType)

    matInput:setFloat("u_opacity", opacity)
    local maskSize = Amaz.Vector2f(0.0, 0.0)
    if isPercentagePos then
        maskSize = Amaz.Vector2f(maskWidth / 100, maskHeight / 100)
    else
        maskSize = Amaz.Vector2f(maskWidth / OutputTex.width,
                                 maskHeight / OutputTex.height)
    end
    matInput:setVec2("u_maskSize", maskSize)
    local pos = Amaz.Vector2f(0.0, 0.0);
    local rotationPoint = Amaz.Vector2f(0.0, 0.0)
    pos = Amaz.Vector2f(maskPosition.x, maskPosition.y)
    rotationPoint = Amaz.Vector2f(rotationPointX, rotationPointY)

    matInput:setFloat("u_angle", rotation)
    matInput:setVec2("u_rotationPoint", rotationPoint)
    matInput:setFloat("u_aspectRatio", maskSize.x / maskSize.y)

    matInput:setVec2("u_maskPosition", pos)
    matInput:setInt("u_maskType", maskType)
    matInput:setMat4("u_mat",
                     Vector.uvTransform(
                         Amaz.Vector2f(OutputTex.width, OutputTex.height), {
            {
                w = OutputTex.width,
                h = OutputTex.height,
                ax = pos.x,
                ay = pos.y,
                x = OutputTex.width * pos.x,
                y = OutputTex.height * pos.y,
                s = scale
            }, {
                w = OutputTex.width,
                h = OutputTex.height,
                ax = rotationPoint.x,
                ay = rotationPoint.y,
                x = OutputTex.width * rotationPoint.x,
                y = OutputTex.height * rotationPoint.y,
                r = rotation
            }
        }))
end

function Vector:onUpdate(comp, deltaTime)
    if self.OutputTex then
        self.matInput:setTex("u_inputTexture", self.InputTex)
        self.camInput.renderTexture = self.OutputTex
        local width = self.OutputTex.width
        local height = self.OutputTex.height
        self.isLandscape = width > height
        self.screenSize = Amaz.Vector2f(width, height)
        self.matInput:setVec2("u_screenSize", self.screenSize)
    end

    -- Only adjust dimensions if rotateOnLandscape is enabled
    local adjustedWidth = (self.isLandscape and self.rotateOnLandscape) and
                              self.maskHeight or self.maskWidth
    local adjustedHeight = (self.isLandscape and self.rotateOnLandscape) and
                               self.maskWidth or self.maskHeight
    local adjustedRotationPoint = Amaz.Vector2f(
                                      (self.isLandscape and
                                          self.rotateOnLandscape) and
                                          self.rotationPoint.y or
                                          self.rotationPoint.x,
                                      (self.isLandscape and
                                          self.rotateOnLandscape) and
                                          self.rotationPoint.x or
                                          self.rotationPoint.y)

    if self.MASK_TYPE[self.maskType] == 0 then
        Vector:drawRectangle(self.scale, self.rotation, self.OutputTex,
                             self.opacity, self.isPercentagePos, adjustedWidth,
                             adjustedHeight, self.matInput, self.maskPosition,
                             adjustedRotationPoint.x, adjustedRotationPoint.y,
                             self.radius, self.MASK_TYPE[self.maskType])
    end
    if self.MASK_TYPE[self.maskType] == 1 then
        Vector:drawCircle(self.scale, self.rotation, self.OutputTex,
                          self.opacity, self.isPercentagePos, adjustedWidth,
                          adjustedHeight, self.matInput, self.maskPosition,
                          adjustedRotationPoint.x, adjustedRotationPoint.y,
                          self.MASK_TYPE[self.maskType])
    end

end

exports.Vector = Vector
return exports
