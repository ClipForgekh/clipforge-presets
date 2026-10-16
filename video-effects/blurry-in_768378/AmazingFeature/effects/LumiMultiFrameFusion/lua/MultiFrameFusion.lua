local exports = exports or {}
local MultiFrameFusion = MultiFrameFusion or {}
MultiFrameFusion.__index = MultiFrameFusion
---@class MultiFrameFusion: ScriptComponent
---@field frameNums number
---@field InputTex Texture
---@field OutputTex Texture
---@field midTex Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

function MultiFrameFusion.createRT(width, height)  
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

function MultiFrameFusion.new(construct, ...)
    local self = setmetatable({}, MultiFrameFusion)
    if construct and MultiFrameFusion.constructor then
        MultiFrameFusion.constructor(self, ...)
    end

    self.InputTex = nil
    self.OutputTex = nil

    return self
end

function MultiFrameFusion:constructor()
end

function MultiFrameFusion:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.width = self.OutputTex.width
    self.height = self.OutputTex.height
    self:start(comp)
end

function MultiFrameFusion:start(comp)
    self.first = true
    self.properties = comp.properties
    self.MaxFrameNums = 31
    self.index = 0
    self.totalNums = 0
    self.cacheRt = {}

    self.materialMerge = comp.entity:searchEntity("renderer_merge"):getComponent("MeshRenderer").material
    self.materialMerge2 = comp.entity:searchEntity("renderer_merge_2"):getComponent("MeshRenderer").material
    self.materialBlit = comp.entity:searchEntity("renderer_blit_1"):getComponent("MeshRenderer").material
    self.cameraBlitCamera = comp.entity:searchEntity("Camera_entity_blit_1"):getComponent("Camera")
    self.camMerge2 = comp.entity:searchEntity("Camera_entity_merge_2"):getComponent("Camera")

    local w = self.width * 0.5
    local h = self.height * 0.5
    self.midTex.width = w
    self.midTex.height = h
    for i=1,self.MaxFrameNums,1 do
        self.cacheRt[i] = self.createRT(w, h)
    end
end

function MultiFrameFusion:updateMaterial()
    if self.first == nil then
        return
    end

    self.materialBlit:setTex("inputImageTexture", self.InputTex)

    for i=1,self.MaxFrameNums,1 do
        local rtIdx = (self.index-(i-1)+self.MaxFrameNums) % self.MaxFrameNums
        if (i<=16) then
            self.materialMerge:setTex("inputImageTexture"..i, self.cacheRt[rtIdx+1])
        else
            self.materialMerge2:setTex("inputImageTexture"..i-16, self.cacheRt[rtIdx+1])
        end
    end

    local frameNums = math.max(math.min(math.floor(0.5+self.frameNums), self.totalNums), 1.0);
    local wSum1 = 0.0
    for i=0,15,1 do
        wSum1 = wSum1 + math.max(frameNums-i, 0.0)
    end
    local wSum2 = 0.0
    for i=16,30,1 do
        wSum2 = wSum2 + math.max(frameNums-i, 0.0)
    end
    local wSum = wSum1 + wSum2

    self.materialMerge:setFloat("frameNums", frameNums);
    self.materialMerge:setFloat("wSum1", wSum1);
    self.materialMerge:setFloat("wSum2", wSum1);
    self.materialMerge:setFloat("wSum", wSum);
    self.materialMerge2:setFloat("frameNums", frameNums);
    self.materialMerge2:setFloat("wSum1", wSum1);
    self.materialMerge2:setFloat("wSum2", wSum1);
    self.materialMerge2:setFloat("wSum", wSum);
end

function MultiFrameFusion:onUpdate(comp, detalTime)
    if self.first == nil then
        self:start(comp)
    end

    self.camMerge2.renderTexture = self.OutputTex

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

exports.MultiFrameFusion = MultiFrameFusion
return exports
