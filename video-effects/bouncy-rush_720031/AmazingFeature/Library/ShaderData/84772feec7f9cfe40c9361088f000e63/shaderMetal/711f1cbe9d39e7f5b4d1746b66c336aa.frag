#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv_0 [[user(v_uv_0)]];
    float2 v_uv_1 [[user(v_uv_1)]];
    float2 v_uv_2 [[user(v_uv_2)]];
    float2 v_uv_3 [[user(v_uv_3)]];
    float2 v_uv_4 [[user(v_uv_4)]];
    float2 v_uv_5 [[user(v_uv_5)]];
    float2 v_uv_6 [[user(v_uv_6)]];
    float2 v_uv_7 [[user(v_uv_7)]];
    float2 v_uv_8 [[user(v_uv_8)]];
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_src [[texture(0)]], sampler u_srcSmplr [[sampler(0)]])
{
    main0_out out = {};
    spvUnsafeArray<float2, 9> v_uv = {};
    v_uv[0] = in.v_uv_0;
    v_uv[1] = in.v_uv_1;
    v_uv[2] = in.v_uv_2;
    v_uv[3] = in.v_uv_3;
    v_uv[4] = in.v_uv_4;
    v_uv[5] = in.v_uv_5;
    v_uv[6] = in.v_uv_6;
    v_uv[7] = in.v_uv_7;
    v_uv[8] = in.v_uv_8;
    float4 _77;
    _77 = u_src.sample(u_srcSmplr, v_uv[0]) * 0.1335709989070892333984375;
    for (int _76 = 0; _76 < 4; )
    {
        int _43 = _76 * 2;
        float _55 = float4(0.23330800235271453857421875, 0.1359280049800872802734375, 0.0513829998672008514404296875, 0.01259499974548816680908203125)[_76];
        _77 = (_77 + (u_src.sample(u_srcSmplr, v_uv[_43 + 1]) * _55)) + (u_src.sample(u_srcSmplr, v_uv[_43 + 2]) * _55);
        _76++;
        continue;
    }
    out.gl_FragColor = _77;
    return out;
}

