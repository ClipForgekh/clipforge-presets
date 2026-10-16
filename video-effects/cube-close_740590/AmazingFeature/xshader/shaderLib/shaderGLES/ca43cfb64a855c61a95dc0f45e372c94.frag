precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform mediump sampler2D u_inputTexture2;

varying vec2 v_uv;

void main()
{
    mediump vec4 _22 = texture2D(u_inputTexture, v_uv);
    mediump vec4 _t1 = _22;
    mediump vec4 _27 = texture2D(u_inputTexture2, v_uv);
    mediump vec4 _t2 = _27;
    mediump vec3 _34 = _27.xyz - vec3(0.00999999977648258209228515625);
    _t2.x = _34.x;
    _t2.y = _34.y;
    _t2.z = _34.z;
    mediump vec4 _46 = _t2;
    mediump vec3 _54 = vec3(1.0) - pow(vec3(1.0) - _46.xyz, vec3(0.2857142984867095947265625));
    _t2.x = _54.x;
    _t2.y = _54.y;
    _t2.z = _54.z;
    mediump vec4 _61 = _t2;
    mediump vec4 _64 = clamp(_61, vec4(0.0), vec4(1.0));
    _t2 = _64;
    mediump float _69 = _t1.w;
    mediump vec4 _72 = _22 + (_64 * (1.0 - _69));
    _t1 = _72;
    gl_FragData[0] = _72;
}

