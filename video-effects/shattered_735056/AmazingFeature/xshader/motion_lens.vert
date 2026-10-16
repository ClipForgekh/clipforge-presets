precision highp float;

attribute vec3 position;
attribute vec2 texcoord0;
varying vec2 uv0;
uniform mat4 u_MVP;
uniform mat4 u_VP;

// VAT samping
uniform sampler2D vatInfo;

uniform sampler2D vatN1Tex;
uniform sampler2D vatN2Tex;
uniform sampler2D curTex;
uniform sampler2D vatN3Tex;
uniform sampler2D vatN4Tex;

uniform float frameID;
uniform float frameNUM;

const int FRAG_NUM = 20;
uniform vec2 u_VerticeCenter[FRAG_NUM];

uniform mat4 u_V;
varying mat4 mvMat0;
varying mat4 mvMat1;
varying mat4 mvMat2;
varying mat4 mvMat3;
varying mat4 mvMat4;
varying mat4 mvMat5;

varying vec2 uvC1;
varying vec2 uvC2;
varying vec2 uvC3;
varying vec2 uvC4;
varying vec2 uvC5;

uniform mat4 cModel6;
uniform mat4 cModel7;
uniform mat4 cModel8;
uniform mat4 cModel9;
uniform mat4 cModel10;
uniform mat4 cModel11;
uniform mat4 cModel12;
uniform mat4 cModel13;
uniform mat4 cModel14;
uniform mat4 cModel15;
uniform mat4 cModel16;
uniform mat4 cModel17;
uniform mat4 cModel18;
uniform mat4 cModel19;
uniform mat4 cModel20;

varying float quad_id;
varying float isShow;
varying vec2 scaleUpUV;

mat4 Ptranspose(mat4 inMatrix) {
    vec4 i0 = inMatrix[0];
    vec4 i1 = inMatrix[1];
    vec4 i2 = inMatrix[2];
    vec4 i3 = inMatrix[3];

    mat4 outMatrix = mat4(
                 vec4(i0.x, i1.x, i2.x, i3.x),
                 vec4(i0.y, i1.y, i2.y, i3.y),
                 vec4(i0.z, i1.z, i2.z, i3.z),
                 vec4(i0.w, i1.w, i2.w, i3.w)
                 );

    return outMatrix;
}

float deCode(vec4 a){
    return a.x+a.y/255.+a.z/(255.*255.)+a.w/(255.*255.*255.);
}

// ：1/mesh, M，1VP，1 =>  ，
// ：1/mesh，1MVP，MVP，1UV

