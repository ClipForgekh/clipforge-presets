precision highp float;

uniform sampler2D inputImageTexture;

varying vec2 uv;

#define textureCoordinate uv
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float ins;
uniform float exposure;
uniform float bulgeIns;
uniform float xiruIns;
uniform float imgScale;

float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
float uvPro(vec2 uv){
    float flag = step(uv.x,1.)*step(0.0,uv.x)*step(uv.y,1.)*step(0.0,uv.y);
    return flag;
}
vec4 Exposure(vec4 inputCol, float _intensity, float _offset, float _gray_scale_correct, float _linear){
    vec4 col = inputCol;
    if(_linear<0.5) col.rgb = pow(col.rgb, vec3(2.2));
    col.rgb *= pow(2.0, _intensity);
    col.rgb += _offset;
    vec3 s = sign(col.rgb);
    col.rgb = pow(abs(col.rgb), vec3(1.0 / _gray_scale_correct)) * s;
    s = sign(col.rgb);
    if (_linear<0.5) col.rgb = pow(abs(col.rgb), vec3(0.454545454545)) * s;
    return col;
}
float mirror(float x){
    return abs(mod(x-1.0,2.0)-1.0);
}
vec2 mirror(vec2 uv){
    return vec2(mirror(uv.x),mirror(uv.y));
}
float sdRoundedBox( in vec2 p, in vec2 b, in vec4 r )
{
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    vec2 q = abs(p)-b+r.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}

vec2 xiruUV(vec2 nowUV,float intensity)
{
    vec2 dir = (nowUV - 0.5);
    float l = sdRoundedBox(dir * 2.0, vec2(0.5), vec4(0.5)) + 0.5;
    float l1 = max(abs(dir.x), abs(dir.y)) * 2.0;
    float x = smoothstep(0.0, 1.0, l1);
    l = l1 * x + l * (1. - x);
    return dir * pow(1.0 / l, intensity) + 0.5;
}
void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec2 newUV = uv;
    float dis = (length(vec2(0.65))-length(uv-0.5))/length(vec2(0.5));
    float oriDis = dis;
    // dis =  pow(dis,0.75);
    newUV = (newUV-0.5)/mix(1.,ins,dis)+0.5;
    newUV = mix(uv,newUV,bulgeIns*0.75);
    newUV = xiruUV(newUV,xiruIns*0.06);

    vec4 col = texture2D(inputImageTexture,mirror((newUV-0.5)/imgScale+0.5));
    col = Exposure(col,exposure,0.,1.,0.);
    
    gl_FragColor = vec4(col);
}