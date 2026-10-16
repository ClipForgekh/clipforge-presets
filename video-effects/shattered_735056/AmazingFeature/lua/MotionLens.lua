local exports = exports or {}
local MotionLens = MotionLens or {}
MotionLens.__index = MotionLens
---@class MotionLens : ScriptComponent
---@field autoplay boolean
---@field _duration number
---@field curTime number
---@field frameID number
---@field progress number [UI(Range={0, 1}, Slider)]
---@field distance_from_cam number
---@field fovx_in_ae number
---@field composite_size_in_ae Vector2f

local function remap01(a,b,x)
    if x < a then return 0 end
    if x > b then return 1 end
    return (x-a)/(b-a)
end

local function remap(x, a, b)
    return x * (b - a) + a
end

local function mix(a, b, x)
    return a * (1-x) + b * x
end


function MotionLens.new(construct, ...)
    local self = setmetatable({}, MotionLens)
    if construct and MotionLens.constructor then MotionLens.constructor(self, ...) end
    EffectSdk.LOG_LEVEL(8, "lrc ========>>: new")
    self.startTime = 0.0
    self.endTime = 3.0
    self.curTime = 0.0
    self.frame = 0
    self.width = 0
    self.height = 0
	self.frameNUM = 24

    -- Editor about ---
    self.autoplay = false
    self._duration = 2

    -- Runtime ---
    self.progress = 0

    self.distance_from_cam = -3 -- Editor Param
	self.fovx_in_ae = 39.6
	self.focal_length_in_ae = 1500
	self.composite_size_in_ae = Amaz.Vector2f(1080, 1080)

    return self
end

function MotionLens:constructor()

end

function MotionLens:initFatherLayer()
	for c=0,19 do
		self.compLayerFather["layer" .. c] = "fast"
	end
	--  = 1， 5~8， 11， 19
	local slow_ind = {1, 5, 6, 7, 8, 9, 11, 19}
	for c = 1, #slow_ind do
		self.compLayerFather["layer" .. (slow_ind[c]-1)] = "slow"
	end
end

function MotionLens:onStart(comp)
    self.entity = comp.entity
    self.trans = self.entity:getComponent("Transform")
    self.cam = self.entity.scene:findEntityBy("cam_motion_lens"):getComponent("Camera")
    self.material       = self.entity.scene:findEntityBy("motion_lens"):getComponent("MeshRenderer").material
	self.child_renderer = self.entity.scene:findEntityBy("motion_lens"):getComponent("MeshRenderer")

	self.compLayerFather = {}
	self:initFatherLayer()

	self.id = 1
	self.fragCenterPnts = Amaz.Vector()
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.124624,0.267646 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.206736,-0.117570 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.251340,0.105713  ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.270134,0.065636 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.149099,-0.195036))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.328616,0.506626  ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.452083,-0.037242))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.047649,-0.372957 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.027129,-0.226126 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.086145,0.314603  ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.259998,0.640349 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.266339,0.217256  ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.436125,0.289376  ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.395096,-0.272333))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.342549,0.481502 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.265366,-0.550523 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.056524,0.550853  ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(0.514068,-0.071769 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.507429,0.201210 ))
	self.fragCenterPnts:pushBack(Amaz.Vector2f(-0.107846,-0.453378))
end

function MotionLens:onUpdate(comp, detalTime)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        self.curTime = self.curTime + detalTime
    end
    self:autoPlay(self.curTime)
	-- local NUM = 51
    -- self.progress = math.floor(self.progress*18)/18

    self:updateFunc(self.progress)

end

function MotionLens:autoPlay(time)
    if Amaz.Macros and Amaz.Macros.EditorSDK then
        if self.autoplay then
            self.progress = time % self._duration / self._duration
        end
    else
        self.duration = self.endTime - self.startTime
        self.progress = time % self.duration / self.duration
    end
end

function printVec3(name, v)
	Amaz.LOGI("XUDDLOG vec3 " .. name .. " x=" .. v.x .. " y=" .. v.y .. " " .. v.z, 99.0)
end

