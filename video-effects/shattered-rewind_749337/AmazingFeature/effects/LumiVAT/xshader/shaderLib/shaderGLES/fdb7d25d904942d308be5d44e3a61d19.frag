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

uniform mat4 u_Model;
uniform mediump sampler2D u_envTex;
uniform float u_envMipLevel;
uniform vec4 u_ScreenParams;
uniform vec4 u_albedoColor;
uniform mediump int u_enableAlbedoTex;
uniform mediump sampler2D u_albedoTex;
uniform vec2 u_padding;
uniform vec3 u_WorldSpaceCameraPos;
uniform float u_rotate;
uniform vec2 u_offset;
uniform vec2 u_scale;
uniform mediump sampler2D u_backTex;
uniform mediump sampler2D u_inputTex;
uniform mediump int u_enableNormTex;
uniform mediump sampler2D u_normTex;
uniform float u_normInt;
uniform float u_metallic;
uniform float u_roughness;
uniform float u_envInt;
uniform float u_envEnabled;
uniform float u_envRot;
uniform float u_dirLightEnabled;
uniform vec3 u_dirLightDirection;
uniform vec3 u_dirLightColor;
uniform float u_dirLightIntensity;
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
uniform vec3 u_spotLightDirection;
uniform float u_spotLightOuterAngleCos;
uniform float u_spotLightInnerAngleCos;
uniform mediump int u_enableToneMapping;
uniform mediump int u_toneMappingType;
uniform float u_lightingBlend;
uniform vec3 u_hightLightColor;

varying vec3 v_posWS;
varying vec3 v_nDirWS;
varying vec3 v_tDirWS;
varying vec3 v_bDirWS;
varying vec2 v_uv0;

vec3 _f6(vec3 _p0)
{
    return vec3(pow(_p0.x, 2.2000000476837158203125), pow(_p0.y, 2.2000000476837158203125), pow(_p0.z, 2.2000000476837158203125));
}

vec2 _f34(vec2 _p0)
{
    vec2 _1599 = mod(_p0, vec2(1.0));
    return _1599 + (vec2(1.0) - step(vec2(0.0), _1599));
}

