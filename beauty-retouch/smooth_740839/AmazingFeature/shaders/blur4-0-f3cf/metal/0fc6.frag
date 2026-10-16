#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    float valueFactor;
    float widthOffset;
    float heightOffset;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(uv0)]];
};

static inline __attribute__((always_inline))
float4 processing_1pixel(thread float4& sum_value, thread const float& center_gray, thread const float2& coor, texture2d<float> inputImageTexture, sampler inputImageTextureSmplr, constant float& valueFactor)
{
    float3 tmp_color = inputImageTexture.sample(inputImageTextureSmplr, coor).xyz;
    float tmp_value_dis = tmp_color.y - center_gray;
    tmp_value_dis = 1.0 - fast::min((tmp_value_dis * tmp_value_dis) * valueFactor, 1.0);
    float4 _49 = sum_value;
    float3 _51 = _49.xyz + (tmp_color * tmp_value_dis);
    sum_value.x = _51.x;
    sum_value.y = _51.y;
    sum_value.z = _51.z;
    sum_value.w += tmp_value_dis;
    return sum_value;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> faceSkinMaskTexture [[texture(1)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler faceSkinMaskTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float3 centerColor = inputImageTexture.sample(inputImageTextureSmplr, in.uv0).xyz;
    float skinArea = faceSkinMaskTexture.sample(faceSkinMaskTextureSmplr, in.uv0).w;
    float3 resColor = centerColor;
    if (skinArea > 0.100000001490116119384765625)
    {
        float2 unit_uv = float2(buffer.widthOffset, buffer.heightOffset) * 0.449999988079071044921875;
        float scale = 0.60000002384185791015625;
        float2 offset = unit_uv * scale;
        spvUnsafeArray<float2, 4> textureShift1;
        textureShift1[0] = offset * float2(5.0, 0.0);
        textureShift1[1] = offset * float2(0.0, 5.0);
        textureShift1[2] = offset * float2(3.0, 4.0);
        textureShift1[3] = offset * float2(4.0, 3.0);
        spvUnsafeArray<float2, 4> textureShift2;
        textureShift2[0] = offset * float2(10.0, 0.0);
        textureShift2[1] = offset * float2(0.0, 10.0);
        textureShift2[2] = offset * float2(6.0, 8.0);
        textureShift2[3] = offset * float2(8.0, 6.0);
        scale = 1.0;
        offset = unit_uv * scale;
        spvUnsafeArray<float2, 4> textureShift3;
        textureShift3[0] = offset * float2(20.0, 0.0);
        textureShift3[1] = offset * float2(0.0, 20.0);
        textureShift3[2] = offset * float2(12.0, 16.0);
        textureShift3[3] = offset * float2(16.0, 12.0);
        float center_gray = centerColor.y;
        float4 sum_value = float4(0.0);
        float4 param = sum_value;
        float param_1 = center_gray;
        float2 param_2 = in.uv0 + float2(textureShift1[0].x, textureShift1[0].y);
        float4 _193 = processing_1pixel(param, param_1, param_2, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _193;
        float4 param_3 = sum_value;
        float param_4 = center_gray;
        float2 param_5 = in.uv0 + float2(-textureShift1[0].x, textureShift1[0].y);
        float4 _207 = processing_1pixel(param_3, param_4, param_5, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _207;
        float4 param_6 = sum_value;
        float param_7 = center_gray;
        float2 param_8 = in.uv0 + float2(textureShift1[1].x, textureShift1[1].y);
        float4 _220 = processing_1pixel(param_6, param_7, param_8, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _220;
        float4 param_9 = sum_value;
        float param_10 = center_gray;
        float2 param_11 = in.uv0 + float2(textureShift1[1].x, -textureShift1[1].y);
        float4 _234 = processing_1pixel(param_9, param_10, param_11, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _234;
        float4 param_12 = sum_value;
        float param_13 = center_gray;
        float2 param_14 = in.uv0 + float2(textureShift1[2].x, textureShift1[2].y);
        float4 _247 = processing_1pixel(param_12, param_13, param_14, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _247;
        float4 param_15 = sum_value;
        float param_16 = center_gray;
        float2 param_17 = in.uv0 + float2(-textureShift1[2].x, textureShift1[2].y);
        float4 _261 = processing_1pixel(param_15, param_16, param_17, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _261;
        float4 param_18 = sum_value;
        float param_19 = center_gray;
        float2 param_20 = in.uv0 + float2(textureShift1[2].x, -textureShift1[2].y);
        float4 _275 = processing_1pixel(param_18, param_19, param_20, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _275;
        float4 param_21 = sum_value;
        float param_22 = center_gray;
        float2 param_23 = in.uv0 + float2(-textureShift1[2].x, -textureShift1[2].y);
        float4 _290 = processing_1pixel(param_21, param_22, param_23, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _290;
        float4 param_24 = sum_value;
        float param_25 = center_gray;
        float2 param_26 = in.uv0 + float2(textureShift1[3].x, textureShift1[3].y);
        float4 _303 = processing_1pixel(param_24, param_25, param_26, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _303;
        float4 param_27 = sum_value;
        float param_28 = center_gray;
        float2 param_29 = in.uv0 + float2(-textureShift1[3].x, textureShift1[3].y);
        float4 _317 = processing_1pixel(param_27, param_28, param_29, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _317;
        float4 param_30 = sum_value;
        float param_31 = center_gray;
        float2 param_32 = in.uv0 + float2(textureShift1[3].x, -textureShift1[3].y);
        float4 _331 = processing_1pixel(param_30, param_31, param_32, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _331;
        float4 param_33 = sum_value;
        float param_34 = center_gray;
        float2 param_35 = in.uv0 + float2(-textureShift1[3].x, -textureShift1[3].y);
        float4 _346 = processing_1pixel(param_33, param_34, param_35, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _346;
        float4 param_36 = sum_value;
        float param_37 = center_gray;
        float2 param_38 = in.uv0 + float2(textureShift2[0].x, textureShift2[0].y);
        float4 _359 = processing_1pixel(param_36, param_37, param_38, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _359;
        float4 param_39 = sum_value;
        float param_40 = center_gray;
        float2 param_41 = in.uv0 + float2(-textureShift2[0].x, textureShift2[0].y);
        float4 _373 = processing_1pixel(param_39, param_40, param_41, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _373;
        float4 param_42 = sum_value;
        float param_43 = center_gray;
        float2 param_44 = in.uv0 + float2(textureShift2[1].x, textureShift2[1].y);
        float4 _386 = processing_1pixel(param_42, param_43, param_44, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _386;
        float4 param_45 = sum_value;
        float param_46 = center_gray;
        float2 param_47 = in.uv0 + float2(textureShift2[1].x, -textureShift2[1].y);
        float4 _400 = processing_1pixel(param_45, param_46, param_47, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _400;
        float4 param_48 = sum_value;
        float param_49 = center_gray;
        float2 param_50 = in.uv0 + float2(textureShift2[2].x, textureShift2[2].y);
        float4 _413 = processing_1pixel(param_48, param_49, param_50, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _413;
        float4 param_51 = sum_value;
        float param_52 = center_gray;
        float2 param_53 = in.uv0 + float2(-textureShift2[2].x, textureShift2[2].y);
        float4 _427 = processing_1pixel(param_51, param_52, param_53, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _427;
        float4 param_54 = sum_value;
        float param_55 = center_gray;
        float2 param_56 = in.uv0 + float2(textureShift2[2].x, -textureShift2[2].y);
        float4 _441 = processing_1pixel(param_54, param_55, param_56, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _441;
        float4 param_57 = sum_value;
        float param_58 = center_gray;
        float2 param_59 = in.uv0 + float2(-textureShift2[2].x, -textureShift2[2].y);
        float4 _456 = processing_1pixel(param_57, param_58, param_59, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _456;
        float4 param_60 = sum_value;
        float param_61 = center_gray;
        float2 param_62 = in.uv0 + float2(textureShift2[3].x, textureShift2[3].y);
        float4 _469 = processing_1pixel(param_60, param_61, param_62, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _469;
        float4 param_63 = sum_value;
        float param_64 = center_gray;
        float2 param_65 = in.uv0 + float2(-textureShift2[3].x, textureShift2[3].y);
        float4 _483 = processing_1pixel(param_63, param_64, param_65, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _483;
        float4 param_66 = sum_value;
        float param_67 = center_gray;
        float2 param_68 = in.uv0 + float2(textureShift2[3].x, -textureShift2[3].y);
        float4 _497 = processing_1pixel(param_66, param_67, param_68, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _497;
        float4 param_69 = sum_value;
        float param_70 = center_gray;
        float2 param_71 = in.uv0 + float2(-textureShift2[3].x, -textureShift2[3].y);
        float4 _512 = processing_1pixel(param_69, param_70, param_71, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _512;
        float4 param_72 = sum_value;
        float param_73 = center_gray;
        float2 param_74 = in.uv0 + float2(textureShift3[0].x, textureShift3[0].y);
        float4 _525 = processing_1pixel(param_72, param_73, param_74, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _525;
        float4 param_75 = sum_value;
        float param_76 = center_gray;
        float2 param_77 = in.uv0 + float2(-textureShift3[0].x, textureShift3[0].y);
        float4 _539 = processing_1pixel(param_75, param_76, param_77, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _539;
        float4 param_78 = sum_value;
        float param_79 = center_gray;
        float2 param_80 = in.uv0 + float2(textureShift3[1].x, textureShift3[1].y);
        float4 _552 = processing_1pixel(param_78, param_79, param_80, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _552;
        float4 param_81 = sum_value;
        float param_82 = center_gray;
        float2 param_83 = in.uv0 + float2(textureShift3[1].x, -textureShift3[1].y);
        float4 _566 = processing_1pixel(param_81, param_82, param_83, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _566;
        float4 param_84 = sum_value;
        float param_85 = center_gray;
        float2 param_86 = in.uv0 + float2(textureShift3[2].x, textureShift3[2].y);
        float4 _579 = processing_1pixel(param_84, param_85, param_86, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _579;
        float4 param_87 = sum_value;
        float param_88 = center_gray;
        float2 param_89 = in.uv0 + float2(-textureShift3[2].x, textureShift3[2].y);
        float4 _593 = processing_1pixel(param_87, param_88, param_89, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _593;
        float4 param_90 = sum_value;
        float param_91 = center_gray;
        float2 param_92 = in.uv0 + float2(textureShift3[2].x, -textureShift3[2].y);
        float4 _607 = processing_1pixel(param_90, param_91, param_92, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _607;
        float4 param_93 = sum_value;
        float param_94 = center_gray;
        float2 param_95 = in.uv0 + float2(-textureShift3[2].x, -textureShift3[2].y);
        float4 _622 = processing_1pixel(param_93, param_94, param_95, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _622;
        float4 param_96 = sum_value;
        float param_97 = center_gray;
        float2 param_98 = in.uv0 + float2(textureShift3[3].x, textureShift3[3].y);
        float4 _635 = processing_1pixel(param_96, param_97, param_98, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _635;
        float4 param_99 = sum_value;
        float param_100 = center_gray;
        float2 param_101 = in.uv0 + float2(-textureShift3[3].x, textureShift3[3].y);
        float4 _649 = processing_1pixel(param_99, param_100, param_101, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _649;
        float4 param_102 = sum_value;
        float param_103 = center_gray;
        float2 param_104 = in.uv0 + float2(textureShift3[3].x, -textureShift3[3].y);
        float4 _663 = processing_1pixel(param_102, param_103, param_104, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _663;
        float4 param_105 = sum_value;
        float param_106 = center_gray;
        float2 param_107 = in.uv0 + float2(-textureShift3[3].x, -textureShift3[3].y);
        float4 _678 = processing_1pixel(param_105, param_106, param_107, inputImageTexture, inputImageTextureSmplr, buffer.valueFactor);
        sum_value = _678;
        float4 _680 = sum_value;
        float3 _682 = _680.xyz + centerColor;
        sum_value.x = _682.x;
        sum_value.y = _682.y;
        sum_value.z = _682.z;
        sum_value.w += 1.0;
        resColor = sum_value.xyz / float3(sum_value.w);
    }
    out.gl_FragColor = float4(resColor, 1.0);
    return out;
}

