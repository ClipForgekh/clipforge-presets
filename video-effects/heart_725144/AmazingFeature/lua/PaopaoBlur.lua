local exports = exports or {}
local PaopaoBlur = PaopaoBlur or {}
PaopaoBlur.__index = PaopaoBlur
---@class PaopaoBlur : ScriptComponent
---@field intensity number

function PaopaoBlur.new(construct, ...)
    local self = setmetatable({}, PaopaoBlur)
    self.comps = {}
    self.compsdirty = true
    self.intensity = 1
    return self
end

function PaopaoBlur:constructor()
    
end

function PaopaoBlur:_get01(a,b,c)
    return math.max(0,math.min(1,(c-a)/(b-a)))
end

function PaopaoBlur:onStart(comp)


    self.mat = comp.entity:searchEntity("paopao"):getComponent("MeshRenderer").material

    
end

function PaopaoBlur:onUpdate(comp,deltaTime)

    self.width = Amaz.BuiltinObject:getInputTextureWidth()
    self.height = Amaz.BuiltinObject:getInputTextureHeight()

    local s = 720 / math.min(self.width, self.height)
    self.width = math.ceil(self.width * s)
    self.height = math.ceil(self.height * s)

    self.mat:setInt("inputWidth",self.width)
    self.mat:setInt("inputHeight",self.height)
    self.mat:setFloat("mysize",96+1)
    self.mat:setFloat("mysize2",96+1)
    self.mat:setVec2("iResolution",Amaz.Vector2f(self.width*0.5,self.height*0.5))
    
    self.mat:setInt("inputWidth",self.width)
    self.mat:setInt("inputHeight",self.height)
    
    self.mat:setFloat("blurSize",0.48 * self.intensity)
    self.mat:setFloat("blurSize2",1.25 * self.intensity)
end

exports.PaopaoBlur = PaopaoBlur
return exports
