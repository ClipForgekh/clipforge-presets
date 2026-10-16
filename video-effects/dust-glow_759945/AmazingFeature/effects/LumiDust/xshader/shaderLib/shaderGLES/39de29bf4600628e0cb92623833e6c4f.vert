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
uniform mediump sampler2D maskNoiseTex;
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

mat2 _f0(float _p0)
{
    float _22 = cos(_p0);
    float _25 = sin(_p0);
    return mat2(vec2(_22, -_25), vec2(_25, _22));
}

vec2 _f1(vec4 _p0)
{
    return vec2(_p0.x + (_p0.y / 255.0), _p0.z + (_p0.w / 255.0));
}

void main()
{
    float _71 = float(gl_InstanceID);
    sprite_uv = attUV;
    vec2 _88 = floor(vec2(normalW, normalH) * dustNum);
    vec2 _t6 = _88;
    vec2 _112 = vec2((floor(_71 / _t6.y) + 0.5) / _t6.x, (mod(_71, _t6.y) + 0.5) / _t6.y);
    dustUV = _112;
    rectUV = vec2(dustSize) / _88;
    float _128 = u_ScreenParams.y / u_ScreenParams.x;
    vec2 _143 = _112 * vec2(1.0 / max(1.0, _128), 1.0 / max(1.0, 1.0 / _128));
    particleColor = textureLod(inputTex, _112, 4.0);
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    float param = mask_line_rot;
    vec4 param_1 = textureLod(noiseTex, _143, 4.0);
    vec2 _t18 = _f1(param_1);
    vec2 _211 = u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _t19 = _211;
    float _t20 = ((_t18.x - 0.5) / _t19.x) * distorIns;
    float _t21 = ((_t18.y - 0.5) / _t19.y) * distorIns;
    vec4 param_2 = textureLod(maskNoiseTex, _143, 4.0);
    vec2 _t22 = _f1(param_2);
    float _249 = progress * (1.0 + noiseFeather);
    float _258 = smoothstep((-noiseFeather) + _249, 0.0 + _249, _t22.x);
    float _261 = 1.0 - _258;
    _t20 *= pow(_261, 0.89999997615814208984375);
    _t21 *= pow(_261, 1.10000002384185791015625);
    particleOpacity = pow(_258, 0.25);
    particleColor.w *= particleOpacity;
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    vec3 _300 = vec3((_112 * 2.0) - vec2(1.0), 0.0) - vec3(0.0);
    vec3 _t26 = _300;
    vec2 _304 = _300.xy * _211;
    _t26.x = _304.x;
    _t26.y = _304.y;
    vec3 _363 = vec3(_261);
    vec3 _413 = mix(vec3(startMoveX, startMoveY, startMoveZ), vec3(endMoveX, endMoveY, endMoveZ), _363);
    vec3 _t31 = _413;
    vec2 _427 = _413.xy * _211;
    _t31.x = _427.x;
    _t31.y = _427.y;
    vec3 _t30 = ((mat3(vec3(mix(u_StartRot_Row1.xyz, u_EndRot_Row1.xyz, _363)), vec3(mix(u_StartRot_Row2.xyz, u_EndRot_Row2.xyz, _363)), vec3(mix(u_StartRot_Row3.xyz, u_EndRot_Row3.xyz, _363))) * _t26) * mix(startSize, endSize, _261)) + _t31;
    _t30.z *= 0.300000011920928955078125;
    _t26 = _t30;
    vec2 _444 = _t30.xy / _211;
    _t26.x = _444.x;
    _t26.y = _444.y;
    vec3 _450 = _t26;
    vec3 _462 = (_450 + vec3(0.0)) + vec3(_t20, _t21, clamp((_t20 + _t21) * 0.00999999977648258209228515625, -1.0, 1.0));
    _t26 = _462;
    vec4 _t33 = u_MVP * vec4((attPosition.xy * rectUV) + _462.xy, _t26.z, 1.0);
    _t33.x *= (u_ScreenParams.x / u_ScreenParams.y);
    gl_Position = _t33;
    testUV = attUV;
}

