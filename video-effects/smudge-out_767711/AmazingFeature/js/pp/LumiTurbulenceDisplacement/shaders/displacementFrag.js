exports.source=`
uniform sampler2D tDiffuse; 
uniform sampler2D noiseTexture;
uniform vec4 u_ScreenParams;
uniform float u_Brightness;
uniform float u_Contrast;
uniform float u_Range;

uniform vec2 u_Scale;
uniform float u_type;
uniform float u_fix_type;
uniform float motion_tile_type;

varying vec2 vUv;

vec2 Mirror(vec2 x) {
    return abs(mod(x - 1., 2.) - 1.);
}

float cut(vec2 u) {
    return step(0., u.x) * step(u.x, 1.) * step(0., u.y) * step(u.y, 1.);
}

float colorAdjust(float c, float brightness, float contrast) {
    c += brightness;
    c = (c - 0.5) * contrast * 10.0 + 0.5;
    return c;
}

void main() {
    vec2 uv0 = vUv;
    
    // 🌟 原生读取 16 位浮点
    vec2 noise = texture2D(noiseTexture, uv0).xy;
    float n1 = noise.x;
    float n2 = noise.y;
    
    n1 = colorAdjust(n1, u_Brightness, u_Contrast);
    n2 = colorAdjust(n2, u_Brightness, u_Contrast);
    
    n1 = (n1 - 0.5) * min(u_ScreenParams.x, u_ScreenParams.y) / max(u_ScreenParams.x, 0.001) + 0.5;
    n2 = (n2 - 0.5) * min(u_ScreenParams.x, u_ScreenParams.y) / max(u_ScreenParams.y, 0.001) + 0.5;

    float ins = clamp(u_Scale.x, 0.01, 1.0) * u_Range;
    vec2 new_uv = uv0;
    
    if (u_type < 0.5) {
        new_uv = vec2(uv0.x + (n1 - 0.5) * ins, uv0.y + (n2 - 0.5) * ins);
    } else if (u_type < 1.5) {
        new_uv = vec2(uv0.x + (n1 - 0.5) * ins, uv0.y);
    } else if (u_type < 2.5) {
        new_uv = vec2(uv0.x, uv0.y + (n2 - 0.5) * ins);
    } else {
        new_uv = vec2(uv0.x + (n1 - 0.5) * ins, uv0.y + (n2 - 0.5) * ins);
    }

    if (u_fix_type < 0.5) {
    } else if (u_fix_type < 1.5) {
        if (uv0.x < 0.1) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, uv0.x));
        if (uv0.x > 0.9) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, 1.0 - uv0.x));
        if (uv0.y < 0.1) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, uv0.y));
        if (uv0.y > 0.9) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, 1.0 - uv0.y));
    } else if (u_fix_type < 2.5) {
        if (clamp(new_uv.x, 0.0, 1.0) == new_uv.x) {
            if (uv0.y < 0.1) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, uv0.y));
            if (uv0.y > 0.9) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, 1.0 - uv0.y));
        }
    } else if (u_fix_type < 3.5) {
        if (clamp(new_uv.y, 0.0, 1.0) == new_uv.y) {
            if (uv0.x < 0.1) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, uv0.x));
            if (uv0.x > 0.9) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, 1.0 - uv0.x));
        }
    } else if (u_fix_type < 4.5) {
        if (new_uv.x <= 1.0 && clamp(new_uv.y, 0.0, 1.0) == new_uv.y) {
            if (uv0.x < 0.1) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, uv0.x));
        }
    } else if (u_fix_type < 5.5) {
        if (new_uv.x >= 0.0 && clamp(new_uv.y, 0.0, 1.0) == new_uv.y) {
            if (uv0.x > 0.9) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, 1.0 - uv0.x));
        }
    } else if (u_fix_type < 6.5) {
        if (new_uv.y >= 0.0 && clamp(new_uv.x, 0.0, 1.0) == new_uv.x) {
            if (uv0.y > 0.9) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, 1.0 - uv0.y));
        }
    } else if (u_fix_type < 7.5) {
        if (new_uv.y <= 1.0 && clamp(new_uv.x, 0.0, 1.0) == new_uv.x) {
            if (uv0.y < 0.1) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, uv0.y));
        }
    } else if (u_fix_type < 8.5) {
        if (uv0.x < 0.1) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, uv0.x));
        if (uv0.x > 0.9) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, 1.0 - uv0.x));
        if (uv0.y < 0.1) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, uv0.y));
        if (uv0.y > 0.9) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, 1.0 - uv0.y));
        float w = 1.0;
        if (uv0.x < 0.1) w = min(w, uv0.x * 10.0);
        if (uv0.x > 0.9) w = min(w, (1.0 - uv0.x) * 10.0);
        if (uv0.y < 0.1) w = min(w, uv0.y * 10.0);
        if (uv0.y > 0.9) w = min(w, (1.0 - uv0.y) * 10.0);
        new_uv = mix(uv0, new_uv, w);
    } else if (u_fix_type < 9.5) {
        if (uv0.y < 0.1) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, uv0.y));
        if (uv0.y > 0.9) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, 1.0 - uv0.y));
        float w = 1.0;
        if (uv0.y < 0.1) w = min(w, uv0.y * 10.0);
        if (uv0.y > 0.9) w = min(w, (1.0 - uv0.y) * 10.0);
        new_uv = mix(uv0, new_uv, w);
    } else if (u_fix_type < 10.5) {
        if (uv0.x < 0.1) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, uv0.x));
        if (uv0.x > 0.9) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, 1.0 - uv0.x));
        float w = 1.0;
        if (uv0.x < 0.1) w = min(w, uv0.x * 10.0);
        if (uv0.x > 0.9) w = min(w, (1.0 - uv0.x) * 10.0);
        new_uv = mix(uv0, new_uv, w);
    } else if (u_fix_type < 11.5) {
        if (uv0.x < 0.1) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, uv0.x));
        float w = 1.0;
        if (uv0.x < 0.1) w = min(w, uv0.x * 10.0);
        new_uv = mix(uv0, new_uv, w);
    } else if (u_fix_type < 12.5) {
        if (uv0.x > 0.9) new_uv.x = mix(uv0.x, new_uv.x, smoothstep(0.0, 0.1, 1.0 - uv0.x));
        float w = 1.0;
        if (uv0.x > 0.9) w = min(w, (1.0 - uv0.x) * 10.0);
        new_uv = mix(uv0, new_uv, w);
    } else if (u_fix_type < 13.5) {
        if (uv0.y > 0.9) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, 1.0 - uv0.y));
        float w = 1.0;
        if (uv0.y > 0.9) w = min(w, (1.0 - uv0.y) * 10.0);
        new_uv = mix(uv0, new_uv, w);
    } else if (u_fix_type < 14.5) {
        if (uv0.y < 0.1) new_uv.y = mix(uv0.y, new_uv.y, smoothstep(0.0, 0.1, uv0.y));
        float w = 1.0;
        if (uv0.y < 0.1) w = min(w, uv0.y * 10.0);
        new_uv = mix(uv0, new_uv, w);
    }

    float mask = 1.;
    if (motion_tile_type < 0.5) {
        mask = cut(new_uv);
    } else if (motion_tile_type < 1.5) {
        new_uv = fract(new_uv);
    } else {
        new_uv = Mirror(new_uv);
    }
    
    vec4 res = texture2D(tDiffuse, new_uv);
    res *= mask;
    gl_FragColor = res;
}
`;