precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform float u_intensity;
uniform float u_lowerLimit;
uniform float u_upperLimit;

varying vec2 v_uv;

void main()
{
    mediump vec4 _19 = texture2D(u_inputTexture, v_uv);
    vec4 _t0 = _19;
    float _51 = mix(max(max(_t0.x, _t0.y), _t0.z), ((_t0.x + _t0.y) + _t0.z) / 3.0, u_intensity);
    if (_51 < u_lowerLimit)
    {
        gl_FragData[0] = vec4(0.0);
    }
    else
    {
        if (_51 > u_upperLimit)
        {
            gl_FragData[0] = vec4(_19.xyz, 1.0);
        }
        else
        {
            gl_FragData[0] = vec4(_19.xyz, (_51 - u_lowerLimit) / (u_upperLimit - u_lowerLimit));
        }
    }
}

