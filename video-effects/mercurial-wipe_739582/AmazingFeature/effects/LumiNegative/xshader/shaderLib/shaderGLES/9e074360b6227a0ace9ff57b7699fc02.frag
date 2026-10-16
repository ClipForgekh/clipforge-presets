precision highp float;
precision highp int;

uniform mediump sampler2D u_albedo;
uniform mediump float negativeAlpha;

varying vec2 v_uv;

vec4 _89;

void main()
{
    mediump vec4 _31 = texture2D(u_albedo, v_uv);
    mediump vec3 _36 = _31.xyz;
    mediump vec3 _75 = vec3(1.0) - _36;
    mediump vec4 _77 = _89;
    _77.x = _75.x;
    mediump vec4 _79 = _77;
    _79.y = _75.y;
    mediump vec4 _81 = _79;
    _81.z = _75.z;
    mediump vec3 _61 = mix(_36, _81.xyz, vec3(negativeAlpha));
    mediump vec4 _83 = _31;
    _83.x = _61.x;
    mediump vec4 _85 = _83;
    _85.y = _61.y;
    mediump vec4 _87 = _85;
    _87.z = _61.z;
    gl_FragData[0] = _87;
}

