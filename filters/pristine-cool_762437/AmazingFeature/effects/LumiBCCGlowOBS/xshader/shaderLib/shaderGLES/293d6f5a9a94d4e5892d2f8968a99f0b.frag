precision highp float;
precision highp int;

uniform float u_Delta;
uniform mediump sampler2D u_InputTexture;
uniform mediump int u_GlowChannels;
uniform float u_Threshold;

varying vec2 uv0;

float _f2(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

float _f1(vec3 _p0)
{
    float _99 = mix(_p0.z, _p0.y, step(_p0.z, _p0.y));
    return mix(_99, _p0.x, step(_99, _p0.x));
}

float _f3(vec2 _p0)
{
    mediump vec4 _125 = texture2D(u_InputTexture, _p0);
    vec4 _t4 = _125;
    if (u_GlowChannels == 5)
    {
        vec3 param = _125.xyz;
        return _f2(param);
    }
    else
    {
        if (u_GlowChannels == 6)
        {
            vec3 param_1 = _125.xyz;
            return _f1(param_1);
        }
        else
        {
            if (u_GlowChannels == 1)
            {
                return _t4.x;
            }
            else
            {
                if (u_GlowChannels == 2)
                {
                    return _t4.y;
                }
                else
                {
                    if (u_GlowChannels == 3)
                    {
                        return _t4.z;
                    }
                    else
                    {
                        if (u_GlowChannels == 4)
                        {
                            return _t4.w;
                        }
                    }
                }
            }
        }
    }
    return _t4.w;
}

vec4 _f0(float _p0, float _p1)
{
    vec4 _t0 = vec4(0.0);
    float _41 = clamp(_p1, u_Delta, 1.0 - u_Delta);
    float _55 = smoothstep(_41 - u_Delta, _41, _p0) - smoothstep(_41, _41 + u_Delta, _p0);
    _t0.x = _55;
    float _64 = u_Delta / 2.0;
    if (_p0 < (_41 - _64))
    {
        _t0.x = 1.0;
    }
    _t0.y = _55 * 0.5;
    if (_p0 > (_41 + _64))
    {
        _t0.y = 1.0;
    }
    return _t0;
}

void main()
{
    vec4 _t5 = vec4(0.0);
    if (u_GlowChannels == 0)
    {
        vec4 _t6 = texture2D(u_InputTexture, uv0);
        float _207 = u_Threshold - u_Delta;
        float _210 = u_Threshold + u_Delta;
        vec3 _237 = vec3(smoothstep(_207, _210, _t6.x), smoothstep(_207, _210, _t6.y), smoothstep(_207, _210, _t6.z));
        _t5.x = _237.x;
        _t5.y = _237.y;
        _t5.z = _237.z;
    }
    else
    {
        vec2 param = uv0;
        float param_1 = _f3(param);
        float param_2 = u_Threshold;
        _t5 = _f0(param_1, param_2);
    }
    gl_FragData[0] = _t5;
}

