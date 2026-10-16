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
uniform int maskType;
uniform mediump sampler2D maskNoiseTex;
uniform float noiseFeather;
uniform float progress;
uniform mediump sampler2D mask_image;
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
    vec2 _165 = _134 * vec2(1.0 / max(1.0, _150), 1.0 / max(1.0, 1.0 / _150));
    particleColor = textureLod(inputTex, _134, 4.0);
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    float param = mask_line_rot;
    vec2 _t14 = ((_134 - vec2(0.5)) * _f1(param)) + vec2(0.5);
    float _t17 = 1.0;
    vec4 param_1 = textureLod(noiseTex, _165, 4.0);
    vec2 _t18 = _f2(param_1);
    vec2 _233 = u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _t19 = _233;
    float _t20 = ((_t18.x - 0.5) / _t19.x) * distorIns;
    float _t21 = ((_t18.y - 0.5) / _t19.y) * distorIns;
    if (maskType == 0)
    {
        vec4 param_2 = textureLod(maskNoiseTex, _165, 4.0);
        vec2 _t22 = _f2(param_2);
        float _278 = progress * (1.0 + noiseFeather);
        float _287 = smoothstep((-noiseFeather) + _278, 0.0 + _278, _t22.x);
        _t17 = _287;
        float _290 = 1.0 - _287;
        _t20 *= pow(_290, 0.89999997615814208984375);
        _t21 *= pow(_290, 1.10000002384185791015625);
    }
    else
    {
        if (maskType == 1)
        {
            float _321 = progress * (1.0 + noiseFeather);
            float _329 = smoothstep((-noiseFeather) + _321, 0.0 + _321, ((_t14.x - 0.5) / (1.41421353816986083984375 * cos(0.7853000164031982421875 - (abs(mod((mask_line_rot / 0.7853000164031982421875) + 1.0, 2.0) - 1.0) * 0.7853000164031982421875)))) + 0.5);
            _t17 = _329;
            float _332 = 1.0 - _329;
            _t20 *= pow(_332, 0.89999997615814208984375);
            _t21 *= pow(_332, 1.10000002384185791015625);
        }
        else
        {
            if (maskType == 2)
            {
                vec3 param_3 = textureLod(mask_image, _134, 4.0).xyz;
                float _364 = progress * (1.0 + noiseFeather);
                float _372 = smoothstep((-noiseFeather) + _364, 0.0 + _364, _f0(param_3));
                _t17 = _372;
                float _375 = 1.0 - _372;
                _t20 *= pow(_375, 0.89999997615814208984375);
                _t21 *= pow(_375, 1.10000002384185791015625);
            }
        }
    }
    particleOpacity = pow(_t17, 0.25);
    particleColor.w *= particleOpacity;
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    vec3 _410 = vec3((_134 * 2.0) - vec2(1.0), 0.0) - vec3(0.0);
    vec3 _t33 = _410;
    vec2 _414 = _410.xy * _233;
    _t33.x = _414.x;
    _t33.y = _414.y;
    float _421 = 1.0 - _t17;
    vec3 _476 = vec3(_421);
    vec3 _526 = mix(vec3(startMoveX, startMoveY, startMoveZ), vec3(endMoveX, endMoveY, endMoveZ), _476);
    vec3 _t39 = _526;
    vec2 _540 = _526.xy * _233;
    _t39.x = _540.x;
    _t39.y = _540.y;
    vec3 _t38 = ((mat3(vec3(mix(u_StartRot_Row1.xyz, u_EndRot_Row1.xyz, _476)), vec3(mix(u_StartRot_Row2.xyz, u_EndRot_Row2.xyz, _476)), vec3(mix(u_StartRot_Row3.xyz, u_EndRot_Row3.xyz, _476))) * _t33) * mix(startSize, endSize, _421)) + _t39;
    _t38.z *= 0.300000011920928955078125;
    _t33 = _t38;
    vec2 _557 = _t38.xy / _233;
    _t33.x = _557.x;
    _t33.y = _557.y;
    vec3 _563 = _t33;
    vec3 _575 = (_563 + vec3(0.0)) + vec3(_t20, _t21, clamp((_t20 + _t21) * 0.00999999977648258209228515625, -1.0, 1.0));
    _t33 = _575;
    vec4 _t41 = u_MVP * vec4((attPosition.xy * rectUV) + _575.xy, _t33.z, 1.0);
    _t41.x *= (u_ScreenParams.x / u_ScreenParams.y);
    gl_Position = _t41;
    testUV = attUV;
}

