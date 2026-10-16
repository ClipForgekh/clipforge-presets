local exports = exports or {}
local MultiFrameDisplacement = MultiFrameDisplacement or {}
MultiFrameDisplacement.__index = MultiFrameDisplacement
---@class MultiFrameDisplacement: ScriptComponent
---@field frameNums number
---@field softEdge Bool
---@field InputTex Texture
---@field OutputTex Texture
---@field maskImage Texture

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local function createRT(width, height)  
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = Amaz.FilterMode.LINEAR
    rt.filterMin = Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    rt.needInitData = true
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

    self.totalNums = 0
    self.MaxFrameNums = 19

    self.speed = 1
    self.fadeout = 0
    self.disable = 0

    return self
end

function MultiFrameDisplacement:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name

    self.materialMerge = self.entity:searchEntity('renderer_merge'):getComponent('MeshRenderer').material
    self.materialMerge2 = self.entity:searchEntity('renderer_merge_2'):getComponent('MeshRenderer').material
    self.cameraMergeCamera = self.entity:searchEntity('Camera_entity_merge'):getComponent('Camera')
    self.cameraMerge2Camera = self.entity:searchEntity('Camera_entity_merge_2'):getComponent('Camera')
    self.cameraBlitCamera = self.entity:searchEntity('Camera_entity_blit_1'):getComponent('Camera')
    self.materialblit = self.entity:searchEntity('renderer_blit_1'):getComponent('MeshRenderer').material

    self.width = self.OutputTex.width
    self.height = self.OutputTex.height
end

function MultiFrameDisplacement:start()
    self.index = 0
    self.totalNums = 0
    self.cacheRt = {}
    self.midTex = nil

    collectgarbage('collect')

    local w = self.width * 0.5
    local h = self.height * 0.5
    self.midTex = createRT(w, h)
    for i = 1, self.MaxFrameNums do
        self.cacheRt[i] = createRT(w, h)
    end

    self.first = false
end

function MultiFrameDisplacement:updateMaterial()
end

function MultiFrameDisplacement:onUpdate(comp, deltaTime)
    local w = self.OutputTex.width
    local h = self.OutputTex.height
    if math.max(w, h) > 1080 then
        if w > h then
            h = h / w * 1080
            w = 1080
        else
            w = w / h * 1080
            h = 1080
        end
    end
    -- Amaz.LOGS('tqh', 'curTime: ' .. tostring(self.curTime) .. ', lastTime: ' .. tostring(self.lastTime))
    local isStart = self.first == nil or self.curTime == 0 or self.lastTime == 0 or self.curTime <= self.lastTime
    if isStart then
        self.first = true
        self.width = w
        self.height = h
        self:start()
        -- Amaz.LOGS('tqh', 'reset' .. ', totalNums: ' .. self.totalNums)
    end
    self.lastTime = self.curTime

    if self.width ~= w or self.height ~= h then
        self.width = w
        self.height = h

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

    -- Amaz.LOGS('tqh', 'fadeout: ' .. self.fadeout)

    self.materialMerge:setFloat('u_isStart', self.disable)--isStart and 1 or 0)
    self.materialMerge2:setFloat('u_isStart', self.disable)--isStart and 1 or 0)
    self.materialMerge2:setFloat('u_fadeout', self.fadeout)

    if self.first == nil then
        return
    end

    local maskImageFlag = self.maskImage ~= nil and 1 or 0

    self.materialblit:setTex("inputImageTexture", self.InputTex)
    self.cameraMergeCamera.renderTexture = self.midTex
    self.materialMerge2:setTex('mergedTexture', self.midTex)
    self.cameraMerge2Camera.renderTexture = self.OutputTex
    for i=1,self.MaxFrameNums,1 do
        local rtIdx = (self.index-(i-1)+self.MaxFrameNums) % self.MaxFrameNums
        if (i<=15) then
            self.materialMerge:setTex("inputImageTexture"..i, self.cacheRt[rtIdx+1])
        else
            self.materialMerge2:setTex("inputImageTexture"..i-15, self.cacheRt[rtIdx+1])
        end
    end

    local frameNums = math.max(math.min(math.ceil(self.frameNums * self.speed), self.totalNums), 1.0);
    -- Amaz.LOGS('tqh', 'frameNums: ' .. frameNums)
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

exports.MultiFrameDisplacement = MultiFrameDisplacement
return exports
