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
    float normalW;
    float normalH;
    float dustNum;
    float dustSize;
    float4 u_ScreenParams;
    float mask_line_rot;
    float distorIns;
    float noiseFeather;
    float progress;
    float4 u_StartRot_Row1;
    float4 u_StartRot_Row2;
    float4 u_StartRot_Row3;
    float4 u_EndRot_Row1;
    float4 u_EndRot_Row2;
    float4 u_EndRot_Row3;
    float startMoveX;
    float startMoveY;
    float startMoveZ;
    float endMoveX;
    float endMoveY;
    float endMoveZ;
    float startSize;
    float endSize;
    float4x4 u_MVP;
};

struct main0_out
{
    float2 testUV [[user(locn0)]];
    float2 dustUV [[user(locn1)]];
    float2 rectUV [[user(locn2)]];
    float2 sprite_uv [[user(locn3)]];
    float4 particleColor [[user(locn4)]];
    float particleOpacity [[user(locn5)]];
    float particleProgress [[user(locn6)]];
    float4 gl_Position [[position]];
    float gl_PointSize [[point_size]];
};

struct main0_in
{
    float3 attPosition [[attribute(0)]];
    float2 attUV [[attribute(2)]];
};

static inline __attribute__((always_inline))
float2x2 _f0(thread const float& _p0)
{
    float _22 = cos(_p0);
    float _25 = sin(_p0);
    return float2x2(float2(_22, -_25), float2(_25, _22));
}

static inline __attribute__((always_inline))
float2 _f1(thread const float4& _p0)
{
    return float2(_p0.x + (_p0.y / 255.0), _p0.z + (_p0.w / 255.0));
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputTex [[texture(0)]], texture2d<float> noiseTex [[texture(1)]], sampler inputTexSmplr [[sampler(0)]], sampler noiseTexSmplr [[sampler(1)]], uint gl_InstanceID [[instance_id]])
{
    main0_out out = {};
    float _71 = float(gl_InstanceID);
    out.sprite_uv = in.attUV;
    float2 _88 = floor(float2(buffer.normalW, buffer.normalH) * buffer.dustNum);
    float2 _t6 = _88;
    float2 _112 = float2((floor(_71 / _t6.y) + 0.5) / _t6.x, (mod(_71, _t6.y) + 0.5) / _t6.y);
    out.dustUV = _112;
    out.rectUV = float2(buffer.dustSize) / _88;
    float _128 = buffer.u_ScreenParams.y / buffer.u_ScreenParams.x;
    out.particleColor = inputTex.sample(inputTexSmplr, _112, level(4.0));
    if (out.particleColor.w < 0.00999999977648258209228515625)
    {
        out.gl_Position = float4(20.0, 20.0, 20.0, 1.0);
        out.gl_PointSize = 1.0;
        out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
        return out;
    }
    float param = buffer.mask_line_rot;
    float2 _t14 = ((_112 - float2(0.5)) * _f0(param)) + float2(0.5);
    float4 param_1 = noiseTex.sample(noiseTexSmplr, (_112 * float2(1.0 / fast::max(1.0, _128), 1.0 / fast::max(1.0, 1.0 / _128))), level(4.0));
    float2 _t18 = _f1(param_1);
    float2 _211 = buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y));
    float2 _t19 = _211;
    float _249 = buffer.progress * (1.0 + buffer.noiseFeather);
    float _257 = smoothstep((-buffer.noiseFeather) + _249, 0.0 + _249, ((_t14.x - 0.5) / (1.41421353816986083984375 * cos(0.7853000164031982421875 - (abs(mod((buffer.mask_line_rot / 0.7853000164031982421875) + 1.0, 2.0) - 1.0) * 0.7853000164031982421875)))) + 0.5);
    float _260 = 1.0 - _257;
    float _265 = (((_t18.x - 0.5) / _t19.x) * buffer.distorIns) * pow(_260, 0.89999997615814208984375);
    float _270 = (((_t18.y - 0.5) / _t19.y) * buffer.distorIns) * pow(_260, 1.10000002384185791015625);
    out.particleOpacity = pow(_257, 0.25);
    out.particleColor.w *= out.particleOpacity;
    if (out.particleColor.w < 0.00999999977648258209228515625)
    {
        out.gl_Position = float4(20.0, 20.0, 20.0, 1.0);
        out.gl_PointSize = 1.0;
        out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
        return out;
    }
    float3 _299 = float3((_112 * 2.0) - float2(1.0), 0.0) - float3(0.0);
    float3 _t26 = _299;
    float2 _303 = _299.xy * _211;
    _t26.x = _303.x;
    _t26.y = _303.y;
    float3 _362 = float3(_260);
    float3 _412 = mix(float3(buffer.startMoveX, buffer.startMoveY, buffer.startMoveZ), float3(buffer.endMoveX, buffer.endMoveY, buffer.endMoveZ), _362);
    float3 _t31 = _412;
    float2 _426 = _412.xy * _211;
    _t31.x = _426.x;
    _t31.y = _426.y;
    float3 _t30 = ((float3x3(float3(mix(buffer.u_StartRot_Row1.xyz, buffer.u_EndRot_Row1.xyz, _362)), float3(mix(buffer.u_StartRot_Row2.xyz, buffer.u_EndRot_Row2.xyz, _362)), float3(mix(buffer.u_StartRot_Row3.xyz, buffer.u_EndRot_Row3.xyz, _362))) * _t26) * mix(buffer.startSize, buffer.endSize, _260)) + _t31;
    _t30.z *= 0.300000011920928955078125;
    _t26 = _t30;
    float2 _443 = _t30.xy / _211;
    _t26.x = _443.x;
    _t26.y = _443.y;
    float3 _449 = _t26;
    float3 _461 = (_449 + float3(0.0)) + float3(_265, _270, fast::clamp((_265 + _270) * 0.00999999977648258209228515625, -1.0, 1.0));
    _t26 = _461;
    float4 _t33 = buffer.u_MVP * float4((in.attPosition.xy * out.rectUV) + _461.xy, _t26.z, 1.0);
    _t33.x *= (buffer.u_ScreenParams.x / buffer.u_ScreenParams.y);
    out.gl_Position = _t33;
    out.testUV = in.attUV;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

