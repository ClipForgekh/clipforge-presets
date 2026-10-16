-- Use requireFile to include other lua modules within the same folder
function requireFile(comp, fileName)
    local path = comp.assetMgr.rootDir
    local modulePath = path.."lua/"
    package.path = package.path..";"..modulePath.."?.lua"
    return require(fileName)
end

local exports = exports or {}
local AnimScript = AnimScript or {}

---@class AnimScript : ScriptComponent
---@field duration number
---@field progress number [UI(Range={0.0, 1.0}, Slider)]
---@field autoPlay boolean
AnimScript.__index = AnimScript

      
local AETools = AETools or {}     ---@class AETools
AETools.__index = AETools

function AETools:new(attrs)
    local self = setmetatable({}, AETools)
    self.attrs = attrs

    local max_frame = 0
    for _,v in pairs(attrs) do
        for i = 1, #v do
            local content = v[i]
            local cur_frame = content[2][2]
            max_frame = math.max(cur_frame, max_frame)
        end
    end

    self:SetAllFrame(max_frame)

    return self
end

function AETools._remap01(a,b,x)
    if x < a then return 0 end
    if x > b then return 1 end
    return (x-a)/(b-a)
end

function AETools._cubicBezier(p1, p2, p3, p4, t)
    return {
        p1[1]*(1.-t)*(1.-t)*(1.-t) + 3*p2[1]*(1.-t)*(1.-t)*t + 3*p3[1]*(1.-t)*t*t + p4[1]*t*t*t,
        p1[2]*(1.-t)*(1.-t)*(1.-t) + 3*p2[2]*(1.-t)*(1.-t)*t + 3*p3[2]*(1.-t)*t*t + p4[2]*t*t*t,
    }
end

function AETools:_cubicBezier01(_bezier_val, p)
    local x = self:_getBezier01X(_bezier_val, p)
    return self._cubicBezier(
        {0,0},
        {_bezier_val[1], _bezier_val[2]},
        {_bezier_val[3], _bezier_val[4]},
        {1,1},
        x
    )[2]
end

function AETools:_getBezier01X(_bezier_val, x)
    local ts = 0
    local te = 1
    -- divide and conque
    repeat
        local tm = (ts+te)*0.5
        local value = self._cubicBezier(
            {0,0},
            {_bezier_val[1], _bezier_val[2]},
            {_bezier_val[3], _bezier_val[4]},
            {1,1},
            tm)
        if(value[1]>x) then
            te = tm
        else
            ts = tm
        end
    until(te-ts < 0.0001)

    return (te+ts)*0.5
end

function AETools._mix(a, b, x)
    return a * (1-x) + b * x
end

function AETools:SetAllFrame(val)
    self.all_frame = val
end

