precision highp float;
precision highp int;

struct SurfaceParams
{
    vec3 albedo;
    float opacity;
    float emission;
    vec3 nDirWS;
    vec2 metalParams;
    vec3 roughParams;
    vec3 clearCoatRoughParams;
    vec2 occParams;
    vec3 diffCol;
    vec3 specCol;
    vec2 anisoParams;
    float thickness;
};

struct WorldSpaceVectors
{
    vec3 pos;
    vec3 nDir;
    vec3 vnDir;
    vec3 tDir;
    vec3 bDir;
    vec3 vDir;
    vec3 rDir;
};

struct LightParams
{
    vec3 lDir;
    vec3 color;
    float intensity;
    float attenuate;
};

uniform vec3 u_WorldSpaceCameraPos;
uniform vec3 u_envRotAxis;
uniform float u_envRot;
uniform mediump sampler2D u_envTex;
uniform vec4 u_ScreenParams;
uniform mediump int u_edgeType;
uniform float u_rotate;
uniform vec2 u_offset;
uniform vec2 u_scale;
uniform mediump sampler2D u_input;
uniform vec2 u_padding;
uniform vec4 u_mainColor;
uniform mediump int u_enableNormTex;
uniform mediump sampler2D u_normTex;
uniform float u_normInt;
uniform float u_metallic;
uniform float u_roughness;
uniform float u_anisoAngle;
uniform float u_anisoStrength;
uniform float u_envInt;
uniform float u_envEnabled;
uniform vec3 u_dirLightDirection;
uniform vec3 u_dirLightColor;
uniform float u_dirLightIntensity;
uniform float u_dirLightEnabled;
uniform float u_pointLightEnabled;
uniform vec3 u_pointLightPosition;
uniform vec3 u_pointLightColor;
uniform float u_pointLightIntensity;
uniform float u_pointLightAttenRangeInv;
uniform float u_spotLightEnabled;
uniform vec3 u_spotLightPosition;
uniform vec3 u_spotLightColor;
uniform float u_spotLightIntensity;
uniform float u_spotLightAttenRangeInv;
uniform float u_shadowContrast;
uniform vec3 u_shadowColor;
uniform mediump int u_enableToneMapping;
uniform float u_lightingBlend;
uniform float u_shadowIntensity;

varying vec3 v_posWS;
varying vec3 v_nDirWS;
varying vec3 v_tDirWS;
varying vec3 v_bDirWS;
varying vec2 v_uv0;
varying vec4 v_vertexColor;

vec2 _f25(inout vec2 _p0, float _p1, vec2 _p2, vec2 _p3)
{
    _p0 -= _p2;
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _1213 = sin(_p1);
    float _1216 = cos(_p1);
    _p0 = mat2(vec2(_1216, _1213), vec2(-_1213, _1216)) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 /= _p3;
    _p0 += _p2;
    return _p0;
}

vec2 _f23(vec2 _p0)
{
    vec2 _1172 = mod(_p0, vec2(1.0));
    return _1172 + (vec2(1.0) - step(vec2(0.0), _1172));
}

