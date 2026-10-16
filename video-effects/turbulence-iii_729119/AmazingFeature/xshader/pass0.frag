precision highp float;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture1;
varying vec2 uv;
uniform float imgMove1;
uniform float iTime;
uniform sampler2D moveImg;
uniform sampler2D scaleImg;
uniform sampler2D timeImg;
uniform float moveTime;
// uniform float u_CutoutPoints[512];
vec4 enCode(float a){
    float a1 = floor(a*255.);
    float b1 = fract(a*255.);
    float a2 = floor(b1*255.);
    float b2 = fract(b1*255.);
    float a3 = floor(b2*255.);
    float b3 = fract(b2*255.);
    return vec4(a1/255.,a2/255.,a3/255.,b3);
}
float deCode(vec4 a){
    return a.x+a.y/255.+a.z/(255.*255.)+a.w/(255.*255.*255.);
}
// float move2scale(float moveIns){

// }
float getNY(float n){
    if( n<0.5) 
    {
        return 0.5;
    }
    else if(n<1.5){
        return 2.5;
    }
    else if(n<2.5){
        return 4.5;
    }
    else if(n<3.5){
        return 6.5;
    }
    else if(n<4.5){
        return 8.5;
    }
    else if(n<5.5){
        return 10.5;
    }
    else if(n<6.5){
        return 12.5;
    }
    else if(n<7.5){
        return 14.5;
    }
    else{
        return 0.;
    }
    return 0.;
}
void main()
{
    float nY = 7.-floor(uv.y*7.999);
    // float nY_iTime = max(moveTime-2./41.*nY,0.0);
    float nY_iTime = deCode(texture2D(timeImg,vec2(max(iTime-2./41.*nY,0.0),0.5)));
    // nY_iTime = iTime-2./41.*nY;


    vec4 resultCol = vec4(0.0);
    float weight = 0.0;
    float moveIns0 = deCode(texture2D(moveImg,vec2(nY_iTime,0.5)));
    float moveIns1 = deCode(texture2D(moveImg,vec2(nY_iTime-0.0112,0.5)));
    float moveSpeed = max(min(abs(moveIns0-moveIns1)/0.0112/10.,1.),0.01);
    for(int i =0;i<=64;i++){
        float j = float(i);
        float t = nY_iTime-j*0.000175/moveSpeed;
        float moveIns = deCode(texture2D(moveImg,vec2(t,0.5)));
        moveIns = pow(moveIns,0.8);
        vec2 uvLeft = uv+vec2(0.5-0.5*moveIns,0.0);
        vec2 uvRight = uv-vec2(0.5-0.5*moveIns,0.0);
        vec2 uv1 = mix(uvLeft,uvRight,step(0.5,uv.x));
        float uvLeftFlag = step(uvLeft.x,0.5);
        float uvRightFlag = step(0.5,uvRight.x);
        float uvFlag = mix(uvLeftFlag,uvRightFlag,step(0.5,uv.x));
        // int j = int(uv.x*512.);
        // vec4 col1 = vec4(enCode(u_CutoutPoints[j]));
        vec4 col1 =texture2D(inputImageTexture,uv1)*uvFlag; 
        resultCol+=col1;
        weight+= 1.0;
        if(j>64.*moveSpeed) break;
    }
    resultCol/=weight;
    resultCol.rgb = clamp(resultCol.rgb/resultCol.a,0.0,1.0);


    vec4 resultCol1 = vec4(0.0);
    float weight1 = 0.0;
    nY_iTime = max((iTime-getNY(nY)/41.),0.0);
    // float scale0 = deCode(texture2D(scaleImg,vec2(iTime,0.5)));
    // float scale1 = 1.0-deCode(texture2D(moveImg,vec2(nY_iTime-0.0128,0.5)));
    float scale1 = deCode(texture2D(scaleImg,vec2(nY_iTime-0.0128,0.5)));
    for(int i =0;i<=32;i++){
        float j = float(i);
        float t = nY_iTime-j*0.0004;
        // float scale = max(1.0-deCode(texture2D(moveImg,vec2(t,0.5))),0.01);
        float scale = max(deCode(texture2D(scaleImg,vec2(t,0.5))),0.01);
        scale = pow(scale,0.8);
        vec2 reScaleUV = uv;
        reScaleUV.x = (reScaleUV.x-0.5)/scale+0.5;
        float reScaleUVFlag = step(reScaleUV.x,1.0)*step(0.0,reScaleUV.x);

        resultCol1 += texture2D(inputImageTexture1,reScaleUV)*reScaleUVFlag;
        weight1+= 1.0;
        if(scale1>0.999) break;
    }
    resultCol1/=weight1;

    vec4 lastCol = resultCol1;
    lastCol.rgb = mix(lastCol.rgb,resultCol.rgb,resultCol.a);
    lastCol.a = max(resultCol.a,resultCol1.a);
    gl_FragColor = vec4(lastCol);
}
