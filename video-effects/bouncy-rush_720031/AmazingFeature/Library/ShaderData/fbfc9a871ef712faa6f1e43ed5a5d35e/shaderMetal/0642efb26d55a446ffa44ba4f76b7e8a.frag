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

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(v_uv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_base [[texture(0)]], sampler u_baseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _53 = mod(in.v_uv, float2(2.0));
    out.gl_FragColor = u_base.sample(u_baseSmplr, fract(mix(_53, float2(2.0) - _53, step(float2(1.0), _53))));
    return out;
}

