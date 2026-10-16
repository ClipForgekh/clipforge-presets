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

struct EnvironmentParams
{
    float intensity;
    float rotation;
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
uniform float u_envRot;
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

vec2 _f28(inout vec2 _p0, float _p1, vec2 _p2, vec2 _p3)
{
    _p0 -= _p2;
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _1396 = sin(_p1);
    float _1399 = cos(_p1);
    _p0 = mat2(vec2(_1399, _1396), vec2(-_1396, _1399)) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 /= _p3;
    _p0 += _p2;
    return _p0;
}

vec2 _f26(vec2 _p0)
{
    vec2 _1355 = mod(_p0, vec2(1.0));
    return _1355 + (vec2(1.0) - step(vec2(0.0), _1355));
}

vec2 _f25(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f27(vec2 _p0)
{
    vec2 _t85 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t85.x * _t85.y;
}

vec4 _f29(mediump sampler2D _p0, vec2 _p1, vec2 _p2)
{
    vec2 _t89 = _p1;
    bool _1436 = _p2.x < 0.0;
    bool _1443;
    if (!_1436)
    {
        _1443 = _p2.y < 0.0;
    }
    else
    {
        _1443 = _1436;
    }
    if (_1443)
    {
        if (u_edgeType == 0)
        {
            vec2 param = _p1;
            _t89 = _f26(param);
        }
        else
        {
            if (u_edgeType == 1)
            {
                vec2 param_1 = _p1;
                _t89 = _f25(param_1);
            }
            else
            {
                if (u_edgeType == 2)
                {
                    _t89 = clamp(_p1, vec2(0.0), vec2(1.0));
                }
                else
                {
                    vec2 param_2 = _p1;
                    if (_f27(param_2) < 1.0)
                    {
                        return vec4(0.0);
                    }
                    _t89 = _p1;
                }
            }
        }
        return texture2D(_p0, _t89);
    }
    bool _1492 = _p1.x < _p2.x;
    bool _1502;
    if (!_1492)
    {
        _1502 = _p1.x > (1.0 - _p2.x);
    }
    else
    {
        _1502 = _1492;
    }
    bool _1512;
    if (!_1502)
    {
        _1512 = _p1.y > (1.0 - _p2.y);
    }
    else
    {
        _1512 = _1502;
    }
    if (_1512)
    {
        if (u_edgeType == 0)
        {
            vec2 param_3 = _p1;
            _t89 = _f26(param_3);
        }
        else
        {
            if (u_edgeType == 1)
            {
                vec2 param_4 = _p1;
                _t89 = _f25(param_4);
            }
            else
            {
                if (u_edgeType == 2)
                {
                    _t89 = clamp(_p1, vec2(0.0), vec2(1.0));
                }
                else
                {
                    vec2 param_5 = _p1;
                    if (_f27(param_5) < 1.0)
                    {
                        return vec4(0.0);
                    }
                    _t89 = _p1;
                }
            }
        }
    }
    return texture2D(_p0, _t89);
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
    float _288 = min(1.0 + dot(_p1.rDir, _p1.nDir), 1.0);
    return _f2(param) * (_288 * _288);
}

vec3 _f4(vec3 _p0)
{
    return vec3(pow(_p0.x, 0.4545449912548065185546875), pow(_p0.y, 0.4545449912548065185546875), pow(_p0.z, 0.4545449912548065185546875));
}

mat3 _f9(float _p0)
{
    float _334 = sin(_p0);
    float _337 = cos(_p0);
    return mat3(vec3(_337, -_334, 0.0), vec3(_334, _337, 0.0), vec3(0.0, 0.0, 1.0));
}

mat3 _f8(float _p0)
{
    float _317 = sin(_p0);
    float _320 = cos(_p0);
    return mat3(vec3(_320, 0.0, _317), vec3(0.0, 1.0, 0.0), vec3(-_317, 0.0, _320));
}

mat3 _f7(float _p0)
{
    float _300 = sin(_p0);
    float _303 = cos(_p0);
    return mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, _303, -_300), vec3(0.0, _300, _303));
}

