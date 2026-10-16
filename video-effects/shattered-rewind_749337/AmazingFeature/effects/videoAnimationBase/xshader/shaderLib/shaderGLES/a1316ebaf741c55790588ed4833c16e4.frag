precision highp float;
precision highp int;

uniform mediump sampler2D u_blendTex;
uniform mediump sampler2D u_bgTex;
uniform mediump sampler2D u_videoTex;
uniform float u_blendAlpha;
uniform float u_prograss;

varying vec2 v_uv;

void main()
{
    mediump vec4 _29 = texture2D(u_videoTex, v_uv);
    vec4 _t2 = _29;
    float _44 = _t2.w;
    vec4 _48 = vec4((texture2D(u_blendTex, v_uv).xyz * u_blendAlpha) + _29.xyz, _44);
    _t2 = _48;
    gl_FragData[0] = mix(_48, texture2D(u_bgTex, v_uv), vec4(u_prograss));
}

