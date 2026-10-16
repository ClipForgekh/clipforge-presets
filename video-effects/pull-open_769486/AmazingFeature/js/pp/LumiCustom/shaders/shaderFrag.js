exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float curvature; // = 0.35 [0.05, 0.8] // 曲率控制，数值越大弧度越明显
uniform float edgeFeather; // = 0.015 [0.0, 0.05] // 遮罩羽化宽度，基于短边比例

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv;
    if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
    } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
    }
    return aspectUV;
}

float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction;
    else return fraction * ratio;
}

vec4 effect(vec4 texel, float progress) {
    float timeline = 1.0 - pow(max(1.0 - progress, 0.0), 0.33333334);
    vec2 aspectUV = getAspectCorrectUV(vUv);
    float yOffset = aspectUV.y - 0.5;

    float edge;
    if (timeline < 0.25) {
        float local = timeline / 0.25;
        float eased = local * local * (3.0 - 2.0 * local);
        edge = mix(1.04, 0.92, eased);
    } else if (timeline < 0.725) {
        float local = (timeline - 0.25) / 0.475;
        float eased = 1.0 - pow(1.0 - local, 3.0);
        edge = mix(0.92, -0.04, eased);
    } else {
        float local = (timeline - 0.725) / 0.275;
        float eased = 1.0 - pow(1.0 - local, 4.0);
        edge = mix(-0.04, -0.18, eased);
    }

    float curvedBoundary = edge + curvature * yOffset * yOffset;
    float sdf = aspectUV.x - curvedBoundary;

    float feather = max(getShortSideRelativeSize(edgeFeather), 0.0005);
    float mask = smoothstep(-feather, feather, sdf);

    vec3 color = mix(vec3(0.0), texel.rgb, mask);

    float effectStrength = 1.0 - timeline;
    float bandWidth = feather * 6.0 + 0.002;
    float band = 1.0 - smoothstep(0.0, bandWidth, abs(sdf));
    vec3 enhanced = clamp(texel.rgb * 1.04 + 0.02, 0.0, 1.0);
    color = mix(color, enhanced, band * effectStrength * 0.4);
    color = clamp(color, 0.0, 1.0);

    float alpha = texel.a * mask;

    return vec4(color, alpha);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);
    vec4 finalColor = effectColor;
    gl_FragColor = finalColor;
}
//===end_frag_code===
`;