precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform mediump sampler2D u_inputTexture2;
uniform mediump sampler2D u_inputTexture3;
uniform mediump sampler2D u_inputTexture4;
uniform mediump int u_cubeMidBool;
uniform mediump float u_timeType;

varying vec2 uv0;

void main()
{
    mediump vec4 _23 = texture2D(u_inputTexture, uv0);
    mediump vec4 _28 = texture2D(u_inputTexture2, uv0);
    mediump vec4 _t3 = _28;
    mediump vec4 _33 = texture2D(u_inputTexture3, uv0);
    mediump vec4 _t4 = _33;
    mediump vec4 _38 = texture2D(u_inputTexture4, uv0);
    mediump vec4 _t5 = _38;
    mediump vec3 _45 = _28.xyz - vec3(0.00999999977648258209228515625);
    _t3.x = _45.x;
    _t3.y = _45.y;
    _t3.z = _45.z;
    mediump vec4 _57 = _t3;
    mediump vec3 _65 = vec3(1.0) - pow(vec3(1.0) - _57.xyz, vec3(0.2857142984867095947265625));
    _t3.x = _65.x;
    _t3.y = _65.y;
    _t3.z = _65.z;
    mediump vec4 _72 = _t3;
    mediump vec4 _75 = clamp(_72, vec4(0.0), vec4(1.0));
    _t3 = _75;
    mediump vec4 _t6 = mix(_23, _75, vec4(_t3.w));
    mediump vec3 _93 = vec3(1.0) - pow(vec3(1.0) - _33.xyz, vec3(2.650000095367431640625));
    _t4.x = _93.x;
    _t4.y = _93.y;
    _t4.z = _93.z;
    _t4 = clamp(_t4, vec4(0.0), vec4(1.0));
    mediump vec3 _112 = vec3(1.0) - pow(vec3(1.0) - _38.xyz, vec3(2.650000095367431640625));
    _t5.x = _112.x;
    _t5.y = _112.y;
    _t5.z = _112.z;
    _t5 = clamp(_t5, vec4(0.0), vec4(1.0));
    if (u_cubeMidBool == 1)
    {
        _t6 = _23;
    }
    if ((u_timeType >= 1.0) && (u_timeType < 2.0))
    {
        _t6 = mix(mix(_t6, _t4, vec4(_t4.w)), _t5, vec4(_t5.w));
    }
    else
    {
        if ((u_timeType >= 2.0) && (u_timeType < 3.0))
        {
            _t6 = mix(mix(_t5, _t6, vec4(_t6.w)), _t4, vec4(_t4.w));
        }
        else
        {
            if ((u_timeType >= 3.0) && (u_timeType < 4.0))
            {
                _t6 = mix(mix(_t4, _t6, vec4(_t6.w)), _t5, vec4(_t5.w));
            }
            else
            {
                if ((u_timeType >= 4.0) && (u_timeType < 5.0))
                {
                    mediump vec4 _207 = _t6;
                    mediump float _209 = _t6.w;
                    mediump vec4 _211 = mix(_t5, _207, vec4(_209));
                    _t6 = _211;
                    _t6 = mix(_t4, _211, vec4(_t6.w));
                }
                else
                {
                    if ((u_timeType >= 5.0) && (u_timeType < 6.0))
                    {
                        mediump vec4 _228 = _t6;
                        mediump float _230 = _t6.w;
                        mediump vec4 _232 = mix(_t4, _228, vec4(_230));
                        _t6 = _232;
                        _t6 = mix(_t5, _232, vec4(_t6.w));
                    }
                    else
                    {
                        if (u_timeType < 1.0)
                        {
                            mediump vec4 _245 = _t6;
                            mediump float _247 = _t6.w;
                            mediump vec4 _249 = mix(_t4, _245, vec4(_247));
                            _t6 = _249;
                            _t6 = mix(_t5, _249, vec4(_t6.w));
                        }
                        else
                        {
                            _t6 = _23;
                        }
                    }
                }
            }
        }
    }
    gl_FragData[0] = _t6;
}

