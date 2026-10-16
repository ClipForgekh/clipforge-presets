precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D u_inputTexture;
uniform float u_smoothness;

varying vec2 v_uv;

void main()
{
    mediump vec4 _32 = texture2D(u_inputTexture, v_uv);
    vec4 _t2 = _32;
    if (u_smoothness < 0.001000000047497451305389404296875)
    {
        gl_FragData[0] = _32;
    }
    else
    {
        float _t4 = 0.0;
        mediump int _67 = (int(u_smoothness * (min(u_ScreenParams.x, u_ScreenParams.y) * 0.01400000043213367462158203125)) * 2) + 1;
        float _t8 = 0.0;
        float _t9 = _t2.x;
        float _t10 = _t2.x;
        mediump int _75 = _67 - 1;
        for (mediump int _t11 = _75; _t11 >= 0; _t11--)
        {
            mediump vec4 _107 = texture2D(u_inputTexture, clamp(v_uv + vec2((1.0 / u_ScreenParams.x) * float(_t11 - (_67 / 2)), 0.0), vec2(0.0), vec2(1.0)));
            mediump float _108 = _107.x;
            _t4 += _108;
            _t8 += 1.0;
            _t9 = max(_t9, _108);
            _t10 = min(_t10, _108);
        }
        float _122 = _t4;
        float _126 = clamp(_122 / max(0.001000000047497451305389404296875, _t8), 0.0, 1.0);
        _t4 = _126;
        gl_FragData[0] = vec4(vec3(_126, _t9, _t10), 1.0);
    }
}

