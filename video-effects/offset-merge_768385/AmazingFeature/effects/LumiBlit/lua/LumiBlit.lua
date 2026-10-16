local exports = exports or {}
local LumiBlit = LumiBlit or {}
LumiBlit.__index = LumiBlit
local AE_EFFECT_TAG = "AE_EFFECT_TAG LumiTag"
---@class LumiBlit : ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

function LumiBlit.new(construct, ...)
    local self = setmetatable({}, LumiBlit)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.curTime = 0.0
    self.startTime = 0.0
    self.endTime = 2.0
    self.u_time = 0.0

    self.InputTex = nil
    self.OutputTex = nil
    self.blendCameraOutputTex = nil
    self.fragmentsData = nil

    -- Runtime collections are populated by reloadFragmentsData().  Initialize
    -- them here as well because the host may deliver an update during the
    -- first lifecycle tick or while a data reload is in progress.
    self.clonedEntities = {}
    self.allCameras = {}
    self.leafRTs = {}
    self.leafCameras = {}
    self.adjustPasses = {}
    self.negativePasses = {}
    self.brightnessPasses = {}
    self.motionBlur2DPasses = {}
    self.gaussianBlurPasses = {}
    self.directionalBlursPasses = {}
    self.dropShadowPasses = {}
    self.globalNegativePass = nil
    self.globalAdjustPass = nil
    self.globalBrightnessPass = nil
    self.globalMotionBlur2DPass = nil
    self.globalGaussianBlurPass = nil
    self.globalDirectionalBlursPass = nil
    self.globalDropShadowPass = nil
    self.globalPingPongScratchRT = nil
    self.globalPingPongFinalRT = nil
    self.globalPingPongCurrentRT = nil
    self.globalPingPongCurrentIsFinal = true
    self.globalPingPongPassCount = 0
    self.globalPingPongPassIndex = 0
    self.cumCamPasses = {}
    self.sGlowPasses = {}
    self.parts = {}
    self.globalCumCamPass = nil
    self.globalSGlowPass = nil

    -- LumiCube-style camera system
    self.designSize = Amaz.Vector2f(1000, 1000)
    self.fov = 40.0
    self.cameraPosition = Amaz.Vector3f(0.5, 0.5, 0.0)
    self.cameraScale = Amaz.Vector3f(1, 1, 1)

    return self
end

-- Public component API kept on the class because LumiManager calls it directly.
function LumiBlit:setEffectAttr(key, value, comp)
    self[key] = value
    if comp and comp.properties ~= nil then
        comp.properties:set(key, value)
    end
end

