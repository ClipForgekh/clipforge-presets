precision highp float;
precision highp int;

uniform float expandLeft;
uniform float expandRight;
uniform float expandUp;
uniform float expandDown;
uniform float runningMode;
uniform mediump sampler2D inputImageTexture;
uniform float expandMode;
uniform float blendBorders;

varying vec2 uv0;

vec2 _f1(inout vec2 _p0)
{
    _p0.x = (_p0.x + expandLeft) / ((1.0 + expandLeft) + expandRight);
    _p0.y = (_p0.y + expandDown) / ((1.0 + expandUp) + expandDown);
    return _p0;
}

vec2 _f0(inout vec2 _p0)
{
    _p0.x = (_p0.x * ((1.0 + expandLeft) + expandRight)) - expandLeft;
    _p0.y = (_p0.y * ((1.0 + expandUp) + expandDown)) - expandDown;
    return _p0;
}

float _f2(float _p0)
{
    float _90 = mod(_p0, 2.0);
    float _97 = _90 + ((1.0 - step(0.0, _90)) * 2.0);
    float _99 = step(_97, 1.0);
    return ((1.0 - _99) * (2.0 - _97)) + (_99 * _97);
}

float _f3(float _p0)
{
    float _114 = mod(_p0, 1.0);
    return _114 + (1.0 - step(0.0, _114));
}

void main()
{
    if (runningMode > 1.5)
    {
        vec2 param = uv0;
        vec2 _135 = _f1(param);
        gl_FragData[0] = texture2D(inputImageTexture, _135);
        return;
    }
    if (expandMode < 0.5)
    {
        vec2 param_1 = uv0;
        vec2 _156 = _f0(param_1);
        vec2 _t7 = _156;
        if (runningMode < 0.5)
        {
            vec2 param_2 = _t7;
            vec2 _163 = _f1(param_2);
            _t7 = _163;
        }
        gl_FragData[0] = texture2D(inputImageTexture, _t7);
        return;
    }
    else
    {
        if (expandMode < 1.5)
        {
            vec2 param_3 = uv0;
            vec2 _176 = _f0(param_3);
            vec2 _t9 = _176;
            float param_4 = _t9.x;
            _t9.x = _f2(param_4);
            float param_5 = _t9.y;
            _t9.y = _f2(param_5);
            if (runningMode < 0.5)
            {
                vec2 param_6 = _t9;
                vec2 _195 = _f1(param_6);
                _t9 = _195;
            }
            gl_FragData[0] = texture2D(inputImageTexture, _t9);
            return;
        }
        else
        {
            if (expandMode < 2.5)
            {
                vec2 param_7 = uv0;
                vec2 _209 = _f0(param_7);
                vec2 _t10 = _209;
                vec2 _t11 = _209;
                float param_8 = _t11.x;
                _t11.x = _f3(param_8);
                float param_9 = _t11.y;
                _t11.y = _f3(param_9);
                vec2 _t12 = _t11;
                _t12.x = 1.0 - _t12.x;
                vec2 _t13 = _t11;
                _t13.y = 1.0 - _t13.y;
                vec2 _t14 = _t11;
                _t14.x = 1.0 - _t14.x;
                _t14.y = 1.0 - _t14.y;
                if (runningMode < 0.5)
                {
                    vec2 param_10 = _t11;
                    vec2 _250 = _f1(param_10);
                    _t11 = _250;
                    vec2 param_11 = _t12;
                    vec2 _253 = _f1(param_11);
                    _t12 = _253;
                    vec2 param_12 = _t13;
                    vec2 _256 = _f1(param_12);
                    _t13 = _256;
                    vec2 param_13 = _t14;
                    vec2 _259 = _f1(param_13);
                    _t14 = _259;
                }
                vec4 _t15 = texture2D(inputImageTexture, _t11);
                vec4 _t17 = texture2D(inputImageTexture, _t13);
                float _281 = blendBorders * 0.4000000059604644775390625;
                float _282 = 1.0 - _281;
                float _286 = 1.10000002384185791015625 - _281;
                float param_14 = _t10.x;
                vec4 _299 = vec4(smoothstep(_282, _286, abs(0.5 - _f2(param_14)) * 2.0) * 0.5);
                _t15 = mix(_t15, texture2D(inputImageTexture, _t12), _299);
                _t17 = mix(_t17, texture2D(inputImageTexture, _t14), _299);
                float param_15 = _t10.y;
                vec4 _322 = _t15;
                vec4 _327 = mix(_322, _t17, vec4(smoothstep(_282, _286, abs(0.5 - _f2(param_15)) * 2.0) * 0.5));
                _t15 = _327;
                gl_FragData[0] = _327;
                return;
            }
        }
    }
    gl_FragData[0] = texture2D(inputImageTexture, uv0);
}

