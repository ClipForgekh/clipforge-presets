precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputtex1;
uniform sampler2D inputtex2;
uniform float xOffset;
uniform float yOffset;
uniform float scaleIns;


vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv+1.,2.)-1.);
}


void main()
{

    vec2 translate=vec2(xOffset,yOffset);
    vec2 uv1=uv0;
    uv1=uv1-translate;
    uv1 -= 0.5;
    uv1=uv1/vec2(scaleIns, scaleIns)/vec2(0.75 , 0.75);

    uv1 += 0.5;
    vec2 uv2 = flip_uv(uv1);
    vec4 col = texture2D(inputtex1, uv2);
    //vec4 col2 = texture2D(inputtex2, uv0);
    //vec4 fincol = vec4(col.r, col.g, col.b, col2.a);
    gl_FragColor = col;
}
