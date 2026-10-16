precision highp float;

varying vec2 uv0;

uniform sampler2D fishTex;
uniform sampler2D blurTex;
uniform sampler2D obTex;
uniform vec2 u_ScreenParams;
uniform vec2 circle;
uniform float progress;

void main()
{
    vec2 uv1 = uv0;

    vec4 fishCol = texture2D(fishTex, uv1);
    vec4 blurCol = texture2D(blurTex, uv1);

    vec2 uv2 = uv1-0.5;
    uv2.x *= u_ScreenParams.x/u_ScreenParams.y;
    float d = length(uv2) * 2.;
    d = smoothstep(circle.x, circle.x + circle.y, d);
    vec4 res = mix(blurCol, fishCol, d);


    // res = texture2D(obTex, uv1);
    gl_FragColor = res;
}
