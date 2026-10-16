precision highp float;
precision highp int;

uniform float u_gamma;
uniform float u_blurAmount;
uniform float u_sigmaY;
uniform float u_sampleY;
uniform float u_stepY;
uniform mediump sampler2D u_inputTexture;
uniform vec4 u_ScreenParams;
uniform float u_lineOffsetX;
uniform float u_lineOffsetY;
uniform float u_reflectionAngle;
uniform float u_maskFalloff;
uniform mediump sampler2D u_inputTexture2;
uniform mediump int u_blendStyle;

varying vec2 v_uv;

vec2 _f4(vec2 _p0, vec2 _p1, float _p2)
{
    vec2 _t19 = _p0 - _p1;
    float _306 = u_ScreenParams.x / u_ScreenParams.y;
    bool _308 = _306 < 1.0;
    vec2 _309;
    if (_308)
    {
        _309 = vec2(_306, 1.0);
    }
    else
    {
        _309 = vec2(1.0, 1.0 / _306);
    }
    _t19 = mat2(vec2(cos(_p2), sin(_p2)), vec2(-sin(_p2), cos(_p2))) * (_t19 * _309);
    vec2 _341;
    if (_308)
    {
        _341 = vec2(_306, 1.0);
    }
    else
    {
        _341 = vec2(1.0, 1.0 / _306);
    }
    vec2 _351 = _t19;
    vec2 _352 = _351 / _341;
    _t19 = _352;
    return _352 + _p1;
}

vec4 _f2(mediump sampler2D _p0, vec2 _p1)
{
    mediump vec4 _123 = texture2D(_p0, _p1);
    vec4 _t5 = _123;
    return vec4(pow(_123.xyz, vec3(u_gamma)), _t5.w);
}

float _f1(float _p0, float _p1)
{
    float _111 = _p0 / _p1;
    return exp(((-0.5) * _111) * _111);
}

vec4 _f3(mediump sampler2D _p0, vec2 _p1, float _p2)
{
    if (u_blurAmount < 0.001000000047497451305389404296875)
    {
        return texture2D(_p0, _p1);
    }
    vec2 param = _p1;
    vec4 _t6 = _f2(_p0, param);
    float param_1 = 0.0;
    float param_2 = u_sigmaY * _p2;
    float _t7 = _f1(param_1, param_2);
    float _170 = min(u_sampleY * _p2, 72.0);
    float _175 = u_stepY * _p2;
    float _179 = u_sigmaY * _p2;
    float _203;
    vec4 _223;
    vec4 _247;
    for (float _t11 = 1.0; _t11 <= _170; _t11 += 1.0)
    {
        if (_t11 >= _170)
        {
            break;
        }
        float _198 = _t11 * _175;
        if (_t11 < 7.19999980926513671875)
        {
            _203 = 1.0;
        }
        else
        {
            float param_3 = _198;
            float param_4 = _179;
            _203 = _f1(param_3, param_4);
        }
        vec2 _216 = vec2(0.0, _198);
        vec2 _217 = _p1 - _216;
        vec2 _t14 = _217;
        if (_t14.y < 0.0)
        {
            vec2 param_5 = vec2(_t14.x, 0.0);
            _223 = _f2(u_inputTexture, param_5);
        }
        else
        {
            vec2 param_6 = _217;
            _223 = _f2(_p0, param_6);
        }
        vec2 _242 = _p1 + _216;
        vec2 _t16 = _242;
        if (_t16.y > 1.0)
        {
            vec2 param_7 = vec2(_t16.x, 1.0);
            _247 = _f2(u_inputTexture, param_7);
        }
        else
        {
            vec2 param_8 = _242;
            _247 = _f2(_p0, param_8);
        }
        _t6 += ((_223 + _247) * _203);
        _t7 += (2.0 * _203);
    }
    vec4 _278 = _t6 / vec4(_t7);
    vec4 _t18 = _278;
    vec3 _284 = pow(_278.xyz, vec3(1.0 / u_gamma));
    _t18.x = _284.x;
    _t18.y = _284.y;
    _t18.z = _284.z;
    return _t18;
}

vec4 _f0(vec4 _p0, vec4 _p1)
{
    vec3 _54 = _p0.xyz / vec3(max(_p0.w, 0.001000000047497451305389404296875));
    return vec4(((((_p1.xyz / vec3(max(_p1.w, 0.001000000047497451305389404296875))) * _p1.w) * (1.0 - _p0.w)) + ((_54 * _p0.w) * (1.0 - _p1.w))) + ((_54 * _p0.w) * _p1.w), _p0.w + (_p1.w * (1.0 - _p0.w)));
}

void main()
{
    float _375 = 1.0 / max(max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x) * 2.2000000476837158203125, 0.001000000047497451305389404296875);
    vec2 _401 = (((vec2(v_uv.x, 1.0 - v_uv.y) - vec2(0.5)) * _375) + vec2(0.5)) - (vec2(u_lineOffsetX, u_lineOffsetY) * _375);
    vec2 _t24 = _401;
    vec2 param = _401;
    vec2 param_1 = vec2(0.5);
    float param_2 = u_reflectionAngle;
    _t24 = _f4(param, param_1, param_2);
    float _414 = 1.0 - step(0.5, _t24.y);
    vec2 param_3 = v_uv;
    float param_4 = 1.0 - smoothstep(0.00999999977648258209228515625, u_maskFalloff + 0.100000001490116119384765625, v_uv.y);
    vec4 _433 = clamp(_f3(u_inputTexture, param_3, param_4), vec4(0.0), vec4(1.0));
    mediump vec4 _438 = texture2D(u_inputTexture2, v_uv);
    vec4 _t29;
    if (u_blendStyle == 0)
    {
        _t29 = mix(_433, _438, vec4(_414));
    }
    else
    {
        if (u_blendStyle == 1)
        {
            vec4 param_5 = _438;
            vec4 param_6 = _433 * (1.0 - _414);
            _t29 = _f0(param_5, param_6);
        }
        else
        {
            _t29 = _433 * clamp(1.0 - _414, 0.0, 1.0);
        }
    }
    gl_FragData[0] = _t29;
}

