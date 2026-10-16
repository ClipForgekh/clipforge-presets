local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local LumiBlit = LumiBlit or {}
LumiBlit.__index = LumiBlit
---@class LumiBlit : ScriptComponent
---@field InputMask Texture
---@field InputTex Texture
---@field OutputTex Texture
---@field param0 Vector [UI(Type="Vector2")]
---@field rotation number  [UI(Range={-1, 1}, Drag)] 旋转角度
---@field feather number  [UI(Range={0, 0.5}, Drag)] 羽化范围
---@field maskType string [UI(Option={"linear", "circle",  "calculateBlitColor", "radialWipe"})] 遮罩类型
---@field wipeMode string [UI(Option={"ClockWise", "CounterClockWise", "Both"})] 擦除模式
---@field Center Vector2f
---@field lumiSharedRt Vector [UI(Type="Texture")]


local WipeMode = { "ClockWise", "CounterClockWise", "Both" }
setmetatable(WipeMode, { __index = function(_, _) return WipeMode[1] end })
local WipeModeIndex = {}
for index, value in ipairs(WipeMode) do WipeModeIndex[value] = index - 1 end

local MaskType = { "linear", "circle", "calculateBlitColor", "radialWipe" }
setmetatable(MaskType, { __index = function(_, _) return MaskType[1] end })
local MaskTypeIndex = {}
for index, value in ipairs(MaskType) do MaskTypeIndex[value] = index - 1 end

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
    -- self.InputMask1 = nil
    -- self.InputTex2 = nil
    -- self.InputTex3 = nil
    self.OutputTex = nil
    self.maskTex = nil
    self.bgTex = nil
    self.InputMask = nil
    self.rotation = 0
    self.feather = 0.015
    self.wipeMode = "ClockWise"
    self.maskType = "linear"
    self.wipeCenter = Amaz.Vector2f(0.5, 0.5)

    self.Center = Amaz.Vector2f(0.5, 0.5)

    self.param0 = Amaz.Vector2f(0, 0)

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
    -- Amaz.LOGE("pathpsl", tostring(rootPath .. path))

    return rootPath .. path
end


function LumiBlit:loadMaterialConfig()
    local path = self:GetAbsolutePath("material_config.json")
    if string.sub(path, 1, 1) == "@" then
        path = string.sub(path, 2)
    end
    
    self.lumaBounds = nil
    
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
    if self.lumiSharedRt and self.lumiSharedRt:size() > 0 then
        self.midTex = self.lumiSharedRt:get(0)
    end
end

function LumiBlit:onUpdate(comp, deltaTime)
    -- set the input and output textures to be displayed
    if self.OutputTex then
        self.camera.renderTexture = self.OutputTex
    end

    local w = self.camera.renderTexture.width
    local h = self.camera.renderTexture.height

    self.maskTex = self:loadAsset("resource/images/1-1-mask.png")

    local time = -self.param0.y / 540
    -- Amaz.LOGI("offsetY", time)
    self.material:setFloat("u_time", time)
    self.material:setVec2("u_wh", Amaz.Vector2f(w, h))
    -- 鲁棒性读取 materialConfig 参数
    local rotation = self.rotation
    local feather = self.feather
    local center = self.Center
    local wipeMode = self.wipeMode
    local maskType = self.maskType

    if self.materialConfig then
        -- 适配嵌套的 mask_config.params 结构
        local config = self.materialConfig
        local params = config.params
        if config.mask_config and config.mask_config.params then
            params = config.mask_config.params
            if config.mask_config.mask_type ~= nil then maskType = config.mask_config.mask_type end
        end

        if params then
            if params.rotation ~= nil then rotation = params.rotation end
            if params.feather ~= nil then feather = params.feather end
            if params.center ~= nil and type(params.center) == "table" then
                -- 适配数组结构 [x, y] 或对象结构 {x=x, y=y}
                local cx = params.center.x or params.center[1]
                local cy = params.center.y or params.center[2]
                if cx ~= nil and cy ~= nil then
                    center = Amaz.Vector2f(cx, cy)
                end
            elseif params.Center ~= nil and params.Center.x ~= nil and params.Center.y ~= nil then
                center = Amaz.Vector2f(params.Center.x, params.Center.y)
            end
            if params.wipe_mode ~= nil then wipeMode = params.wipe_mode end
            if params.wipeMode ~= nil then wipeMode = params.wipeMode end
            if params.maskType ~= nil then maskType = params.maskType end
        end
    end
    Amaz.LOGI("cente2111r", feather)
    self.material:setFloat("u_rotation", rotation)
    self.material:setFloat("u_feather", feather)
    self.material:setVec2("u_center", center)

    local wipeCenter = Amaz.Vector2f(center.x, 1. - center.y)

    self.material:setInt("u_wipeMode", WipeModeIndex[wipeMode])
    self.material:setVec2("u_wipeCenter", wipeCenter)
    self.material:setInt("u_maskType", MaskTypeIndex[maskType])
    self.material:setVec2("u_scale_r", Amaz.Vector2f(1, 1))


    self.material:setTex("u_inputTexture2", self.maskTex)
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
