--write by @yuyubin
--use by includeRelativePath("EntityLua")

---@class EntityLua
----@field entity Entity
----@field camera Camera
----@field animSeqComponent AnimSeqComponent
----@field transform Transform
----@field meshRenderer MeshRenderer
----@field tableComponent TableComponent
----@field scriptComponent ScriptComponent
----@field faceCapture FaceCapture
----@field material Material

local EntityLua = {}
EntityLua.__index = EntityLua

local EntityLuaTools = {}
EntityLuaTools.__index = EntityLuaTools

---@param scene Scene
---@param names string[]
---@return table<string, EntityLua>
function EntityLuaTools:getEntityLuasByName(scene, names, ...)
    local entityLuas = {}
    for i = 1, #names do
        local entity = scene:findEntityBy(names[i])
        entityLuas[names[i]] = EntityLua.new(entity, ...)
    end
    return entityLuas
end

--- Get all entities in the scene
---@param scene Scene
---@return table<string, EntityLua>
function EntityLuaTools:getAllEntityLuasInScene(scene, ...)
    local entityLuas = {}
    local entities = scene.entities
    for i = 1, entities:size() do
        local entity = entities:get(i - 1)
        entityLuas[entity.name] = EntityLua.new(entity, ...)
    end
    return entityLuas
end

---@param entity Entity
---@return EntityLua
function EntityLua.new(entity, ...)
    local o = {}
    o = setmetatable(o, EntityLua)
    local getMaterial = false
    if #{...} > 0 then
        local parameterList = ({...})[1]
        if parameterList.getMaterial then
            getMaterial = true
        end
    end
    o.entity = entity
    if entity then
        o.camera = entity:getComponent("Camera")
        o.meshRenderer = entity:getComponent("MeshRenderer")
        o.transform = entity:getComponent("Transform")
        o.animSeqComponent = entity:getComponent("AnimSeqComponent")
        o.tableComponent = entity:getComponent("TableComponent")
        o.scriptComponent = entity:getComponent("ScriptComponent")
        o.faceCapture = entity:getComponent("FaceCapture")
        if o.meshRenderer and getMaterial then
            o.material = o.meshRenderer.material
        end
    end
    return o
end

--Get the information in the table through the key
function EntityLua:getTableComponentContent(key)
    if self.tableComponent then
        if self.tableComponent.table:has(key) then
            return self.tableComponent.table:get(key)
        end
    end
    return nil
end

function EntityLua:getLuaObj()
    if self.scriptComponent then
        local script = self.scriptComponent:getScript()
        if script then
            self.luaObj = Amaz.ScriptUtils.getLuaObj(script)
            return self.luaObj
        end
    end
    return nil
end

function EntityLua:setWorldOrientationByEuler(euler)
    if self.transform then
        self.transform:setWorldOrientation(Amaz.Quaternionf.eulerToQuaternion(euler))
        return true
    end
    return false
end

function EntityLua:setLocalOrientationByEuler(euler)
    if self.transform then
        self.transform.localOrientation = Amaz.Quaternionf.eulerToQuaternion(euler)
        return true
    end
    return false
end

--Get animation playback time
function EntityLua:getSeqPlayTime()
    if self.animSeqComponent then
        local seq = self.animSeqComponent.animSeq
        return seq:getFrameCount() / (seq.fps * self.animSeqComponent.speed)
    end
    return 0
end

---@param times number @The number of times the sequence frame is played
function EntityLua:playSeqOnTimeByTimes(nowtime, times)
    local seqTime = self:getSeqPlayTime() * times
    if seqTime > nowtime then
        self.entity.visible = true
        self.animSeqComponent:seekToTime(nowtime)
    else
        self.animSeqComponent:seekToTime(seqTime)
        self.entity.visible = false
    end
end


---@param macros string 
---@param macrosValue int
---@param passNum int
---@param addMacroType int
--when addMacroType = 0,only use macros in vert;
--when addMacroType = 1,only use macros in frag;
--when addMacroType = 2,use macros both in vert and frag;
function EntityLua:enableMacro(macros, macrosValue, passNum, addMacroType)
    if self.meshRenderer then
        self.material = self.meshRenderer.material
        if self.material then
            local xshader = self.material.xshader
            if xshader then
                local passes = xshader.passes
                if passes:size() > passNum then
                    ---@type Pass
                    local pass = passes:get(passNum)
                    local shadersMap = pass.shaders
                    local glslType = shadersMap:getVectorKeys()
                    for i = 0, glslType:size() - 1, 1 do
                        local shaders = shadersMap:get(glslType:get(i))
                        for j = 0, shaders:size() - 1, 1 do
                            ---@type Shader
                            local shader = shaders:get(j)
                            if addMacroType == 0 or addMacroType == 2 then
                                if shader.type == Amaz.ShaderType.VERTEX then
                                    if shader.macros:find(macros) < 0 then
                                        shader.macros:pushBack(macros)
                                    end
                                end
                            end
                            if addMacroType == 1 or addMacroType == 2 then
                                if shader.type == Amaz.ShaderType.FRAGMENT then
                                    if shader.macros:find(macros) < 0 then
                                        shader.macros:pushBack(macros)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            self.material:enableMacro(macros, macrosValue)
        end
    end
end

return EntityLuaTools
