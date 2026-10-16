local exports = exports or {}
local Process = Process or {}
Process.__index = Process

local BBOX_INFO = "bbox_info"
local BBOX = "bbox"

function Process.new(construct, ...)
    local self = setmetatable({}, Process)
    if construct and Process.constructor then
        Process.constructor(self, ...)
    end
    return self
end

function Process:constructor()

end

function Process:onStart(comp)
    local scene = comp.entity.scene
    local scriptSystem = scene:getSystem("ScriptSystem")
    self.scriptProps = comp.properties

    self.material = comp.entity.scene:findEntityBy("Picture"):getComponent("MeshRenderer").material
    self.u_center = Amaz.Vector2f(0.0, 0.0)
    self.u_aspect = Amaz.BuiltinObject.getOutputTextureWidth() / Amaz.BuiltinObject.getOutputTextureHeight()
    self.u_rotate = 0.0
    self.u_size = Amaz.Vector2f(1.0, 1.0)
    self.u_diff = 0.0
    self.u_invert = 0.0
    -- lwk
    self.u_center = Amaz.Vector2f(0.00, 0.465)
    self.u_size = Amaz.Vector2f(0.9, 0.5)

    -- self.material:setVec2("u_center", self.u_center)
    -- self.material:setFloat("u_aspect", self.u_aspect)
    -- self.material:setFloat("u_rotate", self.u_rotate)
    -- self.material:setVec2("u_size", self.u_size)
    -- self.material:setFloat("u_diff", self.u_diff)
    -- self.material:setFloat("u_invert", self.u_invert)
    -- lwk
    self.face_center_x = 0.0
    self.face_center_y = 0.465
    self.face_radius = 0.9
    --  {"face_center_x":0.4 , "face_center_y":0.6 , "face_radius": 0.3}
    Amaz.LOGE("luoqi" ,"onStart: face_center_x:" .. self.face_center_x .. ";face_center_y:".. self.face_center_y)
    local boxInfo = Amaz.Map()
    boxInfo:set(BBOX , self:calBBox())
    self.scriptProps:set(BBOX_INFO, boxInfo)
end


-- runtime
local MIN = math.min
local MAX = math.max

function Process:calBBox()
    local bbox = Amaz.FloatVector()
    bbox:pushBack(MAX(self.face_center_x - self.face_radius, -1)) -- left
    bbox:pushBack(MIN(self.face_center_y + self.face_radius*self.u_aspect, 1)) -- top
    bbox:pushBack(MIN(self.face_center_x + self.face_radius, 1)) -- right
    bbox:pushBack(MAX(self.face_center_y - self.face_radius*self.u_aspect, -1)) -- bottom
    return bbox
end

function Process:onUpdate(comp, detalTime)
    Amaz.LOGE("luoqi" ,'running: Process:onUpdate')
    self.u_center = Amaz.Vector2f(self.face_center_x, self.face_center_y)
    self.u_size = Amaz.Vector2f(self.face_radius, self.face_radius*self.u_aspect)
    -- self.u_center:Set(self.u_center.x, intensity)
    -- self.u_size:Set(self.u_size.x, intensity)
    -- self.u_size:Set(self.u_size.y, intensity*self.u_aspect)
    self.material:setVec2("u_center", self.u_center)
    self.material:setFloat("u_aspect", self.u_aspect)
    self.material:setFloat("u_rotate", self.u_rotate)
    self.material:setVec2("u_size", self.u_size)
    self.material:setFloat("u_diff", self.u_diff)
    self.material:setFloat("u_invert", self.u_invert)
    Amaz.LOGE("luoqi" ,'running: Process:onUpdate finish')
end


function Process:onEvent(comp, event)
    if event.type == Amaz.AppEventType.SetEffectIntensity then
        -- if event.args:get(0) == "centerX" then
        --     self.u_center:Set(event.args:get(1), self.u_center.y)
        --     self.material:setVec2("u_center", self.u_center)
        -- elseif event.args:get(0) == "centerY" then
        --     self.u_center:Set(self.u_center.x, event.args:get(1))
        --     self.material:setVec2("u_center", self.u_center)
        -- elseif event.args:get(0) == "width" then
        --     self.u_size:Set(event.args:get(1), self.u_size.y)
        --     -- self.u_size = Amaz.Vector2f(1.0, 1.0)
        --     self.material:setVec2("u_size", self.u_size)
        -- elseif event.args:get(0) == "height" then
        --     self.u_size:Set(self.u_size.x, event.args:get(1))
        --     -- self.u_size = Amaz.Vector2f(1.0, 1.0)
        --     self.material:setVec2("u_size", self.u_size)
        -- elseif event.args:get(0) == "rotation" then
        --     local r = -event.args:get(1)
        --     self.u_rotate = (360.0 - r) * 2.0 * math.pi / 360.0
        --     self.material:setFloat("u_rotate", self.u_rotate)
        -- elseif event.args:get(0) == "feather" then
        --     self.u_diff = event.args:get(1) * 15
        --     self.material:setFloat("u_diff", self.u_diff)
        -- elseif event.args:get(0) == "invert" then
        --     if event.args:get(1) == true then
        --         self.u_invert = 1.0
        --     else
        --         self.u_invert = 0.0
        --     end
        --     self.material:setFloat("u_invert", self.u_invert)
        -- end
        self.u_aspect = Amaz.BuiltinObject.getOutputTextureWidth() / Amaz.BuiltinObject.getOutputTextureHeight()
        if event.args:get(0) == "face_center_x" then
            local intensity = event.args:get(1)
            Amaz.LOGE("luoqi" ,"onEvent: get face_center_x: " .. intensity)
            self.face_center_x = intensity
            -- self.u_center:Set(self.u_center.x, intensity)
            -- self.material:setVec2("u_center", self.u_center)
        elseif event.args:get(0) == "face_center_y" then
            local intensity = event.args:get(1)
            Amaz.LOGE("luoqi" ,"onEvent: get face_center.y: " .. intensity)
            self.face_center_y = intensity
            -- self.u_center:Set(self.u_center.y, intensity)
            -- self.material:setVec2("u_center", self.u_center)
        elseif event.args:get(0) == "face_radius" then
            local intensity = event.args:get(1)
            Amaz.LOGE("luoqi" ,"onEvent: get face_radius: " .. intensity)
            self.face_radius = intensity
            -- self.u_size:Set(self.u_size.x, intensity)
            -- self.u_size:Set(self.u_size.y, intensity*self.u_aspect)
            -- self.material:setVec2("u_size", self.u_size)
        end
        Amaz.LOGE("luoqi" ,"onEvent: face_center_x:" .. self.face_center_x .. ";face_center_y:".. self.face_center_y)
        --  {"face_center_x":0.4 , "face_center_y":0.6 , "face_radius": 0.3}

        local boxInfo = Amaz.Map()
        boxInfo:set(BBOX , self:calBBox())
        self.scriptProps:set(BBOX_INFO, boxInfo)
    end
end

exports.Process = Process
return exports
