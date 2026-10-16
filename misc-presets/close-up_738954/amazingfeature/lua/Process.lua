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
    self.u_roundCorner = 0.0
    self.u_rightTop = Amaz.Vector2f(1.0, 1.0)
    self.u_circleCenter = Amaz.Vector2f(1.0, 1.0)
    self.u_circleRadius = 0.0
    self.u_diff = 0.0
    self.u_invert = 0.0
    -- lwk
    self.u_size = Amaz.Vector2f(1.0, 0.5)
    self.u_center = Amaz.Vector2f(0.0, 0.5)
    -- {"width":"0.992727","height":"0.531604","centerX":"-0.080187","centerY":"0.465106","feather":"0.000000","invert":false,"roundCorner":"0.000000","rotation":"0.000000"}

       -- lwk
    self.face_center = Amaz.Vector2f(0.0, 0.0)
    self.face_center_x = 0.0
    self.face_center_y = 0.5
    local boxInfo = Amaz.Map()
    boxInfo:set(BBOX , self:getBBox())
    self.scriptProps:set(BBOX_INFO, boxInfo)
end

function Process:getBBox()
    local bbox = Amaz.FloatVector()
    bbox:pushBack(-1) -- left no change
    bbox:pushBack(self.face_center_y + 0.5) -- top
    bbox:pushBack(1) -- right  no change
    bbox:pushBack(self.face_center_y - 0.5) -- bottom
    return bbox
end

function Process:onUpdate(comp, detalTime)
    Amaz.LOGE("luoqi" ,'running: Process:onUpdate')
    if self.face_center_y >= 0.5 then
            self.face_center_y = 0.5
            self.u_center = Amaz.Vector2f(0.0, self.face_center_y)
    else
            self.u_center = Amaz.Vector2f(0.0, self.face_center_y)
    end

    self.material:setVec2("u_center", self.u_center)
    self.material:setFloat("u_aspect", self.u_aspect)
    self.material:setFloat("u_rotate", self.u_rotate)
    self.material:setVec2("u_size", self.u_size)
    self.material:setVec2("u_rightTop", self.u_rightTop)
    self.material:setVec2("u_circleCenter", self.u_circleCenter)
    self.material:setFloat("u_circleRadius", self.u_circleRadius)
    self.material:setFloat("u_diff", self.u_diff)
    self.material:setFloat("u_invert", self.u_invert)
    Amaz.LOGE("luoqi" ,'running: Process:onUpdate finish')
end

function Process:onEvent(comp, event)
    if event.type == Amaz.AppEventType.SetEffectIntensity then
        if event.args:get(0) == "centerX" then
            self.u_center:Set(event.args:get(1), self.u_center.y)
            -- self.material:setVec2("u_center", self.u_center)
        elseif event.args:get(0) == "centerY" then
            self.u_center:Set(self.u_center.x, event.args:get(1))
            -- self.material:setVec2("u_center", self.u_center)
        elseif event.args:get(0) == "width" then
            self.u_size:Set(event.args:get(1), self.u_size.y)
            -- self.material:setVec2("u_size", self.u_size)
        elseif event.args:get(0) == "height" then
            self.u_size:Set(self.u_size.x, event.args:get(1))
            -- self.material:setVec2("u_size", self.u_size)
        elseif event.args:get(0) == "rotation" then
            local r = -event.args:get(1)
            self.u_rotate = (360.0 - r) * 2.0 * math.pi / 360.0
            -- self.material:setFloat("u_rotate", self.u_rotate)
        elseif event.args:get(0) == "roundCorner" then
            self.u_roundCorner = event.args:get(1)
        elseif event.args:get(0) == "feather" then
            self.u_diff = event.args:get(1) * 6
            -- self.material:setFloat("u_diff", self.u_diff)
        elseif event.args:get(0) == "face_center_x" then
            local intensity = event.args:get(1)
            self.face_center_x = intensity
            self.face_center:Set(self.face_center_x, intensity)
        elseif event.args:get(0) == "face_center_y" then
            local intensity = event.args:get(1)
            self.face_center_y = tonumber(intensity)
            self.face_center:Set(self.face_center_y, intensity)
        elseif event.args:get(0) == "invert" then
            if event.args:get(1) == true then
                self.u_invert = 1.0
            else
                self.u_invert = 0.0
            end
            -- self.material:setFloat("u_invert", self.u_invert)
        end
        -- lwk
        self.u_size = Amaz.Vector2f(1.0, 0.5)
        
        local boxInfo = Amaz.Map()
        boxInfo:set(BBOX , self:getBBox())
        self.scriptProps:set(BBOX_INFO, boxInfo)

        self.u_aspect = Amaz.BuiltinObject.getOutputTextureWidth() / Amaz.BuiltinObject.getOutputTextureHeight()
        
        if self.u_size.x * self.u_aspect >= self.u_size.y then
            self.u_circleRadius = self.u_size.y * self.u_roundCorner
        else
            self.u_circleRadius = self.u_size.x * self.u_aspect * self.u_roundCorner
        end
        self.u_rightTop:Set(self.u_size.x * self.u_aspect, self.u_size.y)
        self.u_circleCenter:Set(self.u_rightTop.x - self.u_circleRadius, self.u_rightTop.y - self.u_circleRadius)
        
    end
end

exports.Process = Process
return exports
