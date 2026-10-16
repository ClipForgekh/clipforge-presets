precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform mediump sampler2D u_blurTexture;

varying vec2 v_uv;

void main()
{
    vec4 _t1 = texture2D(u_blurTexture, v_uv);
    vec3 _t2 = texture2D(u_inputTexture, v_uv).xyz * _t1.w;
    if (_t1.w < 0.001000000047497451305389404296875)
    {
        _t2 = vec3(0.0);
    }
    gl_FragData[0] = vec4(_t2, _t1.w);
}

