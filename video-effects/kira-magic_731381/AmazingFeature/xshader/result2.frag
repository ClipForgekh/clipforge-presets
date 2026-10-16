precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputImageTexture;
uniform sampler2D _MainTex;
uniform float speed;
uniform float width;
uniform float height;
uniform float true_1;
float getLuminosity(vec3 color)
{
    return dot(color, vec3(0.299, 0.587, 0.114));
}
float blendAdd(float base, float blend) {
    return min(base+blend,1.0);
}

vec3 blendAdd(vec3 base, vec3 blend) {
    return min(base+blend,vec3(1.0));
}
void main()
{
    vec2 baseTextureSize=vec2 (width,height);
    vec2 sucaiSize=vec2(1080,1080);
    vec2 fullBlendAnchor=baseTextureSize*.5;
    float scale=1.;
    float baseAspectRatio=baseTextureSize.y/baseTextureSize.x;
    float blendAspectRatio=sucaiSize.y/sucaiSize.x;
    if(baseAspectRatio>=blendAspectRatio){
        scale=baseTextureSize.y/sucaiSize.y;
    }else{
        scale=baseTextureSize.x/sucaiSize.x;
    }
    vec2 baseTextureCoord=uv0*baseTextureSize;
    vec2 tempSucaiUV=(baseTextureCoord-fullBlendAnchor)/(sucaiSize*scale)+vec2(.5);
    tempSucaiUV.y = 1.0-tempSucaiUV.y;

    vec4 maskColor = texture2D(_MainTex,tempSucaiUV);
    // maskColor.rgb = clamp(maskColor.rgb/maskColor.a,0.0,1.0);
    vec4 inputCol = texture2D(inputImageTexture,uv0); 

    if(true_1==1.){
        
        gl_FragColor = vec4(inputCol);
    }
    else
    {
        inputCol.rgb = blendAdd(inputCol.rgb,maskColor.rgb);
        gl_FragColor = vec4(inputCol);
    }

    

}


