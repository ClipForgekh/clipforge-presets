precision highp float;
precision highp int;

uniform float rotate;
uniform mediump sampler2D infoTexture;
uniform mediump sampler2D maskTexture;
uniform mediump sampler2D inputImageTexture;
uniform mediump sampler2D scaleTexture;
uniform float outputType;
uniform float reverseSort;
uniform float cycle;
uniform float blurSize;
uniform float featherStart;
uniform float featherEnd;

varying vec2 v_uv;

vec2 _f0(inout vec2 _p0, float _p1)
{
    float _17 = sin(_p1);
    float _20 = cos(_p1);
    _p0 -= vec2(0.5);
    _p0 = mat2(vec2(_20, _17), vec2(-_17, _20)) * _p0;
    _p0 += vec2(0.5);
    return _p0;
}

void main()
{
    float _54 = (rotate * 3.141592502593994140625) / 180.0;
    vec2 param = v_uv;
    float param_1 = -_54;
    vec2 _63 = _f0(param, param_1);
    float _69 = abs(cos(_54));
    float _72 = abs(sin(_54));
    vec2 _103 = ((_63 - vec2(0.5)) / vec2(max(_69 + _72, _72 + _69) * 1.0099999904632568359375)) + vec2(0.5);
    vec4 _t7 = texture2D(infoTexture, _103);
    float _t8 = _t7.x / (_t7.x + _t7.y);
    float _t9 = _t7.y / (_t7.x + _t7.y);
    float _t10 = texture2D(maskTexture, _103).x;
    mediump vec4 _145 = texture2D(inputImageTexture, ((v_uv - vec2(0.5)) / vec2(1.0099999904632568359375)) + vec2(0.5));
    vec4 _t11 = _145;
    vec4 _t12 = texture2D(scaleTexture, _103);
    if ((outputType > 0.5) && (outputType <= 1.5))
    {
        gl_FragData[0] = vec4(_t10, _t10, _t10, _t11.w);
        return;
    }
    if ((outputType > 1.5) && (outputType <= 2.5))
    {
        float _183 = _t7.x * 255.0;
        float _187 = _t7.y * 255.0;
        float _t15 = _183;
        if (reverseSort > 0.5)
        {
            _t15 = _187;
        }
        float _196 = _t15;
        float _201 = floor((_183 + _187) + 1.0);
        float _212 = mod(_196 + (_201 * mod(cycle, 1.0)), _201);
        _t15 = _212;
        gl_FragData[0] = vec4(_212 / _201);
        gl_FragData[0].w = _t11.w;
        return;
    }
    if (blurSize > 1.0)
    {
        float _t16 = 1.0;
        for (float _t17 = 1.0; _t17 < 50.0; _t17 += 1.0)
        {
            if (_t17 > blurSize)
            {
                break;
            }
            mediump vec4 _255 = texture2D(maskTexture, _103 + (vec2(0.00390625, 0.0) * _t17));
            mediump float _256 = _255.x;
            if (_256 < 0.5)
            {
                break;
            }
            _t12 += (texture2D(scaleTexture, _103 + (vec2(0.00390625, 0.0) * _t17)) * _256);
            _t16 += _256;
        }
        for (float _t19 = 1.0; _t19 < 50.0; _t19 += 1.0)
        {
            if (_t19 > blurSize)
            {
                break;
            }
            mediump vec4 _297 = texture2D(maskTexture, _103 - (vec2(0.00390625, 0.0) * _t19));
            mediump float _298 = _297.x;
            if (_298 < 0.5)
            {
                break;
            }
            _t12 += (texture2D(scaleTexture, _103 - (vec2(0.00390625, 0.0) * _t19)) * _298);
            _t16 += _298;
        }
        _t12 /= vec4(_t16);
    }
    float _327;
    if (featherStart < 0.00999999977648258209228515625)
    {
        _327 = 1.0;
    }
    else
    {
        _327 = smoothstep(0.0, featherStart, _t8);
    }
    _t8 = _327;
    float _338;
    if (featherEnd < 0.00999999977648258209228515625)
    {
        _338 = 1.0;
    }
    else
    {
        _338 = smoothstep(0.0, featherEnd, _t9);
    }
    _t9 = _338;
    float _349 = _t10;
    float _350 = _349 * min(_t8, _338);
    _t10 = _350;
    gl_FragData[0] = mix(_145, _t12, vec4(_350));
}

