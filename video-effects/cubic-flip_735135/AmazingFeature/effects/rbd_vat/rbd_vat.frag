#version 300 es

precision highp float;
layout(location = 0) out vec4 color0;
layout(location = 1) out vec4 color1;


in vec2 o_uv;
in vec2 o_uv_ao;
in vec4 o_col;
in vec2 uv_0;
in vec2 uv_1;
in highp vec2 uv_2;
in vec2 uv_3;
in vec2 uv_4;
in vec2 uv_5;
in vec2 uv_6;
in vec2 uv_7;

in vec4 FragPosLightSpace;

uniform vec4 u_ScreenParams;
uniform sampler2D refraTex;
uniform sampler2D refleTex;
uniform sampler2D normalBake;
uniform sampler2D normalBake1;
uniform sampler2D depth_tex;
uniform mat4 u_Model;

uniform samplerCube inputTex_cube;

uniform float iTime;
uniform float rotate_angle;
uniform float fade;
uniform float u_Alpha;
uniform float u_Specular;
uniform float u_fadeOut;
uniform float u_fadeInOut;
uniform float u_glow;

in vec2 vScreenPos;

in vec3 vNormal;
in vec3 vTangent;
in vec3 vBiNormal;
in vec3 vPosition;
in vec3 v_refraction;
in vec3 v_reflection;

in float f_fresnel;
in vec3 v_euler;
in float v_zdis;

const float PI = 3.1415926;
uniform float u_Progress;
uniform vec2 u_ratio;
uniform float display_frame;
uniform float u_imageScale;
void main()
{
    vec2 uu = uv_0;
    uu.y = 1.-uu.y;
    vec2 ratio = max(u_ScreenParams.x, u_ScreenParams.y) / u_ScreenParams.xy;
    // vec4 ts_normal = texture(normalBake, uu);
    // vec4 ts_normal1 = texture(normalBake1, uu);
    // ts_normal = mix(ts_normal, ts_normal1, fract(display_frame));
    vec4 oriColor = texture(refleTex, (vScreenPos - 0.5) * u_imageScale + 0.5);
    vec2 uv5 = uv_5;
    uv5 -= 0.5;
    uv5 *= u_ratio * u_imageScale;
    uv5 += 0.5;
    vec2 uv4 = vec2(uv_4.x, uv_4.y);
    vec4 resColor1 = texture(refleTex, uv5.xy);


    float yEuler = clamp(v_euler.z / PI * 2.05 - 0.05, 0.0, 1.0);
    float yEuler_All = clamp(v_euler.y / PI * 1.025 - 0.025, 0.0, 1.0);
    yEuler = pow(yEuler, 0.35);
    yEuler_All = pow(yEuler_All, 8.0);
    vec4 aoFactor = vec4(1.0);
    float depth = 14.44444 * 1.05;
    aoFactor = (vec4((abs(v_zdis) - depth) / depth + 1.0) - 1.0) * 1.65 + 1.0;
    aoFactor = clamp(aoFactor, 0.0, 1.0);
    aoFactor.a = 1.0;
    aoFactor = mix(vec4(1.0), aoFactor, yEuler);
    vec4 frontColor = vec4(0.0, 0.0, 0.0, 1.0 - aoFactor);
    vec4 leftColor = vec4(0.95, 0.95, 0.95, resColor1.a);


    frontColor = mix(frontColor, leftColor, yEuler) * aoFactor;
    leftColor = mix(leftColor, oriColor, yEuler_All);
    frontColor = mix(frontColor, oriColor, yEuler_All);

    color0 = mix(leftColor, resColor1, step(o_col.z, -0.1)) * aoFactor;
    color0 = mix(frontColor, color0, step(o_col.z, 0.1) * step(abs(o_col.y), 0.1)) * clamp(clamp(v_euler.y / PI * 1.025 - 0.025, 0.0, 1.0) * 30.0, 0.0, 1.0);
    // color0 *= mix(vec4(1.0), ts_normal, yEuler);
    // color1 = vec4(smoothstep(0.4, 0.5, abs(uv4.y - 0.5)) * yEuler, 0.0, 0.0, 1.0);
    // color0 = vec4((abs(v_zdis) - 14.44444) / 14.444 + 1.1);
    // color0.a = 1.0;
}