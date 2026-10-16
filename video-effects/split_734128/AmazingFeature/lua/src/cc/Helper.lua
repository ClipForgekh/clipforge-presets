local Helper = {}

---@param scene Scene
---@param rootName string
---@param order number|nil
---@param maxBits number|nil
---@return number, number
function Helper.initPipeline (scene, rootName, order, maxBits)
    maxBits = maxBits or 64
    order = order or 0
    local function setLayerRecursion (parent, lastOrder)
        local entity = parent.entity
        local camera = entity:getComponent("Camera")
        if camera then
            lastOrder = lastOrder + 1
            entity.layer = 0
            camera.renderOrder = lastOrder
            camera.layerVisibleMask = Amaz.DynamicBitset.new(maxBits, "0x0"):set(lastOrder, true)
        else
            entity.layer = lastOrder
        end
        for i = 0, parent.children:size() - 1 do
            local child =  parent.children:get(i)
            lastOrder = setLayerRecursion(child, lastOrder)
        end
        return lastOrder
    end
    return setLayerRecursion(scene:findEntityBy(rootName):getComponent("Transform"), order)
end

---@vararg any[]
function Helper.linkPipeline1 (...)
    local queue = {...}
    local input = table.remove(queue)
    while #queue > 0 do
        local effect = table.remove(queue)
        local output = table.remove(queue)
        if type(input) == "table" then
            for i, tex in ipairs(input) do
                effect["input"..i] = tex
            end
        else
            effect.input = input
        end
        if type(output) == "table" then
            for i, fb in ipairs(output) do
                effect["output"..i] = fb
            end
        else
            effect.output = output
        end
        input = output
    end
end


---@param
---@return
function Helper.getLuaObject (comp)
    local script = comp:getScript()
    if script then
        return Amaz.ScriptUtils.getLuaObj(script)
    end
end

return Helper