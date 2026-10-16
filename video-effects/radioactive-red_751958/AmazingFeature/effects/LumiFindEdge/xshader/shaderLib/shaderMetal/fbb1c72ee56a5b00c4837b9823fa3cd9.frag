#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float grayColor;
    float lowerLimit;
    float upperLimit;
    float brightness;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t1 = float2(1.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float4 _55 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2((-1.0) * _t1.x, (-1.0) * _t1.y)));
    float4 _70 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2((-1.0) * _t1.x, 0.0 * _t1.y)));
    float4 _84 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2((-1.0) * _t1.x, 1.0 * _t1.y)));
    float4 _98 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(1.0 * _t1.x, (-1.0) * _t1.y)));
    float4 _113 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(1.0 * _t1.x, 0.0 * _t1.y)));
    float4 _127 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(1.0 * _t1.x, 1.0 * _t1.y)));
    float4 _130 = (((((float4(0.0) + (_55 * (-1.0))) + (_70 * (-2.0))) + (_84 * (-1.0))) + (_98 * 1.0)) + (_113 * 2.0)) + (_127 * 1.0);
    float4 _t2 = _130;
    float4 _142 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2((-1.0) * _t1.x, (-1.0) * _t1.y)));
    float4 _156 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(0.0 * _t1.x, (-1.0) * _t1.y)));
    float4 _170 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(1.0 * _t1.x, (-1.0) * _t1.y)));
    float4 _184 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2((-1.0) * _t1.x, 1.0 * _t1.y)));
    float4 _198 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(0.0 * _t1.x, 1.0 * _t1.y)));
    float4 _212 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(1.0 * _t1.x, 1.0 * _t1.y)));
    float4 _215 = (((((float4(0.0) + (_142 * (-1.0))) + (_156 * (-2.0))) + (_170 * (-1.0))) + (_184 * 1.0)) + (_198 * 2.0)) + (_212 * 1.0);
    float4 _t3 = _215;
    float4 _t4 = float4(0.0);
    if (buffer.grayColor > 0.5)
    {
        float _237 = ((0.333000004291534423828125 * _t2.x) + (0.333000004291534423828125 * _t2.y)) + (0.333000004291534423828125 * _t2.z);
        float _249 = ((0.333000004291534423828125 * _t3.x) + (0.333000004291534423828125 * _t3.y)) + (0.333000004291534423828125 * _t3.z);
        _t4 = float4((_237 * _237) + (_249 * _249));
    }
    else
    {
        _t4 = (_130 * _130) + (_215 * _215);
    }
    _t4 = smoothstep(float4(buffer.lowerLimit), float4(buffer.upperLimit), _t4 * buffer.brightness);
    _t4.w = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv).w;
    out.o_fragColor = _t4;
    return out;
}

