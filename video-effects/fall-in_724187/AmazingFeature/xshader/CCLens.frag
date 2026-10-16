precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform float u_Convergence;
uniform float u_Radius;
uniform vec2 u_Center;
uniform vec4 u_ScreenParams;
vec2 uvProtect(vec2 uv)
{
    return step(vec2(0.0), uv) * step(uv, vec2(1.0));
}

vec3 barrel(vec2 uv)
{
    vec2 distortionCenter = u_Center;
    vec2 tuv = (uv - distortionCenter);
    tuv.x *= u_ScreenParams.x / u_ScreenParams.y;
    float distortion_k1 = -u_Convergence * 96.25 * 1920.0 / 1080.0 * u_ScreenParams.y / u_ScreenParams.x / pow(u_Radius, 2.0);
    float distortion_k2 = 0.0;
    float rr = length(tuv);
    float r2 = rr * (1.0 + distortion_k1 * (rr * rr) + distortion_k2 * (rr * rr * rr));
    float theta = atan(tuv.x, tuv.y);
    float distortion_x = sin(theta) * r2 * 1.0;
    float distortion_y = cos(theta) * r2 * 1.0;
    vec2 dest_uv = vec2(distortion_x, distortion_y);
    dest_uv.x *= u_ScreenParams.y / u_ScreenParams.x;
    dest_uv += distortionCenter;
    return vec3(dest_uv, rr);
}

void main()
{
    vec2 uv = uv0;
    vec3 x = barrel(uv0);
    uv = x.xy;
    
    vec2 uvp = uvProtect(uv);
    gl_FragColor = texture2D(u_InputTex, uv) * uvp.x * uvp.y * step(x.z, (u_Radius) * 0.01 + 0.01 * (u_Radius * 0.02));
}
