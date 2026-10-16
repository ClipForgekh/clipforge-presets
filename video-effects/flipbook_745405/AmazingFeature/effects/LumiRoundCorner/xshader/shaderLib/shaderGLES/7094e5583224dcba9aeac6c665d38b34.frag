precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform float u_radius;
uniform float u_fade0;
uniform float u_fade1;
uniform mediump sampler2D u_inputTexture;

varying vec2 v_p;

void main()
{
    vec2 _16 = u_ScreenParams.xy * 0.5;
    vec2 _35 = ((((v_p / u_ScreenParams.xy) - vec2(0.5)) * 1.019999980926513671875) + vec2(0.5)) * u_ScreenParams.xy;
    vec2 _47 = abs(_35 - _16) - (_16 - vec2(u_radius));
    vec2 _t2 = _47;
    gl_FragData[0] = texture2D(u_inputTexture, _35 / u_ScreenParams.xy) * smoothstep(u_fade0, u_fade1, -((length(max(_47, vec2(0.0))) + min(max(_t2.x, _t2.y), 0.0)) - u_radius));
    float _92 = gl_FragData[0].w;
    vec4 _96 = gl_FragData[0];
    vec3 _99 = _96.xyz / vec3(max(_92, 9.9999997473787516355514526367188e-06));
    gl_FragData[0].x = _99.x;
    gl_FragData[0].y = _99.y;
    gl_FragData[0].z = _99.z;
}

