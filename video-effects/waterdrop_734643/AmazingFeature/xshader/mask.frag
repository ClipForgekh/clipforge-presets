precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 uv;
uniform vec4 u_ScreenParams;
uniform float strength;
uniform float sm;
uniform float scale;
uniform float sdfSize;
uniform vec2 wh;
float mirror(float x){
    return abs(mod(x-1.0,2.0)-1.0);
}
vec2 mirror(vec2 uv){
    return vec2(mirror(uv.x),mirror(uv.y));
}

float sdRoundBox( in vec2 p, in vec2 b, in vec4 r ) 
{
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    vec2 q = abs(p)-b+r.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}

float roundedBox(vec2 position, vec2 halfSize, float cornerRadius) {
    position = abs(position) - halfSize + cornerRadius;
    return length(max(position, 0.0)) + min(max(position.x, position.y), 0.0) - cornerRadius;
}




float rectSdf(vec2 uv, vec2 halfSize) {
    vec2 edgeDist = abs(uv) - halfSize;
    // edgeDist = vec2(max(edgeDist.x,edgeDist.y));
    float inDist = min(max(edgeDist.x, edgeDist.y), 0.);
    float outDist = length(max(edgeDist, 0.));
    float result = inDist+outDist;
    return result;

}


float roundedBoxSDF(vec2 CenterPosition, vec2 Size, float Radius) {
    return length(max(abs(CenterPosition)-Size+Radius,0.0))-Radius;
}


void main()
{

    vec2 center = vec2(0.5, 0.5);

    vec2 uv0 = uv;
    uv0 -= 0.5;
    uv0 = uv0*sdfSize;
    uv0 += 0.5;

    vec2 size = wh;

    // // How soft the edges should be (in pixels). Higher values could be used to simulate a drop shadow.
    float edgeSoftness  = 1.0*sm;
    // The radius of the corners (in pixels).
    float radius1 = strength*wh.x;
    
    // // Calculate distance to edge.   
    float distance 		= roundedBoxSDF(uv*wh  - (wh/2.0), size / 2.0, radius1);

    float smoothedAlpha =  1.0 -smoothstep(0.0, edgeSoftness ,distance);

    gl_FragColor = vec4(smoothedAlpha);



}
