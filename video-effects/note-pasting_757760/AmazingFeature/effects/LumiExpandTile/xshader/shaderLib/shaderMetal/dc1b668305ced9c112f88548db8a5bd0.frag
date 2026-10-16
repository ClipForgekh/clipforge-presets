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
    float expandLeft;
    float expandRight;
    float expandUp;
    float expandDown;
    float runningMode;
    float expandMode;
    float blendBorders;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float2 _f1(thread float2& _p0, constant float& expandLeft, constant float& expandRight, constant float& expandUp, constant float& expandDown)
{
    _p0.x = (_p0.x + expandLeft) / ((1.0 + expandLeft) + expandRight);
    _p0.y = (_p0.y + expandDown) / ((1.0 + expandUp) + expandDown);
    return _p0;
}

static inline __attribute__((always_inline))
float2 _f0(thread float2& _p0, constant float& expandLeft, constant float& expandRight, constant float& expandUp, constant float& expandDown)
{
    _p0.x = (_p0.x * ((1.0 + expandLeft) + expandRight)) - expandLeft;
    _p0.y = (_p0.y * ((1.0 + expandUp) + expandDown)) - expandDown;
    return _p0;
}

static inline __attribute__((always_inline))
float _f2(thread const float& _p0)
{
    float _90 = mod(_p0, 2.0);
    float _97 = _90 + ((1.0 - step(0.0, _90)) * 2.0);
    float _99 = step(_97, 1.0);
    return ((1.0 - _99) * (2.0 - _97)) + (_99 * _97);
}

static inline __attribute__((always_inline))
float _f3(thread const float& _p0)
{
    float _114 = mod(_p0, 1.0);
    return _114 + (1.0 - step(0.0, _114));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    if (buffer.runningMode > 1.5)
    {
        float2 param = in.uv0;
        float2 _135 = _f1(param, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
        out.o_fragColor = inputImageTexture.sample(inputImageTextureSmplr, _135);
        return out;
    }
    if (buffer.expandMode < 0.5)
    {
        float2 param_1 = in.uv0;
        float2 _156 = _f0(param_1, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
        float2 _t7 = _156;
        if (buffer.runningMode < 0.5)
        {
            float2 param_2 = _t7;
            float2 _163 = _f1(param_2, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
            _t7 = _163;
        }
        out.o_fragColor = inputImageTexture.sample(inputImageTextureSmplr, _t7);
        return out;
    }
    else
    {
        if (buffer.expandMode < 1.5)
        {
            float2 param_3 = in.uv0;
            float2 _176 = _f0(param_3, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
            float2 _t9 = _176;
            float param_4 = _t9.x;
            _t9.x = _f2(param_4);
            float param_5 = _t9.y;
            _t9.y = _f2(param_5);
            if (buffer.runningMode < 0.5)
            {
                float2 param_6 = _t9;
                float2 _195 = _f1(param_6, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
                _t9 = _195;
            }
            out.o_fragColor = inputImageTexture.sample(inputImageTextureSmplr, _t9);
            return out;
        }
        else
        {
            if (buffer.expandMode < 2.5)
            {
                float2 param_7 = in.uv0;
                float2 _209 = _f0(param_7, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
                float2 _t10 = _209;
                float2 _t11 = _209;
                float param_8 = _t11.x;
                _t11.x = _f3(param_8);
                float param_9 = _t11.y;
                _t11.y = _f3(param_9);
                float2 _t12 = _t11;
                _t12.x = 1.0 - _t12.x;
                float2 _t13 = _t11;
                _t13.y = 1.0 - _t13.y;
                float2 _t14 = _t11;
                _t14.x = 1.0 - _t14.x;
                _t14.y = 1.0 - _t14.y;
                if (buffer.runningMode < 0.5)
                {
                    float2 param_10 = _t11;
                    float2 _250 = _f1(param_10, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
                    _t11 = _250;
                    float2 param_11 = _t12;
                    float2 _253 = _f1(param_11, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
                    _t12 = _253;
                    float2 param_12 = _t13;
                    float2 _256 = _f1(param_12, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
                    _t13 = _256;
                    float2 param_13 = _t14;
                    float2 _259 = _f1(param_13, buffer.expandLeft, buffer.expandRight, buffer.expandUp, buffer.expandDown);
                    _t14 = _259;
                }
                float4 _t15 = inputImageTexture.sample(inputImageTextureSmplr, _t11);
                float4 _t17 = inputImageTexture.sample(inputImageTextureSmplr, _t13);
                float _281 = buffer.blendBorders * 0.4000000059604644775390625;
                float _282 = 1.0 - _281;
                float _286 = 1.10000002384185791015625 - _281;
                float param_14 = _t10.x;
                float4 _299 = float4(smoothstep(_282, _286, abs(0.5 - _f2(param_14)) * 2.0) * 0.5);
                _t15 = mix(_t15, inputImageTexture.sample(inputImageTextureSmplr, _t12), _299);
                _t17 = mix(_t17, inputImageTexture.sample(inputImageTextureSmplr, _t14), _299);
                float param_15 = _t10.y;
                float4 _322 = _t15;
                float4 _327 = mix(_322, _t17, float4(smoothstep(_282, _286, abs(0.5 - _f2(param_15)) * 2.0) * 0.5));
                _t15 = _327;
                out.o_fragColor = _327;
                return out;
            }
        }
    }
    out.o_fragColor = inputImageTexture.sample(inputImageTextureSmplr, in.uv0);
    return out;
}

