precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D inputImageTexture;
uniform float lowQuality;
uniform mediump sampler2D lutImageTexture;
uniform float filterIntensity;

varying vec2 v_uv;

vec3 _f0(vec3 _p0)
{
    float _46 = ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
    return vec3(_46, (_p0.z - _46) * 0.564999997615814208984375, (_p0.x - _46) * 0.712999999523162841796875);
}

vec3 _f1(vec3 _p0)
{
    return vec3(_p0.x + (1.40299999713897705078125 * _p0.z), (_p0.x - (0.3440000116825103759765625 * _p0.y)) - (0.7139999866485595703125 * _p0.z), _p0.x + (1.769999980926513671875 * _p0.y));
}

vec4 _f2(mediump sampler2D _p0, vec4 _p1, float _p2)
{
    vec4 _t1 = _p1;
    float _98 = _t1.z * 63.0;
    float _103 = floor(_98);
    vec2 _t3;
    _t3.y = floor(_103 / 8.0);
    _t3.x = _103 - (_t3.y * 8.0);
    float _117 = ceil(_98);
    vec2 _t4;
    _t4.y = floor(_117 / 8.0);
    _t4.x = _117 - (_t4.y * 8.0);
    vec2 _t5;
    _t5.x = (((_t3.x * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * _t1.x);
    _t5.y = (((_t3.y * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * _t1.y);
    vec2 _t6;
    _t6.x = (((_t4.x * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * _t1.x);
    _t6.y = (((_t4.y * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * _t1.y);
    return mix(_p1, vec4(mix(texture2D(_p0, _t5), texture2D(_p0, _t6), vec4(fract(_98))).xyz, _t1.w), vec4(_p2));
}

void main()
{
    vec2 _t11 = vec2(1.0) / ((u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y))) * 720.0);
    mediump vec4 _229 = texture2D(inputImageTexture, v_uv);
    vec4 _t12 = _229;
    for (float _t14 = 1.0; _t14 <= 8.0; _t14 += 1.0)
    {
        _t12 += texture2D(inputImageTexture, v_uv - vec2(_t14 * _t11.x, 0.0));
    }
    vec4 _256 = _t12;
    vec4 _269 = clamp(_229 + ((_229 - (_256 / vec4(9.0))) * 0.60000002384185791015625), vec4(0.0), vec4(1.0));
    _t12 = _269;
    vec3 param = _269.xyz;
    vec3 _t16 = _f0(param);
    vec3 param_1 = texture2D(inputImageTexture, v_uv - vec2(8.0 * _t11.x, 0.0)).xyz;
    vec3 _289 = _t16;
    vec2 _294 = mix(_289.yz, _f0(param_1).yz, vec2(0.60000002384185791015625));
    _t16.y = _294.x;
    _t16.z = _294.y;
    vec3 param_2 = _t16;
    vec3 _301 = _f1(param_2);
    _t12.x = _301.x;
    _t12.y = _301.y;
    _t12.z = _301.z;
    vec4 _308 = _t12;
    float _311 = _t12.w;
    vec3 _314 = clamp(_308.xyz, vec3(0.0), vec3(_311));
    _t12.x = _314.x;
    _t12.y = _314.y;
    _t12.z = _314.z;
    vec4 _322 = _t12;
    vec4 _326 = mix(_229, _322, vec4(lowQuality));
    _t12 = _326;
    vec4 param_3 = _326;
    float param_4 = filterIntensity;
    gl_FragData[0] = _f2(lutImageTexture, param_3, param_4);
}

