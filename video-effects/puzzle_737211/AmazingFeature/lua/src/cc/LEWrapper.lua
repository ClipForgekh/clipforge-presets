
---@class LEWrapper
local LEWrapper = {}


---@param sceneOrEntity Scene | Entity
---@param name string | nil
function LEWrapper:new (sceneOrEntity, name)
    if name then
        sceneOrEntity = sceneOrEntity:findEntityBy(name)
    end
    return setmetatable({
        _nativeRef = sceneOrEntity:getComponent("ScriptComponent"),
    }, self)
end


function LEWrapper:__index (var)
    if self._nativeRef.properties:has(var) then
        return self._nativeRef.properties:get(var)
    end
end

function LEWrapper:__newindex (var, value)
    self._nativeRef.properties:set(var, value)
end


return LEWrapper