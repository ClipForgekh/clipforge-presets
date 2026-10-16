
uniform float u_Speed;
uniform float u_XSpeed;
uniform float u_Twist;

attribute vec3 a_position;
varying vec2 v_uv;
attribute vec2 a_texcoord0;

vec2 _f0(vec2 _p0, float _p1)
{
    if (abs(_p1) <= 9.9999999747524270787835121154785e-07)
    {
        return _p0;
    }
    vec2 _t0 = _p0;
    vec2 _t1 = (_p0 * 0.5) + vec2(0.5);
    _t0.y -= (((sin(((((_t1.x - (u_Speed / 30.0)) - 0.100000001490116119384765625) * 3.141592502593994140625) * u_XSpeed) * 2.0) * _p1) * 0.5) * sin(_t1.y * 3.141592502593994140625));
    return _t0;
}

void main()
{
    vec4 _82 = vec4(a_position.xy, 0.0, 1.0);
    vec4 _t3 = _82;
    vec2 param = _82.xy;
    float param_1 = u_Twist;
    vec2 _89 = _f0(param, param_1);
    _t3.x = _89.x;
    _t3.y = _89.y;
    gl_Position = _t3;
    v_uv = a_texcoord0;
}

