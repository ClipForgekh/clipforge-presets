#version 300 es
precision highp float;
precision highp int;

uniform mediump sampler2D inputTex;
uniform mediump sampler2D endImg;
uniform mediump int AEPlugin;

in vec2 testUV;
in vec2 rectUV;
in vec2 dustUV;
in float particleOpacity;
layout(location = 0) out vec4 o_fragColor;

void main()
{
    vec2 _15 = testUV - vec2(0.5);
    vec2 _38 = (_15 * rectUV) + dustUV;
    vec4 _t1 = mix(texture(endImg, _38), texture(inputTex, _38), vec4(smoothstep(0.949999988079071044921875, 1.0, particleOpacity)));
    _t1.w *= (particleOpacity * mix(smoothstep(0.5, 0.449999988079071044921875, length(_15)), 1.0, clamp(20.0 * (particleOpacity - 0.949999988079071044921875), 0.0, 1.0)));
    if (AEPlugin == 1)
    {
        vec4 _91 = _t1;
        float _94 = _t1.w;
        vec3 _98 = clamp(_91.xyz * _94, vec3(0.0), vec3(1.0));
        _t1.x = _98.x;
        _t1.y = _98.y;
        _t1.z = _98.z;
    }
    o_fragColor = _t1;
}

