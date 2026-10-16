exports.source=`
varying vec2 v_uv;
varying vec3 v_tangentViewPos;
varying vec3 v_tangentFragPos;
uniform sampler2D u_diffuseMap;
uniform sampler2D u_depthMap;
uniform sampler2D u_sFilterTex;
uniform vec4 u_ScreenParams;
uniform vec2 u_center;
uniform float u_heightScale;
uniform float u_intensity;
uniform float u_lutYFlip;

vec2 flipUV(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}

vec2 ParallaxMapping(vec2 texCoords, vec3 viewDir)
{
    const float minLayers = 32.0;
    const float maxLayers = 32.0;
    float numLayers = mix(maxLayers, minLayers, abs(dot(vec3(0.0, 0.0, 1.0), viewDir)));
    float layerDepth = 0.4 / numLayers;
    float oriLayDepth = layerDepth;
    float currentLayerDepth = 0.0;

    vec2 ratio = u_ScreenParams.xy / max(u_ScreenParams.x, u_ScreenParams.y);
    vec2 P = viewDir.xy / viewDir.z * u_heightScale;
    vec2 deltaTexCoords = 0.4 * P / numLayers;
    vec2 oriDeltaTexCoords = deltaTexCoords;

    vec2 currentTexCoords = texCoords;
    float currentDepthMapValue = 1.0 - texture2D(u_depthMap, currentTexCoords).r;

    for (int i = 0; i < 1024; ++i) {
        if (currentLayerDepth >= currentDepthMapValue) {
            break;
        }
        layerDepth = oriLayDepth * mix(0.15, 1., abs(currentLayerDepth - currentDepthMapValue));
        deltaTexCoords = oriDeltaTexCoords * mix(0.15, 1., abs(currentLayerDepth - currentDepthMapValue));
        currentTexCoords -= deltaTexCoords;
        currentDepthMapValue = 1.0 - texture2D(u_depthMap, flipUV(currentTexCoords)).r;
        currentLayerDepth += layerDepth;
    }

    vec2 prevTexCoords = currentTexCoords + deltaTexCoords;
    float afterDepth = currentDepthMapValue - currentLayerDepth;
    float beforeDepth = (1.0 - texture2D(u_depthMap, flipUV(prevTexCoords)).r) - currentLayerDepth + layerDepth;
    float weight = afterDepth / (afterDepth - beforeDepth);
    vec2 finalTexCoords = prevTexCoords * weight + currentTexCoords * (1.0 - weight);

    return finalTexCoords;
}

vec3 unpremul3(vec4 color)
{
    if (color.a == 0.0) {
        return vec3(0.0);
    }
    return color.rgb / color.a;
}

vec3 lut8x8(sampler2D lut, vec3 src)
{
    src *= 63.0;
    float b = src.b;

    vec2 i01 = vec2(floor(b), ceil(b));
    vec2 r01 = floor(i01 * 0.125);
    vec2 c01 = i01 - r01 * 8.0;

    vec4 uv0 = vec4(c01, r01).xzyw * 0.125;
    vec2 uv1 = (src.rg + 0.5) * 0.001953125;
    uv0 += vec4(uv1, uv1);

    float y0 = mix(uv0.y, 1.0 - uv0.y, u_lutYFlip);
    float y1 = mix(uv0.w, 1.0 - uv0.w, u_lutYFlip);
    vec3 c0 = texture2D(lut, vec2(uv0.x, y0)).rgb;
    vec3 c1 = texture2D(lut, vec2(uv0.z, y1)).rgb;
    return mix(c0, c1, b - i01.x);
}

vec4 mapping(vec4 color, sampler2D lut, float intensity)
{
    vec3 dst = unpremul3(color);
    vec3 src = lut8x8(lut, dst);
    dst = mix(dst, src, intensity);
    return vec4(dst, 1.0) * color.a;
}

void main() {
    vec3 tempTangentViewPos = v_tangentViewPos;
    vec3 viewDir = normalize(tempTangentViewPos - v_tangentFragPos);
    vec2 texCoords = v_uv;
    vec2 center = u_center;
    texCoords = (texCoords - center) / mix(1.0, 2.5, pow(u_heightScale, 1.2)) + center;
    texCoords = flipUV(ParallaxMapping(texCoords, viewDir));
    vec4 color = texture2D(u_diffuseMap, texCoords);
    color = mapping(color, u_sFilterTex, u_intensity);
    gl_FragColor = color;
}
`;