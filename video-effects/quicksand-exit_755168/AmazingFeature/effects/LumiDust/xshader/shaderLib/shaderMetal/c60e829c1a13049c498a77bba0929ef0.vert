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
    float mask_line_rot;
    float4 u_ScreenParams;
    float distorIns;
    int maskType;
    float noiseFeather;
    float progress;
    float startRotZ;
    float startRotY;
    float startRotX;
    float endRotZ;
    float endRotY;
    float endRotX;
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
    float _59 = cos(_p0);
    float _62 = sin(_p0);
    return float2x2(float2(_59, -_62), float2(_62, _59));
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

static inline __attribute__((always_inline))
float4 _f4(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    float _256 = cos(_p2 * 0.5);
    float _260 = sin(_p2 * 0.5);
    float _264 = cos(_p1 * 0.5);
    float _268 = sin(_p1 * 0.5);
    float _272 = cos(_p0 * 0.5);
    float _276 = sin(_p0 * 0.5);
    float _280 = _256 * _264;
    float _285 = _260 * _268;
    float _304 = _260 * _264;
    float _309 = _256 * _268;
    return float4((_280 * _272) + (_285 * _276), (_280 * _276) - (_285 * _272), (_304 * _276) + (_309 * _272), (_304 * _272) - (_309 * _276));
}

