      
local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false

local exports = exports or {}
local LumiManager = LumiManager or {}
LumiManager.__index = LumiManager
---@class LumiManager : ScriptComponent
---@field debugTime number [UI(Range={0, 6}, Drag)]
---@field autoPlay boolean
---@field LumiEffectTrans Transform
---@field start_render_layer int
---@field start_render_order int
---@field InputTex Texture
---@field OutputTex Texture
---@field PingPongTex Texture




local function handleAllEntityBySingleParent(_trans, func, ...)
    if _trans.children:size() > 0 then
        for i = 1, _trans.children:size() do
            local child = _trans.children:get(i-1)
            handleAllEntityBySingleParent(child, func, ...)
        end
    end
    func(_trans, ...)
end

local AETools = AETools or {}
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
    ["ADBE_Opacity_0_1"]={
		{{0.33333333, 0, 0.666666669, 1, }, {22, 45, }, {{100, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
    ["ADBE_Opacity_0_2"]={
		-- {{0.33333333, 0, 0.666666667, 0.851851851, }, {22, 45, }, {{100, }, {0, }, }, {6417, }, {0, }, }, 
		{{0.33333333, 0, 0.666666667, 1, }, {22, 45, }, {{100, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
    ["ADBE_Opacity_0_4"]={
		{{0.33333333, 0, 0.66666667, 1, }, {22, 45, }, {{33, }, {100, }, }, {6417, }, {0, }, }, 
	}, 
    ["PaoPaoBlur_0_8"]={
		{{1, 0, 1, 1, }, {22, 42, }, {{0.8, }, {0, }, }, {6417, }, {0, }, }, 
	}, 
}

function LumiManager.new(construct, ...)
    local self = setmetatable({}, LumiManager)

    self.LumiEffectTrans = nil
    self.start_render_layer = 1
    self.start_render_order = 1

    self.InputTex = nil
    self.OutputTex = nil
    self.PingPongTex = nil

    self.startTime = 0.0
    self.endTime = 6.0
    self.curTime = 0.0

    self.speed = 1.0
    self.autoPlay = true
    self.debugTime = 0.0

    if construct and LumiManager.constructor then LumiManager.constructor(self, ...) end
    return self
end


function LumiManager:onStart(comp)
    self.entity = comp.entity
    self.trans = self.entity:getComponent("Transform")

    -- self.input = comp.entity.scene.assetMgr:SyncLoad("share://input.texture")
    -- self.output = comp.entity.scene.assetMgr:SyncLoad("rt/outputTex.rt")
    self.lumi_obj_extension = includeRelativePath("LumiObjectExtension")
    self.lumi_obj = nil

    self.keyframes = nil
    self.durations = nil
    self.params = nil
    self.compDurations = {0, 6}
    self.durationMode = 0
    self.disappearTime = 0
    self.sliderInfos = {}
    self.effectType = "effect"
    self.transitionInputIndex = {}

    self.LumiParamsSetter = includeRelativePath("LumiParamsSetter")
    local ae_export_data = includeRelativePath("LumiExportData")
    if ae_export_data then
        if ae_export_data.ae_keyframes then
            local ae_tools = includeRelativePath("AETools")
            if ae_tools then
                self.keyframes = ae_tools.new(ae_export_data.ae_keyframes)
            end
        end
        if ae_export_data.ae_durations ~= nil then
            self.durations = ae_export_data.ae_durations
        end
        if ae_export_data.ae_attribute ~= nil then
            self.params = ae_export_data.ae_attribute
        end
        if ae_export_data.ae_compDurations ~= nil then
            self.compDurations = ae_export_data.ae_compDurations
        end
        if ae_export_data.ae_durationMode ~= nil then
            self.durationMode = ae_export_data.ae_durationMode
        end
        if ae_export_data.ae_disappearTime ~= nil then
            self.disappearTime = ae_export_data.ae_disappearTime
        end
        if ae_export_data.ae_sliderInfos ~= nil then
            self.sliderInfos = ae_export_data.ae_sliderInfos
        end
        if ae_export_data.ae_effectType ~= nil then
            self.effectType = ae_export_data.ae_effectType
        end
        if ae_export_data.ae_transitionInputIndex ~= nil then
            self.transitionInputIndex = ae_export_data.ae_transitionInputIndex
        end
    end
    if self.LumiParamsSetter then
        self.lumi_params_setter = self.LumiParamsSetter.new(self.params, self.keyframes, self.sliderInfos)
    end

    self.opacity_127 = comp.entity.scene:findEntityBy("AE_Transform_127-trs"):getComponent("ScriptComponent").properties
    self.opacity_128 = comp.entity.scene:findEntityBy("AE_Transform_128-trs"):getComponent("ScriptComponent").properties
    self.aeTransform_129 = comp.entity.scene:findEntityBy("AE_Transform_129-trs"):getComponent("ScriptComponent").properties

    self.paopaoBlur = comp.entity.scene:findEntityBy("PaoPaoBlur"):getComponent("ScriptComponent").properties

    -- self.gaussian_127 = comp.entity.scene:findEntityBy("Gaussian_Blur_Root_127-effect1"):getComponent("ScriptComponent").properties
    -- self.gaussian_128 = comp.entity.scene:findEntityBy("Gaussian_Blur_Root_128-effect1"):getComponent("ScriptComponent").properties
    -- self.gaussian_129 = comp.entity.scene:findEntityBy("Gaussian_Blur_Root_129-effect1"):getComponent("ScriptComponent").properties
    self.attribute = AETools:new(ae_attribute)
end

function LumiManager:onDestroy(comp)
    if self.LumiEffectTrans and self.lumi_obj_extension then
        self.lumi_obj_extension.deregister(self.LumiEffectTrans.entity)
    end
    self.lumi_obj = nil
end

---@function [UI(Button="ReRender")]
function LumiManager:getCameraCount()
    if self.LumiEffectTrans == nil then
        return 0
    end

    self.lumi_obj = nil
    self:ReRender()

    local cam_count = 0
    if self.lumi_obj then
        cam_count = self.lumi_obj:getCameraCount()
        Amaz.LOGI("AE_LUA_TAG", self.lumi_obj.entity.name .. " camera_count: " .. tostring(cam_count))
    end
    return cam_count
end

function LumiManager:ReRender()
    if self.LumiEffectTrans == nil then
        return
    end

    -- re register
    self.lumi_obj = nil
    self:registerLumiObj(self.LumiEffectTrans, 1)

    if self.lumi_obj == nil then
        Amaz.LOGE('AE_LUA_TAG', 'No lumi_obj register')
        return
    end

    -- change layer & order
    self:updateCameraLayerAndOrder()

    -- change rt pingpong
    self:updateRtPingpong()
end

function LumiManager:registerLumiObj(_trans, _idx)
    if _trans == nil then return end
    -- Amaz.LOGI("lrc ".._idx, _trans.entity.name)
    local script_comp = _trans.entity:getComponent("ScriptComponent")
    if script_comp then
        local lua_obj = Amaz.ScriptUtils.getLuaObj(script_comp:getScript())
        if lua_obj then
            self.lumi_obj_extension.deregister(_trans.entity)
            self.lumi_obj = self.lumi_obj_extension.register(_trans.entity)
        end
    end
end

function LumiManager:updateCameraLayerAndOrder()
    if self.lumi_obj then
        self.lumi_obj:updateCameraLayerAndOrder(self.start_render_layer, self.start_render_order)
    end
end

function LumiManager:updateRtPingpong()
    if self.lumi_obj then
        self.lumi_obj:updateRt(self.InputTex, self.OutputTex, self.PingPongTex)
    end
end

function LumiManager:initVideoAnimationLua(comp)
    local modelEntity = comp.entity:searchEntity("model")
    if modelEntity then 
        local scriptComp = modelEntity:getComponent("ScriptComponent")
        if scriptComp then 
            self.videoAnimationLua = Amaz.ScriptUtils.getLuaObj(scriptComp:getScript())
        end
    end
end

function LumiManager:onUpdate(comp, deltaTime)
    if isEditor then
    end

    if self.lumi_obj == nil then
        self:registerLumiObj(self.LumiEffectTrans, 1)
        self:updateCameraLayerAndOrder()
    end

    self.curTime = self.curTime + deltaTime
    local curTime = (self.curTime - self.startTime) * self.speed + self.startTime
    local startTime = self.startTime
    local endTime = (self.endTime - self.startTime) * self.speed + self.startTime
    
    local aeTime = curTime;
    if endTime - curTime < self.disappearTime then
        aeTime = math.max(self.compDurations[1], self.compDurations[2] - (self.endTime - self.curTime))
    else
        local aeDuration = math.max(0.001, self.compDurations[2]-self.compDurations[1]-self.disappearTime)
        local lvDuration =  math.max(0.001, endTime-startTime-self.disappearTime)
        if self.durationMode == 0 then
            aeTime = curTime + self.compDurations[1]
        elseif self.durationMode == 1 then
            aeTime = (curTime - startTime) % aeDuration + self.compDurations[1]
        elseif self.durationMode == 2 then
            aeTime = (curTime - startTime)*aeDuration/lvDuration + self.compDurations[1]
        end
    end

    if self.effectType == "transition" then
        local input1 = Amaz.BuiltinObject.getUserTexture("#TransitionInput0")
        local input2 = Amaz.BuiltinObject.getUserTexture("#TransitionInput1")
        if input1 and input2 then
            for index, transitionInputInfo in ipairs(self.transitionInputIndex) do
                local entityName = transitionInputInfo[1]
                local texName = transitionInputInfo[2]
                local inputIndex = transitionInputInfo[3]
                if inputIndex == 0 then
                    self.lumi_obj:setSubEffectAttr(entityName, texName, input1)
                else
                    self.lumi_obj:setSubEffectAttr(entityName, texName, input2)
                end
            end
            aeTime = Amaz.Input.frameTimestamp * (self.compDurations[2]-self.compDurations[1]) + self.compDurations[1]
        end
    elseif self.effectType == "videoAnimation" then
        if self.videoAnimationLua == nil then
            self:initVideoAnimationLua(comp)
        end
        if self.videoAnimationLua ~= nil then
            aeTime = self.videoAnimationLua.progress * (self.compDurations[2]-self.compDurations[1]) + self.compDurations[1]
        end
    end

    if isEditor then
        if self.autoPlay then
            self.debugTime = curTime % (self.compDurations[2]-self.compDurations[1]) + self.compDurations[1]
            aeTime = self.debugTime
        else
            aeTime = self.debugTime
        end
    end

    if self.lumi_obj then
        self.lumi_obj:setEffectAttrRecursively("startTime", self.startTime)
        self.lumi_obj:setEffectAttrRecursively("endTime", self.endTime)
        self.lumi_obj:setEffectAttrRecursively("curTime", self.curTime)
    end

    if self.lumi_params_setter and self.lumi_params_setter.initParams then
        self.lumi_params_setter:initParams(self.lumi_obj)
    end
    if self.lumi_params_setter and self.lumi_params_setter.updateKeyFrameData then
        self.lumi_params_setter:updateKeyFrameData(self.lumi_obj, self.startTime, self.endTime, self.curTime, aeTime)
    end
    if self.lumi_params_setter and self.lumi_params_setter.updateSlider then
        self.lumi_params_setter:updateSlider(self.lumi_obj, self.startTime, self.endTime, self.curTime, aeTime)
    end
    
    if self.durations~= nil and aeTime >= self.compDurations[1] and aeTime <= self.compDurations[2] then
        if self.lumi_obj and self.lumi_obj.setVisible then
            for entityName, durations in pairs(self.durations) do
                local visible = false
                for j = 1, #durations do
                    if durations[j][1] <= aeTime and aeTime <= durations[j][2] then
                        visible = true
                        break
                    end
                end
                self.lumi_obj:setVisible(entityName, visible)
            end
        end
    end
    if self.lumi_obj and self.lumi_obj.updateMaterials then
        self.lumi_obj:updateMaterials(deltaTime)
    end

    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()

    if(w > h) then
        -- self.aeTransform_129:set("anchorPoint", Amaz.Vector3f(540., 1620., 100.))
        self.aeTransform_129:set("scale", Amaz.Vector3f(150., 600. * w / h, 100.))
        self.aeTransform_129:set("anchorPoint", Amaz.Vector3f(540., 1620. + (w / h * 100.) * 3. - (h / w * 100.) * 3., 100.))
    else
        self.aeTransform_129:set("anchorPoint", Amaz.Vector3f(540., 1620., 100.))
        self.aeTransform_129:set("scale", Amaz.Vector3f(150. * h / w, 600., 100.))
    end

    
    local paopaoBlur_intensity = self.attribute:GetVal("PaoPaoBlur_0_8", aeTime)[1]
    self.paopaoBlur:set("intensity", paopaoBlur_intensity)
    -- local blend_Opacity = self.attribute:GetVal("ADBE_Opacity_0_2", aeTime)[1]
    -- self.opacity_128:set("opacity", blend_Opacity)
    -- local png_Opacity = self.attribute:GetVal("ADBE_Opacity_0_1", aeTime)[1]
    -- self.opacity_129:set("opacity", png_Opacity)
    Amaz.LOGI("paopaoBlur",h)
end

function LumiManager:onEvent(comp, event)
    if self.lumi_obj == nil then
        self:registerLumiObj(self.LumiEffectTrans, 1)
        self:updateCameraLayerAndOrder()
    end

    if self.lumi_obj == nil then
        Amaz.LOGE('AE_LUA_TAG', 'Failed to find lumi_obj')
        return
    end

    -- if event.args:get(0) == "effects_adjust_speed" then
    --     local key = event.args:get(0)
    --     local value = event.args:get(1)
    --     self.speed = value*1.5 + 0.5
    -- end

    if self.lumi_params_setter and self.lumi_params_setter.onEvent then
        self.lumi_params_setter:onEvent(self.lumi_obj, event)
    end
end

exports.LumiManager = LumiManager
return exports
