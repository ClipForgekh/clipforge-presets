precision highp float;
precision highp int;

uniform float u_intensity;
uniform float u_scaleX;
uniform float u_scaleY;
uniform float u_quality;
uniform float u_regionIns;
uniform float u_lightIns;
uniform float u_baseTexWidth;
uniform float u_baseTexHeight;
uniform mediump sampler2D u_inputTex;
uniform float u_blurSize;

varying vec2 v_uv;

float _f1(vec2 _p0)
{
    return step(dot(_p0, _p0), 121.0);
}

mat2 _f0(float _p0)
{
    float _32 = sin(_p0);
    float _35 = cos(_p0);
    return mat2(vec2(_35, -_32), vec2(_32, _35));
}

vec4 _f2(mediump sampler2D _p0, vec2 _p1, float _p2, vec2 _p3)
{
    if (u_intensity < 0.00999999977648258209228515625)
    {
        return texture2D(_p0, _p1);
    }
    vec4 _t4 = vec4(0.0);
    vec4 _t6 = vec4(0.0);
    vec4 _t7 = vec4(0.4000000059604644775390625);
    vec2 _102 = ((vec2(2.0) * vec2(u_scaleX, u_scaleY)) * vec2(_p2)) / _p3;
    float _110 = mix(2.0, 0.5, u_intensity) * mix(2.0, 1.0, u_quality);
    float _121 = max(5.0, (12.0 / _110) * mix(0.60000002384185791015625, 1.0, u_quality));
    float _126 = mix(0.699999988079071044921875, 1.0, u_regionIns);
    for (float _t12 = 0.0; _t12 < 30.0; _t12 += 1.0)
    {
        if ((_t12 > _121) || (u_intensity < 0.300000011920928955078125))
        {
            break;
        }
        for (float _t13 = 0.0; _t13 < 30.0; _t13 += 1.0)
        {
            if (_t13 > _121)
            {
                break;
            }
            vec2 _171 = vec2(mix(-11.0, 11.0, _t12 / _121), mix(-11.0, 11.0, _t13 / _121));
            vec2 param = _171;
            if (_f1(param) < 0.5)
            {
                continue;
            }
            mediump vec4 _187 = texture2D(_p0, _p1 - ((_171 * 0.5) * _102));
            _t4 = max(_t4, _187 * _126);
            vec4 _201 = ((pow(_187, vec4(9.0)) * 539.45001220703125) + vec4(0.4000000059604644775390625)) * u_regionIns;
            _t6 += (_201 * _187);
            _t7 += _201;
        }
    }
    float _226 = max(15.0, (34.0 / _110) * mix(0.5, 1.0, clamp(u_quality * 1.5, 0.0, 1.0)));
    float param_1 = 6.280000209808349609375 / _226;
    mat2 _233 = _f0(param_1);
    vec2 _t18 = vec2(11.0, 0.0);
    for (float _t19 = 0.0; _t19 < 70.0; _t19 += 1.0)
    {
        if (_t19 > _226)
        {
            break;
        }
        vec2 _252 = _t18;
        vec2 _253 = _252 * _233;
        _t18 = _253;
        mediump vec4 _262 = texture2D(_p0, _p1 - ((_253 * 0.5) * _102));
        _t4 = max(_t4, _262);
        vec4 _271 = (pow(_262, vec4(9.0)) * 539.45001220703125) + vec4(0.4000000059604644775390625);
        _t6 += (_271 * _262);
        _t7 += _271;
    }
    vec4 _288 = clamp(_t6 / _t7, vec4(0.0), vec4(1.0));
    return vec4(mix(_288, _t4, clamp(_288 * u_lightIns, vec4(0.0), vec4(1.0))));
}

void main()
{
    vec2 param = v_uv;
    float param_1 = u_blurSize;
    vec2 param_2 = (vec2(u_baseTexWidth, u_baseTexHeight) / vec2(min(u_baseTexWidth, u_baseTexHeight))) * 720.0;
    gl_FragData[0] = _f2(u_inputTex, param, param_1, param_2);
}

