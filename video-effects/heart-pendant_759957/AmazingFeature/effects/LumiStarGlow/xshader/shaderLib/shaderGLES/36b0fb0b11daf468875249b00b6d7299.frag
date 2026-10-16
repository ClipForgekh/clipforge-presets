precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTex;
uniform float u_srcOpacity;
uniform mediump sampler2D u_postTex;
uniform float u_glowOpacity;
uniform mediump int u_view;
uniform mediump sampler2D u_thresholdTex;
uniform mediump sampler2D u_shimmerTex;
uniform mediump int u_blendMode;

varying vec2 v_uv;

vec4 _f0(vec4 _p0)
{
    return vec4(_p0.xyz, max(max(_p0.x, _p0.y), _p0.z));
}

vec4 _f1(vec4 _p0, vec4 _p1)
{
    return vec4(min(_p0.xyz + _p1.xyz, vec3(1.0)), min(_p0.w + _p1.w, 1.0));
}

vec4 _f2(vec4 _p0, vec4 _p1)
{
    return vec4(vec3(1.0) - ((vec3(1.0) - _p0.xyz) * (vec3(1.0) - _p1.xyz)), (_p0.w + _p1.w) - (_p0.w * _p1.w));
}

vec4 _f3(vec4 _p0, vec4 _p1, mediump int _p2)
{
    if (_p2 == 1)
    {
        vec4 param = _p0;
        vec4 param_1 = _p1;
        return _f1(param, param_1);
    }
    else
    {
        if (_p2 == 2)
        {
            vec4 param_2 = _p0;
            vec4 param_3 = _p1;
            return _f2(param_2, param_3);
        }
    }
    return _p0;
}

void main()
{
    mediump vec4 _146 = texture2D(u_inputTex, v_uv);
    mediump vec4 _160 = texture2D(u_postTex, v_uv) * vec4(u_glowOpacity);
    vec4 _t6 = _160;
    vec4 param = _160;
    _t6 = _f0(param);
    vec4 _t7;
    if (u_view == 0)
    {
        _t7 = texture2D(u_thresholdTex, v_uv);
    }
    else
    {
        if (u_view == 1)
        {
            _t7 = texture2D(u_shimmerTex, v_uv);
        }
        else
        {
            if (u_view == 2)
            {
                _t7 = _t6;
            }
            else
            {
                if (u_view == 3)
                {
                    vec4 param_1 = _t6;
                    vec4 param_2 = _146 * vec4(u_srcOpacity);
                    mediump int param_3 = u_blendMode;
                    _t7 = _f3(param_1, param_2, param_3);
                }
            }
        }
    }
    gl_FragData[0] = _t7;
}

