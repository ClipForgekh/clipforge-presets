#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_gridVerticalNumber;
    float u_instanceNumber;
    float u_gridVerticalSize;
    float u_gridHorizontalSize;
    float u_invertGridFlag;
    float u_gridFlag;
    float u_AAFlag;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
    float gl_FragDepth [[depth(any)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
    float4 screenPos [[user(locn1)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _19 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float _26 = 1.0 / buffer.u_gridVerticalNumber;
    float _30 = 1.0 / buffer.u_instanceNumber;
    float _110 = mix(smoothstep(0.0, 0.00200000009499490261077880859375, ((0.5 * _26) * buffer.u_gridVerticalSize) - abs(((floor(in.v_uv.y / _26) + 0.5) * _26) - in.v_uv.y)) * step(0.00200000009499490261077880859375 * buffer.u_gridVerticalNumber, buffer.u_gridVerticalSize), 1.0, step(1.0 - (9.9999997473787516355514526367188e-05 * buffer.u_gridVerticalNumber), buffer.u_gridVerticalSize)) * mix(smoothstep(0.0, 0.00200000009499490261077880859375, ((0.5 * _30) * buffer.u_gridHorizontalSize) - abs(((floor(in.v_uv.x / _30) + 0.5) * _30) - in.v_uv.x)) * step(0.00200000009499490261077880859375 * buffer.u_instanceNumber, buffer.u_gridHorizontalSize), 1.0, step(1.0 - (9.9999997473787516355514526367188e-05 * buffer.u_instanceNumber), buffer.u_gridHorizontalSize));
    float4 _126 = mix(_19, _19 * mix(_110, 1.0 - _110, buffer.u_invertGridFlag), float4(buffer.u_gridFlag));
    float4 _147 = (((_126 * smoothstep(0.0, 0.004999999888241291046142578125, in.v_uv.y)) * smoothstep(1.0, 0.99500000476837158203125, in.v_uv.y)) * smoothstep(0.0, 0.004999999888241291046142578125, in.v_uv.x)) * smoothstep(1.0, 0.99500000476837158203125, in.v_uv.x);
    float4 _t8 = _147;
    out.o_fragColor = mix(_126, _147, float4(buffer.u_AAFlag));
    out.gl_FragDepth = mix(1.0, in.screenPos.z * 0.00999999977648258209228515625, _t8.w);
    return out;
}

