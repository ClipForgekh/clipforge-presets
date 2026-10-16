precision highp float;

uniform sampler2D inTex;
uniform sampler2D u_InputTexture;
uniform sampler2D quadMaskTex;

uniform mat4 pMat0;

varying vec2 uvC1;
varying vec2 uvC2;
varying vec2 uvC3;
varying vec2 uvC4;
varying vec2 uvC5;

varying highp vec2 uv0;
varying float quad_id;
const int FRAG_NUM = 20;
uniform vec2 u_VerticeCenter[FRAG_NUM];
uniform float isVis;

varying float isShow;
varying vec2 scaleUpUV;

#define kSamplesPerFrame 256.0

// 5UV，w
vec2 interUV(float w, vec2 uv_0, vec2 uv_1, vec2 uv_2, vec2 uv_3, vec2 uv_4)
{
    return  mix(uv_0, uv_1, w*4.0)     * step(w, 0.25) +
            mix(uv_1, uv_2, w*4.0-1.0) * (1.0-step(w, 0.25)) * step(w, 0.5) +
            mix(uv_2, uv_3, w*4.0-2.0) * (1.0-step(w, 0.5)) * step(w, 0.75) +
            mix(uv_3, uv_4, w*4.0-3.0) * (1.0-step(w, 0.75));
}

float normpdf(float x, float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma));
}

void main()
{
    vec4 res1 = texture2D(u_InputTexture, uvC1);
    vec4 res2 = texture2D(u_InputTexture, uvC2);
    vec4 res3 = texture2D(u_InputTexture, uvC3);
    vec4 res4 = texture2D(u_InputTexture, uvC4);
    vec4 res5 = texture2D(u_InputTexture, uvC5);

    vec4 res = vec4(0.0);
    float samples = 400.0;
    float sumWeight = 0.0;
    float BLUR_CONTROL = 0.25;

    // frag quadMask  uv  
    vec2 curPntCenter = vec2(0.0);
    for(int i=1; i<=20; i++) {
        float isThisPnt = step(abs(quad_id-float(i)), 0.5);
        curPntCenter = curPntCenter + isThisPnt* u_VerticeCenter[i-1];
    }
    curPntCenter = 0.5* curPntCenter + 0.5;

    float isID13 = step(abs(quad_id-13.0), 0.5);
    for (float i = 0.0; i < kSamplesPerFrame; i+=1.0)
    {
        float w = i / (kSamplesPerFrame - 1.0); 
        // w = mix(w, 0.3*(w-0.5)+0.5, isID13);
        vec2 uv = interUV(w, uvC1, uvC2, uvC3, uvC4, uvC5);

        float curWeight = normpdf(w-0.5, BLUR_CONTROL);
        vec2 scaled_UV = (uv - curPntCenter)* 1.5 + curPntCenter;
        //  UV , ，，
        float quadMaskVal = texture2D(quadMaskTex, scaled_UV).x;
        float isInsideQuad = step(abs(quad_id/20.0-quadMaskVal), 0.5/20.0);
        res += (curWeight* (isInsideQuad * texture2D(u_InputTexture, scaled_UV)));

        sumWeight = sumWeight + curWeight; 
    }
    res /= sumWeight;


    gl_FragColor = isVis* isShow* res;

    // // ：<> <>
    // mesh，， scaleUpUV, UV
    // vec2 scale_uvC2 = (uvC1 - curPntCenter)*1.5 + curPntCenter;
    // vec4 oriContent = texture2D(u_InputTexture, scale_uvC2);
    // float quadMaskVal = texture2D(quadMaskTex, scale_uvC2).x; 
    // float isInsideQuad = step(abs(quad_id/20.0-quadMaskVal), 0.5/20.0);
    // gl_FragColor = isShow*  mix(oriContent, vec4(1.0, 1.0, 0.0, 1.0), 1.0-isInsideQuad);

    // // ：<> <>
    // mesh，， scaleUpUV, UV
    // vec4 oriContent = texture2D(u_InputTexture, scaleUpUV);
    // vec4 validCol = vec4(1.0);
    // float quadMaskVal = texture2D(quadMaskTex, scaleUpUV).x; // UV， scaleUpUV
    // float isInsideQuad = step(abs(quad_id/20.0-quadMaskVal), 0.5/20.0);
    // gl_FragColor = isShow*  mix(vec4(1.0, 1.0, 1.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), 1.0-isInsideQuad);
}

