#version 300 es
precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform float u_progress;
uniform mediump sampler2D u_inputImageTexture;

in vec2 v_uv;
layout(location = 0) out vec4 o_fragColor;

void main()
{
    vec2 _35 = vec2(u_progress * 2.0) / ((u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y))) * 720.0);
    vec4 _t2 = vec4(0.0);
    float _t3 = 0.0;
    for (mediump int _t4 = -1; _t4 <= 1; _t4++)
    {
        for (mediump int _t5 = -1; _t5 <= 1; _t5++)
        {
            _t2 += texture(u_inputImageTexture, v_uv + (_35 * vec2(float(_t4), float(_t5))));
            _t3 += 1.0;
        }
    }
    o_fragColor = _t2 / vec4(_t3);
}

