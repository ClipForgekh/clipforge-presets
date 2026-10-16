precision highp float;
precision highp int;

uniform float inputWidth;
uniform float inputHeight;
uniform mat4 u_InvModel;
uniform mediump sampler2D u_inputTexture;

varying vec2 v_uv;

float cut(vec2 _u)
{
    return ((step(0.0, v_uv.x) * step(v_uv.x, 1.0)) * step(0.0, v_uv.y)) * step(v_uv.y, 1.0);
}

void main()
{
    float _45 = inputWidth / inputHeight;
    vec2 uv_ori = v_uv * vec2(_45, 1.0);
    uv_ori = (u_InvModel * vec4(uv_ori.x * 2.0 + (-_45), uv_ori.y * 2.0 + (-1.0), 0.0, 1.0)).xy;
    uv_ori.x = ((uv_ori.x / _45) + 1.0) * 0.5;
    uv_ori.y = (uv_ori.y + 1.0) * 0.5;
    float _131 = uv_ori.x;
    float _137 = uv_ori.y;
    vec2 _142 = vec2(1.0 - abs(abs(_131) - 1.0), 1.0 - abs(abs(_137) - 1.0));
    uv_ori = _142;
    vec2 param = _142;
    gl_FragData[0] = texture2D(u_inputTexture, _142) * cut(param);
}

