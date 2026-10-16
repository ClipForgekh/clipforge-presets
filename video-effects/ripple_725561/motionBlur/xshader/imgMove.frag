precision highp float;

uniform sampler2D inputImageTexture;

uniform float baseTexWidth;
uniform float baseTexHeight;

uniform float imgSize;
varying vec2 uv;
uniform float posX;
uniform float posY;
mat2 rotMat(float angle){
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c,-s,s,c);
}
float uvpro(vec2 uv){
    return step(0.,uv.x)*step(uv.x,1.0)*step(0.,uv.y)*step(uv.y,1.0);
}
float mirror(float x){
    return abs(mod(x-1.0,2.0)-1.0);
}
vec2 mirror(vec2 uv){
    return vec2(mirror(uv.x),mirror(uv.y));
}
void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec2 mySize = screenSize.xy/min(screenSize.y,screenSize.y)*1080.;
    vec2 resultUV = uv-vec2(posX,-posY)/mySize;
    resultUV=(resultUV-0.5)/imgSize+0.5;
    
    
    vec4 col = texture2D(inputImageTexture,resultUV)*uvpro(resultUV);
    // col.rgb*=uvpro(rotUV);
    gl_FragColor = vec4(col);
}
