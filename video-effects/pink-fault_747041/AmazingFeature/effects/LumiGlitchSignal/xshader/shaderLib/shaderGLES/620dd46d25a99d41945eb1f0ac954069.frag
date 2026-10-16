precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform float d2dIntensity;
uniform mediump sampler2D inputImageTexture;
uniform mediump sampler2D blurImageTexture;

varying vec2 v_uv;

void main()
{
    vec2 _t1 = vec2(1.0) / ((u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y))) * 720.0);
    vec4 _t2 = vec4(0.0);
    vec4 _t3 = vec4(0.0);
    vec4 _t4 = vec4(0.0);
    float _46 = min(5.0, d2dIntensity * 2.0);
    float _t6 = 0.0;
    for (float _t7 = 0.0; _t7 <= 10.0; _t7 += 1.0)
    {
        float _60 = 10.0 - _t7;
        float _70 = min((_t1.x * _46) * 1.0, 2.0 * _t1.x);
        _t2.x += (_60 * texture2D(inputImageTexture, v_uv + vec2(((_t7 * _t1.x) * _46) + _70, 0.0)).x);
        vec4 _111 = _t2;
        vec2 _113 = _111.yw + (texture2D(inputImageTexture, v_uv + vec2((_t7 * _t1.x) * _46, 0.0)).yw * _60);
        _t2.y = _113.x;
        _t2.w = _113.y;
        _t2.z += (_60 * texture2D(inputImageTexture, v_uv + vec2(((_t7 * _t1.x) * _46) - _70, 0.0)).z);
        _t3.x += (_60 * texture2D(blurImageTexture, v_uv + vec2(((_t7 * _t1.x) * _46) + _70, 0.0)).x);
        vec4 _175 = _t3;
        vec2 _177 = _175.yw + (texture2D(blurImageTexture, v_uv + vec2((_t7 * _t1.x) * _46, 0.0)).yw * _60);
        _t3.y = _177.x;
        _t3.w = _177.y;
        _t3.z += (_60 * texture2D(blurImageTexture, v_uv + vec2(((_t7 * _t1.x) * _46) - _70, 0.0)).z);
        _t6 += _60;
    }
    vec4 _208 = _t2;
    vec4 _209 = vec4(_t6);
    vec4 _210 = _208 / _209;
    _t2 = _210;
    vec4 _212 = _t3;
    vec4 _214 = _212 / _209;
    _t3 = _214;
    float _217 = step(d2dIntensity, 2.0);
    vec4 _239 = _t4;
    vec4 _240 = _239 + (_210 + ((_210 - _214) * (((_217 * d2dIntensity) * 10.0) + ((1.0 - _217) * (20.0 + (50.0 * (d2dIntensity - 2.0)))))));
    _t4 = _240;
    float _245 = _t4.w;
    vec3 _248 = clamp(_240.xyz, vec3(0.0), vec3(_245));
    _t4.x = _248.x;
    _t4.y = _248.y;
    _t4.z = _248.z;
    gl_FragData[0] = _t4;
}

