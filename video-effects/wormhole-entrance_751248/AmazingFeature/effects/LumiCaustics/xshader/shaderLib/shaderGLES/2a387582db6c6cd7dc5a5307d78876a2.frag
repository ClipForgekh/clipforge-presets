precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D u_heightTexture;
uniform float u_height;
uniform mediump int u_lightMode;
uniform vec3 u_lightDirOrPos;
uniform float u_height0;
uniform float u_refract;
uniform mediump int u_bottomEdgeMode;
uniform mediump sampler2D u_bottomTexture;
uniform vec2 u_bottomSize;
uniform mediump sampler2D u_normalTexture;
uniform float u_causticsIntensity;
uniform vec3 u_waterColor;
uniform float u_waterOpacity;
uniform float u_skyIntensity;
uniform float u_skyReflect;
uniform mediump int u_skyEdgeMode;
uniform mediump sampler2D u_skyTexture;
uniform vec2 u_skySize;
uniform vec3 u_lightColor;
uniform mediump int u_lightDiffuse;
uniform float u_lightIntensity;
uniform float u_diffuse;
uniform float u_specular;
uniform float u_specularExp;

varying vec2 v_xy;

vec2 _f0()
{
    return u_ScreenParams.xy;
}

vec2 _f1(vec2 _p0)
{
    return (_p0 / _f0()) + vec2(0.5);
}

float _f2(vec4 _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

float _f3(vec2 _p0)
{
    vec2 param = _p0;
    vec4 param_1 = texture2D(u_heightTexture, _f1(param));
    return _f2(param_1) * u_height;
}

vec3 _f4(vec2 _p0)
{
    vec2 param = _p0 + vec2(5.0, 0.0);
    vec2 param_1 = _p0 - vec2(5.0, 0.0);
    vec2 param_2 = _p0 + vec2(0.0, 5.0);
    vec2 param_3 = _p0 - vec2(0.0, 5.0);
    return normalize(cross(vec3(1.0, 0.0, _f3(param) - _f3(param_1)), vec3(0.0, 1.0, _f3(param_2) - _f3(param_3))));
}

vec2 _f11(vec2 _p0, vec2 _p1)
{
    return (((_p1 * u_ScreenParams.xy) - (u_ScreenParams.xy * 0.5)) / _p0) + vec2(0.5);
}

vec4 _f7(mediump sampler2D _p0, vec2 _p1)
{
    return texture2D(_p0, clamp(_p1, vec2(0.0), vec2(1.0)));
}

vec4 _f8(mediump sampler2D _p0, vec2 _p1)
{
    return texture2D(_p0, fract(_p1));
}

vec4 _f9(mediump sampler2D _p0, inout vec2 _p1)
{
    _p1 = abs(mod(_p1 + vec2(1.0), vec2(2.0)) - vec2(1.0));
    return texture2D(_p0, _p1);
}

vec4 _f6(mediump sampler2D _p0, inout vec2 _p1)
{
    vec2 _191 = _p1;
    _p1 = step(vec2(0.0), _p1) * step(_p1, vec2(1.0));
    return (texture2D(_p0, _191) * _p1.x) * _p1.y;
}

vec4 _f10(mediump int _p0, mediump sampler2D _p1, vec2 _p2)
{
    if (_p0 == 0)
    {
        vec2 param = _p2;
        return _f7(_p1, param);
    }
    else
    {
        if (_p0 == 1)
        {
            vec2 param_1 = _p2;
            return _f8(_p1, param_1);
        }
        else
        {
            if (_p0 == 2)
            {
                vec2 param_2 = _p2;
                vec4 _270 = _f9(_p1, param_2);
                return _270;
            }
            else
            {
                vec2 param_3 = _p2;
                vec4 _275 = _f6(_p1, param_3);
                return _275;
            }
        }
    }
}

vec4 _f5(vec4 _p0)
{
    if (_p0.w == 0.0)
    {
        return vec4(0.0);
    }
    return vec4(_p0.xyz / vec3(_p0.w), _p0.w);
}

vec3 _f12(vec3 _p0)
{
    if (u_lightMode == 1)
    {
        return normalize(u_lightDirOrPos - _p0);
    }
    else
    {
        return u_lightDirOrPos;
    }
}

void main()
{
    vec2 param = v_xy;
    float _323 = _f3(param) + u_height0;
    vec2 param_1 = v_xy;
    vec3 _327 = _f4(param_1);
    vec2 param_2 = v_xy + ((_327.xy * _323) * u_refract);
    vec2 _341 = _f1(param_2);
    vec2 param_3 = u_bottomSize;
    vec2 param_4 = _341;
    mediump int param_5 = u_bottomEdgeMode;
    vec2 param_6 = _f11(param_3, param_4);
    vec4 param_7 = _f10(param_5, u_bottomTexture, param_6);
    vec4 _357 = _f5(param_7);
    vec4 _t12 = _357;
    vec3 _t13 = _357.xyz;
    vec4 param_8 = texture2D(u_normalTexture, _341);
    _t13 = clamp(_t13 + vec3(((_f2(param_8) * 2.0) - 1.0) * u_causticsIntensity), vec3(0.0), vec3(1.0));
    float _382 = u_height + u_height0;
    if (_382 > 1.0)
    {
        _t13 = mix(_t13, u_waterColor, vec3(((_323 + u_height0) / _382) * u_waterOpacity));
    }
    vec3 _408 = normalize(reflect(vec3(0.0, 0.0, -1.0), _327));
    if (u_skyIntensity > 0.0)
    {
        vec2 param_9 = v_xy + ((_408.xy * u_height0) * u_skyReflect);
        vec2 param_10 = u_skySize;
        vec2 param_11 = _f1(param_9);
        mediump int param_12 = u_skyEdgeMode;
        vec2 param_13 = _f11(param_10, param_11);
        vec4 param_14 = _f10(param_12, u_skyTexture, param_13);
        vec4 _442 = _f5(param_14);
        vec4 _t19 = _442;
        _t13 = mix(_t13, _442.xyz, vec3(u_skyIntensity * _t19.w));
    }
    vec3 param_15 = vec3(v_xy, _323);
    vec3 _459 = _f12(param_15);
    vec3 _t21 = u_lightColor;
    if (u_lightDiffuse == 1)
    {
        _t13 *= ((u_lightIntensity * u_diffuse) * max(dot(_459, _327), 0.0));
    }
    vec3 _492 = _t21;
    vec3 _493 = _492 * ((u_lightIntensity * u_specular) * pow(max(dot(_459, _408), 0.0), u_specularExp));
    _t21 = _493;
    vec3 _494 = _t13;
    vec3 _499 = clamp(_494 + _493, vec3(0.0), vec3(1.0));
    _t13 = _499;
    gl_FragData[0] = vec4(_499, 1.0) * _t12.w;
}

