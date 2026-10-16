local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiSpeedChange = LumiSpeedChange or {}
LumiSpeedChange.__index = LumiSpeedChange
---@class LumiSpeedChange : ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture
---@field mergeFrameNums number [UI(Range={1.0, 30.0}, Slider)]
---@field slomoRatio number [UI(Range={0.0, 0.95}, Slider)]
---@field slomoRate number [UI(Range={1.0, 10.0}, Slider)]
---@field intervalFrame number [UI(Range={1, 30}, Slider)]

local AE_EFFECT_TAG = 'AE_EFFECT_TAG LumiTag'

local function createRenderTexture(width, height, filterMag, filterMin)
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = filterMag or Amaz.FilterMode.LINEAR
    rt.filterMin = filterMin or Amaz.FilterMode.LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    return rt
end

local function updateTexSize(rt, width, height)
    if rt == nil or width <= 0 or height <= 0 then
        return
    end
    if rt.width ~= width or rt.height ~= height then
        rt.width = width
        rt.height = height
    end
end

function LumiSpeedChange.createRT(width, height)
    local rt = Amaz.RenderTexture()
    rt.width = width
    rt.height = height
    rt.depth = 1
    rt.filterMag = Amaz.FilterMode.FilterMode_LINEAR
    rt.filterMin = Amaz.FilterMode.FilterMode_LINEAR
    rt.filterMipmap = Amaz.FilterMipmapMode.FilterMode_NONE
    rt.attachment = Amaz.RenderTextureAttachment.NONE
    return rt
end

function LumiSpeedChange.new(construct, ...)
    local self = setmetatable({}, LumiSpeedChange)
    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"
    self.InputTex = nil
    self.OutputTex = nil
    self.mergeFrameNums = 1
    self.slomoRatio = 0.5
    self.slomoRate = 1
    self.intervalFrame = 1
    return self
end

function LumiSpeedChange:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value, _force)
        if _force or self[_key] ~= nil then
            self[_key] = _value
            if comp and comp.properties ~= nil then
                comp.properties:set(_key, _value)
            end
        end
    end

    _setEffectAttr(key, value)
end

local function getLuaObject (comp)
    local script = comp:getScript()
    if script then
        return Amaz.ScriptUtils.getLuaObj(script)
    end
end

function LumiSpeedChange:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')
    self.first = true
    self.properties = comp.properties
    self.index = 0
    self.totalNums = 0
    self.cacheRt = {}
    self.cacheRt_Size = 0.5
    self.width = 0
    self.height = 0
    self.materialBlit = comp.entity:searchEntity("PassBlit"):getComponent("MeshRenderer").material
    self.materialMerge = comp.entity:searchEntity("PassMerge"):getComponent("MeshRenderer").material
    self.materialMerge2 = comp.entity:searchEntity("PassMerge2"):getComponent("MeshRenderer").material
    self.cameraBlit = comp.entity:searchEntity("CameraBlit"):getComponent("Camera")
    self.cameraMerge2 = comp.entity:searchEntity("CameraMerge2"):getComponent("Camera")
    self.midRT = comp.entity:searchEntity("CameraMerge"):getComponent("Camera").renderTexture
    for i=1,31,1 do
        self.cacheRt[i] = self.createRT(self.width/2, self.height/2)
    end

end

function LumiSpeedChange:updateMaterial()
    self.intervalFrame = math.floor(self.intervalFrame)
    self.cameraMerge2.renderTexture = self.OutputTex
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()
    if self.OutputTex then
        w = self.OutputTex.width
        h = self.OutputTex.height
        self.midRT.width = w * 0.5
        self.midRT.height = h * 0.5
    end
    if self.width ~= w or self.height ~= h then
        for i=1,self.intervalFrame, 1 do
            self.cacheRt[i].width = w/2
            self.cacheRt[i].height = h/2
        end
        self.width = w
        self.height = h
        self.totalNums = 0
    end
    self.index = (self.index+1) % self.intervalFrame
    self.totalNums = math.min(self.totalNums + 1, self.intervalFrame)
    self.cameraBlit.renderTexture = self.cacheRt[self.index+1]

    self.materialBlit:setTex("u_inputImageTexture", self.InputTex)
    local normal_frame = math.max(math.floor(self.intervalFrame * (1.0-self.slomoRatio)),1)
    for i=1,self.intervalFrame,1 do
        local rtIdx = self.index
        if self.index < normal_frame then
            rtIdx = (self.index-(i-1)+self.intervalFrame) % self.intervalFrame
        else
            local cur = math.max(math.min(math.floor((self.index-normal_frame)/self.slomoRate + normal_frame),self.index),0)
            if (self.index - cur >self.totalNums) then
                cur = self.index
            end
            rtIdx = (cur + self.intervalFrame) % self.intervalFrame
        end
        if (i<=16) then
            self.materialMerge:setTex("u_inputImageTexture"..i, self.cacheRt[rtIdx+1])
        else
            self.materialMerge2:setTex("u_inputImageTexture"..i-16, self.cacheRt[rtIdx+1])
        end
    end
    local frameNums = math.max(math.min(math.floor(0.5+self.mergeFrameNums), self.totalNums), 1.0);
    local wSum1 = 0.0
    for i=0,15,1 do
        wSum1 = wSum1 + math.max(frameNums-i, 0.0)
    end
    local wSum2 = 0.0
    for i=16,30,1 do
        wSum2 = wSum2 + math.max(frameNums-i, 0.0)
    end
    local wSum = wSum1 + wSum2
    self.materialMerge:setFloat("u_frameNums", frameNums);
    self.materialMerge:setFloat("u_wSum1", wSum1);
    self.materialMerge2:setFloat("u_frameNums", frameNums);
    self.materialMerge2:setFloat("u_wSum1", wSum1);
    self.materialMerge2:setFloat("u_wSum", wSum);
end

exports.LumiSpeedChange = LumiSpeedChange
return exports
