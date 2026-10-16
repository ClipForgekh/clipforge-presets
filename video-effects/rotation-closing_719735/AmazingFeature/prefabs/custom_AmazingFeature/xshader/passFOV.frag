precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform float progress;
uniform vec4 u_ScreenParams;
uniform float centerX;
uniform float centerY;
uniform float out_size;
uniform float strength;
uniform float fov;

float cut(vec2 uv){
    return  step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 junlin_barrel(vec2 _uv)
{ 
    vec2 in_info = vec2(0.0, -strength * fov);
    float back_distort=0.;
    vec2 screenSize = vec2(u_ScreenParams.x, u_ScreenParams.y);
    vec2 uv = _uv - (vec2(centerX,centerY)+0.5);
    if(screenSize.x < screenSize.y) uv.y *= screenSize.y/screenSize.x;
    else uv.x *= screenSize.x/screenSize.y;

    float r2 = uv.x * uv.x + uv.y * uv.y;
    
    float test; 
    if(out_size > 1.){
        test = (1.25 - 0.25 * out_size);
    }else{
        test = (1./out_size / out_size);
    }

    float f = 1.0 + pow(r2, .5+back_distort*2.) * (in_info.y);

    if(screenSize.x < screenSize.y) uv.y /= screenSize.y/screenSize.x;
    else uv.x /= screenSize.x/screenSize.y;

    return f * 1. * uv + (vec2(centerX,centerY)+0.5);
}

float DiagnalLen(){
    vec2 screenSize = vec2(u_ScreenParams.x, u_ScreenParams.y);
    float maxlen = max(screenSize.x/screenSize.y, screenSize.y/screenSize.x);
    return length(vec2(maxlen, 1.));
}

float Mask(vec2 _uv){
    vec2 screenSize = vec2(u_ScreenParams.x, u_ScreenParams.y);
    vec2 uv = _uv;
    uv -= (vec2(centerX,centerY)+0.5);

    float maxlen = max(screenSize.x/screenSize.y, screenSize.y/screenSize.x);
    if(screenSize.x < screenSize.y) uv.y *= screenSize.y/screenSize.x;
    else uv.x *= screenSize.x/screenSize.y;

    float d = length(uv * 2.);

    float val = DiagnalLen() * out_size;

    d = smoothstep(val, val + 0.01, d);
    return d;
}

void main()
{
    vec2 uv = vec2(uv0.x, uv0.y);
    float mask = Mask(uv);
    vec4 col=vec4(vec3(0.),1.0);

    vec2 r_uv =junlin_barrel(uv);

    vec4 inCol = texture2D(u_albedo, r_uv);
    vec2 center=vec2(centerX,centerY)+vec2(.5);
    vec2 l=(r_uv-center);
    vec2 stepUV=vec2(u_ScreenParams.z-1., u_ScreenParams.w-1.);
    // inCol.r=texture2D(u_albedo,r_uv-l*colDiffStrength*strength*.1).r;
    col = mix(
        inCol,
        vec4(vec3(.7), 1.),
        mask
    );

    col = mix(
        vec4(vec3(.7), 1.),
        col,
        cut(junlin_barrel(uv))
    );
    gl_FragColor = col;
}
