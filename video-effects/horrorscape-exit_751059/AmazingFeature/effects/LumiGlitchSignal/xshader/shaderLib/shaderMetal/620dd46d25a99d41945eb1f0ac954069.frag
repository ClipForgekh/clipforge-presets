#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float d2dIntensity;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> blurImageTexture [[texture(1)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler blurImageTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _t1 = float2(1.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float4 _t2 = float4(0.0);
    float4 _t3 = float4(0.0);
    float4 _t4 = float4(0.0);
    float _46 = fast::min(5.0, buffer.d2dIntensity * 2.0);
    float _t6 = 0.0;
    for (float _t7 = 0.0; _t7 <= 10.0; _t7 += 1.0)
    {
        float _60 = 10.0 - _t7;
        float _70 = fast::min((_t1.x * _46) * 1.0, 2.0 * _t1.x);
        _t2.x += (_60 * inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(((_t7 * _t1.x) * _46) + _70, 0.0))).x);
        float4 _111 = _t2;
        float2 _113 = _111.yw + (inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2((_t7 * _t1.x) * _46, 0.0))).yw * _60);
        _t2.y = _113.x;
        _t2.w = _113.y;
        _t2.z += (_60 * inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(((_t7 * _t1.x) * _46) - _70, 0.0))).z);
        _t3.x += (_60 * blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(((_t7 * _t1.x) * _46) + _70, 0.0))).x);
        float4 _175 = _t3;
        float2 _177 = _175.yw + (blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2((_t7 * _t1.x) * _46, 0.0))).yw * _60);
        _t3.y = _177.x;
        _t3.w = _177.y;
        _t3.z += (_60 * blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(((_t7 * _t1.x) * _46) - _70, 0.0))).z);
        _t6 += _60;
    }
    float4 _208 = _t2;
    float4 _209 = float4(_t6);
    float4 _210 = _208 / _209;
    _t2 = _210;
    float4 _212 = _t3;
    float4 _214 = _212 / _209;
    _t3 = _214;
    float _217 = step(buffer.d2dIntensity, 2.0);
    float4 _239 = _t4;
    float4 _240 = _239 + (_210 + ((_210 - _214) * (((_217 * buffer.d2dIntensity) * 10.0) + ((1.0 - _217) * (20.0 + (50.0 * (buffer.d2dIntensity - 2.0)))))));
    _t4 = _240;
    float _245 = _t4.w;
    float3 _248 = fast::clamp(_240.xyz, float3(0.0), float3(_245));
    _t4.x = _248.x;
    _t4.y = _248.y;
    _t4.z = _248.z;
    out.o_fragColor = _t4;
    return out;
}

