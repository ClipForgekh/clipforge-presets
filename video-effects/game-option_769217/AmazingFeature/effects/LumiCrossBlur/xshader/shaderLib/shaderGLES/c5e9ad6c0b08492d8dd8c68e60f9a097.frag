precision highp float;
precision highp int;

uniform mediump sampler2D u_gaussianBlurXTexture;
uniform mediump sampler2D u_gaussianBlurYTexture;
uniform mediump int u_blendType;

varying vec2 uv0;

vec4 _f2(vec4 _p0, vec4 _p1)
{
    vec4 _t0 = vec4(0.0);
    vec3 _76 = _p0.xyz + _p1.xyz;
    _t0.x = _76.x;
    _t0.y = _76.y;
    _t0.z = _76.z;
    _t0.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t0;
}

vec4 _f3(vec4 _p0, vec4 _p1)
{
    return vec4(1.0) - ((vec4(1.0) - _p0) * (vec4(1.0) - _p1));
}

vec4 _f0(inout vec4 _p0)
{
    float _42 = _p0.w;
    vec4 _46 = _p0;
    vec3 _49 = _46.xyz / vec3(max(_42, 9.9999997473787516355514526367188e-06));
    _p0.x = _49.x;
    _p0.y = _49.y;
    _p0.z = _49.z;
    return _p0;
}

vec4 _f4(inout vec4 _p0, inout vec4 _p1)
{
    vec4 _t1 = vec4(0.0);
    vec4 param = _p0;
    vec4 _111 = _f0(param);
    _p0 = _111;
    vec4 param_1 = _p1;
    vec4 _114 = _f0(param_1);
    _p1 = _114;
    vec3 _119 = _p0.xyz * _p1.xyz;
    _t1.x = _119.x;
    _t1.y = _119.y;
    _t1.z = _119.z;
    _t1.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t1;
}

vec4 _f5(vec4 _p0, vec4 _p1)
{
    vec4 _t2 = vec4(0.0);
    vec3 _144 = max(_p0.xyz, _p1.xyz);
    _t2.x = _144.x;
    _t2.y = _144.y;
    _t2.z = _144.z;
    _t2.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t2;
}

vec4 _f6(vec4 _p0, vec4 _p1)
{
    vec4 _t3 = vec4(0.0);
    vec3 _169 = min(_p0.xyz, _p1.xyz);
    _t3.x = _169.x;
    _t3.y = _169.y;
    _t3.z = _169.z;
    _t3.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t3;
}

vec4 _f1(vec4 _p0, vec4 _p1)
{
    return (_p0 + _p1) * 0.5;
}

void main()
{
    mediump vec4 _199 = texture2D(u_gaussianBlurXTexture, uv0);
    mediump vec4 _204 = texture2D(u_gaussianBlurYTexture, uv0);
    if (u_blendType == 1)
    {
        vec4 param = _199;
        vec4 param_1 = _204;
        gl_FragData[0] = _f2(param, param_1);
    }
    else
    {
        if (u_blendType == 2)
        {
            vec4 param_2 = _199;
            vec4 param_3 = _204;
            gl_FragData[0] = _f3(param_2, param_3);
        }
        else
        {
            if (u_blendType == 3)
            {
                vec4 param_4 = _199;
                vec4 param_5 = _204;
                vec4 _242 = _f4(param_4, param_5);
                gl_FragData[0] = _242;
            }
            else
            {
                if (u_blendType == 4)
                {
                    vec4 param_6 = _199;
                    vec4 param_7 = _204;
                    gl_FragData[0] = _f5(param_6, param_7);
                }
                else
                {
                    if (u_blendType == 5)
                    {
                        vec4 param_8 = _199;
                        vec4 param_9 = _204;
                        gl_FragData[0] = _f6(param_8, param_9);
                    }
                    else
                    {
                        vec4 param_10 = _199;
                        vec4 param_11 = _204;
                        gl_FragData[0] = _f1(param_10, param_11);
                    }
                }
            }
        }
    }
}

