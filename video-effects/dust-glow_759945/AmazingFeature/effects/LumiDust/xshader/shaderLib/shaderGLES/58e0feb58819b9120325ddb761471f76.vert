#version 300 es

uniform float normalW;
uniform float normalH;
uniform float dustNum;
uniform float dustSize;
uniform vec4 u_ScreenParams;
uniform mediump sampler2D inputTex;
uniform float mask_line_rot;
uniform mediump sampler2D noiseTex;
uniform float distorIns;
uniform mediump sampler2D mask_image;
uniform float noiseFeather;
uniform float progress;
uniform vec4 u_StartRot_Row1;
uniform vec4 u_StartRot_Row2;
uniform vec4 u_StartRot_Row3;
uniform vec4 u_EndRot_Row1;
uniform vec4 u_EndRot_Row2;
uniform vec4 u_EndRot_Row3;
uniform float startMoveX;
uniform float startMoveY;
uniform float startMoveZ;
uniform float endMoveX;
uniform float endMoveY;
uniform float endMoveZ;
uniform float startSize;
uniform float endSize;
uniform mat4 u_MVP;

out vec2 sprite_uv;
layout(location = 2) in vec2 attUV;
out vec2 dustUV;
out vec2 rectUV;
out vec4 particleColor;
out float particleOpacity;
layout(location = 0) in vec3 attPosition;
out vec2 testUV;
out float particleProgress;

mat2 _f1(float _p0)
{
    float _48 = cos(_p0);
    float _51 = sin(_p0);
    return mat2(vec2(_48, -_51), vec2(_51, _48));
}

vec2 _f2(vec4 _p0)
{
    return vec2(_p0.x + (_p0.y / 255.0), _p0.z + (_p0.w / 255.0));
}

float _f0(vec3 _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

void main()
{
    float _93 = float(gl_InstanceID);
    sprite_uv = attUV;
    vec2 _110 = floor(vec2(normalW, normalH) * dustNum);
    vec2 _t6 = _110;
    vec2 _134 = vec2((floor(_93 / _t6.y) + 0.5) / _t6.x, (mod(_93, _t6.y) + 0.5) / _t6.y);
    dustUV = _134;
    rectUV = vec2(dustSize) / _110;
    float _150 = u_ScreenParams.y / u_ScreenParams.x;
    particleColor = textureLod(inputTex, _134, 4.0);
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    float param = mask_line_rot;
    vec4 param_1 = textureLod(noiseTex, _134 * vec2(1.0 / max(1.0, _150), 1.0 / max(1.0, 1.0 / _150)), 4.0);
    vec2 _t18 = _f2(param_1);
    vec2 _233 = u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _t19 = _233;
    float _t20 = ((_t18.x - 0.5) / _t19.x) * distorIns;
    float _t21 = ((_t18.y - 0.5) / _t19.y) * distorIns;
    vec3 param_2 = textureLod(mask_image, _134, 4.0).xyz;
    float _274 = progress * (1.0 + noiseFeather);
    float _282 = smoothstep((-noiseFeather) + _274, 0.0 + _274, _f0(param_2));
    float _285 = 1.0 - _282;
    _t20 *= pow(_285, 0.89999997615814208984375);
    _t21 *= pow(_285, 1.10000002384185791015625);
    particleOpacity = pow(_282, 0.25);
    particleColor.w *= particleOpacity;
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    vec3 _322 = vec3((_134 * 2.0) - vec2(1.0), 0.0) - vec3(0.0);
    vec3 _t27 = _322;
    vec2 _326 = _322.xy * _233;
    _t27.x = _326.x;
    _t27.y = _326.y;
    vec3 _385 = vec3(_285);
    vec3 _435 = mix(vec3(startMoveX, startMoveY, startMoveZ), vec3(endMoveX, endMoveY, endMoveZ), _385);
    vec3 _t32 = _435;
    vec2 _449 = _435.xy * _233;
    _t32.x = _449.x;
    _t32.y = _449.y;
    vec3 _t31 = ((mat3(vec3(mix(u_StartRot_Row1.xyz, u_EndRot_Row1.xyz, _385)), vec3(mix(u_StartRot_Row2.xyz, u_EndRot_Row2.xyz, _385)), vec3(mix(u_StartRot_Row3.xyz, u_EndRot_Row3.xyz, _385))) * _t27) * mix(startSize, endSize, _285)) + _t32;
    _t31.z *= 0.300000011920928955078125;
    _t27 = _t31;
    vec2 _466 = _t31.xy / _233;
    _t27.x = _466.x;
    _t27.y = _466.y;
    vec3 _472 = _t27;
    vec3 _484 = (_472 + vec3(0.0)) + vec3(_t20, _t21, clamp((_t20 + _t21) * 0.00999999977648258209228515625, -1.0, 1.0));
    _t27 = _484;
    vec4 _t34 = u_MVP * vec4((attPosition.xy * rectUV) + _484.xy, _t27.z, 1.0);
    _t34.x *= (u_ScreenParams.x / u_ScreenParams.y);
    gl_Position = _t34;
    testUV = attUV;
}

