      
local isEditor = (Amaz.Macros and Amaz.Macros.EditorSDK) and true or false
local exports = exports or {}
local AETransform = AETransform or {}
AETransform.__index = AETransform
---@class AETransform : ScriptComponent
---@field active_cam_fovx number
---@field composite_size Vector2f
---@field is3DLayer boolean
---@field pivot Vector3f
---@field position Vector3f
---@field scale Vector3f
---@field direction Vector3f
---@field rotation Vector3f
---@field child_rotation Vector3f
---@field alpha number [UI(Range={0, 1}, Slider)]
---@field inputTex Texture
---@field outputTex Texture
---@field y_offset number
---@field cam_visible boolean

function AETransform.new(construct, ...)
    local self = setmetatable({}, AETransform)

    self.active_cam_fovx = 39.6
    self.composite_size = Amaz.Vector2f(1080, 1080)

    self.is3DLayer = false
    self.pivot = Amaz.Vector3f(0,0,0)
    self.position = Amaz.Vector3f(0,0,0)
    self.scale = Amaz.Vector3f(1,1,1)
    self.direction = Amaz.Vector3f(0,0,0)
    self.rotation = Amaz.Vector3f(0,0,0)
    self.child_rotation = Amaz.Vector3f(0,0,0)
    self.alpha = 1
    self.y_offset = 0.
    self.cam_visible = true
    
    self.inputTex = nil
    self.outputTex = nil

    if construct and AETransform.constructor then AETransform.constructor(self, ...) end
    return self
end

function AETransform:constructor()

end

function AETransform:paramListener(_param, _func)
    if self[_param] ~= nil then
        if self["last_".._param] == nil or self["last_".._param] ~= self[_param] then
            _func()
            self["last_".._param] = self[_param]
        end
    end
end

function AETransform:onStart(comp)
    self.entity = comp.entity
    self.ae_cam = self.entity:searchEntity("cam_ae_transform"):getComponent("Camera")
    self.father_trans = self.entity:searchEntity("father_trans"):getComponent("Transform")
    self.child_trans = self.entity:searchEntity("child_trans"):getComponent("Transform")
    self.child_child_trans = self.entity:searchEntity("child_child"):getComponent("Transform")

    -- self.child_renderer = self.child_trans.entity:getComponent("MeshRenderer")
    self.child_mat =self.entity:searchEntity("child_trans"):getComponent("MeshRenderer").material
    self.child_child_mat = self.child_child_trans.entity:getComponent("MeshRenderer").material
    -- self.child_mat:setTex("inputTex", self.inputTex)
    -- self.ae_cam.renderTexture = self.outputTex
end

function AETransform:_rotateByAEAxis(_trans, _direction, _euler_angle)
    -- ae xyz, editor yxz
    local up = Amaz.Vector3f(0.0, 1.0, 0.0)      
    local right = Amaz.Vector3f(1.0, 0.0, 0.0)   
    local forward = Amaz.Vector3f(0.0, 0.0, 1.0) 

    local cur_orientation = Amaz.Quaternionf.axisAngleToQuaternion(right,   _direction.x/180*math.pi) *
                            Amaz.Quaternionf.axisAngleToQuaternion(up,      -_direction.y/180*math.pi) * 
                            Amaz.Quaternionf.axisAngleToQuaternion(forward, -_direction.z/180*math.pi)

    up      = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, up)
    right   = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, right)
    forward = Amaz.Quaternionf.rotateVectorByQuat(cur_orientation, forward)

    cur_orientation = Amaz.Quaternionf.axisAngleToQuaternion(right,   _euler_angle.x/180*math.pi) * 
                    Amaz.Quaternionf.axisAngleToQuaternion(up,      -_euler_angle.y/180*math.pi) * 
                    Amaz.Quaternionf.axisAngleToQuaternion(forward, -_euler_angle.z/180*math.pi) * 
                    cur_orientation
    
    _trans.localOrientation = cur_orientation
end



