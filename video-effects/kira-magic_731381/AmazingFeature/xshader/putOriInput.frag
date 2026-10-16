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


void main()
{
    vec2 baseTextureSize=vec2 (width,height);
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
    vec2 baseTextureCoord=uv0*baseTextureSize;
    vec2 tempSucaiUV=(baseTextureCoord-fullBlendAnchor)/(sucaiSize*scale)+vec2(.5);
    tempSucaiUV.y = 1.0-tempSucaiUV.y;

    vec4 maskColor = texture2D(_MainTex,tempSucaiUV);

    vec4 inputCol = texture2D(inputImageTexture,uv0);
    float factor = 1.0 - maskColor.r;
    if(true_1==1.){
        
        inputCol = inputCol*factor;
        gl_FragColor = vec4(inputCol);
    }
    else
    {
        // inputCol = inputCol*maskColor;
        gl_FragColor = inputCol;
    }
    
    // gl_FragColor = vec4(inputCol);

}


