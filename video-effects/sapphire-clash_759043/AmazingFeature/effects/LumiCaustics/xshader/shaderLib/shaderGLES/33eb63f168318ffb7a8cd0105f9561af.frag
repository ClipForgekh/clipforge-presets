precision highp float;
precision highp int;

uniform mediump int u_property;
uniform mediump int u_edgeMode;
uniform mediump sampler2D u_inputTexture;

varying vec2 v_uv;

vec4 _f2(mediump sampler2D _p0, vec2 _p1)
{
    return texture2D(_p0, clamp(_p1, vec2(0.0), vec2(1.0)));
}

vec4 _f3(mediump sampler2D _p0, vec2 _p1)
{
    return texture2D(_p0, fract(_p1));
}

vec4 _f4(mediump sampler2D _p0, inout vec2 _p1)
{
    _p1 = abs(mod(_p1 + vec2(1.0), vec2(2.0)) - vec2(1.0));
    return texture2D(_p0, _p1);
}

vec4 _f1(mediump sampler2D _p0, inout vec2 _p1)
{
    vec2 _88 = _p1;
    _p1 = step(vec2(0.0), _p1) * step(_p1, vec2(1.0));
    return (texture2D(_p0, _88) * _p1.x) * _p1.y;
}

vec4 _f5(mediump int _p0, mediump sampler2D _p1, vec2 _p2)
{
    if (_p0 == 0)
    {
        vec2 param = _p2;
        return _f2(_p1, param);
    }
    else
    {
        if (_p0 == 1)
        {
            vec2 param_1 = _p2;
            return _f3(_p1, param_1);
        }
        else
        {
            if (_p0 == 2)
            {
                vec2 param_2 = _p2;
                vec4 _169 = _f4(_p1, param_2);
                return _169;
            }
            else
            {
                vec2 param_3 = _p2;
                vec4 _174 = _f1(_p1, param_3);
                return _174;
            }
        }
    }
}

float _f6(vec4 _p0)
{
    if (u_property == 0)
    {
        return _p0.x;
    }
    else
    {
        if (u_property == 1)
        {
            return _p0.y;
        }
        else
        {
            if (u_property == 2)
            {
                return _p0.z;
            }
            else
            {
                if (u_property == 3)
                {
                    return _p0.w;
                }
                else
                {
                    if (u_property == 4)
                    {
                        return dot(_p0.xyz, vec3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875));
                    }
                    else
                    {
                        if (u_property == 5)
                        {
                            return (max(max(_p0.x, _p0.y), _p0.z) + min(min(_p0.x, _p0.y), _p0.z)) * 0.5;
                        }
                    }
                }
            }
        }
    }
    return dot(_p0.xyz, vec3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875));
}

vec4 _f0(inout float _p0)
{
    vec4 _t0 = vec4(0.0);
    _p0 *= 255.0;
    _t0.x = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.y = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.z = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _t0.w = _p0;
    return _t0;
}

void main()
{
    mediump int param = u_edgeMode;
    vec2 param_1 = v_uv;
    vec4 param_2 = _f5(param, u_inputTexture, param_1);
    float param_3 = _f6(param_2);
    vec4 _276 = _f0(param_3);
    gl_FragData[0] = _276;
}

