precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTex;
uniform mediump float u_negativeAlpha;

varying vec2 v_uv;

void main()
{
    mediump vec4 _19 = texture2D(u_inputTex, v_uv);
    mediump vec4 _t0 = _19;
    mediump vec4 _t1 = _19;
    mediump vec3 _25 = _19.xyz;
    mediump vec3 _27 = vec3(1.0) - _25;
    _t1.x = _27.x;
    _t1.y = _27.y;
    _t1.z = _27.z;
    mediump vec3 _47 = mix(_25, _t1.xyz, vec3(u_negativeAlpha));
    _t0.x = _47.x;
    _t0.y = _47.y;
    _t0.z = _47.z;
    gl_FragData[0] = _t0;
}

