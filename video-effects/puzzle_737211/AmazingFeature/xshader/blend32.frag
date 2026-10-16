precision highp float;

uniform sampler2D u_tex3d;
uniform float u_opacity3d;
uniform sampler2D u_tex2d;
uniform float u_opacity2d;

varying vec2 v_uv;


void main () {
    vec4 base = vec4(0.0, 0.0, 0.0, 0.0);

    vec4 tex3 = texture2D(u_tex3d, v_uv) * u_opacity3d;
    base = tex3 + base * (1.0 - tex3.a);

    vec4 tex2 = texture2D(u_tex2d, v_uv) * u_opacity2d;
    base = tex2 + base * (1.0 - tex2.a);

    gl_FragColor = base;
}