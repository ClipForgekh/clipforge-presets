precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform mediump sampler2D u_smoothTexture;
uniform vec4 u_ScreenParams;
uniform float u_smoothness;

varying vec2 v_uv;

void main()
{
    mediump vec4 _19 = texture2D(u_inputTexture, v_uv);
    vec4 _t0 = _19;
    float _24 = _t0.w;
    vec3 _28 = _19.xyz * _24;
    _t0.x = _28.x;
    _t0.y = _28.y;
    _t0.z = _28.z;
    vec4 _t1 = texture2D(u_smoothTexture, v_uv);
    float _t2 = _t1.x;
    if (u_smoothness > 0.001000000047497451305389404296875)
    {
        float _t6 = 0.0;
        int _79 = int(u_smoothness * (min(u_ScreenParams.x, u_ScreenParams.y) * 0.01400000043213367462158203125));
        mediump int _85 = (_79 * 2) + 1;
        float _t10 = 0.0;
        float _t11 = _t1.z;
        float _t12 = _t1.z;
        mediump int _95 = _85 - 1;
        for (mediump int _t13 = _95; _t13 >= 0; _t13--)
        {
            mediump vec4 _127 = texture2D(u_smoothTexture, clamp(v_uv + vec2(0.0, (1.0 / u_ScreenParams.y) * float(_t13 - (_85 / 2))), vec2(0.0), vec2(1.0)));
            mediump float _128 = _127.x;
            _t6 += _128;
            _t10 += 1.0;
            _t11 = max(_t11, _128);
            _t12 = min(_t12, _128);
        }
        float _142 = _t6;
        float _152 = 0.5 + (u_smoothness / 3.0);
        float _166 = clamp(((clamp(_142 / max(0.001000000047497451305389404296875, _t10), 0.0, 1.0) - _152) * ((float(_79) / 5.0) + 1.0)) + _152, _t12, _t11);
        _t6 = _166;
        _t2 = mix(min(_t2, _166), _166, clamp(7.0 * u_smoothness, 0.0, 1.0));
    }
    gl_FragData[0] = _t0 * _t2;
    gl_FragData[0].w *= _t0.w;
}