static inline __attribute__((always_inline))
float3 _f3(thread const float4& _p0, thread const float3& _p1)
{
    float4 _t5 = _p0;
    float _125 = _t5.w * _t5.w;
    float _128 = _t5.x * _t5.x;
    float _132 = _t5.y * _t5.y;
    float _136 = _t5.z * _t5.z;
    float _143 = _t5.x * _t5.y;
    float _146 = _t5.w * _t5.z;
    float _154 = _t5.x * _t5.z;
    float _157 = _t5.w * _t5.y;
    float3 _t13;
    _t13.x = (((((_125 + _128) - _132) - _136) * _p1.x) + ((2.0 * (_143 - _146)) * _p1.y)) + ((2.0 * (_154 + _157)) * _p1.z);
    float _180 = _125 - _128;
    float _194 = _t5.y * _t5.z;
    float _197 = _t5.w * _t5.x;
    _t13.y = (((2.0 * (_143 + _146)) * _p1.x) + (((_180 + _132) - _136) * _p1.y)) + ((2.0 * (_194 - _197)) * _p1.z);
    _t13.y *= (-1.0);
    _t13.z = (((2.0 * (_154 - _157)) * _p1.x) + ((2.0 * (_194 + _197)) * _p1.y)) + (((_180 - _132) + _136) * _p1.z);
    return _t13;
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputTex [[texture(0)]], texture2d<float> noiseTex [[texture(1)]], texture2d<float> maskNoiseTex [[texture(2)]], texture2d<float> mask_image [[texture(3)]], sampler inputTexSmplr [[sampler(0)]], sampler noiseTexSmplr [[sampler(1)]], sampler maskNoiseTexSmplr [[sampler(2)]], sampler mask_imageSmplr [[sampler(3)]], uint gl_InstanceID [[instance_id]])
{
    main0_out out = {};
    float _337 = float(gl_InstanceID);
    out.sprite_uv = in.attUV;
    float2 _354 = floor(float2(buffer.normalW, buffer.normalH) * buffer.dustNum);
    float2 _t25 = _354;
    float2 _377 = float2((floor(_337 / _t25.y) + 0.5) / _t25.x, (mod(_337, _t25.y) + 0.5) / _t25.y);
    out.dustUV = _377;
    out.rectUV = float2(buffer.dustSize) / _354;
    out.particleColor = inputTex.sample(inputTexSmplr, _377, level(0.0));
    if (out.particleColor.w < 0.00999999977648258209228515625)
    {
        out.gl_Position = float4(20.0, 20.0, 20.0, 1.0);
        out.gl_PointSize = 1.0;
        out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
        return out;
    }
    float param = buffer.mask_line_rot;
    float2 _t29 = ((_377 - float2(0.5)) * _f1(param)) + float2(0.5);
    float _t32 = 1.0;
    float4 param_1 = noiseTex.sample(noiseTexSmplr, _377, level(0.0));
    float2 _t33 = _f2(param_1);
    float2 _453 = buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y));
    float2 _t34 = _453;
    float _t35 = ((_t33.x - 0.5) / _t34.x) * buffer.distorIns;
    float _t36 = ((_t33.y - 0.5) / _t34.y) * buffer.distorIns;
    if (buffer.maskType == 0)
    {
        float4 param_2 = maskNoiseTex.sample(maskNoiseTexSmplr, _377, level(0.0));
        float2 _t37 = _f2(param_2);
        float _498 = buffer.progress * (1.0 + buffer.noiseFeather);
        float _507 = smoothstep((-buffer.noiseFeather) + _498, 0.0 + _498, _t37.x);
        _t32 = _507;
        float _510 = 1.0 - _507;
        _t35 *= pow(_510, 0.89999997615814208984375);
        _t36 *= pow(_510, 1.10000002384185791015625);
    }
    else
    {
        if (buffer.maskType == 1)
        {
            float _541 = buffer.progress * (1.0 + buffer.noiseFeather);
            float _549 = smoothstep((-buffer.noiseFeather) + _541, 0.0 + _541, ((_t29.x - 0.5) / (1.41421353816986083984375 * cos(0.7853000164031982421875 - (abs(mod((buffer.mask_line_rot / 0.7853000164031982421875) + 1.0, 2.0) - 1.0) * 0.7853000164031982421875)))) + 0.5);
            _t32 = _549;
            float _552 = 1.0 - _549;
            _t35 *= pow(_552, 0.89999997615814208984375);
            _t36 *= pow(_552, 1.10000002384185791015625);
        }
        else
        {
            if (buffer.maskType == 2)
            {
                float3 param_3 = mask_image.sample(mask_imageSmplr, _377, level(0.0)).xyz;
                float _584 = buffer.progress * (1.0 + buffer.noiseFeather);
                float _592 = smoothstep((-buffer.noiseFeather) + _584, 0.0 + _584, _f0(param_3));
                _t32 = _592;
                float _595 = 1.0 - _592;
                _t35 *= pow(_595, 0.89999997615814208984375);
                _t36 *= pow(_595, 1.10000002384185791015625);
            }
        }
    }
    out.particleOpacity = pow(_t32, 0.25);
    out.particleColor.w *= out.particleOpacity;
    if (out.particleColor.w < 0.00999999977648258209228515625)
    {
        out.gl_Position = float4(20.0, 20.0, 20.0, 1.0);
        out.gl_PointSize = 1.0;
        out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
        return out;
    }
    float3 _630 = float3((_377 * 2.0) - float2(1.0), 0.0) - float3(0.0);
    float3 _t48 = _630;
    float2 _634 = _630.xy * _453;
    _t48.x = _634.x;
    _t48.y = _634.y;
    float _641 = 1.0 - _t32;
    float3 _658 = float3(_641);
    float3 _t50 = mix(float3(buffer.startRotZ, buffer.startRotY, buffer.startRotX), float3(buffer.endRotZ, buffer.endRotY, buffer.endRotX), _658);
    float param_4 = _t50.x;
    float param_5 = _t50.y;
    float param_6 = _t50.z;
    float4 param_7 = _f4(param_4, param_5, param_6);
    float3 param_8 = _t48;
    float3 _694 = mix(float3(buffer.startMoveX, buffer.startMoveY, buffer.startMoveZ), float3(buffer.endMoveX, buffer.endMoveY, buffer.endMoveZ), _658);
    float3 _t53 = _694;
    float2 _708 = _694.xy * _453;
    _t53.x = _708.x;
    _t53.y = _708.y;
    float3 _t52 = (_f3(param_7, param_8) * mix(buffer.startSize, buffer.endSize, _641)) + _t53;
    _t52.z *= 0.300000011920928955078125;
    _t48 = _t52;
    float2 _725 = _t52.xy / _453;
    _t48.x = _725.x;
    _t48.y = _725.y;
    float3 _731 = _t48;
    float3 _742 = (_731 + float3(0.0)) + float3(_t35, _t36, fast::clamp((_t35 + _t36) * 0.00999999977648258209228515625, -1.0, 1.0));
    _t48 = _742;
    float4 _t55 = buffer.u_MVP * float4((in.attPosition.xy * out.rectUV) + _742.xy, _t48.z, 1.0);
    _t55.x *= (buffer.u_ScreenParams.x / buffer.u_ScreenParams.y);
    out.gl_Position = _t55;
    out.testUV = in.attUV;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

