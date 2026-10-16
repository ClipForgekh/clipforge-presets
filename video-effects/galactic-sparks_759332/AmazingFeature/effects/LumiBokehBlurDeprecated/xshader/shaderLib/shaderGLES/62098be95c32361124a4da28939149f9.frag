precision highp float;
precision highp int;

uniform vec2 u_posVec[10];
uniform mediump int u_lineNum;
uniform float u_intensity;
uniform float u_quality;
uniform float u_regionIns;
uniform float u_lightIns;
uniform float u_baseTexWidth;
uniform float u_baseTexHeight;
uniform mediump sampler2D u_inputTex;
uniform float u_blurSize;

varying vec2 v_uv;

float _f0(vec2 _p0, vec2 _p1, vec2 _p2)
{
    return step(cross(vec3(_p0 - _p1, 0.0), vec3(_p2 - _p1, 0.0)).z, 0.0);
}

float _f1(vec2 _p0)
{
    vec2 param = _p0;
    vec2 param_1 = u_posVec[u_lineNum];
    vec2 param_2 = u_posVec[0];
    float _t3 = _f0(param, param_1, param_2);
    for (mediump int _t4 = 0; _t4 < u_lineNum; _t4++)
    {
        vec2 param_3 = _p0;
        vec2 param_4 = u_posVec[_t4];
        vec2 param_5 = u_posVec[_t4 + 1];
        _t3 *= _f0(param_3, param_4, param_5);
    }
    return _t3;
}

vec4 _f2(mediump sampler2D _p0, vec2 _p1, float _p2, vec2 _p3)
{
    if (u_intensity < 0.00999999977648258209228515625)
    {
        return texture2D(_p0, _p1);
    }
    vec4 _t7 = vec4(0.0);
    vec4 _t9 = vec4(0.0);
    vec4 _t10 = vec4(0.4000000059604644775390625);
    vec2 _149 = (vec2(2.0) * vec2(_p2)) / _p3;
    float _158 = mix(2.0, 0.5, u_intensity) * mix(2.0, 1.0, u_quality);
    float _169 = max(5.0, (12.0 / _158) * mix(0.64999997615814208984375, 1.0, u_quality));
    float _174 = mix(0.699999988079071044921875, 1.0, u_regionIns);
    for (float _t15 = 0.0; _t15 < 30.0; _t15 += 1.0)
    {
        if ((_t15 > _169) || (u_intensity < 0.300000011920928955078125))
        {
            break;
        }
        for (float _t16 = 0.0; _t16 < 30.0; _t16 += 1.0)
        {
            if (_t16 > _169)
            {
                break;
            }
            vec2 _219 = vec2(mix(-11.0, 11.0, _t15 / _169), mix(-11.0, 11.0, _t16 / _169));
            vec2 param = _219;
            if (_f1(param) < 0.5)
            {
                continue;
            }
            mediump vec4 _235 = texture2D(_p0, _p1 - ((_219 * 0.5) * _149));
            _t7 = max(_t7, _235 * _174);
            vec4 _249 = ((pow(_235, vec4(9.0)) * 539.45001220703125) + vec4(0.4000000059604644775390625)) * u_regionIns;
            _t9 += (_249 * _235);
            _t10 += _249;
        }
    }
    for (mediump int _t19 = 0; _t19 < u_lineNum; _t19++)
    {
        float _290 = max((length(u_posVec[_t19] - u_posVec[_t19 + 1]) / 1.5) * mix(0.5, 1.0, clamp(u_quality * 1.5, 0.0, 1.0)), 3.0);
        for (float _t21 = 0.0; _t21 < 40.0; _t21 += 1.0)
        {
            float _303 = _t21 * _158;
            if (_303 > _290)
            {
                break;
            }
            mediump vec4 _331 = texture2D(_p0, _p1 - ((mix(u_posVec[_t19], u_posVec[_t19 + 1], vec2(_303 / _290)) * 0.5) * _149));
            _t7 = max(_t7, _331);
            vec4 _340 = (pow(_331, vec4(9.0)) * 539.45001220703125) + vec4(0.4000000059604644775390625);
            _t9 += (_340 * _331);
            _t10 += _340;
        }
    }
    vec4 _359 = clamp(_t9 / _t10, vec4(0.0), vec4(1.0));
    return vec4(mix(_359, _t7, clamp(_359 * u_lightIns, vec4(0.0), vec4(1.0))));
}

void main()
{
    vec2 param = v_uv;
    float param_1 = u_blurSize;
    vec2 param_2 = (vec2(u_baseTexWidth, u_baseTexHeight) / vec2(min(u_baseTexWidth, u_baseTexHeight))) * 720.0;
    gl_FragData[0] = _f2(u_inputTex, param, param_1, param_2);
}

