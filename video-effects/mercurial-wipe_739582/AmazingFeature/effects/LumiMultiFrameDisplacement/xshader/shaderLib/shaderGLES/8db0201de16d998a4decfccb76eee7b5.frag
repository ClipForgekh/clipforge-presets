precision highp float;
precision highp int;

uniform mediump sampler2D maskTexture;
uniform float maskTexFlag;
uniform mediump sampler2D mergedTexture;
uniform mediump sampler2D inputImageTexture1;
uniform mediump sampler2D inputImageTexture2;
uniform mediump sampler2D inputImageTexture3;
uniform mediump sampler2D inputImageTexture4;
uniform mediump sampler2D inputImageTexture5;
uniform mediump sampler2D inputImageTexture6;
uniform mediump sampler2D inputImageTexture7;
uniform mediump sampler2D inputImageTexture8;
uniform mediump sampler2D inputImageTexture9;
uniform mediump sampler2D inputImageTexture10;
uniform mediump sampler2D inputImageTexture11;
uniform mediump sampler2D inputImageTexture12;
uniform mediump sampler2D inputImageTexture13;
uniform float frameNums;
uniform float softEdge;
uniform mediump sampler2D u_inputTex;
uniform float u_min;
uniform float u_max;
uniform float u_factor;

varying vec2 v_uv;

float _f0(float _p0, float _p1, float _p2)
{
    return step(_p0, _p2) * step(_p1, _p0);
}

void main()
{
    mediump vec4 _35 = texture2D(maskTexture, v_uv);
    mediump vec4 _63 = texture2D(mergedTexture, v_uv);
    mediump vec4 _68 = texture2D(inputImageTexture1, v_uv);
    mediump vec4 _73 = texture2D(inputImageTexture2, v_uv);
    mediump vec4 _78 = texture2D(inputImageTexture3, v_uv);
    mediump vec4 _83 = texture2D(inputImageTexture4, v_uv);
    mediump vec4 _88 = texture2D(inputImageTexture5, v_uv);
    mediump vec4 _93 = texture2D(inputImageTexture6, v_uv);
    mediump vec4 _98 = texture2D(inputImageTexture7, v_uv);
    mediump vec4 _103 = texture2D(inputImageTexture8, v_uv);
    mediump vec4 _108 = texture2D(inputImageTexture9, v_uv);
    mediump vec4 _113 = texture2D(inputImageTexture10, v_uv);
    mediump vec4 _118 = texture2D(inputImageTexture11, v_uv);
    mediump vec4 _123 = texture2D(inputImageTexture12, v_uv);
    mediump vec4 _128 = texture2D(inputImageTexture13, v_uv);
    float _133 = (1.0 - ((dot(_35.xyz, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)) * step(0.5, maskTexFlag)) + (step(maskTexFlag, 0.5) * 1.0))) * frameNums;
    float _137 = step(_133, 15.0);
    float _t17 = _137;
    float _141 = step(_133, 16.0);
    float _t18 = _141 * (1.0 - _137);
    float _149 = step(_133, 17.0);
    float _t19 = _149 * (1.0 - _141);
    float _157 = step(_133, 18.0);
    float _t20 = _157 * (1.0 - _149);
    float _165 = step(_133, 19.0);
    float _t21 = _165 * (1.0 - _157);
    float _173 = step(_133, 20.0);
    float _t22 = _173 * (1.0 - _165);
    float _181 = step(_133, 21.0);
    float _t23 = _181 * (1.0 - _173);
    float _189 = step(_133, 22.0);
    float _t24 = _189 * (1.0 - _181);
    float _197 = step(_133, 23.0);
    float _t25 = _197 * (1.0 - _189);
    float _205 = step(_133, 24.0);
    float _t26 = _205 * (1.0 - _197);
    float _213 = step(_133, 25.0);
    float _t27 = _213 * (1.0 - _205);
    float _221 = step(_133, 26.0);
    float _t28 = _221 * (1.0 - _213);
    float _229 = step(_133, 27.0);
    float _t29 = _229 * (1.0 - _221);
    float _t30 = step(_133, 28.0) * (1.0 - _229);
    if (softEdge > 0.5)
    {
        float param = _133;
        float param_1 = 15.0;
        float param_2 = 16.0;
        _t17 = (1.0 - step(15.0, _133)) + (_f0(param, param_1, param_2) * (1.0 - abs(_133 - 15.0)));
        float param_3 = _133;
        float param_4 = 15.0;
        float param_5 = 17.0;
        _t18 = _f0(param_3, param_4, param_5) * (1.0 - abs(_133 - 16.0));
        float param_6 = _133;
        float param_7 = 16.0;
        float param_8 = 18.0;
        _t19 = _f0(param_6, param_7, param_8) * (1.0 - abs(_133 - 17.0));
        float param_9 = _133;
        float param_10 = 17.0;
        float param_11 = 19.0;
        _t20 = _f0(param_9, param_10, param_11) * (1.0 - abs(_133 - 18.0));
        float param_12 = _133;
        float param_13 = 18.0;
        float param_14 = 20.0;
        _t21 = _f0(param_12, param_13, param_14) * (1.0 - abs(_133 - 19.0));
        float param_15 = _133;
        float param_16 = 19.0;
        float param_17 = 21.0;
        _t22 = _f0(param_15, param_16, param_17) * (1.0 - abs(_133 - 20.0));
        float param_18 = _133;
        float param_19 = 20.0;
        float param_20 = 22.0;
        _t23 = _f0(param_18, param_19, param_20) * (1.0 - abs(_133 - 21.0));
        float param_21 = _133;
        float param_22 = 21.0;
        float param_23 = 23.0;
        _t24 = _f0(param_21, param_22, param_23) * (1.0 - abs(_133 - 22.0));
        float param_24 = _133;
        float param_25 = 22.0;
        float param_26 = 24.0;
        _t25 = _f0(param_24, param_25, param_26) * (1.0 - abs(_133 - 23.0));
        float param_27 = _133;
        float param_28 = 23.0;
        float param_29 = 25.0;
        _t26 = _f0(param_27, param_28, param_29) * (1.0 - abs(_133 - 24.0));
        float param_30 = _133;
        float param_31 = 24.0;
        float param_32 = 26.0;
        _t27 = _f0(param_30, param_31, param_32) * (1.0 - abs(_133 - 25.0));
        float param_33 = _133;
        float param_34 = 25.0;
        float param_35 = 27.0;
        _t28 = _f0(param_33, param_34, param_35) * (1.0 - abs(_133 - 26.0));
        float param_36 = _133;
        float param_37 = 26.0;
        float param_38 = 28.0;
        _t29 = _f0(param_36, param_37, param_38) * (1.0 - abs(_133 - 27.0));
        float param_39 = _133;
        float param_40 = 27.0;
        float param_41 = 29.0;
        _t30 = _f0(param_39, param_40, param_41) * (1.0 - abs(_133 - 28.0));
        float param_42 = _133;
        float param_43 = 28.0;
        float param_44 = 30.0;
    }
    gl_FragData[0] = mix(texture2D(u_inputTex, v_uv), (((((((((((((_63 * _t17) + (_68 * _t18)) + (_73 * _t19)) + (_78 * _t20)) + (_83 * _t21)) + (_88 * _t22)) + (_93 * _t23)) + (_98 * _t24)) + (_103 * _t25)) + (_108 * _t26)) + (_113 * _t27)) + (_118 * _t28)) + (_123 * _t29)) + (_128 * _t30), vec4(smoothstep(u_min, u_max, u_factor)));
}

