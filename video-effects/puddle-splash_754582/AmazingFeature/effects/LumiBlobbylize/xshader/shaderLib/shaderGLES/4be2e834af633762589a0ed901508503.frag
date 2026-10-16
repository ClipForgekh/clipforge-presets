precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform float u_cutAway;
uniform float u_height;
uniform mediump int u_lightMode;
uniform vec3 u_lightDirOrPos;
uniform vec3 u_lightColor;
uniform float u_lightIntensity;
uniform float u_ambient;
uniform float u_diffuse;
uniform float u_metallic;
uniform float u_specular;
uniform float u_roughness;
uniform mediump sampler2D u_heightTexture;
uniform float u_displacement;
uniform mediump sampler2D u_inputTexture;
uniform float u_cutAwayFade;

varying vec2 v_xy;

vec2 _f0(vec2 _p0)
{
    return (_p0 / u_ScreenParams.xy) + vec2(0.5);
}

float _f1(vec4 _p0)
{
    return _p0.w * 6.0308629201699659461155533790588e-08 + (_p0.z * 1.5378700481960549950599670410156e-05 + (_p0.y * 0.0039215688593685626983642578125 + _p0.x));
}

float _f5(mediump sampler2D _p0, vec2 _p1)
{
    vec2 param = _p1;
    vec4 param_1 = texture2D(_p0, _f0(param));
    return _f1(param_1);
}

float _f4(float _p0, float _p1, float _p2)
{
    return clamp((_p2 - _p0) / (_p1 - _p0), 0.0, 1.0);
}

float _f6(mediump sampler2D _p0, vec2 _p1)
{
    vec2 param = _p1;
    float param_1 = u_cutAway;
    float param_2 = 1.00100004673004150390625;
    float param_3 = _f5(_p0, param);
    return _f4(param_1, param_2, param_3) * u_height;
}

vec3 _f7(mediump sampler2D _p0, vec2 _p1)
{
    vec2 param = _p1 + vec2(0.5, 0.0);
    vec2 param_1 = _p1 - vec2(0.5, 0.0);
    vec2 param_2 = _p1 + vec2(0.0, 0.5);
    vec2 param_3 = _p1 - vec2(0.0, 0.5);
    return normalize(cross(vec3(1.0, 0.0, _f6(_p0, param) - _f6(_p0, param_1)), vec3(0.0, 1.0, _f6(_p0, param_2) - _f6(_p0, param_3))));
}

vec4 _f2(mediump sampler2D _p0, inout vec2 _p1)
{
    _p1 = abs(mod(_p1 + vec2(1.0), vec2(2.0)) - vec2(1.0));
    return texture2D(_p0, _p1);
}

vec4 _f3(vec4 _p0)
{
    if (_p0.w == 0.0)
    {
        return vec4(0.0);
    }
    return vec4(_p0.xyz / vec3(_p0.w), _p0.w);
}

vec3 _f8(vec2 _p0)
{
    if (u_lightMode == 1)
    {
        return normalize(u_lightDirOrPos - vec3(_p0, 0.0));
    }
    else
    {
        return u_lightDirOrPos;
    }
}

vec3 _f9(vec3 _p0, vec3 _p1, vec3 _p2)
{
    vec3 _241 = u_lightColor * u_lightIntensity;
    return ((_p2 * u_ambient) + (((_p2 * _241) * u_diffuse) * max(dot(_p0, _p1), 0.0))) + (((mix(vec3(1.0), _p2, vec3(u_metallic)) * _241) * u_specular) * pow(max(reflect(-_p0, _p1).z, 0.0), u_roughness));
}

void main()
{
    vec2 param = v_xy;
    vec3 _301 = _f7(u_heightTexture, param);
    vec2 param_1 = v_xy;
    float _308 = _f5(u_heightTexture, param_1);
    float param_2 = u_cutAway;
    float param_3 = 1.00100004673004150390625;
    float param_4 = _308;
    vec2 param_5 = v_xy + (_301.xy * u_displacement);
    vec2 param_6 = _f0(param_5);
    vec4 _331 = _f2(u_inputTexture, param_6);
    vec4 param_7 = _331;
    vec4 _333 = _f3(param_7);
    vec4 _t17 = _333;
    vec2 param_8 = v_xy;
    vec3 param_9 = _f8(param_8);
    vec3 param_10 = _301;
    vec3 param_11 = _333.xyz;
    gl_FragData[0] = vec4(_f9(param_9, param_10, param_11), 1.0) * (_t17.w * smoothstep(mix(-u_cutAwayFade, 1.0, u_cutAway) - 9.9999997473787516355514526367188e-05, mix(0.0, 1.0 + u_cutAwayFade, u_cutAway), _308));
}

