local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiBlit = LumiBlit or {}
LumiBlit.__index = LumiBlit
---@class LumiBlit : ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture
---@field lumiSharedRt Vector [UI(Type="Texture")]

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function LumiBlit.new(construct, ...)
    local self = setmetatable({}, LumiBlit)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.curTime = 0.0
    self.startTime = 0.0
    self.endTime = 1.0

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function LumiBlit:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        self[_key] = _value
        if comp and comp.properties ~= nil then
            comp.properties:set(_key, _value)
        end
    end

    _setEffectAttr(key, value)
end

-- ================================================================
--  camera entity
-- splitLines: { {lineA, lineB, lineC, hidePositive}, ... }  
-- ================================================================
function LumiBlit:createLeafCamera(comp, name, outputRT, splitLines)
    -- 
    local camEntity = comp.entity.scene:cloneEntityFrom(self.cameraTemplate)
    camEntity.name = name
    table.insert(self.clonedEntities, camEntity)  -- 

    local camTransform = camEntity:getComponent("Transform")
    camTransform.parent = self.fatherTrans
    self.fatherTrans.children:pushBack(camTransform)

    local childTrans = camTransform.children:get(0)
    childTrans.entity.name = "pass_" .. name
    local mat = childTrans.entity:getComponent("MeshRenderer").material

    self.nextCloneIndex = self.nextCloneIndex + 1

    local cam = camEntity:getComponent("Camera")

    return {
        entity = camEntity,
        camera = cam,
        material = mat,
        outputRT = outputRT,
        splitLines = splitLines,  -- 
        inputSource = nil,
        -- 
        translation = { 0.0, 0.0, 0.0 },
        rotation    = { 0.0, 0.0, 0.0 },
        scale       = { 1.0, 1.0, 1.0 },
        alpha       = 1.0,
        anchorType  = 1,
        anchorPoint = { 0.5, 0.5, 0.0 },
    }
end

-- ================================================================
--  fragmentsData 
-- 
-- ================================================================
function LumiBlit:reloadFragmentsData(comp)
    --  fragmentsDataaspect-ratio-dependent 
    local fragmentsData = includeRelativePath("fragmentsData.lua")
    self.fragmentsData = fragmentsData

    --  endTime
    if fragmentsData.endTime then
        self.endTime = fragmentsData.endTime
    end
    self.durationScale = fragmentsData.durationScale
    self.reverse = fragmentsData.reverse or false

    -- 
    if fragmentsData.global then
        self.lineMaskProgress = fragmentsData.global.lineMaskProgress or 0.0
    end

    --  camera entity
    if self.clonedEntities then
        for _, entity in ipairs(self.clonedEntities) do
            comp.entity.scene:removeEntity(entity)
        end
    end
    self.clonedEntities = {}

    -- 
    self.cameraTemplate.visible = true

    -- 
    self.allCameras = {}
    self.leafRTs = {}
    self.leafCameras = {}
    self.nextCloneIndex = 0

    local activeSplitTree = self.utils:resolveSplitTree(self.fragmentsData)
    self.utils:buildPipeline(activeSplitTree, "InputTex", {}, {}, comp, self)

    --  +  +  fragmentsData
    for _, lc in ipairs(self.leafCameras) do
        local poly = self.utils:computeLeafPolygon(lc.splitPath)
        lc.polygon = poly
        lc.bounds  = self.utils:computeBounds(poly)

        local fd = self.fragmentsData.fragments[lc.entity.name]
        if fd then
            lc.translation = fd.localPosition or lc.translation
            lc.rotation    = fd.localRotation or lc.rotation
            lc.scale       = fd.localScale or lc.scale
            lc.alpha       = fd.alpha or lc.alpha
            if fd.anchor then
                lc.anchorType  = fd.anchor.type or lc.anchorType
                lc.anchorPoint = fd.anchor.point or lc.anchorPoint
            end
        end
    end

    -- 
    self.utils:orderCam(self, comp)

    --  camera_1 
    self.cameraTemplate.visible = false
end

function LumiBlit:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.fatherTrans = comp.entity:getComponent("Transform")

    self.blendCamEntity = self.entity:searchEntity("blend_cam")
    self.blendPassEntity = self.entity:searchEntity("blend_pass")
    self.blendCamEntity.visible = true
    self.blendCam = self.blendCamEntity:getComponent("Camera")
    self.blendMr = self.blendPassEntity:getComponent("MeshRenderer")

    --  utils
    local utils = includeRelativePath("utils.lua")
    self.utils = utils

    --  camera_1 
    self.cameraTemplate = self.entity:searchEntity("camera_1")

    -- 
    self.lastOutputW = Amaz.BuiltinObject.getOutputTextureWidth()
    self.lastOutputH = Amaz.BuiltinObject.getOutputTextureHeight()

    --  fragmentsData 
    self:reloadFragmentsData(comp)

    -- sharedRT
    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.midTex = self.lumiSharedRt:get(0)
    end
end

