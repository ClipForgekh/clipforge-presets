precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform float scale_X;
uniform float scale_Y;

mat2 scale(float scaleIns_X,float scaleIns_Y ){
return mat2(1.0/(scaleIns_X + 0.000001),0.,0.,1.0/(scaleIns_Y + 0.000001));
}
void main()
{
    vec2 uv = uv0;
    uv -= 0.5;
    uv = uv * scale(scale_X,scale_Y);
    uv += 0.5;
    gl_FragColor = texture2D(u_InputTex, uv); 
}
