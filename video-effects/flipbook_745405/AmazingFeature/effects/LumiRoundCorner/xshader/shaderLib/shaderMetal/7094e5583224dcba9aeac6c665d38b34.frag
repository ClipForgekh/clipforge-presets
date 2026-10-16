#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_radius;
    float u_fade0;
    float u_fade1;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_p [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _16 = buffer.u_ScreenParams.xy * 0.5;
    float2 _35 = ((((in.v_p / buffer.u_ScreenParams.xy) - float2(0.5)) * 1.019999980926513671875) + float2(0.5)) * buffer.u_ScreenParams.xy;
    float2 _47 = abs(_35 - _16) - (_16 - float2(buffer.u_radius));
    float2 _t2 = _47;
    out.o_fragColor = u_inputTexture.sample(u_inputTextureSmplr, (_35 / buffer.u_ScreenParams.xy)) * smoothstep(buffer.u_fade0, buffer.u_fade1, -((length(fast::max(_47, float2(0.0))) + fast::min(fast::max(_t2.x, _t2.y), 0.0)) - buffer.u_radius));
    float _92 = out.o_fragColor.w;
    float4 _96 = out.o_fragColor;
    float3 _99 = _96.xyz / float3(fast::max(_92, 9.9999997473787516355514526367188e-06));
    out.o_fragColor.x = _99.x;
    out.o_fragColor.y = _99.y;
    out.o_fragColor.z = _99.z;
    return out;
}

