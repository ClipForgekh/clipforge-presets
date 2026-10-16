precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTex;
uniform mediump int u_ca;
uniform float u_redOffset;
uniform float u_greenOffset;
uniform float u_blueOffset;
uniform float u_threshold;
uniform float u_thresholdSmooth;
uniform mediump int u_view;
uniform mediump int u_gamma;
uniform float u_gammaValue;

varying vec2 v_uv;

void main()
{
    vec4 _t0 = texture2D(u_inputTex, v_uv);
    if (u_ca == 1)
    {
        vec4 _t1 = texture2D(u_inputTex, v_uv + vec2(-u_redOffset, u_redOffset)).yzwx;
        float _46 = _t1.w;
        float _49 = _t1.x;
        float _50 = _49 * _46;
        _t1.x = _50;
        _t1 = texture2D(u_inputTex, v_uv + vec2(-u_greenOffset, u_greenOffset)).yzwx;
        float _64 = _t1.w;
        float _67 = _t1.y;
        float _68 = _67 * _64;
        _t1.y = _68;
        _t1 = texture2D(u_inputTex, v_uv + vec2(-u_blueOffset, u_blueOffset)).yzwx;
        float _82 = _t1.w;
        float _85 = _t1.z;
        float _86 = _85 * _82;
        _t1.z = _86;
        _t0 = vec4(_50, _68, _86, 1.0);
    }
    if (_t0.x < u_threshold)
    {
        _t0.x = ((_t0.x / u_threshold) * _t0.x) * u_thresholdSmooth;
    }
    if (_t0.y < u_threshold)
    {
        _t0.y = ((_t0.y / u_threshold) * _t0.y) * u_thresholdSmooth;
    }
    if (_t0.z < u_threshold)
    {
        _t0.z = ((_t0.z / u_threshold) * _t0.z) * u_thresholdSmooth;
    }
    if (u_view == 1)
    {
        if (u_gamma == 1)
        {
            _t0 = pow(_t0, vec4(u_gammaValue));
        }
    }
    gl_FragData[0] = _t0;
}

