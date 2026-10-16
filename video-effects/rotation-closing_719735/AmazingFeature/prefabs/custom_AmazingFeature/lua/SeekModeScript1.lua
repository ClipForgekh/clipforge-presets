-- --@input float curTime = 0.0{"widget":"slider","min":0,"max":1}

-- local ae_attribute = {
-- 	["ADBE_Camera_Lens_Blur_0001_0"]={
-- 		[1]={{0, 33.333333, }, {0, 33.3333329588067, }, 0, 18, }, 
-- 		[2]={{0, 33.3333331071026, }, {0, 16.666666667, }, 18, 0, }, 
-- 		[3]={{0, 33.3333331071026, }, {0, 16.666666667, }, 25, 0, }, 
-- 	}, 
-- 	["ADBE_Wave_Warp_0002_0"]={
-- 		[1]={{0, 16.666666667, }, {0, 33.333333, }, 0, 35, }, 
-- 		[2]={{0, 33.333333, }, {0, 16.666666667, }, 20, 0, }, 
-- 		[3]={{0, 33.333333, }, {0, 16.666666667, }, 25, 0, }, 
-- 	}, 
-- 	["ADBE_Wave_Warp_0003_0"]={
-- 		[1]={{0, 16.666666667, }, {0, 33.333333, }, 0, 220.1, }, 
-- 		[2]={{0, 33.333333, }, {0, 16.666666667, }, 14, 252, }, 
-- 		[3]={{0, 33.333333, }, {0, 16.666666667, }, 25, 252, }, 
-- 	}, 
-- 	["ADBE_Optics_Compensation_0001_0"]={
-- 		[1]={{0, 33.333333, }, {0, 33.333333, }, 0, 100, }, 
-- 		[2]={{0, 33.333333, }, {0, 16.666666667, }, 25, 0, }, 
-- 	}, 
-- 	["ADBE_Scale_0"]={
-- 		[1]={{0, 33.333333, }, {0.00000315230744, 53.349317101366, }, 0, {180, 180, 100, }, }, 
-- 		[2]={{0.00000239356586, 45.0329354736288, }, {0, 16.666666667, }, 17, {100, 100, 100, }, }, 
-- 		[3]={{0.00000239356586, 45.0329354736288, }, {0, 16.666666667, }, 25, {100, 100, 100, }, }, 
-- 	}, 
-- 	["ADBE_Rotate_Z_0"]={
-- 		[1]={{0, 33.333333, }, {0.00000323498443, 53.1538957326151, }, 0, 45, }, 
-- 		[2]={{0.00000251472375, 63.7931407875174, }, {0, 16.666666667, }, 13, 0, }, 
-- 		[3]={{0.00000251472375, 63.7931407875174, }, {0, 16.666666667, }, 25, 0, }, 
-- 	}, 
--     ["ADBE_Vector_Scale_0"]={
-- 		[1]={{0, 33.333333, }, {0, 33.333333, }, 0, {0, 100, }, }, 
-- 		[2]={{0, 33.333333, }, {0, 33.333333, }, 18, {59, 82, }, }, 
-- 		[3]={{0, 16.666666667, }, {0, 16.666666667, }, 25, {59, 82, }, }, 
-- 	}, 
-- 	["ADBE_Vector_Rotation_0"]={
-- 		[1]={{0, 0.01, }, {-63.5689471752688, 48.585988022387, }, 0, 45, }, 
-- 		[2]={{2.60270979879351e-7, 29.9490471947051, }, {0, 16.666666667, }, 16, 0, }, 
-- 		[3]={{2.60270979879351e-7, 29.9490471947051, }, {0, 16.666666667, }, 25, 0, }, 
-- 	}, 
-- }

-- local AETools = AETools or {}     ---@class AETools
-- AETools.__index = AETools

-- function AETools:new(frameRate)
--     local self = setmetatable({}, AETools)
--     self.key_frame_info = {}
--     self.frameRate = frameRate == nil and 16 or frameRate
--     return self
-- end

-- function AETools:addKeyFrameInfo(in_val, out_val, frame, val)
--     local key_frame_count = #self.key_frame_info
--     if key_frame_count == 0 and frame > 0 then
--         self.key_frame_info[key_frame_count + 1] = {
--             ["v_in"] = in_val,
--             ["v_out"] = out_val,
--             ["cur_frame"] = 0,
--             ["value"] = val
--         }
--     end

