local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiBlit = LumiBlit or {}
LumiBlit.__index = LumiBlit
---@class LumiBlit : ScriptComponent
---@field InputTex Texture
---@field BlurBgTex Texture
---@field MaskTex Texture
---@field WordsTex Texture
---@field OutputTex Texture
---@field param0 Vector
---@field param02 Vector
---@field MovingType string [UI(Option={"Vertical", "Horizontal" })]

local MovingType = { "Vertical", "Horizontal" }
setmetatable(MovingType, { __index = function(_, _) return MovingType[1] end })
local MovingTypeIndex = {}
for index, value in ipairs(MovingType) do MovingTypeIndex[value] = index - 1 end


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

function LumiBlit.new(construct, ...)
    local self = setmetatable({}, LumiBlit)

    self.__lumi_type = "lumi_obj"
    self.__lumi_rt_pingpong_type = "custom"

    self.InputTex = nil
    self.BlurBgTex = nil
    self.MaskTex = nil
    self.WordsTex = nil

    self.OutputTex = nil

    self.param0 = Amaz.Vector2f(0, 0)
    self.param02 = Amaz.Vector2f(0, 0)
    return self
end

function LumiBlit:loadAsset(path)
    local asset = nil
    asset = self.comp.assetMgr:SyncLoad(path)
    return asset
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

function LumiBlit:loadMaterialConfig()
    local path = self:GetAbsolutePath("material_config.json")
    if string.sub(path, 1, 1) == "@" then
        path = string.sub(path, 2)
    end
    
    local file = io.open(path, "r")
    if file then
        local jsonStr = file:read("*a")
        file:close()
        self.materialConfig = cjson.decode(jsonStr)
        Amaz.LOGI("materialConfig", cjson.encode(self.materialConfig))
    else
        Amaz.LOGE(AE_EFFECT_TAG, "Failed to open material_config.json at " .. path)
    end
end

function LumiBlit:onStart(comp)
    self.entity = comp.entity
    self.TAG = AE_EFFECT_TAG .. ' ' .. self.entity.name
    Amaz.LOGI(self.TAG, 'onStart')

    -- Use entity instead of scene
    self.camera = self.entity:searchEntity("BlitCamera"):getComponent("Camera")
    self.material = self.entity:searchEntity("BlitPass"):getComponent("MeshRenderer").material
    self.comp = comp
    self:loadMaterialConfig()
    self.maskTex = nil
    self.bgTex = nil
end

function LumiBlit:onUpdate(comp, deltaTime)
    -- set the input and output textures to be displayed
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end

    if self.materialConfig then
        if self.materialConfig.MovingType ~= nil then
            self.MovingType = self.materialConfig.MovingType
        end
    end

    local w = self.camera.renderTexture.width
    local h = self.camera.renderTexture.height

    -- local mask1 = self:loadAsset("resource/images/1-1-mask.png")
    local scalex = 1.0
    local scaley = 1.0

    local scalex2 = 1.0
    local scaley2 = 1.0

    if w < h then
        scaley = w / h
        scaley2 = w / h
    else
        scalex = h / w
        scalex2 = h / w
    end

    local offsetY = self.param0.y / 540
    local offsetY2 = self.param02.y / 540

    local moveCenter = Amaz.Vector2f(0.5, 1.0)
    local wordsOffset = Amaz.Vector2f(0.0, 1.0)
    local wordsCenter = Amaz.Vector2f(0.5, 0.5)

    local offset = Amaz.Vector2f(0, 0)
    local offset2 = Amaz.Vector2f(0, 0)
    local offset3 = Amaz.Vector2f(0, 0)
    local wdsoffset = Amaz.Vector2f(0, 0)

    offset2 = Amaz.Vector2f(0, offsetY2)

    if self.MovingType == "Vertical" then
        offset = Amaz.Vector2f(0, offsetY)
        wdsoffset = offset + Amaz.Vector2f(0, 0.15 / (1.0 - math.abs(math.min(9 / 16 - w / h, 0.0))))
        -- Amaz.LOGI("wdsoffset",  (math.min( 9/16 - w/h)) )
        -- offset = offset + Amaz.Vector2f(0, -0.07)
        wordsCenter = Amaz.Vector2f(0.5, 0)
        offset3 = Amaz.Vector2f(0, -(h / w - 1) / 2 * w / h)
        if w > h then
            offset3 = Amaz.Vector2f(0, 0)
            wdsoffset = offset + Amaz.Vector2f(0, 0.32)
        end
        offset = offset + Amaz.Vector2f(0, -0.07)

        moveCenter = Amaz.Vector2f(0.5, 1.0)
    else
        offset = Amaz.Vector2f(-offsetY, 0)
        wdsoffset = offset
        offset3 = Amaz.Vector2f((w / h - 1) / 2 * h / w, 0)
        moveCenter = Amaz.Vector2f(0.0, 0.5)
        wordsCenter = Amaz.Vector2f(1.0, 0.5)
        wordsOffset = Amaz.Vector2f(-1.0, 0.0)
    end


    -- Amaz.LOGI("offset3", offset3.y)
    self.material:setVec2("u_moveCenter", moveCenter)
    self.material:setVec2("u_wordsCenter", wordsCenter)
    self.material:setVec2("u_wordsOffset", wordsOffset)

    self.material:setVec2("u_wdsoffset", wdsoffset)
    self.material:setVec2("u_offset", offset)
    self.material:setVec2("u_offset2", offset2)
    self.material:setVec2("u_offset3", offset3)

    local wordsScale = 1.0
    if w>h then
        wordsScale = math.min(w/h,1.6)
    end

    self.material:setFloat("u_wordsScale", wordsScale)


    self.material:setVec2("u_scale", Amaz.Vector2f(scalex, scaley))
    self.material:setVec2("u_scale2", Amaz.Vector2f(scalex2, scaley2))

    self.material:setTex("u_inputTexture", self.InputTex)
    self.material:setTex("u_blurBgTexture", self.BlurBgTex)
    self.material:setTex("u_maskTexture", self.MaskTex)
    self.material:setTex("u_wordsTexture", self.WordsTex)

    self.material:setInt("u_movingType", MovingTypeIndex[self.MovingType])

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
