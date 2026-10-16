precision highp float;
precision highp int;

uniform float u_brightness;
uniform mediump int u_tonemapMode;
uniform float u_exposure;
uniform float u_rotation;
uniform float u_gammaValue;
uniform mediump sampler2D u_shimmerTex;
uniform mediump sampler2D u_verticalTex1;
uniform mediump sampler2D u_verticalTex2;
uniform mediump sampler2D u_horizontalTex1;
uniform mediump sampler2D u_horizontalTex2;
uniform mediump sampler2D u_diagonal_1Tex;
uniform mediump sampler2D u_diagonal_2Tex;
uniform mediump sampler2D u_diagonal_3Tex;
uniform mediump sampler2D u_diagonal_4Tex;
uniform float u_shimmerIntensity;

varying vec2 v_uv;

vec2 _f7(vec2 _p0, float _p1, float _p2)
{
    return mat2(vec2(_p2, -_p1), vec2(_p1, _p2)) * _p0;
}

vec2 _f8(vec2 _p0, float _p1, float _p2)
{
    vec2 param = _p0 - vec2(0.5);
    float param_1 = _p1;
    float param_2 = _p2;
    return _f7(param, param_1, param_2) + vec2(0.5);
}

vec4 _f6(vec4 _p0, vec3 _p1)
{
    return vec4(pow(_p0.xyz, _p1), _p0.w);
}

vec4 _f3(vec4 _p0, vec4 _p1)
{
    return vec4(_p0.xyz * _p1.xyz, _p0.w * _p1.w);
}

vec4 _f2(vec4 _p0, vec4 _p1)
{
    return vec4(vec3(1.0) - ((vec3(1.0) - _p0.xyz) * (vec3(1.0) - _p1.xyz)), (_p0.w + _p1.w) - (_p0.w * _p1.w));
}

vec3 _f0(inout vec3 _p0, float _p1)
{
    _p0 *= _p1;
    return clamp((_p0 * ((_p0 * 2.5099999904632568359375) + vec3(0.02999999932944774627685546875))) / ((_p0 * ((_p0 * 2.4300000667572021484375) + vec3(0.589999973773956298828125))) + vec3(0.14000000059604644775390625)), vec3(0.0), vec3(1.0));
}

vec3 _f1(vec3 _p0, mediump int _p1, float _p2)
{
    if (_p1 == 1)
    {
        vec3 param = _p0;
        float param_1 = _p2;
        vec3 _107 = _f0(param, param_1);
        return _107;
    }
    return _p0 * _p2;
}

vec4 _f4(vec4 _p0, vec4 _p1, vec4 _p2, vec4 _p3, vec4 _p4, vec4 _p5, vec4 _p6, vec4 _p7)
{
    vec4 param = _p0;
    vec4 param_1 = _p2;
    vec4 param_2 = _p1;
    vec4 param_3 = _p3;
    vec4 param_4 = _p4;
    vec4 param_5 = _p6;
    vec4 param_6 = _p5;
    vec4 param_7 = _p7;
    vec4 param_8 = _f2(param, param_1);
    vec4 param_9 = _f2(param_2, param_3);
    vec4 _195 = _f2(param_8, param_9);
    vec4 _t8 = _195;
    vec4 param_10 = _195;
    vec4 param_11 = _f2(param_4, param_5);
    vec4 _200 = _f2(param_10, param_11);
    _t8 = _200;
    vec4 param_12 = _200;
    vec4 param_13 = _f2(param_6, param_7);
    _t8 = _f2(param_12, param_13);
    if (u_brightness > 0.0)
    {
        vec4 _213 = _t8;
        vec3 _234 = _213.xyz * (1.0 + ((u_brightness * smoothstep(0.00999999977648258209228515625, 0.5, dot(_213.xyz, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)))) * 0.5));
        _t8.x = _234.x;
        _t8.y = _234.y;
        _t8.z = _234.z;
    }
    vec3 param_14 = _t8.xyz;
    mediump int param_15 = u_tonemapMode;
    float param_16 = u_exposure;
    vec3 _254 = _f1(param_14, param_15, param_16);
    _t8.x = _254.x;
    _t8.y = _254.y;
    _t8.z = _254.z;
    return _t8;
}

vec4 _f5(vec4 _p0, vec3 _p1)
{
    return vec4(pow(_p0.xyz, _p1), _p0.w);
}