--     key_frame_count = #self.key_frame_info
--     self.key_frame_info[key_frame_count + 1] = {
--         ["v_in"] = in_val,
--         ["v_out"] = out_val,
--         ["cur_frame"] = frame,
--         ["value"] = val
--     }
--     self:_updateKeyFrameInfo()
-- end

-- function AETools._remap01(a,b,x)
--     if x < a then return 0 end
--     if x > b then return 1 end
--     return (x-a)/(b-a)
-- end

-- function AETools._cubicBezier(p1, p2, p3, p4, t)
--     return {
--         p1[1]*(1.-t)*(1.-t)*(1.-t) + 3*p2[1]*(1.-t)*(1.-t)*t + 3*p3[1]*(1.-t)*t*t + p4[1]*t*t*t,
--         p1[2]*(1.-t)*(1.-t)*(1.-t) + 3*p2[2]*(1.-t)*(1.-t)*t + 3*p3[2]*(1.-t)*t*t + p4[2]*t*t*t,
--     }
-- end

-- function AETools:_cubicBezier01(_bezier_val, p)
--     local x = self:_getBezier01X(_bezier_val, p)
--     return self._cubicBezier(
--         {0,0},
--         {_bezier_val[1], _bezier_val[2]},
--         {_bezier_val[3], _bezier_val[4]},
--         {1,1},
--         x
--     )[2]
-- end

-- function AETools:_getBezier01X(_bezier_val, x)
--     local ts = 0
--     local te = 1
--     -- divide and conque
--     repeat
--         local tm = (ts+te)*0.5
--         local value = self._cubicBezier(
--             {0,0},
--             {_bezier_val[1], _bezier_val[2]},
--             {_bezier_val[3], _bezier_val[4]},
--             {1,-1},
--             tm)
--         if(value[1]>x) then
--             te = tm
--         else
--             ts = tm
--         end
--     until(te-ts < 0.0001)

--     return (te+ts)*0.5
-- end

-- function AETools._mix(a, b, x)
--     return a * (1-x) + b * x
-- end

