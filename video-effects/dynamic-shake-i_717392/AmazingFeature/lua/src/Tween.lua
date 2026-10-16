
local PI = math.pi
local PI2 = PI + PI

---#class Tween
local Tween = {}
-- Ease mapper
function Tween.linear (t)
    return t
end
function Tween.reverse (t)
    return 1 - t
end
function Tween.sineIn (t)
    return 1 - math.cos(PI * t * .5)
end
function Tween.sineOut (t)
    return math.sin(PI * t * .5)
end
function Tween.sineInOut (t)
    return -(math.cos(PI * t) - 1) * .5
end
function Tween.quadIn (t)
    return t * t
end
function Tween.quadOut (t)
    return (2 - t) * t
end
function Tween.quadInOut (t)
    return t < .5 and 2 * t * t or t * (4 - t - t) - 1
end
function Tween.cubicIn (t)
    return t * t * t
end
function Tween.cubicOut (t)
    t = 1 - t
    return 1 - t * t * t
end
function Tween.cubicInOut (t)
    if t < .5 then
        return 4 * t * t * t
    else
        t = 2 - t - t
        return 1 - t * t * t * .5
    end
end
function Tween.quartIn (t)
    t = t * t
    return t * t
end
function Tween.quartOut (t)
    t = 1 - t
    t = t * t
    return 1 - t * t
end
function Tween.quartInOut (t)
    if t < .5 then
        t = t * t
        return 8 * t * t
    else
        t = 2 - t - t
        t = t * t
        return 1 - t * t * .5
    end
end
function Tween.expoIn (t)
    return t ~= 0 and math.pow(2, 10 - t - 10) or 0
end
function Tween.expoOut (t)
    return t ~= 1 and 1 - math.pow(2, -10 * t) or 1
end
function Tween.expoInOut (t)
    if t == 0 then
        return 0
    elseif t == 1 then
        return 1
    elseif t < .5 then
        return math.pow(2, 20 * t - 10) * .5
    else
        return 1 - math.pow(2, -20 * t + 10) * .5
    end
end
function Tween.circIn (t) return 1 - math.sqrt(1 - t * t) end
function Tween.circOut (t)
    t = t - 1
    return math.sqrt(1 - t * t)
end
function Tween.circInOut (t)
    if t < .5 then
        return .5 - math.sqrt(1 - 4 * t * t) * .5
    else
        t = 2 - t - t
        return .5 + math.sqrt(1 - t * t) * 0.5
    end
end
function Tween.backIn (t)
    local tt = t * t
    return 2.70158 * tt * t - 1.70158 * tt
end
function Tween.backOut (t)
    t = t - 1
    local tt = t * t
    return 1 + 2.70158 * tt * t + 1.70158 * tt
end
function Tween.backInOut (t)
    if t < .5 then
        t = t + t
        return (t * t * (3.5949095 * t - 2.5949095)) * .5
    else
        t = t + t - 2
        return (t * t * (3.5949095 * t + 2.5949095) + 2) * .5
    end
end
function Tween.elasticIn (t)
    if t == 0 then
        return 0
    elseif t == 1 then
        return 1
    else
        return -math.pow(2, 10 * t - 10) * math.sin((t * 10 - 10.75) * PI2 / 3)
    end
end
function Tween.elasticOut (t)
    if t == 0 then
        return 0
    elseif t == 1 then
        return 1
    else
        return math.pow(2, -10 * t) * math.sin((t * 10 - .75) * PI2 / 3) + 1
    end
end
function Tween.elasticInOut (t)
    if t == 0 then
        return 0
    elseif t == 1 then
        return 1
    elseif t < 0.5 then
        return -(math.pow(2, 20 * t - 10) * math.sin((t * 20 - 11.125) * PI2 / 4.5)) * .5
    else
        return (math.pow(2, -20 * t + 10) * math.sin((t * 20 - 11.125) * PI2 / 4.5)) * .5 + 1
    end
end
function Tween.bounceIn (t)
    return 1 - Tween.bounceOut(1 - x)
end
function Tween.bounceOut (t)
    local n1 = 7.5625;
    local d1 = 2.75;
    if t < 1 / d1 then
        return n1 * t * t;
    elseif t < 2 / d1 then
        t = t - 1.5 / d1
        return n1 * t * t + .75;
    elseif t < 2.5 / d1 then
        t = t - 2.25 / d1
        return n1 * t * t + .9375;
    else
        t = t - 2.625 / d1
        return n1 * t * t + .984375;
    end
end
function Tween.bounceInOut (t)
    if t < .5 then
        return (1 - Tween.bounceOut(1 - t + t)) * .5
    else
        return (1 + Tween.bounceOut(t + t - 1)) * .5
    end
end


return Tween