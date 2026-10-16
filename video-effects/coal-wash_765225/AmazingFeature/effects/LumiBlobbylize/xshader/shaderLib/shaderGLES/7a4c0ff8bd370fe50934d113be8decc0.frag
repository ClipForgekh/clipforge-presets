precision highp float;
precision highp int;

uniform mediump int u_edgeMode;
uniform mediump int u_property;
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
    vec2 _84 = _p1;
    _p1 = step(vec2(0.0), _p1) * step(_p1, vec2(1.0));
    return (texture2D(_p0, _84) * _p1.x) * _p1.y;
}

vec4 _f5(mediump sampler2D _p0, vec2 _p1)
{
    if (u_edgeMode == 0)
    {
        vec2 param = _p1;
        return _f2(_p0, param);
    }
    else
    {
        if (u_edgeMode == 1)
        {
            vec2 param_1 = _p1;
            return _f3(_p0, param_1);
        }
        else
        {
            if (u_edgeMode == 2)
            {
                vec2 param_2 = _p1;
                vec4 _168 = _f4(_p0, param_2);
                return _168;
            }
            else
            {
                vec2 param_3 = _p1;
                vec4 _173 = _f1(_p0, param_3);
                return _173;
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
    vec2 param = v_uv;
    vec4 param_1 = _f5(u_inputTexture, param);
    float param_2 = _f6(param_1);
    vec4 _271 = _f0(param_2);
    gl_FragData[0] = _271;
}

