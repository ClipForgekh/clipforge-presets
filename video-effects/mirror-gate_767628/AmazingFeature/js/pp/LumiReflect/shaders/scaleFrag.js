exports.scaleFrag=`
precision highp float;

uniform sampler2D u_inputTexture;
uniform vec4 u_ScreenParams;
uniform float u_lineOffsetY;
uniform float u_lineOffsetX;
uniform float u_reflectionAngle;

varying vec2 v_uv;
const float EPS = 1e-3;

float uvProtect(vec2 uvTemp) {
    // 【核心修复】防止边缘拉伸
    vec2 s = step(vec2(0.001), uvTemp) * step(uvTemp, vec2(0.999));
    return s.x * s.y;
}

vec2 rotate(vec2 uv, vec2 center, float angle) {
    vec2 centered = uv - center;
    float ratio = u_ScreenParams.x / u_ScreenParams.y;

    centered *= (ratio < 1.0) ? vec2(ratio, 1.0) : vec2(1.0, 1.0 / ratio);
    mat2 rotMat = mat2(cos(angle), sin(angle), -sin(angle), cos(angle));
    centered = rotMat * centered;

    centered /= (ratio < 1.0) ? vec2(ratio, 1.0) : vec2(1.0, 1.0 / ratio);
    return centered + center;
}

void main() {
    float fixScale = max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x) * 2.2;
    float invFixScale = 1.0 / max(fixScale, EPS);

    vec2 uv = vec2(v_uv.x, 1.0 - v_uv.y);
    uv = ((uv - 0.5) * invFixScale + 0.5) - vec2(u_lineOffsetX, u_lineOffsetY) * invFixScale;
    uv = rotate(uv, vec2(0.5), u_reflectionAngle);
    
    gl_FragColor = texture2D(u_inputTexture, uv) * uvProtect(uv);
}
`;exports.source=exports.scaleFrag;