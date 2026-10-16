exports.source=`
varying vec2 v_uv;
uniform sampler2D inputImageTexture;
uniform sampler2D blurImageTexture;
uniform vec4 u_ScreenParams;
uniform float u_Complexity;
uniform float u_Evolution;
uniform float u_Cycle;
uniform float u_Brightness;
uniform float u_Contrast;

uniform vec2 u_Scale;
uniform vec2 u_Offset;
uniform float u_Rotate;
uniform float u_SubImpact;
uniform float u_SubScale;
uniform float u_SubRotate;
uniform vec2 u_SubOffset;
uniform float edgeSmooth;
uniform float edgeOffset;
uniform float blurSize;

#define PI 3.1415926
#define EPS 0.001
#define HASHSCALE3 vec3(.8031, .1030, .3973)

float hash21(vec2 p) {
    vec2 p2 = fract(p * 1324.518);
    p2 += dot(p2, p2.yx + 22.541);
    return fract((p2.x + p2.y) * p2.y);
}

vec2 random2(vec2 p, vec2 seed) {
    float n = hash21((p.xy));
    float n2 = 4.412;
    float evol = seed.x + n;
    float evol0 = floor(evol);
    float evol1 = evol0 + 1.0;
    if (u_Cycle >= 2.0) {
        evol0 = floor(mod(evol, u_Cycle));
        evol1 = floor(mod(evol + 1.0, u_Cycle));
    }
    vec2 p2 = fract((p.xy) * (34.532 + evol0 * n2 + (seed.y) * HASHSCALE3.x));
    p2 += dot(p2, p2.yx + 15.434);
    vec2 result1 = fract((p2.xy + p2.yx + 0.523) * p2.yx + n);
    vec2 p22 = fract((p.xy) * (34.532 + evol1 * n2 + (seed.y) * HASHSCALE3.x));
    p22 += dot(p22, p22.yx + 15.434);
    vec2 result2 = fract((p22.xy + p22.yx + 0.523) * p22.yx + n);
    return mix(result1, result2, fract(evol)) * 2.0 - 1.0;
}

vec2 rotate(vec2 uv, float theta) {
    uv.y *= u_ScreenParams.y / u_ScreenParams.x;
    float sint = sin(theta);
    float cost = cos(theta);
    mat2 rot = mat2(cost, sint, -sint, cost);
    uv -= 0.5;
    uv = rot * uv;
    uv += 0.5;
    uv.y *= u_ScreenParams.x / u_ScreenParams.y;
    return uv;
}

float interpolation(vec2 uv, vec2 seed) {
    vec2 ratio = vec2(720.0) * u_ScreenParams.xy / min(u_ScreenParams.x, u_ScreenParams.y);
    vec2 _uv = floor(uv * ratio / 100.0);
    vec2 _fuv = fract(uv * ratio / 100.0);
    vec4 ofs = vec4(-1.0, 0.0, 1.0, 2.0);
    vec2 n4 = random2(_uv + ofs.yy, seed);
    vec2 n7 = random2(_uv + ofs.zy, seed);
    vec2 n10 = random2(_uv + ofs.yz, seed);
    vec2 n13 = random2(_uv + ofs.zz, seed);
    vec2 factor = _fuv * _fuv * _fuv * (_fuv * (_fuv * 6.0 - 15.0) + 10.0);
    float ret = mix(mix(dot(n4, _fuv - ofs.yy), dot(n7, _fuv - ofs.zy), factor.x),
                    mix(dot(n10, _fuv - ofs.yz), dot(n13, _fuv - ofs.zz), factor.x), factor.y);
    return ret * 0.5 + 0.5;
}

float gradient_noise(vec2 uv, float complexity, float evolution, float subImpact, float subScale, float subRotate, float rand, vec2 subOffset) {
    vec2 ratio = vec2(720.0) * u_ScreenParams.xy / min(u_ScreenParams.x, u_ScreenParams.y);
    float ic = floor(complexity);
    float fc = fract(complexity);
    float ie = evolution;
    float layer = interpolation(uv, vec2(ie, 1.0 + rand));
    float sumWeight = 1.0;
    float weight = subImpact;
    float sum = layer;
    for (int i = 2; i <= 10; i++) {
        float fi = float(i);
        if (fi > ic) break;
        uv -= subOffset / ratio;
        uv = rotate(uv, subRotate * PI / 180.0);
        uv *= subScale;
        layer = interpolation(uv, vec2(ie, 1.0 + rand)) * weight;
        sumWeight += weight;
        weight *= subImpact;
        sum += layer;
    }
    uv -= subOffset / ratio;
    uv = rotate(uv, subRotate * PI / 180.0);
    uv *= subScale;
    layer = interpolation(uv, vec2(ie, 1.0 + rand)) * weight * fc;
    sumWeight += weight * fc;
    sum += layer;
    sum /= sumWeight;
    return clamp(sum, 0.0, 1.0);
}

float colorAdjust(float c, float brightness, float contrast) {
    c += brightness;
    c = (c - 0.5) * (contrast + 1.0) + 0.5;
    return c;
}

void main() {
    vec2 uv = v_uv;
    uv -= u_Offset;
    uv -= 0.5;
    uv = uv * (1.0 / u_Scale);
    uv += 0.5;
    uv = rotate(uv, u_Rotate * PI / 180.0);
    uv -= 10.0;

    float n1 = gradient_noise(uv, clamp(u_Complexity, 1.0, 10.0), u_Evolution, u_SubImpact, 100.0 / u_SubScale, u_SubRotate, 0.0, u_SubOffset);
    n1 = colorAdjust(n1, u_Brightness, u_Contrast);
    n1 = clamp(n1, 0.0, 1.0);

    vec4 blurColor = texture2D(blurImageTexture, v_uv);
    vec4 color = texture2D(inputImageTexture, v_uv);
    
    if (blurSize < 1.0) {
        gl_FragColor = color;
        return;
    }
    
    blurColor.rgb /= (blurColor.a + EPS);
    color.rgb /= (color.a + EPS);

    n1 = mix(n1, 1.0, max(blurColor.a, EPS));
    blurColor.a *= n1;
    float edgeOffset0 = (edgeOffset - 0.5) * 0.5 + 0.5;
    float left = 0.0 + edgeSmooth * edgeOffset0;
    float right = max(left, 1.0 - edgeSmooth * (1.0 - edgeOffset0));
    blurColor.a = smoothstep(left, right, blurColor.a);
    blurColor.rgb = mix(blurColor.rgb, color.rgb, blurColor.a * color.a);
    blurColor.rgb *= blurColor.a;
    gl_FragColor = blurColor;
}
`;