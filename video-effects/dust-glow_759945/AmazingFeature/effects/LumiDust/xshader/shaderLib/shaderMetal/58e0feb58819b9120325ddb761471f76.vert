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
float2x2 _f1(thread const float& _p0)
{
    float _48 = cos(_p0);
    float _51 = sin(_p0);
    return float2x2(float2(_48, -_51), float2(_51, _48));
}

static inline __attribute__((always_inline))
float2 _f2(thread const float4& _p0)
{
    return float2(_p0.x + (_p0.y / 255.0), _p0.z + (_p0.w / 255.0));
}

static inline __attribute__((always_inline))
float _f0(thread const float3& _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputTex [[texture(0)]], texture2d<float> noiseTex [[texture(1)]], texture2d<float> mask_image [[texture(2)]], sampler inputTexSmplr [[sampler(0)]], sampler noiseTexSmplr [[sampler(1)]], sampler mask_imageSmplr [[sampler(2)]], uint gl_InstanceID [[instance_id]])
{
    main0_out out = {};
    float _93 = float(gl_InstanceID);
    out.sprite_uv = in.attUV;
    float2 _110 = floor(float2(buffer.normalW, buffer.normalH) * buffer.dustNum);
    float2 _t6 = _110;
    float2 _134 = float2((floor(_93 / _t6.y) + 0.5) / _t6.x, (mod(_93, _t6.y) + 0.5) / _t6.y);
    out.dustUV = _134;
    out.rectUV = float2(buffer.dustSize) / _110;
    float _150 = buffer.u_ScreenParams.y / buffer.u_ScreenParams.x;
    out.particleColor = inputTex.sample(inputTexSmplr, _134, level(4.0));
    if (out.particleColor.w < 0.00999999977648258209228515625)
    {
        out.gl_Position = float4(20.0, 20.0, 20.0, 1.0);
        out.gl_PointSize = 1.0;
        out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
        return out;
    }
    float param = buffer.mask_line_rot;
    float4 param_1 = noiseTex.sample(noiseTexSmplr, (_134 * float2(1.0 / fast::max(1.0, _150), 1.0 / fast::max(1.0, 1.0 / _150))), level(4.0));
    float2 _t18 = _f2(param_1);
    float2 _233 = buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y));
    float2 _t19 = _233;
    float _t20 = ((_t18.x - 0.5) / _t19.x) * buffer.distorIns;
    float _t21 = ((_t18.y - 0.5) / _t19.y) * buffer.distorIns;
    float3 param_2 = mask_image.sample(mask_imageSmplr, _134, level(4.0)).xyz;
    float _274 = buffer.progress * (1.0 + buffer.noiseFeather);
    float _282 = smoothstep((-buffer.noiseFeather) + _274, 0.0 + _274, _f0(param_2));
    float _285 = 1.0 - _282;
    _t20 *= pow(_285, 0.89999997615814208984375);
    _t21 *= pow(_285, 1.10000002384185791015625);
    out.particleOpacity = pow(_282, 0.25);
    out.particleColor.w *= out.particleOpacity;
    if (out.particleColor.w < 0.00999999977648258209228515625)
    {
        out.gl_Position = float4(20.0, 20.0, 20.0, 1.0);
        out.gl_PointSize = 1.0;
        out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
        return out;
    }
    float3 _322 = float3((_134 * 2.0) - float2(1.0), 0.0) - float3(0.0);
    float3 _t27 = _322;
    float2 _326 = _322.xy * _233;
    _t27.x = _326.x;
    _t27.y = _326.y;
    float3 _385 = float3(_285);
    float3 _435 = mix(float3(buffer.startMoveX, buffer.startMoveY, buffer.startMoveZ), float3(buffer.endMoveX, buffer.endMoveY, buffer.endMoveZ), _385);
    float3 _t32 = _435;
    float2 _449 = _435.xy * _233;
    _t32.x = _449.x;
    _t32.y = _449.y;
    float3 _t31 = ((float3x3(float3(mix(buffer.u_StartRot_Row1.xyz, buffer.u_EndRot_Row1.xyz, _385)), float3(mix(buffer.u_StartRot_Row2.xyz, buffer.u_EndRot_Row2.xyz, _385)), float3(mix(buffer.u_StartRot_Row3.xyz, buffer.u_EndRot_Row3.xyz, _385))) * _t27) * mix(buffer.startSize, buffer.endSize, _285)) + _t32;
    _t31.z *= 0.300000011920928955078125;
    _t27 = _t31;
    float2 _466 = _t31.xy / _233;
    _t27.x = _466.x;
    _t27.y = _466.y;
    float3 _472 = _t27;
    float3 _484 = (_472 + float3(0.0)) + float3(_t20, _t21, fast::clamp((_t20 + _t21) * 0.00999999977648258209228515625, -1.0, 1.0));
    _t27 = _484;
    float4 _t34 = buffer.u_MVP * float4((in.attPosition.xy * out.rectUV) + _484.xy, _t27.z, 1.0);
    _t34.x *= (buffer.u_ScreenParams.x / buffer.u_ScreenParams.y);
    out.gl_Position = _t34;
    out.testUV = in.attUV;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

