precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform float y_offset;
uniform float alpha;

void main()
{
    vec2 uv1 = uv0;
    uv1.y += y_offset;
    uv1.y -= 0.5;
    uv1.y *= .5;
    uv1.y += 0.5;
    // uv1.y += y_offset;
    vec4 res = texture2D(inputTex, uv1);
    gl_FragColor = res;
}
