local CommonFunc = { 
setFeatureEnabled = function (this, path, status)
    local feature = this:getFeature(path)
    if (feature) then
        feature:setFeatureStatus(EffectSdk.BEF_FEATURE_STATUS_ENABLED, status)
    end
end,
} 
local filter_folder = "Filter_5101"
local init_state = 1
local feature_0 = {
folder = "Filter_5101",
}
EventHandles = {
    handleEffectEvent = function (this, eventCode)
        if (init_state == 1 and eventCode == 1) then
            init_state = 0
            CommonFunc.setFeatureEnabled(this, feature_0.folder, true)
        end
        return true
    end,
    handleRecodeVedioEvent = function (this, eventCode)
        if (init_state ~= 0) then
            return true
        end
        if (eventCode == 1) then
            CommonFunc.setFeatureEnabled(this, feature_0.folder, false)
            CommonFunc.setFeatureEnabled(this, feature_0.folder, true)
        end
        return true
    end,
    handleComposerUpdateNodeEvent = function (this, path, tag, percentage)
        local feature = this:getFeature(filter_folder)
        -- local _feature = EffectSdk.castFaceMakeupV2Feature(feature)
        if (not feature)  then
            print("Filter is not exist")
            return false
        end
        if tag == "Internal_Filter" then
            feature:setIntensity(percentage)
        end
    end,
}