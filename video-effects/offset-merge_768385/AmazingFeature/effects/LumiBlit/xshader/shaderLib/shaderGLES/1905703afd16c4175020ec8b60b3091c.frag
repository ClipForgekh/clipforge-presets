precision highp float;
precision highp int;

uniform mediump int u_frag_num;
uniform mediump sampler2D u_fragmentTexture_1;
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
uniform mediump sampler2D u_fragmentTexture_13;
uniform mediump sampler2D u_fragmentTexture_14;
uniform mediump sampler2D u_fragmentTexture_15;

varying vec2 v_uv;

vec4 _f0(vec4 _p0, vec4 _p1)
{
    return _p1 + (_p0 * (1.0 - _p1.w));
}

void main()
{
    vec4 _t0 = vec4(0.0);
    if (u_frag_num >= 1)
    {
        mediump vec4 _49 = texture2D(u_fragmentTexture_1, v_uv);
        vec4 _t1 = _49;
        vec4 param = _t0;
        vec4 param_1 = vec4(_49.xyz * _t1.w, _t1.w);
        _t0 = _f0(param, param_1);
    }
    if (u_frag_num >= 2)
    {
        mediump vec4 _75 = texture2D(u_fragmentTexture_2, v_uv);
        vec4 _t2 = _75;
        vec4 param_2 = _t0;
        vec4 param_3 = vec4(_75.xyz * _t2.w, _t2.w);
        _t0 = _f0(param_2, param_3);
    }
    if (u_frag_num >= 3)
    {
        mediump vec4 _100 = texture2D(u_fragmentTexture_3, v_uv);
        vec4 _t3 = _100;
        vec4 param_4 = _t0;
        vec4 param_5 = vec4(_100.xyz * _t3.w, _t3.w);
        _t0 = _f0(param_4, param_5);
    }
    if (u_frag_num >= 4)
    {
        mediump vec4 _125 = texture2D(u_fragmentTexture_4, v_uv);
        vec4 _t4 = _125;
        vec4 param_6 = _t0;
        vec4 param_7 = vec4(_125.xyz * _t4.w, _t4.w);
        _t0 = _f0(param_6, param_7);
    }
    if (u_frag_num >= 5)
    {
        mediump vec4 _150 = texture2D(u_fragmentTexture_5, v_uv);
        vec4 _t5 = _150;
        vec4 param_8 = _t0;
        vec4 param_9 = vec4(_150.xyz * _t5.w, _t5.w);
        _t0 = _f0(param_8, param_9);
    }
    if (u_frag_num >= 6)
    {
        mediump vec4 _175 = texture2D(u_fragmentTexture_6, v_uv);
        vec4 _t6 = _175;
        vec4 param_10 = _t0;
        vec4 param_11 = vec4(_175.xyz * _t6.w, _t6.w);
        _t0 = _f0(param_10, param_11);
    }
    if (u_frag_num >= 7)
    {
        mediump vec4 _200 = texture2D(u_fragmentTexture_7, v_uv);
        vec4 _t7 = _200;
        vec4 param_12 = _t0;
        vec4 param_13 = vec4(_200.xyz * _t7.w, _t7.w);
        _t0 = _f0(param_12, param_13);
    }
    if (u_frag_num >= 8)
    {
        mediump vec4 _225 = texture2D(u_fragmentTexture_8, v_uv);
        vec4 _t8 = _225;
        vec4 param_14 = _t0;
        vec4 param_15 = vec4(_225.xyz * _t8.w, _t8.w);
        _t0 = _f0(param_14, param_15);
    }
    if (u_frag_num >= 9)
    {
        mediump vec4 _250 = texture2D(u_fragmentTexture_9, v_uv);
        vec4 _t9 = _250;
        vec4 param_16 = _t0;
        vec4 param_17 = vec4(_250.xyz * _t9.w, _t9.w);
        _t0 = _f0(param_16, param_17);
    }
    if (u_frag_num >= 10)
    {
        mediump vec4 _275 = texture2D(u_fragmentTexture_10, v_uv);
        vec4 _t10 = _275;
        vec4 param_18 = _t0;
        vec4 param_19 = vec4(_275.xyz * _t10.w, _t10.w);
        _t0 = _f0(param_18, param_19);
    }
    if (u_frag_num >= 11)
    {
        mediump vec4 _300 = texture2D(u_fragmentTexture_11, v_uv);
        vec4 _t11 = _300;
        vec4 param_20 = _t0;
        vec4 param_21 = vec4(_300.xyz * _t11.w, _t11.w);
        _t0 = _f0(param_20, param_21);
    }
    if (u_frag_num >= 12)
    {
        mediump vec4 _325 = texture2D(u_fragmentTexture_12, v_uv);
        vec4 _t12 = _325;
        vec4 param_22 = _t0;
        vec4 param_23 = vec4(_325.xyz * _t12.w, _t12.w);
        _t0 = _f0(param_22, param_23);
    }
    if (u_frag_num >= 13)
    {
        mediump vec4 _350 = texture2D(u_fragmentTexture_13, v_uv);
        vec4 _t13 = _350;
        vec4 param_24 = _t0;
        vec4 param_25 = vec4(_350.xyz * _t13.w, _t13.w);
        _t0 = _f0(param_24, param_25);
    }
    if (u_frag_num >= 14)
    {
        mediump vec4 _375 = texture2D(u_fragmentTexture_14, v_uv);
        vec4 _t14 = _375;
        vec4 param_26 = _t0;
        vec4 param_27 = vec4(_375.xyz * _t14.w, _t14.w);
        _t0 = _f0(param_26, param_27);
    }
    if (u_frag_num >= 15)
    {
        mediump vec4 _400 = texture2D(u_fragmentTexture_15, v_uv);
        vec4 _t15 = _400;
        vec4 param_28 = _t0;
        vec4 param_29 = vec4(_400.xyz * _t15.w, _t15.w);
        _t0 = _f0(param_28, param_29);
    }
    gl_FragData[0] = _t0;
}

