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
    vec2 _30 = (_15 * rectUV) + dustUV;
    vec4 _t1 = mix(texture(endImg, _30), texture(inputTex, _30), vec4(smoothstep(0.949999988079071044921875, 1.0, particleOpacity)));
    _t1.w *= (particleOpacity * mix(smoothstep(0.5, 0.449999988079071044921875, length(_15)), 1.0, clamp(20.0 * (particleOpacity - 0.949999988079071044921875), 0.0, 1.0)));
    if (AEPlugin == 1)
    {
        vec4 _83 = _t1;
        float _86 = _t1.w;
        vec3 _90 = clamp(_83.xyz * _86, vec3(0.0), vec3(1.0));
        _t1.x = _90.x;
        _t1.y = _90.y;
        _t1.z = _90.z;
    }
    o_fragColor = _t1;
}

