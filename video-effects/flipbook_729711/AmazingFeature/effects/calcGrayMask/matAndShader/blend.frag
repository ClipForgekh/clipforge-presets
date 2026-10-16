precision lowp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform sampler2D u_MaskTex;
uniform float pos_Y;
vec4 deleteGrad(sampler2D texture, vec2 uv){
    vec2 texCoord1 = uv;

    vec4 result = vec4(0.0);
    if(clamp(texCoord1, 0.0, 1.0) == texCoord1){
        result += texture2D(texture, texCoord1);
    }
    return result;
}
void main()
{
    vec2 uv = uv0;
    uv = vec2(uv.x,uv.y+pos_Y);
    vec4 oriColor = deleteGrad(u_InputTex, uv);
    vec4 maskColor = deleteGrad(u_MaskTex, uv);
    gl_FragColor = oriColor * maskColor.r;
    // gl_FragColor = vec4(gray);
}
