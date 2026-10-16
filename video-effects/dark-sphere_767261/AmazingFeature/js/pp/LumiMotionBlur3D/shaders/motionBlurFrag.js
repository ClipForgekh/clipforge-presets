exports.motionBlurFrag=`
precision highp float;

uniform sampler2D u_inputTex;
uniform float u_alpha;
uniform float u_center;
uniform float u_samples;
uniform float u_dither;
uniform float u_mirrorEdge;
uniform float u_skipSample; // float used instead of int

// --- MVP Matrices split into 4 vec4s ---
uniform vec4 u_mvMat0_0; uniform vec4 u_mvMat0_1; uniform vec4 u_mvMat0_2; uniform vec4 u_mvMat0_3;
uniform vec4 u_mvMat1_0; uniform vec4 u_mvMat1_1; uniform vec4 u_mvMat1_2; uniform vec4 u_mvMat1_3;
uniform vec4 u_mvMat2_0; uniform vec4 u_mvMat2_1; uniform vec4 u_mvMat2_2; uniform vec4 u_mvMat2_3;
uniform vec4 u_mvMat3_0; uniform vec4 u_mvMat3_1; uniform vec4 u_mvMat3_2; uniform vec4 u_mvMat3_3;
uniform vec4 u_mvMat4_0; uniform vec4 u_mvMat4_1; uniform vec4 u_mvMat4_2; uniform vec4 u_mvMat4_3;
uniform vec4 u_mvMat5_0; uniform vec4 u_mvMat5_1; uniform vec4 u_mvMat5_2; uniform vec4 u_mvMat5_3;

// --- Projection Matrices split into 4 vec4s ---
uniform vec4 u_pMat0_0; uniform vec4 u_pMat0_1; uniform vec4 u_pMat0_2; uniform vec4 u_pMat0_3;
uniform vec4 u_pMat1_0; uniform vec4 u_pMat1_1; uniform vec4 u_pMat1_2; uniform vec4 u_pMat1_3;
uniform vec4 u_pMat2_0; uniform vec4 u_pMat2_1; uniform vec4 u_pMat2_2; uniform vec4 u_pMat2_3;
uniform vec4 u_pMat3_0; uniform vec4 u_pMat3_1; uniform vec4 u_pMat3_2; uniform vec4 u_pMat3_3;
uniform vec4 u_pMat4_0; uniform vec4 u_pMat4_1; uniform vec4 u_pMat4_2; uniform vec4 u_pMat4_3;
uniform vec4 u_pMat5_0; uniform vec4 u_pMat5_1; uniform vec4 u_pMat5_2; uniform vec4 u_pMat5_3;

varying vec2 v_uv;

#define kSamplesPerFrame 50.0

mat4 buildMat4(vec4 c0, vec4 c1, vec4 c2, vec4 c3) {
    return mat4(c0, c1, c2, c3);
}

vec2 uvMirror(vec2 x) {
    return abs(mod(x - 1.0, 2.0) - 1.0);
}

vec4 hit(vec3 orig, vec3 dir, vec3 a, vec3 b, vec3 c) {
    const float eps = 1e-7;
    vec3 ab = b - a;
    vec3 ac = c - a;

    vec3 n = cross(dir, ac);
    float det = dot(ab, n);

    if (det <= eps) {
        return vec4(-1.0, -1.0, -1.0, -1.0);
    }
    
    vec3 ao = orig - a;
    float u = dot(ao, n) / det;
    if (u < 0.0 || u > 1.0) {
        return vec4(-1.0, -1.0, -1.0, -1.0);
    }

    vec3 e = cross(ao, ab);
    float v = dot(dir, e) / det;
    if (v < 0.0 || u + v > 1.0) {
        return vec4(-1.0, -1.0, -1.0, -1.0);
    }

    float t = dot(ac, e) / det;
    return vec4(u, v, t, 1.0);
}

vec2 hitRect(mat4 mvM, mat4 pM, vec2 uv) {
    const float eps = 1e-7;
    const float boundEps = 1e-5;
    const vec2 c1 = vec2(-4.5, -4.5);
    const vec2 c2 = vec2(5.5, -4.5);
    const vec2 c3 = vec2(-4.5, 5.5);
    const vec2 c4 = vec2(5.5, 5.5);
    
    vec3 a = (mvM * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 b = (mvM * vec4(10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 c = (mvM * vec4(-10.0, 10.0, 0.0, 1.0)).xyz;
    
    vec4 pos = pM * vec4(uv * 2.0 - 1.0, 0.0, 1.0);
    vec3 p = pos.xyz / pos.w;
    vec3 camera = vec3(0.0);
    vec3 dir = normalize(p - camera);

    vec3 e1 = b - a;
    vec3 e2 = c - a;
    vec3 n = cross(e1, e2);
    float denom = dot(n, dir);
    
    if (denom >= -eps) {
        return vec2(-10000.0);
    }
    
    float t = dot(a - camera, n) / denom;
    if (t <= 0.0) {
        return vec2(-10000.0);
    }
    
    vec3 q = camera + t * dir;
    vec3 v = q - a;
    
    float dot11 = dot(e1, e1);
    float dot12 = dot(e1, e2);
    float dot22 = dot(e2, e2);
    float dot1v = dot(e1, v);
    float dot2v = dot(e2, v);

    float det = dot11 * dot22 - dot12 * dot12;
    if (abs(det) <= eps) {
        return vec2(-10000.0);
    }
    
    float invDet = 1.0 / det;
    float s = (dot22 * dot1v - dot12 * dot2v) * invDet;
    float tt = (dot11 * dot2v - dot12 * dot1v) * invDet;
    
    if (s < -boundEps || s > 1.0 + boundEps || tt < -boundEps || tt > 1.0 + boundEps) {
        return vec2(-10000.0);
    }
    
    s = clamp(s, 0.0, 1.0);
    tt = clamp(tt, 0.0, 1.0);
    return mix(mix(c1, c2, s), mix(c3, c4, s), tt);
}

float uvProtect(vec2 uvTemp) {
    return step(0.0, uvTemp.x) * step(0.0, uvTemp.y) * step(uvTemp.x, 1.0) * step(uvTemp.y, 1.0);
}

vec2 interUV(float w, vec2 uv_0, vec2 uv_1, vec2 uv_2, vec2 uv_3, vec2 uv_4, vec2 uv_5) {
    return mix(uv_0, uv_1, w * 5.0) * step(w, 0.2) +
           mix(uv_1, uv_2, w * 5.0 - 1.0) * (1.0 - step(w, 0.2)) * step(w, 0.4) +
           mix(uv_2, uv_3, w * 5.0 - 2.0) * (1.0 - step(w, 0.4)) * step(w, 0.6) +
           mix(uv_3, uv_4, w * 5.0 - 3.0) * (1.0 - step(w, 0.6)) * step(w, 0.8) +
           mix(uv_4, uv_5, w * 5.0 - 4.0) * (1.0 - step(w, 0.8));
}

float hash21(float p, float seed) {
    vec2 p2 = fract(vec2(p, seed) * 13.517);
    p2 += dot(p2, p2.yx + 22.541);
    return fract((p2.x + p2.y) * p2.y);
}

void main() {
    // 动态组装当前所需的矩阵
    mat4 mvMat0 = buildMat4(u_mvMat0_0, u_mvMat0_1, u_mvMat0_2, u_mvMat0_3);
    mat4 pMat0  = buildMat4(u_pMat0_0, u_pMat0_1, u_pMat0_2, u_pMat0_3);

    if (u_skipSample > 0.5) {
        vec2 uv = hitRect(mvMat0, pMat0, v_uv);
        uv = step(u_mirrorEdge, 0.5) * uv + (1.0 - step(u_mirrorEdge, 0.5)) * uvMirror(uv);
        gl_FragColor = texture2D(u_inputTex, uv) * u_alpha * uvProtect(uv);
        return;
    }
    
    mat4 mvMat1 = buildMat4(u_mvMat1_0, u_mvMat1_1, u_mvMat1_2, u_mvMat1_3);
    mat4 pMat1  = buildMat4(u_pMat1_0, u_pMat1_1, u_pMat1_2, u_pMat1_3);
    mat4 mvMat2 = buildMat4(u_mvMat2_0, u_mvMat2_1, u_mvMat2_2, u_mvMat2_3);
    mat4 pMat2  = buildMat4(u_pMat2_0, u_pMat2_1, u_pMat2_2, u_pMat2_3);
    mat4 mvMat3 = buildMat4(u_mvMat3_0, u_mvMat3_1, u_mvMat3_2, u_mvMat3_3);
    mat4 pMat3  = buildMat4(u_pMat3_0, u_pMat3_1, u_pMat3_2, u_pMat3_3);
    mat4 mvMat4 = buildMat4(u_mvMat4_0, u_mvMat4_1, u_mvMat4_2, u_mvMat4_3);
    mat4 pMat4  = buildMat4(u_pMat4_0, u_pMat4_1, u_pMat4_2, u_pMat4_3);
    mat4 mvMat5 = buildMat4(u_mvMat5_0, u_mvMat5_1, u_mvMat5_2, u_mvMat5_3);
    mat4 pMat5  = buildMat4(u_pMat5_0, u_pMat5_1, u_pMat5_2, u_pMat5_3);

    vec2 uv_0 = hitRect(mvMat0, pMat0, v_uv);
    vec2 uv_1 = hitRect(mvMat1, pMat1, v_uv);
    vec2 uv_2 = hitRect(mvMat2, pMat2, v_uv);
    vec2 uv_3 = hitRect(mvMat3, pMat3, v_uv);
    vec2 uv_4 = hitRect(mvMat4, pMat4, v_uv);
    vec2 uv_5 = hitRect(mvMat5, pMat5, v_uv);

    vec4 res = vec4(0.0);
    for (float i = 0.0; i <= kSamplesPerFrame; i += 1.0) {
        if (i >= u_samples) {
            break;
        }

        float denom = max(u_samples - 1.0, 1e-6);
        float w = i / denom;
        w += u_dither * (hash21(i + v_uv.x, i * v_uv.y) - 0.5) / max(u_samples, 1.0);
        
        vec2 uv = interUV(w, uv_0, uv_1, uv_2, uv_3, uv_4, uv_5);
        uv = step(u_mirrorEdge, 0.5) * uv + (1.0 - step(u_mirrorEdge, 0.5)) * uvMirror(uv);
        res += texture2D(u_inputTex, uv) * u_alpha * uvProtect(uv);
    }
    
    res /= u_samples;
    gl_FragColor = res;
}
`;exports.source=exports.motionBlurFrag;