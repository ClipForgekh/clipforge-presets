precision highp float;

varying vec2 uv0;
uniform sampler2D inputTex;
uniform vec2 threshould;
uniform vec4 u_ScreenParams;

void main()
{
    vec4 input_col = texture2D(inputTex, uv0);
    float grey = dot(input_col.rgb, vec3(0.299, 0.578, 0.114));
    float lightness = smoothstep(threshould.x, threshould.y, grey);
    vec4 res = vec4(lightness);
    gl_FragColor = res;
}
