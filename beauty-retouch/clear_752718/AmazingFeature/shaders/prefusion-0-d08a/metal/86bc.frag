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
    float frameindex;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 textureCoordinate_0 [[user(textureCoordinate_0)]];
    float2 textureCoordinate_1 [[user(textureCoordinate_1)]];
    float2 textureCoordinate_2 [[user(textureCoordinate_2)]];
    float2 textureCoordinate_3 [[user(textureCoordinate_3)]];
    float2 textureCoordinate_4 [[user(textureCoordinate_4)]];
    float2 textureCoordinate_5 [[user(textureCoordinate_5)]];
    float2 textureCoordinate_6 [[user(textureCoordinate_6)]];
    float2 textureCoordinate_7 [[user(textureCoordinate_7)]];
    float2 textureCoordinate_8 [[user(textureCoordinate_8)]];
};

static inline __attribute__((always_inline))
float Gao(thread const float& a)
{
    return (step(0.009803921915590763092041015625, abs(a)) * 0.699999988079071044921875) + 0.300000011920928955078125;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> _MainTex [[texture(0)]], texture2d<float> lastGradimage [[texture(1)]], sampler _MainTexSmplr [[sampler(0)]], sampler lastGradimageSmplr [[sampler(1)]])
{
    main0_out out = {};
    spvUnsafeArray<float2, 9> textureCoordinate = {};
    textureCoordinate[0] = in.textureCoordinate_0;
    textureCoordinate[1] = in.textureCoordinate_1;
    textureCoordinate[2] = in.textureCoordinate_2;
    textureCoordinate[3] = in.textureCoordinate_3;
    textureCoordinate[4] = in.textureCoordinate_4;
    textureCoordinate[5] = in.textureCoordinate_5;
    textureCoordinate[6] = in.textureCoordinate_6;
    textureCoordinate[7] = in.textureCoordinate_7;
    textureCoordinate[8] = in.textureCoordinate_8;
    float a0 = _MainTex.sample(_MainTexSmplr, textureCoordinate[0]).y;
    float a1 = _MainTex.sample(_MainTexSmplr, textureCoordinate[1]).y;
    float a2 = _MainTex.sample(_MainTexSmplr, textureCoordinate[2]).y;
    float a3 = _MainTex.sample(_MainTexSmplr, textureCoordinate[3]).y;
    float a4 = _MainTex.sample(_MainTexSmplr, textureCoordinate[4]).y;
    float a5 = _MainTex.sample(_MainTexSmplr, textureCoordinate[5]).y;
    float a6 = _MainTex.sample(_MainTexSmplr, textureCoordinate[6]).y;
    float a7 = _MainTex.sample(_MainTexSmplr, textureCoordinate[7]).y;
    float a8 = _MainTex.sample(_MainTexSmplr, textureCoordinate[8]).y;
    float sum = a4 * 0.039999999105930328369140625;
    sum += (a0 * 0.1599999964237213134765625);
    sum += (a1 * 0.07999999821186065673828125);
    sum += (a2 * 0.1599999964237213134765625);
    sum += (a3 * 0.07999999821186065673828125);
    sum += (a5 * 0.07999999821186065673828125);
    sum += (a6 * 0.1599999964237213134765625);
    sum += (a7 * 0.07999999821186065673828125);
    sum += (a8 * 0.1599999964237213134765625);
    float diff = a4 - sum;
    float grad = diff;
    float param = diff;
    float Gaodiff = Gao(param);
    float fuhao = sign(grad);
    grad = ((2.5 * log(1.0 + (84.91500091552734375 * abs(grad)))) / 84.91500091552734375) * fuhao;
    float2 lastgrad = lastGradimage.sample(lastGradimageSmplr, textureCoordinate[4]).xy;
    float reallast = (lastgrad.x - 0.5) / 4.0;
    float laoshigrad = grad;
    if (buffer.frameindex > 0.980000019073486328125)
    {
        grad = (0.0500000007450580596923828125 * grad) + (0.949999988079071044921875 * reallast);
    }
    float absImageDiff = 0.039999999105930328369140625 * abs(a4 - lastgrad.y);
    absImageDiff += (0.1599999964237213134765625 * abs(a0 - lastGradimage.sample(lastGradimageSmplr, textureCoordinate[0]).y));
    absImageDiff += (0.07999999821186065673828125 * abs(a1 - lastGradimage.sample(lastGradimageSmplr, textureCoordinate[1]).y));
    absImageDiff += (0.1599999964237213134765625 * abs(a2 - lastGradimage.sample(lastGradimageSmplr, textureCoordinate[2]).y));
    absImageDiff += (0.07999999821186065673828125 * abs(a3 - lastGradimage.sample(lastGradimageSmplr, textureCoordinate[3]).y));
    absImageDiff += (0.07999999821186065673828125 * abs(a5 - lastGradimage.sample(lastGradimageSmplr, textureCoordinate[5]).y));
    absImageDiff += (0.1599999964237213134765625 * abs(a6 - lastGradimage.sample(lastGradimageSmplr, textureCoordinate[6]).y));
    absImageDiff += (0.07999999821186065673828125 * abs(a7 - lastGradimage.sample(lastGradimageSmplr, textureCoordinate[7]).y));
    absImageDiff += (0.1599999964237213134765625 * abs(a8 - lastGradimage.sample(lastGradimageSmplr, textureCoordinate[8]).y));
    float weight = fast::min(absImageDiff / 0.0431372560560703277587890625, 1.0);
    grad = mix(grad, laoshigrad, weight);
    out.gl_FragColor = float4((grad * 4.0) + 0.5, a4, Gaodiff, 0.0);
    return out;
}

