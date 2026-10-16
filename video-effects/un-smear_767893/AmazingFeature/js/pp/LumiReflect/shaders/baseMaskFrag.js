exports.baseMaskFrag=`
precision highp float;

uniform sampler2D u_inputTexture;
uniform vec4 u_ScreenParams;
uniform vec3 u_tintColor;
uniform float u_reflectionAngle;
uniform float u_lineOffsetY;
uniform float u_lineOffsetX;
uniform float u_opacity;
uniform float u_reflectionFalloff;
uniform float u_reflectionDistance;
uniform float u_fixDistance;

varying vec2 v_uv;

vec2 rotate(vec2 uv, vec2 center, float angle) {
    float sint = sin(angle), cost = cos(angle);
    uv -= center;
    float ratio = u_ScreenParams.x / u_ScreenParams.y;
    if (ratio < 1.0) {
        uv.x *= ratio;
    } else {
        uv.y /= ratio;
    }
    uv = mat2(cost, sint, -sint, cost) * uv;
    if (ratio < 1.0) {
        uv.x /= ratio;
    } else {
        uv.y *= ratio;
    }
    return uv + center;
}

float uvProtect(vec2 uvTemp) {
    // 【核心修复】边缘收缩 0.001，防止 CLAMP_TO_EDGE 导致的边缘像素拉伸
    vec2 s = step(vec2(0.001), uvTemp) * step(uvTemp, vec2(0.999));
    return s.x * s.y;
}

float reflectWipe(vec2 uv, float reflectionDistance, float reflectionFalloff) {
    float mask = 0.0;
    if (reflectionFalloff < 0.5) {
        mask = smoothstep(0.0, 2.0 * reflectionDistance * reflectionFalloff, uv.y);
    } else {
        mask = smoothstep(2.0 * reflectionDistance * (reflectionFalloff - 0.5), reflectionDistance, uv.y);
    }
    return 1.0 - mask;
}

void main() {
    float fixScale = max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x) * 2.2;
    vec2 offset = vec2(0.0, 1.0 - u_lineOffsetY);
    vec2 uv = vec2(v_uv.x, 1.0 - v_uv.y);
    uv -= 0.5;
    uv *= fixScale;
    uv += 0.5;

    vec2 maskUV = uv + vec2(0.0, offset.y - 1.0 - mix(0.0, 0.35, clamp(u_fixDistance, 0.0, 1.0)));
    uv = rotate(vec2(uv.x, uv.y), vec2(0.5, 0.5), u_reflectionAngle);
    uv = uv + vec2(u_lineOffsetX, offset.y - 1.0);
    
    float mask = reflectWipe(maskUV, u_reflectionDistance, u_reflectionFalloff);
    vec4 color = texture2D(u_inputTexture, uv) * uvProtect(uv) * u_opacity * mask;
    color.rgb *= u_tintColor.rgb;
    
    gl_FragColor = color;
}
`;exports.source=exports.baseMaskFrag;