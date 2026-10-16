precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform float u_Convergence;
uniform float u_Radius;
uniform float u_Scale;
uniform vec2 u_Center;
uniform vec2 u_ScreenSize;
vec2 uvProtect(vec2 uv)
{
    return step(vec2(0.0), uv) * step(uv, vec2(1.0));
}
vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}
vec3 barrel(vec2 uv)
{
    vec2 distortionCenter = u_Center;
    vec2 tuv = (uv - distortionCenter);
    tuv /= 1.07;
    if (u_ScreenSize.x > u_ScreenSize.y)
    {
        tuv.y *= u_ScreenSize.y / u_ScreenSize.x;
    }
    else
    {
        tuv.x *= u_ScreenSize.x / u_ScreenSize.y;
    }
    float distortion_k1 = -u_Convergence * 96.25 * 1920.0 / 1080.0 * u_ScreenSize.y / u_ScreenSize.x / pow(u_Radius, 2.0);
    float distortion_k2 = 0.0;
    float rr = length(tuv);
    float r2 = rr * (1.0 + distortion_k1 * (rr * rr) + distortion_k2 * (rr * rr * rr));
    float theta = atan(tuv.x, tuv.y);
    float distortion_x = sin(theta) * r2 * 1.0;
    float distortion_y = cos(theta) * r2 * 1.0;
    vec2 dest_uv = vec2(distortion_x, distortion_y);
    if (u_ScreenSize.x > u_ScreenSize.y)
    {
        dest_uv.y *= u_ScreenSize.x / u_ScreenSize.y;
    }
    else
    {
        dest_uv.x *= u_ScreenSize.y / u_ScreenSize.x;
    }
    dest_uv *= 1.07;
    dest_uv += distortionCenter;
    return vec3(dest_uv, rr);
}

void main()
{
    vec2 uv = uv0-0.5;
    uv /= max(0.001,u_Scale);
    uv += 0.5;

    vec3 x = barrel((uv));
    uv = x.xy;
    
    gl_FragColor = texture2D(u_InputTex, flip_uv(uv)) * step(x.z, (u_Radius) * 0.01 + 0.01 * (u_Radius * 0.02));
    // gl_FragColor = vec4(u_Convergence,0,0,1);
    // gl_FragColor.a = 1.;
}
