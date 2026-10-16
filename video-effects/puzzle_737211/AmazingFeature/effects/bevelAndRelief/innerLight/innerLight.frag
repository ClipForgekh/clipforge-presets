precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTex;
uniform sampler2D u_alphaTex;
uniform vec4 u_ScreenParams;
uniform float u_lightDirection;
uniform float u_lightHeight;
uniform float u_roughness;
uniform float u_specOpacity;
uniform vec3 u_specColor;
uniform float u_shadowOpacity;
uniform vec3 u_shadowColor;
uniform float u_depth;
#define PI 3.14159265359
float decode(vec4 g) {
    float ret = 0.0;
    ret = g.x + g.y / 255.0 + g.z / (65025.0) + g.w / (16581375.0);
    return ret;
}

vec2 calcGradientCode (sampler2D tex, vec2 uv, float step, vec2 ratio) {
    vec2 offset = step * 1.0 / vec2(ratio);
    float xLeft  = decode(texture2D(tex, uv - vec2(offset.x, 0.0)));
    float xRight = decode(texture2D(tex, uv + vec2(offset.x, 0.0)));
    float yDown  = decode(texture2D(tex, uv - vec2(0.0, offset.y)));
    float yUp    = decode(texture2D(tex, uv + vec2(0.0, offset.y)));
    xLeft  = pow(xLeft , u_depth);
    xRight = pow(xRight, u_depth);
    yDown  = pow(yDown , u_depth);
    yUp    = pow(yUp   , u_depth);
    
    vec2 normal  = vec2(xLeft - xRight, yDown - yUp);
    return normal;
}

void main()
{
    vec4 oriColor = texture2D(u_inputTex, vec2(uv0.x, uv0.y));
    vec2 normal2D = calcGradientCode(u_alphaTex, uv0, 2.0, u_ScreenParams.xy);
    float alpha = decode(texture2D(u_alphaTex, uv0));
    // alpha = pow(alpha, u_depth);
    vec3 normal = normalize(vec3(normal2D, 0.0));
    // vec3 N = pow(abs(normal), vec3(u_depth)) * sign(normal) * u_lightHeight;
    vec3 N = normal * u_lightHeight;
    // vec3 V = vec3(uv0, 1.);
    vec3 L = normalize(vec3(cos(u_lightDirection * PI / 180.), sin(u_lightDirection * PI / 180.), 0));
    vec3 invL = -normalize(vec3(cos(u_lightDirection * PI / 180.), sin(u_lightDirection * PI / 180.), 0));

    float lightAlpha = (1.0 - alpha);
    // vec3 H = normalize(V + L);
    float intensity = max(dot(N, L), 0.0);
    
    float spec = pow((intensity), u_roughness);


    // H = normalize(V + invL);
    intensity = max(dot(N, invL), 0.0);
    float shadow = pow((intensity), u_roughness);
    vec4 resColor = oriColor;
    resColor.rgb = mix(resColor.rgb, resColor.rgb + u_specColor * oriColor.a, spec * lightAlpha * u_specOpacity);
    resColor.rgb = mix(resColor.rgb, u_shadowColor * oriColor.a * resColor.rgb, shadow * lightAlpha * u_shadowOpacity);
    gl_FragColor = resColor;
    // gl_FragColor = vec4(normal, 1.0);
}
