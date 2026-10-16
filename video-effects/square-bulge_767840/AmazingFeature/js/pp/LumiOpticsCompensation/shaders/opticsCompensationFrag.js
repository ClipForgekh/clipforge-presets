exports.source=`
precision highp float;

uniform sampler2D tDiffuse;

uniform float u_distortParam1;
uniform float u_distortParam2;

uniform int u_inverseLensDistortion;
uniform int u_fillBorders;
uniform vec2 u_center;
uniform float u_fovXScale;
uniform float u_fovYScale;

varying vec2 vUv;

float getMirrorCoordinate(float x)
{
    x = abs(x);
    return abs(floor(ceil(x) / 2.0) * 2.0 - x);
}

void main()
{
    vec2 uv = vUv - u_center;

    float x = uv.x * u_fovXScale;
    float y = uv.y * u_fovYScale;
    float r2 = x * x + y * y;
    float r = sqrt(r2);

    float distortFactor = 1.0;
    if (u_inverseLensDistortion == 0) {
        distortFactor = 1.0 / (1.0 - u_distortParam1 * r - u_distortParam2 * r2);
    } else {
        distortFactor = 1.0 / (1.0 + u_distortParam1 * r + u_distortParam2 * r2);
    }

    vec4 resColor = vec4(0.0);
    vec2 finalUv = vec2(uv.x * distortFactor, uv.y * distortFactor) + u_center;
    
    if (u_fillBorders == 1) {
        finalUv.x = getMirrorCoordinate(finalUv.x);
        finalUv.y = getMirrorCoordinate(finalUv.y);
        resColor = texture2D(tDiffuse, finalUv);
    } else {
        if (distortFactor > 0.0 && finalUv.x >= 0.0 && finalUv.x <= 1.0 && finalUv.y >= 0.0 && finalUv.y <= 1.0) {
            resColor = texture2D(tDiffuse, finalUv);
        } else {
            resColor = vec4(0.0);
        }
    }

    gl_FragColor = resColor;
}
`;