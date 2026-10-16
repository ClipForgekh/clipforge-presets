precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTex;
vec4 encode(float gray) {
    vec4 res = vec4(0.0, 0.0, 0.0, 0.0);
    gray *= 255.0;
    res.x = floor(gray) / 255.0;
    gray = fract(gray);
    gray *= 255.0;
    res.y = floor(gray) / 255.0;
    gray = fract(gray);
    gray *= 255.0;
    res.z = floor(gray) / 255.0;
    gray = fract(gray);
    res.w = gray;
    return res;
}
void main()
{
    float alpha = texture2D(u_inputTex, uv0).a;
    gl_FragColor = encode(alpha);
}
