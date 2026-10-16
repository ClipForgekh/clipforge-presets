precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D inputImageTexture;
uniform float blurSize;

varying vec2 v_uv;

void main()
{
    vec2 _t1 = vec2(1.0) / ((u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y))) * 720.0);
    vec4 _t2 = texture2D(inputImageTexture, v_uv);
    for (float _t3 = 1.0; _t3 <= 128.0; _t3 += 1.0)
    {
        if (_t3 > blurSize)
        {
            break;
        }
        _t2 = (_t2 + texture2D(inputImageTexture, v_uv + vec2(0.0, _t3 * _t1.y))) + texture2D(inputImageTexture, v_uv - vec2(0.0, _t3 * _t1.y));
    }
    vec4 _91 = _t2;
    vec4 _93 = _91 / vec4(1.0 + (blurSize * 2.0));
    _t2 = _93;
    gl_FragData[0] = _93;
}

