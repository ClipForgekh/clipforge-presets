precision highp float;
precision highp int;

uniform mediump sampler2D u_imageFFront;
uniform mediump float u_wrapMode[12];
uniform mediump sampler2D u_imageBFront;
uniform mediump sampler2D u_imageFBack;
uniform mediump sampler2D u_imageBBack;
uniform mediump sampler2D u_imageFTop;
uniform mediump sampler2D u_imageBTop;
uniform mediump sampler2D u_imageFBottom;
uniform mediump sampler2D u_imageBBottom;
uniform mediump sampler2D u_imageFLeft;
uniform mediump sampler2D u_imageBLeft;
uniform mediump sampler2D u_imageFRight;
uniform mediump sampler2D u_imageBRight;
uniform mediump int u_maskChannel;
uniform mediump sampler2D u_mask;

varying vec2 v_id;
varying vec2 v_uv;

mediump vec4 _f0(mediump sampler2D _p0, inout mediump vec2 _p1, mediump int _p2)
{
    if (_p2 == 0)
    {
        mediump vec2 _t0 = step(vec2(0.0), _p1) * step(_p1, vec2(1.0));
        return texture2D(_p0, _p1) * (_t0.x * _t0.y);
    }
    else
    {
        if (_p2 == 1)
        {
            _p1 = fract(_p1);
            return texture2D(_p0, _p1);
        }
        else
        {
            if (_p2 == 2)
            {
                _p1 = abs(mod(_p1 + vec2(1.0), vec2(2.0)) - vec2(1.0));
                return texture2D(_p0, _p1);
            }
            else
            {
                if (_p2 == 3)
                {
                    mediump vec2 _t1 = step(vec2(0.0), _p1) * step(_p1, vec2(1.0));
                    return mix(vec4(0.0, 0.0, 0.0, 1.0), texture2D(_p0, _p1), vec4(_t1.x * _t1.y));
                }
                else
                {
                    if (_p2 == 4)
                    {
                        mediump vec2 _t3 = step(vec2(0.0), _p1) * step(_p1, vec2(1.0));
                        return mix(vec4(1.0), texture2D(_p0, _p1), vec4(_t3.x * _t3.y));
                    }
                }
            }
        }
    }
    return vec4(0.0);
}

void main()
{
    int _144 = int(v_id.x);
    int _148 = int(v_id.y);
    mediump int _154 = (_144 + _144) + _148;
    mediump vec4 _t8;
    if (_144 == 0)
    {
        if (_148 == 0)
        {
            mediump vec2 param = v_uv;
            mediump int param_1 = int(u_wrapMode[_154]);
            mediump vec4 _178 = _f0(u_imageFFront, param, param_1);
            _t8 = _178;
        }
        else
        {
            mediump vec2 param_2 = v_uv;
            mediump int param_3 = int(u_wrapMode[_154]);
            mediump vec4 _188 = _f0(u_imageBFront, param_2, param_3);
            _t8 = _188;
        }
    }
    else
    {
        if (_144 == 1)
        {
            if (_148 == 0)
            {
                mediump vec2 param_4 = v_uv;
                mediump int param_5 = int(u_wrapMode[_154]);
                mediump vec4 _206 = _f0(u_imageFBack, param_4, param_5);
                _t8 = _206;
            }
            else
            {
                mediump vec2 param_6 = v_uv;
                mediump int param_7 = int(u_wrapMode[_154]);
                mediump vec4 _216 = _f0(u_imageBBack, param_6, param_7);
                _t8 = _216;
            }
        }
        else
        {
            if (_144 == 2)
            {
                if (_148 == 0)
                {
                    mediump vec2 param_8 = v_uv;
                    mediump int param_9 = int(u_wrapMode[_154]);
                    mediump vec4 _234 = _f0(u_imageFTop, param_8, param_9);
                    _t8 = _234;
                }
                else
                {
                    mediump vec2 param_10 = v_uv;
                    mediump int param_11 = int(u_wrapMode[_154]);
                    mediump vec4 _244 = _f0(u_imageBTop, param_10, param_11);
                    _t8 = _244;
                }
            }
            else
            {
                if (_144 == 3)
                {
                    if (_148 == 0)
                    {
                        mediump vec2 param_12 = v_uv;
                        mediump int param_13 = int(u_wrapMode[_154]);
                        mediump vec4 _262 = _f0(u_imageFBottom, param_12, param_13);
                        _t8 = _262;
                    }
                    else
                    {
                        mediump vec2 param_14 = v_uv;
                        mediump int param_15 = int(u_wrapMode[_154]);
                        mediump vec4 _272 = _f0(u_imageBBottom, param_14, param_15);
                        _t8 = _272;
                    }
                }
                else
                {
                    if (_144 == 4)
                    {
                        if (_148 == 0)
                        {
                            mediump vec2 param_16 = v_uv;
                            mediump int param_17 = int(u_wrapMode[_154]);
                            mediump vec4 _290 = _f0(u_imageFLeft, param_16, param_17);
                            _t8 = _290;
                        }
                        else
                        {
                            mediump vec2 param_18 = v_uv;
                            mediump int param_19 = int(u_wrapMode[_154]);
                            mediump vec4 _300 = _f0(u_imageBLeft, param_18, param_19);
                            _t8 = _300;
                        }
                    }
                    else
                    {
                        if (_148 == 0)
                        {
                            mediump vec2 param_20 = v_uv;
                            mediump int param_21 = int(u_wrapMode[_154]);
                            mediump vec4 _314 = _f0(u_imageFRight, param_20, param_21);
                            _t8 = _314;
                        }
                        else
                        {
                            mediump vec2 param_22 = v_uv;
                            mediump int param_23 = int(u_wrapMode[_154]);
                            mediump vec4 _324 = _f0(u_imageBRight, param_22, param_23);
                            _t8 = _324;
                        }
                    }
                }
            }
        }
    }
    mediump float _t9 = 1.0;
    if (u_maskChannel < 4)
    {
        _t9 = texture2D(u_mask, v_uv)[u_maskChannel];
    }
    gl_FragData[0] = _t8 * _t9;
}

