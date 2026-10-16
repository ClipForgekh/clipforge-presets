precision highp float;
varying highp vec2 uv0;

uniform sampler2D _MainTex;
uniform vec4 u_ScreenParams;

uniform float h;
uniform float w;


vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

void main()
{
    // vec2 baseTextureSize=vec2 (u_ScreenParams.x,u_ScreenParams.y);
    // vec2 sucaiSize=vec2(561,1000);
    // vec2 fullBlendAnchor=baseTextureSize*.5;
    // float scale=1.;
    // float baseAspectRatio=baseTextureSize.y/baseTextureSize.x;
    // float blendAspectRatio=sucaiSize.y/sucaiSize.x;
    // if(baseAspectRatio>=blendAspectRatio){
    //     scale=baseTextureSize.y/sucaiSize.y;
    // }else{
    //     scale=baseTextureSize.x/sucaiSize.x;
    // }
    // vec2 baseTextureCoord=uv0*baseTextureSize;
    // vec2 tempSucaiUV=(baseTextureCoord-fullBlendAnchor)/(sucaiSize*scale)+vec2(.5);
    // tempSucaiUV.y = 1.0-tempSucaiUV.y;



    vec2 uv = uv0;
    uv -= 0.5;


    // if(w > h){
    //     uv.y -= (h / w / 10.) - (w / h / 10.);
    //     uv.y /= w / h;
    // }
    // else{
    //     uv.x /= h / w;
    // }

    // if(w > h){
    //     uv.y -= (h / w / 10.) - (w / h / 10.);
    //     uv.y = h / 100.;
    // }
    // else{
    //     uv.x = w / 100.;
    // }

    uv.x *= h / w;
    uv.y *= w / h;
    

    uv += 0.5;
    gl_FragColor = texture2D(_MainTex, Mirror(uv));
}
