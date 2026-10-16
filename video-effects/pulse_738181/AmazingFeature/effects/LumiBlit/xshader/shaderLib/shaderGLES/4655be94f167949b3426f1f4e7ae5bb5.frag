precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform vec2 u_center;
uniform float u_scaleEnd;
uniform float u_scaleStart;
uniform float u_angleEnd;
uniform float u_angleStart;
uniform float u_smoothness;
uniform vec2 u_offsetStart;
uniform vec2 u_offsetEnd;
uniform float u_globalTransform;
uniform vec3 u_colorStart;
uniform vec3 u_colorMid;
uniform vec3 u_colorEnd;
uniform float u_weight;
uniform float u_fallOff;
uniform mediump sampler2D u_inputTexture;

varying vec2 v_uv;

mat2 _f0(float _p0)
{
    float _43 = sin(_p0);
    float _46 = cos(_p0);
    return mat2(vec2(_46, -_43), vec2(_43, _46));
}

vec2 _f1(vec2 _p0, vec2 _p1, float _p2)
{
    vec2 _t2 = _p0 - _p1;
    float _74 = u_ScreenParams.x / u_ScreenParams.y;
    _t2.x *= _74;
    float param = _p2;
    _t2 *= _f0(param);
    _t2.x /= _74;
    return _t2 + _p1;
}

vec2 _f2(vec2 _p0, vec2 _p1, mat2 _p2)
{
    vec2 _t3 = _p0 - _p1;
    float _106 = u_ScreenParams.x / u_ScreenParams.y;
    _t3.x *= _106;
    _t3 *= _p2;
    _t3.x /= _106;
    return _t3 + _p1;
}

vec3 _f4(vec3 _p0, vec3 _p1, vec3 _p2, float _p3)
{
    if (_p3 < 0.3333333432674407958984375)
    {
        float _149 = _p3 / 0.3333333432674407958984375;
        return (_p0 * clamp(3.0 - _149, 0.0, 1.0)) + (_p1 * clamp(3.0 * _149, 0.0, 1.0));
    }
    else
    {
        float _169 = (_p3 - 0.666666686534881591796875) / 0.3333333432674407958984375;
        return (_p1 * clamp(3.0 - _169, 0.0, 1.0)) + (_p2 * clamp(3.0 * _169, 0.0, 1.0));
    }
}

vec2 _f3(vec2 _p0)
{
    return abs(mod(_p0 + vec2(1.0), vec2(2.0)) - vec2(1.0));
}

void main()
{
    vec4 _t8 = vec4(0.0);
    vec4 _t9 = vec4(0.0);
    vec2 _198 = vec2(u_center);
    float _t12 = max(80.0 * abs(u_scaleEnd - u_scaleStart), mix(0.0, 79.0, abs(u_angleEnd - u_angleStart) / 0.5));
    float _232 = u_smoothness * u_smoothness;
    if (_232 > 0.300000011920928955078125)
    {
        _t12 = max((_t12 * sqrt(length(v_uv - _198))) * 4.0, 6.0);
    }
    float _260 = _t12;
    float _268 = floor(mix(2.0, max(length((u_offsetStart - u_offsetEnd) * (u_ScreenParams.xy / vec2(min(u_ScreenParams.y, u_ScreenParams.x)))) * 450.0, _260), clamp(_232, 0.0, 1.0)));
    _t12 = _268;
    float _276 = u_angleStart * u_globalTransform;
    float param = ((u_angleEnd * u_globalTransform) - _276) / _268;
    mat2 _281 = _f0(param);
    vec2 param_1 = v_uv;
    vec2 param_2 = _198;
    float param_3 = _276;
    vec2 _t14 = _f1(param_1, param_2, param_3);
    vec2 _297 = (u_offsetStart - vec2(0.5)) * u_globalTransform;
    vec2 _302 = (u_offsetEnd - vec2(0.5)) * u_globalTransform;
    for (mediump int _t17 = 0; _t17 <= 1024; _t17++)
    {
        mediump float _317 = float(_t17);
        if (_317 > _t12)
        {
            break;
        }
        float _327 = _317 / _t12;
        vec2 _329 = _t14;
        vec2 _331 = _329 - _198;
        vec2 _354 = vec2(_327);
        vec2 param_4 = _329;
        vec2 param_5 = _198;
        mat2 param_6 = _281;
        _t14 = _f2(param_4, param_5, param_6);
        vec3 param_7 = u_colorStart;
        vec3 param_8 = u_colorMid;
        vec3 param_9 = u_colorEnd;
        float param_10 = _327;
        vec2 param_11 = mix((_331 / vec2(mix(1.0, u_scaleStart, u_globalTransform))) + _198, (_331 / vec2(mix(1.0, u_scaleEnd, u_globalTransform))) + _198, _354) - mix(_297, _302, _354);
        vec4 _413 = vec4(mix(vec3(1.0), _f4(param_7, param_8, param_9, param_10), vec3(clamp(u_weight, 0.0, 1.0))), 1.0);
        _t8 += ((texture2D(u_inputTexture, _f3(param_11)) * _413) * vec4(vec3(mix(1.0 - u_fallOff, 1.0 + u_fallOff, _327)), 1.0));
        _t9 += _413;
    }
    vec4 _434 = _t8;
    vec4 _435 = _434 / _t9;
    _t8 = _435;
    gl_FragData[0] = vec4(_435);
}

