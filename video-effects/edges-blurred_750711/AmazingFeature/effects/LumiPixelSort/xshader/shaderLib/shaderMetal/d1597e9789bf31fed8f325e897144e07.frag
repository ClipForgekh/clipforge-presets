#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float rotate;
    float outputType;
    float reverseSort;
    float cycle;
    float blurSize;
    float featherStart;
    float featherEnd;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float2 _f0(thread float2& _p0, thread const float& _p1)
{
    float _17 = sin(_p1);
    float _20 = cos(_p1);
    _p0 -= float2(0.5);
    _p0 = float2x2(float2(_20, _17), float2(-_17, _20)) * _p0;
    _p0 += float2(0.5);
    return _p0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> infoTexture [[texture(0)]], texture2d<float> maskTexture [[texture(1)]], texture2d<float> inputImageTexture [[texture(2)]], texture2d<float> scaleTexture [[texture(3)]], sampler infoTextureSmplr [[sampler(0)]], sampler maskTextureSmplr [[sampler(1)]], sampler inputImageTextureSmplr [[sampler(2)]], sampler scaleTextureSmplr [[sampler(3)]])
{
    main0_out out = {};
    float _54 = (buffer.rotate * 3.141592502593994140625) / 180.0;
    float2 param = in.v_uv;
    float param_1 = -_54;
    float2 _63 = _f0(param, param_1);
    float _69 = abs(cos(_54));
    float _72 = abs(sin(_54));
    float2 _103 = ((_63 - float2(0.5)) / float2(fast::max(_69 + _72, _72 + _69) * 1.0099999904632568359375)) + float2(0.5);
    float4 _t7 = infoTexture.sample(infoTextureSmplr, _103);
    float _t8 = _t7.x / (_t7.x + _t7.y);
    float _t9 = _t7.y / (_t7.x + _t7.y);
    float _t10 = maskTexture.sample(maskTextureSmplr, _103).x;
    float4 _145 = inputImageTexture.sample(inputImageTextureSmplr, (((in.v_uv - float2(0.5)) / float2(1.0099999904632568359375)) + float2(0.5)));
    float4 _t11 = _145;
    float4 _t12 = scaleTexture.sample(scaleTextureSmplr, _103);
    if ((buffer.outputType > 0.5) && (buffer.outputType <= 1.5))
    {
        out.o_fragColor = float4(_t10, _t10, _t10, _t11.w);
        return out;
    }
    if ((buffer.outputType > 1.5) && (buffer.outputType <= 2.5))
    {
        float _183 = _t7.x * 255.0;
        float _187 = _t7.y * 255.0;
        float _t15 = _183;
        if (buffer.reverseSort > 0.5)
        {
            _t15 = _187;
        }
        float _196 = _t15;
        float _201 = floor((_183 + _187) + 1.0);
        float _212 = mod(_196 + (_201 * mod(buffer.cycle, 1.0)), _201);
        _t15 = _212;
        out.o_fragColor = float4(_212 / _201);
        out.o_fragColor.w = _t11.w;
        return out;
    }
    if (buffer.blurSize > 1.0)
    {
        float _t16 = 1.0;
        for (float _t17 = 1.0; _t17 < 50.0; _t17 += 1.0)
        {
            if (_t17 > buffer.blurSize)
            {
                break;
            }
            float4 _255 = maskTexture.sample(maskTextureSmplr, (_103 + (float2(0.00390625, 0.0) * _t17)));
            float _256 = _255.x;
            if (_256 < 0.5)
            {
                break;
            }
            _t12 += (scaleTexture.sample(scaleTextureSmplr, (_103 + (float2(0.00390625, 0.0) * _t17))) * _256);
            _t16 += _256;
        }
        for (float _t19 = 1.0; _t19 < 50.0; _t19 += 1.0)
        {
            if (_t19 > buffer.blurSize)
            {
                break;
            }
            float4 _297 = maskTexture.sample(maskTextureSmplr, (_103 - (float2(0.00390625, 0.0) * _t19)));
            float _298 = _297.x;
            if (_298 < 0.5)
            {
                break;
            }
            _t12 += (scaleTexture.sample(scaleTextureSmplr, (_103 - (float2(0.00390625, 0.0) * _t19))) * _298);
            _t16 += _298;
        }
        _t12 /= float4(_t16);
    }
    float _327;
    if (buffer.featherStart < 0.00999999977648258209228515625)
    {
        _327 = 1.0;
    }
    else
    {
        _327 = smoothstep(0.0, buffer.featherStart, _t8);
    }
    _t8 = _327;
    float _338;
    if (buffer.featherEnd < 0.00999999977648258209228515625)
    {
        _338 = 1.0;
    }
    else
    {
        _338 = smoothstep(0.0, buffer.featherEnd, _t9);
    }
    _t9 = _338;
    float _349 = _t10;
    float _350 = _349 * fast::min(_t8, _338);
    _t10 = _350;
    out.o_fragColor = mix(_145, _t12, float4(_350));
    return out;
}

