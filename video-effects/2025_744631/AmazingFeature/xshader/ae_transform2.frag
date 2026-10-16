precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform float alpha;
uniform float mirrorEdge;
uniform sampler2D PNG_2024;

float uvProtect(vec2 uv)
{
    vec2 uvp = step(vec2(0.0), uv) * step(uv, vec2(1.0));
    return uvp.x * uvp.y;
}
vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

void main()
{
    vec2 uv1 = vec2(uv0.x,1.-uv0.y );
    vec2 uv = step(mirrorEdge, 0.5)*uv1 + (1.0-step(mirrorEdge, 0.5))*Mirror(uv1);
    vec4 res = texture2D(inputTex, uv1) * alpha * uvProtect(uv1);
    vec4 PNG_2024Color = texture2D(PNG_2024,vec2(uv0.x,uv0.y ));
    // res  = mix(res,PNG_2024Color ,PNG_2024Color.r );
    // vec4 res = texture2D(inputTex,Mirror(uv0)) * alpha;
    gl_FragColor = res;
}
