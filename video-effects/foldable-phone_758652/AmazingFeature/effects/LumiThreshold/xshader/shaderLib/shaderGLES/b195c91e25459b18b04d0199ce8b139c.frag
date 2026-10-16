precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform float u_binary;
uniform float u_threshold;
uniform float u_grayrange;

varying vec2 v_uv;

void main()
{
    mediump vec4 _19 = texture2D(u_inputTexture, v_uv);
    vec4 _t0 = _19;
    float _24 = _t0.w;
    vec3 _31 = _19.xyz / vec3(max(_24, 0.001000000047497451305389404296875));
    _t0.x = _31.x;
    _t0.y = _31.y;
    _t0.z = _31.z;
    if (u_binary > 0.5)
    {
        if (dot(_t0.xyz, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)) < u_threshold)
        {
            gl_FragData[0] = vec4(0.0, 0.0, 0.0, 1.0) * _t0.w;
        }
        else
        {
            gl_FragData[0] = vec4(1.0) * _t0.w;
        }
    }
    else
    {
        gl_FragData[0] = vec4(vec3(max((dot(_t0.xyz, vec3(0.333000004291534423828125)) - u_threshold) / max(u_grayrange, 0.001000000047497451305389404296875), min((max(_t0.x, max(_t0.y, _t0.z)) - min(_t0.x, min(_t0.y, _t0.z))) * 5.0, 1.0))), 1.0);
    }
}

