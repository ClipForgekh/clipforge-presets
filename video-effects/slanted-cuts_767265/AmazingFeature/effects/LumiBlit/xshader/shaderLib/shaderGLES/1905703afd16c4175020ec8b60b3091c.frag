precision highp float;
precision highp int;

uniform mediump int u_frag_num;
uniform mediump sampler2D u_fragmentTexture_1;
uniform float u_fragDepth[12];
uniform mediump sampler2D u_fragmentTexture_2;
uniform mediump sampler2D u_fragmentTexture_3;
uniform mediump sampler2D u_fragmentTexture_4;
uniform mediump sampler2D u_fragmentTexture_5;
uniform mediump sampler2D u_fragmentTexture_6;
uniform mediump sampler2D u_fragmentTexture_7;
uniform mediump sampler2D u_fragmentTexture_8;
uniform mediump sampler2D u_fragmentTexture_9;
uniform mediump sampler2D u_fragmentTexture_10;
uniform mediump sampler2D u_fragmentTexture_11;
uniform mediump sampler2D u_fragmentTexture_12;

varying vec2 v_uv;

vec4 _f0(vec4 _p0, vec4 _p1)
{
    return _p1 + (_p0 * (1.0 - _p1.w));
}

void main()
{
    mediump int _t0 = 0;
    vec4 _t2[12];
    float _t3[12];
    if (u_frag_num >= 1)
    {
        mediump vec4 _49 = texture2D(u_fragmentTexture_1, v_uv);
        vec4 _t1 = _49;
        if (_t1.w > 0.001000000047497451305389404296875)
        {
            _t2[0] = vec4(_49.xyz * _t1.w, _t1.w);
            _t3[0] = u_fragDepth[0];
            _t0 = 1;
        }
    }
    if (u_frag_num >= 2)
    {
        mediump vec4 _91 = texture2D(u_fragmentTexture_2, v_uv);
        vec4 _t4 = _91;
        if (_t4.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_91.xyz * _t4.w, _t4.w);
            _t3[_t0] = u_fragDepth[1];
            _t0++;
        }
    }
    if (u_frag_num >= 3)
    {
        mediump vec4 _125 = texture2D(u_fragmentTexture_3, v_uv);
        vec4 _t5 = _125;
        if (_t5.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_125.xyz * _t5.w, _t5.w);
            _t3[_t0] = u_fragDepth[2];
            _t0++;
        }
    }
    if (u_frag_num >= 4)
    {
        mediump vec4 _159 = texture2D(u_fragmentTexture_4, v_uv);
        vec4 _t6 = _159;
        if (_t6.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_159.xyz * _t6.w, _t6.w);
            _t3[_t0] = u_fragDepth[3];
            _t0++;
        }
    }
    if (u_frag_num >= 5)
    {
        mediump vec4 _193 = texture2D(u_fragmentTexture_5, v_uv);
        vec4 _t7 = _193;
        if (_t7.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_193.xyz * _t7.w, _t7.w);
            _t3[_t0] = u_fragDepth[4];
            _t0++;
        }
    }
    if (u_frag_num >= 6)
    {
        mediump vec4 _227 = texture2D(u_fragmentTexture_6, v_uv);
        vec4 _t8 = _227;
        if (_t8.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_227.xyz * _t8.w, _t8.w);
            _t3[_t0] = u_fragDepth[5];
            _t0++;
        }
    }
    if (u_frag_num >= 7)
    {
        mediump vec4 _261 = texture2D(u_fragmentTexture_7, v_uv);
        vec4 _t9 = _261;
        if (_t9.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_261.xyz * _t9.w, _t9.w);
            _t3[_t0] = u_fragDepth[6];
            _t0++;
        }
    }
    if (u_frag_num >= 8)
    {
        mediump vec4 _295 = texture2D(u_fragmentTexture_8, v_uv);
        vec4 _t10 = _295;
        if (_t10.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_295.xyz * _t10.w, _t10.w);
            _t3[_t0] = u_fragDepth[7];
            _t0++;
        }
    }
    if (u_frag_num >= 9)
    {
        mediump vec4 _329 = texture2D(u_fragmentTexture_9, v_uv);
        vec4 _t11 = _329;
        if (_t11.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_329.xyz * _t11.w, _t11.w);
            _t3[_t0] = u_fragDepth[8];
            _t0++;
        }
    }
    if (u_frag_num >= 10)
    {
        mediump vec4 _363 = texture2D(u_fragmentTexture_10, v_uv);
        vec4 _t12 = _363;
        if (_t12.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_363.xyz * _t12.w, _t12.w);
            _t3[_t0] = u_fragDepth[9];
            _t0++;
        }
    }
    if (u_frag_num >= 11)
    {
        mediump vec4 _397 = texture2D(u_fragmentTexture_11, v_uv);
        vec4 _t13 = _397;
        if (_t13.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_397.xyz * _t13.w, _t13.w);
            _t3[_t0] = u_fragDepth[10];
            _t0++;
        }
    }
    if (u_frag_num >= 12)
    {
        mediump vec4 _431 = texture2D(u_fragmentTexture_12, v_uv);
        vec4 _t14 = _431;
        if (_t14.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = vec4(_431.xyz * _t14.w, _t14.w);
            _t3[_t0] = u_fragDepth[11];
            _t0++;
        }
    }
    for (mediump int _t15 = 0; _t15 < 11; _t15++)
    {
        mediump int _466 = _t15 + 1;
        for (mediump int _t16 = _466; _t16 < 12; _t16++)
        {
            bool _476 = _t16 < _t0;
            bool _486;
            if (_476)
            {
                _486 = _t3[_t15] > _t3[_t16];
            }
            else
            {
                _486 = _476;
            }
            if (_486)
            {
                float _492 = _t3[_t15];
                _t3[_t15] = _t3[_t16];
                _t3[_t16] = _492;
                vec4 _504 = _t2[_t15];
                _t2[_t15] = _t2[_t16];
                _t2[_t16] = _504;
            }
        }
    }
    vec4 _t19 = vec4(0.0);
    for (mediump int _t20 = 0; _t20 < 12; _t20++)
    {
        if (_t20 < _t0)
        {
            vec4 param = _t19;
            vec4 param_1 = _t2[_t20];
            _t19 = _f0(param, param_1);
        }
    }
    gl_FragData[0] = _t19;
}