-- function AETools:_updateKeyFrameInfo()
--     if self.key_frame_info and #self.key_frame_info > 0 then
--         self.finish_frame_time = self.key_frame_info[#self.key_frame_info]["cur_frame"]
--     end
-- end

-- function AETools._getDiff(val1, val2)
--     local res = nil
--     if type(val1) == "table" then
--         local tmp_sum = 0
--         for i = 1, #val1 do
--             local tmp_v = math.abs(val1[i]-val2[i])
--             tmp_sum = tmp_sum + tmp_v * tmp_v
--         end
--         res = math.sqrt(tmp_sum)
--     else
--         res = math.abs(val1-val2)
--     end
--     return res
-- end

-- function AETools:getCurPartVal(_progress, hard_cut)
    
--     local part_id, part_progress = self:_getCurPart(_progress)

--     local frame1 = self.key_frame_info[part_id-1]
--     local frame2 = self.key_frame_info[part_id]

--     if hard_cut == true then
--         return frame1["value"]
--     end

--     local info1 = frame1["v_out"]
--     local info2 = frame2["v_in"]

--     local duration = (frame2["cur_frame"]-frame1["cur_frame"])/self.frameRate
--     local diff = self._getDiff(frame1["value"], frame2["value"])

--     local average = diff/duration + 0.0001

--     local x1 = info1[2]/100
--     local y1 = x1*info1[1]/average
--     local x2 = 1-info2[2]/100
--     local y2 = 1-(1-x2)*info2[1]/average

--     if type(frame1["value"]) == "number" then
--         if frame1["value"] > frame2["value"] then
--             x1 = info1[2]/100
--             y1 = -x1*info1[1]/average
--             x2 = info2[2]/100
--             y2 = 1+x2*info2[1]/average
--             x2 = 1-x2
--         end

--         local bezier_val = {x1, y1, x2, y2}

--         local progress = self:_cubicBezier01(bezier_val, part_progress)

--         return self._mix(frame1["value"], frame2["value"], progress)
--     end

--     local res = {}
--     for i = 1, #frame1["value"] do

--         if frame1["value"][i] > frame2["value"][i] then
--             x1 = info1[2]/100
--             y1 = -x1*info1[1]/average
--             x2 = info2[2]/100
--             y2 = 1+x2*info2[1]/average
--             x2 = 1-x2
--         end

--         local bezier_val = {x1, y1, x2, y2}

--         local progress = self:_cubicBezier01(bezier_val, part_progress)
--         res[i] = self._mix(frame1["value"][i], frame2["value"][i], progress)
--     end
--     return res

-- end

-- function AETools:_getCurPart(progress)
--     if progress > 0.999 then
--         return #self.key_frame_info, 1
--     end

--     for i = 1, #self.key_frame_info do
--         local info = self.key_frame_info[i]
--         if progress < info["cur_frame"]/self.finish_frame_time then
--             return i, self._remap01(
--                 self.key_frame_info[i-1]["cur_frame"]/self.finish_frame_time,
--                 self.key_frame_info[i]["cur_frame"]/self.finish_frame_time,
--                 progress
--             )
--         end
--     end
-- end

-- function AETools:clear()
--     self.key_frame_info = {}
--     self:_updateKeyFrameInfo()
-- end

-- function AETools:test()
--     Amaz.LOGI("lrc "..tostring(self.key_frame_info), tostring(#self.key_frame_info))
-- end

-- local exports = exports or {}
-- local SeekModeScript1 = SeekModeScript1 or {}
-- SeekModeScript1.__index = SeekModeScript1

-- function SeekModeScript1.new(construct, ...)
--     local self = setmetatable({}, SeekModeScript1)

--     if construct and SeekModeScript1.constructor then SeekModeScript1.constructor(self, ...) end
--     self.curTime = 0
--     self.progress = 0
--     self.startTime = 0
--     return self
-- end

-- function SeekModeScript1:constructor()
-- end

-- function SeekModeScript1:onStart(comp)
--     self.matTransform = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassTransform"):getComponent("MeshRenderer").material
--     self.matHorzBlur = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassHorzBlur"):getComponent("MeshRenderer").material
--     self.matVertBlur = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassVertBlur"):getComponent("MeshRenderer").material
--     self.matHorzBlur1 = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassHorzBlur1"):getComponent("MeshRenderer").material
--     self.matVertBlur1 = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassVertBlur1"):getComponent("MeshRenderer").material
--     self.matWave = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassWave"):getComponent("MeshRenderer").material
--     self.matFOV = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassFOV"):getComponent("MeshRenderer").material
--     self.matMask = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("PassMask"):getComponent("MeshRenderer").material

--     self.camHorzBlurRT = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("CameraTransform"):getComponent("Camera").renderTexture
--     self.camVertBlurRT = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("CameraHorzBlur"):getComponent("Camera").renderTexture
--     self.camHorzBlurRT1 = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("CameraVertBlur"):getComponent("Camera").renderTexture
--     self.camVertBlurRT1 = comp.entity.scene:findEntityBy("custom_AmazingFeature"):searchEntity("CameraHorzBlur1"):getComponent("Camera").renderTexture
--     if self.curveScale == nil then
-- 		self.curveScale = AETools:new()
-- 		for i = 1, #ae_attribute.ADBE_Scale_0 do
-- 			local value = ae_attribute.ADBE_Scale_0[i]
-- 			self.curveScale:addKeyFrameInfo(value[1], value[2], value[3], value[4][1])
-- 		end
-- 	end

--     if self.curveRotate == nil then
-- 		self.curveRotate = AETools:new()
-- 		for i = 1, #ae_attribute.ADBE_Rotate_Z_0 do
-- 			local value = ae_attribute.ADBE_Rotate_Z_0[i]
-- 			self.curveRotate:addKeyFrameInfo(value[1], value[2], value[3], value[4])
-- 		end
-- 	end

--     if self.curveBlur == nil then
-- 		self.curveBlur = AETools:new()
-- 		for i = 1, #ae_attribute.ADBE_Camera_Lens_Blur_0001_0 do
-- 			local value = ae_attribute.ADBE_Camera_Lens_Blur_0001_0[i]
-- 			self.curveBlur:addKeyFrameInfo(value[1], value[2], value[3], value[4])
-- 		end
-- 	end

--     if self.curveWaveHeight == nil then
-- 		self.curveWaveHeight = AETools:new()
-- 		for i = 1, #ae_attribute.ADBE_Wave_Warp_0002_0 do
-- 			local value = ae_attribute.ADBE_Wave_Warp_0002_0[i]
-- 			self.curveWaveHeight:addKeyFrameInfo(value[1], value[2], value[3], value[4])
-- 		end
-- 	end
--     if self.curveWaveWidth == nil then
-- 		self.curveWaveWidth = AETools:new()
-- 		for i = 1, #ae_attribute.ADBE_Wave_Warp_0003_0 do
-- 			local value = ae_attribute.ADBE_Wave_Warp_0003_0[i]
-- 			self.curveWaveWidth:addKeyFrameInfo(value[1], value[2], value[3], value[4])
-- 		end
-- 	end
--     if self.curveFOV == nil then
-- 		self.curveFOV = AETools:new()
-- 		for i = 1, #ae_attribute.ADBE_Optics_Compensation_0001_0 do
-- 			local value = ae_attribute.ADBE_Optics_Compensation_0001_0[i]
-- 			self.curveFOV:addKeyFrameInfo(value[1], value[2], value[3], value[4])
-- 		end
-- 	end

--     if self.curveMaskWidth == nil then
-- 		self.curveMaskWidth = AETools:new()
-- 		for i = 1, #ae_attribute.ADBE_Vector_Scale_0 do
-- 			local value = ae_attribute.ADBE_Vector_Scale_0[i]
-- 			self.curveMaskWidth:addKeyFrameInfo(value[1], value[2], value[3], value[4][1])
-- 		end
-- 	end

--     if self.curveMaskAngle == nil then
-- 		self.curveMaskAngle = AETools:new()
-- 		for i = 1, #ae_attribute.ADBE_Vector_Rotation_0 do
-- 			local value = ae_attribute.ADBE_Vector_Rotation_0[i]
-- 			self.curveMaskAngle:addKeyFrameInfo(value[1], value[2], value[3], value[4])
-- 		end
-- 	end
-- end

-- function SeekModeScript1:onUpdate(comp, deltaTime)
--     self.curTime = self.curTime + deltaTime
--     self.progress = self.curTime - self.startTime
--     if self.progress > 1 then
--         self.progress = 1
--     end
--     -- local props = comp.entity:getComponent("ScriptComponent").properties
--     -- if props:has("curTime") then
--     --     self.curTime = props:get("curTime")
--     -- end
--     -- self.progress = self.curTime
--     self.matTransform:setFloat("scale", self.curveScale:getCurPartVal(self.progress) / 100)
--     self.matTransform:setFloat("angle", self.curveRotate:getCurPartVal(self.progress))
--     self.matHorzBlur:setFloat("horzR", 20 * self.curveBlur:getCurPartVal(self.progress) / 18)
--     self.matVertBlur:setFloat("vertR", 20 * self.curveBlur:getCurPartVal(self.progress) / 18)
--     self.matHorzBlur1:setFloat("horzR", 20 * self.curveBlur:getCurPartVal(self.progress) / 18)
--     self.matVertBlur1:setFloat("vertR", 20 * self.curveBlur:getCurPartVal(self.progress) / 18)
--     self.camHorzBlurRT.pecentX = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
--     self.camHorzBlurRT.pecentY = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
--     self.camVertBlurRT.pecentX = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
--     self.camVertBlurRT.pecentY = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
--     self.camHorzBlurRT1.pecentX = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
--     self.camHorzBlurRT1.pecentY = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
--     self.camVertBlurRT1.pecentX = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
--     self.camVertBlurRT1.pecentY = 1 - 0.5 * self.curveBlur:getCurPartVal(self.progress) / 18
--     self.matWave:setFloat("waveHeight", self.curveWaveHeight:getCurPartVal(self.progress) / 35)
--     self.matWave:setFloat("waveWidth", (self.curveWaveWidth:getCurPartVal(self.progress) - 220) / 32)
--     self.matWave:setFloat("progress", self.progress)
--     self.matFOV:setFloat("fov", self.curveFOV:getCurPartVal(self.progress) / 100)
--     self.matMask:setFloat("width", self.curveMaskWidth:getCurPartVal(self.progress) / 59)
--     self.matMask:setFloat("angle", -self.curveMaskAngle:getCurPartVal(self.progress))
--     -- Amaz.LOGI("ldrldr", self.curveScale:getCurPartVal(self.progress) / 100)
-- end

-- exports.SeekModeScript1 = SeekModeScript1
-- return exports
