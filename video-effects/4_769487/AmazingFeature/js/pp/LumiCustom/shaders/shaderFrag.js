exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float holdPortion; // = 0.2 [0.0, 0.8]
uniform float edgeSoftness; // = 0.015 [0.001, 0.08]
uniform float curveAmount; // = 0.35 [0.0, 1.5]
uniform vec4 sectionSpeed; // = vec4(1.00, 0.94, 1.08, 0.90)

varying vec2 vUv;

const float PI = 3.14159265;

float tween(float p) {
    return p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float angleDiff(float a, float b) {
    float d = abs(a - b);
    return min(d, 2.0 * PI - d);
}

float sectionCut(vec2 p, float r, float ang, float axisAng, float spd, float localP) {
    float da = angleDiff(ang, axisAng);
    float wedgeHalf = PI * 0.25;
    float wedgeMask = 1.0 - smoothstep(wedgeHalf, wedgeHalf + 0.08, da);

    float maxR = length(getSDFCoordinate(vec2(1.0, 1.0), vec2(0.5)));
    float secP = clamp(localP * spd, 0.0, 1.0);
    float nd = clamp(da / max(wedgeHalf, 0.0001), 0.0, 1.0);
    float front = secP * maxR * (1.0 + curveAmount * nd * nd);

    float radialKeep = smoothstep(front - edgeSoftness, front + edgeSoftness, r);
    float removed = wedgeMask * (1.0 - radialKeep);
    return removed;
}

vec4 effect(vec4 texel, float p) {
    float localP = clamp((p - holdPortion) / max(1.0 - holdPortion, 0.0001), 0.0, 1.0);

    vec2 pc = getSDFCoordinate(vUv, vec2(0.5));
    float r = length(pc);
    float ang = atan(pc.y, pc.x);

    float cut0 = sectionCut(pc, r, ang,  PI * 0.25,  sectionSpeed.x, localP);
    float cut1 = sectionCut(pc, r, ang,  PI * 0.75,  sectionSpeed.y, localP);
    float cut2 = sectionCut(pc, r, ang, -PI * 0.75,  sectionSpeed.z, localP);
    float cut3 = sectionCut(pc, r, ang, -PI * 0.25,  sectionSpeed.w, localP);

    float removed = max(max(cut0, cut1), max(cut2, cut3));
    float finalKill = smoothstep(0.92, 1.0, localP);
    removed = max(removed, finalKill);

    float alpha = texel.a * (1.0 - removed);
    return vec4(texel.rgb, alpha);
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