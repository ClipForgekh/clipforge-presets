precision highp float;
precision highp int;

uniform float inputWidth;
uniform float inputHeight;
uniform mat4 u_InvModel;
uniform mediump sampler2D u_inputTexture;

varying vec2 v_uv;

float _f0(vec2 _p0)
{
    return ((step(0.0, v_uv.x) * step(v_uv.x, 1.0)) * step(0.0, v_uv.y)) * step(v_uv.y, 1.0);
}

void main()
{
    float _45 = inputWidth / inputHeight;
    vec2 _t5 = v_uv * vec2(_45, 1.0);
    _t5 = (u_InvModel * vec4((_t5.x * 2.0) - _45, (_t5.y * 2.0) - 1.0, 0.0, 1.0)).xy;
    _t5.x = ((_t5.x / _45) + 1.0) / 2.0;
    _t5.y = (_t5.y + 1.0) / 2.0;
    float _131 = _t5.x;
    float _137 = _t5.y;
    vec2 _142 = vec2(1.0 - abs(abs(_131) - 1.0), 1.0 - abs(abs(_137) - 1.0));
    _t5 = _142;
    vec2 param = _142;
    gl_FragData[0] = texture2D(u_inputTexture, _142) * _f0(param);
}

