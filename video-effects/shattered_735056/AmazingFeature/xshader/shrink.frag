precision lowp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;

uniform float xL;
uniform float xR;
uniform float xT;
uniform float xB;
uniform float isShuPing;

float remapX(float u) {
    float res = xL + (xR-xL)* u;
    return res;
}

float remapY(float u) {
    float res = xT + (xB-xT)* u;
    return res;
}

void main()
{
    vec2 remapX_uv = vec2(remapX(uv0.x), uv0.y);
    vec2 remapY_uv = vec2((uv0.x), remapY(uv0.y));
    vec2 remap_uv = mix(remapY_uv, remapX_uv, isShuPing);

    vec4 result = texture2D(u_InputTexture, remap_uv);
    gl_FragColor = result;
}
