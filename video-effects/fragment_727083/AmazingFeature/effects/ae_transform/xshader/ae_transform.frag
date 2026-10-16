precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform float alpha;

uniform mat4 mvMat0;
uniform mat4 mvMat1;
uniform mat4 mvMat2;
uniform mat4 mvMat3;
uniform mat4 mvMat4;
uniform mat4 mvMat5;
uniform mat4 pMat0;
uniform mat4 pMat1;
uniform mat4 pMat2;
uniform mat4 pMat3;
uniform mat4 pMat4;
uniform mat4 pMat5;

uniform float y_offset;

//from https://www.scratchapixel.com/lessons/3d-basic-rendering/ray-tracing-rendering-a-triangle/moller-trumbore-ray-triangle-intersection
//ray and triangle hit test
// @param orig...origin of ray
// @param dir...ray direction
// @param a,b,c....triangle vertices
// @return vec3(0,0,0) if ray is not hit triangle
vec4 hit(vec3 orig,vec3 dir,vec3 a,vec3 b,vec3 c){
   float eps= 0.0000001;
   vec3 ab=b-a;
   vec3 ac=c-a;
   
   vec3 n=cross(dir,ac);

   float det=dot(ab,n);
    
   if(det<=eps){ return vec4(-1.,-1.,-1.,-1.);}
   // if the determinant is negative the triangle is backfacing
   // if the determinant is close to 0, the ray misses the triangl
   vec3 ao=orig-a;
   float u=dot(ao,n)/det;
   if(u<0.0 || u>1.0){ return vec4(-1.,-1.,-1.,-1.);}
    
   vec3 e=cross(ao,ab);
   float v=dot(dir,e)/det;
   if(v<0.0||u+v>1.0){ return vec4(-1.,-1.,-1.,-1.);}

   float t = dot(ac,e)/det;
   return vec4(u,v,t,1.);
}


vec2 hitRect(mat4 mvM, mat4 pM, vec2 uv)
{
    // const vec2 c1 = vec2(-0.5, -0.5);
    // const vec2 c2 = vec2(1.5, -0.5);
    // const vec2 c3 = vec2(-0.5, 1.5);
    // const vec2 c4 = vec2(1.5, 1.5);
    const vec2 c1 = vec2(-0.5, -0.5);
    const vec2 c2 = vec2(1.5, -0.5);
    const vec2 c3 = vec2(-0.5, 1.5);
    const vec2 c4 = vec2(1.5, 1.5);
    vec4 a = mvM * vec4(-2.0,-2.0,0.0,1.0);
    vec4 b = mvM * vec4(2.0,-2.0,0.0,1.0);
    vec4 c = mvM * vec4(-2.0,2.0,0.0,1.0);
    vec4 d = mvM * vec4(2.0,2.0,0.0,1.0);

    vec4 pos= pM * vec4(uv*2.0-1.0, 0., 1.);
    vec3 p= pos.xyz/pos.w;

	//calc ray direction
    vec3 camera = vec3(0.0,0.0,0.0);
    vec3 dir = p-camera;
	dir = normalize(dir);

    vec4 test1 = hit(camera,dir,a.xyz,b.xyz,c.xyz);
    vec4 test2 = hit(camera,dir,c.xyz,b.xyz,d.xyz);
    vec4 test3 = hit(camera,dir,a.xyz,c.xyz,b.xyz);
    vec4 test4 = hit(camera,dir,c.xyz,d.xyz,b.xyz);

    vec2 resUV1 = (1.0-test1.x-test1.y) * c1 + test1.x * c2 + test1.y * c3;
    vec2 resUV2 = (1.0-test2.x-test2.y) * c3 + test2.x * c2 + test2.y * c4;
    vec2 resUV3 = (1.0-test3.x-test3.y) * c1 + test3.x * c3 + test3.y * c2;
    vec2 resUV4 = (1.0-test4.x-test4.y) * c3 + test4.x * c4 + test4.y * c2;

    vec2 resUV = step(0.,test1.w)*resUV1 + 
                 step(test1.w,0.)*step(0.,test2.w)*resUV2 + 
                 step(test1.w,0.)*step(test2.w,0.)*step(0.,test3.w)*resUV3 + 
                 step(test1.w,0.)*step(test2.w,0.)*step(test3.w,0.)*step(0.,test4.w)*resUV4 + 
                 step(test1.w,0.)*step(test2.w,0.)*step(test3.w,0.)*step(test4.w,0.)*vec2(-1.);

    return resUV;
}


float uvProtect(vec2 uvTemp)
{
    return step(0.,uvTemp.x)*step(0.,uvTemp.y)*step(uvTemp.x,1.0)*step(uvTemp.y,1.0);
}

vec2 interUV(float w, vec2 uv_0, vec2 uv_1, vec2 uv_2, vec2 uv_3, vec2 uv_4, vec2 uv_5)
{
    vec2 res = uv_5;
    float w0 = 5.0 * abs(w - 0.2) * step(0.0, w) * step(w, 0.2);
    float w1 = (1.0 - 5.0 * abs(w - 0.2)) * step(0.0, w) * step(w, 0.4);
    float w2 = (1.0 - 5.0 * abs(w - 0.4)) * step(0.2, w) * step(w, 0.6);
    float w3 = (1.0 - 5.0 * abs(w - 0.6)) * step(0.4, w) * step(w, 0.8);
    float w4 = (1.0 - 5.0 * abs(w - 0.8)) * step(0.6, w) * step(w, 1.0);
    float w5 = 5.0 * abs(w - 0.8) * step(0.8, w) * step(w, 1.0);
    res = w0 * uv_0 + w1 * uv_1 + w2 * uv_2 + w3 * uv_3 + w4 * uv_4 + w5 * uv_5;
    return res;
    // return vec2(w0+w1+w2+w3+w4+w5);
}

void main()
{    
    vec2 uv_0 = hitRect(mvMat0, pMat0, uv0);
    vec2 uv_1 = hitRect(mvMat1, pMat1, uv0);
    vec2 uv_2 = hitRect(mvMat2, pMat2, uv0);
    vec2 uv_3 = hitRect(mvMat3, pMat3, uv0);
    vec2 uv_4 = hitRect(mvMat4, pMat4, uv0);
    vec2 uv_5 = hitRect(mvMat5, pMat5, uv0);

    vec4 res = vec4(0.0);
    const float SAMPLE_COUNT = 50.;
    for (float i = 0.0; i <= SAMPLE_COUNT; i+=1.0)
    {
        vec2 uv = interUV(i/SAMPLE_COUNT, uv_0, uv_1, uv_2, uv_3, uv_4, uv_5);
        vec2 new_uv = uv;
        if(abs(y_offset) > 0.1){
            new_uv.y += y_offset;
            new_uv -= 0.5;
            new_uv.y *= 0.5;
            new_uv += 0.5;
        }
        // if(abs(y_offset) < 0.0001) new_uv = uv;
        res += texture2D(inputTex, new_uv) * alpha * uvProtect(uv);
    }
    res /= SAMPLE_COUNT+1.;
    // res.a = 1.0;

    // vec4 res = texture2D(inputTex, uv_5) * uvProtect(uv_5);

    gl_FragColor = res;
}