function LumiBlit:onUpdate(comp, deltaTime)
    --  endTime
    if isEditor then
        self.curTime = self.curTime + deltaTime
    end

    --  fragmentsData 
    local outputW = Amaz.BuiltinObject.getOutputTextureWidth()
    local outputH = Amaz.BuiltinObject.getOutputTextureHeight()
    if outputW ~= self.lastOutputW or outputH ~= self.lastOutputH then
        self.lastOutputW = outputW
        self.lastOutputH = outputH
        self:reloadFragmentsData(comp)
    end

    --  keyframe  RTS + alpha
    self.utils:applyAnimation(self)

    local count = 0
    for _, camInfo in ipairs(self.allCameras) do
        count = count + 1
        --  camera  outputRT
        camInfo.camera.renderTexture = camInfo.outputRT
        --  RT 
        self.utils:updateTexSize(camInfo.outputRT, outputW, outputH)

        --  InputTex  RT
        camInfo.material:setTex("u_inputTexture", self.InputTex)

        -- ================================================================
        --  splitPath 
        -- ================================================================
        local splitLines = camInfo.splitLines
        local splitCount = #splitLines
        camInfo.material:setInt("u_splitCount", splitCount)

        --  7 (u_split0~u_split6) (A, B, C, hidePositive)
        for i = 1, math.min(splitCount, 7) do
            local sl = splitLines[i]
            camInfo.material:setVec4("u_split" .. (i - 1),
                Amaz.Vector4f(sl.lineA, sl.lineB, sl.lineC, sl.hidePositive))
        end
        --  slot 
        for i = splitCount + 1, 7 do
            camInfo.material:setVec4("u_split" .. (i - 1),
                Amaz.Vector4f(0.0, 0.0, 0.0, 0.0))
        end

        -- 
        camInfo.material:setVec4("u_ScreenParams",
            Amaz.Vector4f(outputW, outputH, outputW / outputH, outputH / outputW))

        -- 
        local lc = self.fragmentsData.global.lineColor or { 0.0, 0.0, 0.0, 1.0 }
        camInfo.material:setVec4("u_lineColor", Amaz.Vector4f(lc[1], lc[2], lc[3], lc[4]))
        local lineWidth = math.min(outputW, outputH) / 720 * self.fragmentsData.global.lineWidth
        camInfo.material:setFloat("u_lineWidth", lineWidth)
        local showLine = self.fragmentsData.global.showLine
        camInfo.material:setFloat("u_showLine", (showLine == false) and 0.0 or 1.0)

        --  +
        camInfo.material:setFloat("u_lineMaskProgress", self.lineMaskProgress or 0.0)
        local maskType = self.fragmentsData.global.maskType or "line"
        camInfo.material:setInt("u_maskType", maskType == "circle" and 1 or 0)
        local ml = self.fragmentsData.global.lineMask
        if ml then
            -- line 
            local mA, mB, mC = self.utils:pointsToLineABC(ml.p1, ml.p2)
            camInfo.material:setFloat("u_maskA", mA)
            camInfo.material:setFloat("u_maskB", mB)
            camInfo.material:setFloat("u_maskC", mC)
            -- circle 
            local mCenter = ml.center or { 0.5, 0.5 }
            camInfo.material:setVec2("u_maskCenter", Amaz.Vector2f(mCenter[1], mCenter[2]))
        end

        -- 
        if camInfo.isLeaf then
            local t = camInfo.translation
            camInfo.material:setVec3("u_fragTranslation", Amaz.Vector3f(t[1], t[2], t[3]))
            local r = camInfo.rotation
            camInfo.material:setVec3("u_fragRotation", Amaz.Vector3f(r[1], r[2], r[3]))
            local s = camInfo.scale
            camInfo.material:setVec3("u_fragScale", Amaz.Vector3f(s[1], s[2], s[3]))
            camInfo.material:setFloat("u_alpha", camInfo.alpha or 1.0)
            camInfo.material:setInt("u_anchorType", camInfo.anchorType or 0)

            --  anchorType + anchorPoint  NDC 
            local at = camInfo.anchorType or 0
            local ap = camInfo.anchorPoint or { 0.5, 0.5, 0.0 }
            local ndcAnchor
            if at == 0 and camInfo.bounds then
                -- anchorPoint 
                ndcAnchor = self.utils:computeAnchorFromBounds(camInfo.bounds, ap)
            else
                -- anchorPoint  [0,1]→[-1,1]
                ndcAnchor = { ap[1] * 2.0 - 1.0, ap[2] * 2.0 - 1.0, ap[3] or 0.0 }
            end
            camInfo.material:setVec3("u_anchorPoint", Amaz.Vector3f(ndcAnchor[1], ndcAnchor[2], ndcAnchor[3]))
        else
            -- 
            camInfo.material:setVec3("u_fragTranslation", Amaz.Vector3f(0.0, 0.0, 0.0))
            camInfo.material:setVec3("u_fragRotation", Amaz.Vector3f(0.0, 0.0, 0.0))
            camInfo.material:setVec3("u_fragScale", Amaz.Vector3f(1.0, 1.0, 1.0))
            camInfo.material:setFloat("u_alpha", 1.0)
            camInfo.material:setInt("u_anchorType", 1)  -- SCREEN_CENTER
            camInfo.material:setVec3("u_anchorPoint", Amaz.Vector3f(0.0, 0.0, 0.0))
        end
    end

    -- ================================================================
    -- Blend RT  blend shader 
    -- ================================================================
    -- if self.OutputTex then
    --     self.blendCam.renderTexture = self.OutputTex
    -- end

    local blendMat = self.blendMr.material
    local leafCount = #self.leafRTs
    local uploadCount = leafCount
    if uploadCount > 12 then
        uploadCount = 12
    end
    blendMat:setInt("u_frag_num", uploadCount)

    local depthVec = Amaz.FloatVector()
    for i = 1, uploadCount do
        blendMat:setTex("u_fragmentTexture_" .. i, self.leafRTs[i])
        --  camera  translation.z 
        depthVec:pushBack(self.leafCameras[i].translation[3])
    end
    blendMat:setFloatVector("u_fragDepth", depthVec)

    -- sharedRT 
    if self.midTex then
        if self.midTex.width ~= self.OutputTex.width or self.midTex.height ~= self.OutputTex.height then
            self.midTex.width = self.OutputTex.width
            self.midTex.height = self.OutputTex.height
        end
    end
end

exports.LumiBlit = LumiBlit
return exports
