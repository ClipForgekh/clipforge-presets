#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uTrailStrength;
    float uBlurStrength;
    float3 uColor;
    float uBrightness;
    float uOpacity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

static inline __attribute__((always_inline))
float polygonMask(thread const float2& p, thread const float& sides, thread const float& radius)
{
    float angle = precise::atan2(p.x, p.y) + 3.1415927410125732421875;
    float slice = 6.283185482025146484375 / sides;
    return (cos((floor(0.5 + (angle / slice)) * slice) - angle) * length(p)) - radius;
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(234.339996337890625, 435.345001220703125));
    p += float2(dot(p, p + float2(34.229999542236328125)));
    return fract(p.x * p.y);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float2 p = in.vUv - float2(0.5);
    float stretch = 1.0 + (buffer.uTrailStrength * 1.35000002384185791015625);
    float2 crystalP = float2(p.x * 0.85000002384185791015625, p.y * stretch);
    float2 param = crystalP;
    float param_1 = 6.0;
    float param_2 = 0.36000001430511474609375;
    float outer = polygonMask(param, param_1, param_2);
    float2 param_3 = crystalP * float2(1.5499999523162841796875, 0.75);
    float param_4 = 4.0;
    float param_5 = 0.20999999344348907470703125;
    float inner = polygonMask(param_3, param_4, param_5);
    float core = 1.0 - smoothstep((-0.02999999932944774627685546875) - (buffer.uBlurStrength * 0.100000001490116119384765625), 0.100000001490116119384765625 + (buffer.uBlurStrength * 0.180000007152557373046875), outer);
    float cut = 1.0 - smoothstep(-0.00999999977648258209228515625, 0.0599999986588954925537109375, inner);
    float mask = fast::max(core * 0.949999988079071044921875, cut * 0.550000011920928955078125);
    float edge = smoothstep(0.2199999988079071044921875 + (buffer.uBlurStrength * 0.20000000298023223876953125), 0.0, abs(outer));
    float2 param_6 = floor(in.vUv * 18.0);
    float _164 = hash21(param_6);
    float frost = (_164 * edge) * 0.25;
    float trail = (smoothstep(0.449999988079071044921875, (-0.3499999940395355224609375) - (buffer.uTrailStrength * 0.64999997615814208984375), p.y) * exp((-abs(p.x)) * 7.0)) * buffer.uTrailStrength;
    float3 color = buffer.uColor * (0.85000002384185791015625 + (buffer.uBrightness * 0.75));
    color += (float3(0.1500000059604644775390625, 0.20000000298023223876953125, 0.2800000011920928955078125) * frost);
    color += (float3(0.3499999940395355224609375, 0.4199999868869781494140625, 0.550000011920928955078125) * trail);
    float alpha = fast::clamp(mask * ((buffer.uOpacity + (trail * 0.3499999940395355224609375)) + (frost * 0.300000011920928955078125)), 0.0, 1.0);
    out.gl_FragColor = float4(color, alpha);
    return out;
}