function AETools:GetVal(_name, _progress)
    local content = self.attrs[_name]
    if content == nil then
        return nil
    end

    local cur_frame = _progress * self.all_frame

    for i = 1, #content do
        local info = content[i]
        local start_frame = info[2][1]
        local end_frame = info[2][2]
        if cur_frame >= start_frame and cur_frame < end_frame then
            local cur_progress = self._remap01(start_frame, end_frame, cur_frame)
            local bezier = info[1]
            local value_range = info[3]

            if #bezier > 4 then
                -- currently scale attrs contains more than 4 bezier values
                local res = {}
                for k = 1, 3 do
                    local cur_bezier = {bezier[k], bezier[k+3], bezier[k+3*2], bezier[k+3*3]}
                    local p = self:_cubicBezier01(cur_bezier, cur_progress)
                    res[k] = self._mix(value_range[1][k], value_range[2][k], p)
                end
                return res

            else
                local p = self:_cubicBezier01(bezier, cur_progress)

                if type(value_range[1]) == "table" then
                    local res = {}
                    for j = 1, #value_range[1] do
                        res[j] = self._mix(value_range[1][j], value_range[2][j], p)
                    end
                    return res
                end
                return self._mix(value_range[1], value_range[2], p)
            end

        end
    end

    local first_info = content[1]
    local start_frame = first_info[2][1]
    if cur_frame<start_frame then
        return first_info[3][1]
    end

    local last_info = content[#content]
    local end_frame = last_info[2][2]
    if cur_frame>=end_frame then
        return last_info[3][2]
    end

    return nil
end

function AETools:test()
    Amaz.LOGI("lrc "..tostring(self.key_frame_info), tostring(#self.key_frame_info))
end

local ae_attribute = {
	["ADBE_Position"]={
		{{0.33, 0, 0.67, 1, }, {0, 2, }, {{540, 540, 0, }, {540, 528, 0, }, }, }, 
		{{0.33, 0, 0.67, 1, }, {2, 4, }, {{540, 528, 0, }, {540, 628, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {4, 7, }, {{540, 628, 0, }, {540, 486, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {7, 10, }, {{540, 486, 0, }, {464, 526, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {10, 13, }, {{464, 526, 0, }, {588, 533, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {13, 16, }, {{588, 533, 0, }, {517.803573608, 541.169647217, 0, }, }, }, 
		{{0.166667, 0.166667, 0.833333, 0.833333, }, {16, 19, }, {{517.803573608, 541.169647217, 0, }, {550.625, 545.401794434, 0, }, }, }, 
		{{0.166667, 0.166667, 0.666667, 1, }, {19, 23, }, {{550.625, 545.401794434, 0, }, {532.4375, 545.25, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {23, 27, }, {{532.4375, 545.25, 0, }, {544.080352783, 541.705352783, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {27, 33, }, {{544.080352783, 541.705352783, 0, }, {537.294647217, 540.5625, 0, }, }, }, 
		{{0.333333, 0, 0.666667, 1, }, {33, 40, }, {{537.294647217, 540.5625, 0, }, {540, 540, 0, }, }, }, 
	}, 
	["ADBE_Scale"]={
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {0, 2, }, {{100, 100, 100, }, {98, 98, 100, }, }, }, 
		{{0.166666667,0.166666667,0.166666667, 0.166666667,0.166666667,0.166666667, 0.833333333,0.833333333,0.833333333, 0.833333333,0.833333333,0.833333333, }, {2, 4, }, {{98, 98, 100, }, {102, 102, 100, }, }, }, 
		{{0.33,0.33,0.33, 0,0,0.33, 0.67,0.67,0.67, 1,1,0.67, }, {4, 27, }, {{102, 102, 100, }, {100, 100, 100, }, }, }, 
	}, 
	["ADBE_Displacement_Map_Small"]={
		{{0.166666667, 0, 0.833333333, 1, }, {2, 4, }, {{0, }, {-20, }, }, }, 
		{{0.3, 0, 0.3, 1, }, {4, 27, }, {{-20, }, {0, }, }, }, 
	}, 
	["ADBE_Displacement_Map_Big"]={
		{{0.166666667, 0, 0.833333333, 1, }, {2, 4, }, {{0, }, {88, }, }, }, 
		{{0.3, 0, 0.3, 1, }, {4, 27, }, {{88, }, {0, }, }, }, 
	}, 
	["ADBE_Gaussian_Blur"]={
		{{0.166666667, 0, 0.833333333, 1, }, {0, 4, }, {{40, }, {200, }, }, }, 
		{{0.3, 0, 0.3, 1, }, {4, 27, }, {{200, }, {0, }, }, }, 
	}, 
}

function AnimScript.new()
    local self = {}
    setmetatable(self, AnimScript)
    self.transform = {}
    self.progress = 0
    self.autoPlay = false
    self.duration = 1.0
    self.curTime = 0
    self.first = true
    return self
end

---@param comp Component
function AnimScript:onStart(comp)
    self.attr = AETools:new(ae_attribute)
    self.flipMat = comp.entity.scene:findEntityBy("Flip"):getComponent("MeshRenderer").material
    self.smallWarpMat = comp.entity.scene:findEntityBy("Small_Warp"):getComponent("MeshRenderer").material
    self.bigWarpMat = comp.entity.scene:findEntityBy("Big_Warp"):getComponent("MeshRenderer").material
    self.bigWarpAnim = comp.entity.scene:findEntityBy("Big_Warp"):getComponent("AnimSeqComponent")
    self.GaussianRootLua = comp.entity.scene:findEntityBy("Gaussian_Blur_Root"):getComponent("ScriptComponent").propreties
    self.first = true
end

---@param comp Component
---@param deltaTime number
function AnimScript:onUpdate(comp, deltaTime)
    if self.first == true then
        -- self.LuaObj1 = Amaz.ScriptUtils.getLuaObj(GaussianRootLua:getScript())
        self.first = false
    end
    if self.autoPlay == true then
        self.progress = self.curTime / self.duration % 1
        self.curTime = self.curTime + deltaTime
    else
        self.curTime = 0
    end
    local progress = self.progress
    local offset = self.attr:GetVal("ADBE_Position", progress)
    self.flipMat:setVec2("u_Offset", Amaz.Vector2f((offset[1] - 540) / 1080, -(offset[2] - 540) / 1080))
    local scale = self.attr:GetVal("ADBE_Scale", progress)[1] * 0.01
    self.flipMat:setFloat("u_Scale", 1. / scale)
    local smallDis = self.attr:GetVal("ADBE_Displacement_Map_Small", progress)[1]
    local bigDis = self.attr:GetVal("ADBE_Displacement_Map_Big", progress)[1]
    self.smallWarpMat:setVec2("u_Offset", Amaz.Vector2f(smallDis, 0.0))
    self.bigWarpMat:setVec2("u_Offset", Amaz.Vector2f(bigDis, 0.0))

    local idx = math.floor(self.progress * 70)
    self.bigWarpAnim:seek(math.min(idx, 7))

    local blurIns = self.attr:GetVal("ADBE_Gaussian_Blur", progress)[1]
    self.GaussianRootLua:set("Intensity", blurIns)

end

---@param comp Component
---@param event Event
function AnimScript:onEvent(comp, event)
end

exports.AnimScript = AnimScript
return exports