void main()
{
    float _322 = radians(u_rotation);
    float _325 = sin(_322);
    float _328 = cos(_322);
    float _337 = _325 * 0.707106769084930419921875;
    float _339 = _328 * 0.707106769084930419921875;
    vec3 _362 = vec3(u_gammaValue);
    vec2 param = v_uv;
    float param_1 = _325;
    float param_2 = _328;
    vec2 param_3 = v_uv;
    float param_4 = _328;
    float param_5 = -_325;
    vec2 param_6 = v_uv;
    float param_7 = _337 + _339;
    float param_8 = _339 - _337;
    vec2 param_9 = v_uv;
    float param_10 = _337 - _339;
    float param_11 = _339 + _337;
    vec4 param_12 = texture2D(u_shimmerTex, _f8(param, param_1, param_2));
    vec3 param_13 = _362;
    vec4 _414 = _f6(param_12, param_13);
    vec4 param_14 = texture2D(u_shimmerTex, _f8(param_3, param_4, param_5));
    vec3 param_15 = _362;
    vec4 _422 = _f6(param_14, param_15);
    vec4 param_16 = texture2D(u_shimmerTex, _f8(param_6, param_7, param_8));
    vec3 param_17 = _362;
    vec4 _430 = _f6(param_16, param_17);
    vec4 param_18 = texture2D(u_shimmerTex, _f8(param_9, param_10, param_11));
    vec3 param_19 = _362;
    vec4 _438 = _f6(param_18, param_19);
    vec4 param_20 = texture2D(u_verticalTex1, v_uv);
    vec3 param_21 = _362;
    vec4 _t33 = _f6(param_20, param_21);
    vec4 param_22 = texture2D(u_verticalTex2, v_uv);
    vec3 param_23 = _362;
    vec4 _t34 = _f6(param_22, param_23);
    vec4 param_24 = texture2D(u_horizontalTex1, v_uv);
    vec3 param_25 = _362;
    vec4 _t35 = _f6(param_24, param_25);
    vec4 param_26 = texture2D(u_horizontalTex2, v_uv);
    vec3 param_27 = _362;
    vec4 _t36 = _f6(param_26, param_27);
    vec4 param_28 = texture2D(u_diagonal_1Tex, v_uv);
    vec3 param_29 = _362;
    vec4 _t37 = _f6(param_28, param_29);
    vec4 param_30 = texture2D(u_diagonal_2Tex, v_uv);
    vec3 param_31 = _362;
    vec4 _t38 = _f6(param_30, param_31);
    vec4 param_32 = texture2D(u_diagonal_3Tex, v_uv);
    vec3 param_33 = _362;
    vec4 _t39 = _f6(param_32, param_33);
    vec4 param_34 = texture2D(u_diagonal_4Tex, v_uv);
    vec3 param_35 = _362;
    vec4 _t40 = _f6(param_34, param_35);
    vec4 param_36 = _t33;
    vec4 param_37 = _414;
    vec4 param_38 = _t34;
    vec4 param_39 = _414;
    vec4 param_40 = _t35;
    vec4 param_41 = _422;
    vec4 param_42 = _t36;
    vec4 param_43 = _422;
    vec4 param_44 = _t37;
    vec4 param_45 = _438;
    vec4 param_46 = _t38;
    vec4 param_47 = _438;
    vec4 param_48 = _t39;
    vec4 param_49 = _430;
    vec4 param_50 = _t40;
    vec4 param_51 = _430;
    vec4 _559 = _t33;
    vec4 _563 = vec4(u_shimmerIntensity);
    vec4 _564 = mix(_559, _f3(param_36, param_37), _563);
    _t33 = _564;
    vec4 _565 = _t34;
    vec4 _569 = mix(_565, _f3(param_38, param_39), _563);
    _t34 = _569;
    vec4 _570 = _t35;
    vec4 _574 = mix(_570, _f3(param_40, param_41), _563);
    _t35 = _574;
    vec4 _575 = _t36;
    vec4 _579 = mix(_575, _f3(param_42, param_43), _563);
    _t36 = _579;
    vec4 _580 = _t37;
    vec4 _584 = mix(_580, _f3(param_44, param_45), _563);
    _t37 = _584;
    vec4 _585 = _t38;
    vec4 _589 = mix(_585, _f3(param_46, param_47), _563);
    _t38 = _589;
    vec4 _590 = _t39;
    vec4 _594 = mix(_590, _f3(param_48, param_49), _563);
    _t39 = _594;
    vec4 _595 = _t40;
    vec4 _599 = mix(_595, _f3(param_50, param_51), _563);
    _t40 = _599;
    vec4 param_52 = _564;
    vec4 param_53 = _569;
    vec4 param_54 = _574;
    vec4 param_55 = _579;
    vec4 param_56 = _584;
    vec4 param_57 = _589;
    vec4 param_58 = _594;
    vec4 param_59 = _599;
    vec4 _617 = _f4(param_52, param_53, param_54, param_55, param_56, param_57, param_58, param_59);
    vec4 _t49 = _617;
    vec3 _620 = _617.xyz;
    vec3 _633 = _620 * (1.0 + ((max(u_brightness, 0.0) * smoothstep(0.00999999977648258209228515625, 0.5, dot(_620, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)))) * 0.5));
    _t49.x = _633.x;
    _t49.y = _633.y;
    _t49.z = _633.z;
    vec3 param_60 = _t49.xyz;
    mediump int param_61 = u_tonemapMode;
    float param_62 = u_exposure;
    vec3 _647 = _f1(param_60, param_61, param_62);
    _t49.x = _647.x;
    _t49.y = _647.y;
    _t49.z = _647.z;
    vec4 param_63 = _t49;
    vec3 param_64 = vec3(1.0 / max(u_gammaValue, 0.001000000047497451305389404296875));
    gl_FragData[0] = _f5(param_63, param_64);
}

