precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform sampler2D blurTex;
// uniform vec2 u_ScreenParams;
// uniform float input_fov;
// uniform float test_scale;

// uniform float d_power;
// uniform float z_power;

// uniform vec2 circle_info;
// precision highp float;

uniform vec2 u_ScreenParams;
uniform float input_fov;



vec2 Distort(vec2 _u,vec2 u_ScreenParams){
    vec2 p = _u;
    p -= 0.5;
    p.x *= u_ScreenParams.x/u_ScreenParams.y ;
    p *= 0.5;
    float d = length(p);
    float r = d/(1.+d*input_fov);
    float phi = atan(p.y, p.x);
    p = vec2(r*cos(phi), r*sin(phi));
    p /= 0.5;
    p.x /= u_ScreenParams.x/u_ScreenParams.y;
    p += 0.5;
    return p;
}



void main()
{
    vec2 uv1 = uv0;
    vec4 res = texture2D(inputTex, Distort(uv1,u_ScreenParams.xy));
    vec4 sucaiCol = texture2D(blurTex,uv1);
    sucaiCol.rgb = clamp(sucaiCol.rgb/sucaiCol.a,0.0,1.0);
    // res=mix(res,sucaiCol,sucaiCol.a);
    gl_FragColor = res;
}
