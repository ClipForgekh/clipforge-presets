precision highp float;

uniform sampler2D u_tex;
uniform float u_intensity;

varying vec2 v_uv;


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    float a = step(-0.5, uv.x);
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv)) * a;
}

float sdRoundedBox( in vec2 p, in vec2 b, in vec4 r )
{
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    vec2 q = abs(p)-b+r.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}

vec2 xiruUV(vec2 nowUV,float intensity)
{
    vec2 dir = (nowUV - 0.5);
    float l = sdRoundedBox(dir * 2.0, vec2(0.5), vec4(0.5)) + 0.5;
    float l1 = max(abs(dir.x), abs(dir.y)) * 2.0;
    float x = smoothstep(0.0, 1.0, l1);
    l = l1 * x + l * (1. - x);
    return dir * pow(1.0 / l, intensity) + 0.5;
}


void main () {
    vec2 uv = xiruUV(v_uv, u_intensity);
    vec4 base = texture2Dmirror(u_tex, uv);
    gl_FragColor = base;
}

