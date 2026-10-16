precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 uv;
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float ins;
uniform float expandIns;


float uvPro(vec2 uv){
    return step(0.0,uv.x)*step(uv.x,1.0)*step(0.0,uv.y)*step(uv.y,1.0);
}
void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec2 newUV = uv;
    // float dis = (length(vec2(0.65))-length(uv-0.5))/length(vec2(0.5));
    // float oriDis = dis;
    // // dis =  pow(dis,0.75);
    // newUV = (newUV-0.5)/mix(1.,2.0,dis)+0.5;
    // newUV = mix(uv,newUV,1.0);
    // newUV =(newUV-0.5)/0.5+0.5;
    float smoothSize = max(0.0025*smoothstep(0.0,0.1,ins*expandIns),0.0001);
    vec4 resultCol = texture2D(inputImageTexture, newUV)*smoothstep(1.0,1.0-smoothSize,newUV.x)*smoothstep(1.0,1.0-smoothSize,newUV.y)
    *smoothstep(0.,smoothSize,newUV.x)*smoothstep(0.,smoothSize,newUV.y);
    

    gl_FragColor = vec4(resultCol);
}