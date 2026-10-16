precision highp float;

#define KEYFRAMES 97
//#define MAX_STEP 2.5
#define Texture2D texture2Dmirror

uniform sampler2D u_sprite;
uniform vec2 u_screen_size;
uniform vec2 u_sprite_size;
uniform vec3 u_matrices[KEYFRAMES * 3];
uniform float u_opacity;

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
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}


void main () {
    vec3 P = vec3(v_uv * u_screen_size, 1.0);
    vec2 rSpriteSize = 1.0 / u_sprite_size;
    vec4 aColor = vec4(0.0);
    float aWeight = 0.0;
    for (int i = 1; i < KEYFRAMES; ++i) {
        mat3 M0 = mat3(u_matrices[i*3-3], u_matrices[i*3-2], u_matrices[i*3-1]);
        vec2 P0 = (M0 * P).xy;
    #ifdef MAX_STEP
        mat3 M1 = mat3(u_matrices[i*3], u_matrices[i*3+1], u_matrices[i*3+2]);
        vec2 P1 = (M1 * P).xy;
        float L = length(P1 - P0);
        float N = max(ceil(L / MAX_STEP), 1.0);
        for (int j = 0; j < int(N); ++j) {
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
    gl_FragColor = aColor / aWeight * u_opacity;
}