precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform sampler2D u_InputTex1;
uniform float op ;

vec4 applyBlend0 (vec4 dst0, vec4 src0, float opacity) {
    src0 *= opacity;
    return src0 + dst0 * (1.0 - src0.a);
}

void main()
{
    vec2 uv = uv0;
    vec4 boxColor = texture2D(u_InputTex, uv);
    vec4 imageColor = texture2D(u_InputTex1, uv);
    vec4 resultColor = applyBlend0(boxColor, imageColor, 1.0);
    
    // resultColor.a = 1.0;
    resultColor *= op;

    gl_FragColor = resultColor;
}
