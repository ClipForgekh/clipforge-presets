precision highp float;
precision highp int;

uniform vec3 u_color_mid;
uniform vec2 u_singleGradient;
uniform vec3 u_threeGradient;
uniform vec3 u_color_low;
uniform vec3 u_color_high;
uniform vec4 u_fiveGradient;
uniform float u_fiveGradientVeryHigh;
uniform vec3 u_color_midLow;
uniform vec3 u_color_midHigh;
uniform mediump sampler2D u_inputTexture;
uniform float u_stepSize;
uniform float u_range;
uniform float u_gammaInv;
uniform vec2 u_currentDir;
uniform mediump int u_colorMode;

varying vec2 v_uv;

vec3 _f0(mediump int _p0, float _p1)
{
    if (_p0 == 0)
    {
        return mix(vec3(0.0), u_color_mid, vec3(smoothstep(u_singleGradient.x, u_singleGradient.y, _p1)));
    }
    else
    {
        if (_p0 == 1)
        {
            return mix(mix(u_color_low, u_color_mid, vec3(smoothstep(u_threeGradient.x, u_threeGradient.y, _p1))), mix(u_color_mid, u_color_high, vec3(smoothstep(u_threeGradient.y, u_threeGradient.z, _p1))), vec3(step(u_threeGradient.y, _p1)));
        }
        else
        {
            if (_p0 == 2)
            {
                return mix(mix(mix(u_color_low, u_color_midLow, vec3(smoothstep(u_fiveGradient.x, u_fiveGradient.y, _p1))), mix(u_color_midLow, u_color_mid, vec3(smoothstep(u_fiveGradient.y, u_fiveGradient.z, _p1))), vec3(step(u_fiveGradient.y, _p1))), mix(mix(u_color_mid, u_color_midHigh, vec3(smoothstep(u_fiveGradient.z, u_fiveGradient.w, _p1))), mix(u_color_midHigh, u_color_high, vec3(smoothstep(u_fiveGradient.w, u_fiveGradientVeryHigh, _p1))), vec3(step(u_fiveGradient.w, _p1))), vec3(step(u_fiveGradient.z, _p1)));
            }
        }
    }
    return u_color_mid;
}

void main()
{
    float _202 = min(1.0, 1.0 / u_stepSize);
    float _216 = _202 * (1.0 / max(u_range, 0.001000000047497451305389404296875));
    vec3 _220 = vec3(u_gammaInv);
    int _229 = int(min(u_range / _202, 64.0));
    if (_229 <= 0)
    {
        gl_FragData[0] = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }
    vec3 _t23 = vec3(0.0);
    float _t24 = 0.0;
    vec2 _244 = u_currentDir * (u_stepSize * _202);
    vec2 _t26 = v_uv;
    for (mediump int _t27 = 1; _t27 <= _229; _t27++)
    {
        _t26 += _244;
        float _265 = float(_t27) * _216;
        float _280 = exp((-3.0) * (_265 * _265)) * (1.0 - smoothstep(0.0, 1.0, _265 * 0.800000011920928955078125));
        if (_280 < 0.001000000047497451305389404296875)
        {
            continue;
        }
        vec3 _294 = pow(texture2D(u_inputTexture, _t26).xyz, _220);
        mediump int param = u_colorMode;
        float param_1 = dot(_294, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
        _t23 += ((_294 * _f0(param, param_1)) * _280);
        _t24 += _280;
    }
    vec3 _325;
    if (_t24 > 0.001000000047497451305389404296875)
    {
        _325 = _t23 / vec3(_t24);
    }
    else
    {
        _325 = vec3(0.0);
    }
    gl_FragData[0] = vec4(_325, 1.0);
}

