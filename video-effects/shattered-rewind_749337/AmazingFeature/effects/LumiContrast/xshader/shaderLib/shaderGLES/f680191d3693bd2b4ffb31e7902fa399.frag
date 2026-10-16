precision highp float;
precision highp int;

uniform float u_pivotSlope;
uniform float u_leftSlopeDiff;
uniform float u_leftDiff;
uniform float u_rightSlopeDiff;
uniform float u_rightDiff;
uniform mediump sampler2D u_inputTexture;
uniform mediump sampler2D u_inputTexture02;
uniform float u_intensity;
uniform float u_pivot;
uniform float u_xFactor;
uniform float u_blend;
uniform float u_prograss;

varying vec2 uv0;

float _f0(float _p0, float _p1, float _p2)
{
    return ((1.0 / (1.0 + exp((-_p1) * (_p0 - _p2)))) + _p2) - 0.5;
}

float _f1(float _p0, float _p1, float _p2)
{
    float _49 = 1.0 / (1.0 + exp((-_p1) * (_p0 - _p2)));
    return (_p1 * _49) * (1.0 - _49);
}

float _f2(float _p0, float _p1, float _p2)
{
    float param = _p0;
    float param_1 = _p1;
    float param_2 = _p2;
    float _t2 = _f0(param, param_1, param_2);
    float param_3 = _p0;
    float param_4 = _p1;
    float param_5 = _p2;
    float _75 = _f1(param_3, param_4, param_5);
    if (_p0 <= _p2)
    {
        float _90 = (u_pivotSlope - _75) / u_leftSlopeDiff;
        _t2 += ((_90 * _90) * u_leftDiff);
    }
    else
    {
        float _107 = (u_pivotSlope - _75) / u_rightSlopeDiff;
        _t2 += ((_107 * _107) * u_rightDiff);
    }
    return _t2;
}

void main()
{
    vec4 _t6 = texture2D(u_inputTexture, uv0);
    mediump vec4 _137 = texture2D(u_inputTexture02, uv0);
    if (u_intensity <= 1.0)
    {
        vec4 _145 = _t6;
        vec3 _149 = vec3(u_pivot);
        vec3 _154 = ((_145.xyz - _149) * u_intensity) + _149;
        _t6.x = _154.x;
        _t6.y = _154.y;
        _t6.z = _154.z;
    }
    else
    {
        float param = _t6.x;
        float param_1 = u_xFactor;
        float param_2 = u_pivot;
        _t6.x = _f2(param, param_1, param_2);
        float param_3 = _t6.y;
        float param_4 = u_xFactor;
        float param_5 = u_pivot;
        _t6.y = _f2(param_3, param_4, param_5);
        float param_6 = _t6.z;
        float param_7 = u_xFactor;
        float param_8 = u_pivot;
        _t6.z = _f2(param_6, param_7, param_8);
    }
    if (u_blend == 1.0)
    {
        gl_FragData[0] = mix(clamp(_t6, vec4(0.0), vec4(1.0)), _137, vec4(u_prograss));
    }
    else
    {
        gl_FragData[0] = clamp(_t6, vec4(0.0), vec4(1.0));
    }
}