function MotionLens:updateFunc(_progress)
    local w = Amaz.BuiltinObject:getInputTextureWidth()
    local h = Amaz.BuiltinObject:getInputTextureHeight()

	local focal_length_in_ae = self.composite_size_in_ae.x * 0.5 / math.tan(self.fovx_in_ae*0.5/180*math.pi)

	-- set the camera's fovy
    local y_length = focal_length_in_ae * math.tan(self.fovx_in_ae*0.5/180*math.pi)*h/w
    local fovy = math.atan(y_length/focal_length_in_ae)/math.pi*2*180
    self.cam.fovy = fovy

	-- set the tran's scale
    local y_scale = math.tan(fovy*0.5/180*math.pi)*math.abs(self.distance_from_cam) -- editor，y
    -- Amaz.LOGI("XUDDLOG y_scale=", y_scale)
    -- self.trans.localScale = Amaz.Vector3f(y_scale*w/h, y_scale, 1)
    local border = Amaz.Vector2f(y_scale*w/h*2, y_scale*2)
    local NUM = 51.5

	local motionScriptProps = self.entity.scene:findEntityBy("motion_lens"):getComponent("ScriptComponent").properties
    local id = motionScriptProps:get("frameID")
	id = id-2.0
	self.material:setFloat("frameID", 1.0*id)
	self.material:setFloat("isVis", id>1.5 and 1.0 or 0.0)
	self.material:setFloat("frameNUM", 1.0*self.frameNUM)

	self.material:setVec2Vector("u_VerticeCenter",    self.fragCenterPnts)
end


function PP(number)
	return string.format("%.4f", number)
end

function MotionLens:getMatAsStringTranspose(m)
	local t = PP(m:get(0,0)) .. " " .. PP(m:get(0, 1)) .. " " .. PP(m:get(0, 2)) .. " " .. PP(m:get(0, 3)) .. " " .. 
			  PP(m:get(1,0)) .. " " .. PP(m:get(1, 1)) .. " " .. PP(m:get(1, 2)) .. " " .. PP(m:get(1, 3)) .. " " .. 
			  PP(m:get(2,0)) .. " " .. PP(m:get(2, 1)) .. " " .. PP(m:get(2, 2)) .. " " .. PP(m:get(2, 3)) .. " " ..
			  PP(m:get(3,0)) .. " " .. PP(m:get(3, 1)) .. " " .. PP(m:get(3, 2)) .. " " .. PP(m:get(3, 3)) 
	return t
end

function MotionLens:getMatAsString(m)
	local t = PP(m:get(0,0)) .. " " .. PP(m:get(1, 0)) .. " " .. PP(m:get(2, 0)) .. " " .. PP(m:get(3, 0)) .. " " .. 
			  PP(m:get(0,1)) .. " " .. PP(m:get(1, 1)) .. " " .. PP(m:get(2, 1)) .. " " .. PP(m:get(3, 1)) .. " " .. 
			  PP(m:get(0,2)) .. " " .. PP(m:get(1, 2)) .. " " .. PP(m:get(2, 2)) .. " " .. PP(m:get(3, 2)) .. " " ..
			  PP(m:get(0,3)) .. " " .. PP(m:get(1, 3)) .. " " .. PP(m:get(2, 3)) .. " " .. PP(m:get(3, 3)) 
	return t
end

function MotionLens:printMat(m)
	Amaz.LOGI("XUDDLOG m=" .. m:get(0,0), 3.0)
	Amaz.LOGI("XUDDLOG m=" .. m:get(0,1), 3.0)
	Amaz.LOGI("XUDDLOG m=" .. m:get(0,2), 3.0)
	Amaz.LOGI("XUDDLOG m=" .. m:get(1,0), 3.0)
	Amaz.LOGI("XUDDLOG m=" .. m:get(1,1), 3.0)
	Amaz.LOGI("XUDDLOG m=" .. m:get(1,2), 3.0)
	Amaz.LOGI("XUDDLOG m=" .. m:get(2,0), 3.0)
	Amaz.LOGI("XUDDLOG m=" .. m:get(2,1), 3.0)
	Amaz.LOGI("XUDDLOG m=" .. m:get(2,2), 3.0)
end

exports.MotionLens = MotionLens
return exports
