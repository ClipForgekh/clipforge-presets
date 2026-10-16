#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_branchSeed;
    float u_boltProgress;
    float u_reveal;
    float u_afterglow;
    float3 u_glowColor;
    float u_brightness;
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
float boltX(thread const float& yNorm, constant float& u_branchSeed)
{
    return (0.4000000059604644775390625 + (sin((yNorm * 18.0) + (u_branchSeed * 0.699999988079071044921875)) * 0.0320000015199184417724609375)) + (sin((yNorm * 43.0) + (u_branchSeed * 2.099999904632568359375)) * 0.01400000043213367462158203125);
}

static inline __attribute__((always_inline))
float segmentDistance(thread const float2& p, thread const float2& a, thread const float2& b)
{
    float2 pa = p - a;
    float2 ba = b - a;
    float h = fast::clamp(dot(pa, ba) / fast::max(dot(ba, ba), 9.9999997473787516355514526367188e-05), 0.0, 1.0);
    return length(pa - (ba * h));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 texColor = texture1.sample(texture1Smplr, uv);
    float headY = 1.0 - buffer.u_boltProgress;
    float traversed = step(headY, uv.y);
    float param = uv.y;
    float mainX = boltX(param, buffer.u_branchSeed);
    float dMain = abs(uv.x - mainX);
    float coreMain = exp((-dMain) * 260.0) * traversed;
    float glowMain = exp((-dMain) * 70.0) * traversed;
    float param_1 = 0.64999997615814208984375;
    float2 b1Start = float2(boltX(param_1, buffer.u_branchSeed), 0.64999997615814208984375);
    float2 b1End = b1Start + float2(-0.0900000035762786865234375, -0.1599999964237213134765625);
    float b1Visible = step(headY, b1Start.y);
    float param_2 = 0.319999992847442626953125;
    float2 b2Start = float2(boltX(param_2, buffer.u_branchSeed), 0.319999992847442626953125);
    float2 b2End = b2Start + float2(0.100000001490116119384765625, -0.14000000059604644775390625);
    float b2Visible = step(headY, b2Start.y);
    float2 param_3 = uv;
    float2 param_4 = b1Start;
    float2 param_5 = b1End;
    float dB1 = segmentDistance(param_3, param_4, param_5);
    float2 param_6 = uv;
    float2 param_7 = b2Start;
    float2 param_8 = b2End;
    float dB2 = segmentDistance(param_6, param_7, param_8);
    float coreBranch = ((exp((-dB1) * 210.0) * b1Visible) * 0.60000002384185791015625) + ((exp((-dB2) * 210.0) * b2Visible) * 0.60000002384185791015625);
    float glowBranch = ((exp((-dB1) * 62.0) * b1Visible) * 0.449999988079071044921875) + ((exp((-dB2) * 62.0) * b2Visible) * 0.449999988079071044921875);
    float boltVisibility = 1.0 - smoothstep(0.89999997615814208984375, 1.0, buffer.u_reveal);
    float lightningCore = (coreMain + coreBranch) * boltVisibility;
    float lightningGlow = (glowMain + glowBranch) * boltVisibility;
    float afterglowMask = (glowMain + glowBranch) * buffer.u_afterglow;
    float revealMask = fast::clamp(((buffer.u_reveal + (lightningCore * 0.89999997615814208984375)) + (lightningGlow * 0.3499999940395355224609375)) + (afterglowMask * 0.3499999940395355224609375), 0.0, 1.0);
    float3 color = texColor.xyz * revealMask;
    color += ((float3(1.0) * lightningCore) * 1.25);
    color += (buffer.u_glowColor * ((lightningGlow * 0.75) + (afterglowMask * 0.949999988079071044921875)));
    color *= buffer.u_brightness;
    float flashWhite = fast::clamp((buffer.u_brightness - 1.0) / 0.85000002384185791015625, 0.0, 1.0);
    color = mix(color, float3(1.0), float3(flashWhite * 0.920000016689300537109375));
    float alpha = texColor.w * fast::max(revealMask, flashWhite * 0.959999978542327880859375);
    out.gl_FragColor = float4(color, fast::clamp(alpha, 0.0, 1.0));
    return out;
}

