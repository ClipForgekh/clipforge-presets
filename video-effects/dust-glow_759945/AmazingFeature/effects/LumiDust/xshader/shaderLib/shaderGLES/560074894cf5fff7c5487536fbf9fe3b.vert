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
    particleColor = textureLod(inputTex, _112, 4.0);
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    float param = mask_line_rot;
    vec2 _t14 = ((_112 - vec2(0.5)) * _f0(param)) + vec2(0.5);
    vec4 param_1 = textureLod(noiseTex, _112 * vec2(1.0 / max(1.0, _128), 1.0 / max(1.0, 1.0 / _128)), 4.0);
    vec2 _t18 = _f1(param_1);
    vec2 _211 = u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _t19 = _211;
    float _249 = progress * (1.0 + noiseFeather);
    float _257 = smoothstep((-noiseFeather) + _249, 0.0 + _249, ((_t14.x - 0.5) / (1.41421353816986083984375 * cos(0.7853000164031982421875 - (abs(mod((mask_line_rot / 0.7853000164031982421875) + 1.0, 2.0) - 1.0) * 0.7853000164031982421875)))) + 0.5);
    float _260 = 1.0 - _257;
    float _265 = (((_t18.x - 0.5) / _t19.x) * distorIns) * pow(_260, 0.89999997615814208984375);
    float _270 = (((_t18.y - 0.5) / _t19.y) * distorIns) * pow(_260, 1.10000002384185791015625);
    particleOpacity = pow(_257, 0.25);
    particleColor.w *= particleOpacity;
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    vec3 _299 = vec3((_112 * 2.0) - vec2(1.0), 0.0) - vec3(0.0);
    vec3 _t26 = _299;
    vec2 _303 = _299.xy * _211;
    _t26.x = _303.x;
    _t26.y = _303.y;
    vec3 _362 = vec3(_260);
    vec3 _412 = mix(vec3(startMoveX, startMoveY, startMoveZ), vec3(endMoveX, endMoveY, endMoveZ), _362);
    vec3 _t31 = _412;
    vec2 _426 = _412.xy * _211;
    _t31.x = _426.x;
    _t31.y = _426.y;
    vec3 _t30 = ((mat3(vec3(mix(u_StartRot_Row1.xyz, u_EndRot_Row1.xyz, _362)), vec3(mix(u_StartRot_Row2.xyz, u_EndRot_Row2.xyz, _362)), vec3(mix(u_StartRot_Row3.xyz, u_EndRot_Row3.xyz, _362))) * _t26) * mix(startSize, endSize, _260)) + _t31;
    _t30.z *= 0.300000011920928955078125;
    _t26 = _t30;
    vec2 _443 = _t30.xy / _211;
    _t26.x = _443.x;
    _t26.y = _443.y;
    vec3 _449 = _t26;
    vec3 _461 = (_449 + vec3(0.0)) + vec3(_265, _270, clamp((_265 + _270) * 0.00999999977648258209228515625, -1.0, 1.0));
    _t26 = _461;
    vec4 _t33 = u_MVP * vec4((attPosition.xy * rectUV) + _461.xy, _t26.z, 1.0);
    _t33.x *= (u_ScreenParams.x / u_ScreenParams.y);
    gl_Position = _t33;
    testUV = attUV;
}

