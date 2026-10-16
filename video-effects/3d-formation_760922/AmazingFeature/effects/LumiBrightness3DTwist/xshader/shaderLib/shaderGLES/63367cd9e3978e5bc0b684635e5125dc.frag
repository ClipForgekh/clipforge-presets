#version 300 es
precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform float u_gridVerticalNumber;
uniform float u_instanceNumber;
uniform float u_gridVerticalSize;
uniform float u_gridHorizontalSize;
uniform float u_invertGridFlag;
uniform float u_gridFlag;
uniform float u_AAFlag;

in vec2 v_uv;
layout(location = 0) out vec4 o_fragColor;
in vec4 screenPos;

void main()
{
    mediump vec4 _19 = texture(u_inputTexture, v_uv);
    float _26 = 1.0 / u_gridVerticalNumber;
    float _30 = 1.0 / u_instanceNumber;
    float _110 = mix(smoothstep(0.0, 0.00200000009499490261077880859375, ((0.5 * _26) * u_gridVerticalSize) - abs(((floor(v_uv.y / _26) + 0.5) * _26) - v_uv.y)) * step(0.00200000009499490261077880859375 * u_gridVerticalNumber, u_gridVerticalSize), 1.0, step(1.0 - (9.9999997473787516355514526367188e-05 * u_gridVerticalNumber), u_gridVerticalSize)) * mix(smoothstep(0.0, 0.00200000009499490261077880859375, ((0.5 * _30) * u_gridHorizontalSize) - abs(((floor(v_uv.x / _30) + 0.5) * _30) - v_uv.x)) * step(0.00200000009499490261077880859375 * u_instanceNumber, u_gridHorizontalSize), 1.0, step(1.0 - (9.9999997473787516355514526367188e-05 * u_instanceNumber), u_gridHorizontalSize));
    vec4 _126 = mix(_19, _19 * mix(_110, 1.0 - _110, u_invertGridFlag), vec4(u_gridFlag));
    vec4 _147 = (((_126 * smoothstep(0.0, 0.004999999888241291046142578125, v_uv.y)) * smoothstep(1.0, 0.99500000476837158203125, v_uv.y)) * smoothstep(0.0, 0.004999999888241291046142578125, v_uv.x)) * smoothstep(1.0, 0.99500000476837158203125, v_uv.x);
    vec4 _t8 = _147;
    o_fragColor = mix(_126, _147, vec4(u_AAFlag));
    gl_FragDepth = mix(1.0, screenPos.z * 0.00999999977648258209228515625, _t8.w);
}

