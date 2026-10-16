precision highp float;
precision highp int;

uniform mediump vec4 u_ScreenParams;
uniform mediump vec2 u_size;
uniform mediump sampler2D u_albedo;
uniform mediump float negativeAlpha;

varying vec2 v_uv;

mediump vec3 _f0(mediump vec3 _p0)
{
    return vec3(1.0) - _p0;
}

void main()
{
    mediump vec2 _t0 = v_uv;
    _t0.y = 1.0 - _t0.y;
    _t0 -= vec2(0.5);
    _t0.x *= (u_ScreenParams.x / u_size.x);
    _t0.y *= (u_ScreenParams.y / u_size.y);
    mediump vec2 _61 = _t0;
    mediump vec2 _63 = _61 + vec2(0.5);
    _t0 = _63;
    mediump vec4 _72 = texture2D(u_albedo, _63);
    mediump vec4 _t1 = _72;
    mediump vec4 _t2 = _72;
    mediump vec3 param = _72.xyz;
    mediump vec3 _78 = _f0(param);
    _t2.x = _78.x;
    _t2.y = _78.y;
    _t2.z = _78.z;
    mediump vec4 _86 = _t1;
    mediump vec3 _93 = mix(_86.xyz, _t2.xyz, vec3(negativeAlpha));
    _t1.x = _93.x;
    _t1.y = _93.y;
    _t1.z = _93.z;
    gl_FragData[0] = _t1;
}