function AETransform:cauleMVP(position, direction, rotation, pivot, scale, c_rotation)
    self.width = Amaz.BuiltinObject:getInputTextureWidth()
    self.height = Amaz.BuiltinObject:getInputTextureHeight()
    local ratio = self.width/self.height

    local ow = Amaz.BuiltinObject:getOutputTextureWidth()
    local oh = Amaz.BuiltinObject:getOutputTextureHeight()
    local o_ratio = ow/oh

    if self.is3DLayer then
        self.ae_cam.type = 0
        local pos_z0 = ratio/math.tan(self.active_cam_fovx*0.5/180*math.pi)
        self.ae_cam.fovy = math.atan(1/pos_z0)/math.pi*180*2
        self:_rotateByAEAxis(self.father_trans, direction, rotation)
        self.father_trans.localPosition = Amaz.Vector3f(
            (position.x/self.composite_size.x-0.5)*2*ratio, 
            (1-position.y/self.composite_size.y-0.5)*2, 
            -pos_z0-position.z*2/self.composite_size.y
        )
        self.child_trans.localPosition = Amaz.Vector3f(
            -(pivot.x/self.composite_size.x-0.5)*2*ratio, 
            -(1-pivot.y/self.composite_size.y-0.5)*2, 
            pivot.z*2/self.composite_size.y
        )
        self.child_trans.localEulerAngle = Amaz.Vector3f(0,0,0)
        -- self.child_child_trans.localEulerAngle = Amaz.Vector3f(0,0,c_rotation)
        self:_rotateByAEAxis(self.child_child_trans, direction, c_rotation)
    else
        self.ae_cam.type = 1
        self.father_trans.localEulerAngle = Amaz.Vector3f(0,0,0)
        self.father_trans.localPosition = Amaz.Vector3f(
            (position.x/self.composite_size.x-0.5)*2*ratio, 
            (position.y/self.composite_size.y-0.5)*2, 
            -10
        )

        self.child_trans.localPosition = Amaz.Vector3f(
            -(pivot.x/self.composite_size.x-0.5)*2*ratio, 
            -(pivot.y/self.composite_size.y-0.5)*2, 
            0
        )
        self.child_trans.localEulerAngle = Amaz.Vector3f(0,0, -rotation.z)
    end
    self.father_trans.localScale = Amaz.Vector3f(scale.x, scale.y, scale.z)
    self.child_trans.localScale = Amaz.Vector3f(ratio,1,1)

    local iw = Amaz.BuiltinObject:getInputTextureWidth()
    local ih = Amaz.BuiltinObject:getInputTextureHeight()
    local ow = Amaz.BuiltinObject:getOutputTextureWidth()
    local oh = Amaz.BuiltinObject:getOutputTextureHeight()

    self.ae_cam.renderTexture.pecentX = oh/ow / (ih/iw)

    local u_Child_M = self.child_child_trans.localMatrix
    local u_M = self.child_trans:getWorldMatrix()
    local u_V = self.ae_cam:getWorldToCameraMatrix()
    local u_P = self.ae_cam.projectionMatrix
    -- if self.child_renderer.useCustomProjectMatrix then
    --     u_P = self.child_renderer.customProjectMatrix
    -- end

    -- local mvp = u_P * u_V * u_M

    return {u_V * u_M * u_Child_M, u_P:invert_Full()}
end


function AETransform:onUpdate(comp, deltaTime)

    self.ae_cam.entity.visible = self.cam_visible

    self.child_child_trans.localEulerAngle = self.child_rotation
    self.child_child_mat:setFloat("y_offset", self.y_offset)

    self.prePivot = self.pivot
    self.preDirection = self.direction
    self.prePosition = self.prePosition == nil and Amaz.Vector3f(540,540,0) or self.prePosition
    self.preScale = self.preScale == nil and Amaz.Vector3f(1,1,1) or self.preScale
    self.preRotation = self.preRotation == nil and Amaz.Vector3f(0,0,0) or self.preRotation
    self.preChildRotation = self.preChildRotation == nil and Amaz.Vector3f(0,0,0) or self.preChildRotation

    -- Amaz.LOGI("lrc pre", tostring(self.prePosition))
    -- Amaz.LOGI("lrc cur", tostring(self.position))

    -- Amaz.LOGI("lrc pre", tostring(self.preScale))
    -- Amaz.LOGI("lrc cur", tostring(self.scale))

    -- Amaz.LOGI("lrc pre", tostring(self.preRotation))
    -- Amaz.LOGI("lrc cur", tostring(self.rotation))

    local size = 5;
    for i=0,size,1 do
        local pivot = self.prePivot * (1.0-i/size) + self.pivot * i/size;
        local position = self.prePosition * (1.0-i/size) + self.position * i/size;
        local scale = self.preScale * (1.0-i/size) + self.scale * i/size;
        local direction = self.preDirection * (1.0-i/size) + self.direction * i/size;
        local rotation = self.preRotation * (1.0-i/size) + self.rotation * i/size;
        local child_rotation = self.preChildRotation * (1.0-i/size) + self.child_rotation * i/size;

        -- pivot = self.pivot
        -- position = self.position
        -- scale = self.scale
        -- direction = self.direction
        -- rotation = self.rotation
        -- child_rotation = self.child_rotation


        local u_MVP = self:cauleMVP(position, direction, rotation, pivot, scale, child_rotation)
        -- u_MVP = u_MVP:invert_Full()
        self.child_child_mat:setMat4("mvMat"..i, u_MVP[1])
        self.child_child_mat:setMat4("pMat"..i, u_MVP[2])

        self.child_mat:setMat4("mvMat"..i, u_MVP[1])
        self.child_mat:setMat4("pMat"..i, u_MVP[2])

    end

    self.child_mat:setFloat("alpha", self.alpha)
    self.child_child_mat:setFloat("alpha", self.alpha)

    local iw = Amaz.BuiltinObject:getInputTextureWidth()
    local ih = Amaz.BuiltinObject:getInputTextureHeight()
    local ow = Amaz.BuiltinObject:getOutputTextureWidth()
    local oh = Amaz.BuiltinObject:getOutputTextureHeight()

    -- self.ae_cam.renderTexture.pecentX = oh/ow

    local output_size = Amaz.Vector2f(ow, oh)
    self.child_mat:setVec2("output_size", output_size)
    self.child_child_mat:setVec2("output_size", output_size)

end

exports.AETransform = AETransform
return exports
