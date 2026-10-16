precision highp float;

//#define MAX_STEP 2.5
#define MAX_STEPS 8
#define KEYFRAMES 16
#define Texture2D texture2Dmirror

uniform sampler2D u_sprite;
uniform vec2 u_screen_size;
uniform vec2 u_sprite_size;
uniform vec3 u_matrices[KEYFRAMES * 3 + 3];

varying vec2 v_uv;


vec4 texture2Dclamp (sampler2D tex, vec2 uv) {
    vec4 color = texture2D(tex, uv);
    uv = step(vec2(0.0), uv) * step(uv, vec2(1.0));
    return color * uv[0] * uv[1];
}

vec4 texture2DclampToEdge (sampler2D tex, vec2 uv) {
    return texture2D(tex, clamp(uv, 0.0, 1.0));
}

vec4 texture2Drepeat (sampler2D tex, vec2 uv) {
    return texture2D(tex, fract(uv));
}

vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = abs(mod(uv + 1.0, 2.0) - 1.0);
    return texture2D(tex, uv);
}


void main () {
    vec3 P = vec3(v_uv * u_screen_size, 1.0);
    vec2 rSpriteSize = 1.0 / u_sprite_size;
    vec4 aColor = vec4(0.0);
    float aWeight = 0.0;
    for (int i = 0; i < KEYFRAMES; ++i) {
        mat3 M0 = mat3(u_matrices[i*3+0], u_matrices[i*3+1], u_matrices[i*3+2]);
        vec2 P0 = (M0 * P).xy;
    #ifdef MAX_STEP
        mat3 M1 = mat3(u_matrices[i*3+3], u_matrices[i*3+4], u_matrices[i*3+5]);
        vec2 P1 = (M1 * P).xy;
        float L = length(P1 - P0);
        float N = clamp(ceil(L / MAX_STEP), 1.0, float(MAX_STEPS));
        for (int j = 0; j < MAX_STEPS; ++j) {
            if (float(j) >= N) break;
            float t = float(j) / N;
            vec2 uv = mix(P0, P1, t) * rSpriteSize;
            aColor += Texture2D(u_sprite, uv);
            aWeight += 1.0;
        }
    #else
        aColor += Texture2D(u_sprite, P0 * rSpriteSize);
        aWeight += 1.0;
    #endif
    }
    gl_FragColor = aColor / aWeight;
}