exports.source=`
uniform vec4 u_ScreenParams;
uniform float u_Complexity;
uniform float u_Evolution;
uniform float u_Cycle;

uniform vec2 u_Scale;
uniform vec2 u_Offset;
uniform float u_Rotate;
uniform float u_SubImpact;
uniform float u_SubScale;
uniform float u_SubRotate;
uniform vec2 u_SubOffset;
uniform float u_type;

varying vec2 vUv;

#define PI 3.1415926
#define HASHSCALE3 vec3(.8031, .1030, .3973)

float hash21(vec2 p) {
    vec2 p2 = fract(p * 1324.518);
    p2 += dot(p2, p2.yx + 22.541);
    return fract((p2.x + p2.y) * p2.y);
}

vec2 random2(vec2 p, vec2 seed) {
    float n = hash21((p.xy));
    float n2 = 2.;
    float evolAngle = seed.x * 0.25 + n;
    float evolAngle0 = floor(evolAngle);
    float evolAngle1 = evolAngle0 + 1.0;
    
    if (u_Cycle >= 2.0) {
        evolAngle0 = floor(mod(evolAngle, u_Cycle));
        evolAngle1 = floor(mod(evolAngle + 1.0, u_Cycle));
    }
    
    vec2 pAngle2 = fract((p.xy) * (34.532 + evolAngle0 * n2 + (seed.y) * HASHSCALE3.x));
    pAngle2 += dot(pAngle2, pAngle2.yx + 15.434);
    vec2 resultAngle1 = fract((pAngle2.xy + pAngle2.yx + 0.523) * pAngle2.yx + n);
    
    vec2 pAngle22 = fract((p.xy) * (34.532 + evolAngle1 * n2 + (seed.y) * HASHSCALE3.x));
    pAngle22 += dot(pAngle22, pAngle22.yx + 15.434);
    vec2 resultAngle2 = fract((pAngle22.xy + pAngle22.yx + 0.523) * pAngle22.yx + n);

    float wAngle = fract(evolAngle);
    resultAngle2.y += 1.;
    float angleRand = mix(resultAngle1.y, resultAngle2.y, wAngle) * PI * 2.;

    float evolLine = seed.x * 2.0 + n;
    float evolLine0 = floor(evolLine);
    float evolLine1 = evolLine0 + 1.0;
    
    if (u_Cycle >= 2.0) {
        evolLine0 = floor(mod(evolLine, u_Cycle));
        evolLine1 = floor(mod(evolLine + 1.0, u_Cycle));
    }
    
    vec2 pLine2 = fract((p.xy) * (34.532 + evolLine0 * n2 + (seed.y) * HASHSCALE3.x));
    pLine2 += dot(pLine2, pLine2.yx + 15.434);
    vec2 resultLine1 = fract((pLine2.xy + pLine2.yx + 0.523) * pLine2.yx + n);
    
    vec2 pLine22 = fract((p.xy) * (34.532 + evolLine1 * n2 + (seed.y) * HASHSCALE3.x));
    pLine22 += dot(pLine22, pLine22.yx + 15.434);
    vec2 resultLine2 = fract((pLine22.xy + pLine22.yx + 0.523) * pLine22.yx + n);

    float wLine = fract(evolLine);
    float lineRand = mix(0.75, 1.0, mix(resultLine1.x, resultLine2.x, wLine));

    return vec2(cos(angleRand), sin(angleRand)) * lineRand;
}

// 🌟 1. 还原旋转算法
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
    
    vec2 factor = smoothstep(0.0, 1.0, _fuv);
    float ret = mix(
        mix(dot(n4, _fuv - ofs.yy), dot(n7, _fuv - ofs.zy), factor.x),
        mix(dot(n10, _fuv - ofs.yz), dot(n13, _fuv - ofs.zz), factor.x),
        factor.y
    );
    ret = ret * 0.5 + 0.5;
    return ret;
}

float gradient_noise(vec2 uv, float complexity, float evolution, float subImpact, float subScale, float subRotate, float rand, vec2 subOffset) {
    vec2 ratio = vec2(720.0) * u_ScreenParams.xy / min(u_ScreenParams.x, u_ScreenParams.y);
    float ic = floor(complexity);
    float fc = fract(complexity);
    float ie = evolution;
    
    float layer = interpolation(uv, vec2(ie, 1.0 + rand));
    float sumWeight = 1.0;
    float weight = subImpact;
    float sum = layer * 1.0;
    
    for (float i = 2.0; i <= 10.0; i += 1.0) {
        if (i > ic) break;
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

void main() {
    vec2 uv = vUv;
    uv -= u_Offset;
    
    // 🌟 2. 移除强行居中，恢复 1:1 的噪波相位系（保证扭曲的特征完全贴合原版）
    uv = rotate(uv, u_Rotate * PI / 180.0);
    uv = uv * (1. / max(u_Scale, vec2(0.001)));
    uv -= 10.0;

    float n1 = 0.5;
    float n2 = 0.5;
    if (u_type < 0.5) {
        n1 = gradient_noise(uv, clamp(u_Complexity, 1.0, 10.0), u_Evolution, u_SubImpact, 100.0 / u_SubScale, u_SubRotate, 2.11, u_SubOffset);
        n2 = gradient_noise(uv, clamp(u_Complexity, 1.0, 10.0), u_Evolution, u_SubImpact, 100.0 / u_SubScale, u_SubRotate, 9.71, u_SubOffset);
    } else {
        n1 = gradient_noise(vec2(0.5, uv.y), clamp(u_Complexity, 1.0, 10.0), u_Evolution, u_SubImpact, 100.0 / u_SubScale, u_SubRotate, 2.11, u_SubOffset);
        n2 = gradient_noise(vec2(uv.x, 0.5), clamp(u_Complexity, 1.0, 10.0), u_Evolution, u_SubImpact, 100.0 / u_SubScale, u_SubRotate, 9.71, u_SubOffset);
    }

    // 🌟 3. 输出纯净浮点，绕开 sRGB 伽马污染带来的偏移
    gl_FragColor = vec4(n1, n2, 0.0, 1.0);
}
`;