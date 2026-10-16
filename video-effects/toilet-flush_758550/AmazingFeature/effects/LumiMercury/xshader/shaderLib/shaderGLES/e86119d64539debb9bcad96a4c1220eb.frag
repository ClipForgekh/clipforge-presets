precision highp float;
precision highp int;

uniform float u_lightHeight;
uniform vec4 u_ScreenParams;
uniform mediump sampler2D u_maskTex;
uniform float u_specular;
uniform mediump sampler2D u_inputTexture;
uniform float u_strength;
uniform vec2 u_lightPosition;
uniform float u_lightIntensity;
uniform float u_lightDirection;
uniform float u_metal;
uniform float u_roughness;
uniform float u_ambient;
uniform mediump int u_lightType;

varying vec2 v_uv;

float _f0(vec3 _p0)
{
    return (_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0);
}

vec2 _f1(vec2 _p0)
{
    return abs(mod(_p0 + vec2(1.0), vec2(2.0)) - vec2(1.0));
}

vec3 _f2(vec3 _p0, vec3 _p1, vec3 _p2, vec3 _p3, vec3 _p4, vec3 _p5, float _p6, float _p7, float _p8, float _p9, mediump int _p10)
{
    vec3 _t2 = normalize(_p2 - _p3);
    vec3 _t3 = normalize(_p4 - _p3);
    if (_p10 == 1)
    {
        _t2 = vec3(0.0, 0.0, 1.0);
        _t3 = vec3(cos((_p6 * 3.1415927410125732421875) / 180.0), sin((_p6 * 3.1415927410125732421875) / 180.0), u_lightHeight);
    }
    return (_p0 * _p9) + ((_p5 * mix(vec3(1.0), _p0, vec3(_p7))) * pow(max(dot(normalize(_p1), normalize(_t2 + _t3)), 0.0), 1.0 / _p8));
}

void main()
{
    mediump vec4 _157 = texture2D(u_maskTex, v_uv);
    vec4 _t10 = _157;
    vec3 param = _157.xyz;
    vec2 _167 = vec2(0.0, 2.0 / u_ScreenParams.y);
    vec3 param_1 = texture2D(u_maskTex, v_uv - _167).xyz;
    vec3 param_2 = texture2D(u_maskTex, v_uv + _167).xyz;
    vec2 _187 = vec2(2.0 / u_ScreenParams.x, 0.0);
    vec3 param_3 = texture2D(u_maskTex, v_uv - _187).xyz;
    vec3 param_4 = texture2D(u_maskTex, v_uv + _187).xyz;
    vec3 _221 = vec3((_f0(param_3) - _f0(param_4)) * 0.5, (_f0(param_1) - _f0(param_2)) * 0.5, _f0(param) * u_specular);
    vec2 param_5 = v_uv + (_221.xy * u_strength);
    vec4 _239 = texture2D(u_inputTexture, _f1(param_5)) * _t10.w;
    vec4 _t19 = _239;
    vec3 _246 = vec3(u_lightPosition, u_lightHeight);
    vec3 param_6 = _239.xyz;
    vec3 param_7 = _221;
    vec3 param_8 = _246;
    vec3 param_9 = vec3(v_uv, 0.0);
    vec3 param_10 = _246;
    vec3 param_11 = vec3(1.0) * u_lightIntensity;
    float param_12 = u_lightDirection;
    float param_13 = u_metal;
    float param_14 = u_roughness;
    float param_15 = u_ambient;
    mediump int param_16 = u_lightType;
    vec3 _284 = _f2(param_6, param_7, param_8, param_9, param_10, param_11, param_12, param_13, param_14, param_15, param_16);
    _t19.x = _284.x;
    _t19.y = _284.y;
    _t19.z = _284.z;
    gl_FragData[0] = _t19;
}