void main() 
{ 
    quad_id = texcoord0.x; // id => ID
    uv0 = 0.5*position.xy+0.5; // uv0frag ; ？  =  <<>> 

    float tid = texcoord0.x;
    mat4 newM;
    mat4 curModel;

    //
    //  frag MVP
    //
    // float VMIN = -6.0835; // ori
    // float VMAX = 3.376;

    float VMIN = -5.3387; // new
    float VMAX = 2.7974;
    VMIN = -5.3407; // frameID log
    VMAX =  2.9215; // frameID log
    VMIN =  -3.2661;
    VMAX =  2.7776;

    float startInd = (tid-1.0)* 16.0;
    vec2 NORMUV = vec2(frameNUM, 320.0);
    for (float c=0.0; c<=15.0; c=c+1.0) {
        // 
        // vec2 vat_uv= vec2((frameID), (startInd+c)); // WRONG! 0.0，
        vec2 vat_uv= vec2((frameID-0.5), (startInd+c+0.5)); // CORRECT!
        vat_uv = vat_uv / NORMUV;
        float m11 = deCode(texture2D(vatInfo, vat_uv));
        m11 = m11*(VMAX-VMIN) + VMIN;
        int rowInd = int(c/4.0);
        int colInd = int(c-float(rowInd)*4.0);
        curModel[rowInd][colInd] = m11;
    }

    // vert  frag  -- 
    vec2 curPntCenter = vec2(0.0);
    for(int i=1; i<=20; i++) {
        float isThisPnt = step(abs(tid-float(i)), 0.5);
        curPntCenter = curPntCenter + isThisPnt* u_VerticeCenter[i-1];
    }

    vec3 scaled_position = position;
    scaled_position.z = 0.0001* (quad_id-10.0);
    scaled_position.xy = (scaled_position.xy - curPntCenter)* 1.5 + curPntCenter;

    //
    // ：，uv 
    //
    newM = curModel;
    vec4 pCoord = ( newM) * vec4(position, 1.0);

    pCoord = pCoord/pCoord.w;

    //
    //  frag MVP
    // ：，UV
    //
    // for(float fid = frameID-2.0; fid<=frameID+2.0; fid = fid+1.0) {
    {
        mat4 invMVP1, invMVP2, invMVP3, invMVP4, invMVPCur;
        mat4 t_invMVP1, t_invMVP2, t_invMVP3, t_invMVP4, t_invMVPCur;
        // float minV1 =  -15.483;
        // float maxV1 =  14.6413;

        // float minV2 =  -15.4992;
        // float maxV2 =  14.6575;

        float minV1 =  -15.5081;
        float maxV1 =  14.6665;

        float minV2 =  -15.5081;
        float maxV2 =  14.6665;

        float minVC =  -15.5081;
        float maxVC =  14.6665;

        float minV3 =  -15.5081;
        float maxV3 =  14.6665;

        float minV4 =  -15.5081; 
        float maxV4 =  14.6665;

        // VAT 320x51, 320 = 4x4x20
        for (float c=0.0; c<=15.0; c=c+1.0) {
            // ，Model
            vec2 vat_uv= vec2((frameID-0.5), (startInd+c+0.5)); // CORRECT!
            vat_uv = vat_uv / NORMUV;
            int rowInd = int(c/4.0);
            int colInd = int(c-float(rowInd)*4.0);

            float val = deCode(texture2D(vatN1Tex, vat_uv));
            val = val* (maxV1 - minV1) + minV1;
            invMVP1[rowInd][colInd] = val;

            val = deCode(texture2D(vatN2Tex, vat_uv));
            val = val* (maxV2 - minV2) + minV2;
            invMVP2[rowInd][colInd] = val;

            val = deCode(texture2D(curTex, vat_uv));
            val = val* (maxVC - minVC) + minVC;
            invMVPCur[rowInd][colInd] = val;
            
            val = deCode(texture2D(vatN3Tex, vat_uv));
            val = val* (maxV3 - minV3) + minV3;
            invMVP3[rowInd][colInd] = val;

            val = deCode(texture2D(vatN4Tex, vat_uv));
            val = val* (maxV4 - minV4) + minV4;
            invMVP4[rowInd][colInd] = val;
        }

        vec4 invCoord;
        vec3 invNDC;

        // t_invMVP1 = Ptranspose(invMVP1);
        t_invMVP1 = (invMVP1);
        invCoord = (t_invMVP1) * pCoord;
        invNDC = invCoord.xyz / invCoord.w;
        uvC1 = invNDC.xy * 0.5 + 0.5;

        t_invMVP2 = (invMVP2);
        invCoord = (t_invMVP2) * pCoord;
        invNDC = invCoord.xyz / invCoord.w;
        uvC2 = invNDC.xy * 0.5 + 0.5;

        t_invMVPCur = (invMVPCur);
        invCoord = (t_invMVPCur) * pCoord;
        invNDC = invCoord.xyz / invCoord.w;
        uvC3 = invNDC.xy * 0.5 + 0.5;

        t_invMVP3 = (invMVP3);
        invCoord = (t_invMVP3) * pCoord;
        invNDC = invCoord.xyz / invCoord.w;
        uvC4 = invNDC.xy * 0.5 + 0.5;

        t_invMVP4 = (invMVP4);
        invCoord = (t_invMVP4) * pCoord;
        invNDC = invCoord.xyz / invCoord.w;
        uvC5 = invNDC.xy * 0.5 + 0.5;

    }

    float B = 2.0;
    uvC1 = B* (uvC1 - uvC3) + uvC3;
    uvC2 = B* (uvC2 - uvC3) + uvC3;
    uvC4 = B* (uvC4 - uvC3) + uvC3;
    uvC5 = B* (uvC5 - uvC3) + uvC3;

    isShow = step(abs(quad_id-2.0), 0.5);
    isShow = 1.0;
    scaleUpUV = scaled_position.xy* 0.5+0.5;

    gl_Position = ( newM) * vec4(scaled_position, 1.0);
}
