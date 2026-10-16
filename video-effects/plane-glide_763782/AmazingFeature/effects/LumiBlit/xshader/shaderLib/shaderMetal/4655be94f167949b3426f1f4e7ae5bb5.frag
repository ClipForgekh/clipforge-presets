#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_offset;
    float2 u_moveCenter;
    float2 u_scale;
    int u_movingType;
    float2 u_wdsoffset;
    float2 u_wordsOffset;
    float2 u_offset3;
    float2 u_offset2;
    float2 u_wordsCenter;
    float2 u_scale2;
    float u_wordsScale;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_blurBgTexture [[texture(1)]], texture2d<float> u_maskTexture [[texture(2)]], texture2d<float> u_wordsTexture [[texture(3)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_blurBgTextureSmplr [[sampler(1)]], sampler u_maskTextureSmplr [[sampler(2)]], sampler u_wordsTextureSmplr [[sampler(3)]])
{
    main0_out out = {};
    float2 _22 = float2(in.v_uv.x, 1.0 - in.v_uv.y);
    float2 _t2 = float2(0.0);
    float2 _t3 = float2(0.0);
    float _t4 = 1.0;
    float _t5 = 1.0;
    if (buffer.u_movingType == 0)
    {
        float2 _65 = _22 + fast::min(buffer.u_wdsoffset - buffer.u_wordsOffset, buffer.u_offset3);
        _t3 = _65 - buffer.u_offset2;
        _t2 = _65 + buffer.u_offset2;
        float _79 = 0.5 + buffer.u_offset3.y;
        if (_t2.y > _79)
        {
            _t4 = 0.0;
        }
        if (_t3.y < _79)
        {
            _t5 = 0.0;
        }
    }
    else
    {
        float2 _98 = _22 + fast::max(buffer.u_offset - buffer.u_wordsOffset, buffer.u_offset3);
        _t3 = _98 - buffer.u_offset2;
        _t2 = _98 + buffer.u_offset2;
        if (_t2.y > 0.5)
        {
            _t4 = 0.0;
        }
        if (_t3.y < 0.5)
        {
            _t5 = 0.0;
        }
    }
    float2 _117 = _t2;
    float2 _127 = _t3;
    float2 _141 = float2(buffer.u_wordsScale);
    float2 _145 = (((((_117 - buffer.u_wordsCenter) / buffer.u_scale2) + buffer.u_wordsCenter) - float2(0.5)) / _141) + float2(0.5);
    _t2 = _145;
    float2 _155 = (((((_127 - buffer.u_wordsCenter) / buffer.u_scale2) + buffer.u_wordsCenter) - float2(0.5)) / _141) + float2(0.5);
    _t3 = _155;
    float4 _170 = u_blurBgTexture.sample(u_blurBgTextureSmplr, in.v_uv);
    float4 _t7 = _170;
    float3 _174 = _170.xyz * 0.5;
    _t7.x = _174.x;
    _t7.y = _174.y;
    _t7.z = _174.z;
    float4 _186 = u_maskTexture.sample(u_maskTextureSmplr, ((((_22 + buffer.u_offset) - buffer.u_moveCenter) / buffer.u_scale) + buffer.u_moveCenter));
    float4 _t8 = _186;
    float4 _t9 = u_wordsTexture.sample(u_wordsTextureSmplr, (_145 * _t4));
    float4 _t10 = u_wordsTexture.sample(u_wordsTextureSmplr, (_155 * _t5));
    float3 _213 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv).xyz;
    out.o_fragColor = float4(mix(mix(mix(_t7, _186, float4(_t8.w)).xyz, _213, float3(smoothstep(0.20000000298023223876953125, 0.800000011920928955078125, _t9.x))), _213, float3(smoothstep(0.20000000298023223876953125, 0.800000011920928955078125, _t10.x))), fast::clamp(_t4 + _t5, 0.0, 1.0));
    return out;
}

