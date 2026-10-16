precision lowp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;

uniform float xL;
uniform float xR;
uniform float xT;
uniform float xB;
uniform float isShuPing;

float remapX(float oriU) {
    float u = (oriU - xL)/(xR-xL);
    float p0 = step(u, 0.0);
    float p1 = (1.0-p0)* step(u, 1.0);
    float p2 = step(1.0, u);
    float res = p0* (-u) + p1* u + p2* (2.0-u);
    return res;
}

float remapY(float oriU) {
    float u = (oriU - xT)/(xB-xT);
    float p0 = step(u, 0.0);
    float p1 = (1.0-p0)* step(u, 1.0);
    float p2 = step(1.0, u);
    float res = p0* (-u) + p1* u + p2* (2.0-u);
    return res;
}

void main()
{
    vec2 remapX_uv = vec2(remapX(uv0.x), uv0.y);
    vec2 remapY_uv = vec2((uv0.x), remapY(uv0.y));
    vec2 remap_uv = mix(remapY_uv, remapX_uv, isShuPing);
    gl_FragColor = texture2D(u_InputTexture, remap_uv);

    // gl_FragColor = texture2D(u_InputTexture, uv0);
}