vec2 _f22(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f24(vec2 _p0)
{
    vec2 _t70 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t70.x * _t70.y;
}

vec4 _f26(mediump sampler2D _p0, vec2 _p1, vec2 _p2)
{
    vec2 _t74 = _p1;
    bool _1253 = _p2.x < 0.0;
    bool _1260;
    if (!_1253)
    {
        _1260 = _p2.y < 0.0;
    }
    else
    {
        _1260 = _1253;
    }
    if (_1260)
    {
        if (u_edgeType == 0)
        {
            vec2 param = _p1;
            _t74 = _f23(param);
        }
        else
        {
            if (u_edgeType == 1)
            {
                vec2 param_1 = _p1;
                _t74 = _f22(param_1);
            }
            else
            {
                if (u_edgeType == 2)
                {
                    _t74 = clamp(_p1, vec2(0.0), vec2(1.0));
                }
                else
                {
                    vec2 param_2 = _p1;
                    if (_f24(param_2) < 1.0)
                    {
                        return vec4(0.0);
                    }
                    _t74 = _p1;
                }
            }
        }
        return texture2D(_p0, _t74);
    }
    bool _1309 = _p1.x < _p2.x;
    bool _1319;
    if (!_1309)
    {
        _1319 = _p1.x > (1.0 - _p2.x);
    }
    else
    {
        _1319 = _1309;
    }
    bool _1329;
    if (!_1319)
    {
        _1329 = _p1.y > (1.0 - _p2.y);
    }
    else
    {
        _1329 = _1319;
    }
    if (_1329)
    {
        if (u_edgeType == 0)
        {
            vec2 param_3 = _p1;
            _t74 = _f23(param_3);
        }
        else
        {
            if (u_edgeType == 1)
            {
                vec2 param_4 = _p1;
                _t74 = _f22(param_4);
            }
            else
            {
                if (u_edgeType == 2)
                {
                    _t74 = clamp(_p1, vec2(0.0), vec2(1.0));
                }
                else
                {
                    vec2 param_5 = _p1;
                    if (_f24(param_5) < 1.0)
                    {
                        return vec4(0.0);
                    }
                    _t74 = _p1;
                }
            }
        }
    }
    return texture2D(_p0, _t74);
}

vec3 _f3(vec3 _p0)
{
    return vec3(pow(_p0.x, 2.2000000476837158203125), pow(_p0.y, 2.2000000476837158203125), pow(_p0.z, 2.2000000476837158203125));
}

float _f0(float _p0)
{
    return _p0 * _p0;
}

float _f2(float _p0)
{
    return clamp(_p0, 0.0, 1.0);
}

float _f6(SurfaceParams _p0, WorldSpaceVectors _p1)
{
    float param = (pow(max(0.0, dot(_p1.nDir, _p1.vDir)) + _p0.occParams.x, exp2(((-16.0) * _p0.roughParams.x) - 1.0)) - 1.0) + _p0.occParams.x;
    float _267 = min(1.0 + dot(_p1.rDir, _p1.nDir), 1.0);
    return _f2(param) * (_267 * _267);
}

vec3 _f4(vec3 _p0)
{
    return vec3(pow(_p0.x, 0.4545449912548065185546875), pow(_p0.y, 0.4545449912548065185546875), pow(_p0.z, 0.4545449912548065185546875));
}

mat3 _f9(float _p0)
{
    float _313 = sin(_p0);
    float _316 = cos(_p0);
    return mat3(vec3(_316, -_313, 0.0), vec3(_313, _316, 0.0), vec3(0.0, 0.0, 1.0));
}

mat3 _f8(float _p0)
{
    float _296 = sin(_p0);
    float _299 = cos(_p0);
    return mat3(vec3(_299, 0.0, _296), vec3(0.0, 1.0, 0.0), vec3(-_296, 0.0, _299));
}

mat3 _f7(float _p0)
{
    float _279 = sin(_p0);
    float _282 = cos(_p0);
    return mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, _282, -_279), vec3(0.0, _279, _282));
}

vec2 _f10(vec3 _p0, float _p1)
{
    vec3 _336 = normalize(u_WorldSpaceCameraPos - v_posWS);
    vec3 _341 = normalize(cross(vec3(0.0, 1.0, 0.0), _336));
    float param = u_envRotAxis.z;
    float param_1 = u_envRotAxis.y;
    float param_2 = u_envRotAxis.x;
    vec3 _t22 = normalize((mat3(vec3(_341), vec3(normalize(cross(_336, _341))), vec3(_336)) * ((_f9(param) * _f8(param_1)) * _f7(param_2))) * _p0);
    vec2 _t23;
    _t23.x = ((atan(_t22.z, _t22.x) * 0.31830990314483642578125) * 0.5) + 0.5;
    _t23.y = acos(_t22.y) * 0.31830990314483642578125;
    _t23.x = fract(_t23.x + _p1);
    return _t23;
}

