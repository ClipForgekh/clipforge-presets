precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform sampler2D maskTex;
uniform vec4 u_ScreenParams;
uniform float time;
uniform float intensity;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(62.9898,78.233)))*
        437598.5453123);
}

float noise(vec2 st) {
    vec2 pi = floor(st);
    vec2 pf = fract(st);

    // Four corners in 2D of a tile
    float a = random(pi);
    float b = random(pi + vec2(1.0, 0.0));
    float c = random(pi + vec2(0.0, 1.0));
    float d = random(pi + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 w = pf*pf*(3.0-2.0*pf);
    // w = smoothstep(0.,1.,pf);

    // Mix 4 coorners percentages
    return mix(a, b, w.x) +
            (c - a)* w.y * (1.0 - w.x) +
            (d - b) * w.x * w.y;
}

float noise_sum(vec2 p)
{
    float pf = 0.0;
    p = p * 4.0;
    pf += 1.0000 * noise(p); p = 2.0 * p;
    pf += 0.5000 * noise(p); p = 2.0 * p;
    pf += 0.2500 * noise(p); p = 2.0 * p;
    pf += 0.1250 * noise(p); p = 2.0 * p;
    pf += 0.0625 * noise(p); p = 2.0 * p;

   return pf / 1.9375;
}

void main()
{
    vec2 uv1 = uv0;
    vec2 unit = u_ScreenParams.zw - 1.;
    float myNoise0 = noise_sum((uv0 - .5 + sin(6.28 * time * 10.)) * (5.) + .5);
    float myNoise1 = noise_sum((uv0 - .5 + sin(6.28 * time * 10. + 9.32)) * (5.) + .5);
    myNoise0 = clamp((myNoise0 - .5) * .5 + .5, 0., 1.);
    myNoise1 = clamp((myNoise1 - .5) * .5 + .5, 0., 1.);
    uv1 += vec2((myNoise0 - .5) * 2., (myNoise1 - .5) * 2.) * unit * 20. * intensity;
    // vec4 curColor = texture2D(u_albedo, uv0);
    vec2 uv2 = vec2(uv0.x, 1. - uv0.y);
    float maskVal = texture2D(maskTex, uv2).r;
    for (int i = -1; i <= 1; ++i){
        for (int j = -1; j <= 1; ++j) {
            maskVal = max(maskVal, texture2D(maskTex, uv2 + unit * 10. * vec2(i, j)).r);
        }
    }
    float maskVal1 = texture2D(maskTex, vec2(uv1.x, 1. - uv1.y)).r;
    uv1 = mix(uv1, uv0, max(maskVal, maskVal1));
    vec4 resultColor = texture2D(u_albedo, uv1);
    // resultColor = vec4(maskVal);
    gl_FragColor = resultColor;
}
