precision highp float;
precision highp int;

uniform float u_offsety;
uniform vec2 u_scale;
uniform mediump sampler2D _MaskMp4;
uniform vec2 u_scale2;
uniform mediump sampler2D u_inputTexture2;

varying vec2 v_uv;

void main()
{
    vec2 _22 = vec2(v_uv.x, 1.0 - v_uv.y);
    vec2 _29 = vec2(0.0, u_offsety);
    vec2 _30 = _22 + _29;
    vec2 _t1 = _30;
    vec2 _35 = _22 - _29;
    vec2 _t2 = _35;
    float _41 = step(0.5, _t1.y);
    float _46 = 1.0 - step(0.5, _t2.y);
    vec2 _57 = mix(_35, _30, vec2(_41)) - vec2(0.5);
    mediump vec4 _75 = texture2D(_MaskMp4, (_57 / u_scale) + vec2(0.5));
    mediump vec4 _90 = texture2D(u_inputTexture2, (_57 / u_scale2) + vec2(0.5));
    vec4 _t9 = _90 * _41;
    vec4 _t10 = _90 * _46;
    gl_FragData[0] = clamp(((_75 * _41) * (1.0 - smoothstep(0.5, 0.89999997615814208984375, _t9.x))) + ((_75 * _46) * (1.0 - smoothstep(0.5, 0.89999997615814208984375, _t10.x))), vec4(0.0), vec4(1.0));
}