function LumiBlit:onStart(comp)
    self.utils = includeRelativePath("utils.lua")

    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. " " .. self.entity.name
    self.fatherTrans = comp.entity:getComponent("Transform")

    self.blendCamEntity = self.entity:searchEntity("blend_cam")
    self.blendPassEntity = self.entity:searchEntity("blend_pass")
    self.blendCamEntity.visible = true
    self.blendCam = self.blendCamEntity:getComponent("Camera")
    self.blendCameraOutputTex = self.blendCam.renderTexture
    self.blendMr = self.blendPassEntity:getComponent("MeshRenderer")

    self.LumiSGlow = self.entity:searchEntity("LumiSGlow")
    if self.LumiSGlow then
        self.LumiSGlow.visible = false
    end

    self.LumiNegative = self.entity:searchEntity("LumiNegative")
    if self.LumiNegative then
        self.LumiNegative.visible = false
    end

    self.LumiAdjust = self.entity:searchEntity("LumiAdjust")
    if self.LumiAdjust then
        self.LumiAdjust.visible = false
    end

    self.LumiBrightness = self.entity:searchEntity("LumiBrightness")
    if self.LumiBrightness then
        self.LumiBrightness.visible = false
    end

    self.LumiMotionBlur2D = self.entity:searchEntity("LumiMotionBlur2D")
    if self.LumiMotionBlur2D then
        self.LumiMotionBlur2D.visible = false
    end

    self.LumiGaussianBlur = self.entity:searchEntity("LumiGaussianBlur")
    if self.LumiGaussianBlur then
        self.LumiGaussianBlur.visible = false
    end

    self.LumiDirectionalBlurs = self.entity:searchEntity("LumiDirectionalBlurs")
    if self.LumiDirectionalBlurs then
        self.LumiDirectionalBlurs.visible = false
    end

    self.LumiDropShadow = self.entity:searchEntity("LumiDropShadow")
    if self.LumiDropShadow then
        self.LumiDropShadow.visible = false
    end

    self.cumCam = self.entity:searchEntity("cumCam")
    if self.cumCam then
        self.cumCam.visible = false
    end

    self.cameraTemplate = self.entity:searchEntity("camera_1")
    self.fatherEntity_1 = self.entity:searchEntity("fatherEntity_1")
    self.pass_camera_1 = self.entity:searchEntity("pass_camera_1")
    self.pass_camera_1_material = self.pass_camera_1:getComponent("MeshRenderer").material

    local templateCam = self.cameraTemplate:getComponent("Camera")
    if templateCam then
        templateCam.zNear = 0.1
        templateCam.zFar = 1000
    end

    self.lastOutputW = Amaz.BuiltinObject.getOutputTextureWidth()
    self.lastOutputH = Amaz.BuiltinObject.getOutputTextureHeight()
    self.fragmentsData = includeRelativePath("fragmentsData.lua")
    self.utils:reloadFragmentsData(self, comp, self.fragmentsData)

    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.midTex = self.lumiSharedRt:get(0)
    end
end

function LumiBlit:onUpdate(comp, deltaTime)
    -- Wait until onStart has supplied the scene references and loaded the
    -- fragment graph.  This also makes a hot reload's transient empty state
    -- safe for the first update callback.
    if self.utils == nil or self.blendMr == nil then
        return
    end

    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
    if outputW ~= self.lastOutputW or outputH ~= self.lastOutputH then
        self.lastOutputW = outputW
        self.lastOutputH = outputH
        local refreshedFragmentsData = includeRelativePath("fragmentsData.lua")
        if refreshedFragmentsData ~= nil then
            self.fragmentsData = refreshedFragmentsData
        end
        self.utils:reloadFragmentsData(self, comp, self.fragmentsData)
    end

    self.utils:applyAnimation(self)
    self.utils:applyFragmentTransform(self)

    for _, camInfo in ipairs(self.allCameras or {}) do
        self.utils:updateLeafCameraPass(self, camInfo, outputW, outputH)
    end
    self.utils:refreshGlobalPostEffectPingPong(self, outputW, outputH)
    self.utils:updateAdjustPasses(self, outputW, outputH)
    self.utils:updateNegativePasses(self, outputW, outputH)
    self.utils:updateBrightnessPasses(self, outputW, outputH)
    self.utils:updateMotionBlur2DPasses(self, outputW, outputH)
    self.utils:updateGaussianBlurPasses(self, outputW, outputH)
    self.utils:updateDirectionalBlursPasses(self, outputW, outputH)
    self.utils:updateDropShadowPasses(self, outputW, outputH)
    self.utils:updateCumCamPasses(self, outputW, outputH)
    self.utils:updateSGlowPasses(self, outputW, outputH)
    self.utils:updateBlendPass(self)
end

-- Called by LumiObjectExtension after the regular Lumi camera traversal.
-- Post-effect passes (Adjust/Negative/Brightness/MotionBlur2D/GaussianBlur/
-- DirectionalBlurs/DropShadow/cumCam/SGlow) are intentionally managed here so they
-- remain outside the generic component sort while receiving the correct
-- layer/order.
function LumiBlit:updateCameraLayerAndOrder(startLayer, startOrder)
    if self.utils and self.utils.orderManagedCameras then
        return self.utils:orderManagedCameras(self, startLayer, startOrder)
    end
    return startLayer, startOrder
end

exports.LumiBlit = LumiBlit
return exports
