#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_sampleY;
    float u_stepY;
    int u_borderType;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    if (buffer.u_sampleY < 9.9999997473787516355514526367188e-06)
    {
        out.o_fragColor = u_inputTexture.sample(u_inputTextureSmplr, in.uv0);
        return out;
    }
    float2 _209;
    float4 _210;
    float _211;
    _211 = 1.0;
    _210 = u_inputTexture.sample(u_inputTextureSmplr, in.uv0) * 1.0;
    _209 = in.uv0;
    float2 _234;
    float4 _238;
    float _242;
    for (int _208 = 1; _208 <= 1024; _211 = _242, _210 = _238, _209 = _234, _208++)
    {
        float _58 = float(_208);
        if (_58 > buffer.u_sampleY)
        {
            break;
        }
        float _76 = fma(-_58, buffer.u_stepY, in.uv0.y);
        float2 _193 = _209;
        _193.y = _76;
        float2 _212;
        float4 _216;
        float _220;
        if (_76 < 0.0)
        {
            float2 _213;
            float4 _217;
            float _221;
            if (buffer.u_borderType == 1)
            {
                float2 _196 = _193;
                _196.y = 0.0;
                _221 = _211 + 1.0;
                _217 = _210 + u_inputTexture.sample(u_inputTextureSmplr, _196);
                _213 = _196;
            }
            else
            {
                float2 _214;
                float4 _218;
                float _222;
                if (buffer.u_borderType == 2)
                {
                    _222 = _211 + 1.0;
                    _218 = _210;
                    _214 = _193;
                }
                else
                {
                    float2 _215;
                    float4 _219;
                    float _223;
                    if (buffer.u_borderType == 3)
                    {
                        float2 _199 = _193;
                        _199.y = -_76;
                        _223 = _211 + 1.0;
                        _219 = _210 + u_inputTexture.sample(u_inputTextureSmplr, _199);
                        _215 = _199;
                    }
                    else
                    {
                        _223 = _211;
                        _219 = _210;
                        _215 = _193;
                    }
                    _222 = _223;
                    _218 = _219;
                    _214 = _215;
                }
                _221 = _222;
                _217 = _218;
                _213 = _214;
            }
            _220 = _221;
            _216 = _217;
            _212 = _213;
        }
        else
        {
            _220 = _211 + 1.0;
            _216 = _210 + u_inputTexture.sample(u_inputTextureSmplr, _193);
            _212 = _193;
        }
        float _134 = fma(_58, buffer.u_stepY, in.uv0.y);
        float2 _201 = _212;
        _201.y = _134;
        if (_134 > 1.0)
        {
            float2 _235;
            float4 _239;
            float _243;
            if (buffer.u_borderType == 1)
            {
                float2 _204 = _201;
                _204.y = 1.0;
                _243 = _220 + 1.0;
                _239 = _216 + u_inputTexture.sample(u_inputTextureSmplr, _204);
                _235 = _204;
            }
            else
            {
                float2 _236;
                float4 _240;
                float _244;
                if (buffer.u_borderType == 2)
                {
                    _244 = _220 + 1.0;
                    _240 = _216;
                    _236 = _201;
                }
                else
                {
                    float2 _237;
                    float4 _241;
                    float _245;
                    if (buffer.u_borderType == 3)
                    {
                        float2 _207 = _201;
                        _207.y = 2.0 - _134;
                        _245 = _220 + 1.0;
                        _241 = _216 + u_inputTexture.sample(u_inputTextureSmplr, _207);
                        _237 = _207;
                    }
                    else
                    {
                        _245 = _220;
                        _241 = _216;
                        _237 = _201;
                    }
                    _244 = _245;
                    _240 = _241;
                    _236 = _237;
                }
                _243 = _244;
                _239 = _240;
                _235 = _236;
            }
            _242 = _243;
            _238 = _239;
            _234 = _235;
        }
        else
        {
            _242 = _220 + 1.0;
            _238 = _216 + u_inputTexture.sample(u_inputTextureSmplr, _201);
            _234 = _201;
        }
    }
    out.o_fragColor = _210 / float4(_211);
    return out;
}

