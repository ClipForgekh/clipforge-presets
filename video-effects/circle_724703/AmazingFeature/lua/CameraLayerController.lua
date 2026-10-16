local exports = exports or {}
local CameraLayerController = CameraLayerController or {}
CameraLayerController.__index = CameraLayerController
---@class CameraLayerController: ScriptComponent
----@field addNum Int [UI(Range={0, 64}, Drag=1)]


function CameraLayerController.new(construct, ...)
    local o = setmetatable({}, CameraLayerController)
    o.addNum = 0
    return o
end

local function changeLayer(entity, addNum)
    if entity and entity:getComponent("Transform") then
        local children = entity:getComponent("Transform").children
        if children:size() == 0 then
            return
        end
        for i = 1, children:size() do
            local tmpEntity = children:get(i-1).entity
            tmpEntity.layer = tmpEntity.layer + addNum
            changeLayer(tmpEntity, addNum)
        end
    end
end

local function getMaskIdxList(mask)
    local res = {}
    for i = 1, 64 do
        if mask:test(i-1) then
            table.insert(res, i-1)
        end
    end
    return res
end

local function get16to10(numStr)
    return tonumber(string.format("%d",tostring(numStr)))
end

local function get10to16(str)
    -- body
end

local function getLayerMask16(str)
    local numStr = string.sub(tostring(str), 9, 10)
    return string.format("%#x", numStr)
end

local function getLayerMaskNum(str)
    local idx1 = string.find(str, ":")
    local idx2 = string.find(str, ";")
    return tonumber(string.sub(str, idx1+1, idx2-1))
end

-- layermask must < 64
---@function [UI(Button="add layer")]
function CameraLayerController:addLayer()
    local childList = self.rootEntity:getComponent("Transform").children
    for i = 1, childList:size() do
        local camera = childList:get(i-1).entity:getComponent("Camera")
        local idxList = getMaskIdxList(camera.layerVisibleMask)
        
        for i = 1, #idxList do
            local value = idxList[i] + self.addNum
            if value >= getLayerMaskNum(tostring(camera.layerVisibleMask)) then
                camera.layerVisibleMask = Amaz.DynamicBitset.new(value + 1, "0x0")
            end
        end

        local layerMask = camera.layerVisibleMask
        for i = 1, #idxList do
            layerMask:set(idxList[i] , false)
        end
        
        for i = 1, #idxList do
            local value = idxList[i] + self.addNum
            -- Amaz.LOGI("lrc", value)
            layerMask:set(value , true)
        end

        camera.layerVisibleMask = layerMask

        camera.renderOrder = camera.renderOrder + self.addNum
        changeLayer(camera.entity, self.addNum)
    end
end

local function handleAllEntityBySingleParent(_trans, func)
    if _trans.children:size() > 0 then
        for i = 1, _trans.children:size() do
            local child = _trans.children:get(i-1)
            handleAllEntityBySingleParent(child, func)
        end
    end
    func(_trans)
end

local function _updateLayerMaskByRenderOrder(_cam)
    local render_order = _cam.renderOrder
    local str = "1"
    for i = 1, render_order do
        str = str.."0"
    end
    local dynamic_bitset = Amaz.DynamicBitset.new(str)

    _cam.layerVisibleMask = dynamic_bitset
end

-- local function _findCameraRenderObject(_cam)
--     local dynamic_bitset = _cam.layerVisibleMask
--     -- todo: find the numblock
--     local res = {}
--     for i = 1, 64 do
        
--         if dynamic_bitset:test(i-1) == true then

--         end
--     end
-- end

---@function [UI(Button="sort by scene order")]
function CameraLayerController:Sorted()
    local childList = self.rootEntity:getComponent("Transform").children
    local tmp_cam_list = {}
    local tmp_renderer_list = {}
    for i = 1, childList:size() do
        local function handle(_trans)
            local cam = _trans.entity:getComponent("Camera")
            local renderer = _trans.entity:getComponent("Renderer")

            local target_order = i + self.addNum

            if cam then
                table.insert(tmp_cam_list, cam)
                -- cam.renderOrder = target_order
                -- _updateLayerMaskByRenderOrder(cam)
            end

            if renderer then
                table.insert(tmp_renderer_list, renderer)
                -- renderer.entity.layer = target_order
            end
        end
        
        handleAllEntityBySingleParent(childList:get(i-1), handle)
    end

    for i = 1, #tmp_cam_list do
        local cam = tmp_cam_list[i]
        local renderer = tmp_renderer_list[i]

        local target_order = i + self.addNum
        cam.renderOrder = target_order
        _updateLayerMaskByRenderOrder(cam)
        renderer.entity.layer = target_order
    end

end

function CameraLayerController:constructor()
end

function CameraLayerController:onStart(comp)
    self.rootEntity = comp.entity
end

exports.CameraLayerController = CameraLayerController
return exports
