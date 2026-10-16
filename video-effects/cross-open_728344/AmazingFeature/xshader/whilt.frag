precision highp float;

uniform sampler2D white;

varying vec2 uv0;



float blend(float base) 
{ 
    return base ==0.?base:1.; 
} 
vec3 blend(vec3 base) {
    return vec3(blend(base.r),blend(base.g),blend(base.b));
}



void main()
{

    vec4 whiteColor = texture2D(white,uv0);
    // vec4 mixColor2 = vec4(blend(mixColor.rgb),mixColor.a);

    whiteColor.rgb = blend(whiteColor.rgb);
    

    gl_FragColor = whiteColor;
}