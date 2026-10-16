precision highp float;
attribute vec3 attPosition;
attribute vec2 attUV;
varying vec2 uv;
uniform float ins;
uniform float expandIns;
uniform float xSize;
uniform float ySize;


vec2 dilatation(vec2 pos, float twist) {

    if (abs(twist) <= 0.000001) return pos;
    vec2 res_pos = pos;
    vec2 t = res_pos * 0.5 + 0.5;

    float m = (1.0 / clamp(abs(twist * res_pos.y), 0.00001, 1.0)) - 0.1;
    float x = 1.0;
    float R = sqrt(x*x+m*m);
    float y = sqrt(R*R - res_pos.x*res_pos.x) - m;


    m = (1.0 / clamp(abs(twist * res_pos.x), 0.00001, 1.0)) - 0.1;
    x = 1.0;
    R = sqrt(x*x+m*m);
    x = sqrt(R*R - res_pos.y*res_pos.y) - m;
    res_pos.y += y * sign(res_pos.y) * sign(twist);
    res_pos.x += x * sign(res_pos.x) * sign(twist);
    return res_pos;
}
void main() {
     vec4 pos = (vec4(attPosition.xy, 0.0, 1.0));
     pos.xy = dilatation(pos.xy, ins*expandIns)*vec2(xSize,ySize);
    gl_Position = pos;
    uv = attPosition.xy*0.5+0.5;
}
