precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump int u_inputType;
uniform mediump sampler2D u_inputTex;
uniform float u_threshold;
uniform float u_thresholdSmooth;
uniform float u_maskRadius;
uniform vec2 u_maskCenter;
uniform float u_maskFade;
uniform float u_mask;

varying vec2 v_uv;

vec3 _f1(vec4 _p0)
{
    if (_p0.w == 0.0)
    {
        return vec3(0.0);
    }
    return _p0.xyz / vec3(_p0.w);
}

float _f2(vec3 _p0)
{
    return (max(max(_p0.x, _p0.y), _p0.z) + min(min(_p0.x, _p0.y), _p0.z)) * 0.5;
}

float _f3(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

float _f4(vec4 _p0)
{
    vec4 param = _p0;
    vec3 _114 = _f1(param);
    vec3 _t3 = _114;
    if (u_inputType == 0)
    {
        vec3 param_1 = _114;
        return _f2(param_1);
    }
    else
    {
        if (u_inputType == 1)
        {
            vec3 param_2 = _114;
            return _f3(param_2);
        }
        else
        {
            if (u_inputType == 2)
            {
                return _p0.w;
            }
            else
            {
                if (u_inputType == 3)
                {
                    return _t3.x;
                }
                else
                {
                    if (u_inputType == 4)
                    {
                        return _t3.y;
                    }
                    else
                    {
                        return _t3.z;
                    }
                }
            }
        }
    }
}

vec2 _f0()
{
    return u_ScreenParams.xy * (1080.0 / min(u_ScreenParams.x, u_ScreenParams.y));
}

float _f5(float _p0, vec2 _p1, float _p2, float _p3)
{
    vec2 _t4 = _f0();
    return mix(1.0, smoothstep((_p0 + _p2) + 0.001000000047497451305389404296875, _p0, length((v_uv - _p1) * vec2(_t4.x / _t4.y, 1.0))), _p3);
}

void main()
{
    vec4 _t9 = texture2D(u_inputTex, v_uv);
    if (_t9.x < u_threshold)
    {
        _t9.x = ((_t9.x / u_threshold) * _t9.x) * u_thresholdSmooth;
    }
    if (_t9.y < u_threshold)
    {
        _t9.y = ((_t9.y / u_threshold) * _t9.y) * u_thresholdSmooth;
    }
    if (_t9.z < u_threshold)
    {
        _t9.z = ((_t9.z / u_threshold) * _t9.z) * u_thresholdSmooth;
    }
    vec4 param = _t9;
    float _t11 = _f4(param);
    float param_1 = 1.0 - u_maskRadius;
    vec2 param_2 = u_maskCenter;
    float param_3 = u_maskFade;
    float param_4 = u_mask;
    float _285 = _t11;
    float _286 = _285 * _f5(param_1, param_2, param_3, param_4);
    _t11 = _286;
    gl_FragData[0] = vec4(vec3(_286), 1.0);
}

