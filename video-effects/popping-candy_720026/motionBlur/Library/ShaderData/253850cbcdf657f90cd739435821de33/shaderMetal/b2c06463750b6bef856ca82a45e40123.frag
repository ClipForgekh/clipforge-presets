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
    float4 u_ScreenParams;
    float noiseX;
    float noiseY;
    float noiseX2;
    float noiseY2;
    float imgMove;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv [[user(uv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> _MainTex [[texture(0)]], texture2d<float> inputImageTexture [[texture(1)]], sampler _MainTexSmplr [[sampler(0)]], sampler inputImageTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _90 = float2(buffer.u_ScreenParams.xy);
    float _272;
    if ((buffer.u_ScreenParams.y / buffer.u_ScreenParams.x) >= 1.0)
    {
        _272 = buffer.u_ScreenParams.y * 0.00185185181908309459686279296875;
    }
    else
    {
        _272 = buffer.u_ScreenParams.x * 0.00185185181908309459686279296875;
    }
    float2 _139 = (fma(in.uv, _90, -(_90 * 0.5)) / (float2(540.0) * _272)) + float2(0.5);
    float2 _268 = _139;
    _268.y = 1.0 - _139.y;
    float2 _175 = (buffer.u_ScreenParams.xy * 1080.0) / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y));
    float2 _181 = float2(buffer.noiseX, buffer.noiseY);
    float2 _216 = (in.uv - (((mix(_181, _181 + float2(buffer.noiseX2, buffer.noiseY2), float2(smoothstep(0.3499999940395355224609375, 0.5, length(in.uv - float2(0.5))))) / _175) * (_MainTex.sample(_MainTexSmplr, _268).x - 0.5)) * 2.0)) + (float2(0.0, buffer.imgMove) / _175);
    out.gl_FragColor = inputImageTexture.sample(inputImageTextureSmplr, float2(abs(mod(_216.x - 1.0, 2.0) - 1.0), abs(mod(_216.y - 1.0, 2.0) - 1.0)));
    return out;
}

