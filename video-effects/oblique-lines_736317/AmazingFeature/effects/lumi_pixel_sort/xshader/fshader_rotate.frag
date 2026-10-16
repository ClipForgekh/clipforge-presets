precision highp float;
varying highp vec2 uv0;

uniform sampler2D inputImageTexture;
uniform float rotate;
uniform float pingtie;
uniform vec4 u_ScreenParams;
uniform vec2 size_;

#define PI 3.1415926

vec2 rotateFun(vec2 uv, float theta)
{
    float sint = sin(theta);
    float cost = cos(theta);
    mat2 rot = mat2(
        cost, sint,
        -sint, cost
    );
    uv -= 0.5;
    uv = rot * uv;
    uv += 0.5;
    return uv;
}
vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}

void main() {
    float theta = rotate * PI / 180.0;
    vec2 new_uv = rotateFun(uv0, theta);

    float scale = abs(cos(theta)) + abs(sin(theta));
    new_uv -= 0.5;
    new_uv *= scale;
    new_uv += 0.5;

    float pingtie_int = pingtie;
    if(size_.x>size_.y*4./3.){
        pingtie_int*=size_.x/size_.y;
    }
    if(size_.y>size_.x*4./3.){
        pingtie_int*=size_.y/size_.x;
    }
    gl_FragColor = texture2D(inputImageTexture, flip_uv(new_uv));
    if (new_uv.x >= 1.+pingtie_int)
    {
        gl_FragColor.a = 0.0;
    }
    if (new_uv.y <= -0.1-pingtie_int)
    {
        gl_FragColor.a = 0.0;
    }
}