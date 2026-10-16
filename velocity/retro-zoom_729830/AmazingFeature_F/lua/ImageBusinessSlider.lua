--write by editor  EffectSDK:10.5.0 EngineVersion:10.66.0 EditorBuildTime:Dec__7_2021_12_06_29
--sliderVersion: 20210901  Lua generation date: Fri Dec 31 14:14:56 2021


local exports = exports or {}
local ImageBusinessSlider = ImageBusinessSlider or {}
ImageBusinessSlider.__index = ImageBusinessSlider


function ImageBusinessSlider.new(construct, ...)
    local self = setmetatable({}, ImageBusinessSlider)
    if construct and ImageBusinessSlider.constructor then
        ImageBusinessSlider.constructor(self, ...)
    end
    return self
end


local function remap(x, a, b)
    return x * (b - a) + a
end


function ImageBusinessSlider:onStart(sys)
    self.Pass0Material0 = sys.scene:findEntityBy("Pass0"):getComponent("Renderer").material
end


function ImageBusinessSlider:onEvent(sys,event)
end


exports.ImageBusinessSlider = ImageBusinessSlider
return exports