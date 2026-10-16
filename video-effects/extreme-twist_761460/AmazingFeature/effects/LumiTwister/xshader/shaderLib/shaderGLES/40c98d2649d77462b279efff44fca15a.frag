precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform float u_lightIns;
uniform float u_shadingProgress;

varying vec2 v_uv;

float _f0(float _p0, float _p1)
{
    return pow((4.0 * _p0) * (1.0 - _p0), _p1);
}

vec4 _f2(inout vec4 _p0, inout vec4 _p1)
{
    float _136 = _p0.w;
    vec4 _138 = _p0;
    vec3 _141 = _138.xyz / vec3(max(_136, 0.001000000047497451305389404296875));
    _p0.x = _141.x;
    _p0.y = _141.y;
    _p0.z = _141.z;
    float _149 = _p1.w;
    vec4 _151 = _p1;
    vec3 _154 = _151.xyz / vec3(max(_149, 0.001000000047497451305389404296875));
    _p1.x = _154.x;
    _p1.y = _154.y;
    _p1.z = _154.z;
    vec4 _t2 = _p1;
    vec3 _167 = min(_p0.xyz, _p1.xyz);
    _t2.x = _167.x;
    _t2.y = _167.y;
    _t2.z = _167.z;
    vec4 _t3 = vec4(0.0);
    vec3 _202 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t2.xyz * (_p0.w * _p1.w));
    _t3.x = _202.x;
    _t3.y = _202.y;
    _t3.z = _202.z;
    _t3.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t3;
}

vec4 _f3(inout vec4 _p0, inout vec4 _p1)
{
    float _223 = _p0.w;
    vec4 _225 = _p0;
    vec3 _228 = _225.xyz / vec3(max(_223, 0.001000000047497451305389404296875));
    _p0.x = _228.x;
    _p0.y = _228.y;
    _p0.z = _228.z;
    float _236 = _p1.w;
    vec4 _238 = _p1;
    vec3 _241 = _238.xyz / vec3(max(_236, 0.001000000047497451305389404296875));
    _p1.x = _241.x;
    _p1.y = _241.y;
    _p1.z = _241.z;
    vec4 _t4 = _p1;
    float _255;
    if (_p1.x < 0.5)
    {
        _255 = (2.0 * _p1.x) * _p0.x;
    }
    else
    {
        _255 = 1.0 - ((2.0 * (1.0 - _p1.x)) * (1.0 - _p0.x));
    }
    float _279;
    if (_p1.y < 0.5)
    {
        _279 = (2.0 * _p1.y) * _p0.y;
    }
    else
    {
        _279 = 1.0 - ((2.0 * (1.0 - _p1.y)) * (1.0 - _p0.y));
    }
    float _302;
    if (_p1.z < 0.5)
    {
        _302 = (2.0 * _p1.z) * _p0.z;
    }
    else
    {
        _302 = 1.0 - ((2.0 * (1.0 - _p1.z)) * (1.0 - _p0.z));
    }
    vec3 _322 = vec3(_255, _279, _302);
    _t4.x = _322.x;
    _t4.y = _322.y;
    _t4.z = _322.z;
    vec4 _t5 = vec4(0.0);
    vec3 _357 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t4.xyz * (_p0.w * _p1.w));
    _t5.x = _357.x;
    _t5.y = _357.y;
    _t5.z = _357.z;
    _t5.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t5;
}

vec4 _f1(inout vec4 _p0, inout vec4 _p1)
{
    float _42 = _p0.w;
    vec4 _46 = _p0;
    vec3 _49 = _46.xyz / vec3(max(_42, 0.001000000047497451305389404296875));
    _p0.x = _49.x;
    _p0.y = _49.y;
    _p0.z = _49.z;
    float _60 = _p1.w;
    vec4 _62 = _p1;
    vec3 _65 = _62.xyz / vec3(max(_60, 0.001000000047497451305389404296875));
    _p1.x = _65.x;
    _p1.y = _65.y;
    _p1.z = _65.z;
    vec4 _t0 = _p1;
    vec3 _78 = max(_p0.xyz, _p1.xyz);
    _t0.x = _78.x;
    _t0.y = _78.y;
    _t0.z = _78.z;
    vec4 _t1 = vec4(0.0);
    vec3 _115 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t0.xyz * (_p0.w * _p1.w));
    _t1.x = _115.x;
    _t1.y = _115.y;
    _t1.z = _115.z;
    _t1.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t1;
}

void main()
{
    vec4 _t7 = texture2D(u_inputTexture, v_uv);
    if (u_lightIns > 0.0)
    {
        vec2 _t8 = v_uv;
        float param = _t8.x;
        float param_1 = 0.25;
        float param_2 = _t8.y;
        float param_3 = 0.25;
        float _t11 = 1.0 - _f0(param_2, param_3);
        float _t12 = 1.0 - _f0(param, param_1);
        if (_t8.y < 0.5)
        {
            _t11 = 0.0;
        }
        if (_t8.x < 0.5)
        {
            _t12 = 0.0;
        }
        float _434 = sin(radians(u_shadingProgress * 180.0));
        float _435 = _t11;
        float _437 = mix(0.0, _435, _434);
        _t11 = _437;
        float _438 = _t12;
        float _440 = mix(0.0, _438, _434);
        _t12 = _440;
        vec4 _453 = vec4(0.0, 0.0, 0.0, _437 * u_lightIns);
        vec4 _466 = vec4((vec3(1.0) * _440) * u_lightIns, _440 * u_lightIns);
        vec4 param_4 = _453 * 0.5;
        vec4 param_5 = _t7;
        vec4 _472 = _f2(param_4, param_5);
        _t7 = _472;
        vec4 param_6 = _453;
        vec4 param_7 = _472;
        vec4 _477 = _f3(param_6, param_7);
        _t7 = _477;
        vec4 param_8 = _453;
        vec4 param_9 = _477;
        vec4 _482 = _f3(param_8, param_9);
        _t7 = _482;
        vec4 param_10 = _466 * 0.5;
        vec4 param_11 = _482;
        vec4 _488 = _f1(param_10, param_11);
        _t7 = _488;
        vec4 param_12 = _466;
        vec4 param_13 = _488;
        vec4 _493 = _f3(param_12, param_13);
        _t7 = _493;
        vec4 param_14 = _466;
        vec4 param_15 = _493;
        vec4 _498 = _f3(param_14, param_15);
        _t7 = _498;
    }
    gl_FragData[0] = vec4(_t7);
}

