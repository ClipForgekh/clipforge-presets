local exports = exports or {}
local MultiFrameDisplacement = MultiFrameDisplacement or {}
MultiFrameDisplacement.__index = MultiFrameDisplacement
---@class MultiFrameDisplacement: ScriptComponent
---@field frameNums number
---@field softEdge Bool
---@field InputTex Texture
---@field OutputTex Texture
---@field maskImage Texture
---@field midTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function MultiFrameDisplacement.createRT(width, height)  
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = Amaz.FilterMode.LINEAR
    rt.filterMin = Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    return rt
end

function MultiFrameDisplacement.new(construct, ...)
    local self = setmetatable({}, MultiFrameDisplacement)

    self.InputTex = nil
    self.OutputTex = nil
    self.maskImage = nil

    self.lastTime = -10000
    self.startTime = 0.0
    self.endTime = 6.0
    self.curTime = 0.0
    self.aeTime = 0.0
    self.aeStartTime = 0.0
    self.aeEndTime = 0.0

    return self
end

function MultiFrameDisplacement:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.width = self.OutputTex.width
    self.height = self.OutputTex.height
    self:start(comp)
end

function MultiFrameDisplacement:start(comp)
    self.first = true
    self.properties = comp.properties
    self.MaxFrameNums = 29
    self.index = 0
    self.totalNums = 0
    self.cacheRt = {}

    self.materialMerge = comp.entity:searchEntity("renderer_merge"):getComponent("MeshRenderer").material
    self.materialMerge2 = comp.entity:searchEntity("renderer_merge_2"):getComponent("MeshRenderer").material
    self.cameraMerge2Camera = comp.entity.scene:findEntityBy("Camera_entity_merge_2"):getComponent("Camera")
    self.cameraBlitCamera = comp.entity.scene:findEntityBy("Camera_entity_blit_1"):getComponent("Camera")
    self.materialblit = comp.entity:searchEntity("renderer_blit_1"):getComponent("MeshRenderer").material

    local w = self.width * 0.5
    local h = self.height * 0.5
    self.midTex.width = w
    self.midTex.height = h
    for i=1,self.MaxFrameNums,1 do
        self.cacheRt[i] = self.createRT(w, h)
    end
end

function MultiFrameDisplacement:updateMaterial()
    if self.first == nil then
        return
    end

    local maskImageFlag = self.maskImage ~= nil and 1 or 0

    self.materialblit:setTex("inputImageTexture", self.InputTex)
    self.cameraMerge2Camera.renderTexture = self.OutputTex
    for i=1,self.MaxFrameNums,1 do
        local rtIdx = (self.index-(i-1)+self.MaxFrameNums) % self.MaxFrameNums
        if (i<=15) then
            self.materialMerge:setTex("inputImageTexture"..i, self.cacheRt[rtIdx+1])
        else
            self.materialMerge2:setTex("inputImageTexture"..i-15, self.cacheRt[rtIdx+1])
        end
    end

    local frameNums = math.max(math.min(math.floor(0.5+self.frameNums), self.totalNums), 1.0);
    self.materialMerge:setFloat("frameNums", frameNums);
    self.materialMerge2:setFloat("frameNums", frameNums);
    self.materialMerge:setFloat("softEdge", self.softEdge and 1 or 0);
    self.materialMerge2:setFloat("softEdge", self.softEdge and 1 or 0);
    self.materialMerge:setTex("maskTexture", self.maskImage)
    self.materialMerge2:setTex("maskTexture", self.maskImage)
    self.materialMerge2:setTex("u_inputTex", self.InputTex)
    self.materialMerge:setFloat("maskTexFlag", maskImageFlag)
    self.materialMerge2:setFloat("maskTexFlag", maskImageFlag)
end

function MultiFrameDisplacement:onUpdate(comp, detalTime)
    if self.first == nil then
        self:start(comp)
    end

    if self.aeTime < self.lastTime then
        self.totalNums = 0
    end
    self.lastTime = self.aeTime

    local length = self.aeEndTime - self.aeStartTime
    local diff = self.aeEndTime + self.aeStartTime - self.aeTime
    self.materialMerge2:setFloat('u_factor', diff)
    self.materialMerge2:setFloat('u_min', 0.05)
    self.materialMerge2:setFloat('u_max', math.max(math.min(length, 0.5), 0.05))

    if self.width ~= self.OutputTex.width or self.height ~= self.OutputTex.height then
        self.width = self.OutputTex.width
        self.height = self.OutputTex.height

        local w = self.width * 0.5
        local h = self.height * 0.5
        self.midTex.width = w
        self.midTex.height = h
        for i=1,self.MaxFrameNums, 1 do
            self.cacheRt[i].width = w
            self.cacheRt[i].height = h
        end

        self.totalNums = 0
    end

    self.index = (self.index+1) % self.MaxFrameNums
    self.totalNums = math.min(self.totalNums + 1, self.MaxFrameNums)
    self.cameraBlitCamera.renderTexture = self.cacheRt[self.index+1]

    self:updateMaterial()
end

exports.MultiFrameDisplacement = MultiFrameDisplacement
return exports
