precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 uv;
uniform sampler2D blur0ImageTexture;
uniform sampler2D blur1ImageTexture;
uniform sampler2D blur2ImageTexture;
uniform sampler2D blur3ImageTexture;
uniform sampler2D blur4ImageTexture;
uniform sampler2D blur5ImageTexture;
uniform float blurInsAdjust;
uniform float glowIns;
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r,blend.r),blendScreen(base.g,blend.g),blendScreen(base.b,blend.b));
}
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z +  (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
void main()
{


    vec4 col = texture2D(inputImageTexture,uv);

    float gray = dot(col.rgb,vec3(0.299 ,0.587,0.114));
    float ins = mix(0.3,2.5,gray);
    ins = mix(1.0,ins,blurInsAdjust/2.24);
    // ins = 1.0;
    

    vec4 blur0Col = texture2D(blur0ImageTexture,uv);
    blur0Col = clamp(blur0Col*glowIns*blurInsAdjust*ins,0.,1.);
    vec4 blur1Col = texture2D(blur1ImageTexture,uv);
    blur1Col = clamp(blur1Col*glowIns*blurInsAdjust*ins,0.,1.);
    vec4 blur2Col = texture2D(blur2ImageTexture,uv);
    blur2Col = clamp(blur2Col*glowIns*blurInsAdjust*ins,0.,1.);
    vec4 blur3Col = texture2D(blur3ImageTexture,uv);
    blur3Col = clamp(blur3Col*glowIns*blurInsAdjust*ins,0.,1.);
    vec4 blur4Col = texture2D(blur4ImageTexture,uv);
    blur4Col = clamp(blur4Col*glowIns*blurInsAdjust*ins,0.,1.);
    vec4 blur5Col = texture2D(blur5ImageTexture,uv);
    blur5Col = clamp(blur5Col*glowIns*blurInsAdjust*ins,0.,1.);

    col.rgb = blendScreen(col.rgb,blur0Col.rgb);
    col.rgb = blendScreen(col.rgb,blur1Col.rgb);
    col.rgb = blendScreen(col.rgb,blur2Col.rgb);
    col.rgb = blendScreen(col.rgb,blur3Col.rgb);
    col.rgb = blendScreen(col.rgb,blur4Col.rgb);
    col.rgb = blendScreen(col.rgb,blur5Col.rgb);

    vec3 hsv = rgb2hsv(col.rgb);
    hsv.y*=mix(1.0,2.0,blurInsAdjust/2.24);
    col.rgb = hsv2rgb(hsv);

    col.a = max(col.a,blur0Col.a);
    col.a = max(col.a,blur1Col.a);
    col.a = max(col.a,blur2Col.a);
    col.a = max(col.a,blur3Col.a);
    col.a = max(col.a,blur4Col.a);
    col.a = max(col.a,blur5Col.a);

    gl_FragColor = vec4(col);
}