vec2 _f10(vec3 _p0, float _p1)
{
    vec3 _357 = normalize(u_WorldSpaceCameraPos - v_posWS);
    vec3 _362 = normalize(cross(vec3(0.0, 1.0, 0.0), _357));
    float param = u_envRotAxis.z;
    float param_1 = u_envRotAxis.y;
    float param_2 = u_envRotAxis.x;
    vec3 _t22 = normalize((mat3(vec3(_362), vec3(normalize(cross(_357, _362))), vec3(_357)) * ((_f9(param) * _f8(param_1)) * _f7(param_2))) * _p0);
    vec2 _t23;
    _t23.x = ((atan(_t22.z, _t22.x) * 0.31830990314483642578125) * 0.5) + 0.5;
    _t23.y = acos(_t22.y) * 0.31830990314483642578125;
    _t23.x = fract(_t23.x + _p1);
    return _t23;
}

vec3 _f11(mediump sampler2D _p0, vec2 _p1, float _p2)
{
    float _437 = floor(_p2);
    vec2 _t26 = _p1;
    vec2 _t27 = _p1;
    if (abs(_437 - 0.0) < 0.001000000047497451305389404296875)
    {
        _t26.x = ((((_p1.x * 511.0) / 512.0) + 0.0009765625) * 1.0) + 0.0;
        _t26.y = ((((_p1.y * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
    }
    else
    {
        if (abs(_437 - 1.0) < 0.001000000047497451305389404296875)
        {
            _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
            _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
            _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
            _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
        }
        else
        {
            if (abs(_437 - 2.0) < 0.001000000047497451305389404296875)
            {
                _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
                _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
            }
            else
            {
                if (abs(_437 - 3.0) < 0.001000000047497451305389404296875)
                {
                    _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                    _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                    _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                    _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                }
                else
                {
                    if (abs(_437 - 4.0) < 0.001000000047497451305389404296875)
                    {
                        _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                        _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                        _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                        _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                    }
                    else
                    {
                        if (abs(_437 - 5.0) < 0.001000000047497451305389404296875)
                        {
                            _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                            _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                            _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                            _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                        }
                        else
                        {
                            if (abs(_437 - 6.0) < 0.001000000047497451305389404296875)
                            {
                                _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                                _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                            }
                            else
                            {
                                if (abs(_437 - 7.0) < 0.001000000047497451305389404296875)
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
    vec4 _793 = mix(texture2D(_p0, _t26), texture2D(_p0, _t27), vec4(_p2 - _437));
    vec4 _t29 = _793;
    return _793.xyz / vec3(_t29.w);
}

vec3 _f12(mediump sampler2D _p0, vec3 _p1, float _p2, float _p3)
{
    vec3 param = _p1;
    float param_1 = _p2;
    vec2 param_2 = _f10(param, param_1);
    float param_3 = _p3;
    return _f11(_p0, param_2, param_3);
}

vec3 _f14(float _p0, vec3 _p1)
{
    return max(vec3(_p0), ((((((_p1 * 2.040400028228759765625) - vec3(0.3323999941349029541015625)) * _p0) + ((_p1 * (-4.79510021209716796875)) + vec3(0.6417000293731689453125))) * _p0) + ((_p1 * 2.755199909210205078125) + vec3(0.69029998779296875))) * _p0);
}

vec3 _f16(SurfaceParams _p0, WorldSpaceVectors _p1, EnvironmentParams _p2)
{
    vec3 param = _p1.nDir;
    float param_1 = _p2.rotation;
    float param_2 = 7.0;
    float param_3 = _p0.occParams.x;
    vec3 param_4 = _p0.diffCol;
    return ((_f12(u_envTex, param, param_1, param_2) * _p0.diffCol) * _f14(param_3, param_4)) * _p2.intensity;
}

vec3 _f13(SurfaceParams _p0, WorldSpaceVectors _p1)
{
    vec4 _838 = (vec4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _p0.roughParams.x) + vec4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    vec4 _t33 = _838;
    vec2 _t35 = (vec2(-1.03999996185302734375, 1.03999996185302734375) * ((min(_t33.x * _t33.x, exp2((-9.27999973297119140625) * max(0.0, dot(_p1.nDir, _p1.vDir)))) * _t33.x) + _t33.y)) + _838.zw;
    float param = 50.0 * _p0.specCol.y;
    _t35.y *= _f2(param);
    return (_p0.specCol * _t35.x) + vec3(_t35.y);
}

vec3 _f15(SurfaceParams _p0, WorldSpaceVectors _p1, EnvironmentParams _p2)
{
    vec3 param = mix(_p1.rDir, _p1.nDir, vec3(_p0.roughParams.x * _p0.roughParams.y));
    float param_1 = _p2.rotation;
    float param_2 = _p0.roughParams.x * 7.0;
    SurfaceParams param_3 = _p0;
    WorldSpaceVectors param_4 = _p1;
    float param_5 = _p0.occParams.y;
    vec3 param_6 = _p0.specCol;
    return ((_f13(param_3, param_4) * _f12(u_envTex, param, param_1, param_2)) * _f14(param_5, param_6)) * _p2.intensity;
}

vec3 _f24(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    float _1251 = max(0.0, dot(_p1.nDir, _p2.lDir));
    float _1258 = max(0.0, dot(_p1.nDir, _p1.vDir));
    float _1264 = max(0.0, dot(_p1.vDir, normalize(_p2.lDir + _p1.vDir)));
    float _1273 = _p0.roughParams.y * _p0.roughParams.y;
    float _1285 = (((2.0 * _1264) * _1264) - 1.0) - (_1258 * _1251);
    float _1306;
    if (_1285 >= 0.0)
    {
        _1306 = 1.0 / max(_1251, _1258);
    }
    else
    {
        _1306 = 1.0;
    }
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * ((((1.0 - ((0.5 * _1273) / (_1273 + 0.3300000131130218505859375))) + ((((0.449999988079071044921875 * _1273) / (_1273 + 0.0900000035762786865234375)) * _1285) * _1306)) * (1.0 + (_p0.roughParams.x * 0.5))) * _1251);
}

float _f19(float _p0, float _p1, float _p2)
{
    return 0.5 / (((_p2 * ((_p1 * (1.0 - _p0)) + _p0)) + (_p1 * ((_p2 * (1.0 - _p0)) + _p0))) + 9.9999997473787516355514526367188e-06);
}

float _f18(float _p0, float _p1)
{
    float _1023 = (((_p0 * _p1) - _p0) * _p0) + 1.0;
    return (_p1 * 0.31830990314483642578125) / ((_1023 * _1023) + 1.0000000116860974230803549289703e-07);
}

float _f1(float _p0)
{
    float _171 = _p0 * _p0;
    return (_171 * _171) * _p0;
}

vec3 _f17(vec3 _p0, float _p1)
{
    float param = 1.0 - _p1;
    return _p0 + ((vec3(1.0) - _p0) * _f1(param));
}

vec3 _f20(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    vec3 _1066 = normalize(_p2.lDir + _p1.vDir);
    float _1085 = max(0.0, dot(_p1.nDir, _p2.lDir));
    float param = _1085;
    float param_1 = max(0.0, dot(_p1.nDir, _p1.vDir));
    float param_2 = _p0.roughParams.y;
    float param_3 = max(0.0, dot(_p1.nDir, _1066));
    float param_4 = _p0.roughParams.z;
    vec3 param_5 = _p0.specCol;
    float param_6 = max(0.0, dot(_p1.vDir, _1066));
    return ((((((_f17(param_5, param_6) * _f19(param, param_1, param_2)) * _f18(param_3, param_4)) * 3.1415927410125732421875) * _1085) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

vec3 _f23(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * max(0.0, dot(_p1.nDir, _p2.lDir));
}

float _f21()
{
    return 0.25;
}

vec3 _f22(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    vec3 _1152 = normalize(_p2.lDir + _p1.vDir);
    float param = max(0.0, dot(_p1.nDir, _1152));
    float param_1 = _p0.roughParams.z;
    vec3 param_2 = _p0.specCol;
    float param_3 = max(0.0, dot(_p1.vDir, _1152));
    return ((((((_f17(param_2, param_3) * _f21()) * _f18(param, param_1)) * 3.1415927410125732421875) * max(0.0, dot(_p1.nDir, _p2.lDir))) * _p2.color) * _p2.intensity) * _p2.attenuate;
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
    vec2 _1588 = _f28(param, param_1, param_2, param_3);
    vec2 param_4 = _1588;
    vec2 param_5 = u_padding;
    vec4 _1598 = _f29(u_input, param_4, param_5);
    vec4 _t93 = _1598;
    vec3 param_6 = u_mainColor.xyz;
    vec3 _2174 = _f3(param_6);
    float _2175 = u_mainColor.w;
    vec3 _1611 = _1598.xyz;
    vec3 param_7 = _1611;
    _2174 *= _f3(param_7);
    _2175 *= _t93.w;
    vec3 _2177 = v_nDirWS;
    bool _1629 = u_enableNormTex > 0;
    if (_1629)
    {
        _2177 = mat3(vec3(v_tDirWS), vec3(v_bDirWS), vec3(v_nDirWS)) * normalize(mix(vec3(0.0, 0.0, 1.0), normalize((mix(texture2D(u_normTex, v_uv0).xyz, texture2D(u_normTex, v_uv0 * 3.0).xyz, vec3(0.300000011920928955078125)) * 2.0) - vec3(1.0)), vec3(u_normInt * 2.0)));
    }
    vec2 _2178 = vec2(0.0);
    vec3 _2179 = vec3(0.0);
    vec2 _2181 = vec2(1.0);
    _2178.x = max(0.0199999995529651641845703125, u_metallic * 0.100000001490116119384765625);
    _2178.y = 0.9900000095367431640625 * (1.0 - _2178.x);
    _2179.x = clamp(mix(0.85000002384185791015625, u_roughness, 0.300000011920928955078125), 0.039999999105930328369140625, 1.0);
    float param_8 = _2179.x;
    _2179.y = _f0(param_8);
    float param_9 = _2179.y;
    _2179.z = _f0(param_9);
    vec3 _1732 = (_2174 * _2178.y) * 1.2000000476837158203125;
    vec3 _1740 = mix(vec3(0.0199999995529651641845703125), _2174, vec3(_2178.x));
    vec2 _1754 = vec2(u_anisoAngle * 3.1415927410125732421875, max(0.60000002384185791015625, u_anisoStrength));
    vec3 _2317;
    vec3 _2318;
    if (_1629)
    {
        vec3 _1778 = normalize(cross(_2177, v_bDirWS));
        _2317 = _1778;
        _2318 = normalize(cross(_2177, _1778));
    }
    else
    {
        _2317 = v_tDirWS;
        _2318 = v_bDirWS;
    }
    vec3 _1803 = normalize(reflect(vec3(-0.0, -0.0, -1.0), _2177));
    float _2185;
    SurfaceParams param_10 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
    WorldSpaceVectors param_11 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
    _2181.y = _f6(param_10, param_11);
    vec3 _1825 = normalize(-u_dirLightDirection);
    bool _1839 = u_pointLightEnabled > 0.0;
    vec3 _2415;
    vec3 _2416;
    float _2417;
    float _2418;
    if (_1839)
    {
        vec3 _1847 = u_pointLightPosition - v_posWS;
        _2415 = normalize(_1847);
        _2416 = u_pointLightColor;
        _2417 = u_pointLightIntensity * u_pointLightEnabled;
        _2418 = pow(1.0 - smoothstep(0.0, 1.2000000476837158203125 / u_pointLightAttenRangeInv, length(_1847)), 1.60000002384185791015625);
    }
    bool _1878 = u_spotLightEnabled > 0.0;
    vec3 _2429;
    vec3 _2430;
    float _2431;
    float _2432;
    if (_1878)
    {
        vec3 _1893 = vec3(u_spotLightPosition.x, -u_spotLightPosition.y, u_spotLightPosition.z) - v_posWS;
        float _1896 = length(_1893);
        _2429 = normalize(_1893);
        _2430 = u_spotLightColor;
        _2431 = u_spotLightIntensity * u_spotLightEnabled;
        float _1912 = 1.0 / u_spotLightAttenRangeInv;
        float _1917 = 1.0 - smoothstep(0.0, _1912, _1896);
        _2432 = max(_1917 * _1917, pow(1.0 - smoothstep(0.0, _1912 * 0.5, _1896), 1.5) * 0.60000002384185791015625);
    }
    vec3 _t118 = _1611;
    vec3 param_12 = v_vertexColor.xyz;
    bool _1955 = u_envEnabled > 0.0;
    bool _1957 = u_dirLightEnabled > 0.0;
    if (((_1955 || _1957) || _1839) || _1878)
    {
        vec3 _t121 = vec3(0.0);
        if (_1955)
        {
            SurfaceParams param_13 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
            WorldSpaceVectors param_14 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
            EnvironmentParams _2397 = EnvironmentParams(u_envInt * u_envEnabled, u_envRot);
            EnvironmentParams param_15 = _2397;
            SurfaceParams param_16 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
            WorldSpaceVectors param_17 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
            EnvironmentParams param_18 = _2397;
            _t121 += (((_f16(param_13, param_14, param_15) * 1.2999999523162841796875) + (_f15(param_16, param_17, param_18) * 0.20000000298023223876953125)) * v_vertexColor.w);
        }
        if (_1957)
        {
            SurfaceParams param_19 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
            WorldSpaceVectors param_20 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
            LightParams _2409 = LightParams(_1825, u_dirLightColor, u_dirLightIntensity * u_dirLightEnabled, 1.0);
            LightParams param_21 = _2409;
            SurfaceParams param_22 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
            WorldSpaceVectors param_23 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
            LightParams param_24 = _2409;
            _t121 += (((((_f24(param_19, param_20, param_21) * 1.39999997615814208984375) + (_f20(param_22, param_23, param_24) * 0.300000011920928955078125)) + (vec3(0.20000000298023223876953125) * pow(1.0 - max(0.0, dot(_2177, vec3(0.0, 0.0, 1.0))), 3.0))) + vec3(pow(max(0.0, dot(_2177, -_1825)), 2.0) * 0.100000001490116119384765625)) * v_vertexColor.w);
        }
        if (_1839)
        {
            SurfaceParams param_25 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
            WorldSpaceVectors param_26 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
            LightParams param_27 = LightParams(_2415, _2416, _2417, _2418);
            SurfaceParams param_28 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
            WorldSpaceVectors param_29 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
            LightParams param_30 = LightParams(_2415, _2416, _2417, _2418);
            _t121 += (((_f23(param_25, param_26, param_27) * 1.2000000476837158203125) + (_f22(param_28, param_29, param_30) * 0.300000011920928955078125)) * v_vertexColor.w);
        }
        if (_1878)
        {
            SurfaceParams param_31 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
            WorldSpaceVectors param_32 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
            LightParams param_33 = LightParams(_2429, _2430, _2431, _2432);
            SurfaceParams param_34 = SurfaceParams(_2174, _2175, 0.0, _2177, _2178, _2179, vec3(0.0), _2181, _1732, _1740, _1754, _2185);
            WorldSpaceVectors param_35 = WorldSpaceVectors(v_posWS, _2177, v_nDirWS, _2317, _2318, vec3(0.0, 0.0, 1.0), _1803);
            LightParams param_36 = LightParams(_2429, _2430, _2431, _2432);
            _t121 += (((_f23(param_31, param_32, param_33) * 1.2000000476837158203125) + (_f22(param_34, param_35, param_36) * 0.300000011920928955078125)) * v_vertexColor.w);
        }
        if (u_enableToneMapping > 0)
        {
            vec3 param_37 = _t121;
            _t121 = _f5(param_37);
        }
        vec3 param_38 = _t121;
        vec3 _2130 = _f4(param_38);
        _t121 = _2130;
        _t118 = mix(_t118, _2130, vec3(u_lightingBlend)) * mix(vec3(1.0), pow(_f4(param_12), vec3(u_shadowContrast)) * u_shadowColor, vec3(u_shadowIntensity));
    }
    gl_FragData[0] = vec4(_t118, _2175);
}

