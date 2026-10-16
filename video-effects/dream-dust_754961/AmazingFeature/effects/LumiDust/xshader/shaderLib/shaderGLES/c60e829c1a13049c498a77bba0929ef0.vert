#version 300 es

uniform float normalW;
uniform float normalH;
uniform float dustNum;
uniform float dustSize;
uniform mediump sampler2D inputTex;
uniform float mask_line_rot;
uniform mediump sampler2D noiseTex;
uniform vec4 u_ScreenParams;
uniform float distorIns;
uniform int maskType;
uniform mediump sampler2D maskNoiseTex;
uniform float noiseFeather;
uniform float progress;
uniform mediump sampler2D mask_image;
uniform float startRotZ;
uniform float startRotY;
uniform float startRotX;
uniform float endRotZ;
uniform float endRotY;
uniform float endRotX;
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
    float _59 = cos(_p0);
    float _62 = sin(_p0);
    return mat2(vec2(_59, -_62), vec2(_62, _59));
}

vec2 _f2(vec4 _p0)
{
    return vec2(_p0.x + (_p0.y / 255.0), _p0.z + (_p0.w / 255.0));
}

float _f0(vec3 _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

vec4 _f4(float _p0, float _p1, float _p2)
{
    float _256 = cos(_p2 * 0.5);
    float _260 = sin(_p2 * 0.5);
    float _264 = cos(_p1 * 0.5);
    float _268 = sin(_p1 * 0.5);
    float _272 = cos(_p0 * 0.5);
    float _276 = sin(_p0 * 0.5);
    float _280 = _256 * _264;
    float _285 = _260 * _268;
    float _304 = _260 * _264;
    float _309 = _256 * _268;
    return vec4((_280 * _272) + (_285 * _276), (_280 * _276) - (_285 * _272), (_304 * _276) + (_309 * _272), (_304 * _272) - (_309 * _276));
}

vec3 _f3(vec4 _p0, vec3 _p1)
{
    vec4 _t5 = _p0;
    float _125 = _t5.w * _t5.w;
    float _128 = _t5.x * _t5.x;
    float _132 = _t5.y * _t5.y;
    float _136 = _t5.z * _t5.z;
    float _143 = _t5.x * _t5.y;
    float _146 = _t5.w * _t5.z;
    float _154 = _t5.x * _t5.z;
    float _157 = _t5.w * _t5.y;
    vec3 _t13;
    _t13.x = (((((_125 + _128) - _132) - _136) * _p1.x) + ((2.0 * (_143 - _146)) * _p1.y)) + ((2.0 * (_154 + _157)) * _p1.z);
    float _180 = _125 - _128;
    float _194 = _t5.y * _t5.z;
    float _197 = _t5.w * _t5.x;
    _t13.y = (((2.0 * (_143 + _146)) * _p1.x) + (((_180 + _132) - _136) * _p1.y)) + ((2.0 * (_194 - _197)) * _p1.z);
    _t13.y *= (-1.0);
    _t13.z = (((2.0 * (_154 - _157)) * _p1.x) + ((2.0 * (_194 + _197)) * _p1.y)) + (((_180 - _132) + _136) * _p1.z);
    return _t13;
}

void main()
{
    float _337 = float(gl_InstanceID);
    sprite_uv = attUV;
    vec2 _354 = floor(vec2(normalW, normalH) * dustNum);
    vec2 _t25 = _354;
    vec2 _377 = vec2((floor(_337 / _t25.y) + 0.5) / _t25.x, (mod(_337, _t25.y) + 0.5) / _t25.y);
    dustUV = _377;
    rectUV = vec2(dustSize) / _354;
    particleColor = textureLod(inputTex, _377, 0.0);
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    float param = mask_line_rot;
    vec2 _t29 = ((_377 - vec2(0.5)) * _f1(param)) + vec2(0.5);
    float _t32 = 1.0;
    vec4 param_1 = textureLod(noiseTex, _377, 0.0);
    vec2 _t33 = _f2(param_1);
    vec2 _453 = u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _t34 = _453;
    float _t35 = ((_t33.x - 0.5) / _t34.x) * distorIns;
    float _t36 = ((_t33.y - 0.5) / _t34.y) * distorIns;
    if (maskType == 0)
    {
        vec4 param_2 = textureLod(maskNoiseTex, _377, 0.0);
        vec2 _t37 = _f2(param_2);
        float _498 = progress * (1.0 + noiseFeather);
        float _507 = smoothstep((-noiseFeather) + _498, 0.0 + _498, _t37.x);
        _t32 = _507;
        float _510 = 1.0 - _507;
        _t35 *= pow(_510, 0.89999997615814208984375);
        _t36 *= pow(_510, 1.10000002384185791015625);
    }
    else
    {
        if (maskType == 1)
        {
            float _541 = progress * (1.0 + noiseFeather);
            float _549 = smoothstep((-noiseFeather) + _541, 0.0 + _541, ((_t29.x - 0.5) / (1.41421353816986083984375 * cos(0.7853000164031982421875 - (abs(mod((mask_line_rot / 0.7853000164031982421875) + 1.0, 2.0) - 1.0) * 0.7853000164031982421875)))) + 0.5);
            _t32 = _549;
            float _552 = 1.0 - _549;
            _t35 *= pow(_552, 0.89999997615814208984375);
            _t36 *= pow(_552, 1.10000002384185791015625);
        }
        else
        {
            if (maskType == 2)
            {
                vec3 param_3 = textureLod(mask_image, _377, 0.0).xyz;
                float _584 = progress * (1.0 + noiseFeather);
                float _592 = smoothstep((-noiseFeather) + _584, 0.0 + _584, _f0(param_3));
                _t32 = _592;
                float _595 = 1.0 - _592;
                _t35 *= pow(_595, 0.89999997615814208984375);
                _t36 *= pow(_595, 1.10000002384185791015625);
            }
        }
    }
    particleOpacity = pow(_t32, 0.25);
    particleColor.w *= particleOpacity;
    if (particleColor.w < 0.00999999977648258209228515625)
    {
        gl_Position = vec4(20.0, 20.0, 20.0, 1.0);
        gl_PointSize = 1.0;
        return;
    }
    vec3 _630 = vec3((_377 * 2.0) - vec2(1.0), 0.0) - vec3(0.0);
    vec3 _t48 = _630;
    vec2 _634 = _630.xy * _453;
    _t48.x = _634.x;
    _t48.y = _634.y;
    float _641 = 1.0 - _t32;
    vec3 _658 = vec3(_641);
    vec3 _t50 = mix(vec3(startRotZ, startRotY, startRotX), vec3(endRotZ, endRotY, endRotX), _658);
    float param_4 = _t50.x;
    float param_5 = _t50.y;
    float param_6 = _t50.z;
    vec4 param_7 = _f4(param_4, param_5, param_6);
    vec3 param_8 = _t48;
    vec3 _694 = mix(vec3(startMoveX, startMoveY, startMoveZ), vec3(endMoveX, endMoveY, endMoveZ), _658);
    vec3 _t53 = _694;
    vec2 _708 = _694.xy * _453;
    _t53.x = _708.x;
    _t53.y = _708.y;
    vec3 _t52 = (_f3(param_7, param_8) * mix(startSize, endSize, _641)) + _t53;
    _t52.z *= 0.300000011920928955078125;
    _t48 = _t52;
    vec2 _725 = _t52.xy / _453;
    _t48.x = _725.x;
    _t48.y = _725.y;
    vec3 _731 = _t48;
    vec3 _742 = (_731 + vec3(0.0)) + vec3(_t35, _t36, clamp((_t35 + _t36) * 0.00999999977648258209228515625, -1.0, 1.0));
    _t48 = _742;
    vec4 _t55 = u_MVP * vec4((attPosition.xy * rectUV) + _742.xy, _t48.z, 1.0);
    _t55.x *= (u_ScreenParams.x / u_ScreenParams.y);
    gl_Position = _t55;
    testUV = attUV;
}