vec3 _f11(mediump sampler2D _p0, vec2 _p1, float _p2)
{
    float _416 = floor(_p2);
    vec2 _t26 = _p1;
    vec2 _t27 = _p1;
    if (abs(_416 - 0.0) < 0.001000000047497451305389404296875)
    {
        _t26.x = ((((_p1.x * 511.0) / 512.0) + 0.0009765625) * 1.0) + 0.0;
        _t26.y = ((((_p1.y * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
    }
    else
    {
        if (abs(_416 - 1.0) < 0.001000000047497451305389404296875)
        {
            _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
            _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
            _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
            _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
        }
        else
        {
            if (abs(_416 - 2.0) < 0.001000000047497451305389404296875)
            {
                _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
                _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
            }
            else
            {
                if (abs(_416 - 3.0) < 0.001000000047497451305389404296875)
                {
                    _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                    _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                    _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                    _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                }
                else
                {
                    if (abs(_416 - 4.0) < 0.001000000047497451305389404296875)
                    {
                        _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                        _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                        _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                        _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                    }
                    else
                    {
                        if (abs(_416 - 5.0) < 0.001000000047497451305389404296875)
                        {
                            _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                            _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                            _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                            _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                        }
                        else
                        {
                            if (abs(_416 - 6.0) < 0.001000000047497451305389404296875)
                            {
                                _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                                _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                            }
                            else
                            {
                                if (abs(_416 - 7.0) < 0.001000000047497451305389404296875)
                                {
                                    _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                    _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                    _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                    _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    vec4 _772 = mix(texture2D(_p0, _t26), texture2D(_p0, _t27), vec4(_p2 - _416));
    vec4 _t29 = _772;
    return _772.xyz / vec3(_t29.w);
}

vec3 _f12(vec3 _p0, float _p1)
{
    vec3 param = _p0;
    float param_1 = u_envRot;
    vec2 param_2 = _f10(param, param_1);
    float param_3 = _p1;
    return _f11(u_envTex, param_2, param_3);
}

vec3 _f13(SurfaceParams _p0, WorldSpaceVectors _p1)
{
    vec4 _819 = (vec4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _p0.roughParams.x) + vec4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    vec4 _t33 = _819;
    vec2 _t35 = (vec2(-1.03999996185302734375, 1.03999996185302734375) * ((min(_t33.x * _t33.x, exp2((-9.27999973297119140625) * max(0.0, dot(_p1.nDir, _p1.vDir)))) * _t33.x) + _t33.y)) + _819.zw;
    float param = 50.0 * _p0.specCol.y;
    _t35.y *= _f2(param);
    return (_p0.specCol * _t35.x) + vec3(_t35.y);
}

vec3 _f14(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    float param = dot(_p1.nDir, _p2.lDir);
    float param_1 = dot(_p1.nDir, normalize(_p2.lDir + _p1.vDir));
    return (((_p0.diffCol * mix(pow(1.0 - _f2(param), 3.0) * 0.5, (1.0 - pow(1.0 - _f2(param_1), 5.0)) * 0.699999988079071044921875, 0.5)) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

float _f17(float _p0, float _p1, float _p2)
{
    return 0.5 / (((_p2 * ((_p1 * (1.0 - _p0)) + _p0)) + (_p1 * ((_p2 * (1.0 - _p0)) + _p0))) + 9.9999997473787516355514526367188e-06);
}

float _f16(float _p0, float _p1)
{
    float _946 = (((_p0 * _p1) - _p0) * _p0) + 1.0;
    return (_p1 * 0.31830990314483642578125) / ((_946 * _946) + 1.0000000116860974230803549289703e-07);
}

float _f1(float _p0)
{
    float _150 = _p0 * _p0;
    return (_150 * _150) * _p0;
}

vec3 _f15(vec3 _p0, float _p1)
{
    float param = 1.0 - _p1;
    return _p0 + ((vec3(1.0) - _p0) * _f1(param));
}

vec3 _f18(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    vec3 _989 = normalize(_p2.lDir + _p1.vDir);
    float _1008 = max(0.0, dot(_p1.nDir, _p2.lDir));
    float param = _1008;
    float param_1 = max(0.0, dot(_p1.nDir, _p1.vDir));
    float param_2 = _p0.roughParams.y;
    float param_3 = max(0.0, dot(_p1.nDir, _989));
    float param_4 = _p0.roughParams.z;
    vec3 param_5 = _p0.specCol;
    float param_6 = max(0.0, dot(_p1.vDir, _989));
    return ((((((_f15(param_5, param_6) * _f17(param, param_1, param_2)) * _f16(param_3, param_4)) * 3.1415927410125732421875) * _1008) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

vec3 _f21(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * max(0.0, dot(_p1.nDir, _p2.lDir));
}

float _f19()
{
    return 0.25;
}

vec3 _f20(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    vec3 _1073 = normalize(_p2.lDir + _p1.vDir);
    float param = max(0.0, dot(_p1.nDir, _1073));
    float param_1 = _p0.roughParams.z;
    vec3 param_2 = _p0.specCol;
    float param_3 = max(0.0, dot(_p1.vDir, _1073));
    return ((((((_f15(param_2, param_3) * _f19()) * _f16(param, param_1)) * 3.1415927410125732421875) * max(0.0, dot(_p1.nDir, _p2.lDir))) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

vec3 _f5(vec3 _p0)
{
    return (_p0 * ((_p0 * 1.7999999523162841796875) + vec3(1.39999997615814208984375))) / min(vec3(1000.0), (_p0 * ((_p0 * 1.7999999523162841796875) + vec3(0.5))) + vec3(1.5));
}

void main()
{
    vec2 param = v_uv0;
    float param_1 = u_rotate;
    vec2 param_2 = u_offset;
    vec2 param_3 = u_scale;
    vec2 _1405 = _f25(param, param_1, param_2, param_3);
    vec2 param_4 = _1405;
    vec2 param_5 = u_padding;
    vec4 _1415 = _f26(u_input, param_4, param_5);
    vec4 _t78 = _1415;
    vec3 param_6 = u_mainColor.xyz;
    vec3 _1982 = _f3(param_6);
    float _1983 = u_mainColor.w;
    vec3 _1428 = _1415.xyz;
    vec3 param_7 = _1428;
    _1982 *= _f3(param_7);
    _1983 *= _t78.w;
    vec3 _1985 = v_nDirWS;
    bool _1446 = u_enableNormTex > 0;
    if (_1446)
    {
        _1985 = mat3(vec3(v_tDirWS), vec3(v_bDirWS), vec3(v_nDirWS)) * normalize(mix(vec3(0.0, 0.0, 1.0), normalize((mix(texture2D(u_normTex, v_uv0).xyz, texture2D(u_normTex, v_uv0 * 3.0).xyz, vec3(0.300000011920928955078125)) * 2.0) - vec3(1.0)), vec3(u_normInt * 2.0)));
    }
    vec2 _1986 = vec2(0.0);
    vec3 _1987 = vec3(0.0);
    vec2 _1989 = vec2(1.0);
    _1986.x = max(0.0199999995529651641845703125, u_metallic * 0.100000001490116119384765625);
    _1986.y = 0.9900000095367431640625 * (1.0 - _1986.x);
    _1987.x = clamp(mix(0.85000002384185791015625, u_roughness, 0.300000011920928955078125), 0.039999999105930328369140625, 1.0);
    float param_8 = _1987.x;
    _1987.y = _f0(param_8);
    float param_9 = _1987.y;
    _1987.z = _f0(param_9);
    vec3 _1549 = (_1982 * _1986.y) * 1.2000000476837158203125;
    vec3 _1557 = mix(vec3(0.0199999995529651641845703125), _1982, vec3(_1986.x));
    vec2 _1571 = vec2(u_anisoAngle * 3.1415927410125732421875, max(0.60000002384185791015625, u_anisoStrength));
    vec3 _2113;
    vec3 _2114;
    if (_1446)
    {
        vec3 _1595 = normalize(cross(_1985, v_bDirWS));
        _2113 = _1595;
        _2114 = normalize(cross(_1985, _1595));
    }
    else
    {
        _2113 = v_tDirWS;
        _2114 = v_bDirWS;
    }
    vec3 _1620 = normalize(reflect(vec3(-0.0, -0.0, -1.0), _1985));
    float _1993;
    SurfaceParams param_10 = SurfaceParams(_1982, _1983, 0.0, _1985, _1986, _1987, vec3(0.0), _1989, _1549, _1557, _1571, _1993);
    WorldSpaceVectors param_11 = WorldSpaceVectors(v_posWS, _1985, v_nDirWS, _2113, _2114, vec3(0.0, 0.0, 1.0), _1620);
    _1989.y = _f6(param_10, param_11);
    bool _1657 = u_pointLightEnabled > 0.0;
    vec3 _2197;
    vec3 _2198;
    float _2199;
    float _2200;
    if (_1657)
    {
        vec3 _1665 = u_pointLightPosition - v_posWS;
        _2197 = normalize(_1665);
        _2198 = u_pointLightColor;
        _2199 = u_pointLightIntensity * u_pointLightEnabled;
        _2200 = pow(1.0 - smoothstep(0.0, 1.2000000476837158203125 / u_pointLightAttenRangeInv, length(_1665)), 1.60000002384185791015625);
    }
    bool _1696 = u_spotLightEnabled > 0.0;
    vec3 _2211;
    vec3 _2212;
    float _2213;
    float _2214;
    if (_1696)
    {
        vec3 _1711 = vec3(u_spotLightPosition.x, -u_spotLightPosition.y, u_spotLightPosition.z) - v_posWS;
        float _1714 = length(_1711);
        _2211 = normalize(_1711);
        _2212 = u_spotLightColor;
        _2213 = u_spotLightIntensity * u_spotLightEnabled;
        float _1730 = 1.0 / u_spotLightAttenRangeInv;
        float _1735 = 1.0 - smoothstep(0.0, _1730, _1714);
        _2214 = max(_1735 * _1735, pow(1.0 - smoothstep(0.0, _1730 * 0.5, _1714), 1.5) * 0.60000002384185791015625);
    }
    vec3 _t103 = _1428;
    vec3 param_12 = v_vertexColor.xyz;
    bool _1773 = u_envEnabled > 0.0;
    bool _1775 = u_dirLightEnabled > 0.0;
    if (((_1773 || _1775) || _1657) || _1696)
    {
        vec3 _t106 = vec3(0.0);
        if (_1773)
        {
            vec3 param_13 = _1985;
            float param_14 = 7.0;
            vec3 param_15 = _1620;
            float param_16 = _1987.x * 7.0;
            SurfaceParams param_17 = SurfaceParams(_1982, _1983, 0.0, _1985, _1986, _1987, vec3(0.0), _1989, _1549, _1557, _1571, _1993);
            WorldSpaceVectors param_18 = WorldSpaceVectors(v_posWS, _1985, v_nDirWS, _2113, _2114, vec3(0.0, 0.0, 1.0), _1620);
            _t106 += ((((_f12(param_13, param_14) * _1549) * 1.2999999523162841796875) + ((_f12(param_15, param_16) * _f13(param_17, param_18)) * 0.20000000298023223876953125)) * (u_envInt * u_envEnabled));
        }
        if (_1775)
        {
            SurfaceParams param_19 = SurfaceParams(_1982, _1983, 0.0, _1985, _1986, _1987, vec3(0.0), _1989, _1549, _1557, _1571, _1993);
            WorldSpaceVectors param_20 = WorldSpaceVectors(v_posWS, _1985, v_nDirWS, _2113, _2114, vec3(0.0, 0.0, 1.0), _1620);
            LightParams _2191 = LightParams(normalize(-u_dirLightDirection), u_dirLightColor, u_dirLightIntensity * u_dirLightEnabled, 1.0);
            LightParams param_21 = _2191;
            SurfaceParams param_22 = SurfaceParams(_1982, _1983, 0.0, _1985, _1986, _1987, vec3(0.0), _1989, _1549, _1557, _1571, _1993);
            WorldSpaceVectors param_23 = WorldSpaceVectors(v_posWS, _1985, v_nDirWS, _2113, _2114, vec3(0.0, 0.0, 1.0), _1620);
            LightParams param_24 = _2191;
            float param_25 = dot(_1985, vec3(0.0, 0.0, 1.0));
            _t106 += ((_f14(param_19, param_20, param_21) + (_f18(param_22, param_23, param_24) * 0.300000011920928955078125)) + (vec3(0.20000000298023223876953125) * pow(1.0 - _f2(param_25), 3.0)));
        }
        if (_1657)
        {
            SurfaceParams param_26 = SurfaceParams(_1982, _1983, 0.0, _1985, _1986, _1987, vec3(0.0), _1989, _1549, _1557, _1571, _1993);
            WorldSpaceVectors param_27 = WorldSpaceVectors(v_posWS, _1985, v_nDirWS, _2113, _2114, vec3(0.0, 0.0, 1.0), _1620);
            LightParams param_28 = LightParams(_2197, _2198, _2199, _2200);
            SurfaceParams param_29 = SurfaceParams(_1982, _1983, 0.0, _1985, _1986, _1987, vec3(0.0), _1989, _1549, _1557, _1571, _1993);
            WorldSpaceVectors param_30 = WorldSpaceVectors(v_posWS, _1985, v_nDirWS, _2113, _2114, vec3(0.0, 0.0, 1.0), _1620);
            LightParams param_31 = LightParams(_2197, _2198, _2199, _2200);
            _t106 += (((_f21(param_26, param_27, param_28) * 1.2000000476837158203125) + (_f20(param_29, param_30, param_31) * 0.300000011920928955078125)) * 1.0);
        }
        if (_1696)
        {
            SurfaceParams param_32 = SurfaceParams(_1982, _1983, 0.0, _1985, _1986, _1987, vec3(0.0), _1989, _1549, _1557, _1571, _1993);
            WorldSpaceVectors param_33 = WorldSpaceVectors(v_posWS, _1985, v_nDirWS, _2113, _2114, vec3(0.0, 0.0, 1.0), _1620);
            LightParams param_34 = LightParams(_2211, _2212, _2213, _2214);
            SurfaceParams param_35 = SurfaceParams(_1982, _1983, 0.0, _1985, _1986, _1987, vec3(0.0), _1989, _1549, _1557, _1571, _1993);
            WorldSpaceVectors param_36 = WorldSpaceVectors(v_posWS, _1985, v_nDirWS, _2113, _2114, vec3(0.0, 0.0, 1.0), _1620);
            LightParams param_37 = LightParams(_2211, _2212, _2213, _2214);
            _t106 += (((_f21(param_32, param_33, param_34) * 1.2000000476837158203125) + (_f20(param_35, param_36, param_37) * 0.300000011920928955078125)) * 1.0);
        }
        if (u_enableToneMapping > 0)
        {
            vec3 param_38 = _t106;
            _t106 = _f5(param_38);
        }
        vec3 param_39 = _t106;
        vec3 _1938 = _f4(param_39);
        _t106 = _1938;
        _t103 = mix(_t103, _1938, vec3(u_lightingBlend)) * mix(vec3(1.0), pow(_f4(param_12), vec3(u_shadowContrast)) * u_shadowColor, vec3(u_shadowIntensity));
    }
    gl_FragData[0] = vec4(_t103, _1983);
}

