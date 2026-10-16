--@input float curTime = 0.0{"widget":"slider","min":0,"max":1}

local exports = exports or {}
local ShadowHighlight = ShadowHighlight or {}
ShadowHighlight.__index = ShadowHighlight

---@class ShadowHighlight: ScriptComponent
---@field shadow double [UI(Range={-1, 1}, Drag)]
---@field highlight double [UI(Range={-1, 1}, Drag)]
---@field ratio number
---@field windowSize int
---@field blurSize number
---@field renderTextureNum int
---@field autoPlay boolean
---@field playTime number
---@field InputTex Texture
---@field OutputTex Texture

function ShadowHighlight.new(construct, ...)
    local self = setmetatable({}, ShadowHighlight)
    if construct and ShadowHighlight.constructor then
        ShadowHighlight.constructor(self, ...)
    end

    self.InputTex = nil
    self.OutputTex = nil

    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.width = 0
    self.height = 0
    self.shadow = 0
    self.highlight = 0

    return self
end

function ShadowHighlight:onUpdate(comp, detalTime)
    -- if Amaz.Macros and Amaz.Macros.EditorSDK then
    --     self:initData()
    -- -- self:start()
    -- else
    -- self.duration = self.endTime - self.startTime
    -- end
    if self.autoPlay or (not (Amaz.Macros and Amaz.Macros.EditorSDK)) then
        self.curTime = self.curTime + detalTime
        self:seekToTime(comp, self.curTime - self.startTime)
    else
        self:seekToTime(comp, self.playTime)
    end
end

---@param comp ScriptComponent
function ShadowHighlight:onStart(comp)
    self.camera = comp.entity:searchEntity("Camera_10"):getComponent("Camera")
    self.cameraAdjustMaterial0 = comp.entity:searchEntity("cameraAdjust"):getComponent("MeshRenderer").material
    self.getGrayMaterial = comp.entity:searchEntity("getGray"):getComponent("MeshRenderer").material
    self.blend2Material = comp.entity:searchEntity("blend_2"):getComponent("MeshRenderer").material
    -- self.material = comp.entity:getComponent("MeshRenderer").material
    self.properties = comp.properties
    self.width = 0
    self.height = 0
    self.isFirst = true
    self.isSecond = false
    self.isDefaultPos = false
    self.renderTexture = {}
    self.material = {}
    for i = 1, self.renderTextureNum do
        self.renderTexture[i] = self.properties:get("midTex" .. i)
    end
    for i = 2, 7 do
        self.material[i] = comp.entity:searchEntity("boxFilter_"..i):getComponent("MeshRenderer").material
    end
    self.ratio = 0.1
end

-- function ShadowHighlight:beforeEditorSave()
--     Amaz.Algorithm.setAlgorithmEnable("", "face_0", false)
--     Amaz.Algorithm.setAlgorithmEnable("", "skeleton_0", true)
--     self.entityLuas["face"].entity.visible = true
-- end

function ShadowHighlight:seekToTime(comp, time)
    local w = Amaz.BuiltinObject.getInputTextureWidth()
    local h = Amaz.BuiltinObject.getInputTextureHeight()
    if self.OutputTex then
        w = self.OutputTex.width
        h = self.OutputTex.height
    end
    if self.width ~= w or self.height ~= h or (Amaz.Macros and Amaz.Macros.EditorSDK) then
        self.width = w
        self.height = h
        for i = 1, self.renderTextureNum do
            self.renderTexture[i].height = self.height * self.ratio
            self.renderTexture[i].width = self.width * self.ratio
        end
        for i = 2, 7 do
            self.material[i]:enableMacro("blur_Num",self.windowSize)
            self.material[i]["u_blurSize"] = self.blurSize
        end
    end

    local x = self.shadow * 0.01
    x = math.pow(math.abs(x), 8.0)
    local lf = 0.28 * x
    local sf1 = 0.0 * x
    local sf2 = -0.12 * x
    if self.shadow < 0 then
        lf = 0.2 * x
        sf2 = 0.08 * x
    end

    self.camera.renderTexture = self.OutputTex
    self.getGrayMaterial:setTex("u_albedo", self.InputTex)
    self.blend2Material:setTex("u_albedo", self.InputTex)
    self.cameraAdjustMaterial0:setTex("inputTex", self.InputTex)
    self.cameraAdjustMaterial0:setFloat("lf", lf)
    self.cameraAdjustMaterial0:setFloat("sf1", sf1)
    self.cameraAdjustMaterial0:setFloat("sf2", sf2)
    self.cameraAdjustMaterial0:setFloat("shadow", self.shadow * 100)
    self.cameraAdjustMaterial0:setFloat("highlight", self.highlight * 100)
end

exports.ShadowHighlight = ShadowHighlight
return exports
