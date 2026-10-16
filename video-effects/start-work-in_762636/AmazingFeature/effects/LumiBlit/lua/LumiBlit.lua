local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiBlit = LumiBlit or {}
LumiBlit.__index = LumiBlit
---@class LumiBlit : ScriptComponent
---@field InputTex Texture
---@field OutputTex Texture
---@field param0 Vector
---@field lumiSharedRt Vector [UI(Type="Texture")]

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

function LumiBlit:GetAbsolutePath(path)
    if path:sub(1, 1) == "/" or path:sub(2, 2) == ":" then
        return path
    end
    local rootPath = debug.getinfo(2, "S").source
    local len = #rootPath
    local counter = 0
    for i = len, 1, -1 do
        local leadingByte = string.byte(rootPath, i)
        if leadingByte == 47 or leadingByte == 92 then
            counter = counter + 1
            if counter == 4 then
                rootPath = string.sub(rootPath, 1, i)
                break
            end
        end
    end
    return rootPath .. path
end

function LumiBlit.new(construct, ...)
    local self = setmetatable({}, LumiBlit)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.InputTex = nil
    -- self.InputMask1 = nil
    -- self.InputTex2 = nil
    -- self.InputTex3 = nil
    self.OutputTex = nil

    self.param0 = Amaz.Vector2f(0, 0)

    return self
end

function LumiBlit:loadAsset(path)
    local asset = nil
    asset = self.comp.assetMgr:SyncLoad(path)
    return asset
end

function LumiBlit:setupVideo(videoPath, material)
    self.video_1.enabled = true
    local abSolutePath = self:GetAbsolutePath(videoPath)
    self.video_1.videoFilename = abSolutePath
    local frameCount1 = self.video_1:getFrameCount()
    local frame1 = math.max(0, math.floor((self.curTime /self.Duration *3) * (frameCount1 - 0.01)));
    self.video_1:seek(frame1 );
    local videoSize1 = self.video_1:getVideoSize()
    if material then
        material:setVec2("videoSize1", videoSize1)
    end
    return videoSize1
end

function LumiBlit:setEffectAttr(key, value, comp)
    local function _setEffectAttr(_key, _value)
        self[_key] = _value
        if comp and comp.properties ~= nil then
            comp.properties:set(_key, _value)
        end
    end

    -- value may be nil, please make sure that the variable can be updated to nil
    -- if value == nil then
    --     return
    -- end

    _setEffectAttr(key, value)
end

function LumiBlit:onStart(comp)
    self.scene = comp.entity.scene

    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    -- Use entity instead of scene
    self.camera = self.entity:searchEntity("BlitCamera"):getComponent("Camera")
    self.material = self.entity:searchEntity("BlitPass"):getComponent("MeshRenderer").material
    self.videos = comp.entity:searchEntity("BlitPass"):getComponents("VideoAnimSeq")

    self.comp = comp
    self.maskTex = nil
    self.bgTex = nil
    self.video_1 = self.videos:get(0)
    self.video_1.enableFixedSeekMode = true
    self.video_1.autoplay = false
    self.video_1.enableAlphaBlend = false

    -- AmazingFeature/resource/images/1-1-mask.png
    -- if temporary texture has the same dimensions as self.OutputTex, and need not persist, advised to used sharedRT
    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.midTex = self.lumiSharedRt:get(0)
    end

    -- if render texture needs to persist, or dimensions are exposed to be modified, then .rt files cannot be used, create the texture using the code below
    -- self.myTex = createRenderTexture(w, h)
end

function LumiBlit:onUpdate(comp, deltaTime)
    -- set the input and output textures to be displayed
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end


    local w = self.camera.renderTexture.width
    local h = self.camera.renderTexture.height

    -- local mask1 = self:loadAsset("resource/images/1-1-mask.png")
    local scalex = 1.0
    local scaley = 1.0

    local scalex2 = 1.0
    local scaley2 = 1.0

    if w / h < 0.65 then
        self.maskTex = self:loadAsset("resource/images/9-16-mask.png")
        self.bgTex = self:loadAsset("resource/images/9-16.png")
        scalex2 = 1 + (0.5625 - w / h)
    elseif w / h > 1.35 then
        self.maskTex = self:loadAsset("resource/images/16-9-mask.png")
        self.bgTex = self:loadAsset("resource/images/16-9.png")
        scaley2 = 1 + (w / h - (16 / 9)) * 0.8
    else
        self.maskTex = self:loadAsset("resource/images/1-1-mask.png")
        self.bgTex = self:loadAsset("resource/images/1-1.png")
        scaley2 = w / h
    end

    if w / h < 0.5625 then
        self:setupVideo("mp4/9-16-mp4.mp4", self.material)
        scalex = 1 + (0.5625 - w / h)
    elseif w / h < 0.76 then
        self:setupVideo("mp4/9-16-mp4.mp4", self.material)
        scaley = 1 + (w / h - 0.5625) * 0.5
    elseif w / h < 0.9 then
        scalex = 1 + (w / h - (3 / 4))
    elseif w / h > 1.777 then
        self:setupVideo("mp4/16-9-mp4.mp4", self.material)
        scaley = 1 + (w / h - (16 / 9)) * 0.5
    elseif w / h > 1.32 then
        scalex = 1 + ((16 / 9) - w / h) * 0.5
        self:setupVideo("mp4/16-9-mp4.mp4", self.material)
    else
        self:setupVideo("mp4/1-1-mp4.mp4", self.material)
        scaley = w / h
    end
    local offsetY = self.param0.y / 540 * 0.5


    self.material:setFloat("u_offsety", offsetY)
    self.material:setVec2("u_scale", Amaz.Vector2f(scalex, scaley))
    self.material:setVec2("u_scale2", Amaz.Vector2f(scalex2, scaley2))

    self.material:setTex("u_inputTexture", self.bgTex)
    self.material:setTex("u_inputTexture2", self.maskTex)
    -- if using sharedRT, dimensions need to be consistent with self.InputTex or self.OutputTex
    if self.midTex then
        if self.midTex.width ~= self.OutputTex.width or self.midTex.height ~= self.OutputTex.height then
            self.midTex.width = self.OutputTex.width
            self.midTex.height = self.OutputTex.height
        end
    end

    -- temporary texture's dimensions need to be based on self.InputTex or self.OutputTex's dimensions
    if self.myTex then
        local scale = 1.0 -- the necessary scale factor
        local realW = self.OutputTex.width * scale
        local realH = self.OutputTex.height * scale

        -- when temporary texture type is RenderTexture
        self.myTex.width = realW
        self.myTex.height = realH

        -- when temporary texture type is ScreenRenderTexture
        self.myTex.pecentX = realW / Amaz.BuiltinObject.getOutputTextureWidth()
        self.myTex.pecentY = realH / Amaz.BuiltinObject.getOutputTextureHeight()
    end
end

exports.LumiBlit = LumiBlit
return exports
