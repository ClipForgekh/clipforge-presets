local exports = exports or {}
local Utils = Utils or {}
Utils.__index = Utils

function Utils.new(construct, ...)
    local self = setmetatable({}, Utils)

    self.rotateOnLandscape = true
    self.rotateUV = 0
    self.offsetUV = Amaz.Vector2f(0, 0)
    self.scaleUV = Amaz.Vector2f(1, 1)
    self.padding = Amaz.Vector2f(0.01, 0.01)
    self.edgeType = "Tile"
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

end

function Utils:constructor()
end

function Utils:createRenderTexture(width, height, is2D)
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

function Utils:updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

function Utils:setRenderTexture(camera, rt)
    if rt then
        camera.renderTexture = rt
    end
end

function Utils:remap(value, min, max, newMin, newMax)
    return newMin + (value - min) * (newMax - newMin) / (max - min)
end

function Utils:initializeComponents(name, isXform)
    local cameraEntityName = "Cam" .. name
    local meshEntityName = "Pass" .. name

    local camera = self.entity:searchEntity(cameraEntityName):getComponent("Camera")
    local meshRenderer = self.entity:searchEntity(meshEntityName):getComponent("MeshRenderer")
    local transform = isXform and self.entity:searchEntity(meshEntityName):getComponent("Transform")

    return camera, meshRenderer and meshRenderer.material, transform
end

function Utils:rotateByAxis(_trans, _direction, _euler_angle)
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

function Utils:aspectXform()
end

exports.Utils = Utils
return exports
