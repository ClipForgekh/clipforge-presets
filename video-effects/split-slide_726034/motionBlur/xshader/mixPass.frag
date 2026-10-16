precision highp float;

uniform sampler2D upTex;
uniform sampler2D downTex;

varying vec2 uv;

#define textureCoordinate uv
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float shadowIns;
float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}

void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    
    float upUVy = (uv.y-0.35)/0.65;
    vec4 upCol = texture2D(upTex,vec2(uv.x,upUVy));

    float downUVy = uv.y/0.45;
    vec4 downCol = texture2D(downTex,vec2(uv.x,downUVy));

    vec4 resultCol = vec4(0.0);
    float smoothIns=0.01;
    float shadowSmoothIns=0.015;
    upCol.rgb = mix(upCol.rgb,vec3(0.0),smoothstep(0.393+shadowSmoothIns,0.393-shadowSmoothIns,uv.y)*0.15*shadowIns) ;
    resultCol = mix(upCol,downCol,smoothstep(0.38888+smoothIns,0.38888-smoothIns,uv.y));
    gl_FragColor = vec4(resultCol);
}