precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D u_inputTexture;
uniform float lowerLimit;
uniform float upperLimit;
uniform float brightness;
uniform float u_edgeBrightness;

varying vec2 v_uv;

void main()
{
    vec2 _t1 = vec2(1.0) / ((u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y))) * 720.0);
    mediump vec4 _43 = texture2D(u_inputTexture, v_uv);
    vec4 _t2 = _43;
    float _154 = (-1.0) * texture2D(u_inputTexture, v_uv + vec2((-1.0) * _t1.x, (-1.0) * _t1.y)).w;
    float _160 = 1.0 * texture2D(u_inputTexture, v_uv + vec2((-1.0) * _t1.x, 1.0 * _t1.y)).w;
    float _163 = 1.0 * texture2D(u_inputTexture, v_uv + vec2(1.0 * _t1.x, (-1.0) * _t1.y)).w;
    float _169 = 1.0 * texture2D(u_inputTexture, v_uv + vec2(1.0 * _t1.x, 1.0 * _t1.y)).w;
    float _170 = ((((_154 - (2.0 * texture2D(u_inputTexture, v_uv + vec2((-1.0) * _t1.x, 0.0 * _t1.y)).w)) - _160) + _163) + (2.0 * texture2D(u_inputTexture, v_uv + vec2(1.0 * _t1.x, 0.0 * _t1.y)).w)) + _169;
    float _188 = ((((_154 - (2.0 * texture2D(u_inputTexture, v_uv + vec2(0.0 * _t1.x, (-1.0) * _t1.y)).w)) - _163) + _160) + (2.0 * texture2D(u_inputTexture, v_uv + vec2(0.0 * _t1.x, 1.0 * _t1.y)).w)) + _169;
    float _t14 = ((_t2.x + _t2.y) + _t2.z) / 3.0;
    if (smoothstep(lowerLimit, upperLimit, ((_170 * _170) + (_188 * _188)) * brightness) > 0.5)
    {
        _t14 = min(smoothstep(0.0, u_edgeBrightness, _t14), _t2.w);
    }
    else
    {
        _t14 = _t2.w;
    }
    gl_FragData[0] = vec4(_43.xyz, _t14);
}