vec2 _f33(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f35(vec2 _p0)
{
    vec2 _t103 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t103.x * _t103.y;
}

vec4 _f37(mediump sampler2D _p0, vec2 _p1, vec2 _p2, mediump int _p3)
{
    vec2 _t107 = _p1;
    bool _1680 = _p2.x < 0.0;
    bool _1687;
    if (!_1680)
    {
        _1687 = _p2.y < 0.0;
    }
    else
    {
        _1687 = _1680;
    }
    if (_1687)
    {
        if (_p3 == 0)
        {
            vec2 param = _p1;
            _t107 = _f34(param);
        }
        else
        {
            if (_p3 == 1)
            {
                vec2 param_1 = _p1;
                _t107 = _f33(param_1);
            }
            else
            {
                if (_p3 == 2)
                {
                    _t107 = clamp(_p1, vec2(0.0), vec2(1.0));
                }
                else
                {
                    vec2 param_2 = _p1;
                    if (_f35(param_2) < 1.0)
                    {
                        return vec4(0.0);
                    }
                    _t107 = _p1;
                }
            }
        }
        return texture2D(_p0, _t107);
    }
    bool _1734 = _p1.x < _p2.x;
    bool _1744;
    if (!_1734)
    {
        _1744 = _p1.x > (1.0 - _p2.x);
    }
    else
    {
        _1744 = _1734;
    }
    bool _1754;
    if (!_1744)
    {
        _1754 = _p1.y > (1.0 - _p2.y);
    }
    else
    {
        _1754 = _1744;
    }
    if (_1754)
    {
        if (_p3 == 0)
        {
            vec2 param_3 = _p1;
            _t107 = _f34(param_3);
        }
        else
        {
            if (_p3 == 1)
            {
                vec2 param_4 = _p1;
                _t107 = _f33(param_4);
            }
            else
            {
                if (_p3 == 2)
                {
                    _t107 = clamp(_p1, vec2(0.0), vec2(1.0));
                }
                else
                {
                    vec2 param_5 = _p1;
                    if (_f35(param_5) < 1.0)
                    {
                        return vec4(0.0);
                    }
                    _t107 = _p1;
                }
            }
        }
    }
    return texture2D(_p0, _t107);
}

vec2 _f36(inout vec2 _p0, float _p1, vec2 _p2, vec2 _p3)
{
    _p0 -= _p2;
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _1640 = sin(_p1);
    float _1643 = cos(_p1);
    _p0 = mat2(vec2(_1643, _1640), vec2(-_1640, _1643)) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 /= _p3;
    _p0 += _p2;
    return _p0;
}

float _f0(float _p0)
{
    return _p0 * _p0;
}

float _f3(float _p0)
{
    return clamp(_p0, 0.0, 1.0);
}

float _f17(SurfaceParams _p0, WorldSpaceVectors _p1)
{
    float param = (pow(max(0.0, dot(_p1.nDir, _p1.vDir)) + _p0.occParams.x, exp2(((-16.0) * _p0.roughParams.x) - 1.0)) - 1.0) + _p0.occParams.x;
    float _615 = min(1.0 + dot(_p1.rDir, _p1.nDir), 1.0);
    return _f3(param) * (_615 * _615);
}

float _f1(float _p0)
{
    float _197 = _p0 * _p0;
    return _197 * _197;
}

float _f5(float _p0, float _p1)
{
    return ((_p0 < 0.0) ? (-1.0) : 1.0) * acos(clamp(_p1 / length(vec2(_p0, _p1)), -1.0, 1.0));
}

vec2 _f18(inout vec3 _p0, float _p1)
{
    _p0 = normalize(_p0);
    float param = _p0.x;
    float param_1 = -_p0.z;
    vec2 _t40;
    _t40.x = (_f5(param, param_1) - 1.57079637050628662109375) / 6.283185482025146484375;
    _t40.y = acos(_p0.y) / 3.1415927410125732421875;
    _t40.x += _p1;
    _t40.x = fract((_t40.x + floor(_t40.x)) + 1.0);
    return _t40;
}

vec3 _f19(mediump sampler2D _p0, vec2 _p1, float _p2)
{
    float _666 = floor(_p2);
    vec2 _t43 = _p1;
    vec2 _t44 = _p1;
    if (abs(_666 - 0.0) < 0.001000000047497451305389404296875)
    {
        _t43.x = ((((_p1.x * 511.0) / 512.0) + 0.0009765625) * 1.0) + 0.0;
        _t43.y = ((((_p1.y * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t44.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t44.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
    }
    else
    {
        if (abs(_666 - 1.0) < 0.001000000047497451305389404296875)
        {
            _t43.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
            _t43.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
            _t44.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
            _t44.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
        }
        else
        {
            if (abs(_666 - 2.0) < 0.001000000047497451305389404296875)
            {
                _t43.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
                _t43.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                _t44.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                _t44.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
            }
            else
            {
                if (abs(_666 - 3.0) < 0.001000000047497451305389404296875)
                {
                    _t43.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                    _t43.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                    _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                    _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                }
                else
                {
                    if (abs(_666 - 4.0) < 0.001000000047497451305389404296875)
                    {
                        _t43.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                        _t43.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                        _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                        _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                    }
                    else
                    {
                        if (abs(_666 - 5.0) < 0.001000000047497451305389404296875)
                        {
                            _t43.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                            _t43.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                            _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                            _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                        }
                        else
                        {
                            if (abs(_666 - 6.0) < 0.001000000047497451305389404296875)
                            {
                                _t43.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                                _t43.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                            }
                            else
                            {
                                if (abs(_666 - 7.0) < 0.001000000047497451305389404296875)
                                {
                                    _t43.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                    _t43.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                    _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                    _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    vec4 _1020 = mix(texture2D(_p0, _t43), texture2D(_p0, _t44), vec4(_p2 - _666));
    vec4 _t46 = _1020;
    return _1020.xyz / vec3(_t46.w);
}

vec3 _f20(mediump sampler2D _p0, vec3 _p1, float _p2, float _p3)
{
    vec3 param = _p1;
    float param_1 = _p2;
    vec2 _1035 = _f18(param, param_1);
    vec2 param_2 = _1035;
    float param_3 = _p3;
    return _f19(_p0, param_2, param_3);
}

vec3 _f22(float _p0, vec3 _p1)
{
    return max(vec3(_p0), ((((((_p1 * 2.040400028228759765625) - vec3(0.3323999941349029541015625)) * _p0) + ((_p1 * (-4.79510021209716796875)) + vec3(0.6417000293731689453125))) * _p0) + ((_p1 * 2.755199909210205078125) + vec3(0.69029998779296875))) * _p0);
}

vec3 _f24(SurfaceParams _p0, WorldSpaceVectors _p1, EnvironmentParams _p2)
{
    vec3 param = normalize(mat3(u_Model[0].xyz, u_Model[1].xyz, u_Model[2].xyz) * _p1.nDir);
    float param_1 = _p2.rotation;
    float param_2 = u_envMipLevel;
    float param_3 = _p0.occParams.x;
    vec3 param_4 = _p0.diffCol;
    return ((_f20(u_envTex, param, param_1, param_2) * _p0.diffCol) * _f22(param_3, param_4)) * _p2.intensity;
}

vec3 _f21(SurfaceParams _p0, WorldSpaceVectors _p1)
{
    vec4 _1068 = (vec4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _p0.roughParams.x) + vec4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    vec4 _t52 = _1068;
    vec2 _t54 = (vec2(-1.03999996185302734375, 1.03999996185302734375) * ((min(_t52.x * _t52.x, exp2((-9.27999973297119140625) * max(0.0, dot(_p1.nDir, _p1.vDir)))) * _t52.x) + _t52.y)) + _1068.zw;
    float param = 50.0 * _p0.specCol.y;
    _t54.y *= _f3(param);
    return (_p0.specCol * _t54.x) + vec3(_t54.y);
}

vec3 _f23(SurfaceParams _p0, WorldSpaceVectors _p1, EnvironmentParams _p2)
{
    vec3 param = normalize(mat3(u_Model[0].xyz, u_Model[1].xyz, u_Model[2].xyz) * mix(_p1.rDir, _p1.nDir, vec3(_p0.roughParams.x * _p0.roughParams.y)));
    float param_1 = _p2.rotation;
    float param_2 = _p0.roughParams.x * u_envMipLevel;
    SurfaceParams param_3 = _p0;
    WorldSpaceVectors param_4 = _p1;
    float param_5 = _p0.occParams.y;
    vec3 param_6 = _p0.specCol;
    return ((_f21(param_3, param_4) * _f20(u_envTex, param, param_1, param_2)) * _f22(param_5, param_6)) * _p2.intensity;
}

vec3 _f32(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    float _1505 = max(0.0, dot(_p1.nDir, _p1.vDir));
    float _1512 = max(0.0, dot(_p1.nDir, _p2.lDir));
    float _1524 = dot(_p2.lDir, _p1.vDir) - (_1512 * _1505);
    float _1538 = _p0.roughParams.y * _p0.roughParams.y;
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * (max(0.0, _1512) * ((1.0 + (_1538 * ((1.0 / (_1538 + 0.12999999523162841796875)) + (0.5 / (_1538 + 0.3300000131130218505859375))))) + ((((0.449999988079071044921875 * _1538) / (_1538 + 0.0900000035762786865234375)) * _1524) / mix(1.0, max(_1512, _1505), step(0.0, _1524)))));
}

float _f27(float _p0, float _p1, float _p2)
{
    return 0.5 / (((_p2 * ((_p1 * (1.0 - _p0)) + _p0)) + (_p1 * ((_p2 * (1.0 - _p0)) + _p0))) + 9.9999997473787516355514526367188e-06);
}

float _f26(float _p0, float _p1)
{
    float _1284 = (((_p0 * _p1) - _p0) * _p0) + 1.0;
    return (_p1 * 0.31830990314483642578125) / ((_1284 * _1284) + 1.0000000116860974230803549289703e-07);
}

float _f2(float _p0)
{
    float _206 = _p0 * _p0;
    return (_206 * _206) * _p0;
}

vec3 _f25(vec3 _p0, float _p1)
{
    float param = 1.0 - _p1;
    return _p0 + ((vec3(1.0) - _p0) * _f2(param));
}

vec3 _f28(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    vec3 _1328 = normalize(_p2.lDir + _p1.vDir);
    float _1347 = max(0.0, dot(_p1.nDir, _p2.lDir));
    float param = _1347;
    float param_1 = max(0.0, dot(_p1.nDir, _p1.vDir));
    float param_2 = _p0.roughParams.y;
    float param_3 = max(0.0, dot(_p1.nDir, _1328));
    float param_4 = _p0.roughParams.z;
    vec3 param_5 = _p0.specCol;
    float param_6 = max(0.0, dot(_p1.vDir, _1328));
    return ((((((_f25(param_5, param_6) * _f27(param, param_1, param_2)) * _f26(param_3, param_4)) * 3.1415927410125732421875) * _1347) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

vec3 _f31(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * max(0.0, dot(_p1.nDir, _p2.lDir));
}

float _f29()
{
    return 0.25;
}

vec3 _f30(SurfaceParams _p0, WorldSpaceVectors _p1, LightParams _p2)
{
    vec3 _1413 = normalize(_p2.lDir + _p1.vDir);
    float param = max(0.0, dot(_p1.nDir, _1413));
    float param_1 = _p0.roughParams.z;
    vec3 param_2 = _p0.specCol;
    float param_3 = max(0.0, dot(_p1.vDir, _1413));
    return ((((((_f25(param_2, param_3) * _f29()) * _f26(param, param_1)) * 3.1415927410125732421875) * max(0.0, dot(_p1.nDir, _p2.lDir))) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

vec3 _f8(vec3 _p0)
{
    return (_p0 * ((_p0 * 1.7999999523162841796875) + vec3(1.39999997615814208984375))) / min(vec3(1000.0), (_p0 * ((_p0 * 1.7999999523162841796875) + vec3(0.5))) + vec3(1.5));
}

vec3 _f11(vec3 _p0)
{
    vec3 _385 = _p0 * 1.5;
    return _385 / (vec3(1.0) + _385);
}

vec3 _f12(inout vec3 _p0)
{
    _p0 *= 2.0;
    return ((((_p0 * ((_p0 * 0.1500000059604644775390625) + vec3(0.0500000007450580596923828125))) + vec3(0.0040000001899898052215576171875)) / ((_p0 * ((_p0 * 0.1500000059604644775390625) + vec3(0.5))) + vec3(0.060000002384185791015625))) - vec3(0.066666662693023681640625)) * vec3(1.3790643215179443359375);
}

vec3 _f10(vec3 _p0)
{
    vec3 _356 = max(vec3(0.0), _p0 - vec3(0.0040000001899898052215576171875));
    vec3 _361 = _356 * 6.19999980926513671875;
    return pow((_356 * (_361 + vec3(0.5))) / ((_356 * (_361 + vec3(1.7000000476837158203125))) + vec3(0.0599999986588954925537109375)), vec3(2.2000000476837158203125));
}

vec3 _f4(inout vec3 _p0)
{
    _p0.x = clamp(_p0.x, 0.0, 1.0);
    _p0.y = clamp(_p0.y, 0.0, 1.0);
    _p0.z = clamp(_p0.z, 0.0, 1.0);
    return _p0;
}

vec3 _f9(vec3 _p0)
{
    vec3 param = (_p0 * ((_p0 * 2.5099999904632568359375) + vec3(0.02999999932944774627685546875))) / ((_p0 * ((_p0 * 2.4300000667572021484375) + vec3(0.589999973773956298828125))) + vec3(0.14000000059604644775390625));
    vec3 _347 = _f4(param);
    return _347;
}

vec3 _f13(vec3 _p0)
{
    vec3 _484 = _p0 * _p0;
    vec3 _488 = _484 * _484;
    return (_p0 * (_488 + vec3(1.0))) / ((_488 + _484) + _p0);
}

vec3 _f14(vec3 _p0)
{
    float _508 = dot(_p0, vec3(0.4122214615345001220703125, 0.536332547664642333984375, 0.0514459945261478424072265625));
    vec3 param = vec3(_508);
    return (_p0 / vec3(_508 + 9.9999997473787516355514526367188e-05)) * _f13(param).x;
}

vec3 _f15(vec3 _p0)
{
    vec3 _532 = max(vec3(0.0), _p0 - vec3(0.0500000007450580596923828125));
    vec3 _543 = pow(_532 / (_532 + vec3(0.9700000286102294921875)), vec3(0.85000002384185791015625));
    return mix(vec3(dot(_543, vec3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875))), _543, vec3(1.4500000476837158203125));
}

vec3 _f16(vec3 _p0)
{
    return (_p0 * (vec3(1.0) + (_p0 / vec3(16.0)))) / (vec3(1.0) + _p0);
}

vec3 _f7(vec3 _p0)
{
    return vec3(pow(_p0.x, 0.4545449912548065185546875), pow(_p0.y, 0.4545449912548065185546875), pow(_p0.z, 0.4545449912548065185546875));
}

void main()
{
    vec3 _1806 = normalize(v_nDirWS);
    vec3 _1810 = normalize(v_tDirWS);
    vec3 _1814 = normalize(v_bDirWS);
    vec3 param = u_albedoColor.xyz;
    vec3 _2610 = _f6(param);
    float _2611 = u_albedoColor.w;
    if (u_enableAlbedoTex > 0)
    {
        vec2 param_1 = v_uv0;
        vec2 param_2 = u_padding;
        mediump int param_3 = 0;
        vec4 _1847 = _f37(u_albedoTex, param_1, param_2, param_3);
        vec4 _t110 = _1847;
        vec3 param_4 = _1847.xyz;
        _2610 *= _f6(param_4);
        _2611 *= _t110.w;
    }
    vec3 _1869 = normalize(u_WorldSpaceCameraPos - v_posWS);
    vec3 _1881 = -_1869;
    vec3 _1889 = _1881 - (_1806 * (1.39999997615814208984375 * dot(_1806, _1881)));
    vec3 _t114 = _1889;
    vec2 _t118 = ((vec2(((1.0 * _t114.x) / (u_ScreenParams.x / u_ScreenParams.y)) + 0.5, (1.0 * _t114.y) + 0.5) - vec2(0.5)) * 1.2000000476837158203125) + vec2(0.5);
    vec2 param_5 = v_uv0;
    float param_6 = u_rotate;
    vec2 param_7 = u_offset;
    vec2 param_8 = u_scale;
    vec2 _1941 = _f36(param_5, param_6, param_7, param_8);
    vec2 _1942 = _t118;
    vec2 _1946 = mix(_1942, _1941, vec2(smoothstep(0.85000002384185791015625, 1.0, (dot(vec3(0.0, 0.0, 1.0), _1806) + 1.0) / 2.0)));
    _t118 = _1946;
    mediump vec4 _1962 = texture2D(u_backTex, ((_1946 - vec2(0.5)) * 0.333000004291534423828125) + vec2(0.5));
    vec2 param_9 = _1946;
    mediump vec4 _1971 = texture2D(u_inputTex, _f33(param_9));
    vec4 _2008 = mix(_1962, _1971, vec4((smoothstep(-0.4000000059604644775390625, 0.0, _t118.x) * (1.0 - smoothstep(1.0, 1.39999997615814208984375, _t118.x))) * (smoothstep(-0.4000000059604644775390625, 0.0, _t118.y) * (1.0 - smoothstep(1.0, 1.39999997615814208984375, _t118.y)))));
    vec4 _t123 = _2008;
    float _2012 = _t123.w;
    vec4 _2016 = vec4(_2008.xyz, _2012);
    _t123 = _2016;
    vec4 _t128 = _2016;
    vec3 _2021 = _2016.xyz;
    vec3 param_10 = _2021;
    _2610 *= _f6(param_10);
    _2611 *= _t128.w;
    vec3 _2613 = _1806;
    bool _2039 = u_enableNormTex > 0;
    if (_2039)
    {
        vec2 param_11 = v_uv0;
        vec2 param_12 = u_padding;
        mediump int param_13 = 0;
        _2613 = mat3(vec3(_1810), vec3(_1814), vec3(_1806)) * normalize(mix(vec3(0.0, 0.0, 1.0), normalize((_f37(u_normTex, param_11, param_12, param_13).xyz * 2.0) - vec3(1.0)), vec3(u_normInt)));
    }
    vec2 _2614 = vec2(0.0);
    vec3 _2615 = vec3(0.0);
    vec2 _2617 = vec2(1.0);
    _2614.x = u_metallic;
    _2614.y = 0.959999978542327880859375 * (1.0 - _2614.x);
    _2615.x = clamp(u_roughness, 0.039999999105930328369140625, 1.0);
    float param_14 = _2615.x;
    _2615.y = _f0(param_14);
    float param_15 = _2615.y;
    _2615.z = _f0(param_15);
    vec3 _2122 = _2610 * _2614.y;
    vec3 _2130 = mix(vec3(0.039999999105930328369140625), _2610, vec3(_2614.x));
    vec3 _2753;
    vec3 _2754;
    if (_2039)
    {
        vec3 _2154 = normalize(cross(_2613, _1814));
        _2753 = _2154;
        _2754 = normalize(cross(_2613, _2154));
    }
    else
    {
        _2753 = _1810;
        _2754 = _1814;
    }
    vec3 _2755 = _1869;
    vec3 _2182;
    if (dot(_1869, _2613) < 0.0)
    {
        _2182 = reflect(_2755, _2613);
    }
    else
    {
        _2182 = _2755;
    }
    _2755 = _2182;
    vec3 _2201 = normalize(reflect(-_2182, _2613));
    float _2621;
    vec2 _2620;
    SurfaceParams param_16 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
    WorldSpaceVectors param_17 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2182, _2201);
    _2617.y = _f17(param_16, param_17);
    bool _2221 = u_dirLightEnabled > 0.0;
    vec3 _2837;
    vec3 _2838;
    float _2839;
    float _2840;
    if (_2221)
    {
        _2837 = normalize(-u_dirLightDirection);
        _2838 = u_dirLightColor;
        _2839 = u_dirLightIntensity * u_dirLightEnabled;
        _2840 = 0.5;
    }
    bool _2241 = u_pointLightEnabled > 0.0;
    vec3 _2851;
    vec3 _2852;
    float _2853;
    float _2854;
    if (_2241)
    {
        vec3 _2249 = u_pointLightPosition - v_posWS;
        float _2252 = length(_2249);
        _2851 = _2249 / vec3(_2252);
        _2852 = u_pointLightColor;
        _2853 = u_pointLightIntensity * u_pointLightEnabled;
        float _2270 = _2252 * u_pointLightAttenRangeInv;
        float param_18 = _2270;
        float param_19 = 1.0 - _f1(param_18);
        float param_20 = _f3(param_19);
        float param_21 = _2270;
        _2854 = (_f0(param_20) * (_f0(param_21) + 1.0)) * 0.25;
    }
    bool _2288 = u_spotLightEnabled > 0.0;
    vec3 _2865;
    vec3 _2866;
    float _2867;
    float _2868;
    if (_2288)
    {
        vec3 _2296 = u_spotLightPosition - v_posWS;
        float _2299 = length(_2296);
        vec3 _2304 = _2296 / vec3(_2299);
        _2865 = _2304;
        _2866 = u_spotLightColor;
        _2867 = u_spotLightIntensity * u_spotLightEnabled;
        float _2317 = _2299 * u_spotLightAttenRangeInv;
        float param_22 = _2317;
        float param_23 = 1.0 - _f1(param_22);
        float param_24 = _f3(param_23);
        float param_25 = _2317;
        _2868 = ((_f0(param_24) * (_f0(param_25) + 1.0)) * 0.25) * smoothstep(u_spotLightOuterAngleCos, u_spotLightInnerAngleCos, max(0.0, dot(_2304, normalize(-u_spotLightDirection))));
    }
    vec3 _t143 = _2021;
    bool _2362 = u_envEnabled > 0.0;
    if (((_2362 || _2221) || _2241) || _2288)
    {
        vec3 _t147 = vec3(0.0);
        if (_2362)
        {
            SurfaceParams param_26 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
            WorldSpaceVectors param_27 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2755, _2201);
            EnvironmentParams _2833 = EnvironmentParams(u_envInt * u_envEnabled, u_envRot);
            EnvironmentParams param_28 = _2833;
            _t147 += _f24(param_26, param_27, param_28);
            SurfaceParams param_29 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
            WorldSpaceVectors param_30 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2755, _2201);
            EnvironmentParams param_31 = _2833;
            _t147 += _f23(param_29, param_30, param_31);
        }
        if (_2221)
        {
            SurfaceParams param_32 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
            WorldSpaceVectors param_33 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2755, _2201);
            LightParams param_34 = LightParams(_2837, _2838, _2839, _2840);
            _t147 += _f32(param_32, param_33, param_34);
            SurfaceParams param_35 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
            WorldSpaceVectors param_36 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2755, _2201);
            LightParams param_37 = LightParams(_2837, _2838, _2839, _2840);
            _t147 += _f28(param_35, param_36, param_37);
        }
        if (_2241)
        {
            SurfaceParams param_38 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
            WorldSpaceVectors param_39 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2755, _2201);
            LightParams param_40 = LightParams(_2851, _2852, _2853, _2854);
            _t147 += _f31(param_38, param_39, param_40);
            SurfaceParams param_41 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
            WorldSpaceVectors param_42 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2755, _2201);
            LightParams param_43 = LightParams(_2851, _2852, _2853, _2854);
            _t147 += _f30(param_41, param_42, param_43);
        }
        if (_2288)
        {
            SurfaceParams param_44 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
            WorldSpaceVectors param_45 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2755, _2201);
            LightParams param_46 = LightParams(_2865, _2866, _2867, _2868);
            _t147 += _f31(param_44, param_45, param_46);
            SurfaceParams param_47 = SurfaceParams(_2610, _2611, 0.0, _2613, _2614, _2615, vec3(0.0), _2617, _2122, _2130, _2620, _2621);
            WorldSpaceVectors param_48 = WorldSpaceVectors(v_posWS, _2613, _1806, _2753, _2754, _2755, _2201);
            LightParams param_49 = LightParams(_2865, _2866, _2867, _2868);
            _t147 += _f30(param_47, param_48, param_49);
        }
        if (u_enableToneMapping > 0)
        {
            if (u_toneMappingType == 0)
            {
                vec3 param_50 = _t147;
                _t147 = _f8(param_50);
            }
            else
            {
                if (u_toneMappingType == 1)
                {
                    vec3 param_51 = _t147;
                    _t147 = _f11(param_51);
                }
                else
                {
                    if (u_toneMappingType == 2)
                    {
                        vec3 param_52 = _t147;
                        vec3 _2492 = _f12(param_52);
                        _t147 = _2492;
                    }
                    else
                    {
                        if (u_toneMappingType == 3)
                        {
                            vec3 param_53 = _t147;
                            _t147 = _f10(param_53);
                        }
                        else
                        {
                            if (u_toneMappingType == 4)
                            {
                                vec3 param_54 = _t147;
                                _t147 = _f9(param_54);
                            }
                            else
                            {
                                if (u_toneMappingType == 5)
                                {
                                    vec3 param_55 = _t147;
                                    _t147 = _f14(param_55);
                                }
                                else
                                {
                                    if (u_toneMappingType == 6)
                                    {
                                        vec3 param_56 = _t147;
                                        _t147 = _f15(param_56);
                                    }
                                    else
                                    {
                                        if (u_toneMappingType == 7)
                                        {
                                            vec3 param_57 = _t147;
                                            _t147 = _f16(param_57);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        vec3 param_58 = _t147;
        vec3 _2535 = _f7(param_58);
        _t147 = _2535;
        _t143 = mix(_t143, _2535, vec3(u_lightingBlend));
    }
    vec4 _2549 = vec4(_t143, _2611);
    vec4 _t148 = _2549;
    float _2573 = _t148.w;
    vec4 _2577 = vec4(_2549.xyz + (u_hightLightColor * (smoothstep(0.5, 0.75, clamp(pow(max(abs(dot(_1889, vec3(1.0, 0.0, 0.0))), 0.0), 5.0) * 5.0, 0.0, 1.0)) * 0.5)), _2573);
    _t148 = _2577;
    gl_FragData[0] = _2577;
}

