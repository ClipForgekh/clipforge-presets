precision highp float;

uniform sampler2D inputImageTexture;

uniform vec4 u_ScreenParams;
varying vec2 uv;

uniform int inputWidth;
uniform int inputHeight;
uniform float noiseSize;
uniform float iTime;
uniform float noiseScale;
uniform float imgMove;
uniform float noiseX;
uniform float noiseY;
uniform float noiseX2;
uniform float noiseY2;
uniform sampler2D _MainTex;
vec2 hash( vec2 p ,float seed)
{
	p *= mat2( 127.14+seed,311.71+seed,
			   269.55+seed,123.32+seed);

	return normalize(2.*fract(sin(p)*438.543) -1.);
}

float noise( vec2 p ,float seed)
{
    vec2 i = floor( p ),
         f = fract( p ),
	    //  u = f*f*(3.-2.*f);
       u = f*f*f* ( 10. + f * ( -15. + 6.* f ) ); // smoother. from http://staffwww.itn.liu.se/~stegu/TNM022-2005/perlinnoiselinks/paper445.pdf

    float result =  
              mix( mix( dot( hash( i + vec2(0,0) ,seed), f - vec2(0,0) ), 
                        dot( hash( i + vec2(1,0) ,seed), f - vec2(1,0) ), u.x),
                   mix( dot( hash( i + vec2(0,1) ,seed), f - vec2(0,1) ), 
                        dot( hash( i + vec2(1,1) ,seed), f - vec2(1,1) ), u.x), u.y);
    return clamp(result*0.75+0.5,0.0,1.0);
}
float mirror(float x){
    return abs(mod(x-1.0,2.0)-1.0);
}
vec2 mirror(vec2 uv){
    return vec2(mirror(uv.x),mirror(uv.y));
}
void main()
{
    vec2 noiseUV = (uv-0.5)*noiseSize/noiseScale;
    if(u_ScreenParams.x<u_ScreenParams.y)
        noiseUV.y*=u_ScreenParams.y/u_ScreenParams.x;
    else
        
        noiseUV.x*=u_ScreenParams.x/u_ScreenParams.y;

    vec2 baseTextureSize=vec2(u_ScreenParams);
    vec2 sucaiSize=vec2(540,540);
    vec2 fullBlendAnchor=baseTextureSize*.5;
    float scale=1.;
    float baseAspectRatio=baseTextureSize.y/baseTextureSize.x;
    float blendAspectRatio=sucaiSize.y/sucaiSize.x;
    if(baseAspectRatio>=blendAspectRatio){
        scale=baseTextureSize.y/sucaiSize.y;
    }else{
        scale=baseTextureSize.x/sucaiSize.x;
    }
    vec2 baseTextureCoord=uv*baseTextureSize;
    vec2 tempSucaiUV=(baseTextureCoord-fullBlendAnchor)/(sucaiSize*scale)+vec2(.5);
    tempSucaiUV.y = 1.0-tempSucaiUV.y;
    //vec2 tempSucaiUV=vec2(uv.x,1.0-uv.y);

    // float mynoise1 = noise(noiseUV,121.21);
    // float mynoise2 = noise(noiseUV,111.11);
    float d = length(uv-0.5);
    float mask = smoothstep(0.35,0.5,d);

    vec3 col = texture2D(_MainTex,tempSucaiUV).rgb;
    vec2 mySize = u_ScreenParams.xy*1080./min(u_ScreenParams.x,u_ScreenParams.y);
    vec2 noiseOffset = mix(vec2(noiseX,noiseY),vec2(noiseX,noiseY)+vec2(noiseX2,noiseY2),mask)/mySize*(col.r-0.5)*2.0;
    vec2 imgMoveOffset = vec2(0,imgMove)/mySize;
    vec4 resultCol = texture2D(inputImageTexture,mirror(uv-noiseOffset+imgMoveOffset));
    // vec3 col = texture2D(inputImageTexture,mirror(uv)).rgb;
    gl_FragColor = vec4(resultCol);
}
