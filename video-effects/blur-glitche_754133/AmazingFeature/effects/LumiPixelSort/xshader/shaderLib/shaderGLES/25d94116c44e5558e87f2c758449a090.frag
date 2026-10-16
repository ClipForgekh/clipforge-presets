precision highp float;
precision highp int;

uniform float rotate;
uniform mediump sampler2D inputImageTexture;

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
    float param_1 = _54;
    vec2 _62 = _f0(param, param_1);
    vec2 _79 = ((_62 - vec2(0.5)) * (abs(cos(_54)) + abs(sin(_54)))) + vec2(0.5);
    gl_FragData[0] = texture2D(inputImageTexture, _79);
    if (any(notEqual(_79, clamp(_79, vec2(0.0), vec2(1.0)))))
    {
        gl_FragData[0].w = 0.0;
    }
}

